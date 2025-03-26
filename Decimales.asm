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
    msgCm     db "Ingrese la longitud en Cent�metros: ", 0
    msgKm     db "Ingrese la distancia en Kil�metros: ", 0
    msgOnzas db "Ingrese el peso en Onzas: ", 0
    msgLibras db "Ingrese el peso en Libras: ", 0
    msgToneladas db "Ingrese el peso en Toneladas: ", 0
    msgKilos db "Ingrese el peso en Kilos: ", 0
    msgResultF db "Temperatura en Fahrenheit: ", 0
    msgResultC db "Temperatura en Celsius: ", 0
    msgResultK db "Temperatura en Kelvin: ", 0
    msgResultCM db "Longitud en Cent�metros: ", 0
    msgResultKM db "Distancia en Kil�metros: ", 0
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
.code
main PROC
Inicio:
    invoke StdOut, addr msgMenuP1
    invoke StdOut, addr msgMenuP2
    invoke StdOut, addr msgMenuP3
    
    invoke StdIn, addr inputBuffer, sizeof inputBuffer
    invoke atodw, addr inputBuffer
   
    
    ; Verificar opci�n seleccionada usando el valor num�rico
    cmp eax, 2
    je CtoF
    cmp eax, 17
    je KGtoLB
    
    ; Si la opci�n no es v�lida
    invoke StdOut, addr msgOpcionInvalida
    jmp Inicio

CtoF:
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

KGtoLB:
    ; Mostrar mensaje de entrada para peso
    invoke StdOut, addr msgKilos
    
    ; Leer entrada del usuario para peso
    invoke StdIn, addr buffer, 20
    
    ; Convertir cadena a n�mero de punto flotante
    invoke StrToFloat, addr buffer, addr pesoKilos
    
    ; Conversi�n de Kilos a Libras: Kilos * 2.20462
    fld pesoKilos          ; Cargar peso en Kilos
    fmul real8 ptr [multiplicadorKGLB]  ; Multiplicar por factor de conversi�n
    fstp pesoLibras        ; Guardar resultado
    
    ; Mostrar mensaje de salida para peso
    invoke StdOut, addr msgResultKG
    
    ; Convertir resultado a cadena con formato
    invoke FloatToStr, pesoLibras, addr bufferResultado
    
    ; Mostrar resultado de peso
    invoke StdOut, addr bufferResultado
    invoke StdOut, addr msgSaltoLinea
    

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
    multiplicadorTemp REAL8 1.8   ; 9/5
    constanteTemp REAL8 32.0      ; Constante de conversi�n de temperatura
    multiplicadorKGLB REAL8 2.20462  ; Factor de conversi�n de Kilos a Libras
    
END main