import Foundation
import Alamofire

class BaseApiService {
    weak var delegate: DataDelegate?

    convenience init() {
        self.init(with: nil)
    }

    init(with delegate: DataDelegate?) {
        self.delegate = delegate
    }
}

protocol DataDelegate: class {
    func onFail()
}
