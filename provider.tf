provider "google" {
  credentials = "${var.credential}" 
  project     = "${var.project}"
  region      = "asia-southeast2"
}
