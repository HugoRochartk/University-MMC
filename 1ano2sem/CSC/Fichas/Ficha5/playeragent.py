import gym
import numpy as np
import pickle
from collections import Counter
import tensorflow as tf



class MLP:
     
    def __init__(self, epochs=1, batch_size=32, output_neurons=2):
        self.epochs = epochs
        self.batch_size = batch_size
        self.output_neurons = output_neurons
    

    def prepare_data(self, training_set):    
        X = np.array([i[1] for i in training_set], dtype='float32').reshape(-1, len(training_set[0][1]))
        y = np.array([i[0] for i in training_set])
        print(X.shape, y.shape)
        return X, y


    def build(self):
        self.model = tf.keras.Sequential([
            tf.keras.layers.Dense(64, activation="relu"),
            tf.keras.layers.Dense(128, activation="relu"),
            tf.keras.layers.Dense(self.output_neurons, activation="softmax"),
        ])
        self.model.compile(optimizer="adam",
                           loss="categorical_crossentropy",
                           metrics=['accuracy'])
    

    def fit(self, training_set):
        X, y = self.prepare_data(training_set)
        self.model.fit(X, y, epochs=self.epochs, batch_size=self.batch_size)

    

    def predict(self, obs):
         
         obs = np.array(obs).reshape(1, -1)

         prediction = self.model.predict(obs)

         predicted_value = np.argmax(prediction)

         return predicted_value



class PlayerAgent:

    def __init__(self, game_steps, nr_of_games_for_training, score_requirement, game="CartPole-v1", log=False):
        self.game_steps = game_steps
        self.nr_of_games_for_training = nr_of_games_for_training
        self.score_requirement = score_requirement
        self.random_games = 50
        self.log = log
        self.scores = []



    def play_random_games(self):
        if self.log:
            self.env=gym.make("CartPole-v1", render_mode="human")
        else:
            self.env=gym.make("CartPole-v1")
            


        for game in range(self.random_games):
                self.env.reset()
                for step in range(self.game_steps):
                        if self.log:
                             self.env.render()
                        action=self.env.action_space.sample()
                        observation, reward, done, truncated, info = self.env.step(action)
                        if done:
                                print("episode finished after {} time steps", format(step+1))
                                break




    def build_training_set(self):
         
        self.env=gym.make("CartPole-v1")
        training_set = []
        score_set = []


        for game in range(self.nr_of_games_for_training):
                cumulative_game_score = 0
                game_memory = []
                obs_prev = (self.env.reset())[0]

                for step in range(self.game_steps):
                   action = self.env.action_space.sample()
                   obs_next, reward, done, _, info = self.env.step(action)
                   game_memory.append([action, obs_prev])
                   cumulative_game_score += reward
                   obs_prev = obs_next
                   if done:
                        break
                   
                if cumulative_game_score > self.score_requirement:
                    score_set.append(cumulative_game_score)
                    for play in game_memory:
                        if play[0] == 0:
                            one_hot_action = [1,0]
                        elif play[0] == 1:
                            one_hot_action = [0,1]
                        
                        training_set.append([one_hot_action, play[1]])
          
        with open('CartPoleTrainingSet.pickle', 'wb') as f:
            pickle.dump(training_set, f)
        

        if score_set:
             print('Average Score:', np.mean(score_set))
             print('Number of stored games per score', Counter(score_set))

        
        return training_set



    def play_the_game(self):
         
        training_set = self.build_training_set()

        mlp = MLP()
        mlp.build()
        mlp.fit(training_set)

        if self.log:
            self.env = gym.make('CartPole-v1', render_mode='human')
        else:
            self.env = gym.make('CartPole-v1')
        

        for game in range(self.nr_of_games_for_training):
            score = 0
            obs_prev = (self.env.reset())[0]
            done = False

            while not done:
                if self.log:
                    self.env.render()
                action = mlp.predict(obs_prev)
                obs_next, reward, done, _, _ = self.env.step(action)
                score += reward
                obs_prev = obs_next
                print(score)

            
            self.scores.append(score)
            print('Current Score: ' + str(score) + '; Average score: ', sum(self.scores)/len(self.scores))
                




playerAgent = PlayerAgent(5000, 10000, 75, game="CartPole-v1", log=True)
#playerAgent.build_training_set()
playerAgent.play_the_game()