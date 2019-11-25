resource "google_storage_bucket" "storage" {
  name     = "paulvarache.co.uk"
  location = "EU"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = "${google_storage_bucket.storage.name}"
  role        = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}