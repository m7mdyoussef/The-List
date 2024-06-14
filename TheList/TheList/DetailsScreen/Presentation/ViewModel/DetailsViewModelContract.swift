
import Foundation

protocol DetailsViewModelContract : BaseViewModelContract {
    var errorHandler: ((String) -> Void)? { get set }
    var loadingHandler: ((Bool) -> Void)? { get set }
    var dataHandler: ((RepoDetailsModel) -> Void)? { get set }
    func fetchDetailsFollowers(withUrl url:String)
    func fetchDetails()
}
