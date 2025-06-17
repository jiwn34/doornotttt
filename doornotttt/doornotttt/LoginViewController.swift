import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 8
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "이메일과 비밀번호를 모두 입력해주세요.")
            return
        }

        // 임시 로그인 로직
        if email == "test@example.com" && password == "1234" {
            moveToNextScreen()
        } else {
            showAlert(message: "아이디 또는 비밀번호가 올바르지 않습니다.")
        }
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else {
            print("❌ SignUpViewController 로드 실패")
            return
        }
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true)
    }

    func moveToNextScreen() {
        guard let emotionVC = storyboard?.instantiateViewController(withIdentifier: "EmotionSelectViewController") as? EmotionSelectViewController else {
            print("❌ EmotionSelectViewController 로드 실패")
            return
        }
        emotionVC.modalPresentationStyle = .fullScreen
        present(emotionVC, animated: true)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
