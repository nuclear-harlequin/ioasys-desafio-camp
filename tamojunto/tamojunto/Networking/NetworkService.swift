//
//  NetworkService.swift
//  tamojunto
//
//  Created by Giovanna Toni on 13/04/22.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case patch = "PATCH"
    }
    
    var header: [AnyHashable: Any]?
    
    private init() {}
    
    func makeUrlRequest<T: Decodable>(route: TamoJunto,
                                      method: Method,
                                      header: [String:String]?,
                                      body: Data?,
                                      parameters: [String:String]?,
                                      resultHandler: @escaping (Result<T, RequestError>) -> Void) {
        
        guard let request = createRequest(route: route, method: method, header: header, body: body, parameters: parameters) else { return }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription)
                resultHandler(.failure(.clientError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                resultHandler(.failure(.serverError))
                return
            }
            print(response)
            self.header = response.allHeaderFields
            
            guard let data = data else {
                resultHandler(.failure(.noData))
                return
            }
            print(data)
            
            guard let decodedData = self.decodeFromJSON(type: T.self, data: data) else {
                resultHandler(.failure(.dataDecodingError))
                return
            }
//            print(decodedData)
            resultHandler(.success(decodedData))
        }.resume()
    }
    
    private func createRequest(route: TamoJunto,
                               method: Method,
                               header: [String:String]?,
                               body: Data?,
                               parameters: [String:String]?) -> URLRequest? {
        
        let urlString = TamoJunto.baseUrl + route.path
        guard let url = URL(string: urlString) else
            {
                print("No URL")
                return nil
            }
        print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        
        return urlRequest
    }
    
    func encodeToJSON<T: Encodable>(data: T) -> Data? {
        do {
            return try JSONEncoder().encode(data)
        } catch {
            return nil
        }
    }

    func decodeFromJSON<T: Decodable>(type: T.Type, data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
    
    func getHeaderValue(forKey: String) -> String {
        return header?[forKey] as? String ?? ""
    }
    
}

//class NetworkingService {

//    static let shared = NetworkingService()
//
//    var header: [AnyHashable: Any]?
//
//    private init() {}
//
//    enum TamoJunto {
//        static let baseUrl = "https://camp-tamojunto.herokuapp.com/"
//
//        case userLogin
//        case fetchBooks
//
//        var path: String {
//            switch self {
//            case .userLogin:
//                return "/auth/sign-in"
//
//            case .fetchBooks:
//                return "/books"
//
//
//            }
//        }
//    }
//
//    enum Method: String {
//        case get = "GET"
//        case post = "POST"
//        case delete = "DELETE"
//        case patch = "PATCH"
//    }
//
//    func makeRequest(url: URL,
//                     httpMethod: Method,
//                     headers: [AnyHashable: Any],
//                     parameters: [String: String],
//                     body: Data?,
//                     completion: (Result<(URLResponse,Data), Error>) -> Void) {
//
////                     method: Method,
////                     header: [String:String]?,
////                     body: Data?,
////                     completion: @escaping (_: Data, _: HTTPURLResponse) -> Void) {
//
//        guard let request = createRequest(route: route, method: method, header: header, body: body) else { return }
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else { return }
//            self.header = response.allHeaderFields
//
//            guard let data = data else {
//                print("No data retrieved")
//                return
//            }
//
//            DispatchQueue.main.async {
//                completion(data, response)
//            }
//        }.resume()
//    }
//
//    /// Function that generates URLRequest
//    /// - Parameters:
//    ///   - route: path to resource in the back-end
//    ///   - method: type of request
//    ///   - header: request headers
//    ///   - body: additional information that may be passed into the request body
//    /// - Returns: URLRequest
//    private func createRequest(route: TamoJunto,
//                               method: Method,
//                               header: [String:String]?,
//                               body: Data?) -> URLRequest? {
//
//        let urlString = TamoJunto.baseUrl + route.path
//        guard let url = urlString.asUrl else { return nil }
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.allHTTPHeaderFields = header
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        urlRequest.httpMethod = method.rawValue
//        urlRequest.httpBody = body
//
//        return urlRequest
//    }
//
//    func getHeader(forKey: String) -> String {
//        return header?[forKey] as? String ?? ""
//    }
//}

// CODIGO GUSTAVO:
//class MainPageRequest {
//    func requestInformation(completion: @escaping ((Data?, URLResponse?, Error?) -> Void)){
//
//        let url = URL(string: "https://camp-tamojunto.herokuapp.com/subjects")
//
//        guard let url = url else {
//            print("Erro na URL")
//            return
//        }
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//        urlRequest.addValue("Bearer \(authCode)", forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            completion(data, response, error)
//        }.resume()
//
//    }
//}


// DICAS BRENO
//url: String, (baseURL + url)
//httpMethod: String (enum)
//headers: [String: String],
//parameters: [String: String] (query)
//body: Data?,
//completion: (Result<(URLResponse, Data), Error>
//
//func makeRequest<Object: Encodable>(
//...,
//body: Object,
//...
//)


// NEXT STEPS:
//1a com todos os parâmetros (call que não precisa de enviar nem receber nada)
//2a com Decodable (tratar resultado)
//3a com Decodable e Encodable (enviar model e tratar resposta)
//4a com Encodable (enviar model)
