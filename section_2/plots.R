ring <- read.csv("~/OneDrive/github/HPC/section_1/times_24.csv", header = FALSE)
print(ring)
library(ggplot2)
library(gridExtra)
ggplot(ring,aes(x=V2,y=V1,color="observation",linetype="fit"))  +
  scale_y_continuous(name="Time uSec") +
  scale_x_continuous(name="Processor number",breaks = ring$V2) +
  geom_point() + 
  geom_line()  + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+
  geom_point(data=ring,aes(x=V2,y=V1,color="observation"))+
  geom_line(data=ring,aes(x=V2,y=V1,color="observation",linetype="fit")) + 
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  scale_color_manual(name="observation", values = c(10,12,13))+
  scale_linetype_manual(name="",values=c(1,2))+
  theme(legend.position = c(0.2, 0.8))
          + geom_vline(xintercept=12, color = "observation",linetype="dashed", size=0.5)

############ MPI-BENCHMARK #################

# OPENMPI THIN NODE

core_ib_openmpi <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/openmpi/core_ib.csv",
                            skip = 2, header = TRUE)
core_ob1_tcp <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/openmpi/core_ob1_tcp.csv",
                         skip = 2, header = TRUE)
core_ob1_vader <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/openmpi/core_ob1_vader.csv",
                           skip = 2, header = TRUE)
node_ib_openmpi <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/openmpi/node_ib.csv",
                            skip = 2, header = TRUE)
node_ob1_tcp <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/openmpi/node_ob1_tcp.csv",
                         skip = 2, header = TRUE)
node_ucx_mlx5 <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/openmpi/node_ucx_mlx5_0.csv",
                          skip = 2, header = TRUE)
socket_ib_openmpi <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/openmpi/socket_ib.csv",
                              skip = 2, header = TRUE)
socket_ob1_tcp <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/openmpi/socket_ob1_tcp.csv",
                           skip = 2, header = TRUE)
socket_ob1_vader <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/openmpi/socket_ob1_vader.csv",
                             skip = 2, header = TRUE)

# INTEL

core_ib_intel <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/intel/core_ib.csv",
                          skip = 2, header = TRUE)
core_mlx <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/intel/core_mlx.csv",
                     skip = 2, header = TRUE)
core_tcp <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/intel/core_tcp.csv",
                     skip = 2, header = TRUE)
node_ib_intel <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/intel/node_ib.csv",
                          skip = 2, header = TRUE)
node_mlx <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/intel/node_mlx.csv",
                     skip = 2, header = TRUE)
node_tcp <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/intel/node_tcp.csv",
                     skip = 2, header = TRUE)
socket_ib_intel <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/intel/socket_ib.csv",
                            skip = 2, header = TRUE)
socket_mlx <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/intel/socket_mlx.csv",
                       skip = 2, header = TRUE)
socket_tcp <- read.csv("~/OneDrive/github/HPC/section_2/thin_node/csv/mean/intel/socket_tcp.csv",
                       skip = 2, header = TRUE)

openmpi <- ggplot(core_ib_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX IB",linetype="Core")) +
  scale_x_continuous(trans='log2',name="Message Size Bytes",breaks=core_ib_openmpi$X.bytes) +
  geom_point() + geom_line()+scale_y_continuous(breaks = seq(0,25000,1000),name="MB/s") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  
  geom_point(data=core_ob1_tcp,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp")) +
  geom_line(data=core_ob1_tcp,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp",linetype="Core")) +
  
  geom_point(data=core_ob1_vader,aes(x=X.bytes,y=Mbytes.sec,color="OB1 vader")) +
  geom_line(data=core_ob1_vader,aes(x=X.bytes,y=Mbytes.sec,color="OB1 vader",linetype="Core")) +
  
  geom_point(data=socket_ib_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX IB")) +
  geom_line(data=socket_ib_openmpi,aes(x=X.bytes,y=Mbytes.sec,color="UCX IB",linetype="Socket")) +
  
  geom_point(data=socket_ob1_tcp,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp")) +
  geom_line(data=socket_ob1_tcp,aes(x=X.bytes,y=Mbytes.sec,color="OB1 tcp",linetype="Socket")) +
  
  geom_point(data=socket_ob1_vader,aes(x=X.bytes,y=Mbytes.sec,color="OB1 vader")) +
  geom_line(data=socket_ob1_vader,aes(x=X.bytes,y=Mbytes.sec,color="OB1 vader",linetype="Socket")) +

  scale_color_manual(name="Protocol", values = c("#ffa600", "#bc5090", "#003f5c"))+
  scale_linetype_manual(name="Mapping",values=c(1,2,3))+
  
  labs(title="Openmpi", subtitle="Thind node: core and socket mapping")  +
  theme(plot.title = element_text(size = 17, face = "bold",hjust = 0.5,margin = margin(t = 12)), 
        plot.subtitle = element_text(size = 15, hjust = 0.5, margin = margin(t = 7, b = 10)), 
        axis.title = element_text(face = "bold"), 
        legend.text = element_text(margin = margin(t = 7, b = 7, r=12)), 
        axis.title.x = element_text(margin = margin(t = 10, b=10)), 
        axis.title.y = element_text(margin = margin(r = 10,l=10)), 
        axis.text = element_text(color= "#2f3030", face="bold")) +
  geom_vline(xintercept=32768, 
             color = "black",linetype="dashed", size=0.35)+
  geom_vline(xintercept=1048576, 
             color = "black",linetype="dashed", size=0.35)+
  geom_vline(xintercept=19922944, 
             color = "black",linetype="dashed", size=0.35)+
  annotate("text", x=58000, y=24000, label= "L1",color="Black")+
  annotate("text", x=1800000, y=24000, label= "L2",color="Black")+
  annotate("text", x=29900000, y=24000, label= "L3",color="Black")

  intel <- ggplot(core_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB",linetype="Core")) +
    scale_x_continuous(trans='log2',name="Message Size Bytes",breaks=core_ib_openmpi$X.bytes) +
    geom_point() + geom_line()+scale_y_continuous(breaks = seq(0,25000,1000),name="MB/s") +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
    
    geom_point(data=socket_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB")) +
    geom_line(data=socket_ib_intel,aes(x=X.bytes,y=Mbytes.sec,color="Intel IB",linetype="Socket")) +
    
    geom_point(data=core_tcp,aes(x=X.bytes,y=Mbytes.sec,color="Intel tcp")) +
    geom_line(data=core_tcp,aes(x=X.bytes,y=Mbytes.sec,color="Intel tcp",linetype="Core")) +
    
    geom_point(data=socket_tcp,aes(x=X.bytes,y=Mbytes.sec,color="Intel tcp")) +
    geom_line(data=socket_tcp,aes(x=X.bytes,y=Mbytes.sec,color="Intel tcp",linetype="Socket")) +
    
    scale_color_manual(name="Protocol", values = c("#ffa600", "#003f5c"))+
    scale_linetype_manual(name="Mapping",values=c(1,2))+
    
    labs(title="Intel", subtitle="Thin node: core and socket mapping")  +
    theme(plot.title = element_text(size = 17, face = "bold",hjust = 0.5,margin = margin(t = 12)), 
          plot.subtitle = element_text(size = 15, hjust = 0.5, margin = margin(t = 7, b = 10)), 
          axis.title = element_text(face = "bold"), 
          legend.text = element_text(margin = margin(t = 7, b = 7, r=12)), 
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

    grid.arrange(openmpi, intel, ncol=2)

  