package gui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import net.sourceforge.jFuzzyLogic.FIS;
import net.sourceforge.jFuzzyLogic.plot.JFuzzyChart;

public class ListenerSubmit implements ActionListener {

    JTextField T1;
    JTextField T2;
    JTextField T3;
    JTextArea TA1;

    public ListenerSubmit(JTextField t1, JTextField t2, JTextField t3, JTextArea ta1) {
        T1 = t1;
        T2 = t2;
        T3 = t3;
        TA1 = ta1;
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String actionCommand = e.getActionCommand();
        if (e.getSource() instanceof JButton) {
            if ("Enviar".equals(actionCommand)) {
                FIS texturaSuelo = FIS.load("src/fuzzy/agroexpertFCL.fcl", true);

                // Set inputs
                texturaSuelo.setVariable("porcentajeArenoso", Double.parseDouble(T1.getText()));
                texturaSuelo.setVariable("porcentajeLimoso", Double.parseDouble(T2.getText()));
                texturaSuelo.setVariable("porcentajeArcilloso", Double.parseDouble(T3.getText()));

                // Evaluate
                texturaSuelo.evaluate();

                //Graficas de conjuntos difusos
                JFuzzyChart.get().chart(texturaSuelo.getFunctionBlock("texturaSuelo"));

                // Show output variable

                TA1.setText(TA1.getText() + "El indicador de textura es: " + texturaSuelo.getVariable("textura").defuzzify());
                TA1.setText(TA1.getText() + "\n \n" + "El metodo usado para 'defuzzificar' la textura fue: " + texturaSuelo.getVariable("textura").getDefuzzifier());
                TA1.setEditable(false);
                
                
                
                
                
            }
        }
    }
}

