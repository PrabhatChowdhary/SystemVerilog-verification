class sender;
 
  	mailbox	names; 	
  
	task send ();
		for (int i = 0; i < 3; i++) begin
			
          #1 $display ("[%0t] sender: Put %0d", $time, i);
          names.put(i);     
		end
	endtask
endclass

class receiver;
  
	mailbox	list;
  
	task receive ();
		forever begin
			int i;
          list.get(i);
          $display ("[%0t]    receiver: Got %0d", $time, i);
		end
	endtask
endclass


module tb;
  	
  	mailbox	m    = new();
  sender	s  = new();
  	receiver 	r  = new();
  
  	initial begin
//both class variables will be referenced to same class object m
      s.names = m;
      r.list = m;

      
      fork
      	s.send();
        r.receive();
      join
    end
endmodule
