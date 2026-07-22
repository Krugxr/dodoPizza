import Foundation


protocol IBannerServise {
    func fetchBanners(completion: @escaping (Result<[Product], Error>)->())
    
}

final class BannerServise: IBannerServise {
    let session = URLSession.shared //session -> http request
    let decoder = JSONDecoder()     //parse json model -> swift model
    
    
    func fetchBanners(completion: @escaping (Result<[Product], Error>)->()) {
        
        guard let url = URL(string: "http://localhost:3001/banners") else { return }
        
        session.dataTask(with: url) { data, response, error in
            
            guard let data else { return }
            
            do {
                let banners = try self.decoder.decode([Product].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(banners))
                }
                
            } catch {
                print(error)
            }
        }.resume()
    }
}


