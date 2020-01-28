package gui;


import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JOptionPane;
public class ListenerMenu implements ActionListener {

	@Override
	public void actionPerformed(ActionEvent e) {
		
		String actionCommand = e.getActionCommand();
		
		if ("Salir".equals(actionCommand)) {
			
			int resp = JOptionPane.showConfirmDialog(null, "¿Esta seguro que desea salir?", "¡Saliendo!", JOptionPane.YES_NO_OPTION, JOptionPane.ERROR_MESSAGE);
			
			if(resp == 0){	
				System.exit(0);
			}else if(resp == 1){
				
			}
		}else if("Info".equals(actionCommand)) {
			JOptionPane.showMessageDialog(null,"Desarrollado por: \n     Juan Esteban Cendales \n     Juan Manuel Pajoy \n     Juan Pablo Ortega", "Acerca de nosotros", JOptionPane.INFORMATION_MESSAGE);
		}else if("Ayuda".equals(actionCommand)) {
			JOptionPane.showMessageDialog(null,"Envia un correo con tus dudas al correo: \n         → jcendaless@unal.edu.co \n         → jpajoyl@unal.edu.co \n         → jportegame@unal.edu.co \n \n.","Ver ayuda", JOptionPane.INFORMATION_MESSAGE);
		}
	}
}
