import Foundation

public struct Tree: Decodable {
    
    let id: Float
    let timeCreated: String? //"2022-01-22T12:19:13.000Z"
    let timeUpdated: String? //"2022-01-22T12:19:13.000Z"
    let planterID: Float? //4962
    let imageURL: String? //"https://treetracker-production-images.s3.eu-central-1.amazonaws.com/2022.01.22.12.57.09_8.368650000000002_-13.228745000000002_11c3ab6c-5dfd-4e41-9da5-c5cb1e280a75_IMG_20220122_121853_774096458100759370.jpg",
    //"estimated_geometric_location": "0101000020E61000003F3F8C101E752AC040575BB1BFBC2040",
    let lat: String? //"8.368650000000002",
    let lon: String? //"-13.228745000000002",
    let active: Bool? //true,
    let planterPhotoURL: String? //"https://treetracker-production-images.s3.eu-central-1.amazonaws.com/2022.01.20.12.36.58_8.367143333333333_-13.227906666666668_f987f60f-cfeb-4ddc-9612-d7d98e0988c5_IMG_20220120_103637_6922005364472036657.jpg",
    let planterIdentifier: String? //"080014777",
    let uuid: String //"3723aa96-4beb-48d5-ae55-0ffb1a6ae7c6",
    let approved: Bool //true,
    let status: String? //"planted",
    let speciesID: String?  //null,
    let plantingOrganizationID: String? //null,
    let morphology: String? //"seedling",
    let age: String? //"new_tree",
    let species: String? //null,
    let speciesName: String? //null,
    let speciesDescription: String? //null,
    let countryName: String? //"Sierra Leone",
    let countryID: Float? //6632692,
    let organizationID: Int? //182,
    let organizationName: String? //"FCCYAR",
    
    private enum CodingKeys: String, CodingKey {
        case id
        case timeCreated = "time_created"
        case timeUpdated = "time_updated"
        case planterID = "planter_id"
        case imageURL = "image_url"
        case lat
        case lon
        case active
        case planterPhotoURL = "planter_photo_url"
        case planterIdentifier = "planter_identifier"
        case uuid
        case approved
        case status
        case speciesID = "species_id"
        case plantingOrganizationID = "planting_organization_id"
        case morphology
        case age
        case species
        case speciesName = "species_name"
        case speciesDescription = "species_desc"
        case countryName = "country_name"
        case countryID = "country_id"
        case organizationID = "organization_id"
        case organizationName = "organization_name"
    }
}
