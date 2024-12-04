import UIKit

class PuntuacionesOnlineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
@IBOutlet weak var tablaPuntuacionesOnline: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        tablaPuntuacionesOnline.dataSource = self
        tablaPuntuacionesOnline.delegate = self
        peticionGET()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "onlineScoreCell", for: indexPath)
        let usuario = users[indexPath.row]
        celda.textLabel?.text = "\(usuario.name): \(usuario.score)"
        return celda
    }


    

    func peticionGET() {
        // Construir la URL para la solicitud GET
        guard let urlAPI = URL(string: "https://qhavrvkhlbmsljgmbknr.supabase.co/rest/v1/scores?select=*") else {
            print("Error al construir la URL")
            return
        }
        
        var solicitudGet = URLRequest(url: urlAPI)
        solicitudGet.httpMethod = "GET"
        solicitudGet.addValue(apikey, forHTTPHeaderField: "apikey")
        
        URLSession.shared.dataTask(with: solicitudGet) { (data, response, error) in
            if let error = error {
                print("Error en la petición GET: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // Si la respuesta es correcta, intentar convertir el JSON
                    if let data = data {
                        do {
                            // Intentar parsear los datos en formato JSON
                            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                            users.removeAll()
                            
                            // Aquí añadimos los usuarios obtenidos del JSON
                            for user in json as! [[String: Any]] {
                                users.append(Usuario(json: user))
                            }
                            
                            // Recargar la tabla con los datos obtenidos
                            DispatchQueue.main.async {
                                self.tablaPuntuacionesOnline.reloadData()
                            }
                        } catch let errorJson {
                            print("Error al parsear JSON: \(errorJson.localizedDescription)")
                        }
                    }
                } else {
                    print("Error en la respuesta GET, Código HTTP: \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }
}
