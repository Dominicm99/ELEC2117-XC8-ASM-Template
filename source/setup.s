    ; 16F866 setup for ELEC2117, updated for pic-as (XC8 assembler)
    ; allowing use with latest version of MPLAB X (v6.00 at time of writing)
    ; There are minor differences between MPLAB's MPASM and MPLABX's pic-as
    ; these can be found in Microchip document DS-50002973A
    ; Dominic McAuley z5208099, T3 2022
    
    TITLE	"Insert Program Title String Here"
    SUBTITLE	"Insert Program Subtitle String Here"
    PROCESSOR	16f886			; ELEC2117 uses the PIC16F886

    ; Config for pic-as is different to MPLAB v8.XX, this is using same settings.
    ; Config defines can be found in the DFP directory created when installing XC8
    ; C:/Program Files/Microchip/MPLABX/v6.00/packs/Microchip/PIC16Fxxx_DFP/1.3.42/xc8/docs/chips/16f886.html
    ; These can also be generated with the MPLAB X tool (Production > Set Configuration Bits)
    
    ; CONFIG1 Defines (DS40001291H-page 206)
    CONFIG FOSC	    = INTRC_NOCLKOUT	; Use internal RC, lets RA7 be used as GPIO
    CONFIG WDTE	    = OFF		; Watchdog timer disabled
    CONFIG PWRTE    = OFF		; Power-up Timer disabled
    CONFIG MCLRE    = ON		; Use RE3 (Pin 1) as MCLR pin
    CONFIG CP	    = OFF		; Program memory code protection disabled
    CONFIG CPD	    = OFF		; Data memory code protection disabled
    CONFIG BOREN    = OFF		; Brown out reset disabled
    CONFIG IESO	    = OFF		; Disable fast switchover to external osc
    CONFIG FCMEN    = ON		; Clock monitor enabled, (but not useful for INTRC)
    CONFIG LVP	    = OFF		; Allows RB3 (Pin 24) to be used as a GPIO
    CONFIG DEBUG    = ON		; Allow RB6/7 (Pin 39,40) for debug thru PICkit
    
    ; CONFIG2 Defines (DS40001291H-page 207)x
    CONFIG BOR4V    = BOR21V		; Set Brownout reset threshold to 2.1V (unused due to BOREN)
    CONFIG WRT	    = OFF		; Disable Flash Program memory write protection    
    
    
    
; Define a section of data that can be accessed from any bank. For PIC16F886, only 8 bytes can do this.
; Make these registers availabe to other .s files
GLOBAL WREG_CTX
GLOBAL STATUS_CTX
GLOBAL PCLATH_CTX
GLOBAL FSR_CTX

; Setting the PSECT class to COMMON indicates to the linker to store this data
; in 0x70 to 0x7F (Bank 0), which is also accessable from banks 1-3. 
PSECT global_vars, space=1, class=COMMON 
WREG_CTX:   DS	1   ; Reserve a byte for the context saved Working Register for the interrupt routine.
STATUS_CTX: DS	1   ; Reserve a byte for the context saved Status Register for the interrupt routine.
PCLATH_CTX: DS	1   ; Reserve a byte for the context saved Program Counter Latch High Register for the interrupt routine.
FSR_CTX:    DS	1   ; Reserve a byte for the context saved File Select Register for the interrupt routine.