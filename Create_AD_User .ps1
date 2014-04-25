#***********************************************************************
# NAME:  CreateADUser
#
# AUTHOR: Dwayne C. Barrett
# DATE  : 7/11/11
#
# VERSION: 7/13/11 	Beta
#		   9/1/11	Production Release
#          5/1/2012 Changed user homedirectory path to DFS links
#          8/15/2013 Added comments for Remedy db column names
#          1/24/2014 Updated email distribution list's
#
# COMMENT: Create AD Account from Remedy Ticket 
#************************************************************************

<# Remedy column/field names
C536870943 is a text field which contains the date when the script updated the record
C536870938 is a text field which contains the account build status (i.e. Created or Failed)
C536870954 is a text field which contains the NAS path that will be created for the account
C536870929 is a text field which contains the user's AKO. If the AKO is too long, the script truncates it and writes the truncated AKO back to this field.
#>

##### Load Quest Snappin used for creating accounts, if not installed, check for OS Architecture and open installer package#####

Add-PsSnapin Quest.ActiveRoles.ADManagement -ErrorAction SilentlyContinue													# Add Quest Snappin
if ( (Get-PSSnapin -Name Quest.ActiveRoles.ADManagement -ErrorAction SilentlyContinue) -eq $null )							# Check for Snappin
{
# Snappin not found...Notify User....Determine OS Bit Information....Launch appropriate install file 
[windows.forms.messagebox]::show('Active Roles is NOT installed. Please click OK to install.','Warning','OK',[Windows.Forms.MessageBoxIcon]::Error)

	$Bit = gwmi win32_operatingsystem | select OSArchitecture,caption														# Determine Bit Info
	if ($Bit -match "64")
	{
	Invoke-Item \\carsnecxa0x0100\SMBMgmtTools\ActiveRolesManagementShellforActiveDirectoryx64_140.msi
	}
	else {Invoke-Item \\carsnecxa0x0100\SMBMgmtTools\ActiveRolesManagementShellforActiveDirectoryx86_140.msi }
	
	exit																													# Close powershell script
}
#==========================================================================================================
#                                               Functions
#==========================================================================================================
Function Send_Email 
{ 
#=====================================================================
# Send email to SMB SA Team if an user account fails 
# 		to create for one reason or another
#=====================================================================
        $date = Get-Date -Format "yyyy/MM/dd"
        $mailmsg = new-object system.net.mail.mailmessage
        $mailmsg.Subject = "Failed Creating AD Accounts on $date"
        $mailmsg.Body = ""
        $mailmsg.From = "FtCarsonNECSMB@carson.army.mil" 
        $mailmsg.Attachments.add($File)
     
        # Add multiple recipients using "name@army.mil", "name2@army.mil"
        $to = "usarmy.carson.106-sig-bde.list.nec-ssd-smb-remedy-group@mail.mil","usarmy.carson.106-sig-bde.list.nec-ssd-smb-sa@mail.mil"
        foreach ($addr in $to)
            {
            $addr = $addr.trim()
            $a = new-object System.Net.Mail.MailAddress($addr)
            $mailmsg.To.add($a)
            }
            
        # Add multiple recipients using "name@army.mil", "name2@army.mil"
        $cc = ""    
        foreach ($addr in $cc)
            {
            $addr = $addr.trim()
            if ($addr -ne "")
                {
                $a = new-object System.Net.Mail.MailAddress($addr)
                $mailmsg.CC.add($a)
                }
             }
        $smtpServer = "155.214.100.30"
        $smtp = new-object System.Net.Mail.SmtpClient($smtpServer)
        $smtp.Send($mailmsg)
		del $File																						# Delete Temp File
}

Function Search_EDIPI
{Param([string]$EDIPI)
#=====================================================================
# Search All domains for EDIPI in use
#=====================================================================

	$Domain = ("AR","DAHQ", "NASE", "NASW", "NAE","NANW")												# All user domains
	$DN = $null
	foreach ($DC in $Domain)
	{
		$erroractionpreference = "SilentlyContinue"
		[string]$filter = "(userprincipalname=$EDIPI@mil)"
		$root = [ADSI]"LDAP://DC=$DC,DC=ds,DC=army,DC=mil"
		[string]$props  = "givenName","DN"
		$ds = New-Object DirectoryServices.DirectorySearcher([adsi]$root,$filter,$props,"Subtree") 		#Build ADSI query with specified properties
		$ds.PageSize = 1000
		$DN += $ds.FindOne().GetDirectoryEntry().Path
	}
	$DN =  $DN.ToString().replace("LDAP://CN=","").Replace("OU=","").Replace("DC=","")					# If found, replace string characters

	return ($DN)																					
}

Function Search_SAM
{Param([string]$SAM)
#=====================================================================
# Search All domains for SAM account in use
#=====================================================================

	$Domain = ("AR","DAHQ", "NASE", "NASW", "NAE","NANW")												# All user domains
	$DN = $null
	foreach ($DC in $Domain)
	{
		$erroractionpreference = "SilentlyContinue"
		[string]$filter = "(sAMAccountName=$Sam)"
		$root = [ADSI]"LDAP://DC=$DC,DC=ds,DC=army,DC=mil"
		[string]$props  = "givenName","DN"
		$ds = New-Object DirectoryServices.DirectorySearcher([adsi]$root,$filter,$props,"Subtree") 		#Build ADSI query with specified properties
		$ds.PageSize = 1000
		$DN += $ds.FindOne().GetDirectoryEntry().Path
	}
	$DN =  $DN.ToString().replace("LDAP://CN=","").Replace("OU=","").Replace("DC=","")					# If found, replace string characters

	return ($DN)
}

Function Update_DB
{Param([string]$ID, [string]$Message, [string]$NAS, [string]$AKO)
#=====================================================================
# Update Database with Status Information for current user
#=====================================================================
	$Updated = Get-Date -Format "MM/dd/yy"
	
	# Possible Queries
	if ($NAS -ne "NULL" -and $AKO -ne "NULL")		#NAS folder & and New AKO/SAM
	{$SQLQuery = "update dbo.T3574 set [C536870943] = `'{0}`', [C536870938] = `'{1}`', [C536870954] = `'{2}`', [C536870929] = `'{3}`' where C1 = `'{4}`'" -f $Updated,$Message, $NAS, $AKO, $ID}
	
	elseif ($NAS -ne "NULL" -and $AKO -eq "NULL")	#NAS folder and existing AKO/SAM
	{$SQLQuery = "update dbo.T3574 set [C536870943] = `'{0}`', [C536870938] = `'{1}`', [C536870954] = `'{2}`' where C1 = `'{3}`'" -f $Updated,$Message, $NAS, $ID}
	
	else											
	{$SQLQuery = "update dbo.T3574 set [C536870943] = `'{0}`', [C536870938] = `'{1}`' where C1 = `'{2}`'" -f $Updated,$Message, $ID}
	
	# Create SQL Connection to Remedy DB
	$SQLUpdateConnection = New-Object System.Data.SQLClient.SQLConnection
	$SQLUpdateConnection.ConnectionString =  $GlobalConnectionString
	$erroractionpreference = "SilentlyContinue"
	$SQLUpdateConnection.Open()
	
	# Create SQL Command to Update record
	$SQLUpdateCommand = New-Object System.Data.SQLClient.SQLCommand
	$SQLUpdateCommand.Connection = $SQLUpdateConnection
	$SQLUpdateCommand.CommandText = $SQLQuery

	# Create SQL Adapter to Update record
	$SQLUpdateAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
	$SQLUpdateAdapter.SelectCommand = $SQLUpdateCommand
		
	$SQLUpdateDataset = New-Object System.Data.DataSet
	$SQLUpdateAdapter.Fill($SQLUpdateDataset) | Out-Null 
    $SQLExecConnection.Close()	
}

 
Function Create_User
{ Param([string]$EDIPI, [string]$Sam, [string]$SN, [string]$GivenName, [string]$MI, [string]$Persona, [string]$Building,`
	[string]$Room, [string]$Phone, [string]$Rank, [string]$Office, [string]$Unit, [string]$Org, [int]$VPN )
#=====================================================================
# Create New User in the _New User OU from data in SQL DB
#	Check for DoD Visitor acct and delete if found
#=====================================================================

#-----------Data Clean up and modification------------

		# Build Address Field with Unit, Bldg and Room				
		if (($Room) -eq "" -and ($Building -ne "") )
			{ $Address = $Unit + "`r`nBLDG $Building" }								
		elseif (($Room -ne "") -and ($Building -ne "")) 
			{ $Address = $Unit + "`r`nBLDG $Building" + ", RM $Room" }	
		else {	$Address = $Unit  }

		# Capitalize first letter
		$Sn = $Sn|foreach{$_.substring(0,1).toupper()+$_.substring(1,$_.length-1).tolower()}					# Ensure first letter is capital
		$GivenName = $GivenName|foreach{$_.substring(0,1).toupper()+$_.substring(1,$_.length-1).tolower()}		# Ensure first letter is capital
		$MI = $MI|foreach{$_.substring(0,1).toupper()+$_.substring(1,$_.length-1).tolower()}					# Ensure first letter is capital

		# Determine Branch
		$TmpRank = $Rank.toString().Split("-")[0]		
		switch ($TmpRank) 
	    { 
	        AF { $Branch = "USAF" } 
			CG { $Branch = "USCG" } 
			N { $Branch = "USN" } 
			Mar { $Branch = "USM" } 
			Default { $Branch = "USA"}
	    }
		
		# Clean up Rank value
		if ($Rank -match "-")
		{	$Rank = $Rank.toString().Split("-")[1]	}
		
		# Clean up Org Name
		if ($Org -match "NETCOM")
		{ $Org = "NETCOM/9TH SC A 7TH SC"}
		
		# Create Display Name
		$Dis = "{0}, {1} {2} {3} {4} {5} {6} " -f $SN, $GivenName, $MI, $Rank, $Persona, $Branch, $Org
		$Dis = $Dis.ToString().Replace("  "," ")

		# Set CN Name w/ or w/o MI
		if ($MI -eq "")
	    {$CN = $Sn + "\, " + $GivenName} 
	    else {$CN = $Sn + "\, " + $GivenName + " " + $MI}
		
#--------------------#--------------------#--------------------#	

#--------------------Create AD User--------------------#
		$Sam = $Sam.ToString().Replace(",",".")
		$erroractionpreference = "SilentlyContinue"
		$NewUserOU=[ADSI]("LDAP://"+$GlobalNewUsersOU) 
		$newUser=$NewUserOU.Create("user","CN=$CN")
		$newUser.Put("sAMAccountName",$Sam) 							# Sam Acct Name
		$newUser.SetInfo() 	

			$newUser.SetPassword("PAssword!!1234") 						# set a password 
			$newUser.Put("UserAccountControl","262656") 				# Enable account with smart card required
			$newUser.Put("l","Fort Carson") 							# City
			$newUser.Put("st","CO") 									# State
			$newUser.Put("postalCode","80913") 							# Zip Code
			$newUser.Put("co","United States") 							# Country
			$newUser.Put("c","US") 										# Country
			$newUser.Put("primaryGroupID","513") 						# Primary Group ID		                  
			$newUser.SetInfo()  										# commit changes to Active Directory

		# Set Persona's for CIV and CTR
		if ($Persona -match "CIV") {$Rank = "CIV"}
		if ($Persona -match "CTR") {$Rank = "CTR"}
		
		# Compute DSN Phone Number
		if ($Phone -ne $null)
		{
			$DSN = $null
			$DSNPre = $Phone.Split(".")[1]
			switch ($DSNPre)
			{
			526 {$DSN = "312.691." + $Phone.Split(".")[2]}
			524 {$DSN = "312.883." + $Phone.Split(".")[2]}
			503 {$DSN = "312.532." + $Phone.Split(".")[2]}
			}
			
			# Execute change
			set-QADUser $Sam -ObjectAttributes @{OtherTelephone=$DSN} | out-null
		}

		# Compute Z Drive \\carsdoima7x0034\shares\users\
		$ZDrivePath = ""					# Path mapped in AD to user profile									
		$ZDrive = ""						# Physical location of user home drive
		
		# AKO/SAM has three periods (.)
		if ($SAM.Split(".").Length -eq 3) 		
		{
			$Folder = $SAM.Split(".")[2].Remove(1)		# Determine first letter of last name according to AKO/SAM
			$ZDrivePath = "\\carsnecxa7x0001\shares\users\$Folder\$SAM"	
			$ZDrive = "\\carsdoima7x0034\users$\$Folder\$SAM"	
		}
		
		# AKO/SAM has two periods (.)
		if ($SAM.Split(".").Length -eq 2) 
		{
			$Folder = $SAM.Split(".")[1].Remove(1)		# Determine first letter of last name according to AKO/SAM
			$ZDrivePath = "\\carsnecxa7x0001\shares\users\$Folder\$SAM"
			$ZDrive = "\\carsdoima7x0034\users$\$Folder\$SAM"
		}
		
		# Create Z Drive Folder
		$validuser = Get-QADUser $Sam
		
		# Double checks to ensure user account was actually created prior to creating home drive folder
		if ($validuser)  											
		{
			New-Item $ZDrive -Type "Directory"			# Create folder
			
			$Rights = "Modify"
			
			sleep 3										# Pause script to ensure folder was created
	 		
			 # Set access for NAS Admins
			 $ruleadmin = new-object System.Security.AccessControl.FileSystemAccessRule("NANW\CARSON NEC SSD SMB NAS SA Admins","FullControl","ContainerInherit, ObjectInherit", "None", "Allow")

			 $acladmin = get-acl $ZDrive
						 
			 $acladmin.SetAccessRule($ruleadmin) 
			 set-acl $ZDrive $acladmin 						# Write the changes to the object
			 
			 # Set access for user	
			 sleep 5
			 $ruleuser = new-object System.Security.AccessControl.FileSystemAccessRule("nanw\$Sam",$Rights,"ContainerInherit, ObjectInherit", "None", "Allow")

			 $acluser = get-acl $ZDrive
						 
			 $acluser.SetAccessRule($ruleuser)  
			 set-acl $ZDrive $acluser 						#Write the changes to the object
		}
		
		# Additional Info pulled from the Remedy Ticket
		set-QADUser $Sam -ObjectAttributes @{UserPrincipalName="$EDIPI@mil";employeeID=$EDIPI;employeeType=$Persona;initials=$MI;sn=$Sn;GivenName=$GivenName} | out-null
		set-QADUser $Sam -ObjectAttributes @{initials=$MI;DisplayName=$Dis;telephoneNumber=$Phone;Title=$Rank;PersonalTitle=$Rank;department=$Unit;physicalDeliveryOfficeName=$Office;streetAddress=$Address} | out-null
		set-QADUser $Sam -ObjectAttributes @{homeDrive="Z:";homeDirectory=$ZDrivePath} | out-null
		
		# Add users to VPN group
		If($VPN -eq 1) {Add-QADGroupMember -Identity "CN=CARSON VPN USERS,OU=Special Groups,OU=NETCOM,OU=Fort Carson,OU=Carson,OU=Installations,DC=nanw,DC=ds,DC=army,DC=mil" -Member $Sam}
##--------------------#--------------------#--------------------		
}

Function Verify_Account
{Param([string]$Incident,[string]$SAM, [string]$ID, [string]$EDIPI, [string]$SN, [string]$GivenName, [string]$MI, [int]$VPN)
#=====================================================================
# Checks AD for each user to confirm they have been created,
#		upon doing so, updates the Created Date field in the DB
#=====================================================================
$validuser = Get-QADUser $SAM  	
# Double checks to ensure user account was actually created 
	if ($validuser)  											
	{	
		$HomeD = (Get-QADUser $SAM | select homeDirectory).homeDirectory
		
		# Create new message for VPN and User
		if ($VPN -eq 1) {$Created = "CREATED: with VPN " + (Get-Date -Format "yyyy/MM/dd HH:mm")	}
			else {$Created = "CREATED: " + (Get-Date -Format "yyyy/MM/dd HH:mm")	}
					
		Update_DB -ID $ID -Message $Created -NAS $HomeD -AKO $SAM							# Update DB Record 		
	}
	else
	{ # User account does not exist, create export with failed accounts
		If (!(Test-Path $File))																# Failed export list does not exist, create csv
		{
		"IncidentID|EDIPI|SAM|LastName|FirstName|MI"  >> $File
		$Incident + '|' + $EDIPI +'|'+  $SAM  +'|'+ $SN +'|'+ $GivenName +'|'+ $MI  >> $File
		$Failed = "FAILED to Create: " + (Get-Date -Format "yyyy/MM/dd HH:mm")
		Update_DB -ID $ID -Message $Failed -NAS "NULL" -AKO "NULL"							# Update DB Record for failed creation       
		} 
		else 
		{
		$Incident + '|' + $EDIPI +'|'+  $SAM  +'|'+ $SN +'|'+ $GivenName +'|'+ $MI  >> $File
		$Failed = "FAILED to Create: " + (Get-Date -Format "yyyy/MM/dd HH:mm")
		Update_DB -ID $ID -Message $Failed -NAS "NULL" -AKO "NULL"							# Update DB Record for failed creation        
		}
	}
}

#==========================================================================================================
#                                           Global Variables
#==========================================================================================================
$GlobalConnectionString = "Server=carsnecxa4x0003;Database=arsystem;Integrated Security=True”								# DB Connection String
$GlobalNewUsersOU = "OU=_New Users,OU=NETCOM,OU=Fort Carson,OU=Carson,OU=Installations,DC=nanw,DC=ds,DC=army,DC=mil"		# New Users OU


#==========================================================================================================
#                                           Script
#==========================================================================================================
cls
$date = Get-Date -Format "yyyy_MM_dd_hh_mm"
$File = "F:\Projects\RemedyADUser\Remedy_AD_Failed_Accounts_$date.csv"														# Failed export file
		
#=====================================================================
#  Connect to database and retrieve new user accounts where,
#		the created date is NULL and verifiedBy is NOT NULL
#=====================================================================
# Connection string and query
$SQLQuery = "select * from dbo.FC_Account_Creation where txtAcctStatus is null and txtVerifiedBy is not null"
$SQLExecConnection = New-Object System.Data.SQLClient.SQLConnection
$SQLExecConnection.ConnectionString =  $GlobalConnectionString
$erroractionpreference = "SilentlyContinue"
$SQLExecConnection.Open()

# Create SQL Command to execute query
$SQLExecCommand = New-Object System.Data.SQLClient.SQLCommand
$SQLExecCommand.Connection = $SQLExecConnection
$SQLExecCommand.CommandText = $SQLQuery

# Create SQL Adapter to read information
$SQLExecAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SQLExecAdapter.SelectCommand = $SQLExecCommand	
$SQLExecDataset = New-Object System.Data.DataSet
$SQLExecAdapter.Fill($SQLExecDataset) | Out-Null 	
$SQLExecConnection.Close()		

# Set userinfo variable
$UsersInfo = $SQLExecDataset.Tables[0] | select *
$SQLExecDataset.Clear()	

if ($UsersInfo | select txtEDIPI)																# Verify SQL Query is not null
{
	$FailedAccounts = @()																		# Array for failed account creation
	
	# Loop through each row in the SQL result set
	foreach ($UserInfo in $UsersInfo)
	{				
		$Action = $UserInfo.selAcctType
		
		switch($Action)
		{
			0 {		# Type "User Only"
			
						#-----------Check for DoD Visitor Account------------#
						$SearchEDIPI = $UserInfo.txtEDIPI
						Get-QADUser "$SearchEDIPI@mil" | ? {$_.DN -match "_DoDVisitor"} | Remove-QADObject -force	
					
				        $DNEDIPI = $null
						$DNSAM = $null
						$DNEDIPI = Search_EDIPI -EDIPI $UserInfo.txtEDIPI										# Verify EDIPI Is not Used
						$DNSAM = Search_SAM -SAM $UserInfo.txtAKO												# Verify SAM Is not Used
						
						##### If EDIPI is Found #####
						if ($DNEDIPI -ne $null)
						{
							# Update status in Remedy DB that EDIPI is in use; break loop
							$UpdateDN = $DNEDIPI
					        Update_DB -ID $UserInfo.Request_ID -Message "FOUND - EDIPI In Use : $UpdateDN" -NAS "NULL" -AKO "NULL"
					        break
				        }
						##### If AKO/SAM is Found #####
						elseif ($DNSAM -ne $null)
						{
							$UpdateDN = $DNSAM
							
							# Sam acct is in use, appending a random number for creation
							$Num = Get-Random -minimum 1 -maximum 20
							$AKO = $UserInfo.txtAKO + $num
							
							# Validate SAM Account Length
							$Date = Get-Date -Format "MMdd"
							if ($AKO.Length -gt 20 )
							{$AKO = $AKO.SubString(0,16) + $date}
					        
								# Execute Account Creation Function
								Create_User 	`
								-EDIPI $UserInfo.txtEDIPI `
								-Sam  $AKO `
								-SN $UserInfo.txtLastName`
								-GivenName $UserInfo.txtFirstName `
								-MI $UserInfo.txtMiddleInitial `
								-Building $UserInfo.txtBuilding `
								-Room $UserInfo.txtRoom `
								-Office $UserInfo.txtOffice `
								-Persona $UserInfo.txtPersona `
								-Phone $UserInfo.txtTelephone `
								-Rank $UserInfo.txtRank `
								-Unit $UserInfo.txtDepartment `
								-Org $UserInfo.txtOrganization `
								-VPN 0
																						
					            # Execute Account Verification Function
								Verify_Account `
								-SAM $AKO `
								-ID $UserInfo.Request_ID `
								-EDIPI $UserInfo.txtEDIPI `
								-GivenName $UserInfo.txtFirstName `
								-MI $UserInfo.txtMiddleInitial `
								-SN $UserInfo.txtLastName	`
								-Incident $UserInfo.txtAssociatedIncident `
								-VPN 0
					        break
				        }		
						##### EDIPI and AKO/SAM accoun is not found #####
						else
						{																					# Create AD Account		
							$VerifySam = $UserInfo.txtAKO
							$VerifySam = $VerifySam.Trim(" ")
							
							# Validate SAM Account Length
							$Date = Get-Date -Format "MMdd"
							if ($VerifySam.Length -gt 20 )
							{$VerifySam = $VerifySam.SubString(0,16) + $date}
							
							# Execute Account Creation Function
							 Create_User 	`
							-EDIPI $UserInfo.txtEDIPI `
							-Sam  $VerifySam `
							-SN $UserInfo.txtLastName`
							-GivenName $UserInfo.txtFirstName `
							-MI $UserInfo.txtMiddleInitial `
							-Building $UserInfo.txtBuilding `
							-Room $UserInfo.txtRoom `
							-Office $UserInfo.txtOffice `
							-Persona $UserInfo.txtPersona `
							-Phone $UserInfo.txtTelephone `
							-Rank $UserInfo.txtRank `
							-Unit $UserInfo.txtDepartment `
							-Org $UserInfo.txtOrganization `
							-VPN 0
				            
				           	# Execute Account Verification Function												
							Verify_Account `
							-SAM $VerifySam `
							-ID $UserInfo.Request_ID `
							-EDIPI $UserInfo.txtEDIPI `
							-GivenName $UserInfo.txtFirstName `
							-MI $UserInfo.txtMiddleInitial `
							-SN $UserInfo.txtLastName	`
							-Incident $UserInfo.txtAssociatedIncident `
							-VPN 0
						}
					} # End User Only
					
			1		{ # Type "VPN Only"
			
					# Add user to VPN Group
					Add-QADGroupMember -Identity "CN=CARSON VPN USERS,OU=Special Groups,OU=NETCOM,OU=Fort Carson,OU=Carson,OU=Installations,DC=nanw,DC=ds,DC=army,DC=mil" -Member $UserInfo.txtAKO
					
					# Update status in db after VPN Creation
					$Created = "VPN Access : " + (Get-Date -Format "yyyy/MM/dd HH:mm")				
					Update_DB -ID $UserInfo.Request_ID -Message $Created -NAS "" -AKO $UserInfo.txtAKO							# Update DB Record 	
					} # End VPN Only
					
			2		{ # Type "User and VPN"
			
					#-----------Check for DoD Visitor Account------------#
						$SearchEDIPI = $UserInfo.txtEDIPI
						Get-QADUser "$SearchEDIPI@mil" | ? {$_.DN -match "_DoDVisitor"} | Remove-QADObject -force	
					
				        $DNEDIPI = $null
						$DNSAM = $null
						$DNEDIPI = Search_EDIPI -EDIPI $UserInfo.txtEDIPI										# Verify EDIPI Is not Used
						$DNSAM = Search_SAM -SAM $UserInfo.txtAKO												# Verify SAM Is not Used
						
						##### If EDIPI is Found #####
						if ($DNEDIPI -ne $null)
						{
							# Update status in Remedy DB that EDIPI is in use; break loop
							$UpdateDN = $DNEDIPI
					        Update_DB -ID $UserInfo.Request_ID -Message "FOUND - EDIPI In Use : $UpdateDN" -NAS "NULL" -AKO "NULL"
					        break
				        }
						##### If AKO/SAM is Found #####
						elseif ($DNSAM -ne $null)
						{
							$UpdateDN = $DNSAM
							
							# Sam acct is in use, appending a random number for creation
							$Num = Get-Random -minimum 1 -maximum 20
							$AKO = $UserInfo.txtAKO + $num
							
							# Validate SAM Account Length
							$Date = Get-Date -Format "MMdd"
							if ($AKO.Length -gt 20 )
							{$AKO = $AKO.SubString(0,16) + $date}
					        
								# Execute Account Creation Function
								Create_User 	`
								-EDIPI $UserInfo.txtEDIPI `
								-Sam  $AKO `
								-SN $UserInfo.txtLastName`
								-GivenName $UserInfo.txtFirstName `
								-MI $UserInfo.txtMiddleInitial `
								-Building $UserInfo.txtBuilding `
								-Room $UserInfo.txtRoom `
								-Office $UserInfo.txtOffice `
								-Persona $UserInfo.txtPersona `
								-Phone $UserInfo.txtTelephone `
								-Rank $UserInfo.txtRank `
								-Unit $UserInfo.txtDepartment `
								-Org $UserInfo.txtOrganization `
								-VPN 1
																						
					            # Execute Account Verification Function
								Verify_Account `
								-SAM $AKO `
								-ID $UserInfo.Request_ID `
								-EDIPI $UserInfo.txtEDIPI `
								-GivenName $UserInfo.txtFirstName `
								-MI $UserInfo.txtMiddleInitial `
								-SN $UserInfo.txtLastName	`
								-Incident $UserInfo.txtAssociatedIncident `
								-VPN 1
					        break
				        }		
						##### EDIPI and AKO/SAM accoun is not found #####
						else
						{																					# Create AD Account		
							$VerifySam = $UserInfo.txtAKO
							$VerifySam = $VerifySam.Trim(" ")
							
							# Validate SAM Account Length
							$Date = Get-Date -Format "MMdd"
							if ($VerifySam.Length -gt 20 )
							{$VerifySam = $VerifySam.SubString(0,16) + $date}
							
							# Execute Account Creation Function
							 Create_User 	`
							-EDIPI $UserInfo.txtEDIPI `
							-Sam  $VerifySam `
							-SN $UserInfo.txtLastName`
							-GivenName $UserInfo.txtFirstName `
							-MI $UserInfo.txtMiddleInitial `
							-Building $UserInfo.txtBuilding `
							-Room $UserInfo.txtRoom `
							-Office $UserInfo.txtOffice `
							-Persona $UserInfo.txtPersona `
							-Phone $UserInfo.txtTelephone `
							-Rank $UserInfo.txtRank `
							-Unit $UserInfo.txtDepartment `
							-Org $UserInfo.txtOrganization `
							-VPN 1
				            
				           	# Execute Account Verification Function												
							Verify_Account `
							-SAM $VerifySam `
							-ID $UserInfo.Request_ID `
							-EDIPI $UserInfo.txtEDIPI `
							-GivenName $UserInfo.txtFirstName `
							-MI $UserInfo.txtMiddleInitial `
							-SN $UserInfo.txtLastName	`
							-Incident $UserInfo.txtAssociatedIncident `
							-VPN 1
						}
					} # End User & VPN		
		} # End Switch
	} # End Foreach						

}	# End IF

#=====================================================================
# Check for failed accounts and send email
#=====================================================================
If (Test-Path $File)
{
	$FailedAccounts = @()     
	$FailedAccounts = import-csv  -delimiter "|" -path $File  | select IncidentID, EDIPI, SAM, LastName, FirstName, MI
	$FailedAccounts | export-csv $File -notypeInformation 
	Send_Email											# Send email
}