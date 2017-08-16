module "app" {
  source = "git@github.com:imma/fogg-app"

  global_region = "${var.remote_region}"
  global_bucket = "${var.remote_bucket}"

  global_key = "${join("_",slice(split("_",var.remote_path),0,1))}/terraform.tfstate"
  env_key    = "${join("_",slice(split("_",var.remote_path),0,2))}/terraform.tfstate"
}

data "terraform_remote_state" "env" {
  backend = "s3"

  config {
    bucket         = "${var.remote_bucket}"
    key            = "${join("_",slice(split("_",var.remote_path),0,2))}/terraform.tfstate"
    region         = "${var.remote_region}"
    dynamodb_table = "terraform_state_lock"
  }
}
