# Natural_Language_Processing_Compilation
A compilation of NLP projects, including sentiment analysis, NLI, generators, classification, music, ect.

Too many NLP notebooks for one repository. My GitHub can get rather cluttered making a new repository to feature for each one and some smaller or older code samples need a good home without obscuring newer and more interesting projects. If it deals with text, it is in here. (Maybe I should make a text generater to make all my documentation for me. Might save me some time.)

# ARPAbet-agrams
A new word "game" where words are found that share the same ARPAbet transcription codes, but with a different order!

We have all heard of anagrams, where you take a word or phrase and shuffle the letters to make a new one. However, I was wondering what if, instead of letters, what if we shuffled the words base sounds around. The ARPAbet is a set of phonetic transcription codes developed by Advanced Research Projects Agency (ARPA) in the 1970s. It allows us to break down words farther into visual representation of speech sounds. Now what if we shuffled these around to make, what I am calling, an ARPAbet-agram. This is a bit more complex than anyone would ever care to deal with (It makes anagrams look pretty easy by comparasion). Calling it a word "game" is somewhat generous, but we can make a computer do all that teadious work to find ARPAbetagrams and we can just enjoy the results. Feel free to play with this notebook or just download the outputed .CSV file of ~135,000 words and their possible ARPAbetagrams. 

Check it out on Kaggle: https://www.kaggle.com/valkling/arpabet-agrams

Check out the ARPAbetagram phrases here on Kaggle: https://www.kaggle.com/valkling/arpabet-agrams-phrases

# Indeed_Job_Tagging
Machine learning algorithm made to determine job tags based on job posts. This was made for the Indeed Machine Learning CodeSprint on Hacker Rank. It got 29th place, which was enoungh to win the T-shirt prize. It gives job posts tags based off their raw descriptions by looking for keywords. Just exicuting the test.rb with the test/train files in the same folder will create a tags.tsv with the answers. It has an F1-Score of 0.685. The CodeSprint was only open for a short time so this code was created in a short window. The final code runs well but not as flexabile as ideal. The only package used was "csv".

### (Update)
I revisted the data for this CodeSprint to see how I would do with my new NLP skills. The revist uses Bidirrectional GRU and CNN layers to get the validation F1-Score to 0.7365, which would have put it in the top ten. That is far enough to satisify my curiosity.


# Kaggle_Toxic_Comment
My top bidirectional GRU model and Submissions that achieved a bronze medal in Kaggle Toxic Comment Challenge.

The notebook achived 0.9835 ROC in the competition, which is pretty much as high as a single model could go in the competition. Any scores higher than that are achived by ensembling methods. My subsquent ensemble model got to 0.9865 ROC, which was enough to reach a bronze medal and put me in the top 7%. (The highest model was 0.9885 for reference, with top ten being at 0.9875)

This model, in its many forms, was shared with many particpates at the Boston Kaggle study group. It was the insparational base for over 20 subsquent models from other members of the group. That is why the notebook has so many notes on how to use it, it was an introductry notebook to NLP neural networks for many people.

The Kaggle competition and related dataset can be found here: https://www.kaggle.com/c/jigsaw-toxic-comment-classification-challenge

# Mercari_Price_Suggestion_Challenge_Challenge
A RNN, Ridge, and RidgeCV aggregate model for the Mercari Kaggle competition (RMSLE score of 0.427) 

The Mercari Price Suggestion Challenge is a $100,000 machine learning competition on Kaggle. The goal being to predict the sale price of items on Mercari. Mercari wants to have this prediction so that it can suggest to it's users what price new postings are likely to sell at. 

As an added complication, the challenge only allowed submissions using Kaggle kernals. This means that everyone's code is run on a simulated computer, about as powerful as a good desktop computer,  and has a time limit of 1 hour. No additional dataframes can be saved or brought in between runs.

My model is an aggregate a RNN and 2 Ridge models. It is kept in a jypiter notebook here or in the notebook kernal on Kaggle. It is probably best to view the Kaggle kernal, as all the test and train files are there and ready to explore. If using this GitHub, the test and train files will still need to be picked up on the challenge page. I did good in the compo, I was in the top 100 for a while. I decided that I had other projects to work on so I left it at this point. I published this notebook as a tutorial for others in the compo. As such it has many notes and ideas in the markdowns and comments. It is the best scoring public kernal of the compo as of this posting.


The Kaggle competition and related dataset can be found here: https://www.kaggle.com/c/mercari-price-suggestion-challenge

The original Kernal can be tried and run here: https://www.kaggle.com/valkling/mercari-rnn-2ridge-models-with-notes-0-42755

# Piano_Playing_AI
A Recurrent Neural Network Model that plays piano by predicting the next note in a sequence.


# The_Pythonic_Python_Script_4_Making_Monty_Python_Scripts
(I know, It is pretty much the best title ever!)

This is a whole series of sacked LSTM text generator notebooks.

The python language was named after Monty Python's Flying Circus so why not use python to generate an unlimited supply of new Monty Python scripts? This notebook is a compressed version of my text generating AI. Text generator like this one require a lot of computational power so it only became really feasible to do them on Kaggle Kernels when they upgraded to have a GPU and a 6 hour computational limit. Even so, 6 hours is still kind of lean for an LSTM text generator but I can make it work quite well anyways.

The goal of this notebook is to serve as a introduction to text generation NLPs. These LSTM text generator are actually not that difficult to make. However, most tutorials on the topic are incomplete and/or generate poor results. I'll try to talk about every step of the process thoroughly and clearly. Other than that, this notebook is pretty easy to adapt to any text generation you might want to do. Just pop in any sizeable txt file and the model will learn to make more text in that style. Things like Shakespeare are common and work well for this type of text generation. Make sure that GPU is enabled in settings. Now lets make an AI generate something completely different.

Check it out on Kaggle: https://www.kaggle.com/valkling/pythonicpythonscript4makingmontypythonscripts

Check it out with Seinfeld script data at: https://www.kaggle.com/valkling/pythonicpythonscript4making-seinfeld-scripts

Check it out with the original Star Wars scripts: https://www.kaggle.com/valkling/making-new-ai-generated-star-wars-scripts

# Stanford_Natural_Language_Inference (NLI/NLU)

*The SNLI corpus (version 1.0) is a collection of 570k human-written English sentence pairs manually labeled for balanced classification with the labels entailment, contradiction, and neutral, supporting the task of natural language inference (NLI), also known as recognizing textual entailment (RTE). We aim for it to serve both as a benchmark for evaluating representational systems for text, especially including those induced by representation learning methods, as well as a resource for developing NLP models of any kind.

Read the rest here: https://nlp.stanford.edu/projects/snli/

In short, the dataset provides one line of text and one hypothesis for the text. The goal of the model is to decide if the hypothesis contradicts, entails or is neutral to the text. So the example text "A man inspects the uniform of a figure in some East Asian country." with a hypothesis of "The man is sleeping" is a contradiction because the man cannot inspect if he is asleep.

Check it out the 1DCNN notebook on Kaggle: https://www.kaggle.com/valkling/a-straight-forward-snli-elmo-cnn-attempt

Check it out the BiLSTM notebook on Kaggle: https://www.kaggle.com/valkling/snli-elmo-6bilstm-layers-attempt

SNLI on Kaggle datasets: https://www.kaggle.com/stanfordu/stanford-natural-language-inference-corpus
