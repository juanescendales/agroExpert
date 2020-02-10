package gui;

import java.awt.Dimension;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import java.awt.Font;
import javax.swing.SwingConstants;

import java.awt.BorderLayout;
import java.awt.Color;
import javax.swing.UIManager;

import jess.ConsolePanel;
import jess.JessException;
import jess.Rete;


import javax.swing.JComboBox;
import javax.swing.BorderFactory;
import javax.swing.DefaultComboBoxModel;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;




@SuppressWarnings("serial")
public class InterfazDelSE extends JFrame {
	private JTextField TTextura;
	private JTextField TPh;
	private JTextField TFotoperiodo;
	
	

	public InterfazDelSE(String textura,ConsolePanel c,Rete motor) throws JessException {
		
        
		
		// Asignar nombre a la ventana
		super("AgroExpert");
		
		
		// Asignar aspectos basicos de la ventana
		this.setMinimumSize(new Dimension(250, 350));
		this.setSize(824, 627);
		this.setVisible(true);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setLocationRelativeTo(null);
		
		//Consola de Jess (Rete)
		ConsolePanel console = c;

		// Menu
		JMenuBar menuBar = new JMenuBar();
		this.setJMenuBar(menuBar);

		JMenu archivo = new JMenu("Archivo");
		JMenu ayuda = new JMenu("Ayuda");

		JMenuItem salir = new JMenuItem("Salir");
		JMenuItem ver_ayuda = new JMenuItem("Ver ayuda");
		JMenuItem info = new JMenuItem("Acerca de nosotros");

		salir.setActionCommand("Salir");
		salir.addActionListener(new ListenerMenu());

		ver_ayuda.setActionCommand("Ayuda");
		ver_ayuda.addActionListener(new ListenerMenu());

		info.setActionCommand("Info");
		info.addActionListener(new ListenerMenu());

		menuBar.add(archivo);
		menuBar.add(ayuda);

		archivo.add(salir);

		ayuda.add(ver_ayuda);
		ayuda.add(info);
		getContentPane().setLayout(null);
		
		JLabel Titulo = new JLabel("REQUERIMIENTOS AGROECOL\u00D3GICOS DEL CULTIVO");
		Titulo.setHorizontalAlignment(SwingConstants.CENTER);
		Titulo.setFont(new Font("Tahoma", Font.BOLD, 27));
		Titulo.setBounds(27, 13, 749, 40);
		getContentPane().add(Titulo);
		
		JLabel LTS = new JLabel("Textura del suelo: ");
		LTS.setFont(new Font("Tahoma", Font.BOLD, 15));
		LTS.setBounds(27, 84, 151, 16);
		getContentPane().add(LTS);
		
		JLabel LPh = new JLabel("Ph del suelo: ");
		LPh.setFont(new Font("Tahoma", Font.BOLD, 15));
		LPh.setBounds(27, 132, 151, 16);
		getContentPane().add(LPh);
		
		JLabel LFP = new JLabel("Fotoperiodo: ");
		LFP.setFont(new Font("Tahoma", Font.BOLD, 15));
		LFP.setBounds(27, 177, 151, 16);
		getContentPane().add(LFP);
		
		TTextura = new JTextField(textura);
		TTextura.setHorizontalAlignment(SwingConstants.CENTER);
		TTextura.setBackground(UIManager.getColor("Button.background"));
		TTextura.setBounds(242, 82, 116, 22);
		getContentPane().add(TTextura);
		TTextura.setColumns(10);
		
		TPh = new JTextField();
		TPh.setHorizontalAlignment(SwingConstants.CENTER);
		TPh.setBounds(242, 130, 116, 22);
		getContentPane().add(TPh);
		TPh.setColumns(10);
		
		TFotoperiodo = new JTextField();
		TFotoperiodo.setHorizontalAlignment(SwingConstants.CENTER);
		TFotoperiodo.setBounds(242, 175, 116, 22);
		getContentPane().add(TFotoperiodo);
		TFotoperiodo.setColumns(10);
		
		JLabel lblNewLabel_5 = new JLabel("Ph");
		lblNewLabel_5.setBounds(370, 133, 56, 16);
		getContentPane().add(lblNewLabel_5);
		
		JLabel lblNewLabel_6 = new JLabel("horas");
		lblNewLabel_6.setBounds(370, 178, 56, 16);
		getContentPane().add(lblNewLabel_6);
		
		JTextArea textArea = new JTextArea();
		textArea.setBounds(438, 82, 333, 219);
		getContentPane().add(textArea);
	
		
		JLabel lblZona = new JLabel("Zona: ");
		lblZona.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblZona.setBounds(27, 221, 151, 16);
		getContentPane().add(lblZona);
		
		JComboBox cbZona = new JComboBox();
		cbZona.setModel(new DefaultComboBoxModel(new String[] {"Palestina", "Armenia", "Yopal", "Medellin", "Popayan", "Villavicencio", "Palmira", "Pasto", "Florencia", "Aguazul"}));
		cbZona.setBounds(242, 219, 116, 22);
		getContentPane().add(cbZona);
		
		JLabel lblPlanta = new JLabel("Planta: ");
		lblPlanta.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblPlanta.setBounds(27, 267, 151, 16);
		getContentPane().add(lblPlanta);
		
		JComboBox cbPlanta = new JComboBox();
		cbPlanta.setModel(new DefaultComboBoxModel(new String[] {"CAFE", "CACAO"}));
		cbPlanta.setBounds(242, 265, 116, 22);
		getContentPane().add(cbPlanta);
		
		JButton sendButton = new JButton("Obtener recomendacion");
		sendButton.setBackground(Color.WHITE);
		sendButton.setActionCommand("Enviar");
		sendButton.addActionListener(new ListenerSubmitRecomendacion(
				cbPlanta,
				cbZona,
	    		TTextura,
	    		TPh,
	    		TFotoperiodo,
	    		textArea,
	    		motor));

		sendButton.setBounds(325, 331, 178, 29);
		getContentPane().add(sendButton);
		
		JPanel consolePanel = new JPanel();
		consolePanel.setLayout(new BorderLayout());
		consolePanel.setBounds(10, 376, 786, 168);
		consolePanel.add(console, BorderLayout.CENTER);
		consolePanel.setBorder(BorderFactory.createEmptyBorder(0,10,10,10));
		getContentPane().add(consolePanel);
		
	}
}
