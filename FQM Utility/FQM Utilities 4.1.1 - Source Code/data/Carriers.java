package data;


/**
 * Class describing the modulator carriers.
 * 
 * @author Sonnino Alberto
 * @version 1.1.1
 */
public class Carriers extends Generator
{
    private double frequency;
    private int    inputNumber;
    
    private double[] cosCarrier, sinCarrier;

    /**
     * Constructor for objects of class Carriers
     */
    public Carriers(double frequency, int inputNumber)
    {
        // call constructor of supercalss
        super();
        
        // initialize instance variables
        this.frequency   = (frequency   < 0) ? 0 : frequency;
        this.inputNumber = (inputNumber < 0) ? 0 : inputNumber;
        setSize(generateNumberOfSamples(getFrequency(), getInputNumber()));
        
        cosCarrier = new double[getSize()];
        sinCarrier = new double[getSize()];
        
        // generate carriers
        double period = 1 / getFrequency();            // carrier period
        double dt     = period / getNumberOfSamples(); // interval between samples
   
        for(int n=0; n < getSize(); n++){
            this.cosCarrier[n] = Math.cos(2 * Math.PI * getFrequency() * n * dt);
            this.sinCarrier[n] = Math.sin(2 * Math.PI * getFrequency() * n * dt);
        }
    }
    
    /**
     * @param  frequency     the carriers frequency
     * @param  inputNumber   the number of parallel inputs
     * @return               the number of samples
     */
    private int generateNumberOfSamples(double frequency, int inputNumber)
    {
        // compute number of samples to make it a multiple of inputNumber
        int numberOfSamples = 4 * (int)Math.round(frequency);
        for(int i=0; i < inputNumber; i++){
            if( numberOfSamples % inputNumber == 0 ){break;}
            numberOfSamples++;
        }
        
        // return
        return numberOfSamples;
    }
    
    /**
     * @return     the carrier's frequency
     */
    public double getFrequency()
    {
        return frequency;
    }
    
    /**
     * @return     the number of parallel inputs
     */
    public int getInputNumber()
    {
        return inputNumber;
    }
    
    /**
     * @return     the number of samples contained in the carriers
     */
    public int getNumberOfSamples()
    {
        return getSize();
    }
    
    /**
     * @return     the cos carrier 
     */
    public double[] getCosCarrier()
    {
        return cosCarrier;
    }
    /**
     * @param  cos   the cos carrier
     * @return       - 
     */
    public void setCosCarrier(double[] cosCarrier)
    {
       this.cosCarrier = cosCarrier;
    }
    
    /**
     * @return     the sin carrier 
     */
    public double[] getSinCarrier()
    {
        return sinCarrier;
    }
    /**
     * @param  sin   the sin carrier
     * @return       - 
     */
    public void setSin_carrier(double[] sinCarrier)
    {
       this.sinCarrier = sinCarrier;
    }
    
    /**
     * @param  RescFactor   the rescale factor to apply
     * @return        - 
     */
    public void rescale(double RescFactor)
    {
       // rescale
       for(int n=0; n < getSize(); n++){
           getCosCarrier()[n] = getCosCarrier()[n] * RescFactor;
           getSinCarrier()[n] = getSinCarrier()[n] * RescFactor;
       }
       
       // update the rescale factor
       updateRescFactor(RescFactor);
    }
}
