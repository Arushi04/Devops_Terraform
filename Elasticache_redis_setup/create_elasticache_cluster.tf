resource "aws_elasticache_cluster" "test_redis" {
	cluster_id           = "test-redis-cluster"
	engine               = "redis"
	engine_version       = "4.0.10"
	node_type            = "cache.t2.medium"
	num_cache_nodes      = 1
	parameter_group_name = "default.redis4.0"
	port                 = 6379
	subnet_group_name    = "default"
	security_group_ids   = "${var.security-grp-id}"
	tags {
		test = "${var.tag}"
	}
}




