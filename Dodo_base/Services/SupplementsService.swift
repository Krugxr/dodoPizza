import Foundation

protocol ISupplementsService {
    func fetchSupplements (completion: @escaping (Result<[Product], Error>)->())
}

final class SupplementsService: ISupplementsService {
    let session = URLSession.shared //session -> http request
    let decoder = JSONDecoder()     //parse json model -> swift model
    
    
    func fetchSupplements (completion: @escaping (Result<[Product], Error>)->()) {
        
        guard let url = URL(string: "http://localhost:3001/supplements") else { return }
        
        session.dataTask(with: url) { data, response, error in
            
            guard let data else { return }
            
            do {
                let supplements = try self.decoder.decode([Product].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(supplements))
                }
                
            } catch {
                print(error)
            }
        }.resume()
    }
}
