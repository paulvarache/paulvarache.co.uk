terraform {
  # State is saved in a GCloud Storage bucket. This one was created manually. This is the only manual resource required
  backend "gcs" {
    bucket  = "paulvarache-tf-state"
    prefix  = "terraform/paulvarache.co.uk"
  }
}

provider "google-beta" {
  project = "${var.project}"
  region  = "europe-west2"
  zone    = "europe-west2-c"
}

provider "gandi" {
  key = "${var.GANDI_API_KEY}"
}
