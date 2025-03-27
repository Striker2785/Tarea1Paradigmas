.386
.model flat, stdcall
option casemap:none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\user32.lib

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
    msgOpcionInvalida db "Opcion invalida, seleccione un valor entre 1-18"
    msgCelsius db "Ingrese la temperatura en Celsius: ", 0
    msgKelvin db "Ingrese la temperatura en Kelvin: ", 0
    msgPulgadas db "Ingrese la longitud en Pulgadas: " , 0
    msgPies db "Ingrese la longitud en Pies: " , 0
    msgYardas db "Ingrese la longitud en Yardas: ", 0
    msgMillas db "Ingrese la distancia en Millas: ", 0
    msgCm     db "Ingrese la longitud en Centimetros: ", 0
    msgKm     db "Ingrese la distancia en Kilometros: ", 0
    msgOnzas db "Ingrese el peso en Onzas: ", 0
    msgLibras db "Ingrese el peso en Libras: ", 0
    msgToneladas db "Ingrese el peso en Toneladas: ", 0
    msgKilos db "Ingrese el peso en Kilos: ", 0
    msgResultF db "Temperatura en Fahrenheit: ", 0
    msgResultC db "Temperatura en Celsius: ", 0
    msgResultK db "Temperatura en Kelvin: ", 0
    msgResultCM db "Longitud en Centimetros: ", 0
    msgResultKM db "Distancia en Kilometros: ", 0
    msgResultIN db "Longitud en Pulgadas: ", 0
    msgResultFT db "Longitud en Pies: ", 0
    msgResultYD db "Longitud en Yardas: ", 0
    msgResultMI db "Distancia en Millas: ", 0
    msgResultKG db "Peso en Kilos: ", 0
    msgResultOZ db "Peso en Onzas: ", 0
    msgResultLB db "Peso en Libras: ", 0
    msgResultTN db "Peso en Toneladas: ", 0
    msgSaltoLinea db 13, 10, 0  ; Salto de l�nea
    msgContinue db "Ingrese 1 para continuar o 2 para salir: ", 0
    msgSalida db "Gracias por usar el programa de conversion. Presione enter para cerrar", 13, 10, 0
    buffer db 20 dup(0)
    inputBuffer db 20 dup(0)
    bufferResultado db 20 dup(0)
    opcionContinuar db 0
.data?
    tempCelsius REAL8 ?
    tempFahrenheit REAL8 ?
    pesoKilos REAL8 ?
    pesoLibras REAL8 ?
    conInputBuffer REAL8 ?
    conResultBuffer REAL8 ?
.code
main PROC
Inicio:
    invoke StdOut, addr msgMenuP1
    invoke StdOut, addr msgMenuP2
    invoke StdOut, addr msgMenuP3
    
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
   
    
    ; Verificar opci�n seleccionada usando el valor num�rico
    cmp eax, 1
    je convertFtoC
    cmp eax, 2
    je convertCtoF
    cmp eax, 3
    je convertKtoC
    cmp eax, 4
    je convertCtoK
    cmp eax, 5
    je convertPLGtoCM
    cmp eax, 6
    je convertFtToCm
    cmp eax, 7
    je convertYdToCm
    cmp eax, 8
    je convertMiToKm
    cmp eax, 9
    je convertCmToIn
    cmp eax, 10
    je convertCmToFt
    cmp eax, 11
    je convertCmToYd
    cmp eax, 12
    je convertKmToMi
    cmp eax, 13
    je convertOzToKg
    cmp eax, 14
    je convertLbToKg
    cmp eax, 15
    je convertTnToKg
    cmp eax, 16
    je convertKgToOz
    cmp eax, 17
    je convertKGtoLB
    cmp eax, 18
    je convertKgToTn
         
    ; Si la opci�n no es v�lida
    invoke StdOut, addr msgOpcionInvalida
    jmp Inicio

convertFtoC:

    invoke StdOut, addr msgFahrenheit
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr tempFahrenheit

    fld tempFahrenheit
    fsub real8 ptr [constanteTemp]
    fmul real8 ptr [multiplicadorFar]
    fstp tempCelsius

    invoke FloatToStr, tempCelsius, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertCtoF:
    ; Mostrar mensaje de entrada para temperatura
    invoke StdOut, addr msgCelsius
    
    ; Leer entrada del usuario
    invoke StdIn, addr buffer, 20
    
    ; Convertir cadena a n�mero de punto flotante
    invoke StrToFloat, addr buffer, addr tempCelsius
    
    ; Conversi�n de Celsius a Fahrenheit: (C * 9/5) + 32
    fld tempCelsius        ; Cargar temperatura Celsius
    fmul real8 ptr [multiplicadorTemp]  ; Multiplicar por 9/5
    fadd real8 ptr [constanteTemp]      ; Sumar 32
    fstp tempFahrenheit    ; Guardar resultado
    
    ; Mostrar mensaje de salida para temperatura
    invoke StdOut, addr msgResultF
    
    ; Convertir resultado a cadena con formato
    invoke FloatToStr, tempFahrenheit, addr bufferResultado
    
    ; Mostrar resultado de temperatura
    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar


convertKtoC:

    invoke StdOut, addr msgKelvin
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fsub real8 ptr [constantK]
    fstp conResultBuffer

    invoke StdOut, addr msgResultK

    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar


convertCtoK:

    invoke StdOut, addr msgCelsius
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fadd real8 ptr [constantK]
    fstp conResultBuffer

    invoke StdOut, addr msgResultC
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertPLGtoCM:

    invoke StdOut, addr msgPulgadas
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [inToCmFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultCM
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertFtToCm:

    invoke StdOut, addr msgPies
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [ftToCmFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultCM
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertYdToCm:

    invoke StdOut, addr msgYardas
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [ydsToCmFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultCM
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertMiToKm:

    invoke StdOut, addr msgMillas
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [miToKmFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultKM
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertCmToIn:

    invoke StdOut, addr msgCm
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [cmToInFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultIN
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertCmToFt:

    invoke StdOut, addr msgCm
    invoke StdIn, addr buffer, 50
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [cmToFtFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultFT
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertCmToYd:

    invoke StdOut, addr msgCm
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [cmToYdFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultYD
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar   

convertKmToMi:

    invoke StdOut, addr msgKm
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [kmToMiFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultMI
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertOzToKg:

    invoke StdOut, addr msgOnzas
    invoke StdIn, addr buffer, 20
    invoke StrToFloat ,addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [ozToKgFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultOZ
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertLbToKg:

    invoke StdOut, addr msgLibras
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [lbToKgFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultKG
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertTnToKg:

    invoke StdOut, addr msgToneladas
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [tnToKgFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultKG
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertKgToOz:

    invoke StdOut, addr msgKilos
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [kgToOzFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultOZ
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar                    

convertKGtoLB:
    invoke StdOut, addr msgKilos
    
    invoke StdIn, addr buffer, 20
    
    invoke StrToFloat, addr buffer, addr pesoKilos
    
    fld pesoKilos          ; Cargar peso en Kilos
    fmul real8 ptr [multiplicadorKGLB]  ; Multiplicar por factor de conversi�n
    fstp pesoLibras        ; Guardar resultado
    
    invoke StdOut, addr msgResultKG
    
    invoke FloatToStr, pesoLibras, addr bufferResultado
    
    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar

convertKgToTn:

    invoke StdOut, addr msgKilos
    invoke StdIn, addr buffer, 20
    invoke StrToFloat, addr buffer, addr conInputBuffer

    fld conInputBuffer
    fmul real8 ptr [kgToTnFactor]
    fstp conResultBuffer

    invoke StdOut, addr msgResultTN
    invoke FloatToStr, conResultBuffer, addr bufferResultado

    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    jmp Continuar    
    

Continuar:
    ; Preguntar si desea continuar
    invoke StdOut, addr msgContinue
    
    ; Leer opci�n de continuaci�n
    invoke StdIn, addr buffer, 20
    mov al, byte ptr [buffer]
    mov [opcionContinuar], al
    
    ; Verificar opci�n de continuaci�n
    cmp [opcionContinuar], '1'
    je Inicio
    cmp [opcionContinuar], '2'
    je Salir
    
    

Salir:
    ; Salir si no desea continuar
    invoke StdOut, addr msgSalida
    
    ; Esperar entrada antes de salir
    invoke StdIn, addr buffer, 1
    
    ; Salir del programa
    invoke ExitProcess, 0
main ENDP

.data
    ; Factores de conversion temperatura
    multiplicadorTemp REAL8 1.8   ; 9/5
    multiplicadorFar REAL8 0.55
    constantK REAL8 273.15
    constanteTemp REAL8 32.0      ; Constante de conversi�n de temperatura

    ; Factores de conversion peso
    multiplicadorKGLB REAL8 2.20462  ; Factor de conversi�n de Kilos a Libras
    ozToKgFactor REAL8 0.02835
    lbToKgFactor REAL8 0.45359
    tnToKgFactor REAL8 1000.00
    kgToOzFactor REAL8 35.27
    kgToTnFactor REAL8 0.001

    ; Factores de conversion longitud
    inToCmFactor REAL8 2.540
    ftToCmFactor REAL8 30.48
    ydsToCmFactor REAL8 91.44
    miToKmFactor REAL8 1.60934
    cmToInFactor REAL8 0.393701
    cmToFtFactor REAL8 0.0328084
    cmToYdFactor REAL8 0.0109361
    kmToMiFactor REAL8 0.621371

END main
