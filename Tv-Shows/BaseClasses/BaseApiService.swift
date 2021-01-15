import Foundation
import Alamofire

class BaseApiService {
    weak var delegate: DataDelegate?
    private var requests: [DataRequest] = []

    convenience init() {
        self.init(with: nil)
    }

    init(with delegate: DataDelegate?) {
        self.delegate = delegate
    }

    @discardableResult
    func handleRequest(dataRequest: DataRequest?) -> Bool {
        guard let request = dataRequest else {
            return false
        }
        self.requests.append(request)
        return true
    }

    func cancelRequest() {
        self.delegate = nil
        self.requests.forEach { (request) in
            request.cancel()
        }
        self.requests.removeAll()
    }
}

protocol DataDelegate: class {
    func onFail()
}
