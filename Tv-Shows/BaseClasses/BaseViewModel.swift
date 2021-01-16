// swiftlint:disable force_cast

import Foundation
import EVReflection
import Alamofire

class BaseViewModel: ViewModelProtocol {
    var apiService: BaseApiService?

    init() {
        self.apiService = nil
    }

    init(with apiService: BaseApiService?) {
        self.apiService = apiService
    }
}

protocol ViewModelProtocol {
    var apiService: BaseApiService? { get set }
}

class BaseModel: EVObject {
    var parameter: Parameters {
        return self.toDictionary() as! Parameters
    }
}
