include \masm32\include\masm32rt.inc
.data
    msgMenuP1 db "Bienvenido a ConverTec", 13, 10, \
    "Por favor indique que tipo de conversion desea realizar", 13, 10, \
    "Presione:", 13, 10, 0

    msgMenuP2 db "1. Fahrenheit a Celsius", 13, 10, \
    "2. Celsius a Fahrenheit", 13, 10, \
    "3. Kelvin a Celsius",13, 10, \
    "4. Celsius a Kelvin", 13, 10, \
    "5. Pulgadas a Centimetros", 13, 10, \
    "6. Pies a Centimetros", 13, 10, \
    "7. Yardas a Centimetros", 13, 10, \
    "8. Millas a Kilometros", 13, 10, 0

    msgMenuP3 db "9. Centimetros a Pulgadas", 13, 10, \
    "10. Centimetros a Pies", 13, 10, \
    "11. Centimetros a Yardas", 13, 10, \
    "12. Kilometros a Millas", 13, 10, \
    "13. Onzas a Kilos", 13, 10, \
    "14. Libras a Kilos", 13, 10, \
    "15. Toneladas a Kilos", 13, 10, \
    "16. Kilos a Onzas", 13, 10, \
    "17. Kilos a Libras", 13, 10, \
    "18. Kilos a Toneladas", 13, 10, \
    "Opcion: ", 0
    
    msgFahrenheit db "Ingrese la temperatura en Fahrenheit: ", 0
    msgCelsius db "Ingrese la temperatura en Celsius: ", 0
    msgKelvin db "Ingrese la temperatura en Kelvin: ", 0
    msgInches db "Ingrese la longitud en Pulgadas: " , 0
    msgFeet db "Ingrese la longitud en Pies: " , 0
    msgYardas db "Ingrese la longitud en Yardas: ", 0
    msgMillas db "Ingrese la distancia en Millas: ", 0
    msgCm     db "Ingrese la longitud en Centímetros: ", 0
    msgKm     db "Ingrese la distancia en Kilómetros: ", 0
    msgOnzas db "Ingrese el peso en Onzas: ", 0
    msgLibras db "Ingrese el peso en Libras: ", 0
    msgToneladas db "Ingrese el peso en Toneladas: ", 0
    msgKilos db "Ingrese el peso en Kilos: ", 0
    msgResultF db "Temperatura en Fahrenheit: ", 0
    msgResultC db "Temperatura en Celsius: ", 0
    msgResultK db "Temperatura en Kelvin: ", 0
    msgResultCm db "Longitud en Centímetros: ", 0
    msgResultKM db "Distancia en Kilómetros: ", 0
    msgResultIN db "Longitud en Pulgadas: ", 0
    msgResultFT db "Longitud en Pies: ", 0
    msgResultYD db "Longitud en Yardas: ", 0
    msgResultMI db "Distancia en Millas: ", 0
    msgResultKG db "Peso en Kilos: ", 0
    msgResultOZ db "Peso en Onzas: ", 0
    msgResultLB db "Peso en Libras: ", 0
    msgResultTN db "Peso en Toneladas: ", 0
    msgContinue db "Ingrese 1 para continuar o 2 para salir: ", 0
    msgError db "Error: Entrada invalida", 13, 10, 0
    inputBuffer db 20 dup(0)
    resultBuffer db 20 dup(0)
    tempBuffer dd 0
    CrLf db 13, 10, 0  
.code
; Declaración de prototipos
ParseDecimal proto :PTR BYTE, :PTR DWORD
FormatDecimal proto :DWORD, :DWORD

start:
    mainLoop:
        invoke StdOut, addr msgMenuP1
        invoke StdOut, addr msgMenuP2
        invoke StdOut, addr msgMenuP3
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
        cmp eax, 5
        je convertInchesToCm
        cmp eax, 6
        je convertFeetToCm
        invoke ExitProcess, 0

convertFtoC:
    invoke StdOut, addr msgFahrenheit
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke ParseDecimal, addr inputBuffer, addr tempBuffer
    jc invalidInput
    
    ; Conversión de Fahrenheit a Celsius (F - 32) * 5/9
    mov eax, tempBuffer
    sub eax, 3200     ; Restar 32.00
    imul eax, 5       ; Multiplicar por 5
    mov ebx, 9        ; Dividir por 9
    cdq
    idiv ebx
    
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultC
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertCtoF:
    invoke StdOut, addr msgCelsius
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke ParseDecimal, addr inputBuffer, addr tempBuffer
    jc invalidInput
    
    ; Conversión de Celsius a Fahrenheit (C * 9/5) + 32
    mov eax, tempBuffer
    imul eax, 9       ; Multiplicar por 9
    mov ebx, 5        ; Dividir por 5
    cdq
    idiv ebx
    add eax, 3200     ; Sumar 32.00
    
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultF
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertKtoC:
    invoke StdOut, addr msgKelvin
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke ParseDecimal, addr inputBuffer, addr tempBuffer
    jc invalidInput
    
    ; Conversión de Kelvin a Celsius (K - 273.15)
    mov eax, tempBuffer
    sub eax, 27315    ; Restar 273.15
    
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultC
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertCtoK:
    invoke StdOut, addr msgCelsius
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke ParseDecimal, addr inputBuffer, addr tempBuffer
    jc invalidInput
    
    ; Conversión de Celsius a Kelvin (C + 273.15)
    mov eax, tempBuffer
    add eax, 27315    ; Sumar 273.15
    
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultK
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertInchesToCm:
    invoke StdOut, addr msgInches
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke ParseDecimal, addr inputBuffer, addr tempBuffer
    jc invalidInput
    
    ; Conversión de pulgadas a centímetros (1 pulgada = 2.54 cm)
    mov eax, tempBuffer
    imul eax, 254     ; Multiplicar por 2.54
    mov ebx, 100      ; Dividir por 100 para manejar decimales
    cdq
    idiv ebx
    
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultCm
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop
    
convertFeetToCm:
    invoke StdOut, addr msgFeet
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke ParseDecimal, addr inputBuffer, addr tempBuffer
    jc invalidInput
    
    ; Conversión de pies a centímetros (1 pie = 30.48 cm)
    mov eax, tempBuffer
    imul eax, 3048    ; Multiplicar por 30.48
    mov ebx, 100      ; Dividir por 100 para manejar decimales
    cdq
    idiv ebx
    
    invoke FormatDecimal, eax, addr resultBuffer
    invoke StdOut, addr msgResultCm
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

invalidInput:
    invoke StdOut, addr msgError
    jmp mainLoop

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

ParseDecimal proc uses esi edi ebx, pInputStr:PTR BYTE, pResult:PTR DWORD
    local @tempValue:DWORD
    
    mov esi, pInputStr
    mov @tempValue, 0
    xor ebx, ebx    ; EBX será el valor entero
    xor edx, edx    ; EDX será el valor decimal
    xor ecx, ecx    ; Contador de decimales

    ; Saltar espacios iniciales
    .while byte ptr [esi] == ' '
        inc esi
    .endw

    ; Manejar signo si está presente
    mov al, byte ptr [esi]
    .if al == '-'
        mov ch, 1    ; Marcar como negativo
        inc esi
    .elseif al == '+'
        inc esi
    .endif

    ; Procesar parte entera
    .while byte ptr [esi] >= '0' && byte ptr [esi] <= '9'
        imul ebx, 10
        movzx eax, byte ptr [esi]
        sub eax, '0'
        add ebx, eax
        inc esi
    .endw

    ; Verificar si hay decimales
    .if byte ptr [esi] == '.'
        inc esi
        ; Procesar hasta 2 decimales
        .while byte ptr [esi] >= '0' && byte ptr [esi] <= '9' && ecx < 2
            imul edx, 10
            movzx eax, byte ptr [esi]
            sub eax, '0'
            add edx, eax
            inc esi
            inc ecx
        .endw

        ; Ajustar decimales a 2 lugares
        .while ecx < 2
            imul edx, 10
            inc ecx
        .endw
    .endif

    ; Combinar parte entera y decimal
    imul ebx, 100
    add ebx, edx

    ; Aplicar signo si es negativo
    .if ch == 1
        neg ebx
    .endif

    ; Guardar resultado
    mov edi, pResult
    mov [edi], ebx

    ; Verificar si la entrada es válida (al menos un dígito)
    .if ecx == 0 && ebx == 0
        stc    ; Establecer bandera de acarreo para indicar error
        ret
    .endif

    clc    ; Limpiar bandera de acarreo para indicar éxito
    ret
ParseDecimal endp

FormatDecimal proc uses esi edi, value:DWORD, buffer:DWORD
    mov esi, buffer
    mov eax, value
    
    ; Manejar números negativos
    .if SDWORD ptr eax < 0
        mov byte ptr [esi], '-'
        inc esi
        neg eax
    .endif
    
    ; Parte entera
    mov ebx, 100
    cdq
    div ebx
    
    ; Convertir parte entera
    push edx  ; Guardar decimales
    invoke dwtoa, eax, esi
    invoke lstrlen, esi
    mov ecx, eax
    add esi, ecx
    
    ; Agregar punto decimal
    mov byte ptr [esi], '.'
    inc esi
    
    ; Convertir decimales
    pop eax
    .if eax < 10
        mov byte ptr [esi], '0'
        inc esi
    .endif
    invoke dwtoa, eax, esi
    
    ret
FormatDecimal endp
end start
