include \masm32\include\masm32rt.inc

.data 
    msgMenu db "Bienvenido a ConverTec", 13, 10, "Por favor indique que tipo de conversion desea realizar", 13, 10,
     "Presione:", 13, 10, "1. Fahrenheit a Celsius", 13, 10, "2. Celsius a Fahrenheit", 13, 10, "3. Kelvin a Celsius",
    13, 10, "4. Celsius a Kelvin", 13, 10, "13. Onzas a Kilos", 13, 10, "14. Libras a Kilos", 13, 10, "15. Toneladas a Kilos",
     13, 10, "16. Kilos a Onzas", 13, 10, "17. Kilos a Libras", 13, 10, "18. Kilos a Toneladas", 13, 10, "Opcion: ", 0
    msgFahrenheit db "Ingrese la temperatura en Fahrenheit: ", 0
    msgCelsius db "Ingrese la temperatura en Celsius: ", 0
    msgKelvin db "Ingrese la temperatura en Kelvin: ", 0
    msgOnzas db "Ingrese el peso en Onzas: ", 0
    msgLibras db "Ingrese el peso en Libras: ", 0
    msgToneladas db "Ingrese el peso en Toneladas: ", 0
    msgKilos db "Ingrese el peso en Kilos: ", 0
    msgResultF db "Temperatura en Fahrenheit: ", 0
    msgResultC db "Temperatura en Celsius: ", 0
    msgResultK db "Temperatura en Kelvin: ", 0
    msgResultKG db "Peso en Kilos: ", 0
    msgResultOZ db "Peso en Onzas: ", 0
    msgResultLB db "Peso en Libras: ", 0
    msgResultTN db "Peso en Toneladas: ", 0
    msgContinue db "Ingrese 1 para continuar o 2 para salir: ", 0
    inputBuffer db 20 dup(0)
    resultBuffer db 20 dup(0)
    tempBuffer db 20 dup(0)
    CrLf db 13, 10, 0  
    five dword 500
    nine dword 900
    thirtyTwo dword 3200
    scaleFactor dword 100
    
    ; Factores de conversión para pesos
    ozToKgFactor dword 2835    ; 1 onza = 0.02835 kg (2835/100000)
    lbToKgFactor dword 45359   ; 1 libra = 0.45359 kg (45359/100000)
    tnToKgFactor dword 100000  ; 1 tonelada = 1000 kg (100000/100)
    kgToOzFactor dword 3527    ; 1 kg = 35.27 oz (3527/100)
    kgToLbFactor dword 2205    ; 1 kg = 2.205 lb (2205/1000)
    kgToTnFactor dword 1000    ; 1 kg = 0.001 toneladas (1/1000)

.code
FormatDecimal proto :DWORD, :DWORD
start:
    mainLoop:
        invoke StdOut, addr msgMenu
        invoke StdIn, addr inputBuffer, sizeof inputBuffer
        invoke atodw, addr inputBuffer
        cmp eax, 1
        je convertFtoC
        cmp eax, 2
        je convertCtoF
        cmp eax, 3
        je convertKtoC
        cmp eax, 4
        je convertCtoK
        cmp eax, 13
        je convertOZtoKG
        cmp eax, 14
        je convertLBtoKG
        cmp eax, 15
        je convertTNtoKG
        cmp eax, 16
        je convertKGtoOZ
        cmp eax, 17
        je convertKGtoLB
        cmp eax, 18
        je convertKGtoTN
        invoke ExitProcess, 0

convertFtoC:
    invoke StdOut, addr msgFahrenheit
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    imul eax, 100
    sub eax, thirtyTwo   
    imul eax, five   
    cdq           
    idiv nine     
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultC
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertCtoF:
    invoke StdOut, addr msgCelsius
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    imul eax, 100
    imul eax, nine   
    cdq           
    idiv five     
    add eax, thirtyTwo   
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultF
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertKtoC:
    invoke StdOut, addr msgKelvin
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    imul eax, 100
    sub eax, 27300
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultC
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertCtoK:
    invoke StdOut, addr msgCelsius
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    imul eax, 100
    add eax, 27300
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultK
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertOZtoKG:
    invoke StdOut, addr msgOnzas
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    imul eax, ozToKgFactor
    mov ebx, 100000
    cdq
    idiv ebx
    mov ecx, eax
    mov eax, edx
    imul eax, 100
    cdq
    idiv ebx
    mov edx, eax
    mov eax, ecx
    imul eax, 100     
    add eax, edx
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultKG
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertLBtoKG:
    invoke StdOut, addr msgLibras
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    imul eax, lbToKgFactor
    mov ebx, 100000
    cdq
    idiv ebx
    mov ecx, eax
    mov eax, edx
    imul eax, 100
    cdq
    idiv ebx
    mov edx, eax
    mov eax, ecx
    imul eax, 100
    add eax, edx
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultKG
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertTNtoKG:
    invoke StdOut, addr msgToneladas
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    imul eax, tnToKgFactor
    mov ebx, 100
    cdq
    idiv ebx
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultKG
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertKGtoOZ:
    invoke StdOut, addr msgKilos
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    imul eax, kgToOzFactor
    mov ebx, 100
    cdq
    idiv ebx
    mov ecx, eax
    mov eax, edx
    imul eax, 100
    cdq
    idiv ebx
    mov edx, eax
    mov eax, ecx
    imul eax, 100
    add eax, edx
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultOZ
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertKGtoLB:
    invoke StdOut, addr msgKilos
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    imul eax, kgToLbFactor
    mov ebx, 1000
    cdq
    idiv ebx
    mov ecx, eax
    mov eax, edx
    imul eax, 100
    cdq
    idiv ebx
    mov edx, eax
    mov eax, ecx
    imul eax, 100
    add eax, edx
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultLB
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertKGtoTN:
    invoke StdOut, addr msgKilos
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    mov ebx, kgToTnFactor
    cdq
    idiv ebx
    mov ecx, eax
    mov eax, edx
    imul eax, 100
    cdq
    idiv ebx
    mov edx, eax
    mov eax, ecx
    imul eax, 100
    add eax, edx
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultTN
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop
    
continueLoop:
    invoke StdOut, addr msgContinue
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    cmp eax, 1
    je mainLoop
    cmp eax, 2
    je exitProgram
    jmp continueLoop

exitProgram:
    invoke ExitProcess, 0


FormatDecimal proc uses esi edi, value:DWORD, buffer:DWORD
    mov esi, buffer
    mov eax, value
    cdq
    idiv scaleFactor
    push edx
    invoke dwtoa, eax, esi
    invoke lstrlen, esi
    mov ecx, eax
    add esi, ecx
    mov byte ptr [esi], '.'
    inc esi
    pop eax
    cmp eax, 10
    jge no_pad_zero
    mov byte ptr [esi], '0'
    inc esi
    
no_pad_zero:
    invoke dwtoa, eax, esi
    ret
FormatDecimal endp

end start