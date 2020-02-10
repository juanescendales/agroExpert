package gui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Iterator;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import jess.Rete;
import jess.Fact;
import jess.JessException;



public class ListenerSubmitRecomendacion implements ActionListener {

	JComboBox cbPlanta; 
	JComboBox cbZona;
	 JTextField TTextura;
	 JTextField TPh;
	 JTextField TFotoperiodo;
	 JTextField TProfundidad;
	 JTextArea textArea;
	 
	 Rete motor;

	 
    public ListenerSubmitRecomendacion(
    		JComboBox cbPlanta,
    		JComboBox cbZona,
    		JTextField TTextura,
    		JTextField TPh,
    		JTextField TFotoperiodo,
    		JTextField TProfundidad,
    		JTextArea textArea,
    		Rete motor) throws JessException {
    	
    	this.cbPlanta=cbPlanta;
    	this.cbZona=cbZona;
        this.TTextura = TTextura;
        this.TPh = TPh;
        this.TFotoperiodo = TFotoperiodo;
        this.TProfundidad = TProfundidad;
        
        this.textArea = textArea;
        
        this.motor = motor;
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String actionCommand = e.getActionCommand();
        if (e.getSource() instanceof JButton) {
            if ("Enviar".equals(actionCommand)) {
            	try {
            		motor.batch("src/clp/expertSystemProject.CLP");
            		motor.reset();
					motor.assertString("(planta (nombre '"+(String)cbPlanta.getSelectedItem()+"')"
					+"(profundidadDelSuelo " + TProfundidad.getText()+")"
					+"(texturaDelSuelo '"+TTextura.getText()+"') (phDelSuelo "+ TPh.getText()+") (fotoperiodo '"+ TFotoperiodo.getText()+"'))");
					motor.assertString("(zonaSeleccionada (nombre '"+(String)cbZona.getSelectedItem()+"'))");
					motor.run();
					motor.executeCommand("(facts)");
					String text = "";
					
					Iterator it = motor.listFacts();
					Fact faux;
					
					while(it.hasNext()) {
						faux = (Fact) it.next();
						if(faux.getName().equals("MAIN::respuesta")) {
							text+=faux.getSlotValue("print");
						}
					}
					textArea.setText(text);
            	} catch (JessException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
            }
        }
    }
}

