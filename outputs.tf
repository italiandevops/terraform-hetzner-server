# Output Server Public IP address 
output "server_ip" {
 value = "${hcloud_server.server01.ipv4_address}"
}