//
//  MovieError.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//


// MARK: - Custom Error Enum
enum MovieError: String, Error {
    case invalidUrl             = "Url Dönüştürülemedi. Please try again."
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "The data received from the server was invalid Please try again."
}
