package view;

import javax.swing.JFileChooser;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.JComponent;

import java.io.File;

/**
* Write a description of class MenuApplication here.
*
* @author ALF CORP
* @version 2012
*/
public class Chooser extends JFileChooser
{
   private int status;

   public Chooser(){
       super();
       init("", null, this.FILES_ONLY);
   }
   public Chooser(String[] chooseTab) {
       super();
       init("", chooseTab, this.FILES_ONLY);
   }
   public Chooser(String choose) {
       super();
       init(choose, null, this.FILES_ONLY);
   }
   public Chooser(String choose, String[] chooseTab) {
       super();
       init(choose, chooseTab, this.FILES_ONLY);
   }
   public Chooser(int mode) {
       super();
       init("", null, mode);
   }
   public Chooser(String choose, String[] chooseTab, int mode) {
       super();
       init(choose, chooseTab, mode);
   }

   public void init(String text, String[] extensions, int mode){
       if(extensions != null){this.setFileFilter(new FileNameExtensionFilter(text, extensions));}

       setMode(mode);

       status = -1;
   }

   public void setMode(int mode){
       this.setFileSelectionMode(mode);
   }

   public void show(){
       this.status = status = this.showOpenDialog(null);
   }
   public void show(JComponent component){
       this.status = status = this.showOpenDialog(component);
   }

   public int getStatus(){
       return this.status;
   }

   public String getFileName(){
       if(this.getSelectedFile() == null || this.getSelectedFile().getName() == null){return null;}
       return this.getSelectedFile().getName();
   }
   public String getFileParent(){
       if(this.getSelectedFile() == null || this.getSelectedFile().getParent() == null){return null;}
       return this.getSelectedFile().getParent();
   }
   public String getFilePath(){
       if(this.getSelectedFile() == null || this.getSelectedFile().getPath() == null){return null;}
       return this.getSelectedFile().getPath();
   }

   public boolean isAccepted(){
       if (getStatus() == JFileChooser.APPROVE_OPTION) {return true;}
       else if (getStatus() == JFileChooser.CANCEL_OPTION) {return false;}
       return false;
   }
}