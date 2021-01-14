import Foundation
import EVReflection
import Alamofire

class BaseViewModel: ViewModelProtocol {
    var apiService: BaseApiService?
    var data: BaseModel?

    init() {
        self.apiService = nil
        self.data = nil
    }

    init(with data: BaseModel?, apiService: BaseApiService?) {
        self.apiService = apiService
        self.data = data
    }
}

protocol ViewModelProtocol {
    var data: BaseModel? { get set }
    var apiService: BaseApiService? { get set }
}

class BaseModel: EVObject {
    var parameter: Parameters {
        return self.toDictionary() as! Parameters
    }
}
