package data;


/**
 * Call containing the data processing methods.
 * 
 * @author Sonnino Alberto 
 * @version 1.0.1
 */
public class Process
{
    /**
     * Convert a signed decimal into a two's complement binary number.
     * 
     * @param  dec   the decimal number
     * @return       the String representation of the binary number
     */
    public static String dec2bin(int dec, int base, boolean bigEndian) 
    {
        // initialize variable
        String bin = "";
 
        // convert
        // NOTE: two's complement is automatically handled by the bitwise-AND operator
        for(int i=0; i < base; i++){
            bin = ( ((1 << i & dec) != 0) ? "1" : "0" ) + bin;
        }
        
        // consider endianness
        if(bigEndian){bin = new StringBuffer(bin).reverse().toString();}
        
        // return
        return bin;
    }
    
    /**
     *@param  x      the number to compute the log
     *@param  base   the base of the logarithm
     *@return        the log of x in the give base
     */
    public static int log(int x, int base){
        return (int) Math.ceil(Math.log(x) / Math.log(base));
    }
    
    /**
     * Test the method dec2bin.
     */ 
    public static void testDec2bin(){
        // declare variables
        int dec, base;
        boolean twosComplement, bigEndian;
        
        System.out.println(">>> Start test dec2bin:");
        
        // Test 1
        System.out.println("> Test 1:");
        dec  = 15;
        base = 8;
        bigEndian      = false;
        System.out.println(dec+" = "+dec2bin(dec,base,bigEndian));
        
        // Test 2
        System.out.println("> Test 2:");
        dec  = -8;
        base = 8;
        bigEndian      = false;
        System.out.println(dec+" = "+dec2bin(dec,base,bigEndian));
        
         // Test 3
        System.out.println("> Test 3:");
        dec  = 15;
        base = 8;
        bigEndian      = true;
        System.out.println(dec+"(bigendian) = "+dec2bin(dec,base,bigEndian));
        
        System.out.println(">>> End test dec2bin\n");
    }
}
