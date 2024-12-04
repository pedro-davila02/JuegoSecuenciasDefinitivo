import UIKit

class JuegoViewController: UIViewController {

    // Referencias de las imágenes y botones

    @IBOutlet weak var botonImg1: UIButton!
    @IBOutlet weak var botonImg2: UIButton!
    @IBOutlet weak var botonImg3: UIButton!
    @IBOutlet weak var botonImg4: UIButton!
    @IBOutlet weak var verPuntuacionesLocales: UIButton!

    var botonPulsado = 0
    var puntuacionTotal = 0
  

    override func viewDidLoad() {
        super.viewDidLoad()
        inicio()
        
    }

    func inicio() {
        verPuntuacionesLocales.isEnabled = false
        verPuntuacionesLocales.alpha = 0.6
    }



    @IBAction func botonSeleccionado(_ sender: UIButton) {
        if sender.tag == imagen1 || sender.tag == imagen2 {
            puntuacionTotal += 25
            sender.isEnabled = false
        } else {
            puntuacionTotal -= 20
        }

        botonPulsado += 1
        finPartida()
    }

    func finPartida() {
        if botonPulsado >= 2 {
            botonImg1.isEnabled = false
            botonImg2.isEnabled = false
            botonImg3.isEnabled = false
            botonImg4.isEnabled = false

        

            verPuntuacionesLocales.isEnabled = true
            verPuntuacionesLocales.alpha = 1
            puntuacionActual = puntuacionTotal
        }
    }

    @IBAction func verPuntuacionPulsado(_ sender: Any) {
        usuario.score = puntuacionActual
        puntuaciones.insert(usuario, at: 0)
        performSegue(withIdentifier: "toPuntuacionesLocales", sender: nil)
    }
}
