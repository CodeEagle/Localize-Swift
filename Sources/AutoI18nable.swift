import Foundation
import ObjectiveC

public protocol AutoI18nable: AnyObject {
    func setString(value: String, forTag tag: String?)

    func autoLocalize(key: String, tag: String?)

}

extension AutoI18nable {
    public func autoLocalize(key: String, tag: String? = nil) {
        weakTableHolder.setObject(self, forKey: KeyObject(key: key, tag: tag))
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

    var weakTableHolder: WeakTableHolder {
        get {
            var holder =
                objc_getAssociatedObject(self, &AssociatedKeys.localizedKey) as? WeakTableHolder
            if holder == nil {
                holder = WeakTableHolder()
                objc_setAssociatedObject(
                    self, &AssociatedKeys.localizedKey, holder,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return holder!
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
    static var weakTableHolder: UnsafeRawPointer = UnsafeRawPointer(
        bitPattern: "weakTableHolder".hashValue)!
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
        let keyEnumerator: NSEnumerator = weakTable.keyEnumerator()
        while let key = keyEnumerator.nextObject() as? KeyObject {
            if let object = weakTable.object(forKey: key) as? AutoI18nable {
                object.setString(value: key.key.localized(), forTag: key.tag)
            }
        }
    }

    func setObject(_ object: AnyObject, forKey key: KeyObject) {
        weakTable.setObject(object, forKey: key)
    }

    func getObject(forKey key: KeyObject) -> AnyObject? {
        return weakTable.object(forKey: key)
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
