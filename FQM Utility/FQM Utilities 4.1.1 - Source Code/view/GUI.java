package view;

import data.*;

import java.awt.Dimension;
import java.awt.Color;
import java.awt.Font;
import java.awt.BorderLayout;
import java.awt.Cursor;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

import javax.swing.JFrame;
import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.JTabbedPane;
import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.BorderFactory;


/**
 * Main GUI.
 * 
 * @author Sonnino 
 * @version 2.0.1
 */
public class GUI extends JFrame
{
    // parameters
    public static final int FRAME_WIDTH          = 700, FRAME_HEIGHT          = 500;
    public static final int GENERATE_BUTTON_WIDTH = 150, GENERATE_BUTTON_HEIGHT = 70;
    
    // variables
    private JButton generateButton;
    private GeneralPanel generalPanel;
    
    /**
     * Constructor for objects of class GUI
     */
    public GUI()
    {        
        // main panel
        JPanel pane = new JPanel(new BorderLayout()); //pane.setBackground(Color.WHITE);
        
        // create tabs
        //JTabbedPane tabbedpane = new JTabbedPane(); //tabbedpane.setBackground(Color.WHITE);
        //tabbedpane.addTab("General", new GeneralPanel());
        //tabbedpane.addTab("Advanced", new AdvancedPanel());
        //tabbedpane.addTab("Converter", new ConverterPanel());
        
        // generate button
        generateButton = new JButton("Generate");
        generateButton.setPreferredSize(new Dimension(GENERATE_BUTTON_WIDTH, GENERATE_BUTTON_HEIGHT));
        generateButton.setMinimumSize(generateButton.getPreferredSize());
        generateButton.setMaximumSize(generateButton.getPreferredSize());
        generateButton.setFont(new Font("sans-serif",Font.PLAIN,16));
        //generateButton.setForeground(ColorLibrary.APPLE_BLUE); 
        //generateButton.setBackground(Color.WHITE);
        generateButton.addActionListener(new ButtonListener());
        
        generalPanel = new GeneralPanel();
        
        // assemble
        pane.add(generalPanel,BorderLayout.CENTER);
        pane.add(generateButton,BorderLayout.SOUTH);
        this.setContentPane(pane);  
        
        // setup frame
        this.setTitle(Const.NAME+" v"+Const.VERSION); //this.setBackground(ColorLibrary.LIGHT_GREY);
        this.setPreferredSize(new Dimension(FRAME_WIDTH,FRAME_HEIGHT));
        this.pack();
        this.setLocationRelativeTo(null); this.setResizable(false);
        
        try {
            //if(!System.getProperty("os.name").equalsIgnoreCase("mac os X")){
                javax.swing.UIManager.setLookAndFeel("javax.swing.plaf.nimbus.NimbusLookAndFeel");
                javax.swing.SwingUtilities.updateComponentTreeUI(this);
            //}
        }
        catch (Exception exc) {exc.printStackTrace();}
        

        this.setVisible(true);
    }
    
    /**
     * Test the GUI
     */
    public static void test(){
         new GUI();
    }
    
    private class ButtonListener implements ActionListener
    {
        public void actionPerformed(ActionEvent evt){
            if(evt.getSource() == generateButton){
                Chooser chooser = new Chooser(Chooser.DIRECTORIES_ONLY);
                chooser.show();
                String path = "";
                try{
                    path = chooser.getSelectedFile().getPath() + System.getProperty("file.separator");
                    
                }
                catch(Exception exc){
                    chooser.setVisible(false);
                    return;
                }
                generate(path);
            }
        }
        
        public void generate(String path){
             /*
             * Declare variables
             */
             String modulename;
             String outputfile;
        
             // reteive data:
             double[] filterCoeffTab = generalPanel.getFilterTable();
             if(filterCoeffTab == null){return;} // invalid coefficents
                          
             
             double carrierFrequency = generalPanel.getCarrierFrequency();
             if(carrierFrequency == 0){return;} // invalid frequency
             
             

             
             /*
              * DFT coefficients
              */
             // output file
             modulename = Const.DEFAULT_DFT_MODULENAME;
             outputfile = path+modulename+Const.VERILOG_EXTENSION;

             // generate coefficients
             DftCoeff dftCoeff = new DftCoeff(generalPanel.getDFTSize());

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
             outputfile = path+modulename+Const.VERILOG_EXTENSION;
    
             // generate coefficients
             
             
             FilterCoeff filterCoeff = new FilterCoeff(generalPanel.getDFTSize(),filterCoeffTab);
        
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
             outputfile = path+modulename+Const.VERILOG_EXTENSION;
        
             // generate coefficients
 
             Carriers carriers = new Carriers(carrierFrequency, generalPanel.getDFTSize());
        
             // rescale
             carriers.rescale(Const.DEFAULT_CARRIERS_RESC_FACTOR);
        
             // export
             try{Export.exportForVerilog(carriers, Const.DEFAULT_PRECISION, modulename, outputfile);}
             catch(ProgException exc){System.err.println(exc.getMessage());}
        
        }
    }
}
