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
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;




@SuppressWarnings("serial")
public class InterfazDelSE extends JFrame {
	private JTextField TTextura;
	private JTextField TPh;
	private JTextField TFotoperiodo;
	private JTextField TProfundidad;
	

	public InterfazDelSE(String textura,ConsolePanel c,Rete motor) throws JessException {
		
		// Asignar nombre a la ventana
		super("AgroExpert");
		
		class validator {
			public boolean validarCampo(String text){
				try {
					if(text.length()>0) {
						if(!text.substring(text.length()-1).equals(".")) {
							int n=Integer.parseInt(text.substring(text.length()-1));
						}
					}
					return true;
				}catch(Exception e) {
					return false;
				}
		    }  
        };
		
		
		// Asignar aspectos basicos de la ventana
		this.setMinimumSize(new Dimension(250, 350));
		this.setSize(470, 718);
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
		
		JLabel Titulo = new JLabel("REQUERIMIENTOS ");
		Titulo.setHorizontalAlignment(SwingConstants.CENTER);
		Titulo.setFont(new Font("Tahoma", Font.BOLD, 22));
		Titulo.setBounds(0, 13, 452, 47);
		getContentPane().add(Titulo);
		
		JLabel LTS = new JLabel("Textura del suelo: ");
		LTS.setFont(new Font("Tahoma", Font.BOLD, 15));
		LTS.setBounds(27, 135, 151, 16);
		getContentPane().add(LTS);
		
		JLabel LPh = new JLabel("Ph del suelo: ");
		LPh.setFont(new Font("Tahoma", Font.BOLD, 15));
		LPh.setBounds(27, 183, 151, 16);
		getContentPane().add(LPh);
		
		JLabel LFP = new JLabel("Fotoperiodo: ");
		LFP.setFont(new Font("Tahoma", Font.BOLD, 15));
		LFP.setBounds(27, 228, 151, 16);
		getContentPane().add(LFP);
		
		TTextura = new JTextField(textura);
		TTextura.setHorizontalAlignment(SwingConstants.CENTER);
		TTextura.setBackground(UIManager.getColor("Button.background"));
		TTextura.setBounds(242, 133, 116, 22);
		TTextura.setEditable(false);
		getContentPane().add(TTextura);
		TTextura.setColumns(10);
		
		TPh = new JTextField();
		TPh.addKeyListener(new KeyAdapter() {
			@Override
			public void keyReleased(KeyEvent arg0) {
				validator validador = new validator();
				String texto=TPh.getText();
				if(validador.validarCampo(texto)==false) {
					TPh.setText(texto.substring(0,texto.length()-1));
				}
			}
		});
		TPh.setHorizontalAlignment(SwingConstants.CENTER);
		TPh.setBounds(242, 181, 116, 22);
		getContentPane().add(TPh);
		TPh.setColumns(10);
		
		TFotoperiodo = new JTextField();
		TFotoperiodo.addKeyListener(new KeyAdapter() {
			@Override
			public void keyReleased(KeyEvent arg0) {
				validator validador = new validator();
				String texto=TFotoperiodo.getText();
				if(validador.validarCampo(texto)==false) {
					TFotoperiodo.setText(texto.substring(0,texto.length()-1));
				}
			}
		});
		TFotoperiodo.setHorizontalAlignment(SwingConstants.CENTER);
		TFotoperiodo.setBounds(242, 226, 116, 22);
		getContentPane().add(TFotoperiodo);
		TFotoperiodo.setColumns(10);
		
		JLabel lblNewLabel_5 = new JLabel("Ph");
		lblNewLabel_5.setBounds(370, 183, 56, 16);
		getContentPane().add(lblNewLabel_5);
		
		JLabel lblNewLabel_6 = new JLabel("horas");
		lblNewLabel_6.setBounds(370, 228, 56, 16);
		getContentPane().add(lblNewLabel_6);
	
		
		JLabel lblZona = new JLabel("Zona: ");
		lblZona.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblZona.setBounds(27, 321, 151, 16);
		getContentPane().add(lblZona);
		
		JComboBox cbZona = new JComboBox();
		cbZona.setModel(new DefaultComboBoxModel(new String[] {"Palestina", "Armenia", "Yopal", "Medellin", "Popayan", "Villavicencio", "Palmira", "Pasto", "Florencia", "Aguazul","cafe","cacao"}));
		cbZona.setBounds(242, 319, 116, 22);
		getContentPane().add(cbZona);
		
		JLabel lblPlanta = new JLabel("Planta: ");
		lblPlanta.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblPlanta.setBounds(27, 365, 151, 16);
		getContentPane().add(lblPlanta);
		
		JComboBox cbPlanta = new JComboBox();
		cbPlanta.setModel(new DefaultComboBoxModel(new String[] {"cafe", "cacao"}));
		cbPlanta.setBounds(242, 363, 116, 22);
		getContentPane().add(cbPlanta);
		
		JLabel lblProfundidadDelSuelo = new JLabel("Profundidad del suelo: ");
		lblProfundidadDelSuelo.setFont(new Font("Tahoma", Font.BOLD, 15));
		lblProfundidadDelSuelo.setBounds(27, 275, 203, 16);
		getContentPane().add(lblProfundidadDelSuelo);
		
		TProfundidad = new JTextField();
		TProfundidad.addKeyListener(new KeyAdapter() {
			@Override
			public void keyReleased(KeyEvent arg0) {
				validator validador = new validator();
				String texto=TProfundidad.getText();
				if(validador.validarCampo(texto)==false) {
					TProfundidad.setText(texto.substring(0,texto.length()-1));
				}
			}
		});
		TProfundidad.setHorizontalAlignment(SwingConstants.CENTER);
		TProfundidad.setColumns(10);
		TProfundidad.setBounds(242, 273, 116, 22);
		getContentPane().add(TProfundidad);
		
		JLabel lblMetros = new JLabel("metros");
		lblMetros.setBounds(370, 275, 56, 16);
		getContentPane().add(lblMetros);
		
		JButton sendButton = new JButton("Obtener recomendacion");
		sendButton.setBackground(Color.WHITE);
		sendButton.setActionCommand("Enviar");
		sendButton.addActionListener(new ListenerSubmitRecomendacion(
				cbPlanta,
				cbZona,
	    		TTextura,
	    		TPh,
	    		TFotoperiodo,
	    		TProfundidad,
	    		motor));
		sendButton.setBounds(126, 422, 178, 29);
		getContentPane().add(sendButton);
		
		JPanel consolePanel = new JPanel();
		consolePanel.setLayout(new BorderLayout());
		consolePanel.setBounds(12, 464, 426, 168);
		consolePanel.add(console, BorderLayout.CENTER);
		consolePanel.setBorder(BorderFactory.createEmptyBorder(0,10,10,10));
		getContentPane().add(consolePanel);
		
		JLabel lblAgroecolgicosdelCultivo = new JLabel("AGROECOL\u00D3GICOS DEL CULTIVO");
		lblAgroecolgicosdelCultivo.setHorizontalAlignment(SwingConstants.CENTER);
		lblAgroecolgicosdelCultivo.setFont(new Font("Tahoma", Font.BOLD, 22));
		lblAgroecolgicosdelCultivo.setBounds(0, 56, 452, 47);
		getContentPane().add(lblAgroecolgicosdelCultivo);
		
		
		
	}
}
