import data.DftCoeff;
import data.Carriers;
import data.FilterCoeff;
import data.Const;
import data.Export;
import data.ProgException;

import view.GUI;

/**
 * Class containing the main method.
 * 
 * @author Sonnino Alberto 
 * @version 1.1.1
 */
public class Main
{
    /**
     * Main method
     * 
     * @param  args   generic input parameters
     * @return        - 
     */
    public static void main(String[] args)
    {
        new GUI();
    }
    
    /**
     * Run with default parameters
     */
    public static void runWithDefParameters()
    {
        /*
         * Declare variables
         */
        String modulename;
        String outputfile;
        
        
        
        /*
         * DFT coefficients
         */
        // output file
        modulename = Const.DEFAULT_DFT_MODULENAME;
        outputfile = modulename+Const.VERILOG_EXTENSION;

        // generate coefficients
        DftCoeff dftCoeff = new DftCoeff(Const.DEFAULT_DFT_SIZE);

        // rescale
        dftCoeff.rescale(Const.DEFAULT_DFT_RESC_FACTOR);
        
        // export
        try{Export.exportForVerilog(dftCoeff, Const.DEFAULT_PRECISION, modulename, outputfile);}
        catch(ProgException exc){System.err.println(exc.getMessage());}

        
        
        /*
         * Filter coefficients
         */
        // output file
        modulename = Const.DEFAULT_FILTER_MODULENAME;
        outputfile = modulename+Const.VERILOG_EXTENSION;
        
        // generate coefficients
        FilterCoeff filterCoeff = new FilterCoeff(Const.DEFAULT_FILTER_SIZE,Const.DEFAULT_FILTER_COEFF);
        
        // rescale
        filterCoeff.rescale(Const.DEFAULT_FILTER_RESC_FACTOR);
        
        // export
        try{Export.exportForVerilog(filterCoeff, Const.DEFAULT_PRECISION, modulename, outputfile);}
        catch(ProgException exc){System.err.println(exc.getMessage());}
        
        
        
        /*
         * Carriers
         */
        // output file
        modulename = Const.DEFAULT_CARRIERS_MODULENAME;
        outputfile = modulename+Const.VERILOG_EXTENSION;
        
        // generate coefficients
        Carriers carriers = new Carriers(Const.DEFAULT_CARRIERS_FREQUENCY, Const.DEFAULT_INPUT_NUMBER);

        // rescale
        carriers.rescale(Const.DEFAULT_CARRIERS_RESC_FACTOR);
        
        // export
        try{Export.exportForVerilog(carriers, Const.DEFAULT_PRECISION, modulename, outputfile);}
        catch(ProgException exc){System.err.println(exc.getMessage());}
    }
}
