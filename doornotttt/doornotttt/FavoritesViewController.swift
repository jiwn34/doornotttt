import UIKit
import MapKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!

    var favorites: [FavoritePlace] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavorites()
        setupMap()
    }

    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favorites"),
           let savedPlaces = try? JSONDecoder().decode([FavoritePlace].self, from: data) {
            favorites = savedPlaces
            tableView.reloadData()
        }
    }

    func setupMap() {
        mapView.removeAnnotations(mapView.annotations)
        for place in favorites {
            let annotation = MKPointAnnotation()
            annotation.title = place.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            mapView.addAnnotation(annotation)
        }
        if let first = favorites.first {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: first.latitude, longitude: first.longitude), latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        cell.textLabel?.text = favorites[indexPath.row].name
        return cell
    }
}

struct FavoritePlace: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
}

// 즐겨찾기 저장 함수 예시 (다른 VC에서 사용)
func saveFavoritePlace(name: String, latitude: Double, longitude: Double) {
    var current = [FavoritePlace]()
    if let data = UserDefaults.standard.data(forKey: "favorites"),
       let saved = try? JSONDecoder().decode([FavoritePlace].self, from: data) {
        current = saved
    }
    current.append(FavoritePlace(name: name, latitude: latitude, longitude: longitude))
    if let encoded = try? JSONEncoder().encode(current) {
        UserDefaults.standard.set(encoded, forKey: "favorites")
    }
}
