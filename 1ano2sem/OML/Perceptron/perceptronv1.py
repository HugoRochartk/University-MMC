import os

def dot_product(t1, t2):
        return sum([t1[i]*t2[i] for i in range(len(t1))])


def activation_function(x):
        
        if x>0:
            return 1
        else:
            return -1


def custo(N, true_class, w, points):
        return (1/N) * sum([(0.5)*abs(true_class[i] -  activation_function(dot_product(w, points[i]))) for i in range(N)])


class Perceptron:


    def __init__(self, path, w0):

        if os.path.exists(path):
            points = []
            true_class = []
         
            with open(path, "r") as f:
                lines = f.readlines()

                for line in lines:
                    points.append(tuple(map(float, ('1',) + tuple(line.split(',')[:-1])))) 
                    true_class.append(int(line.split(',')[-1]))
                    
            self.points = points
            self.N = len(points)
            self.true_class = true_class
            self.calc_class = [(-1) * elem for elem in self.true_class]
            self.w = w0
        else:
            print("DB doesn't exists!")




            

    def apply_perceptron(self):

        iter = 1

        while(iter < 1000):

            for i in range(self.N):
                    
                    if(custo(self.N, self.true_class, self.w, self.points) == 0):
                        return self.w
                    else:
                         if activation_function(dot_product(self.w, self.points[i])) != self.true_class[i]:
                              self.w = tuple(x+y for x,y in zip(self.w, tuple(self.true_class[i]*elem for elem in self.points[i])))
                    print(iter, self.w, custo(self.N, self.true_class, self.w, self.points))
                    iter+=1
                 


P = Perceptron("BD/Ex1_D.csv", (-0.25,-0.25,-0.25))
P.apply_perceptron()




