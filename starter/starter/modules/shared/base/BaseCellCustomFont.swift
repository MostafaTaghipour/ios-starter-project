//  ___FILEHEADER___

import UIKit
import mtpFontManager
import iOSEasyList

class BaseTableViewCellCustomFont<T>:BaseTableViewCell<T>{

    override func awakeFromNib() {
        super.awakeFromNib()
        StyleWatcher().watchViews(inView: self.contentView)
    }
}


class BaseCollectionViewCellCustomFont<T>:BaseCollectionViewCell<T>{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        StyleWatcher().watchViews(inView: self.contentView)
    }
}
