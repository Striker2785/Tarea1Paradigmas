include \masm32\include\masm32rt.inc

.data 
    msgMenu db "Bienvenido a ConverTec", 13, 10, "Por favor indique que tipo de conversion desea realizar", 13, 10,
     "Presione:", 13, 10, "1. Fahrenheit a Celsius", 13, 10, "2. Celsius a Fahrenheit", 13, 10, "3. Kelvin a Celsius",
    13, 10, "4. Celsius a Kelvin", 13, 10, "Opcion: ", 0
    msgFahrenheit db "Ingrese la temperatura en Fahrenheit: ", 0
    msgCelsius db "Ingrese la temperatura en Celsius: ", 0
    msgKelvin db "Ingrese la temperatura en Kelvin: ", 0
    msgResultF db "Temperatura en Fahrenheit: ", 0
    msgResultC db "Temperatura en Celsius: ", 0
    msgResultK db "Temperatura en Kelvin: ", 0
    msgContinue db "Ingrese 1 para continuar o 2 para salir: ", 0
    inputBuffer db 20 dup(0)
    resultBuffer db 20 dup(0)
    tempBuffer db 20 dup(0)
    CrLf db 13, 10, 0  
    five dword 500
    nine dword 900
    thirtyTwo dword 3200
    scaleFactor dword 100

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

; Subrutina para formatear un número con dos decimales
FormatDecimal proc uses esi edi, value:DWORD, buffer:DWORD
    mov esi, buffer
    mov eax, value
    cdq
    idiv scaleFactor
    push edx  ; Guardar los dos últimos dígitos
    invoke dwtoa, eax, esi
    invoke lstrlen, esi
    mov ecx, eax
    add esi, ecx
    mov byte ptr [esi], '.'
    inc esi
    pop eax
    invoke dwtoa, eax, esi
    ret
FormatDecimal endp

end start
