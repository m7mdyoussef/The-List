
import Foundation

enum ApplicationNetworking{
    case getList(page:String)
}

extension ApplicationNetworking : TargetType{
    var baseURL: String {
        switch self{
        default:
            return Constants.APIConstatnts.baseURL
        }
    }
    
    var path: String {
        switch self{
        case .getList:
            return Constants.APIConstatnts.listUrlPath
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
        case .getList(let page):
            return .requestParameters(parameters:
                                        [Constants.APIConstatnts.page:page],
                                      encoding: .urlEncoding)
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
