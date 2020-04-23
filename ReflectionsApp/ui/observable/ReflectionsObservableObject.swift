//
//  ReflectionsObservableObject.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 23/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

class ReflectionsObservableObject: ObservableObject {
    
    private var dataFacade = DataFacade.instance
    private var hasResolved: Bool = false
    
    @Published var reflections: [Reflection]?
    
    
}
