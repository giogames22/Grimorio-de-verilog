# Contador

Un contador es un circuito secuencial digital que se utiliza para contar el número de veces que ocurre un evento (generalmente los flancos de un reloj) o para generar una secuencia binaria específica.

<img width="3999" height="1472" alt="imagen_2025-11-28_204035727" src="https://github.com/user-attachments/assets/8b1e24a4-efd9-425a-b3dd-11ca1feaca33" />


```verilog
//contador ascendente
module contA(BCLK,BnRES,VAL);
	input BCLK; //delcaracion del reloj
	input BnRES; // declaracion del boton de reset
    output [3:0] VAL;//declaracion de las salidas del contador

  // Declaración de registros internos
    reg [3:0] VAL, nVAL;// VAL: Valor Actual (se almacena en el flip-flop)
	                    // nVAL: Próximo Valor (siguiente estado)

  //cambio con el flanco positivo del reloj o el positivo del reset
always @(posedge BCLK or posedge BnRES)
    if(BnRES==1) VAL=0; //si el boton reset vale 1 resetear a 0
    else VAL=nVAL; // si cambia clock y no reset val toma el valor de nval

always @(VAL)
    nVAL=VAL+1;// si cambia val  nval es igual al valor de val +1

endmodule
```
