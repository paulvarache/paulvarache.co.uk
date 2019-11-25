data "gandi_zone" "paulvarache_co_uk" {
  name = "paulvarache.co.uk"
}

resource "gandi_zonerecord" "root" {
  zone = "${data.gandi_zone.paulvarache_co_uk.id}"
  name = "@"
  type = "A"
  ttl = 3600
  values = [
    "${google_compute_global_address.default.address}"
  ]
}