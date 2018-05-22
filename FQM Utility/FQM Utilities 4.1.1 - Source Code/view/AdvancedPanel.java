package view;

import java.awt.BorderLayout;
import java.awt.Dimension;

import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.Box;
import javax.swing.JTable;
import javax.swing.JScrollPane;
import javax.swing.BorderFactory;

import javax.swing.border.TitledBorder;

/**
 * Panel allowing general use of the application.
 * 
 * @author Alberto Sonnino 
 * @version 2.0.1
 */
public class AdvancedPanel extends JPanel
{
    // parameters
    public static final int MODULENAME_FIELD_WIDTH  = 200, MODULENAME_FIELD_HEIGHT  = 30;
    public static final int SIZE_FIELD_WIDTH        = 50,  SIZE_FIELD_HEIGHT        = 30;
    public static final int RESC_FACTOR_FIELD_WIDTH = 70,  RESC_FACTOR_FIELD_HEIGHT = 30;
    public static final int FILTER_TABLE_WIDTH      = 300, FILTER_TABLE_HEIGHT      = 300;
    
    // variables
    JTextField filterModulenameField, filterSizeField, filterRescFactorField;
    JTable filterTable;
    
    /**
     * Constructor for objects of class GeneralPanel
     */
    public AdvancedPanel()
    {
        // initialize
        this.setLayout(new BorderLayout());
        
        // assemble
        this.add(createFilterBox(),BorderLayout.WEST);
        this.add(createEastPanel(),BorderLayout.EAST);
        this.add(createSouthPanel(),BorderLayout.SOUTH);
    }

    /**
     * @return     return the filter panel 
     */
    private Box createFilterBox(){
        /*
         * modulename
         */ 
        JLabel filterModulenameLabel = new JLabel("modulename:"); filterModulenameField = new JTextField(); 
        filterModulenameField.setPreferredSize(new Dimension(MODULENAME_FIELD_WIDTH,MODULENAME_FIELD_HEIGHT));
        
        Box filterModulenameBox = Box.createHorizontalBox(); 
        filterModulenameBox.add(Box.createHorizontalStrut(10)); filterModulenameBox.add(filterModulenameLabel); 
        filterModulenameBox.add(Box.createHorizontalStrut(5)); filterModulenameBox.add(filterModulenameField);
        filterModulenameBox.add(Box.createHorizontalStrut(10));
        
        /*
         * size and  rescaling factor
         */ 
        JLabel filterSizeLabel = new JLabel("size:"); filterSizeField = new JTextField();
        filterSizeField.setPreferredSize(new Dimension(SIZE_FIELD_WIDTH,SIZE_FIELD_HEIGHT));
        
        JLabel filterRescFactorLabel = new JLabel("rescaling factor:"); filterRescFactorField = new JTextField();
        filterRescFactorField.setPreferredSize(new Dimension(RESC_FACTOR_FIELD_WIDTH,RESC_FACTOR_FIELD_HEIGHT));
        
        Box filterSizeAndRFBox = Box.createHorizontalBox(); 
        filterSizeAndRFBox.add(Box.createHorizontalStrut(10)); filterSizeAndRFBox.add(filterSizeLabel); 
        filterSizeAndRFBox.add(Box.createHorizontalStrut(5)); filterSizeAndRFBox.add(filterSizeField);
        filterSizeAndRFBox.add(Box.createHorizontalStrut(20)); filterSizeAndRFBox.add(Box.createHorizontalGlue());
        filterSizeAndRFBox.add(filterRescFactorLabel); filterSizeAndRFBox.add(Box.createHorizontalStrut(5)); 
        filterSizeAndRFBox.add(filterRescFactorField); filterSizeAndRFBox.add(Box.createHorizontalStrut(10));
        
        
        /*
         * coefficients
         */ 
        filterTable = new JTable(10,1); 
        JScrollPane filterTableScroller = new JScrollPane(filterTable); filterTable.setFillsViewportHeight(true);
        filterTableScroller.setPreferredSize(new Dimension(FILTER_TABLE_WIDTH, FILTER_TABLE_HEIGHT));
        
        
        /*
         * assemble and return
         */
        Box vBox = Box.createVerticalBox();
        vBox.add(Box.createVerticalStrut(10));
        vBox.add(filterModulenameBox); vBox.add(Box.createVerticalStrut(5)); vBox.add(filterSizeAndRFBox); 
        vBox.add(Box.createVerticalStrut(10)); vBox.add(filterTableScroller);
        vBox.add(Box.createVerticalStrut(10));
        
        TitledBorder filterBorder = BorderFactory.createTitledBorder("Filter Coefficients");
        filterBorder.setTitleJustification(TitledBorder.CENTER);
        vBox.setBorder(filterBorder);
        
        return vBox;
    }
    
    /**
     * @return     return the east panel containing the DFT and the carriers pannel
     */
    private JPanel createEastPanel(){
        return new JPanel();
    }
    
    /**
     * @return     return the DFT panel 
     */
    private JPanel createDFTPanel(){
        return new JPanel();
    }

    /**
     * @return     return the carriers panel 
     */
    private JPanel createCarriersPanel(){
        return new JPanel();
    }
    
    /**
     * @return     return the south panel
     */
    private JPanel createSouthPanel(){
        return new JPanel();
    }
}
