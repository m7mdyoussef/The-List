
import Foundation

enum ApplicationNetworking{
    case getList
    case getRepoDetails(url:String)
}

extension ApplicationNetworking : TargetType{
    var baseURL: String {
        switch self{
        case .getRepoDetails(let url):
            return url
        default:
            return Constants.APIConstatnts.baseURL
        }
    }
    
    var path: String {
        switch self{
        case .getList:
            return Constants.APIConstatnts.listUrlPath
        case .getRepoDetails:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self{
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .getList:
            return .requestPlain
        case .getRepoDetails:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        switch self{
        default:
            return [
                "Accept": "application/json",
                "Content-Type": "application/json",
            ]
        }
    }
}
