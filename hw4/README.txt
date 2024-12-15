PROBLEM 1) BOOTH ENCODING MULTIPLICATION

      multiplicand        aaaa  
        multiplier x      bbbb x
    ----------------    --------
           product

    radix 4 booth's encoding

    NUM_PARTIALS = (N+1)/2
    for i in range {0, 1, ..., NUM_PARTIALS-1}

    x(2i+1) x(2i) x(2i-1) | i-th partial product
                     000  |   0 << 2i
                     001  |  +A << 2i
                     010  |  +A << 2i
                     011  | +2A << 2i
                     100  | -2A << 2i
                     101  |  -A << 2i
                     110  |  -A << 2i
                     111  |   0 << 2i

    example: 
          A = 24, B = 15
          A * B = 360
     
          B = 00001111
        
          A = 00011000
         2A = 00110000
        -2A = 11010000
         -A = 11101000

    calculating partial products:

        i = 1
               011000|
            00|001111|0
            -----------
                   ^^ ^
                   11 0 => -A << 0
               
        
        i = 2
               011000|
            00|001111|0
            -----------
                 ^^^
                 111    => +0 << 2
           
        
        i = 3
               011000|
            00|001111|0
            -----------
               ^^^
               001      => +A << 4
        
        
        i = 4
               011000|
            00|001111|0
            -----------
            ^^ ^
            00 0        => +0 << 6

    partial products:
        i = 1:   -A << 0  =  000000|11101000
        i = 2:   +0 << 2  =  000000|00000000 +
        i = 3:   +A << 4  =  000001|10000000 +
        i = 4:   +0 << 6  =  000000|00000000 + 
        --------------------------------------
                             000010|01101000 = 360 = 24 * 15

PROBLEM 2) MEMORY MODELLING:
    - refer to src/ for verilog modules
    - refer to verif/ for testbench
    - Screenshots of testbench waveform as .png files
    - refer to xsim_11296.backup.log for test case printouts
    - RTL schematics as .pdf files
