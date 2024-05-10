//Samples the interface output signals, captures the transaction packet 
//and sends the packet to scoreboard.

class monitor_out;
  
  //create virtual interface handle
  virtual inf vinf;
  
  //create mailbox handle
  mailbox mon2scbout;
  
  //constructor
  function new(virtual inf vinf,mailbox mon2scbout);
    //get the interface
    this.vinf = vinf;
    //get the mailbox handle from environment 
    this.mon2scbout = mon2scbout;
  endfunction
  
  //Samples the interface signal and sends the sampled packet to scoreboard
  task main;
    forever begin
      transaction trans;
      trans = new();
      @(negedge vinf.clk);

      trans.data_out = vinf.data_out;
      trans.full = vinf.full; 
      trans.empty = vinf.empty; 
      
      trans.display_out("[ --Monitor_out-- ]");
      mon2scbout.put(trans);
      @(posedge vinf.clk);

    end
  endtask
  
endclass