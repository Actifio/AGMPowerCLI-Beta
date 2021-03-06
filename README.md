# AGMPowerCLI
A Powershell module that allows PowerShell users to issue API calls to Actifio Global Manager.
This module is intended to deliver the following:

* Allow the user to create and remove sessions so that API commands can be issued
* Issue commands to API end points 

There is a partner module:  AGMPowerLib found here:  https://github.com/Actifio/AGMPowerLib
The AGMPowerLib module contains what we call composite functions, these being complex combination of API endpoints.   
We chose to separate the two modules (a module for end points versus a module for composite functions), to make it easier to differentiate if you are working with a single end-point or working with a composite collection of endpoints.  

Our intention is that you should install both modules.


### What versions of PowerShell will this module work with?

It was written and tested for Windows PowerShell 5 and PowerShell V7 with Linux, Mac OS and Windows

## Usage


### 1)    Install or Upgrade AGMPowerCLI

Install from PowerShell Gallery (the ProtocolType only needs to be set for Windows PowerShell 5)

```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-Module -Name AGMPowerCLI
```

If the install worked, you can now move to Step 2.

#### Upgrades using PowerShell Gallery

Note if you run 'Install-Module' to update an installed module, it will complain.  You need to run:
```
Update-Module -name AGMPowerCLI
```
It will install the latest version and leave the older version in place.  To see the version in use versus all versions downloaded use these two commands:
```
Get-InstalledModule AGMPowerCLI
Get-InstalledModule AGMPowerCLI -AllVersions
```
To uninstall all older versions run this command:
```
$Latest = Get-InstalledModule AGMPowerCLI; Get-InstalledModule AGMPowerCLI -AllVersions | ? {$_.Version -ne $Latest.Version} | Uninstall-Module
```

#### Manual install

Serious corporate servers will not allow downloads from PowerShell gallery or even access to GitHub from Production Servers, so for these we have the following process:

1.  From GitHub, use the Green Code download button to download the AGMPowerCLI-Beta-main repo as a zip file
1.  Copy the Zip file to the server where you want to install it
1.  For Windows, Right select on the zip file, choose  Properties and then use the Unblock button next to the message:  "This file came from another computer and might be blocked to help protect  your computer."
1.  For Windows, now right select and use Extract All to extract the contents of the zip file to a folder.  It doesn't matter where you put the folder.  For Mac it should automatically unzip.  For Linux use the unzip command to unzip the folder.
1.  Now start PWSH and change directory to the  AGMPowerCLI-Beta-main directory that should contain our module files.   
1.  There is an installer, Install-AGMPowerCLI.ps1 so run that with ./Install-AGMPowerCLI.ps1
If you find multiple installs, we strongly recommend you delete them all and run the installer again to have just one install.


If the install fails with:
```
PS C:\Users\av\Downloads\AGMPowerCLI-Beta-main\AGMPowerCLI-Beta-main> .\Install-
AGMPowerCLI.ps1
.\Install-AGMPowerCLI.ps1: File C:\Users\av\Downloads\AGMPowerCLI-Beta-main\AGMPowerCLI-Beta-main\Install-AGMPowerCLI.ps1 cannot be loaded. 
The file C:\Users\av\Downloads\AGMPowerCLI-Beta-main\AGMPowerCLI-Beta-main\Install-AGMPowerCLI.ps1 is not digitally signed. 
You cannot run this script on the current system. For more information about running scripts and setting execution policy, see about_Execution_Policies at https://go.microsoft.com/fwlink/?LinkID=135170.
```
Then  run this command:
```
Get-ChildItem .\Install-AGMPowerCLI.ps1 | Unblock-File
```
Then re-run the installer.  The installer will unblock all the files.

Here is a typical install:
```
Could not find an existing AGMPowerCLI Module installation.
Where would you like to install it?

1: C:\Users\av\Documents\PowerShell\Modules
2: C:\Program Files\PowerShell\Modules
3: c:\program files\powershell\7\Modules
4: C:\Windows\system32\WindowsPowerShell\v1.0\Modules\
5: C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\

Please select an installation path: 2

Installation successful.

AGMPowerCLI Module installation location(s):

Name        Version ModuleBase
----        ------- ----------
AGMPowerCLI 0.0.0.6 C:\Program Files\PowerShell\Modules\AGMPowerCLI

PS C:\Users\av\Downloads\AGMPowerCLI-Beta-main\AGMPowerCLI-Beta-main> Connect-AG
M 10.65.5.38 av passw0rd -i
Login Successful!
PS C:\Users\av\Downloads\AGMPowerCLI-Beta-main\AGMPowerCLI-Beta-main> Get-AGMVer
sion

product summary
------- -------
AGM     10.0.1.4673

PS C:\Users\av\Downloads\AGMPowerCLI-Beta-main\AGMPowerCLI-Beta-main>
```

Now jump over to https://github.com/Actifio/AGMPowerLib and install AGMPowerLib.


### 2)  Get some help

List the available commands in the AGMPowerCLI module:
```
Get-Command -module AGMPowerCLI
```
Find out the syntax and how you can use a specific command. For instance:
```
Get-Help Connect-AGM
```
If you need some examples on the command:
```
Get-Help Connect-AGM -examples
```

### 3)  Save your password

Create an encrypted password file using the AGMPowerCLI **Save-AGMPassword** function:
```
Save-AGMPassword -filename "C:\temp\password.key"
```

The Save-AGMPassword function creates an encrypted password file on Windows, but on Linux and Mac it only creates an encoded password file.  
Note that you can also use this file with the Connect-Act command from ActPowerCLI.

##### Sharing Windows key files

Currently if a Windows key file is created by a specific user, it cannot be used by a different user.    You will see an error like this:
```
Key not valid for use in specified state.
```
This will cause issues when running saved scripts when two different users want to run the same script with the same keyfile.    To work around this issue, please have each user create a keyfile for their own use.   Then when running a shared script, each user should execute the script specifying their own keyfile.  This can be done by using a parameter file for each script.


### 4)  Login to your appliance

To login to an AGM (10.61.5.114) as admin and enter password interactively:
```
Connect-AGM 10.61.5.114 admin -ignorecerts
```
Or login to the AGM using the password file created in the previous step:
```
Connect-AGM 10.61.5.114 admin -passwordfile "c:\temp\password.key" -ignorecerts
```
You will need to store the certificate during first login if you don't use **-ignorecerts**

Note you can use **-quiet** to suppress messages.   This is handy when scripting.

### 5)  Run your first command:

```
PS /Users/anthony/git/AGMPowerLib> Get-AGMVersion

product summary
------- -------
AGM     10.0.1.4673
```

### 6) Example commands

There are three common options that may be available for a command (if shown with Get-Help)

#### id search
-id   This will fetch a specific ID

#### keyword search
-keyword   This is a case insensitive search of certain fields for a stated keyword.  This is useful for finding an object that has a unique value, like a unique DB name.  You  can only specify one keyword.

#### filtering
-filtervalue   This is a filtering function.  To get a list of available filters, run the command with option -o.   The filters allow for searches using equals, less than, greater than or fuzzy.   To combine searches use & between each filter and encase the whole thing in double quotes.   Here are some examples:

There are five filter types

| symbol | purpose | example | result
| ------ | ------- | ------- | ------
| = | equals | -filtervalue id=123 | will show objects with an ID equal to 123 
| < | less than | -filtervalue id<123  | will show objects with an ID less than 123
| > | great than | -filtervalue id>123 | will show objects with an ID greater than 123
| ~ | similar to | -filtervalue appname~smalldb | will show objects with an name similar to smalldb
| ! | not equals | -filtervalue apptype!VMBackup | will show objects with that are not apptype of VMbackup

Multiple filtervalues can be used and will combine results.  Note also they need to be encased in double quotes.

| example | result
| ------ | ------- 
| -filtervalue appname=smalldb  | filter on appname
| -filtervalue "appname=smalldb&hostname=prodserver"  | filter on appname and hostname
| -filtervalue id<10000   | filter on objects where the ID is less than 10000
| -filtervalue id>10000   | filter on objects where the ID is greater than 10000
| -filtervalue appname~smalldb  | fuzzy search for appname like smalldb,  so you could get SmallDb, smalldb1, smalldbold.
| filtervalue "appname=smalldb&appname=bigdb" | will show both smalldb and bigdb in the results.


#### API Limit

The module has no API limit which means if you run Get-AGMJobHistory you can easily get results in the thousands or millions.   So we added a command to prevent giant lookups by setting a limit on the number of returned objects, although by default this limit is off.  You can set the limit with:   Set-AGMAPILimit

In the example below, we login and search for snapshot jobs and find there are over sixty thousand.  A smart move would be to use more filters (such as date or appname), but we could also limit the number of results using an API limit, so we set it to 100 and only get 100 jobs back:

```
PS /Users/anthony/git/ActPowerCLI> Connect-Act 172.24.1.117 av -passwordfile avpass.key -ignorecerts
Login Successful!
PS /Users/anthony/git/AGMPowerCLI> $jobs = Get-AGMJobHistory -filtervalue jobclass=snapshot
PS /Users/anthony/git/AGMPowerCLI> $jobs.id.count
32426
PS /Users/anthony/git/AGMPowerCLI> Set-AGMAPILimit 100
PS /Users/anthony/git/AGMPowerCLI> $jobs = Get-AGMJobHistory -filtervalue jobclass=snapshot
PS /Users/anthony/git/AGMPowerCLI> $jobs.id.count
100
```

You can reset the limit to 'unlimited' by setting it to '0'.

#### Get-AGMApplication

Fetch Applications to get their ID, protection status, host info.   In this example we know that smalldb3 is a unique value.

Get-AGMApplication -keyword smalldb3



### 7)  Disconnect from your appliance
Once you are finished, make sure to disconnect (logout).   If you are running many scripts in quick succession, each script should connect and then disconnect, otherwise each session will be left open to time-out on its own.
```
Disconnect-AGM
```



# What else do I need to know?


##  Time Zone handling

By default all dates shown will be in the local session timezone as shown by Get-TimeZone.  There are two commands to help you:
```
Get-AGMTimeZoneHandling
Set-AGMTimeZoneHandling -l
Set-AGMTimeZoneHandling -u 
```
In this example we see timestamps are being shown in local TZ (Melbourne), so we switch to UTC and grab a date example:

```
PS /Users/anthony/git/AGMPowerCLI> Get-AGMTimeZoneHandling
Currently timezone in use is local which is (UTC+10:00) Australian Eastern Standard Time
PS /Users/anthony/git/AGMPowerCLI> Set-AGMTimeZoneHandling -u
PS /Users/anthony/git/AGMPowerCLI> Get-AGMTimeZoneHandling
Currently timezone in use is UTC
PS /Users/anthony/git/AGMPowerCLI> Get-AGMUser -filtervalue name=av | select createdate

createdate
----------
2020-06-19 00:28:07
```
We then switch the timestamps back to local and validate the output of the same command shows Melbourne local time:

```
PS /Users/anthony/git/AGMPowerCLI> Set-AGMTimeZoneHandling -l
PS /Users/anthony/git/AGMPowerCLI> Get-AGMTimeZoneHandling
Currently timezone in use is local which is (UTC+10:00) Australian Eastern Standard Time
PS /Users/anthony/git/AGMPowerCLI> Get-AGMUser -filtervalue name=av | select createdate

createdate
----------
2020-06-19 10:28:07
```

## Date field format

All date fields are returned by AGM as EPOCH time (an offset from Jan 1, 1970).  The Module transforms these using the timezone discussed above.   If an EPOCH time is shown (which will be a long number), then this field has been missed and needs to be added to the transform effort.  Please open an issue to let us know.


## What about Self Signed Certs?

At this time we only offer the choice to ignore the cert.   Clearly you can manually import the cert and trust it, or you can install a trusted cert on your AGM to avoid the issue altogether.


## Detecting errors and failures

One design goal of AGMPowerCLI is for all user messages to be easy to understand and formatted nicely.   However when a command fails, the return code shown by $? will not indicate this.  For instance in these two examples we try to connect and check $? each time.  However the result is the same for both cases ($? being 'True', as opposed to 'False', meaning the last command was successfully run).

Successful login:
```
PS /Users/anthony> Connect-AGM 172.24.1.180 av passw0rd -i
Login Successful!
PS /Users/anthony> $?
True
```

Unsuccessful login:
```
PS /Users/anthony> Connect-AGM 172.24.1.180 av password -i

err_code errormessage
-------- ------------
   10011 Login failed

PS /Users/anthony> $?
True
```

The solution for the above is to check for errormessage for every command. 
Lets repeat the same exercise but using -q for quiet login

In a successful login the variable $loginattempt is empty

```
PS /Users/anthony> $loginattempt = Connect-AGM 172.24.1.180 av passw0rd -i -q
PS /Users/anthony> $loginattempt
```

But an unsuccessful login can be 'seen'.  

```
PS /Users/anthony> $loginattempt = Connect-AGM 172.24.1.180 av password -i -q
PS /Users/anthony> $loginattempt

err_code errormessage
-------- ------------
   10011 Login failed

PS /Users/anthony> $loginattempt.errormessage
java.lang.SecurityException: Login failed.
```

So we could test for failure by looking for the .errormessage

```
if ($loginattempt.errormessage)
{
  write-host "Login failed"
}
```

We can then take this a step further in a script.   If a script has clearly failed, then if we set an exit code, this can be read using $LASTEXITCODE.  We put this into a script (PS1).   NOTE!  If you run this inside a PWSH window directly, it will exit the PWSH session (rather than the PS1 script):

```
if ($loginattempt.errormessage)
{
  write-host "Login failed"'
  exit 1
}
```

We can then read for this exit code like this:

```
PS /Users/anthony> $LASTEXITCODE
1
```

 # Working with Common Functions in AGMPowerCLI versus Composite Functions in AGMPowerLib
 
 The goal of AGMPowerCLI is to expose all the REST API end points that are available on an AGM so you can automate functions using PowerShell.  However this requires a knowledge of the END points and particularly for commands that create new things (like mounts), these commands need a body that is made of well formed JSON.  For this reason we have started a second module that is dedicated to composite functions.   A composite function is a function that contains multiple end-points or a function that includes guided wizards.   
 
 ## Common Functions
 
 There are several functions exported out of the file AGMPowerCLICommonFunctions.ps1 that are intended to be backbone functions for all of the functions that need to interact with AGM.   While power users may choose to work with them directly, using them is optional, especially as we add more functions to AGMPowerLib.
 
### Get-AGMAPIData
This command sends a Get API call to an AGM.   Normally this function is not called directly, but by another function, such as Get-AGMUser.
However power users can use this function to simplify their own scripts if they so choose.

Here is an example, where we do the following:

1. Access the /application endpoint
1. Use a filtervalue to search in the appname field for apps that are like smalldb.  
1. Request the syncdate field get converted from epoch time to IS08601
1. Limit the number of objects (Apps) returned to one.
1. Sort by ID desc.   Now we are only getting back on application,  but by using this sort, we will get the most recently created one.

```
Get-AGMAPIData -endpoint /application -filtervalue appname~smalldb -datefields "syncdate" -limit 1 -sort id:desc
```

Now to be clear, we could do exactly the same thing with this command:
```
Get-AGMApplication -filtervalue appname~smalldb -limit 1 -sort id:desc
```
 
### Post-AGMAPIData
This command sends a Post API call to an AGM.  Normally this function is not called directly, but by another function.  However power users can use this function to simplify their own scripts if they so choose.
Here is an example, we create an org and return data relevant to that new org.  Note the returned data will be formatted JSON.  
The command does:

1.  Connects to the /org endpoint
1.  Sends a body composed of well formed JSON that supplies the Org name and Ord Description
1.  Requests that in the data that gets returned, that the modify date and createdate fields are concerted from epoch time to ISO8601

```
Post-AGMAPIData -endpoint /org -body '{ "description": "Melbourne test team","name": "MelTeam1" }' -datefields "modifydate,createdate"
```
We could do exactly the same with:

```
New-AGMOrg -orgname MelTeam1 -description "Melbourne test team"

```    
In this example we delete an org (ID 53688920):

```
Post-AGMAPIData -endpoint /org/53688920 -method "delete"
```
We could do exactly the same with:
```
Remove-AGMOrg 54382768
```


# User Stories

In this section we will share some examples of User Stories

## Bulk unprotection of VMs

In this scenario, a large number of VMs that were no longer required were removed from the vCenter. However, as those VMs were still being managed by Actifio at the time of removal from the VCenter, the following error message is being received constantly
 
 ```
Error 933 - Failed to find VM with matching BIOS UUID
```

### 1)  Create a list of affected VMs using AGM PowerShell

First we need to create a list of affected VMs.  The simplest way to do this is to run these commands:

There are two parameters in the filtervalue.
The first is the errorcode of 933
The second is the startdate.  You need to update this.

This is the command we thus run (connect-agm logs us into the appliance).
We grab just the Appname  (which is the VMname) and AppID of each affected VM and reduce to a unique list in a CSV file

```
connect-agm 
Get-AGMJobHistory -filtervalue "errorcode=933&startdate>2020-09-01"  | select appname,appid | sort-object appname | Get-Unique -asstring | Export-Csv -Path .\missingvms.csv -NoTypeInformation
```
### 2). Edit your list if needed

Now open your CSV file called missingvms.csv and go to the VMware administrator.
Validate each VM is truly gone.
Edit the CSV and remove any VMs you don't want to unprotect.   
 
### 3) Unprotection script using AGM Powershell

Because we have a CSV file of affected VMs we can run this simple PowerShell script. 

Import the list and validate the import worked by displaying the imported variable.  In this example we have only four apps.
```
PS /Users/anthonyv> $appstounmanage = Import-Csv -Path .\missingvms.csv
PS /Users/anthonyv> $appstounmanage

appname      appid
-------      --
duoldapproxy 655601
SYDWINDC1    655615
SYDWINDC2    6227957
SYDWINFS2    5370126
```
Then paste this script to validate each app has an SLA ID
```
foreach ($app in $appstounmanage)
{ $slaid = get-agmSLA -filtervalue appid=$($app.appid)
write-host "Appid $($app.appid) has SLA ID $($slaid.id)" }
```
Output will be similar to this:
```
Appid 655601 has SLA ID 6749490
Appid 655615 has SLA ID 6749492
Appid 6227957 has SLA ID 6749494
Appid 5370126 has SLA ID 6749496
```
If you want to build a backout plan, run this script now:
```
foreach ($app in $appstounmanage)
{ $slaid = Get-AGMSLA -filtervalue appid=$($app.appid)
$slpid =  $slaid.slp.id
$sltid =  $slaid.slt.id
write-host "New-AGMSLA -appid $($app.appid) -slpid $slpid -sltid $sltid" }
```
It will produce a list of commands to re-protect all the apps.
You would simply paste this list into your Powershell session:
```
New-AGMSLA -appid 655601 -slpid 655697 -sltid 4171
New-AGMSLA -appid 655615 -slpid 655697 -sltid 4181
New-AGMSLA -appid 6227957 -slpid 655697 -sltid 4171
New-AGMSLA -appid 5370126 -slpid 655697 -sltid 4181
```
Now we are ready for the final step.  Run this script to unprotect the VMs:
```
foreach ($app in $appstounmanage)
{ Remove-AGMSLA -appid $($app.appid) }
```
Output will be blank but the VMs will all be unprotected

### 4) Bulk deletion of the Applications

If any of the Applications have images, it is not recommended you delete them, as this creates orphans apps and images.
If you are determined to also delete them, run this script to delete the VMs from AGM and Appliances.
```
foreach ($app in $appstounmanage)
{ Remove-AGMApplication -appid $($app.appid) }
```
Output will be blank but the VMs will all be deleted.
