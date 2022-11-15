terraform {
  backend "s3" {
        bucket = "thisisforterraform"
        key = "ntierdeploydev"
        region = "ap-south-1"
        dynamodb_table = "thisisforteraform"
    
  }
}
