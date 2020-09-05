//
//  Data.swift
//  Liverpool
//
//  Created by Jorge Arturo Parra Avila on 04/09/20.
//  Copyright © 2020 Jorge Arturo Parra Avila. All rights reserved.
//

class Productos: Codable{
    
    let status: Satatus?
    let pageType: String?
    let plpResults: PlpResults?
    
    init(status: Satatus, pageType: String, plpResults: PlpResults) {
        self.status = status
        self.pageType = pageType
        self.plpResults = plpResults
    }
    
}

class Satatus: Codable {
    let status: String?
    let statusCode: Int?
    
    init(stauts: String, statusCode: Int) {
        self.status = stauts
        self.statusCode = statusCode
    }
}
 
class PlpResults: Codable {
    let label: String?
    let plpState: PlpState?
    let sortOptions: [SortOptions]?
    let refinementGroups: [RefinementGroups]?
    let records: [Records]?
    let navigation: Navigation?
    
    init(label: String, plpState: PlpState, sortOptions: [SortOptions], refinementGroups: [RefinementGroups], records: [Records], navigation: Navigation) {
        self.label = label
        self.plpState = plpState
        self.sortOptions = sortOptions
        self.refinementGroups = refinementGroups
        self.records = records
        self.navigation = navigation
    }
}
 
class PlpState: Codable {
    let categoryId: String?
    let currentSortOption: String?
    let currentFilters: String?
    let firstRecNum: Int?
    let lastRecNum: Int?
    let recsPerPage: Int?
    let totalNumRecs: Int?
    
    init(categoryId: String, currentSortOption: String, currentFilters: String, firstRecNum: Int, lastRecNum: Int, recsPerPage: Int, totalNumRecs: Int) {
        self.categoryId = categoryId
        self.currentSortOption = currentSortOption
        self.currentFilters = currentFilters
        self.firstRecNum = firstRecNum
        self.lastRecNum = lastRecNum
        self.recsPerPage = recsPerPage
        self.totalNumRecs = totalNumRecs
    }
}

class SortOptions: Codable {
    let sortBy: String?
    let label: String?
    
    init(sortBy: String, label: String) {
        self.sortBy = sortBy
        self.label = label
    }
}

class RefinementGroups: Codable {
    let name: String?
    let refinement: [Refinement]?
    let multiSelect: Bool?
    let dimensionName: String?
    
    init(name: String, refinement: [Refinement], multiSelect: Bool, dimensionName: String) {
        self.name = name
        self.refinement = refinement
        self.multiSelect = multiSelect
        self.dimensionName = dimensionName
    }
}

class Refinement: Codable {
    let count: Int?
    let label: String?
    let refinementId: String?
    let selected: Bool?
    let colorHex: String?
    
    init(count: Int, label: String, refinementId: String, selected: Bool, colorHex: String) {
        self.count = count
        self.label = label
        self.refinementId = refinementId
        self.selected = selected
        self.colorHex = colorHex
    }
}

class Records: Codable {
    let productId: String?
    let skuRepositoryId: String?
    let productDisplayName: String?
    let productType: String
    let productRatingCount: Int?
    let productAvgRating: Float?
    let listPrice: Float?
    let minimumListPrice: Float?
    let maximumListPrice: Float?
    let promoPrice: Float?
    let minimumPromoPrice: Float?
    let maximumPromoPrice: Float?
    let isHybrid: Bool?
    let marketplaceSLMessage: String?
    let marketplaceBTMessage: String?
    let isMarketPlace: Bool?
    let isImportationProduct: Bool?
    let brand: String?
    let seller: String?
    let category: String?
    let smImage: String?
    let lgImage: String?
    let xlImage: String?
    let groupType: String?
    let plpFlags: [PlpFlags]?
    let variantsColor: [VariantsColor]?
    
    init(productId: String, skuRepositoryId: String, productDisplayName: String, productType: String, productRatingCount: Int, productAvgRating: Float, listPrice: Float, minimumListPrice: Float, maximumListPrice: Float, promoPrice: Float, minimumPromoPrice: Float, maximumPromoPrice: Float, isHybrid: Bool, marketplaceSLMessage: String, marketplaceBTMessage: String, isMarketPlace: Bool, isImportationProduct: Bool, brand: String, seller: String, category: String, smImage: String, lgImage: String, xlImage: String, groupType: String, plpFlags: [PlpFlags], variantsColor: [VariantsColor]) {
        
        self.productId = productId
        self.skuRepositoryId = skuRepositoryId
        self.productDisplayName = productDisplayName
        self.productType = productType
        self.productRatingCount = productRatingCount
        self.productAvgRating = productAvgRating
        self.listPrice = listPrice
        self.minimumListPrice = minimumListPrice
        self.maximumListPrice = maximumListPrice
        self.promoPrice = promoPrice
        self.minimumPromoPrice = minimumPromoPrice
        self.maximumPromoPrice = maximumPromoPrice
        self.isHybrid = isHybrid
        self.marketplaceSLMessage = marketplaceSLMessage
        self.marketplaceBTMessage = marketplaceBTMessage
        self.isMarketPlace = isMarketPlace
        self.isImportationProduct = isImportationProduct
        self.brand = brand
        self.seller = seller
        self.category = category
        self.smImage = smImage
        self.lgImage = lgImage
        self.xlImage = xlImage
        self.groupType = groupType
        self.plpFlags = plpFlags
        self.variantsColor = variantsColor
    }
}

class PlpFlags: Codable {
}

class VariantsColor: Codable {
    let colorName: String?
    let colorHex: String?
    let colorImageURL: String?
    
    init(colorName: String, colorHex: String, colorImageURL: String) {
        self.colorName = colorName
        self.colorHex = colorHex
        self.colorImageURL = colorImageURL
    }
}

class Navigation: Codable {
    let ancester: [Ancester]?
    let current: [Current]?
    let childs: [Childs]?
    
    init(ancester: [Ancester], current: [Current], childs: [Childs]) {
        self.ancester = ancester
        self.current = current
        self.childs = childs
    }
}


class Ancester: Codable {
}

class Current: Codable {
    let label: String?
    let categoryId: String?
    
    init(label: String, categoryId: String) {
        self.label = label
        self.categoryId = categoryId
    }
}

class Childs: Codable {
}
