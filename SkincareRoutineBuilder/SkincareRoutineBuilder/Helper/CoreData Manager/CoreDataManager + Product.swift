//
//  CoreDataManager + Product.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 12/09/25.
//

import Foundation

extension CoreDataManager {
    
    func addProductToTemplateRoutine(
        routine: SCTemplateRoutine,
        name: String,
        type: String,
        timeOfDay: String,
        frequency: String
    ) {
        // create product
        let product = SCTemplateProduct(context: context)
        product.id = UUID()
        product.name = name
        product.type = type
        product.timeOfDay = timeOfDay
        product.frequency = frequency
        
        // create step
        let step = SCTemplateRoutineStep(context: context)
        step.id = UUID()
        step.displayOrder = Int16((routine.steps?.count ?? 0))
        step.product = product
        
        routine.addToSteps(step)
        
        try? context.save()
    }
    
    func updateTemplateProduct(
        product: SCTemplateProduct,
        name: String,
        type: String,
        timeOfDay: String,
        frequency: String
    ) {
        product.name = name
        product.type = type
        product.timeOfDay = timeOfDay
        product.frequency = frequency
        
        try? context.save()
    }

    func deleteTemplateProduct(step: SCTemplateRoutineStep) {
        if let product = step.product {
            context.delete(product)
        }
        context.delete(step)
        try? context.save()
    }
}
