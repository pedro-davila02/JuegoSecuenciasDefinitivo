import UIKit

class PuntuacionLocalesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tablaPuntuaciones: UITableView!
    
    @IBOutlet weak var resultadoActual: UILabel!
    
    @IBOutlet weak var publicarPuntuacion: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaPuntuaciones.dataSource = self
        tablaPuntuaciones.delegate = self
        resultadoActual.text = "RESULTADO ACTUAL: \(puntuacionActual)"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return puntuaciones.count    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "IdCelda", for: indexPath)
        let puntuacion = puntuaciones[indexPath.row]
        celda.textLabel?.text = "\(puntuacion.name): \(puntuacion.score)"
        return celda
    }


    @IBAction func verPuntuacionesOnline(_ sender: UIButton) {
        performSegue(withIdentifier: "toPuntuacionesOnline", sender: nil)
    }

    @IBAction func publicarPuntuacion(_ sender: UIButton) {
        peticionPOST()
    }

    func peticionPOST() {
        guard let urlAPI = URL(string: "https://qhavrvkhlbmsljgmbknr.supabase.co/rest/v1/scores") else { return }

        var solicitudPOST = URLRequest(url: urlAPI)
        solicitudPOST.httpMethod = "POST"
        solicitudPOST.addValue(apikey, forHTTPHeaderField: "apikey")
        solicitudPOST.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let parametros = "name=\(usuario.name)&score=\(usuario.score)"
        solicitudPOST.httpBody = parametros.data(using: .utf8)

        URLSession.shared.dataTask(with: solicitudPOST) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("Error en la petición POST: \(error?.localizedDescription ?? "Desconocido")")
                self.peticionPATCH()
                return
            }

            DispatchQueue.main.async {
                if httpResponse.statusCode == 201 {
                    self.cambiarEstadoBotonSubirPuntuacion(subirModificar: true)
                } else {
                    self.peticionPATCH()
                }
            }
        }.resume()
    }

    func peticionPATCH() {
        guard let urlPATCH = URL(string: "https://qhavrvkhlbmsljgmbknr.supabase.co/rest/v1/scores?name=eq.\(usuario.name)") else { return }

        var solicitudPATCH = URLRequest(url: urlPATCH)
        solicitudPATCH.httpMethod = "PATCH"
        solicitudPATCH.addValue(apikey, forHTTPHeaderField: "apikey")
        solicitudPATCH.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parametros = ["score": usuario.score]
        solicitudPATCH.httpBody = try? JSONSerialization.data(withJSONObject: parametros)

        URLSession.shared.dataTask(with: solicitudPATCH) { (data, response, error) in
            DispatchQueue.main.async {
                self.cambiarEstadoBotonSubirPuntuacion(subirModificar: false)
            }
        }.resume()
    }

    func cambiarEstadoBotonSubirPuntuacion(subirModificar: Bool) {
        publicarPuntuacion.isEnabled = false
        publicarPuntuacion.alpha = 0.6
        publicarPuntuacion.setTitle(subirModificar ? "PUNTUACIÓN SUBIDA" : "PUNTUACIÓN MODIFICADA", for: .normal)
    }
}
