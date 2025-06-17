import UIKit

class PlaceDetailViewController: UIViewController {

    var placeName: String?

    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!

    var isFavorited: Bool = false {
        didSet {
            updateFavoriteButton()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        placeNameLabel.text = placeName ?? "장소 정보 없음"
        descriptionLabel.text = "설명을 불러오는 중입니다..."

        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true

        updateFavoriteButton()
        fetchImageFromSearchAPI(query: placeName ?? "장소")
        fetchDescriptionFromGPT(query: placeName ?? "장소")
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        isFavorited.toggle()
    }

    func updateFavoriteButton() {
        let title = isFavorited ? "★ 즐겨찾기됨" : "☆ 즐겨찾기"
        favoriteButton.setTitle(title, for: .normal)
        favoriteButton.setTitleColor(isFavorited ? .systemYellow : .systemBlue, for: .normal)
    }

    func fetchImageFromSearchAPI(query: String) {
        let searchTerm = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "place"
        let urlStr = "https://source.unsplash.com/600x400/?\(searchTerm)"
        guard let url = URL(string: urlStr) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(named: "placeholder")
                }
            }
        }.resume()
    }

    func fetchDescriptionFromGPT(query: String) {
        let prompt = "\"\(query)\"라는 장소에 대해 짧고 간단하게 설명해줘. 일반인이 이해하기 쉬운 말로 소개문구처럼 써줘."
        let apiKey = "" // 🔐 여기에 실제 GPT API 키 입력

        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [["role": "user", "content": prompt]],
            "max_tokens": 100
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = json["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                DispatchQueue.main.async {
                    self.descriptionLabel.text = "GPT 응답 오류"
                }
                return
            }

            DispatchQueue.main.async {
                self.descriptionLabel.text = content
            }
        }.resume()
    }
}
