class fifo_scoreboard extends uvm_scoreboard;
uvm_analysis_imp#(fifo_seq_item, fifo_scoreboard) item_got_export;
`uvm_component_utils(fifo_scoreboard)
  int counter;

  function new(string name = "fifo_scoreboard", uvm_component parent);
   super.new(name, parent);
   item_got_export = new("item_got_export", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
    int check_fifo[$];
  
  function void write(input fifo_seq_item item_got);
    bit [127:0] testdata;
    if(item_got.i_wren == 'b1)begin
      if(check_fifo.size < 1023) begin
        counter = counter++;
        check_fifo.push_back(item_got.i_wrdata);
        `uvm_info("write Data", $sformatf("write enable: %0b read enable: %0b write data: %0h full: %0b",item_got.i_wren, item_got.i_rden,item_got.i_wrdata, item_got.o_full), UVM_LOW);
      end
        else begin
          $display("--------REFERENCE FIFO IS FULL--------");

         //If assertion isn't present
          /*if(item.got.o_full == 1)
          $display("FULL condition is satisfied");
          else
          $display("FULL condition isn't satisfied");*/
        end
        
    end
      
    if (item_got.i_rden == 'b1)begin
      if(check_fifo.size() >= 'd1)begin
        counter = counter--;
        testdata = check_fifo.pop_front();
        
        `uvm_info("Read Data", $sformatf("testdata: %0h read data : %0h empty: %0b", testdata, item_got.i_rddata, item_got.o_empty), UVM_LOW);
        
        if(testdata == item_got.o_rddata)begin
          $display("--------MATCH SUCCESSFUL----------");
        end
          else begin
            $display("--------MATCH UNSUCCESSFUL--------");
          end
          
      end
        else begin
          $display("--------REFERENCE FIFO IS EMPTY--------");

        //If assertion isn't present
          /*if(item.got.o_empty == 1)
          $display("EMPTY condition is satisfied");
          else
          $display("EMPTY condition isn't satisfied");*/
        end
        
    end

    //If assertion isn't present
    /*if(counter >= 1020 && counter<1024)
    $display("ALMOST FULL condition is satisfied");
    else
    $display("ALMOST FULL condition isn't satisfied");
    if(counter <=)
    $display("ALMOST FULL condition is satisfied");
    else
    $display("ALMOST FULL condition isn't satisfied");*/

  endfunction

endclass
        
