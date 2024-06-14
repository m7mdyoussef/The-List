
import UIKit

extension UIImage {
    static var emptyImage: UIImage {
        return UIImage()
    }
    
    static var backButton: UIImage {
        return UIImage(systemName: "chevron.backward.circle") ?? .emptyImage
    }
    
    static func downloadAndSetImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}


extension UIImageView {
    func setImage(from url: URL) {
        UIImage.downloadAndSetImage(from: url) { [weak self] image in
            self?.image = image
        }
    }
}
