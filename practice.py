import nltk
# nltk.download("wordnet")
from nltk.corpus import wordnet as wn
from textblob import TextBlob
import spacy
from transformers import BlenderbotTokenizer, BlenderbotForConditionalGeneration
import time


# Load BlenderBot model and tokenizer
tokenizer = BlenderbotTokenizer.from_pretrained("facebook/blenderbot-400M-distill")
model = BlenderbotForConditionalGeneration.from_pretrained("facebook/blenderbot-400M-distill")


def getDefinition(word):
    s = wn.synset(word+'.n.01')
    return s.definition()

# Function to detect sentiment using TextBlob (positive, negative, or neutral)
def detect_sentiment(sentence):
    """
    Detect sentiment (positive, negative, or neutral) of the sentence.
    """
    blob = TextBlob(sentence)
    polarity = blob.sentiment.polarity

    if polarity > 0:
        return 'Positive'
    elif polarity < 0:
        return 'Negative'
    else:
        return 'Neutral'

# Load the spaCy model for sentence parsing
nlp = spacy.load("en_core_web_sm")
# Function to analyze sentence type (declarative, interrogative, exclamatory, imperative)
def analyze_sentence_type(sentence):
    """
    Analyze the sentence structure and return its type.
    """
    # Process the sentence with spaCy to get the syntactic analysis
    doc = nlp(sentence)

    # Check for punctuation and sentence structure to classify the sentence type
    if sentence.endswith('?'):
        return 'Interrogative'  # Question
    elif sentence.endswith('!'):
        return 'Exclamatory'  # Exclamation
    elif doc[0].tag_ == 'VB' or doc[0].dep_ == 'ROOT':  # Starting with verb or imperative structure
        return 'Imperative'  # Command or request
    else:
        return 'Declarative'  # Statement

def get_blenderbot_response(input_text,model,tokenizer):
    # Tokenize the input text
    inputs = tokenizer([input_text], return_tensors="pt")

    # Generate the reply using the model
    reply_ids = model.generate(inputs['input_ids'])

    # Decode the response and return it
    return tokenizer.decode(reply_ids[0], skip_special_tokens=True)




