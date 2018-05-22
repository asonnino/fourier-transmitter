package view;

import data.Const;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Color;
import java.awt.Font;
import java.awt.Component;
import java.awt.Insets;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;

import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.Box;
import javax.swing.JTable;
import javax.swing.JScrollPane;
import javax.swing.JTextField;
import javax.swing.JTextArea;
import javax.swing.BorderFactory;
import javax.swing.event.TableModelListener;
import javax.swing.event.TableModelEvent;

import javax.swing.table.DefaultTableCellRenderer;

import javax.swing.border.TitledBorder;

/**
 * Panel allowing advanved use of the application.
 * 
 * @author Alberto Sonnino 
 * @version 2.0.1
 */
public class GeneralPanel extends JPanel
{
    // parameters
    public static final int FREQUENCY_FIELD_WIDTH  = 200, FREQUENCY_FIELD_HEIGHT  = 25;
    public static final int FILTER_TABLE_WIDTH     = 263, FILTER_TABLE_HEIGHT     = 100;
        
    // variables
    private int filterCoeffNumber, numberOfZeroFilterCoeff, DFTSize;
    
    private Table filterTable;
    private JTextField frequencyField;
    private JTextArea infoArea;
    
    private Font infoFont;
    
    /**
     * Constructor for objects of class GeneralPanel
     */
    public GeneralPanel()
    {
        // initialize
        filterCoeffNumber = 11;
        numberOfZeroFilterCoeff = 5;
        DFTSize = 16;
        
        infoFont = new Font("SansSerif", Font.BOLD, 12);
        
        this.setLayout(new BorderLayout()); //this.setBackground(new Color(230,230,230));
        
        // assemble
        this.add(createNorthArea(),BorderLayout.NORTH);
        this.add(createWestArea(),BorderLayout.WEST);
        this.add(createEastArea(),BorderLayout.EAST);
        
        refreshInfoAreaValues();
        refreshInfoArea();
    }

    /**
     * @return     the north area of the GUI 
     */
    private JTextArea createNorthArea(){
        // initialize
        JTextArea northTxtArea = new JTextArea();
        northTxtArea.setEditable(false); northTxtArea.setForeground(ColorLibrary.LIGHT_GREY); 
        northTxtArea.setMargin(new Insets(10,10,10,10)); //northTxtArea.setBackground(this.getBackground());
        northTxtArea.setBackground(new Color(0, 0, 0, 0));
        northTxtArea.setFocusable(false);
        // fill
        northTxtArea.append(
            "Enter the filter coefficients in the table on the left and the carrier frequency on the field "+
            "on the right.\n" +
            "The info panel on the bottom right indicates the properties of the files."
        );
        TitledBorder northTxtBorder = BorderFactory.createTitledBorder("");
        northTxtBorder.setTitleColor(ColorLibrary.DARK_GREY);
        northTxtBorder.setTitleJustification(TitledBorder.LEFT);
        northTxtArea.setBorder(northTxtBorder);
        
        // return
        return northTxtArea;
    }
    
    /**
     * @return     the west area of the GUI 
     */
    private Box createWestArea(){
        // label
        JLabel infoLabel = new JLabel("Enter the filter coefficients: ");
        infoLabel.setFont(infoFont);
        infoLabel.setForeground(ColorLibrary.DARK_GREY); 
        infoLabel.setMaximumSize(new Dimension(FILTER_TABLE_WIDTH, 25));
        infoLabel.setPreferredSize(infoLabel.getMaximumSize());
        
        // create table
        filterTable = new Table(16); filterTable.setToolLocation(Table.SOUTH); filterTable.repaint();
        filterTable.setMinimumSize(new Dimension(FILTER_TABLE_WIDTH, FILTER_TABLE_HEIGHT));
        filterTable.addTableModelListener(new TableModelListener(){
            public void tableChanged(TableModelEvent evt){
                refreshInfoAreaValues();
                refreshInfoArea();
                filterTable.refresh();
            }
        });
        // NOT COMPLETE
        
        
        // assemble and return
        Box infoBox = Box.createHorizontalBox();
        infoBox.add(infoLabel); infoBox.add(Box.createHorizontalStrut(77));
        
        Box vBox = Box.createVerticalBox();
        vBox.add(Box.createVerticalStrut(10));
        vBox.add(infoBox);
        vBox.add(Box.createVerticalStrut(10));
        vBox.add(filterTable); 
        vBox.add(Box.createVerticalStrut(5));
        
        Box hBox = Box.createHorizontalBox();
        hBox.add(Box.createHorizontalStrut(10)); hBox.add(vBox);
        
        return hBox;
    }
    
    /**
     * @return     the east area of the GUI 
     */
    private Box createEastArea(){
        // frequency
        JLabel frequencyLabel = new JLabel("frequency:");
        frequencyLabel.setFont(infoFont);
        frequencyLabel.setForeground(ColorLibrary.DARK_GREY);
        frequencyField = new JTextField(); 
        frequencyField.addKeyListener(new KeyAdapter() {
            public void keyReleased(KeyEvent e) {
                refreshInfoArea();
            }
            public void keyTyped(KeyEvent e) {}
            public void keyPressed(KeyEvent e) {}
        });
    
        frequencyField.setPreferredSize(new Dimension(FREQUENCY_FIELD_WIDTH,FREQUENCY_FIELD_HEIGHT));
        frequencyField.setMaximumSize(frequencyField.getPreferredSize());
        frequencyField.setMinimumSize(frequencyField.getPreferredSize());
        JLabel frequencyUnitLabel = new JLabel("Hz");
        frequencyUnitLabel.setFont(infoFont);
        frequencyUnitLabel.setForeground(frequencyLabel.getForeground());
        
        Box frequencyBox = Box.createHorizontalBox();
        frequencyBox.add(Box.createHorizontalStrut(10)); frequencyBox.add(frequencyLabel);
        frequencyBox.add(Box.createHorizontalStrut(5)); frequencyBox.add(frequencyField);
        frequencyBox.add(Box.createHorizontalStrut(5)); frequencyBox.add(frequencyUnitLabel);
        frequencyBox.add(Box.createHorizontalStrut(13));
        
        // info panel
        infoArea = new JTextArea(){
            public void paintComponent(java.awt.Graphics g){
                super.paintComponent(g);
                g.setColor(ColorLibrary.DARK_GREY);
                g.drawRoundRect(3, 15, this.getWidth() - 9, this.getHeight() - 16, 20, 20);
            }
        }; infoArea.setEditable(false); refreshInfoArea(); infoArea.setForeground(ColorLibrary.LIGHT_GREY);
        infoArea.setMargin(new Insets(100, 100, 20, 20));
        //infoArea.setBackground(this.getBackground());  //infoArea.setMargin(new Insets(30,30,30,30));
        infoArea.setBackground(new Color(0, 0, 0, 0));
        //infoArea.setBackground(new Color(0, 0, 0, 0));
        
        TitledBorder infoBorder = BorderFactory.createTitledBorder("info");
        infoBorder.setTitleColor(ColorLibrary.DARK_GREY);
        //infoBorder.setColor(ColorLibrary.DARK_GREY);
        infoBorder.setTitleJustification(TitledBorder.LEFT);
        infoArea.setBorder(infoBorder);
        
        JScrollPane infoScrollPane = new JScrollPane(infoArea);
        infoScrollPane.setBackground(new Color(0, 0, 0, 0));
        infoScrollPane.setBorder(BorderFactory.createEmptyBorder());
        
        Box infoBox = Box.createHorizontalBox();
        infoBox.add(infoScrollPane); infoBox.add(Box.createHorizontalStrut(7));
        
        // assemble and return
        Box vBox = Box.createVerticalBox(); vBox.add(Box.createVerticalStrut(10));
        vBox.add(frequencyBox); vBox.add(Box.createVerticalStrut(30)); vBox.add(infoBox); vBox.add(Box.createVerticalStrut(7));
        return vBox;
    }
    
    private int getDFTPow(int filterCoefNumber){
        int pow = 0;
        for(; Math.pow(2, pow) < filterCoefNumber ; pow++){}
        return pow;
    }
    private int calculateFilterCoeffNumber(){
        for(int i=filterTable.getTable().getRowCount() - 1 ; i >= 0 ; i--){
            try{
                if(filterTable.getTable().getValueAt(i, 0) != null){
                    return i + 1;
                }
            }
            catch(Exception exc){System.err.println(exc.getMessage());}
        }
        return 0;
    }
    
    private void refreshInfoAreaValues(){
        filterCoeffNumber = calculateFilterCoeffNumber();
        DFTSize = (int) Math.pow(2, getDFTPow(filterCoeffNumber));
        numberOfZeroFilterCoeff = DFTSize - filterCoeffNumber;
    }
    
    /**
     * @return     refresh the info area 
     */
    private void refreshInfoArea(){
        String modulename = Const.DEFAULT_DFT_MODULENAME;
        double carrierFrequency = 0;
        try{carrierFrequency = Double.parseDouble(frequencyField.getText());}
        catch(NumberFormatException e){}
        
        infoArea.setText("");
        infoArea.append(
            " \n" +
            " >> System precision: "+Const.DEFAULT_PRECISION+" bits\n"+
            " \n" +
            " >> Filter coefficients: "+filterCoeffNumber+" entered\n"+
            "           padding with "+numberOfZeroFilterCoeff+" zeros\n"+
            " \n" +
            " >> DFT size: "+DFTSize+"\n"+
            " \n" +
            " >> Carrier's frequency: "+carrierFrequency+"\n"+
            " \n" +
            " \n" +
            " >> The following files will be generated:\n" +
            "           - " + Const.DEFAULT_DFT_MODULENAME + Const.VERILOG_EXTENSION + "\n" +
            "           - " + Const.DEFAULT_FILTER_MODULENAME + Const.VERILOG_EXTENSION + "\n" +
            "           - " + Const.DEFAULT_CARRIERS_MODULENAME + Const.VERILOG_EXTENSION + "\n"
            
        );
    }
    
    public int getFilterCoeffNumber(){
        return filterCoeffNumber;
    }
    public int getNumberOfZeroFilterCoeff(){
        return numberOfZeroFilterCoeff;
    }
    public int getDFTSize(){
        return DFTSize;
    }
    public double[] getFilterTable(){
        Object[] filterCoeffStringObj = filterTable.getContent();
        String[] filterCoeffStringTab = new String[filterCoeffStringObj.length];
        
        int count = 0; // suppress 'null' values
        for(int i=0; i<filterCoeffStringObj.length; i++){
            if(filterCoeffStringObj[i] == null ){break;} 
            
            filterCoeffStringTab[i] = (String) filterCoeffStringObj[i];
            count++;
        }
        
        // fill only 'count' value, the rest will be set to zero by the FilterCoeff constructor
        double[] filterCoeffTab = new double[count];
        for(int i=0; i<count; i++){ 
            try{
         
                filterCoeffTab[i] = Double.parseDouble(filterCoeffStringTab[i]);

            }
            catch(NumberFormatException e){
                infoArea.setText("");
                infoArea.append(
                    " \n" +
                    " >> System precision: "+Const.DEFAULT_PRECISION+" bits\n"+
                    " \n" +
                    " >> Filter coefficients: /!\\ ERROR - coefficient "+i+" is not a number\n"+
                    ""+           
                    " \n" +
                    " >> DFT size: "+DFTSize+"\n"+
                    " \n" +
                    " >> Carrier's frequency: "+getCarrierFrequency()+"\n"+
                    " \n" +
                    " \n" +
                    " >> The following files will be generated:\n" +
                    "           - " + Const.DEFAULT_DFT_MODULENAME + Const.VERILOG_EXTENSION + "\n" +
                    "           - " + Const.DEFAULT_FILTER_MODULENAME + Const.VERILOG_EXTENSION + "\n" +
                    "           - " + Const.DEFAULT_CARRIERS_MODULENAME + Const.VERILOG_EXTENSION + "\n"
                );
                return null;
            }
        }
        return filterCoeffTab;
    }
   
    public double getCarrierFrequency(){
        double carrierFrequency = 0;
        try{
            carrierFrequency = Double.parseDouble(frequencyField.getText());
            if(carrierFrequency == 0){throw new NumberFormatException();}
        }
        catch(NumberFormatException e){
            infoArea.setText("");
            infoArea.append(
                " \n" +
                " >> System precision: "+Const.DEFAULT_PRECISION+" bits\n"+
                " \n" +
                " >> Filter coefficients: "+filterCoeffNumber+" entered\n"+
                "           padding with "+numberOfZeroFilterCoeff+" zeros\n"+
                " \n" +
                " >> DFT size: "+DFTSize+"\n"+
                " \n" +
                " >> Carrier's frequency: /!\\ ERROR - invalid frequency\n"+
                " \n" +
                " \n" +
                " >> The following files will be generated:\n" +
                "           - " + Const.DEFAULT_DFT_MODULENAME + Const.VERILOG_EXTENSION + "\n" +
                "           - " + Const.DEFAULT_FILTER_MODULENAME + Const.VERILOG_EXTENSION + "\n" +
                "           - " + Const.DEFAULT_CARRIERS_MODULENAME + Const.VERILOG_EXTENSION + "\n"
            
            );
            return 0;
        }
        return carrierFrequency;
    }
}
