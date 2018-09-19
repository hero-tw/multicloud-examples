resource "google_container_cluster" "primary" {
  name               = "gke-example"
  zone               = "europe-west2-a"
  initial_node_count = 2
}
