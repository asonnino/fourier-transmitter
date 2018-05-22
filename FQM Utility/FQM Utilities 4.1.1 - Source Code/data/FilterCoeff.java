package data;


/**
 * Class describing the Filter coefficients.
 * 
 * @author Alberto Sonnino 
 * @version 1.1.1
 */
public class FilterCoeff extends Generator
{
    private double[] H;
    private double   HMax;

    /**
     * Constructor for objects of class FilterCoeff
     */
    public FilterCoeff(int size)
    {
        // call constructor of supercalss
        super(size);
        
        // initialize instance variables
        this.H = new double[getSize()]; 
        setHMax(0); 
        
        // fill coefficients
        for(double h : H){h = 0;}
        updateHMax();
    }
    /**
     * Constructor for objects of class FilterCoeff
     */
    public FilterCoeff(int size, double[] H)
    {
        // call constructor of supercalss
        super(size);
        
        // initialize instance variables
        this.H = new double[Math.max(getSize(),H.length)]; 
        setHMax(0); 
        
        // fill coefficients
        // NOTE:
        // if size < H.length, retreive only the first 'size' coeff
        // if size > H.length, pad with zeros
        int minLength = Math.min(getSize(),H.length);
        for(int i=0; i < minLength; i++){
            this.H[i] = H[i];
        }
        for(int i=minLength; i < (minLength + getSize() - H.length); i++){
            this.H[i] = 0;
        }
        // update higest filter coeff
        updateHMax();
    }


    /**
     * @return     the filter coefficients 
     */
    public double[] getH()
    {
        return H;
    }
    /**
     * @param  H   the filter coefficients
     * @return     - 
     */
    public void setH(double[] H)
    {
       this.H = H;
    }
    
    /**
     * @return     the highest filter coefficients 
     */
    public double getHMax()
    {
        return HMax;
    }
    /**
     * @param  HMax   the highest filter coefficients
     * @return        - 
     */
    private void setHMax(double HMax)
    {
       this.HMax = HMax;
    }
    
    /**
     * Update the higest filter coefficient.
     * @return     - 
     */
    public void updateHMax()
    {
       setHMax(getH()[0]);
       for(int i=0; i < getSize(); i++){
           if(getH()[i] > getHMax()){setHMax(getH()[i]);}
       }
    }
    
    /**
     * @param  RescFactor   the rescale factor to apply
     * @return        - 
     */
    public void rescale(double RescFactor)
    {
       // rescale
       for(int i=0; i < getSize(); i++){
           getH()[i] =  getH()[i] * RescFactor;
       }
        
       // update the higest coefficient
       updateHMax();
       
       // update the rescale factor
       updateRescFactor(RescFactor);
    }
}
