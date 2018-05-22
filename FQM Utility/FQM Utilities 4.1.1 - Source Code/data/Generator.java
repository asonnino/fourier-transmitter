package data;


/**
 * Abstract class Generator - Ground of all coefficients-generator class
 * 
 * @author Alberto Sonnino
 * @version 4.0.1
 */
public abstract class Generator
{
    protected int    size;
    protected double RescFactor;
    
    public Generator(int size){
        // initialize instance variables
        setSize(size);
        this.RescFactor = 1;
    }
    
    public Generator(){
        // initialize instance variables
        setSize(0);
        this.RescFactor = 1;
    }

    /**
     * @return     the size of the transform 
     */
    public int getSize()
    {
        return size;
    }
    /**
     * @param  size    the new size 
     * @return   -
     */
    public void setSize(int size)
    {
        this.size = (size < 0) ? 0 : size;
    }
    
    /**
     * @return     the rescale factor 
     */
    public double getRescFactor()
    {
        return RescFactor;
    }
    /**
     * @param  RescFactor   the rescale factor to apply
     * @return        - 
     */
    public abstract void rescale(double RescFactor);
    
    /**
     * @param  RescFactor   the applied rescale factor
     * @return        - 
     */
    protected void updateRescFactor(double newRescFactor){
       this.RescFactor = this.RescFactor * newRescFactor;
    }
}
