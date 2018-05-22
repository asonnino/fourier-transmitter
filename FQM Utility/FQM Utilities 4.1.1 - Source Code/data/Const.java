package data;


/**
 * Class containing the global constant fields.
 * 
 * @author Sonnino Alberto 
 * @version 1.1.1
 */
public class Const
{
    // general constants
    public static final String NAME    = "FQM Utility";
    public static final String VERSION = "4.1.1";
    public static final String AUTHOR  = "Sonnino Alberto";
    
    
    // default general parameters
    public static final String VERILOG_EXTENSION = ".v";
    public static final int    DEFAULT_PRECISION = 16;
    
    // default DFT parameters
    public static final String DEFAULT_DFT_MODULENAME  = "dft_coeff";
    public static final int    DEFAULT_DFT_SIZE        = 16;
    public static final double DEFAULT_DFT_RESC_FACTOR = Math.pow(2,14);
    
    // default filter parameters
    public static final String   DEFAULT_FILTER_MODULENAME  = "filter_coeff";
    public static final int      DEFAULT_FILTER_SIZE        = 16;
    public static final double   DEFAULT_FILTER_RESC_FACTOR = Math.pow(2,15);
    public static final double[] DEFAULT_FILTER_COEFF       = {
         0.022507907903927645,
         0.028298439380057477,
        -0.076801948979409798,
        -0.037500771921555154,
         0.3076724792547561,
         0.54098593171027443,
         0.3076724792547561,
        -0.037500771921555154,
        -0.076801948979409798,
         0.028298439380057477,
         0.022507907903927645,
    };
    
    // default carriers parameters
    public static final String DEFAULT_CARRIERS_MODULENAME  = "carriers";
    public static final int    DEFAULT_INPUT_NUMBER         = 16;
    public static final double DEFAULT_CARRIERS_FREQUENCY   = 100; // Hertz
    public static final double DEFAULT_CARRIERS_RESC_FACTOR = Math.pow(2,14);
}
