// EmotionSelectViewController.swift - 감정 버튼이 제대로 동작하지 않을 때 확인

import UIKit

class EmotionSelectViewController: UIViewController {

    @IBOutlet weak var selectedEmotionLabel: UILabel!
    var selectedEmotion: String?
    
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            selectedEmotion = title
            print("선택된 감정: \(title)")
            selectedEmotionLabel.text = "선택된 감정: \(title)"
        } else {
            print("❌ 버튼 titleLabel.text가 nil입니다")
        }
    }

    

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextVC = storyboard.instantiateViewController(withIdentifier: "PeopleCountViewController") as? PeopleCountViewController {
            nextVC.selectedEmotion = self.selectedEmotion
            self.present(nextVC, animated: true, completion: nil)
        }
    }
}
