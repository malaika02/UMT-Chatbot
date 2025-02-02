import time
import aiml
import os
from glob import glob
from flask import Flask, render_template, request
from practice import getDefinition, detect_sentiment, analyze_sentence_type, get_blenderbot_response  # Import your custom functions
from transformers import BlenderbotTokenizer, BlenderbotForConditionalGeneration  # Import the necessary components
import tensorflow as tf
from neo4j_functions import query_neo4j  # Import Neo4j functions

os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'

# Monkey-patch time.clock() for compatibility with Python 3.8+
if not hasattr(time, "clock"):
    time.clock = time.perf_counter

# Initialize the AIML Kernel
bot = aiml.Kernel()

# Flask app initialization
app = Flask(__name__)

# Specify the folder where the AIML files are located
aiml_folder = 'techsage'  # Update this path accordingly

# A dictionary to store sentence types and sentiment
sentence_history = {}

# Function to load AIML files
def load_aiml_files(folder_path):
    """
    Load AIML files from the specified folder.
    """
    aiml_files = glob(os.path.join(folder_path, '*.aiml'))
    if not aiml_files:
        raise FileNotFoundError(f"No AIML files found in folder: {folder_path}")
    for file in aiml_files:
        bot.learn(file)
    print(f"Loaded {len(aiml_files)} AIML files from {folder_path}")

# Handle user input and generate response
def get_response(user_input):
    """
    Generate a response from the bot based on user input.
    """
    # Analyze the sentence type
    sentence_type = analyze_sentence_type(user_input)
    # Detect sentiment of the sentence
    sentiment = detect_sentiment(user_input)

    print(f"Sentence Type: {sentence_type}")
    print(f"Sentiment: {sentiment}")

    # Store sentence type and sentiment in history
    sentence_history['last_sentence_type'] = sentence_type
    sentence_history['last_sentence_sentiment'] = sentiment

    # First, check AIML files for a response
    bot_response = bot.respond(user_input)
    if bot_response and bot_response != 'Sorry, I didn’t understand that.':
        # Check if AIML response requires additional handling
        word = bot.getPredicate("word")  # Check if a word is captured by the AIML pattern
        if word:
            definition = getDefinition(word)  # Get word definition from WordNet or another source
            print("Definition: ", definition)
            bot.setPredicate("definition", definition)  # Store the definition in AIML predicate
            bot_response = bot.respond(user_input)
        return bot_response

    print("No AIML pattern matched. Checking sentiment...")

    # Generate response based on sentiment
    if sentiment == 'Positive':
        return "That's great! I'm happy to hear that!"  # Response for positive sentiment
    elif sentiment == 'Negative':
        return "I'm sorry to hear that. How can I help?"  # Response for negative sentiment
    else:
        print("Sentiment neutral. Using BlenderBot...")

        # If the user is asking about a faculty member's email or designation, query Neo4j
        if 'email' in user_input.lower() or 'designation' in user_input.lower():
            faculty_name = user_input.split("of")[-1].strip()  # Extract faculty name
            if 'email' in user_input.lower():
                query_type = 'email'
            else:
                query_type = 'designation'

            info = query_neo4j(query_type, faculty_name)
            return f"The {query_type} of {faculty_name} is: {info}"

        # Use BlenderBot transformer model as a fallback
        transformer_response = get_blenderbot_response(user_input, model, tokenizer)  # Pass model and tokenizer
        return transformer_response

# Route for home page
@app.route("/")
def home():
    return render_template("home.html")

# Route to get bot response
@app.route("/get")
def get_bot_response():
    query = request.args.get('msg', '').strip()
    if not query:
        return "Please provide a message."

    # If user asks for the previous sentence type and sentiment
    if query.lower() == "what was my previous sentence type?":
        sentence_type = sentence_history.get('last_sentence_type', "No previous sentence type found.")
        sentiment = sentence_history.get('last_sentence_sentiment', "No previous sentence sentiment found.")
        return f"Your previous sentence was {sentence_type} with {sentiment} sentiment."

    # Otherwise, process normal response
    response = get_response(query)
    return str(response)

# Run Flask app
if __name__ == "__main__":
    # Initialize the BlenderBot model and tokenizer
    model = BlenderbotForConditionalGeneration.from_pretrained(
        "facebook/blenderbot-400M-distill",  # You can remove the cache_dir if not needed
        cache_dir=r"C:\Users\hp\.cache\huggingface\hub\models--facebook--blenderbot-400M-distill"
        # Optional custom cache path
    )

    tokenizer = BlenderbotTokenizer.from_pretrained("facebook/blenderbot-400M-distill")
    try:
        # Load AIML files
        load_aiml_files(aiml_folder)

        print("AIML files loaded successfully.")

        # Run Flask app
        app.run(debug=True, host='0.0.0.0', port=5000)

    except Exception as e:
        print(f"Error: {e}")
