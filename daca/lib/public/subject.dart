import 'observer.dart';

class Subject {
  List<Observer> observers = [];

  void registerObserver(Observer observer) {
    print('registering observer');
    this.observers.add(observer);
    print(this.observers);
  }

  void unregisterObserver(Observer observer) {
    this.observers.remove(observer);
  }

  void clearObservers() {
    this.observers.clear();
  }

  void notifyObservers() {
    for (Observer observer in observers) {
      observer.update();
    }
  }
}
