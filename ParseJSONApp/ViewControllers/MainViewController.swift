
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var episodeTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func showResponseButtonPressed() {
        guard let url = URL(
            string: Links.episodes.rawValue + (episodeTextField.text ?? "1")
        ) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let episode = try JSONDecoder().decode(Episode.self, from: data)
                print(episode)
                
                guard let imageUrl = URL(string: episode.data.thumbnail_url) else { return }
                URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, error in
                    guard let data = data else {
                        print(error?.localizedDescription ?? "No error description")
                        return
                    }
                    guard let image = UIImage(data: data) else { return }
                    
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }.resume()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
