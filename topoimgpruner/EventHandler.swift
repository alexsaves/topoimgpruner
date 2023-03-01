import Foundation

/**
 * Module inspired by existing art on the web
 */
class EventHandler {
    func subscribeTo(eventName:String, action: @escaping (()->())) {
        let subscriber = EventSubscriberActor(callback: action);
        addSubscriber(eventName: eventName, newEventListener: subscriber);
    }
    
    func subscribeTo(eventName:String, action: @escaping ((Any?)->())) {
        let subscriber = EventSubscriberActor(callback: action);
        addSubscriber(eventName: eventName, newEventListener: subscriber);
    }
    
    internal func addSubscriber(eventName:String, newEventListener:EventSubscriberActor) {
        if let subscriberArray = self.subscribers[eventName] {
            subscriberArray.add(newEventListener);
        }
        else {
            self.subscribers[eventName] = [newEventListener] as NSMutableArray;
        }
    }
    
    func removeListeners(eventNameToRemoveOrNil:String?) {
        if let eventNameToRemove = eventNameToRemoveOrNil {
            
            if let actionArray = self.subscribers[eventNameToRemove] {
                actionArray.removeAllObjects();
            }
        }
        else {
            self.subscribers.removeAll(keepingCapacity: false);
        }
    }
    
    func trigger(eventName:String, information:Any? = nil) {
        if let actionObjects = self.subscribers[eventName] {
            for actionObject in actionObjects {
                if let actionToPerform = actionObject as? EventSubscriberActor {
                    if let methodToCall = actionToPerform.actionExpectsInfo {
                        methodToCall(information);
                    }
                    else if let methodToCall = actionToPerform.action {
                        methodToCall();
                    }
                }
            }
        }
    }
    
    var subscribers = Dictionary<String, NSMutableArray>();
    
}

class EventSubscriberActor {
    let action:(() -> ())?;
    let actionExpectsInfo:((Any?) -> ())?;
    
    init(callback: @escaping (() -> ()) ) {
        self.action = callback;
        self.actionExpectsInfo = nil;
    }
    
    init(callback: @escaping ((Any?) -> ()) ) {
        self.actionExpectsInfo = callback;
        self.action = nil;
    }
}
