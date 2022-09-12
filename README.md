# ELEC2117 MPLAB X PIC16F886 XC8 ASM Starter Code

This repo is a port of the provided ELEC2117 Project code for the MPASM Assembler, to the newer XC8 PIC Assembler (pic-as). As MPASM was discontinued as of MPLAB X 5.40, this provides similar startup code to what is provided in the labs, but assembles in newer versions of MPLAB X. It may be required to download XC8 separately from MPLAB X from Microchip's website to get pic-as.
# Use
Download this repo as a .zip file thru the code dropdown above.
Unzip contents into a new empty folder
In MPLAB X, File > Open Project and select the new folder
This will open as a project named ELEC2117_Template. This can be renamed by right clicking on project container within the projects tab and pressing rename. It is recommended to check "Also rename project folder" for consistency.

When creating new .s files, It may be nececary to explicitly include them into the compilation by right clicking on Source Files in Projects and selecting Add Existing Item...

# Changes
As the syntax and functionality of pic-as is slightly different to MPASM, some specifics have been removed. This is mostly the directives to format the .MAP listing.

 - The __CONFIG directive has been changed to CONFIG directives
 - UDATA, UDATA_SHR and CODE data sections have been replaced with PSECTs.
 - PSECTs with absolute addresses are now positioned by linker command line flags (see note in main.s before RES_VEC)
 - Split code into two .s files to hide config & global context switch temp variables
 - Added assembler flags to generate .lst files

These changes were made mostly with the direction of the Microchip MPASM to MPLAB XC8 PIC Assembler Migration Guide.

# Notes

 - The interrupt handler has not been tested. It may or may not work.
 - When assembling for release, there is a warning regarding the debug bit being set. This warning can be fixed by setting the Debug CONFIG directive to off in setup.s. However, I have kept the startup code as similar to the MPASM as possible in this release.