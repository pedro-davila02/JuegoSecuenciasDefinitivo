import Foundation

class Usuario {
    var name: String
    var score: Int
    
    // Inicializador estándar
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    
    // Inicializador que recibe un diccionario JSON
    init(json: [String: Any]) {
        // Usamos el valor por defecto en caso de que no exista la clave
        self.name = json["name"] as? String ?? ""
        self.score = json["score"] as? Int ?? 0
    }
    
    // Inicializador por defecto (sin parámetros)
    init() {
        self.name = ""
        self.score = 0
    }

    // Método para validar el nombre del usuario
    func tieneCaracteresEspeciales(texto: String) -> Bool {
        let especiales = "!¡$%/()?¿+-*,.;:{}[]"
        for letra in texto {
            for especial in especiales {
                if letra == especial {
                    return true
                }
            }
        }
        return false
    }

    // Validar que el nombre sea válido: no vacío, no contenga números ni caracteres especiales
    func validarNombre(name: String) -> Bool {
        if name.isEmpty {
            return false
        }
        let maximo10Letras = name.count <= 10
        let primeraLetra = !name.first!.isNumber
        let sinEspeciales = !tieneCaracteresEspeciales(texto: name)
        return maximo10Letras && primeraLetra && sinEspeciales
    }
}
