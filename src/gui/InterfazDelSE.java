package gui;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Font;
import javax.swing.SwingConstants;
import java.awt.Color;
import java.awt.SystemColor;
import javax.swing.UIManager;

import jess.JessException;

import javax.swing.JTabbedPane;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.util.Iterator;
import java.awt.Button;


@SuppressWarnings("serial")
public class InterfazDelSE extends JFrame {
	private JTextField TAltitud;
	private JTextField TTemperatura;
	private JTextField TPrecipitacion;
	private JTextField TProfundidad;
	private JTextField THumedadAbsoluta;
	private JTextField TVaporDeAgua;
	private JTextField THumedadRelativa;
	private JTextField TTextura;
	private JTextField TPh;
	private JTextField TFotoperiodo;
	
	

	public InterfazDelSE(String textura) throws JessException {
		super("AgroExpert");
        
		
		// Asignar nombre a la ventana
		
		
		// Asignar aspectos basicos de la ventana
		this.setMinimumSize(new Dimension(250, 350));
		this.setSize(824, 530);
		this.setVisible(true);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setLocationRelativeTo(null);

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
		
		JLabel LAltitud = new JLabel("Altitud: ");
		LAltitud.setFont(new Font("Tahoma", Font.BOLD, 15));
		LAltitud.setBounds(27, 82, 151, 16);
		getContentPane().add(LAltitud);
		
		JLabel LTemperatura = new JLabel("Temperatura: ");
		LTemperatura.setFont(new Font("Tahoma", Font.BOLD, 15));
		LTemperatura.setBounds(27, 111, 151, 16);
		getContentPane().add(LTemperatura);
		
		JLabel LPrecipitacion = new JLabel("Precipitación: ");
		LPrecipitacion.setFont(new Font("Tahoma", Font.BOLD, 15));
		LPrecipitacion.setBounds(27, 140, 151, 16);
		getContentPane().add(LPrecipitacion);
		
		JLabel LProfundidad = new JLabel("Profundidad: ");
		LProfundidad.setFont(new Font("Tahoma", Font.BOLD, 15));
		LProfundidad.setBounds(27, 169, 151, 16);
		getContentPane().add(LProfundidad);
		
		JLabel LHR = new JLabel("Humedad relativa: ");
		LHR.setFont(new Font("Tahoma", Font.BOLD, 15));
		LHR.setBounds(27, 203, 151, 16);
		getContentPane().add(LHR);
		
		JLabel LHA = new JLabel("Humedad absoluta: ");
		LHA.setFont(new Font("Tahoma", Font.BOLD, 15));
		LHA.setBounds(69, 232, 151, 16);
		getContentPane().add(LHA);
		
		JLabel LVA = new JLabel("Vapor de agua: ");
		LVA.setFont(new Font("Tahoma", Font.BOLD, 15));
		LVA.setBounds(69, 261, 151, 16);
		getContentPane().add(LVA);
		
		JLabel LTS = new JLabel("Textura del suelo: ");
		LTS.setFont(new Font("Tahoma", Font.BOLD, 15));
		LTS.setBounds(27, 290, 151, 16);
		getContentPane().add(LTS);
		
		JLabel LPh = new JLabel("Ph del suelo: ");
		LPh.setFont(new Font("Tahoma", Font.BOLD, 15));
		LPh.setBounds(27, 319, 151, 16);
		getContentPane().add(LPh);
		
		JLabel LFP = new JLabel("Fotoperiodo: ");
		LFP.setFont(new Font("Tahoma", Font.BOLD, 15));
		LFP.setBounds(27, 348, 151, 16);
		getContentPane().add(LFP);
		
		TAltitud = new JTextField();
		TAltitud.setHorizontalAlignment(SwingConstants.CENTER);
		TAltitud.setBounds(242, 80, 116, 22);
		getContentPane().add(TAltitud);
		TAltitud.setColumns(10);
		
		TTemperatura = new JTextField();
		TTemperatura.setHorizontalAlignment(SwingConstants.CENTER);
		TTemperatura.setBounds(242, 109, 116, 22);
		getContentPane().add(TTemperatura);
		TTemperatura.setColumns(10);
		
		TPrecipitacion = new JTextField();
		TPrecipitacion.setHorizontalAlignment(SwingConstants.CENTER);
		TPrecipitacion.setBounds(242, 138, 116, 22);
		getContentPane().add(TPrecipitacion);
		TPrecipitacion.setColumns(10);
		
		TProfundidad = new JTextField();
		TProfundidad.setHorizontalAlignment(SwingConstants.CENTER);
		TProfundidad.setBounds(242, 167, 116, 22);
		getContentPane().add(TProfundidad);
		TProfundidad.setColumns(10);
		
		THumedadAbsoluta = new JTextField();
		THumedadAbsoluta.addKeyListener(new KeyAdapter() {
			@Override
			public void keyReleased(KeyEvent arg0) {
				try {
					double HA = Double.parseDouble(THumedadAbsoluta.getText());
					double VA = Double.parseDouble(TVaporDeAgua.getText());
			        double hr=HA/VA;
			        THumedadRelativa.setText(Double.toString(Math.round(hr* 100.0)/100.0));

			    } catch (Exception e) {

			    	THumedadRelativa.setText("0");

			    }
			}
		});
		THumedadAbsoluta.setHorizontalAlignment(SwingConstants.CENTER);
		THumedadAbsoluta.setBounds(242, 230, 116, 22);
		getContentPane().add(THumedadAbsoluta);
		THumedadAbsoluta.setColumns(10);
		
		
		TVaporDeAgua = new JTextField();
		TVaporDeAgua.addKeyListener(new KeyAdapter() {
			@Override
			public void keyReleased(KeyEvent arg0) {
				try {
					double HA = Double.parseDouble(THumedadAbsoluta.getText());
					double VA = Double.parseDouble(TVaporDeAgua.getText());
			        double hr=HA/VA;
			        THumedadRelativa.setText(Double.toString(Math.round(hr* 100.0)/100.0));

			    } catch (Exception e) {

			    	THumedadRelativa.setText("0");

			    }
			}
		});
		TVaporDeAgua.setHorizontalAlignment(SwingConstants.CENTER);
		TVaporDeAgua.setBounds(242, 259, 116, 22);
		getContentPane().add(TVaporDeAgua);
		TVaporDeAgua.setColumns(10);
		
		THumedadRelativa = new JTextField();
		THumedadRelativa.setHorizontalAlignment(SwingConstants.CENTER);
		THumedadRelativa.setBackground(UIManager.getColor("Button.background"));
		THumedadRelativa.setBounds(242, 201, 116, 22);
		getContentPane().add(THumedadRelativa);
		THumedadRelativa.setColumns(10);
		
		TTextura = new JTextField(textura);
		TTextura.setHorizontalAlignment(SwingConstants.CENTER);
		TTextura.setBackground(UIManager.getColor("Button.background"));
		TTextura.setBounds(242, 288, 116, 22);
		getContentPane().add(TTextura);
		TTextura.setColumns(10);
		
		TPh = new JTextField();
		TPh.setHorizontalAlignment(SwingConstants.CENTER);
		TPh.setBounds(242, 317, 116, 22);
		getContentPane().add(TPh);
		TPh.setColumns(10);
		
		TFotoperiodo = new JTextField();
		TFotoperiodo.setHorizontalAlignment(SwingConstants.CENTER);
		TFotoperiodo.setBounds(242, 346, 116, 22);
		getContentPane().add(TFotoperiodo);
		TFotoperiodo.setColumns(10);
		
		JLabel lblNewLabel = new JLabel("metros");
		lblNewLabel.setBounds(367, 83, 56, 16);
		getContentPane().add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("grados centigrados");
		lblNewLabel_1.setBounds(367, 112, 116, 15);
		getContentPane().add(lblNewLabel_1);
		
		JLabel lblNewLabel_2 = new JLabel("mm");
		lblNewLabel_2.setBounds(367, 141, 56, 16);
		getContentPane().add(lblNewLabel_2);
		
		JLabel lblNewLabel_3 = new JLabel("cm");
		lblNewLabel_3.setBounds(367, 170, 56, 16);
		getContentPane().add(lblNewLabel_3);
		
		JLabel lblNewLabel_4 = new JLabel("RH");
		lblNewLabel_4.setBounds(367, 204, 56, 16);
		getContentPane().add(lblNewLabel_4);
		
		JLabel lblNewLabel_5 = new JLabel("Ph");
		lblNewLabel_5.setBounds(367, 320, 56, 16);
		getContentPane().add(lblNewLabel_5);
		
		JLabel lblNewLabel_6 = new JLabel("horas");
		lblNewLabel_6.setBounds(367, 349, 56, 16);
		getContentPane().add(lblNewLabel_6);
		
		JTextArea textArea = new JTextArea();
		textArea.setBounds(507, 82, 264, 286);
		getContentPane().add(textArea);
		
		JButton button = new JButton("Obtener recomendacion");
		button.setBackground(Color.WHITE);
		button.setActionCommand("Enviar");
		button.addActionListener(new ListenerSubmitRecomendacion(TAltitud,
	    		TTemperatura,
	    		TPrecipitacion,
	    		TProfundidad,
	    		THumedadRelativa,
	    		THumedadAbsoluta,
	    		TVaporDeAgua,
	    		TTextura,
	    		TPh,
	    		TFotoperiodo,
	    		textArea));
		button.setBounds(323, 406, 178, 29);
		getContentPane().add(button);

	}
}
