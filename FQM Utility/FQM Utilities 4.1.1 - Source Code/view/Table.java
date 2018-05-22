package view;

import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.JPanel;
import javax.swing.Box;
import javax.swing.JLabel;
import javax.swing.ImageIcon;
import javax.swing.event.ListSelectionListener;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.TableModelListener;
import javax.swing.event.TableModelEvent;

import javax.swing.JScrollPane;

import java.awt.Dimension;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.awt.event.MouseEvent;
/**
 * Write a description of class Table here.
 *
 * @author ALF Corp
 * @version 2.1.1
 */
public class Table extends JPanel
{
    public static final int DEFAULT_ROWS = 10, COLUMNS = 1;
    private JTable table;
    private JTable rowsNumberTable;
    private DefaultTableModel tableModel, rowsNumberTableModel;

    public static final int NORTH = 0, SOUTH = 1;
    private int toolLocation;

    private Color backgroundLineColor = new Color(220,220,225);

    private JPanel toolPanel;
    public Table()
    {
        super(new BorderLayout());
        init(DEFAULT_ROWS, COLUMNS);
        printRowsCount();
    }
    public Table(int rows){
        super(new BorderLayout());
        init(rows, COLUMNS);
        printRowsCount();
    }
    public Table(int rows, Object[] content){
        super(new BorderLayout());
        init(rows, COLUMNS);
        setContent(content);
    }

    private void init(int rows,int columns){
        //this.setBackground(new Color(0, 0, 0, 0));

        tableModel = new DefaultTableModel(rows, columns);
        table = new JTable(rows, columns);
        table.setBackground(new Color(0, 0, 0, 0));
        table.setShowGrid(false);
        table.getSelectionModel().addListSelectionListener(new ListSelectionListener(){
            public void valueChanged(ListSelectionEvent event) {repaint();}
        });
        table.setSelectionBackground(new Color(
            ColorLibrary.SELECTION_BLUE.getRed(),ColorLibrary.SELECTION_BLUE.getGreen(),ColorLibrary.SELECTION_BLUE.getBlue(),170
        ));
        createRowNumberTable(rows);

        toolLocation = NORTH;
        
        JPanel tablesPanel = new JPanel(new BorderLayout()){
            public void paintComponent(java.awt.Graphics g){
                super.paintComponent(g);
                g.setColor(backgroundLineColor);
                int size = table.getRowHeight();
                for(int i=0 ; i < table.getRowCount() ; i += 2){
                    g.fillRect(0, i * size, this.getWidth(), size);
                }
            }
        };
        tablesPanel.setBackground(Color.WHITE);
        
        tablesPanel.add(table, BorderLayout.CENTER);
        tablesPanel.add(rowsNumberTable, BorderLayout.WEST);
        JScrollPane scrollPane = new JScrollPane(tablesPanel);
        scrollPane.setBackground(new Color(0, 0, 0, 0));
        tablesPanel.addMouseMotionListener(new MouseMotionListener(){
            public void mouseMoved(MouseEvent evt){
                tablesPanel.repaint(); refresh(); table.repaint(); table.revalidate(); rowsNumberTable.repaint(); rowsNumberTable.revalidate();
            }
            public void mouseDragged(MouseEvent evt){
                tablesPanel.repaint(); refresh(); table.repaint(); table.revalidate(); rowsNumberTable.repaint(); rowsNumberTable.revalidate();
            }
        });
        this.add(scrollPane, BorderLayout.CENTER);
        packToolPanel();
    }
    private void packToolPanel(){
        switch(toolLocation){
            case NORTH: this.add(getToolsPanel(), BorderLayout.NORTH); break;
            case SOUTH: this.add(getToolsPanel(), BorderLayout.SOUTH); break;
        }
    }

    private void createRowNumberTable(int rows){
        rowsNumberTableModel = new DefaultTableModel(rows, 1);
        rowsNumberTable = new JTable(rowsNumberTableModel);
        rowsNumberTable.setBackground(new Color(0, 0, 0, 0));
        rowsNumberTable.setShowGrid(false);
        rowsNumberTable.setEnabled(false);
        printRowsCount();
    }

    public void printRowsCount(){
        int width = (int) (("" + table.getRowCount()).length() * 13);
        if(width < 20){width = 20;}
        rowsNumberTable.setPreferredSize(new Dimension(width, table.getHeight()));
        for(int i=0 ; i < table.getRowCount() ; i++){
            rowsNumberTable.setValueAt(i, i, 0);
        }
    }

    public void setTablePreferredSize(int width, int height){
        table.setPreferredSize(new Dimension(width, height));
    }
    public void setTablePreferredSize(Dimension dimension){
        table.setPreferredScrollableViewportSize(dimension);
    }

    public JTable getTable(){
        return table;
    }

    public void setContent(Object[] content){
        for(int i=0 ; i < content.length ; i++){
            if(i >= table.getRowCount()){
                return;
            }
            table.setValueAt(content[i], i, 0);
        }
    }
    public Object[] getContentFrom(JTable table){
        Object[] content = new Object[table.getRowCount()];
        for(int i=0 ; i < content.length ; i++){
            content[i] = table.getValueAt(i, 0);
        }
        return content;
    }
    public Object[] getContent(){
        Object[] content = new Object[getTable().getRowCount()];
        for(int i=0 ; i < content.length ; i++){
            content[i] = getTable().getValueAt(i, 0);
        }
        return content;
    }

    public Object[] removeFromArray(Object[] array, int[] index){
        Object[] tab = new Object[array.length - index.length];

        int indexInTab = 0;
        for(int i=0 ; i < array.length ; i++){
            boolean copy = true;
            for(int j=0 ; j < index.length ; j++){
                if(i == index[j]){copy = false;}
            }
            if(copy){
                tab[indexInTab] = array[i];
                indexInTab++;
            }
        }

        return tab;
    }

    public void addLine(){
        tableModel = (DefaultTableModel) table.getModel();
        tableModel.addRow(new Object[]{null});
        table.setModel(tableModel);

        rowsNumberTableModel.addRow(new Object[]{table.getRowCount() - 1});
        rowsNumberTable.setModel(rowsNumberTableModel);
        printRowsCount();
    }
    public void removeLine(){
        Object[] content = getContent();
        tableModel = (DefaultTableModel) table.getModel();
        if(table.getSelectedRows().length == 0 && table.getRowCount() > 0){
            int rowCount = table.getRowCount();
            tableModel.removeRow(rowCount - 1);
            rowsNumberTableModel.removeRow(rowCount - 1);
            removeFromArray(content, table.getSelectedRows());
        }
        else if(table.getRowCount() > 0){
            int[] selectedRows = table.getSelectedRows();
            for(int i=0 ; i < selectedRows.length ; i++){
                tableModel.removeRow(selectedRows[i]);
                rowsNumberTableModel.removeRow(selectedRows[i]);
                removeFromArray(content, new int[]{i});
                for(int j=i ; j < selectedRows.length ; j++){
                    selectedRows[j] = selectedRows[j] - 1;
                }
            }
        }
        else{return;}
        table.setModel(tableModel);
        rowsNumberTable.setModel(rowsNumberTableModel);
        setContent(content);

        printRowsCount();
    }

    private JPanel getToolsPanel(){
        int distance = 12; int removeDistance = 50;
        int width = 5; int length = 21;
        int[] coords = new int[]{(int) ((length - width) / 2) + distance - 1, (int) ((length - width) / 2) + 5,
            15 + distance, 5,
            5 + removeDistance, (int) ((length - width) / 2) + 5};
        toolPanel = new JPanel(){
            public void paintComponent(java.awt.Graphics g){
                super.paintComponent(g);
                g.setColor(ColorLibrary.DARK_GREY);
                
                g.fillRect(coords[0], coords[1], length, width);
                g.fillRect(coords[2], coords[3], width, length);
                g.fillRect(coords[4], coords[5], length, width);
            }
        };
        
        toolPanel.setMinimumSize(new Dimension(this.getWidth(), 26));
        toolPanel.setMaximumSize(toolPanel.getMinimumSize());
        toolPanel.setPreferredSize(toolPanel.getMinimumSize());
        toolPanel.addMouseListener(new MouseListener(){
            public void mouseEntered(MouseEvent evt){}
            public void mouseExited(MouseEvent evt){}
            public void mousePressed(MouseEvent evt){}
            public void mouseReleased(MouseEvent evt){}
            public void mouseClicked(MouseEvent evt){
                if(evt.getX() >= coords[0] && evt.getX() <= coords[0] + length && evt.getY() >= coords[3] && evt.getY() <= coords[3] + length){
                    addLine(); repaint(); refresh();
                }
                else if(evt.getX() >= coords[4] && evt.getX() <= coords[4] + length && evt.getY() >= coords[3] && evt.getY() <= coords[3] + length){
                    removeLine(); repaint(); refresh();
                }
            }
        });
        
        /*//JLabel addLabel = new JLabel(new ImageIcon(System.getProperty("user.dir")+System.getProperty("file.separator")+"view"+
        //    System.getProperty("file.separator")+"Resources"+System.getProperty("file.separator")+"Add.png"));
        JLabel addLabel = new JLabel(){
            public void paintComponent(java.awt.Graphics g){
                super.paintComponent(g);
                g.setColor(ColorLibrary.DARK_GREY);
                g.fillRect(0, 0, 21, 5);
                g.fillRect(0, 0, 5, 21);
                //g.fillRect(0, 0, this.getWidth() - 1, this.getHeight() - 1);
                System.out.println(this.getWidth() + " " + this.getHeight());
            }
        };;
        addLabel.setMaximumSize(new Dimension(22, 22));
        addLabel.setPreferredSize(addLabel.getMaximumSize());
        addLabel.addMouseListener(new MouseListener(){
            public void mouseEntered(MouseEvent evt){}
            public void mouseExited(MouseEvent evt){}
            public void mousePressed(MouseEvent evt){}
            public void mouseReleased(MouseEvent evt){}
            public void mouseClicked(MouseEvent evt){addLine(); repaint();}
        });
        //JLabel removeLabel = new JLabel(new ImageIcon(System.getProperty("user.dir")+System.getProperty("file.separator")+"view"+
        //    System.getProperty("file.separator")+"Resources"+System.getProperty("file.separator")+"Substract.png"));
        JLabel removeLabel = new JLabel(){
            public void paintComponent(java.awt.Graphics g){
                super.paintComponent(g);
                g.setColor(ColorLibrary.DARK_GREY);
                g.fillRect(0, 8, 21, 5);
            }
        };
        removeLabel.setMaximumSize(new Dimension(22, 42));
        removeLabel.setPreferredSize(addLabel.getMaximumSize());
        removeLabel.addMouseListener(new MouseListener(){
            public void mouseEntered(MouseEvent evt){}
            public void mouseExited(MouseEvent evt){}
            public void mousePressed(MouseEvent evt){}
            public void mouseReleased(MouseEvent evt){}
            public void mouseClicked(MouseEvent evt){removeLine(); repaint();}
        });

        Box hBox = Box.createHorizontalBox();
        hBox.add(Box.createHorizontalStrut(7));
        hBox.add(addLabel);
        hBox.add(Box.createHorizontalStrut(17));
        hBox.add(removeLabel);
        hBox.add(Box.createHorizontalStrut(250));*/

        toolPanel.setBackground(new Color(0,0,0,0));
        
        //toolPanel.add(hBox);
        return toolPanel;
    }

    public void setToolLocation(int location){
        this.toolLocation = location;
        this.remove(toolPanel);
        this.packToolPanel();
    }
    public int getToolLocation(){
        return toolLocation;
    }

    public void setBackgroundLineColor(Color color){
        backgroundLineColor = color;
    }
    public Color getBackgroundLineColor(){
        return backgroundLineColor;
    }
    
    public void refresh(){
        repaint();
        revalidate();
    }
    
    public void addTableModelListener(TableModelListener listener){
        this.getTable().getModel().addTableModelListener(listener);
    }

    public static void test() {
        javax.swing.JFrame frame = new javax.swing.JFrame("Test");
        frame.setDefaultCloseOperation(javax.swing.JFrame.EXIT_ON_CLOSE);

        Table table = new Table();
        table.setToolLocation(table.SOUTH);
        table.repaint();
        frame.add(table);

        frame.pack();
        frame.setVisible(true);
    }
} 