import Foundation

protocol IIngredientService {
    func fetchIngridients(completion: @escaping (Result<[Ingridient], Error>)->())
}

final class IngredientService: IIngredientService {
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func fetchIngridients(completion: @escaping (Result<[Ingridient], Error>)->()) {
        guard let url = URL(string: "http://localhost:3001/ingridients")
        else {return}
        
        session.dataTask(with: url) { data, response, error in
            guard let data else { return }
            
            do {
                let ingridients = try self.decoder.decode([Ingridient].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(ingridients))
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}


