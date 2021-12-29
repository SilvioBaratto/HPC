import pandas as pd
import os
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
from sklearn.linear_model import LinearRegression
import scipy
import numpy as np

'''
  calculate_fit=function(d){
  fit1=lm(data=d[1:15,],formula = t~X.bytes)
  fit2=lm(data=d[15:30,],formula = t~X.bytes)
  lambda=fit1$coefficients[1]
  b=(fit2$coefficients[2]^-1)
  d$t_est=lambda+d$X.bytes/b
  d$b_est=d$X.bytes/d$t_est
  return(d)
 }
'''

def regressionIntercept(x, y):
    slope, intercept, r_value, p_value, std_err = scipy.stats.linregress(x, y)
    return intercept

def regressionXbytes(x,y):
    slope, intercept, r_value, p_value, std_err = scipy.stats.linregress(x, y)
    return slope

    #return model.score(x, y)

def objective(x_data, c, bandwidth):
    return c + (x_data / bandwidth)


def removeHeadersFromCSV(full_path):
    with open(full_path, "r") as f:
        lines = f.readlines()

    with open(full_path, "w") as f:
        f.writelines(lines[2:])

    return lines[0:2], lines[2:]


def insertHeadersToCSV(headers, result_full_path):
    with open(result_full_path, "r") as f:
        lines = f.readlines()

    with open(result_full_path, "w") as f:
        for index, head in enumerate(headers):
            lines.insert(index, head)
        f.writelines(lines)


if __name__ == '__main__':
    cartella = "gpu_node/"
    for module in ["openmpi", "intel"]:
        directory = cartella +"csv/mean/" + module

        for filename in os.listdir(directory):
            full_path = os.path.join(directory, filename)

            headers, lines = removeHeadersFromCSV(
                full_path)

            df = pd.read_csv(full_path)

            insertHeadersToCSV(headers, full_path)
            x_data, y = df['#bytes'].values, df['t[usec]'].values

            #print(filename, regressionIntercept(np.array(x_data[0:14]), np.array(y[0:14])), "\n")
            #print(" ", np.reciprocal(regressionXbytes(np.array(x_data[14:29]), np.array(y[14:29]))))

            latency_estimate = regressionIntercept(np.array(x_data[0:14]), np.array(y[0:14]))
            bandwidth_estimate = np.reciprocal(regressionXbytes(np.array(x_data[14:29]), np.array(y[14:29])))
            
            #plt.rcParams["figure.figsize"] = (12, 10)
            #plt.scatter(x_data, y, label='measured data')

            y_estimated = objective(x_data, latency_estimate, bandwidth_estimate)
            '''
            plt.plot(x_data, y_estimated, '--', color='red',
                     label='least squares fitting')
            c = y[0]
            T_comm = [c + (element / bandwidth_estimate) for element in x_data]
            plt.plot(x_data, T_comm, '--', color='blue',
                     label='simple communication model')
            plt.ylabel('t[usecon]')
            plt.xlabel('#bytes')
            plt.xscale('log', base=2)
            plt.yscale('log', base=10)
            plt.legend(loc="upper left")

            plot_filename = os.path.splitext(filename)[0]+'.jpg'
            plot_full_path = os.path.join(cartella + "plots/" + module, plot_filename)
            plt.savefig(plot_full_path)
            plt.clf()
            '''
            #d$t_est=lambda+d$X.bytes/b
            #d$b_est=d$X.bytes/d$t_est

            #print(filename, "\n", y_estimated, "\n")

            bandwidth = df['Mbytes/sec'][-1:]

            df['t[usec] (computed)'] = [round(number, 2)
                                        for number in y_estimated]
            Mbytes_comp = [round(number, 2)
                           for number in (x_data / y_estimated)]
            df['Mbytes/sec (computed)'] = Mbytes_comp

            result_full_path = os.path.join(cartella + "results/" + module, filename)
            df.to_csv(result_full_path, sep=",", index=False)

            headers[1] = '#lambda[usec] (computed) -> ' + \
                str(df['t[usec] (computed)'].iloc[0]) + \
                ', bandwidth[Mbytes/sec] (computed) -> ' + \
                str(df['Mbytes/sec (computed)'].iloc[-1]) + '\n'

            insertHeadersToCSV(headers, result_full_path)
