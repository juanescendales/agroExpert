package gui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JTextArea;
import javax.swing.JTextField;


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


    public ListenerSubmitRecomendacion(JTextField TAltitud,
    		JTextField TTemperatura,
    		JTextField TPrecipitacion,
    		JTextField TProfundidad,
    		JTextField THumedadRelativa,
    		JTextField THumedadAbsoluta,
    		JTextField TVaporDeAgua,
    		JTextField TTextura,
    		JTextField TPh,
    		JTextField TFotoperiodo) {
    	
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

    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String actionCommand = e.getActionCommand();
        if (e.getSource() instanceof JButton) {
            if ("Enviar".equals(actionCommand)) {
               
                
            }
        }
    }
}

