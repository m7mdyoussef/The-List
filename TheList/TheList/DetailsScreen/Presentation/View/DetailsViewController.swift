
import UIKit

class DetailsViewController: BaseViewController {
    
    @IBOutlet weak var repoImg: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoUserName: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var companiesLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var mailLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var TwitterLbl: UILabel!
    

    var detailsViewModel:DetailsViewModelContract!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        detailsViewModel.fetchDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Constants.RepoDetails
    }
    
    private func bindViewModel(){        
        self.detailsViewModel.errorHandler = {[weak self] (message) in
            guard let self = self else{
                return
            }
            self.showAlert(title: "Error", body: message, actions: [UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)])
        }
        
        self.detailsViewModel.loadingHandler = {[weak self] (boolValue) in
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
        
        self.detailsViewModel.dataHandler = { [weak self] (result) in
            guard let self else { return }
            self.setData(with: result)
        }
    }
    
    private func setData(with repo: RepoDetailsModel) {
        DispatchQueue.main.async {[weak self] in
            guard let self else { return }
            if let imageURLString = repo.avatarURL, let imageURL = URL(string: imageURLString) {
                self.repoImg.setImage(from: imageURL)
            }
            self.repoName.text = repo.name ?? ""
            self.repoUserName.text = repo.login ?? ""
            self.followersCount.text = "\(repo.followers ?? 0)"
            self.followingCount.text = "\(repo.following ?? 0)"
            self.companiesLbl.text = repo.company ?? ""
            self.locationLbl.text = repo.location ?? ""
            self.mailLbl.text = repo.email ?? ""
            self.websiteLbl.text = repo.blog ?? ""
            self.TwitterLbl.text = repo.twitterUsername ?? ""
            
        }
    }
    
}
