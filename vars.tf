variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "aws_key_name" {}
variable "aws_key_fingerprint" {}
variable "aws_certificate_arn" {}
variable "allowed_ip_network" {}
variable "eks_role_arn" {}

variable "az_map" {
	type = map

	default = {
		0 = "a"
		1 = "b"
		2 = "c"
	}
}