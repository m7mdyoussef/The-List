
import UIKit
class HomeViewController: BaseViewController {
    @IBOutlet private weak var RepoListTableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    var RepoListViewModel: HomeViewModelContract!
    var repoArray: [RepoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        registerCellNibFile()
        
        instantiateRefreshControl()
        bindViewModel()
        RepoListViewModel.fetchRepos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = Constants.AppName
    }
    
    private func setupNavigationController(){
        self.navigationItem.setHidesBackButton(true, animated: true)
        //clear background
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    private func registerCellNibFile(){
        let listNibCell = UINib(nibName: Constants.ListCellNibName, bundle: nil)
        RepoListTableView.register(listNibCell, forCellReuseIdentifier: Constants.ListCellNibName)
    }
    
    private func instantiateRefreshControl(){
        RepoListTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
    }
    
    @objc private func refreshControlTriggered() {
        RepoListViewModel.fetchRepos()
    }
    
    private func bindViewModel(){
        
        self.RepoListViewModel.errorHandler = {[weak self] (message) in
            guard let self = self else{
                return
            }
            DispatchQueue.main.async {
                self.showAlert(title: "Error", body: message, actions: [UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)])
            }
        }
        
        self.RepoListViewModel.loadingHandler = {[weak self] (boolValue) in
            guard let self = self else{
                return
            }
            switch boolValue{
            case true:
                self.showLoading()
            case false:
                self.hideLoading()
            }
        }
        
        self.RepoListViewModel.dataHandler = { [weak self] (result) in
            guard let self else { return }
            self.repoArray = result
            DispatchQueue.main.async {
                self.RepoListTableView.reloadData()
            }
        }
    }
}


extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ListCellNibName, for: indexPath) as? CellViewProtocol
        let item = repoArray[indexPath.row]
        let model = ListTableViewCellModel(
            repoName: item.name,
            repoOwnerName: item.owner?.login,
            repoOwnerImage: item.owner?.avatarURL,
            createdAt: item.createdAt)
        cell?.setup(viewModel: model)
        return cell as? UITableViewCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.RepoListViewModel.navigateTo(to: .Details(repoArray[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
