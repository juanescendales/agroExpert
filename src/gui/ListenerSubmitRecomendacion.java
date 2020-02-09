package gui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import net.sourceforge.jFuzzyLogic.FIS;
import net.sourceforge.jFuzzyLogic.plot.JFuzzyChart;

public class ListenerSubmitRecomendacion implements ActionListener {

    JTextField T1;
    JTextField T2;
    JTextField T3;


    public ListenerSubmitRecomendacion(JTextField TAltitud,
    		JTextField TTemperatura,
    		JTextField TPrecipitacion,
    		JTextField TProfundidad,
    		JTextField THumedadRelativa,
    		JTextField THumedadAbsoluta,
    		JTextField TVaporDeAgua,
    		JTextField TTexturaDelSuelo,
    		JTextField TPh,
    		JTextField TFotoperiodo) {
        T1 = TTemperatura;
        T2 = TPrecipitacion;
        T3 = TProfundidad;
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
                           
                new InterfazDelSE(Double.toString(texturaSuelo.getVariable("textura").defuzzify()));
                
                
            }
        }
    }
}

