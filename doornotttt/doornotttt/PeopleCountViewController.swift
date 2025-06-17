// PeopleCountViewController.swift - 인원 수 선택 화면

import UIKit

class PeopleCountViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!

    var peopleCount: Int = 1
    var selectedEmotion: String? // ✅ 감정 선택 결과를 받기 위한 변수 추가

    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.stepValue = 1
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.value = Double(peopleCount)
        updateLabel()

        // 디버깅용 출력
        print("선택된 감정: \(selectedEmotion ?? "없음")")
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        peopleCount = Int(sender.value)
        updateLabel()
    }

    func updateLabel() {
        countLabel.text = "\(peopleCount)명"
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let placeVC = storyboard.instantiateViewController(withIdentifier: "PlaceRecommendViewController") as? PlaceRecommendViewController {
            placeVC.selectedEmotion = self.selectedEmotion
            placeVC.peopleCount = self.peopleCount
            self.present(placeVC, animated: true, completion: nil)
        }
    }
}
