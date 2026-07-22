import Foundation

protocol IProductServiсe {
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>)->())
}

final class ProductServiсe: IProductServiсe {
    
    let session = URLSession.shared //session -> http request
    let decoder = JSONDecoder()     //parse json model -> swift model

    
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>)->()) {
        
        guard let url = URL(string: "http://localhost:3001/products") else {
            completion(.failure(.badUrl))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completion(.failure(.requestError))
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                switch httpResponse.statusCode {
                case 400...499:
                    completion(.failure(.clientError))
                    
                case 500...599:
                    completion(.failure(.serverError))
                  
                default:
                    break
                }
            }
                
            guard let data else {
                completion(.failure(.badJSON))
                return
            }
            
            do {
                let products = try self.decoder.decode([Product].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(products))
                }
                
            } catch {
                print(error)
                completion(.failure(.parsingError(error)))
            }
        }.resume()
    }
    
    
    
//    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
//        
//        URLSession.shared.dataTask(with: URL(string: "http://localhost:3001/products")!) { data, _, error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//                
//                guard let data = data else {
//                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет данных"])))
//                    return
//                }
//                
//                do {
//                    let products = try JSONDecoder().decode([Product].self, from: data)
//                    completion(.success(products))
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//        }.resume()
//    }
}
