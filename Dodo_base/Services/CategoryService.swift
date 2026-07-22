
import Foundation

protocol ICategoryService {
    func fetchCategories(completion: @escaping (Result<[Category], Error>)->())
}

final class CategoryService: ICategoryService {
    let session = URLSession.shared //session -> http request
    let decoder = JSONDecoder()     //parse json model -> swift model
    
    
    func fetchCategories(completion: @escaping (Result<[Category], Error>)->()) {
        
        guard let url = URL(string: "http://localhost:3001/categories") else { return }
        
        session.dataTask(with: url) { data, response, error in
            
            guard let data else { return }
            
            do {
                let categories = try self.decoder.decode([Category].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(categories))
                }
                
            } catch {
                print(error)
            }
        }.resume()
    }
}
