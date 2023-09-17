module GCD_controller(lda,ldb,sel1,sel2,selin,done,clk,lt,gt,eq,start);
  input clk,lt,gt,eq,start;
  output reg lda,ldb,sel1,sel2,selin,done;
  reg[15:0] state;
  
    parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100,S5=3'b101;
    always@(posedge clk)
    begin
      case(state)
        S0: if(start) state <= S1;
        S1: state <= S2;
        S2: if(eq) state <= S5;
          else if(lt) state <= S3;
          else if(gt) state <= S4;
        S3: if(eq) state <= S5;
          else if(lt) state <= S3;
          else if(gt) state <= S4;
        S4: if(eq) state <= S5;
            else if(lt) state <= S3;
            else if(gt) state <= S4;
        S5: state <= S5;
        default: state <= S0;
      endcase
    end
  
    always@(state)
    begin
      case(state)
        S0: begin
          selin = 1;
          lda = 1;
          ldb = 0;
          done = 0;
        end
        S1: begin 
          selin = 1;
          lda = 0;
          ldb = 1;
        end
        S2: if(eq) done = 1;
            else if(lt)
            begin
              sel1 = 1;
              sel2 = 0;
              selin = 0;
              lda = 0;
              ldb = 1;
            end
            else if(gt) 
            begin
              sel1 = 0;
              sel2 = 1;
              selin = 0;
              lda = 1;
              ldb = 0;
            end
        S3: if(eq) done = 1;
            else if(lt)
            begin
              sel1 = 1;
              sel2 = 0;
              selin = 0;
              lda = 0;
              ldb = 1;
            end
            else if(gt)
            begin
              sel1 = 0;
              sel2 = 1;
              selin = 0;
              lda = 1;
              ldb = 0;
            end
        S4: if(eq) done = 1;
            else if(lt)
            begin
              sel1 = 1;
              sel2 = 0;
              selin = 0;
              lda = 0; 
              ldb = 1;
            end
            else if(gt)
            begin
              sel1 = 0;
              sel2 = 1;
              selin = 0;
              lda = 1;
              ldb = 0;
            end
        S5: begin
              done = 1;
              sel1 = 0;
              sel2 = 0;
              lda = 0;
              ldb = 0;
        end
        default: begin 
              lda = 0;
              ldb = 0;
        end
      endcase
    end
endmodule
