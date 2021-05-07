//
//  MvpPresenter.swift
//  MovieDatabase
//
//  Created by Sergiy Sobol on 06.05.2021.
//

class MvpPresenter<V> {

    var mvpView: V?
    var context: RouteContext?

    func attachView(mvpView: V) {
        self.mvpView = mvpView
    }

    func setContext(to context: RouteContext?) {
        self.context = context
    }

    func detachView() {
        mvpView = nil
    }
}
