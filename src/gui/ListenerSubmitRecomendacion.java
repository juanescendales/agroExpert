package gui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Iterator;

import javax.swing.JButton;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import jess.Rete;
import jess.Fact;
import jess.JessException;



public class ListenerSubmitRecomendacion implements ActionListener {

	 JTextField TAltitud;
	 JTextField TTemperatura;
	 JTextField TPrecipitacion;
	 JTextField TProfundidad;
	 JTextField THumedadAbsoluta;
	 JTextField TVaporDeAgua;
	 JTextField THumedadRelativa;
	 JTextField TTextura;
	 JTextField TPh;
	 JTextField TFotoperiodo;
	 JTextArea textArea;
	 
	 Rete motor;

	 
    public ListenerSubmitRecomendacion(JTextField TAltitud,
    		JTextField TTemperatura,
    		JTextField TPrecipitacion,
    		JTextField TProfundidad,
    		JTextField THumedadRelativa,
    		JTextField THumedadAbsoluta,
    		JTextField TVaporDeAgua,
    		JTextField TTextura,
    		JTextField TPh,
    		JTextField TFotoperiodo,
    		JTextArea textArea) throws JessException {
    	
    	this.TAltitud = TAltitud;
        this.TTemperatura = TTemperatura;
        this.TPrecipitacion = TPrecipitacion;
        this.TProfundidad = TProfundidad;
        this.THumedadRelativa = THumedadRelativa;
        this.THumedadAbsoluta = THumedadAbsoluta;
        this.TVaporDeAgua = TVaporDeAgua;
        this.TTextura = TTextura;
        this.TPh = TPh;
        this.TFotoperiodo = TFotoperiodo;
        this.textArea = textArea;
        
        motor = new Rete();
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String actionCommand = e.getActionCommand();
        if (e.getSource() instanceof JButton) {
            if ("Enviar".equals(actionCommand)) {
            	try {
            		motor.batch("src/clp/expertSystemProject.CLP");
            		motor.reset();
					motor.assertString("(planta (nombre 'cafe') (altitud "+ TAltitud.getText()+") (temperatura "+TTemperatura.getText()
					+") (precipitacion " + TPrecipitacion.getText() + ") (profundidadDelSuelo " + TProfundidad.getText()+") (humedadRelativa "
					+ THumedadRelativa.getText() + ") (texturaDelSuelo "+TTextura.getText()+") (phDelSuelo "+ TPh.getText()+") (fotoperiodo '"+ TFotoperiodo.getText()+"'))");
					motor.run();
					motor.executeCommand("(facts)");
					String text = "";
					
					Iterator it = motor.listFacts();
					Fact faux;
					
					while(it.hasNext()) {
						faux = (Fact) it.next();
						if(faux.getName().equals("MAIN::respuesta")) {
							System.out.println("funciona");
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

