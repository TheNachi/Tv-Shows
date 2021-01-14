import Foundation
import Alamofire

class LoginService: BaseApiService {
    private let BASEURL : String = ApiConfig.baseURL
    private var header: HTTPHeaders
    
    init() {
        self.header = ["Content-Type": ApiConfig.contentType]
        super.init(with: nil)
    }
    
    public func loginUser(with model: LoginModel, delegate: LoginDelegate) {
        let url = "\(BASEURL)users/sessions"
        let request = Alamofire.request(url, method: .post, parameters: model.parameter, encoding: JSONEncoding.default, headers: self.header)
        request.validate()
        request.responseString { (responseData) in
            guard let dataString = responseData.result.value else {
                delegate.onFail()
                return
            }
                    
            if responseData.response?.statusCode == 200 {
                let response = DataModel(json: dataString)
                delegate.onLoginSuccessful(response: response)
            } else {
                delegate.onFail()
            }
        }
        
    }
}

protocol LoginDelegate: DataDelegate {
    func onLoginSuccessful(response: DataModel)
}
