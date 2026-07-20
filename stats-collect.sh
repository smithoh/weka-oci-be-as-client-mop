#!/bin/sh
# ============================================================
# WEKA High Latency Diagnostics — Full Stats Collection
# Used in Step 7 of README.md (run on target [T], right after
# the Step 6 fio tests, before Step 8 umount)
# ============================================================

END=$(date +%Y-%m-%dT%H:%M:%S)
START=$(date -d "-15 minutes" +%Y-%m-%dT%H:%M:%S)
# 노드 타임존이 KST이므로 Z(UTC 표기)는 붙이지 않음.
# Z를 붙이면 UTC로 해석되어 실제 로컬 시각보다 9시간 뒤 구간을 수집하게 됨.

# ── Workload / Latency ───────────────────────────────────────

weka stats --show-internal --start-time "$START" --end-time "$END" --stat WRITE_BYTES --per-node -Z > write-bytes-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat READ_BYTES --per-node -Z > read-bytes-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat WRITES --per-node -Z > ops-write-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat READS --per-node -Z > ops-read-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat WRITE_LATENCY > write-latency.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat WRITE_LATENCY --per-node -Z > write-latency-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat READ_LATENCY > read-latency.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat READ_LATENCY --per-node -Z > read-latency-nodes.txt

# ── RPC Latency (NodeId < 10,000 = backend / >= 10,000 = client) ─

weka stats --show-internal --start-time "$START" --end-time "$END" --stat CLIENT_ROUNDTRIP_AVG,SERVER_PROCESSING_AVG > client-server-avg.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat CLIENT_ROUNDTRIP_AVG,SERVER_PROCESSING_AVG --param method:* -Z > client-server-avg-by-method.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat CLIENT_ROUNDTRIP_AVG --param method:* --per-node -Z > client-roundtrip-avg-by-method-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat SERVER_PROCESSING_AVG --param method:* --per-node -Z > server-processing-avg-by-method-nodes.txt

# ── Network Throughput ───────────────────────────────────────

weka stats --show-internal --start-time "$START" --end-time "$END" --stat PORT_RX_BYTES --param networkPortId:* > port-rx-bytes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat PORT_TX_BYTES --param networkPortId:* > port-tx-bytes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat PORT_RX_BYTES --param networkPortId:* --per-node -Z > port-rx-bytes-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat PORT_TX_BYTES --param networkPortId:* --per-node -Z > port-tx-bytes-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat GOODPUT_RX_RATIO > goodput-rx-ratio.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat GOODPUT_RX_RATIO --per-node -Z > goodput-rx-ratio-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat GOODPUT_TX_RATIO > goodput-tx-ratio.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat GOODPUT_TX_RATIO --per-node -Z > goodput-tx-ratio-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat PUMPS_TXQ_FULL --per-node -Z > pumps-txq-full-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat PEER_RTT_BACKEND > peer-rtt-backend.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat PEER_RTT_CLIENT > peer-rtt-client.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat DROPPED_PACKETS --per-node -Z > dropped-packets-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat RESENT_DATA_PACKETS --per-node -Z > resent-packets-nodes.txt

# ── Drive / SSD Latency ──────────────────────────────────────

weka stats --show-internal --start-time "$START" --end-time "$END" --stat SSD_WRITE_LATENCY --param disk:* --per-node -Z > ssd-write-latency.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat SSD_READ_LATENCY --param disk:* --per-node -Z > ssd-read-latency.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat DRIVE_WRITE_LATENCY --param disk:* > drive-write-latency.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat DRIVE_READ_LATENCY --param disk:* > drive-read-latency.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat DRIVE_UTILIZATION --param disk:* > drive-utilization.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat DRIVE_UTILIZATION --param disk:* --per-node -Z > drive-utilization-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat DRIVE_LOAD --param disk:* --per-node -Z > drive-load-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat DRIVE_IO_TOO_LONG --param disk:* --per-node -Z > drive-io-too-long-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat DRIVE_READ_RATIO_PER_SSD_READ --param disk:* --per-node -Z > drive-read-ratio-per-ssd-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat DRIVE_UNCORRECTABLE_READ_COUNT --param disk:* --per-node -Z > drive-uncorrectable-read-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat NVME_SMART_HOST_READ_CMDS --param disk:* --per-node -Z > nvme-host-read-cmds-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat NVME_SMART_HOST_WRITE_CMDS --param disk:* --per-node -Z > nvme-host-write-cmds-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat DRIVE_WAF_INTERVAL --param disk:* --per-node -Z > drive-waf-interval-nodes.txt

# ── Cluster State Snapshots ──────────────────────────────────

weka stats --show-internal --start-time "$START" --end-time "$END" --stat CPU_UTILIZATION --per-node -Z > cpu-util-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat FE_IDLE_TIME --per-node -Z > fe-idle-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat IDLE_TIME --per-node -Z > compute-idle-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat DRIVE_IDLE_TIME --per-node -Z > drive-idle-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat CPU_HANGS --per-node -Z > cpu-hangs-nodes.txt
weka stats --show-internal --start-time "$START" --end-time "$END" --stat READ_QOS_DELAY,WRITE_QOS_DELAY,READ_LATENCY_NO_QOS,WRITE_LATENCY_NO_QOS > qos-delay-stats.txt

weka events -v --show-internal --start-time "$START" --end-time "$END" --format csv --num-results 1000000 > weka_events.txt
weka cluster task --start-time "$START" --end-time "$END" > cluster-tasks.txt

weka status > weka-status.txt
weka cluster process > cluster-process.txt
weka cluster drive > cluster-drive.txt
weka cluster nodes --backends > cluster-nodes-uptime.txt
weka alerts > weka-alerts.txt
weka fs > weka-fs.txt
weka cluster host > cluster-host.txt
