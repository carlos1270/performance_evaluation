-- Memory

SELECT mean("value") FROM "memory_usage" WHERE "container_name" =~ /cassandradc1n1/ AND "machine" =~ /cadvisor/ AND $timeFilter GROUP BY time($__interval), "machine", "container_name"

-- CPU

SELECT derivative(mean("value"), 10s) FROM "cpu_usage_total" WHERE "container_name" =~ /cassandradc1n1/ AND "machine" =~ /cadvisor/ AND $timeFilter GROUP BY time($interval), "machine", "container_name"

-- File system

SELECT mean("value") FROM "fs_usage" WHERE "machine" =~ /cadvisor/ AND "container_name" = 'cassandradc1n1' AND $timeFilter GROUP BY time($interval), "container_name", "machine"
SELECT mean("value") FROM "fs_limit" WHERE "machine" =~ /cadvisor/ AND "container_name" = 'cassandradc1n1' AND $timeFilter GROUP BY time($interval), "container_name", "machine"

-- Network

SELECT derivative(mean("value"), 10s) FROM "rx_bytes" WHERE "machine" =~ /cadvisor/ AND "container_name" =~ /cassandradc1n1/ AND $timeFilter GROUP BY time($interval), "container_name", "machine"
SELECT derivative(mean("value"), 10s) FROM "tx_bytes" WHERE "machine" =~ /cadvisor/ AND "container_name" =~ /cassandradc1n1/ AND $timeFilter GROUP BY time($interval), "container_name", "machine"