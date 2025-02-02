NOVA SST
Overview
UMT SST Bot is an intelligent chatbot designed for the University of Management and Technology (UMT) School of Science and Technology (SST). It utilizes AIML, NLP, Prolog, and Neo4j to provide smart, structured, and interactive responses to user queries regarding courses and faculty.

Features
AIML for Predefined Chat Patterns – Handles basic conversational flows.
NLP for Natural Language Understanding – Enhances query processing and intent recognition.
Prolog for Course Information – Stores and retrieves course details using logical rules.
Neo4j for Faculty Information – Manages faculty relationships, expertise, and department structure using a graph database.
Technologies Used
AIML – Chatbot response handling.
NLP (spaCy, NLTK, etc.) – Text processing for better understanding of user queries.
Prolog – Logic-based reasoning for storing and retrieving course information.
Neo4j – Graph-based database to manage faculty details and relationships.
How It Works
User Query Processing: NLP analyzes and extracts intent from user input.
AIML Matching: If the query fits predefined AIML patterns, a direct response is returned.
Prolog Course Lookup: Queries related to courses (e.g., "What are the prerequisites for AI?") are processed in Prolog.
Neo4j Faculty Search: Queries related to faculty (e.g., "Who teaches Machine Learning?") are processed in Neo4j.
Response Generation: The system combines results from multiple sources to provide a meaningful response.
Example Queries
"Which courses require Data Structures?" → Processed in Prolog
"Who is the head of the CS department?" → Retrieved from Neo4j
"Tell me about AI courses and instructors." → Uses both Prolog & Neo4j
