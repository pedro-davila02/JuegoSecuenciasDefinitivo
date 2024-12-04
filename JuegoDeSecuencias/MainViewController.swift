import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var ingresarNombre: UITextField!
    @IBOutlet weak var botonStart: UIButton!
    @IBOutlet weak var imagenCereza: UIImageView!
    @IBOutlet weak var imagenMango: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inicio()
        usuario = Usuario() // Inicializa un nuevo usuario
        configurarJuego()
        
       
    }
    
    func configurarJuego() {
        imagen1 = Int.random(in: 0...3)
       imagen2 = Int.random(in: 0...3)

        while imagen1 == imagen2 {
            imagen2 = Int.random(in: 0...3)
        }

      

        imagenCereza.image = listaImagenes[imagen1]
        imagenMango.image = listaImagenes[imagen2]
       
    }

    func inicio() {
        botonStart.isEnabled = false
        botonStart.alpha = 0.6
    }

    func error() {
        botonStart.setTitle("NOMBRE INCORRECTO", for: .normal)
        botonStart.isEnabled = false
        botonStart.alpha = 0.6
    }

    func nombreValido() {
        botonStart.setTitle("JUGAR", for: .normal)
        botonStart.isEnabled = true
        botonStart.alpha = 1
    }

    @IBAction func escribirNombre(_ sender: Any) {
        let valido = usuario.validarNombre(name: ingresarNombre.text!)
        if valido {
            usuario.name = ingresarNombre.text!
            nombreValido()
        } else {
            error()
        }
    }
    

    @IBAction func startPulsado(_ sender: UIButton) {
        performSegue(withIdentifier: "toJuego", sender: nil)
    }
}



