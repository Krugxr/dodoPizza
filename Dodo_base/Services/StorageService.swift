import Foundation

protocol IStorageService {
    func save(_ products: [Product]) //сохраняем друзей
    func retrieve() -> [Product] //закдалываем их массивом
    func append(_ product: Product)
}

final class StorageService: IStorageService {
    
    private let encoder = JSONEncoder() //кодирует в бинарник
    private let decoder = JSONDecoder() //разкодирует
    
    private let key = "Products"
    
    func append(_ product: Product) {
        //var product = product
        var array = retrieve()
        
        
        if array .isEmpty {
            array.append(product)
            save(array)
            return
        }
            
        for (index, item) in array.enumerated() {
            if item == product {
                array[index] = array[index].increaseCount()
                save(array)
                return
            }
        }
        
        array.append(product)
        
//        if array.contains(product) {
//            product = product.increaseCount()
//        } else {
//            array.append(product)
//        }
       
        save(array)
    }
    
    //MARK: - Public methods
    func save(_ products: [Product]) { //метод сохранить
        
        //Array<Product> -> Data
        //массив кладем в бинарник и кодируем, бинарник кладем в UserDefaults
        do {
            let data = try encoder.encode(products)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    //retrieve - получить данные
    func retrieve() -> [Product] {  //метод получить
        
        //Data -> Array<Product>
        //вытаскиваем из UserDefaults бинарник
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            //раскодировали бинарник в массив
            let array = try decoder.decode(Array<Product>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
}


