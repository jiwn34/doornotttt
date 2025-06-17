import UIKit
import MapKit
import CoreLocation

class PlaceRecommendViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var mapView: MKMapView!

    var selectedEmotion: String?
    var peopleCount: Int?
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialLocation()
        getPlaceRecommendationFromGPT()
    }

    func setupInitialLocation() {
        let ptuLocation = CLLocationCoordinate2D(latitude: 36.9947, longitude: 127.0885)
        let region = MKCoordinateRegion(center: ptuLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }

    func getPlaceRecommendationFromGPT() {
        guard let emotion = selectedEmotion, let count = peopleCount else {
            resultLabel.text = "입력 정보 부족"
            return
        }

        let prompt = "오늘 기분은 \(emotion)이고, \(count)명이 함께할 거예요. 평택대학교 근처에서 어울리는 장소 5개를 추천해줘. 장소 이름만 콤마(,)로 구분해서 한 줄로 알려줘."

        guard let apiKey = loadAPIKey() else {
            resultLabel.text = "API 키 로드 실패"
            return
        }

        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [["role": "user", "content": prompt]],
            "max_tokens": 150
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = json["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                DispatchQueue.main.async {
                    self.resultLabel.text = "GPT 응답 오류"
                }
                return
            }

            DispatchQueue.main.async {
                self.createPlaceButtons(from: content)
            }
        }.resume()
    }

    func createPlaceButtons(from content: String) {
        let placeList = content.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        resultLabel.text = "추천된 장소를 눌러보세요!"
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for placeName in placeList {
            let button = UIButton(type: .system)
            button.setTitle(placeName, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.backgroundColor = UIColor.systemGray6
            button.setTitleColor(.systemBlue, for: .normal)
            button.layer.cornerRadius = 8
            button.addTarget(self, action: #selector(placeButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    @objc func placeButtonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }

        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = title
        searchRequest.region = mapView.region

        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let item = response?.mapItems.first else { return }

            let annotation = MKPointAnnotation()
            annotation.coordinate = item.placemark.coordinate
            annotation.title = item.name
            self.mapView.addAnnotation(annotation)
            self.mapView.setCenter(item.placemark.coordinate, animated: true)
        }
    }

    func loadAPIKey() -> String? {
        if let path = Bundle.main.path(forResource: "OpenAIKey", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let key = dict["OpenAI_API_KEY"] as? String {
            return key
        }
        return nil
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
