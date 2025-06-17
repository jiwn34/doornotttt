import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        // 임시 회원가입 로직 (Firebase 없이)
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""

        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            showAlert(title: "오류", message: "모든 항목을 입력해주세요.")
            return
        }

        if password != confirmPassword {
            showAlert(title: "오류", message: "비밀번호가 일치하지 않습니다.")
            return
        }

        // 가입 성공 시 로그인 화면으로 돌아가기
        showAlert(title: "회원가입 완료", message: "이제 로그인 해주세요.") {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func backLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true, completion: nil)
    }
}
