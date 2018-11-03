//  ___FILEHEADER___

import Foundation
import Moya


extension ___FILEBASENAMEASIDENTIFIER___: TargetType {

    var task: Task {
        switch self {
        case .insert(let body) :
            return .requestJSONEncodable(body)
        case .update(_,let body) :
            return .requestJSONEncodable(body)
        case .upload(let image, _):
            let imageData: Data = image.pngData()!
            let data = MultipartFormData(provider: .data(imageData), name: "file", fileName: "image.png", mimeType: "image/png")
            let multipartData = [data]
            return .uploadMultipart(multipartData)
        default:
            return .requestPlain
        }
    }


    var path: String {
        switch self {
        case .getAll:
            return "___VARIABLE_productName:identifier___"
        case .get(let id):
            return "___VARIABLE_productName:identifier___/\(id)"
        case .delete(let id):
            return "___VARIABLE_productName:identifier___/\(id)"
        case .insert:
            return "___VARIABLE_productName:identifier___"
        case .update(let id , _):
            return "___VARIABLE_productName:identifier___/\(id)"
        case .upload(_,let id):
            return "___VARIABLE_productName:identifier___/Upload/\(id)"
        }
    }


    var method: Moya.Method {
        switch self {
        case .insert , .upload:
            return .post
        case .delete:
            return .delete
        case .update:
            return .put
        default:
            return .get
        }
    }
}



