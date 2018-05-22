package data;

/**
 * Class representing an exception.
 * This exception is used when trying to perform an operation that is not allowed.
 * 
 * @author Sonnino
 * @version 12.04
 */
public class ProgException extends Exception
{
    /**
    * Constructor for objects of class Exception
    */
   public ProgException(){
       super();
   }
   
   /**
    * Constructor for objects of class Exception
    * 
    * Make an exception with an error message
    */
   public ProgException(String message){
       super(message);
    }
}