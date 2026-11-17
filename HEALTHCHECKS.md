# 容器健康检查

Docker Compose 默认自动合并 `docker-compose.override.yml`。显式 `-f` 时需同时指定本覆盖文件。仅补检查及只读探针挂载，不改变业务镜像或运行数据。

检查每 30 秒运行，超时 10 秒，连续 3 次失败标记 unhealthy；不自动重启或发送通知。静态探针来自 docker-nginx 的 `ops/container-health/probe.go`，源码提交 `d60ebf9e890ea3c8d27aff7e731324f610c090f6`，Linux amd64 产物 SHA256 `49706c7d01e99c095f34c30b8df3126dafe8a5af82d1473adc1de5b0fb21889e`，部署在服务器 `/data/docker-health/releases/`，运行时无需读取外部 Git 工作区。

首次环境应先从该提交编译并安装探针；已有环境原地补健康检查用 docker-nginx 的 `ops/container-health/apply.py`，它保留当前镜像、挂载和网络，失败恢复。Native Compose 未来重建会自动带上本配置。具体探针含义及任务进程检查的边界见健康工具 README。
