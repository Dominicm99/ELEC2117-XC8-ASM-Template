; Dominic McAuley z5208099, T3 2022

; The pic-as assembler no longer uses device-specific includes.
; These have now been replaced with xc.inc
#include <xc.inc>

; Inform the linker of the global variables defined in setup.s
EXTRN WREG_CTX
EXTRN STATUS_CTX
EXTRN PCLATH_CTX
EXTRN FSR_CTX

; Declare variables here.
; These will be stored in any available General Purpose Register (DS40001291H-page 26)
; If optimization of banks is required, the RAM class can be replaced with BANKN
; If Constant variables are required, class can be set to CONST to allocate to program memory
PSECT vars, space=1, class=RAM


; End variable declaration
 
 
; ISR Setup:
 
; NOTE: with pic-as, the location of code sections is set by a linker directive
; These can be set in Project Properties > Conf > pic-as Global Options > pic-as Linker
; Locations are set by adding a -pPSECTNAME=addr to the Custom Linker Options.
; This project has the following two entries provided to locate the reset and interrupt vectors:
; -pRES_VEC=0h
; -pINT_VEC=4h
 
; POR and BOR vector (First call during startup: PC=0)
PSECT RES_VEC, delta=2, class=CODE  
RES_VEC:
    goto    MAIN		; Set PC to address of Main, jumping over INT_VEC
    
; When any interrupt is raised, the last program counter location is pushed
; onto the stack and the program counter is set to the this location. Global
; interrupts are also disabled.
PSECT INT_VEC, delta=2, class=CODE
INT_VEC:
    movwf	WREG_CTX	; Context save Working Register.
    movf	STATUS,	w	; Copy Status Register into Working Register.
    movwf	STATUS_CTX	; Context save Status Register.
    movf	FSR,	w	; Copy File Select Register into Working Register.
    movwf	FSR_CTX		; Context save File Select Register.
    movf	PCLATH,	w	; Copy Program Counter Latch High Register into Working Register.
    movwf	PCLATH_CTX	; Context save Program Counter Latch High Register.
	
    ; Interrupt code goes here.
	
    movf	PCLATH_CTX, w	; Copy saved context of Program Counter Latch High Register into Working Register.
    movwf	PCLATH		; Context restore Program Counter Latch High Register.
    movf	FSR_CTX,    w	; Copy saved context of File Select Register into Working Register.
    movwf	FSR		; Context restore File Select Register.
    movf	STATUS_CTX, w	; Copy saved context of Status Register into Working Register.
    movwf	STATUS		; Context restore Status Register.
    swapf	WREG_CTX,   f	; We cannot use movf as that will mess with the Status Register. So we can swapf
    swapf	WREG_CTX,   w	; twice and on the second, context restore the Working Register.
    retfie			; Finally, return from the interrupt service routine. This is done by popping the
				; stack to get the Program Counter location before the interrupt. Global interrupts


;; Create new PSECT to differentiate code size of ISR and Main in MAP file
PSECT MAIN, delta=2, class=CODE
;; ------------- Your normal program is written below here. ---------------;;
MAIN:
SETUP:
    ;; Insert setup code here. Run once whenever the MCU resets.

    
LOOP:
    ;; Insert main loop code

    
    goto	LOOP		; Jump the Program Counter to where the LOOP label is. This creates an infinite loop.
    END				; Directive to signify end of code. This is optional but if present, all lines after this will be ignored by the assembler.