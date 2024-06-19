import gym

env=gym.make("CartPole-v1", render_mode="human")
env.reset()


for _ in range(1):
        for i_episode in range(1):
            observation=env.reset()
            for t in range (100):
                env.render()
                print(observation)
                action=env.action_space.sample()
                observation, reward, done, _, info =env.step(action)
                if done:
                        print("episode finished after {} time steps", format(t+1))
                        break


env.close()