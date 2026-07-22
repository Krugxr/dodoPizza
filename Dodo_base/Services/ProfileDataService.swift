import Foundation

// MARK: - Service



protocol IProfileDataService {
    func fetchProfileData(completion: @escaping (Result<[ProfileData], NetworkError>) -> Void)
    func fetchProfileData() async throws -> [ProfileData] 
}

final class ProfileDataService: IProfileDataService {
    
    //static let shared = ProfileDataService()
    
    //private init() {}
    
    private let urlString = "http://localhost:3001/profileData"
    
    // MARK: - Completion Handler версия
    func fetchProfileData(completion: @escaping (Result<[ProfileData], NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                // Ошибка запроса (нет интернета, таймаут и т.д.)
                if let error = error {
                    completion(.failure(.requestError))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.requestError))
                    return
                }
                
                // Проверка статуса ответа
                switch httpResponse.statusCode {
                case 200...299:
                    break // успех
                case 400...499:
                    completion(.failure(.clientError))
                    return
                case 500...599:
                    completion(.failure(.serverError))
                    return
                default:
                    completion(.failure(.requestError))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.badJSON))
                    return
                }
                
                // Парсинг JSON
                do {
                    let decoder = JSONDecoder()
                    let items = try decoder.decode([ProfileData].self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(.parsingError(error)))
                }
            }
        }.resume()
    }
    
    // MARK: - Async/Await версия (рекомендуется)
    func fetchProfileData() async throws -> [ProfileData] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestError
        }
        
        // Обработка HTTP статусов
        switch httpResponse.statusCode {
        case 200...299:
            break
        case 400...499:
            throw NetworkError.clientError
        case 500...599:
            throw NetworkError.serverError
        default:
            throw NetworkError.requestError
        }
        
        // Парсинг
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([ProfileData].self, from: data)
        } catch {
            throw NetworkError.parsingError(error)
        }
    }
}

