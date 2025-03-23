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
    inputBuffer db 10 dup(0)
    resultBuffer db 10 dup(0)
    CrLf db 13, 10, 0  ; Nueva línea y retorno de carro
    five dword 5
    nine dword 9
    thirtyTwo dword 32

.code
start:
    mainLoop:
        ; Mostrar menú
        invoke StdOut, addr msgMenu
        invoke StdIn, addr inputBuffer, sizeof inputBuffer

        ; Convertir entrada a número
        invoke atodw, addr inputBuffer
        cmp eax, 1
        je convertFtoC
        cmp eax, 2
        je convertCtoF
        cmp eax, 3
        je convertKtoC
        cmp eax, 4
        je convertCtoK

        ; Si la opción no es válida, salir
        invoke ExitProcess, 0

convertFtoC:
    ; Pedir temperatura en Fahrenheit
    invoke StdOut, addr msgFahrenheit
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    mov eax, eax  ; EAX contiene Fahrenheit

    ; Fórmula: C = (F - 32) * 5 / 9
    sub eax, 32   ; Fahrenheit - 32
    imul eax, 5   ; Multiplicar por 5
    cdq           ; Extender signo para división
    idiv nine     ; Dividir por 9

    ; Convertir resultado a string
    invoke dwtoa, eax, addr resultBuffer

    ; Mostrar resultado
    invoke StdOut, addr msgResultC
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertCtoF:
    ; Pedir temperatura en Celsius
    invoke StdOut, addr msgCelsius
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    mov eax, eax  ; EAX contiene Celsius

    ; Fórmula: F = (C * 9) / 5 + 32
    imul eax, 9   ; Celsius * 9
    cdq           ; Extender signo para división
    idiv five     ; Dividir por 5
    add eax, 32   ; Sumar 32

    ; Convertir resultado a string
    invoke dwtoa, eax, addr resultBuffer

    ; Mostrar resultado
    invoke StdOut, addr msgResultF
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertKtoC:
    invoke StdOut, addr msgKelvin
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    mov eax, eax

    sub eax, 273

    invoke dwtoa, eax, addr resultBuffer
    invoke StdOut, addr msgResultC
    invoke StdOut, addr resultBuffer
    invoke StdOut, addr CrLf
    jmp continueLoop

convertCtoK:
    invoke StdOut, addr msgCelsius
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
    mov eax, eax

    add eax, 273

    invoke dwtoa, eax, addr resultBuffer
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


end start