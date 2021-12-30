import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from pandas.core.indexes.base import Index


def compute_C(L, k):
    return (L**2 * k * 2 * 8)/1000000


def compute_T_c(C, B, k, T_l):
    return (C/B) + (k*T_l)


def compute_MLUPs(L, N, T_s, T_c):
    return (L**3 * N) / (T_s + T_c)

def compute_P(x, y):
    results_P = []
    for i in range(len(y)):
            results_P.append(x[i]*y[0]/y[i])
    return results_P

if __name__ == '__main__':

    # first exercise
    results = []
    results_C = []
    results_T_c = []
    results_P = []
    L = 1200
    T_s = 15.32

    # MAP BY CORE

    B = 6450.36
    T_l = 0.22 / 1000000

    for N in [1, 4, 8, 12]:
        if N == 1:
            k = 2
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)
        if N==4:
            k=4
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)
        if N == 8 or N == 12:
            k=6
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)

    x = [1, 4, 8, 12]
    y = [results[0], results[1], results[2], results[3]]
    C_measured = [results_C[0], results_C[1], results_C[2], results_C[3]]
    T_c_measured = [results_T_c[0], results_T_c[1], results_T_c[2], results_T_c[3]]

    y_measured = [112.738038684, 451.917340285, 890.340247916, 1325.42592104]

    diff = np.array(y_measured) - np.array(y)

    df = pd.DataFrame()
    df['#Processors'] = [1, 4, 8, 12]
    df['C[Mb]'] = C_measured
    df['T_c'] = T_c_measured
    df['expected performance [MLUPs/sec]'] = y
    df['measured performance [MLUPs/sec]'] = y_measured
    df['difference in performance [MLUPs/sec]'] = diff
    df['P(1)/P(L,N)'] = compute_P(x, y_measured)
    df.to_csv("csv/exercise1/map-core.txt", sep=",", index=False)

    print("exercise 1 - map by core:")
    print("C/Mb -> ", C)
    print("T_c -> ", T_c)
    print("expected -> ", y)
    print("computed -> ", y_measured)
    print("diff -> ", diff)
    print()

    # MAP BY SOCKET

    results = []
    results_C = []
    results_T_c = []
    results_P = []
    L = 1200
    T_s = 15.32
   
    B = 5679.78
    T_l = 0.54 / 1000000
    

    for N in [1, 4, 8, 12]:
        if N == 1:
            k = 2
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)
        if N==4:
            k=4
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)
        if N == 8 or N == 12:
            k=6
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)

    x = [1, 4, 8, 12]
    y = [results[0], results[1], results[2], results[3]]
    C_measured = [results_C[0], results_C[1], results_C[2], results_C[3]]
    T_c_measured = [results_T_c[0], results_T_c[1], results_T_c[2], results_T_c[3]]

    y_measured = [112.738038684, 447.417460743, 883.428980139, 1336.18901670]

    diff = np.array(y_measured) - np.array(y)

    df = pd.DataFrame()
    df['#Processors'] = [1, 4, 8, 12]
    df['C[Mb]'] = C_measured
    df['T_c'] = T_c_measured
    df['expected performance [MLUPs/sec]'] = y
    df['measured performance [MLUPs/sec]'] = y_measured
    df['difference in performance [MLUPs/sec]'] = diff
    df['P(1)/P(L,N)'] = compute_P(x, y_measured)
    df.to_csv("csv/exercise1/map-socket.txt", sep=",", index=False)

    print("exercise 1 - map by socket:")
    print("C/Mb -> ", C)
    print("T_c -> ", T_c)
    print("expected -> ", y)
    print("computed -> ", y_measured)
    print("diff -> ", diff)
    print()


    # MAP NODE
    results = []
    results_C = []
    results_T_c = []
    results_P = []
    L = 1200
    T_s = 15.32

    B = 12176.39
    T_l = 1.07 / 1000000
  
    for N in [1, 12, 24, 48]:
        if N == 1:
            k=2
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)
        else:
            k=6
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)

    x = [1, 12, 24, 48]
    y = [results[0], results[1], results[2], results[3]]
    C_measured = [results_C[0], results_C[1], results_C[2], results_C[3]]
    T_c_measured = [results_T_c[0], results_T_c[1], results_T_c[2], results_T_c[3]]

    y_measured = [112.738038684, 1326.57991764, 2627.13087281, 5131.27333911]

    diff = np.array(y_measured) - np.array(y)

    df = pd.DataFrame()
    df['#Processors'] = [1, 12, 24, 48]
    df['C[Mb]'] = C_measured
    df['T_c'] = T_c_measured
    df['expected performance [MLUPs/sec]'] = y
    df['measured performance [MLUPs/sec]'] = y_measured
    df['difference in performance [MLUPs/sec]'] = diff
    df['P(1)/P(L,N)'] = compute_P(x, y_measured)
    df.to_csv("csv/map-node.txt", sep=",", index=False)

    print("exercise 2:")
    print("C/Mb -> ", C)
    print("T_c -> ", T_c)
    print("expected -> ", y)
    print("measured -> ", y_measured)
    print("diff -> ", np.array(y_measured) - np.array(y))
    print()

    #EXERCISE3

    # GPU MAP BY NODE

    results = []
    results_C = []
    results_T_c = []

    L = 1200
    T_s = 22.11

    B = 12185.46
    T_l = 1.58 / 1000000
    
    # 78.1421102760
    for N in [1, 12, 24, 48]:
        if N == 1:
            k=2
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)
        else:
            k = 6
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)

    x = [1, 12, 24, 48]
    y = [results[0], results[1], results[2], results[3]]
    C_measured = [results_C[0], results_C[1], results_C[2], results_C[3]]
    T_c_measured = [results_T_c[0], results_T_c[1], results_T_c[2], results_T_c[3]]

    y_measured = [78.1421102760, 897.052501334, 1686.52547650, 2488.66471192]

    diff = np.array(y_measured) - np.array(y)

    df = pd.DataFrame()
    df['#Processors'] = [1, 12, 24, 48]
    df['C[Mb]'] = C_measured
    df['T_c'] = T_c_measured
    df['expected performance [MLUPs/sec]'] = y
    df['measured performance [MLUPs/sec]'] = y_measured
    df['difference in performance [MLUPs/sec]'] = diff
    df['P(1)/P(L,N)'] = compute_P(x, y_measured)
    df.to_csv("csv/exercise3/gpu-map-node.txt", sep=",", index=False)

    print("exercise 3:")
    print("C/Mb -> ", C)
    print("T_c -> ", T_c)
    print("expected -> ", y)
    print("measured -> ", y_measured)
    print("diff -> ", np.array(y_measured) - np.array(y))
    print()

    # GPU MAP BY CORE
    results = []
    results_C = []
    results_T_c = []

    L = 1200
    T_s = 22.11

    B = 6157.24
    T_l = 0.26 / 1000000
    
    # 78.1421102760
    for N in [1, 4, 8, 12]:
        if N == 1:
            k = 2
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)
        if N==4:
            k=4
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)
        if N == 8 or N == 12:
            k=6
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)

    x = [1, 4, 8, 12]
    y = [results[0], results[1], results[2], results[3]]
    C_measured = [results_C[0], results_C[1], results_C[2], results_C[3]]
    T_c_measured = [results_T_c[0], results_T_c[1], results_T_c[2], results_T_c[3]]

    y_measured = [78.1421102760, 309.684185677, 586.338024349, 850.567090061]

    diff = np.array(y_measured) - np.array(y)

    df = pd.DataFrame()
    df['#Processors'] = [1, 4, 8, 12]
    df['C[Mb]'] = C_measured
    df['T_c'] = T_c_measured
    df['expected performance [MLUPs/sec]'] = y
    df['measured performance [MLUPs/sec]'] = y_measured 
    df['difference in performance [MLUPs/sec]'] = diff
    df['P(1)/P(L,N)'] = compute_P(x, y_measured)
    df.to_csv("csv/exercise3/gpu-map-core.txt", sep=",", index=False)

    print("exercise 3:")
    print("C/Mb -> ", C)
    print("T_c -> ", T_c)
    print("expected -> ", y)
    print("measured -> ", y_measured)
    print("diff -> ", np.array(y_measured) - np.array(y))
    print()
    
    # GPU MAP BY SOCKET

    results = []
    results_C = []
    results_T_c = []

    L = 1200
    T_s = 22.11

    B = 5201.56
    T_l = 0.60 / 1000000

    # 78.1421102760
    for N in [1, 4, 8, 12]:
        if N == 1:
            k = 2
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)
        if N==4:
            k=4
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)
        if N == 8 or N == 12:
            k=6
            C = compute_C(L, k)
            T_c = compute_T_c(C, B, k, T_l)
            results_C.append(C)
            results_T_c.append(T_c)
            res = compute_MLUPs(L, N, T_s, T_c) / 1000000
            results.append(res)

    x = [1, 4, 8, 12]
    y = [results[0], results[1], results[2], results[3]]
    C_measured = [results_C[0], results_C[1], results_C[2], results_C[3]]
    T_c_measured = [results_T_c[0], results_T_c[1], results_T_c[2], results_T_c[3]]

    y_measured = [78.1421102760, 311.429599694, 611.262184627, 899.664031245]

    diff = np.array(y_measured) - np.array(y)

    df = pd.DataFrame()
    df['#Processors'] = [1, 4, 8, 12]
    df['C[Mb]'] = C_measured
    df['T_c'] = T_c_measured
    df['expected performance [MLUPs/sec]'] = y
    df['measured performance [MLUPs/sec]'] = y_measured
    df['difference in performance [MLUPs/sec]'] = diff
    df['P(1)/P(L,N)'] = compute_P(x, y_measured)
    df.to_csv("csv/exercise3/gpu-map-socket.txt", sep=",", index=False)

    print("exercise 3:")
    print("C/Mb -> ", C)
    print("T_c -> ", T_c)
    print("expected -> ", y)
    print("measured -> ", y_measured)
    print("diff -> ", np.array(y_measured) - np.array(y))
    print()
    
    
    
    
