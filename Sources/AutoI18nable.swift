import Foundation
import ObjectiveC

public protocol AutoI18nable: AnyObject {
    var i18nString: String { get set }

    func autoLocalize(key: String)

    var autoI18nKey: String? { get set }
}

extension AutoI18nable {
    public func autoLocalize(key: String) {
        autoI18nKey = key
        WeakTableHolder.setObject(self, forKey: KeyObject(key: key))
        i18nString = key.localized()
    }

    public var autoI18nKey: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.localizedKey) as? String
        }
        set {
            objc_setAssociatedObject(
                self, &AssociatedKeys.localizedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
private struct AssociatedKeys {
    static var localizedKey: UnsafeRawPointer = UnsafeRawPointer(
        bitPattern: "localizedKey".hashValue)!
}

class WeakTableHolder: NSObject {
    static let shared = WeakTableHolder()
    private var weakTable: NSMapTable<KeyObject, AnyObject> = NSMapTable.weakToWeakObjects()

    override init() {
        super.init()
        NotificationCenter.default.addObserver(
            self, selector: #selector(WeakTableHolder.langageChanged),
            name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }

    @objc func langageChanged() {
        let keyEnumerator = weakTable.keyEnumerator()
        while let key = keyEnumerator.nextObject() as? KeyObject {
            if let object = weakTable.object(forKey: key) as? AutoI18nable {
                object.i18nString = key.key.localized()
            }
        }
    }
    static func setObject(_ object: AnyObject, forKey key: KeyObject) {
        shared.weakTable.setObject(object, forKey: key)
    }

    static func getObject(forKey key: KeyObject) -> AnyObject? {
        return shared.weakTable.object(forKey: key)
    }
}

class KeyObject: NSObject {
    var key: String
    init(key: String) {
        self.key = key
    }
}
