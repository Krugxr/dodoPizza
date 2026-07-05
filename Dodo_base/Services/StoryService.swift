
import Foundation

class StoryService {
    let session = URLSession.shared //session -> http request
    let decoder = JSONDecoder()     //parse json model -> swift model
    
    
    func fetchStories (completion: @escaping (Result<[Story], Error>)->()) {
        
        guard let url = URL(string: "http://localhost:3001/stories") else { return }
        
        session.dataTask(with: url) { data, response, error in
            
            guard let data else { return }
            
            do {
                let stories = try self.decoder.decode([Story].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(stories))
                }
                
            } catch {
                print(error)
            }
        }.resume()
    }
}
