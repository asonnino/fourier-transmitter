package data;

import java.io.PrintWriter;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 * Export DFT dftCoefficients.
 * 
 * @author Sonnino Alberto 
 * @version 1.1.1
 */
public class Export
{
    /**
     * Export DFT coefficients for Verilog
     * 
     * @param  dftCoeff   the DFT coefficient object to export
     * @param  precision  the data precision
     * @param  modulename the Verilog module name
     * @param  filepath   the file path and name where to export data
     * @return            - 
     */
    public static void exportForVerilog(DftCoeff dftCoeff, int precision, String modulename, String filepath) 
    throws ProgException {
        // compute the bus width
        int busWidth = dftCoeff.getSize()*dftCoeff.getSize()*precision;
        
        // export
        try{
            // open the printer
            PrintWriter pr = new PrintWriter(new BufferedWriter(new FileWriter(filepath)));
            
            
            // print file header
            pr.println("////////////////////////////////////////////////////////////");
            pr.println("// Auto-generated file - "+Const.NAME+" v"+Const.VERSION);
            pr.println("// Generated on "+getCurrentDate());
            pr.println("//");
            pr.println("//");
            pr.println("// Additional comments:");
            pr.println("// rescaling factor "+dftCoeff.getRescFactor());
            pr.println("////////////////////////////////////////////////////////////");
            pr.println("module "+modulename +"(");
            
            pr.println("\t output wire ["+(busWidth - 1)+":0] ccos,");
            pr.println("\t output wire ["+(busWidth - 1)+":0] csin");
            
            pr.println(");\n\n\n");
            
            
            // export ccos
            pr.print("assign ccos = "+busWidth+"'b");
            for(int i=0; i < dftCoeff.getSize(); i++){
                for(int j=0; j < dftCoeff.getSize(); j++){
                    pr.print(
                        Process.dec2bin((int) Math.round(dftCoeff.getCcos()[i][j]),precision,false)
                    );
                }
            }
            pr.println(";");
            // jump to next line
            pr.println("");
            // export csin
            pr.print("assign csin = "+busWidth+"'b");
            for(int i=0; i < dftCoeff.getSize(); i++){
                for(int j=0; j < dftCoeff.getSize(); j++){
                    pr.print(
                        Process.dec2bin((int) Math.round(dftCoeff.getCsin()[i][j]),precision,false)
                    );
                }
            }
            pr.println(";");
            
            
            // print footer
            pr.println("\n\n");
            pr.println("endmodule");
            
            
            // close the printer
            pr.close();
        }
        catch(SecurityException exc){throw new ProgException("Error: access to "+filepath+" refused");}
        catch(IOException exc){throw new ProgException("Error: unable to open file "+filepath);}
    }
    
    
    /**
     * Export carriers for Verilog
     * 
     * @param  filterCoeff the filter coefficients object to export
     * @param  precision   the data precision
     * @param  modulename  the Verilog module name
     * @param  filepath    the file path and name where to export data
     * @return             - 
     */
    public static void exportForVerilog(FilterCoeff filterCoeff, int precision, String modulename, String filepath) 
    throws ProgException {
        // compute the bus width
        int busWidth = filterCoeff.getSize()*precision;
        
        // export
        try{
            // open the printer
            PrintWriter pr = new PrintWriter(new BufferedWriter(new FileWriter(filepath)));
            
            
            // print file header
            pr.println("////////////////////////////////////////////////////////////");
            pr.println("// Auto-generated file - "+Const.NAME+" v"+Const.VERSION);
            pr.println("// Generated on "+getCurrentDate());
            pr.println("//");
            pr.println("//");
            pr.println("// Additional comments:");
            pr.println("// rescaling factor "+filterCoeff.getRescFactor());
            pr.println("////////////////////////////////////////////////////////////");
            pr.println("module "+modulename +"(");
            
            pr.println("\t output wire ["+(busWidth  - 1)+":0] H,");
            pr.println("\t output wire ["+(precision - 1)+":0]  H_max");
            
            pr.println(");\n\n\n");
            
            
            // export H
            pr.print("assign H = "+busWidth+"'b");
            for(int i=0; i < filterCoeff.getSize(); i++){
                pr.print(
                    Process.dec2bin((int) Math.round(filterCoeff.getH()[i]),precision,false)
                );
            }
            pr.println(";");
            // jump to next line
            pr.println("");
            // export HMax
            pr.print("assign H_max = "+precision+"'b");
            pr.print(
                Process.dec2bin((int) Math.round(filterCoeff.getHMax()),precision,false)
            );
            pr.println(";");
            
            
            // print footer
            pr.println("\n\n");
            pr.println("endmodule");
            
            
            // close the printer
            pr.close();
        }
        catch(SecurityException exc){throw new ProgException("Error: access to "+filepath+" refused");}
        catch(IOException exc){throw new ProgException("Error: unable to open file "+filepath);}
    }
    
    /**
     * Export carriers for Verilog
     * 
     * @param  carriers   the carriers object to export
     * @param  precision  the data precision
     * @param  modulename the Verilog module name
     * @param  filepath   the file path and name where to export data
     * @return            - 
     */
    public static void exportForVerilog(Carriers carriers, int precision, String modulename, String filepath) 
    throws ProgException {
        // compute the bus width
        int busWidth = carriers.getInputNumber()*precision;
        int sizeByN  = carriers.getSize() / carriers.getInputNumber();

        // export
        try{
            // open the printer
            PrintWriter pr = new PrintWriter(new BufferedWriter(new FileWriter(filepath)));
            
            
            // print file header
            pr.println("////////////////////////////////////////////////////////////");
            pr.println("// Auto-generated file - "+Const.NAME+" v"+Const.VERSION);
            pr.println("// Generated on "+getCurrentDate());
            pr.println("//");
            pr.println("//");
            pr.println("// Additional comments:");
            pr.println("// rescaling factor "+carriers.getRescFactor());
            pr.println("////////////////////////////////////////////////////////////");
            pr.println("module "+modulename +"#(");
            pr.println("\t samples = "+carriers.getSize());
            pr.println(") (");
            pr.println("\t input  wire         clk,");
            pr.println("\t input  wire         reset,");
            pr.println("\t output reg  ["+(busWidth - 1)+":0] cos,");
            pr.println("\t output reg  ["+(busWidth - 1)+":0] sin");
            pr.println(");\n\n\n");
            
            
            // initilize counter
            pr.print("// log2("+carriers.getSize()+" / "+carriers.getInputNumber()+") = ");
            pr.println(Process.log(sizeByN,2));
            pr.println("reg ["+(Process.log(sizeByN,2) - 1)+":0] count;");
            pr.println("\n\n");
            
            // export data
            pr.println("always@(posedge clk, posedge reset)");
            pr.println("\t if(reset | count == "+(sizeByN-1)+") count <= 'd0;" );
            pr.print("\t else count <= count + 'd1;");
            
            
            pr.println("\n\n");
            
            
            pr.println("always@(count, reset)");
            pr.println("\t case(count)");
            for(int i=0; i < sizeByN; i++){
                pr.println("\t\t "+Process.log(sizeByN,2)+"'d"+i+": begin");
                
                // print cos
                pr.print("\t\t\t cos = "+busWidth+"'b");
                for(int j=i*carriers.getInputNumber(); j < ((i+1)*carriers.getInputNumber()); j++){
                    pr.print(
                        Process.dec2bin((int) Math.round(carriers.getCosCarrier()[j]),precision,false)
                    );
                }
                pr.println(";");
                
                // print sin
                pr.print("\t\t\t sin = "+busWidth+"'b");
                for(int j=i*carriers.getInputNumber(); j < ((i+1)*carriers.getInputNumber()); j++){
                    pr.print(
                        Process.dec2bin((int) Math.round(carriers.getSinCarrier()[j]),precision,false)
                    );
                }
                pr.println(";");
                
                pr.println("\t\t end");
            }
            pr.println("\t endcase \n");

            
            // print footer
            pr.println("\n\n");
            pr.println("endmodule");
            
            
            // close the printer
            pr.close();
        }
        catch(SecurityException exc){throw new ProgException("Error: access to "+filepath+" refused");}
        catch(IOException exc){throw new ProgException("Error: unable to open file "+filepath);}
    }
    
    
    /**
     * Return the current date and time.
     * 
     * @return      the current date and time 
     */
    private static String getCurrentDate(){
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date date = new Date();
        return dateFormat.format(date); //example: 2014/08/06 15:59:48
    }
}
