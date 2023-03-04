import UIKit

class MenuController: UIViewController {
    
    fileprivate enum MenuOptions: String, CaseIterable {
        case terms = "Terms of use"
        case policy = "Privacy policy"
        case edtit = "Edit profile"
        case faq = "FAQ"
        case settings = "Settings"
        case liked = "Liked post"
    }
    
    fileprivate enum UIConstants {
        static let viewCornerRadius: CGFloat = 15
        static let borderWidth: CGFloat = 1
        static let borderColor: CGFloat = 0
        static let borderColorAlpha: CGFloat = 1
        static let tableViewXPosition: CGFloat = 0
        static let tableViewIdentifier = "cell"
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: UIConstants.tableViewIdentifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: UIConstants.tableViewXPosition,
                                 y: view.safeAreaInsets.top,
                                 width: view.bounds.size.width,
                                 height: view.bounds.size.height)
    }
    
}

private extension MenuController {
    func configureView() {
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = UIConstants.viewCornerRadius
        view.layer.borderWidth = UIConstants.borderWidth
        view.layer.borderColor = CGColor(red: UIConstants.borderColor,
                                         green: UIConstants.borderColor,
                                         blue: UIConstants.borderColor,
                                         alpha: UIConstants.borderColorAlpha)
        view.addSubview(tableView)
    }
    
    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.tableViewIdentifier, for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        return cell
    }
}
