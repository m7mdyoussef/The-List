
import UIKit

class ListTableViewCell: UITableViewCell, CellViewProtocol {
    @IBOutlet private weak var RepoOwnerImageView: UIImageView!
    @IBOutlet private weak var repoNameLabel: UILabel!
    @IBOutlet private weak var repoOwnerNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    
    func setup(viewModel: BaseCellViewModelProtocol) {
        guard let viewModel = viewModel as? ListTableViewCellModel else {return}

        repoNameLabel.text = Constants.RepoName + (viewModel.repoName ?? "")
        repoOwnerNameLabel.text = Constants.OwnerName + (viewModel.repoOwnerName ?? "")
        createdAtLabel.text = viewModel.createdAt

        if let imageURLString = viewModel.repoOwnerImage, let imageURL = URL(string: imageURLString) {
            RepoOwnerImageView.setImage(from: imageURL)
          }
    }
}
