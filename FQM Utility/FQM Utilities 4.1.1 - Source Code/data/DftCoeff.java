package data;


/**
 * Class describing the DFT coefficients.
 * 
 * @author Sonnino Alberto
 * @version 1.1.1
 */
public class DftCoeff extends Generator
{
    private double[][] ccos, csin;
    
    /**
     * Constructor for objects of class DftCoeff
     */
    public DftCoeff(int size)
    {
        // call constructor of supercalss
        super(size);
        
        // initialize instance variables
        ccos = new double[getSize()][getSize()];
        csin = new double[getSize()][getSize()];
        
        // generate sin and cos coefficients
        for(int k=0; k < size; k++){
            for(int n=0; n < size; n++){
                this.ccos[k][n] = Math.cos(2 * Math.PI * k * n / getSize());
                this.csin[k][n] = Math.sin(2 * Math.PI * k * n / getSize());
            }
        }
    }
    
    /**
     * @return     the cos coefficients 
     */
    public double[][] getCcos()
    {
        return ccos;
    }
    /**
     * @param  ccos   the cos FFT coefficients
     * @return        - 
     */
    public void setCcos(double[][] ccos)
    {
       this.ccos = ccos;
    }
    
    /**
     * @return     the sin coefficients 
     */
    public double[][] getCsin()
    {
        return csin;
    }
    /**
     * @param  csin   the cos FFT coefficients
     * @return        - 
     */
    public void setCsin(double[][] csin)
    {
       this.csin = csin;
    }

    /**
     * @param  RescFactor   the rescale factor to apply
     * @return        - 
     */
    public void rescale(double RescFactor)
    {
       // rescale
       for(int k=0; k < getSize(); k++){
           for(int n=0; n < getSize(); n++){
               getCcos()[k][n] = getCcos()[k][n] * RescFactor;
               getCsin()[k][n] = getCsin()[k][n] * RescFactor;
            }
       }
        
       // update the rescale factor
       updateRescFactor(RescFactor);
    }
}
