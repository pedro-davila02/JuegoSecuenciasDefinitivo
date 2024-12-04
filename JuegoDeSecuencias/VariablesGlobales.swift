import UIKit

// Usuario actual que está jugando
var usuario = Usuario()

// Array de puntuaciones locales
var puntuaciones: [Usuario] = []

// Array de usuarios con puntuaciones online
var users: [Usuario] = []

// Puntuación acumulada en la partida actual
var puntuacionActual = 0

var imagen1 = -1

var imagen2 = -1

// Lista de imágenes del juego
let listaImagenes: [UIImage?] = [
    UIImage(named: "cereza"),
    UIImage(named: "mango"),
    UIImage(named: "manzana_verde"),
    UIImage(named: "manzana")
   
]

// API Key para las solicitudes online
let apikey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFoYXZydmtobGJtc2xqZ21ia25yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA3MjY5MTgsImV4cCI6MjAxNjMwMjkxOH0.Ta-_lXGGwSiUGh0VC8tAFcFQqsqAvB8vvXJjubeQkx8"
