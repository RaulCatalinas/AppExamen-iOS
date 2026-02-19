//
//  ViewController.swift
//  AppExamen-iOS
//
//  Created by Tardes on 19/2/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,
    UITableViewDelegate
{
    @IBOutlet weak var diceImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var selectedCatagoryLabel: UILabel!
    @IBOutlet weak var quesitosView: UIStackView!
    @IBOutlet weak var rollDiceBtn: UIButton!
    @IBOutlet weak var playAgainBtn: UIButton!

    private var selectedCategory: TrivialCategory!
    private var selectedQuestion: TrivialQuestion!
    private var selectedCellByUser: UITableViewCell!
    private var correctTableViewCell: UITableViewCell? = nil
    private var correctCategories: Set<TrivialCategory> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        selectedCategory = getRandomCategory()
        selectedQuestion = getRandomQuestion(category: selectedCategory)

        selectedCatagoryLabel.text = selectedCategory.rawValue
        questionLabel.text = selectedQuestion.question

        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func rollDice(_ sender: Any) {
        resetCellsColor()

        tableView.allowsSelection = true

        selectedCategory = getRandomCategory()
        selectedQuestion = getRandomQuestion(category: selectedCategory)

        selectedCatagoryLabel.text = selectedCategory.rawValue
        questionLabel.text = selectedQuestion.question

        tableView.reloadData()

        /*diceImageView.rollDice { [self] result in
            let selectedCategory = TrivialCategory.allCases[result]
        
            selectedQuestion = TRIVIAL_QUESTIONS[selectedCategory]?.randomElement()
        
            tableView.reloadData()
        }*/
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return selectedQuestion.answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "trivial_cell",
                for: indexPath
            ) as! TrivailAnswerViewCell

        cell.configure(with: selectedQuestion.answers[indexPath.row].text)

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.allowsSelection = false

        let userAnswer = selectedQuestion.answers[indexPath.row]

        guard let cell = tableView.cellForRow(at: indexPath) else {
            print("Cell not found")
            return
        }

        selectedCellByUser = cell

        if userAnswer.isCorrect {
            cell.backgroundColor = .systemGreen

            let (inserted, _) = correctCategories.insert(selectedCategory)

            if inserted {
                if win() {
                    rollDiceBtn.isEnabled = false
                    playAgainBtn.isEnabled = true
                    showWinAlert()
                    return
                }

                let piePiece = createPiePiece(
                    color: selectedCategory.getColor()
                )

                quesitosView.addArrangedSubview(piePiece)
            }

            return
        }

        cell.backgroundColor = .systemRed

        // Buscar la respuesta correcta
        let correctIndex = selectedQuestion.answers.firstIndex(where: {
            $0.isCorrect
        })

        guard let correctIndex = correctIndex else { return }

        let correctCell = tableView.cellForRow(
            at: IndexPath(row: correctIndex, section: 0)
        )

        guard let correctCell = correctCell else { return }

        correctCell.backgroundColor = .systemGreen

        correctTableViewCell = correctCell

    }

    func createPiePiece(color: UIColor) -> UIView {
        let piePiece = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 30,
                height: 30
            )
        )

        piePiece.backgroundColor = color
        piePiece.layer.cornerRadius = 15
        piePiece.layer.borderWidth = 1
        piePiece.layer.borderColor = UIColor.label.cgColor

        return piePiece
    }

    func win() -> Bool {
        return correctCategories.count == 6
    }

    func showWinAlert() {
        let alert = UIAlertController(
            title: "¡Has ganado!",
            message: "¡Felicidades por superar el juego!",
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil)
        )

        present(alert, animated: true, completion: nil)
    }

    @IBAction func playAgain(_ sender: Any) {
        correctCategories.removeAll()

        quesitosView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }

        selectedCategory = getRandomCategory()
        selectedQuestion = getRandomQuestion(category: selectedCategory)

        selectedCatagoryLabel.text = selectedCategory.rawValue
        questionLabel.text = selectedQuestion.question

        resetCellsColor()
        tableView.reloadData()

        rollDiceBtn.isEnabled = true
        playAgainBtn.isEnabled = false
    }

    func getRandomQuestion(category: TrivialCategory) -> TrivialQuestion {
        return TRIVIAL_QUESTIONS[category]!.randomElement()!
    }

    func getRandomCategory() -> TrivialCategory {
        return TRIVIAL_QUESTIONS.randomElement()!.key
    }

    func resetCellsColor() {
        selectedCellByUser.backgroundColor = .clear

        if correctTableViewCell != nil {
            correctTableViewCell!.backgroundColor = .clear
        }
    }
}
