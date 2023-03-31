import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class move extends JFrame implements ActionListener, MouseListener {
    // gui components that are contained in this frame:
    private JPanel topPanel, bottomPanel; // top and bottom panels in the main window
    private JLabel instructionLabel; // a text label to tell the user what to do
    private int count;
    private JButton topButton; // a 'reset' button to appear in the top panel
    private GridSquare[][] gridSquares; // squares to appear in grid formation in the bottom panel
    private int rows, columns; // the size of the grid
    public GridSquare prev;
    public int row, col, num, rownext, colnext;


    public move(int rows, int columns) {
        this.rows = rows;
        this.columns = columns;
        this.setSize(600, 600);
        count = 0;
        num = 0;

        // first create the panels
        topPanel = new JPanel();
        topPanel.setLayout(new FlowLayout());

        bottomPanel = new JPanel();
        bottomPanel.setLayout(new GridLayout(rows, columns));
        bottomPanel.setSize(500, 500);

        // then create the components for each panel and add them to it

        // for the top panel:
        instructionLabel = new JLabel("Sir Lancelot, visit every square once!");
        topButton = new JButton("New Game");
        topButton.addActionListener(this); // IMPORTANT! Without this, clicking the square does nothing.

        topPanel.add(instructionLabel);
        topPanel.add(topButton);

        // for the bottom panel:
        // create the squares and add them to the grid
        gridSquares = new GridSquare[rows][columns];
        for (int x = 0; x < columns; x++) {
            for (int y = 0; y < rows; y++) {
                gridSquares[x][y] = new GridSquare(x, y);
                gridSquares[x][y].setSize(20, 20);
                gridSquares[x][y].setColor(x + y);

                gridSquares[x][y].addMouseListener(this); // AGAIN, don't forget this line!

                bottomPanel.add(gridSquares[x][y]);
            }
        }

        // now add the top and bottom panels to the main frame
        getContentPane().setLayout(new BorderLayout());
        getContentPane().add(topPanel, BorderLayout.NORTH);
        getContentPane().add(bottomPanel, BorderLayout.CENTER); // needs to be center or will draw too small

        // housekeeping : behaviour
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setResizable(false);
        setVisible(true);
    }

    // restarts the game
    public void actionPerformed(ActionEvent aevt) {
        // get the object that was selected in the gui
        Object selected = aevt.getSource();
        count = 0;
        num = 0;
        instructionLabel.setText("Sir Lancelot, visit every square once!");
        if (selected.equals(topButton)) {
            for (int x = 0; x < columns; x++) {
                for (int y = 0; y < rows; y++) {
                    gridSquares[x][y].setColor(x + y);
                }
            }
        }
    }

    // switching color
    public void mouseClicked(MouseEvent mevt) {
        Object selected = mevt.getSource();
        if (selected instanceof GridSquare) {
            GridSquare square = (GridSquare) selected;
            if (square.getBackground() == Color.blue || square.getBackground() == Color.yellow
                    || allowed(square) == false) {
                instructionLabel.setText("You can't go there!");
            } else {
                count = count + 1;
                setblue();
                instructionLabel.setText("Moves made: " + count);
                if (count == 25) {
                    instructionLabel.setText("You did it!");
                }
                square.setBackground(Color.yellow);
            }

        }
    }

    public boolean allowed(GridSquare next) {
        for (int x = 0; x < columns; x++) {
            for (int y = 0; y < rows; y++) {
                if (gridSquares[x][y].getBackground() == Color.yellow) {
                    row = x;
                    col = y;
                    num = num + 1;
                }
            }
        }
        for (int x = 0; x < columns; x++) {
            for (int y = 0; y < rows; y++) {
                if (gridSquares[x][y] == next) {
                    rownext = x;
                    colnext = y;
                }
            }
        }

        if (num == 0) {
            return true;
        } else if ((row - 2 == rownext && col - 1 == colnext) || (row - 2 == rownext && col + 1 == colnext)
                || (row + 2 == rownext && col - 1 == colnext)
                || (row + 2 == rownext && col + 1 == colnext) || (row + 1 == rownext && col - 2 == colnext)
                || (row - 1 == rownext && col - 2 == colnext)
                || (row + 1 == rownext && col + 2 == colnext) || (row - 1 == rownext && col + 2 == colnext)) {
            return true;
        }

        else {
            return false;
        }

    }

    public void setblue() {
        for (int x = 0; x < columns; x++) {
            for (int y = 0; y < rows; y++) {
                if (gridSquares[x][y].getBackground() == Color.yellow) {
                    gridSquares[x][y].setBackground(Color.BLUE);
                }
            }
        }
    }

    public void mouseEntered(MouseEvent arg0) {
    }

    public void mouseExited(MouseEvent arg0) {
    }

    public void mousePressed(MouseEvent arg0) {
    }

    public void mouseReleased(MouseEvent arg0) {
    }
}
