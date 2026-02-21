# Star-citizen-Virpil-configurator-input-translation
a Powershell Script that will convert starcitizen input xml file created with old virpil mapping from VPC Software to new mapping set by VPC configurator Alpha.

## Configuration :   
 
You will need to adapt Joystick instance value to your specific input configuration.
 <options type="joystick" instance="1" Product="VPC Stick WarBRD  {00D53344-0000-0000-0000-504944564944}"></options>
 <options type="joystick" instance="2" Product="VPC Throttle MT-50CM2  {01933344-0000-0000-0000-504944564944}"></options>

 VPC Stick WarBRD (Const alpha) will use joystick instance number 1 (JS1)
 VPC Throttle MT-50CM2 will use joystick instance 2 (JS2)

## launch the script  
Open cmd terminal and launch following command:

powershell.exe -ep bypass -file "x:\xxx\virpil_sc_conversion.ps1"

<img width="525" height="484" alt="image" src="https://github.com/user-attachments/assets/97ef67cf-15c7-4918-a8eb-c150b9d0acf2" />

