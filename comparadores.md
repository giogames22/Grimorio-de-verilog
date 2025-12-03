# Comparadores 

```verilog
//comparador parametrico
module comparador #(parameter n = 10)(
  
  input [n-1:0]a,b,
  output BT, LT, EQ
  
);
  assign BT = a>b;
  assign LT = a<b;
  assign EQ = a==b;
  
endmodule
```
