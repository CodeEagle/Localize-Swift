import Foundation
import ObjectiveC

public protocol AutoI18nable: AnyObject {
    func setString(value: String, forTag tag: String?)

    func autoLocalize(key: String, tag: String?)

    var autoI18nableKeys: [KeyObject] { get set }
}

extension AutoI18nable {
    public func autoLocalize(key: String, tag: String?) {
        var oldKeys = autoI18nableKeys
        let newKey = KeyObject(key: key, tag: tag)
        if oldKeys.contains(where: { $0.key == key && $0.tag == tag }) == false {
            oldKeys.append(newKey)
        }
        WeakTableHolder.setObject(self, forKey: newKey)
        setString(value: key.localized(), forTag: tag)
    }

    public var autoI18nableKeys: [KeyObject] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.localizedKey) as? [KeyObject]
                ?? []
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
                object.setString(value: key.key.localized(), forTag: key.tag)
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

public class KeyObject: NSObject {
    let key: String
    let tag: String?
    init(key: String, tag: String?) {
        self.key = key
        self.tag = tag
    }
}
