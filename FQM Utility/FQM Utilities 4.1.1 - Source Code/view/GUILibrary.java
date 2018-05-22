package view;

import javax.swing.ImageIcon;
import javax.swing.JComponent;
import javax.swing.Box;
import javax.swing.border.Border;
import javax.swing.border.EmptyBorder;
import javax.swing.border.CompoundBorder;

/**
 * Class containing GUI utilities.
 * 
 * @author Alf Corp 
 * @version 1.0.1
 */
public class GUILibrary
{
    /**
     * @param     enter the path.
     * @return    return an ImageIcon with the image.      
     */
    public static ImageIcon getImg(String path){
        java.net.URL imgURL = GUILibrary.class.getResource(path);
        if (imgURL == null) {new Error("File "+path+" not found"); return null;} 
        return new ImageIcon(imgURL);
    }
    
    /**
     * @param     enter a JComponent
     * @return    return an horizontal box with the component at its center       
     */
    public static Box centerComponent(JComponent com){
        Box hBox = Box.createHorizontalBox();
        hBox.add(Box.createHorizontalGlue());hBox.add(com);hBox.add(Box.createHorizontalGlue());
        return hBox;
    }
    
    /**
     * @param     enter a JComponent
     * @return    return an horizontal box with the component at its right      
     */
    public static Box centerRightComponent(JComponent com){
        Box hBox = Box.createHorizontalBox();
        hBox.add(Box.createHorizontalGlue());hBox.add(com);
        return hBox;
    }
    /**
     * @param     enter a JComponent
     * @return    return an horizontal box with the component at its right      
     */
    public static Box centerRightComponent(JComponent com, int strut){
        Box hBox = Box.createHorizontalBox();
        hBox.add(Box.createHorizontalGlue());hBox.add(com);hBox.add(Box.createHorizontalStrut(strut));
        return hBox;
    }
    
    /**
     * @param     enter a JComponent
     * @return    return an horizontal box with the component at its left       
     */
    public static Box centerLeftComponent(JComponent com){
        Box hBox = Box.createHorizontalBox();
        hBox.add(com);hBox.add(Box.createHorizontalGlue());
        return hBox;
    }
    
    /**
     * @param     enter a JComponent and the padding distance
     * @return    return the component with padded borders       
     */
    public static JComponent addBorderPadding(JComponent comp, int p1, int p2, int p3, int p4){
        Border border = comp.getBorder(); Border margin = new EmptyBorder(p1,p2,p3,p4);
        comp.setBorder(new CompoundBorder(border, margin));
        return comp;
    }
}
