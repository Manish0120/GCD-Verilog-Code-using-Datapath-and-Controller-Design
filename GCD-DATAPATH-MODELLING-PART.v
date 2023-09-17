module GCD_datapath(lt,gt,eq,lda,ldb,sel1,sel2,data_in,selin,clk);
  input lda,ldb,sel1,sel2,selin,clk;
  input[15:0] data_in;
  output lt,gt,eq;
  wire[15:0] Aout,Bout,X,Y,bus,subout;
    PIPO A(Aout,lda,bus,clk);
    PIPO B(Bout,ldb,bus,clk);
    mux mux1(X,Aout,Bout,sel1);
    mux mux2(Y,Aout,Bout,sel2);
    mux mux3(bus,subout,data_in,selin);
    SUB S(subout,X,Y);
    COMP C(lt,gt,eq,Aout,Bout);
endmodule

module PIPO(dout,ld,din,clk);
  input[15:0] din;
  output reg[15:0] dout;
  input ld,clk;
    always@(posedge clk)
    if(ld)
    dout <= din;
endmodule

module mux(out,in0,in1,sel);
  input sel;
  input[15:0] in0,in1;
  output[15:0] out;
    assign out = (sel) ? in1:in0;
endmodule

module SUB(out,in1,in2);
  input[15:0] in1,in2;
  output reg[15:0] out;
    always@(*)
    out <= in1-in2;
endmodule

module COMP(lt,gt,eq,Aout,Bout);
  input[15:0] Aout,Bout;
  output lt,gt,eq;
    assign lt = Aout<Bout;
    assign gt = Aout>Bout;
    assign eq = Aout==Bout;
endmodule
