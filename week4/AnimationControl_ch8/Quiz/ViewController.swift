import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextQuestionLabel: UILabel!
    @IBOutlet weak var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    var currentQuestionIndex: Int = 0
    
    let questions: [String] = ["From what  is cognac made?", "What is 7+7?","What is the capital of Vermont?"]
    let answers: [String] = ["Grapes","14","Montpelier"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let question = questions[currentQuestionIndex]
        currentQuestionLabel.text = question
        updateOffScreenLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
    }
    
    private func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    private func animateLabelTransitions() {
        view.layoutIfNeeded()
        
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        // curveLiner효과 + spring효과 // 동메달 과제
        UIView.animate(withDuration: 1.0, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: [.curveLinear, .curveEaseInOut], animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded()
        }, completion: { _ in
            swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
            swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
            self.updateOffScreenLabel()
        })
    }
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestionIndex = (currentQuestionIndex + 1) % questions.count
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
}

