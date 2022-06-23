library(dplyr)
library(ggplot2)
library(tidyr)
library(gridExtra)

time_core <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_1/build/times_core.csv", header=TRUE)
time_socket <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_1/build/times_socket.csv", header=TRUE)
time_node <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_1/build/times_node.csv", header=TRUE)

time_core$time <- as.numeric(time_core$time*1000000)
time_socket$time <- as.numeric(time_socket$time*1000000)
time_node$time <- as.numeric(time_node$time*1000000)

sp1 = ggplot(time_core,aes(x=nprocs,y=time,color="Map by core"))  +
  scale_y_continuous(name="Time uSec")+
  scale_x_continuous(name="Processor number",breaks = time_core$nprocs) +
  geom_point() + 
  geom_line()  + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+
  geom_point(data=time_socket,aes(x=nprocs,y=time,color="Map by socket"))+
  geom_line(data=time_socket,aes(x=nprocs,y=time,color="Map by socket")) +    
  geom_point(data=time_node,aes(x=nprocs,y=time,color="Map by node")) +
  geom_line(data=time_node,aes(x=nprocs,y=time,color="Map by node"))+
  scale_color_manual(name="Mapping", values = c(10,12,13))+
  scale_linetype_manual(name="",values=c(1,2))+
  theme(legend.position = c(0.2, 0.8))+ geom_vline(xintercept=12, 
                                                   color = "red",linetype="dashed", size=0.5) +
  theme(legend.position = c(0.2, 0.8))+ geom_vline(xintercept=24, 
                                                 color = "red",linetype="dashed", size=0.5)
ggsave(paste0("~/OneDrive/github/High-Performance-Computing-benchmarks/report_v2/ring.png"), width = 8, height = 6, dpi = 200)

node_ib_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/node_ib.csv", header = TRUE, skip = 2)
node_ob1_tcp_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/node_ob1_tcp.csv", header = TRUE, skip = 2)
node_ucx_br0_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/node_ucx_br0.csv", header = TRUE)
node_ucx_ib0_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/node_ucx_ib0.csv", header = TRUE)
node_ucx__mlx5_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/node_ucx_mlx5_0.csv", header = TRUE, skip = 2)

socket_ib_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/socket_ib.csv", header = TRUE, skip = 2)
socket_ob1_tcp_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/socket_ob1_tcp.csv", header = TRUE, skip = 2)
socket_ob1_vader_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/socket_ob1_vader.csv", header = TRUE, skip = 2)

core_ib_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/core_ib.csv", header = TRUE, skip = 2)
core_ob1_tcp_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/core_ob1_tcp.csv", header = TRUE, skip = 2)
core_ob1_vader_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/core_ob1_vader.csv", header = TRUE, skip = 2)


node_ib_intel <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/intel/node_ib.csv", header = TRUE, skip = 2)
socket_ib_intel <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/intel/socket_ib.csv", header = TRUE, skip = 2)
core_ib_intel <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/intel/core_ib.csv", header = TRUE, skip = 2)

print(core_ib_intel)

thin_bandwidth = ggplot(core_ib_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX IB",linetype="Core")) +
  scale_x_continuous(trans='log2',name="Message Size Bytes",breaks=core_ib_openmpi$X.bytes) +
  geom_point() + geom_line()+scale_y_continuous(breaks = seq(0,25000,1000),name="MB/s") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  geom_point(data=core_ob1_tcp_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp")) +
  geom_line(data=core_ob1_tcp_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp",linetype="Core")) +
  geom_point(data=core_ob1_vader_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 vader")) +
  geom_line(data=core_ob1_vader_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 vader",linetype="Core")) +
  geom_point(data=socket_ib_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX IB")) +
  geom_line(data=socket_ib_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX IB",linetype="Socket")) +
  geom_point(data=socket_ob1_tcp_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp")) +
  geom_line(data=socket_ob1_tcp_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp",linetype="Socket")) +
  geom_point(data=socket_ob1_vader_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 vader")) +
  geom_line(data=socket_ob1_vader_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 vader",linetype="Socket")) +
  geom_point(data=socket_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB")) +
  geom_line(data=socket_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB",linetype="Socket")) +
  geom_point(data=core_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB")) +
  geom_line(data=core_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB",linetype="Core"))+
  scale_color_manual(name="Protocol", values = c("#ffa600", "#ef5675", "#7a5195" ,"#003f5c"))+
  scale_linetype_manual(name="Mapping",values=c(1,2,3,4))+
  labs(title="PingPong bandwidth", subtitle="Thin node,core and socket mapping")  +
  theme(plot.title = element_text(size = 13, face = "bold",hjust = 0.5,margin = margin(t = 12)), 
        plot.subtitle = element_text(size = 10, hjust = 0.5, margin = margin(t = 7, b = 10), face = "italic"), 
        axis.title = element_text(face = "bold"), legend.text = element_text(margin = margin(t = 7, b = 7, r=12)), 
        axis.title.x = element_text(margin = margin(t = 10, b=10)), 
        axis.title.y = element_text(margin = margin(r = 10,l=10)), 
        axis.text = element_text(color= "#2f3030", face="bold"))+
  geom_vline(xintercept=32768, 
             color = "black",linetype="dashed", size=0.35)+
  geom_vline(xintercept=1048576, 
             color = "black",linetype="dashed", size=0.35)+
  geom_vline(xintercept=19922944, 
             color = "black",linetype="dashed", size=0.35)+
  annotate("text", x=58000, y=24000, label= "L1",color="Black")+
  annotate("text", x=1800000, y=24000, label= "L2",color="Black")+
  annotate("text", x=29900000, y=24000, label= "L3",color="Black")
ggsave(paste0("~/OneDrive/github/High-Performance-Computing-benchmarks/report_v2/ThinPingPongBandwidth.png"), width = 8, height = 6, dpi = 200)

gpu_node_ib_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/gpu_node/results/openmpi/node_ib.csv", header = TRUE, skip = 2)
gpu_node_ob1_tcp_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/gpu_node/results/openmpi/node_ob1_tcp.csv", header = TRUE, skip = 2)
#node_ucx_br0_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/node_ib.csv", header = TRUE, skip = 2)
#node_ucx_ib0_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/thin_node/results/openmpi/node_ib.csv", header = TRUE, skip = 2)
gpu_node_ucx__mlx5_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/gpu_node/results/openmpi/node_ucx_mlx5_0.csv", header = TRUE, skip = 2)

gpu_socket_ib_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/gpu_node/results/openmpi/socket_ib.csv", header = TRUE, skip = 2)
gpu_socket_ob1_tcp_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/gpu_node/results/openmpi/socket_ob1_tcp.csv", header = TRUE, skip = 2)
gpu_socket_ob1_vader_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/gpu_node/results/openmpi/socket_ob1_vader.csv", header = TRUE, skip = 2)

gpu_core_ib_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/gpu_node/results/openmpi/core_ib.csv", header = TRUE, skip = 2)
gpu_core_ob1_tcp_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/gpu_node/results/openmpi/core_ob1_tcp.csv", header = TRUE, skip = 2)
gpu_core_ob1_vader_openmpi <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/gpu_node/results/openmpi/core_ob1_vader.csv", header = TRUE, skip = 2)


gpu_node_ib_intel <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/gpu_node/results/intel/node_ib.csv", header = TRUE, skip = 2)
gpu_socket_ib_intel <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/gpu_node/results/intel/socket_ib.csv", header = TRUE, skip = 2)
gpu_core_ib_intel <- read.csv("~/OneDrive/github/High-Performance-Computing-benchmarks/section_2/gpu_node/results/intel/core_ib.csv", header = TRUE, skip = 2)

gpu_bandwidth = ggplot(gpu_core_ib_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX IB",linetype="Core")) +
  scale_x_continuous(trans='log2',name="Message Size Bytes",breaks=gpu_core_ib_openmpi$X.bytes) +
  geom_point() + geom_line()+scale_y_continuous(breaks = seq(0,25000,1000),name="MB/s") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  geom_point(data=gpu_core_ob1_tcp_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp")) +
  geom_line(data=gpu_core_ob1_tcp_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp",linetype="Core")) +
  geom_point(data=gpu_core_ob1_vader_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 vader")) +
  geom_line(data=gpu_core_ob1_vader_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 vader",linetype="Core")) +
  geom_point(data=gpu_socket_ib_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX IB")) +
  geom_line(data=gpu_socket_ib_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX IB",linetype="Socket")) +
  geom_point(data=gpu_socket_ob1_tcp_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp")) +
  geom_line(data=gpu_socket_ob1_tcp_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp",linetype="Socket")) +
  geom_point(data=gpu_socket_ob1_vader_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 vader")) +
  geom_line(data=gpu_socket_ob1_vader_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 vader",linetype="Socket")) +
  geom_point(data=gpu_socket_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB")) +
  geom_line(data=gpu_socket_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB",linetype="Socket")) +
  geom_point(data=gpu_core_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB")) +
  geom_line(data=gpu_core_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB",linetype="Core"))+
  scale_color_manual(name="Protocol", values = c("#ffa600", "#ef5675", "#7a5195" ,"#003f5c"))+
  scale_linetype_manual(name="Mapping",values=c(1,2,3,4))+
  labs(title="PingPong bandwidth", subtitle="Gpu node,core and socket mapping")  +
  theme(plot.title = element_text(size = 13, face = "bold",hjust = 0.5,margin = margin(t = 12)), 
        plot.subtitle = element_text(size = 10, hjust = 0.5, margin = margin(t = 7, b = 10), face = "italic"), 
        axis.title = element_text(face = "bold"), legend.text = element_text(margin = margin(t = 7, b = 7, r=12)), 
        axis.title.x = element_text(margin = margin(t = 10, b=10)), 
        axis.title.y = element_text(margin = margin(r = 10,l=10)), 
        axis.text = element_text(color= "#2f3030", face="bold"))+
  geom_vline(xintercept=32768, 
             color = "black",linetype="dashed", size=0.35)+
  geom_vline(xintercept=1048576, 
             color = "black",linetype="dashed", size=0.35)+
  geom_vline(xintercept=19922944, 
             color = "black",linetype="dashed", size=0.35)+
  annotate("text", x=58000, y=24000, label= "L1",color="Black")+
  annotate("text", x=1800000, y=24000, label= "L2",color="Black")+
  annotate("text", x=29900000, y=24000, label= "L3",color="Black")
ggsave(paste0("~/OneDrive/github/High-Performance-Computing-benchmarks/report_v2/GpuPingPongBandwidth.png"), width = 8, height = 6, dpi = 200)



thin_mapping = ggplot(node_ib_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX IB")) +
  scale_x_continuous(trans='log2',name="Message Size Bytes",breaks=core_ib_openmpi$X.bytes)+
  scale_y_continuous(breaks = seq(0,13000,500),name="MB/s")  + geom_point() + geom_line()  +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  geom_point(data=node_ob1_tcp_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp")) + 
  geom_line(data=node_ob1_tcp_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp")) + 
  geom_point(data=node_ucx_br0_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX br0")) + 
  geom_line(data=node_ucx_br0_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX br0")) + 
  geom_point(data=node_ucx_ib0_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX ib0")) + 
  geom_line(data=node_ucx_ib0_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX ib0")) + 
  geom_point(data=node_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB")) + 
  geom_line(data=node_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB")) +
  labs(title="PingPong bandwidth", subtitle="Thin node,node mapping")  +
  theme(plot.title = element_text(size = 13, face = "bold",hjust = 0.5,margin = margin(t = 12)), 
        plot.subtitle = element_text(size = 10, hjust = 0.5, margin = margin(t = 7, b = 10), face = "italic"), 
        axis.title = element_text(face = "bold"), legend.text = element_text(margin = margin(t = 7, b = 7, r=12)), 
        axis.title.x = element_text(margin = margin(t = 10, b=10)), 
        axis.title.y = element_text(margin = margin(r = 10,l=10)), 
        axis.text = element_text(color= "#2f3030", face="bold")) +
    geom_hline(yintercept=3125, 
               color = "blue",linetype="dotted", size=0.4) +
    geom_hline(yintercept=12500, 
               color = "blue",linetype="dotted", size=0.4) +
    annotate("text", x=8, y=2260, label= "25 Gbit",color="black") +
    annotate("text", x=8, y=11800, label= "100 Gbit",color="black")
ggsave(paste0("~/OneDrive/github/High-Performance-Computing-benchmarks/report_v2/ThinNodeMapping.png"), width = 8, height = 6, dpi = 200)

gpu_mapping = ggplot(gpu_node_ib_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX IB")) +
  scale_x_continuous(trans='log2',name="Message Size Bytes",breaks=gpu_core_ib_openmpi$X.bytes)+
  scale_y_continuous(breaks = seq(0,13000,500),name="MB/s")  + geom_point() + geom_line()  +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  geom_point(data=gpu_node_ob1_tcp_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp")) +
  geom_line(data=gpu_node_ob1_tcp_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp")) + 
  geom_point(data=gpu_node_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB")) + 
  geom_line(data=gpu_node_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB")) +
  labs(title="PingPong bandwidth", subtitle="Gpu node,node mapping")  +
  theme(plot.title = element_text(size = 13, face = "bold",hjust = 0.5,margin = margin(t = 12)), 
        plot.subtitle = element_text(size = 10, hjust = 0.5, margin = margin(t = 7, b = 10), face = "italic"), 
        axis.title = element_text(face = "bold"), legend.text = element_text(margin = margin(t = 7, b = 7, r=12)), 
        axis.title.x = element_text(margin = margin(t = 10, b=10)), 
        axis.title.y = element_text(margin = margin(r = 10,l=10)), 
        axis.text = element_text(color= "#2f3030", face="bold"))
ggsave(paste0("~/OneDrive/github/High-Performance-Computing-benchmarks/report_v2/GPuNodeMapping.png"), width = 8, height = 6, dpi = 200)
