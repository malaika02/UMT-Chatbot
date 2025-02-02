# UMT SST Bot

## 📌 Overview
UMT SST Bot is an AI-powered chatbot designed for the **University of Management and Technology (UMT) School of Science and Technology (SST)**.  
It utilizes **AIML, NLP, Prolog, and Neo4j** to provide intelligent responses for **course and faculty-related queries**.  

---

## 🚀 Features
- 🧠 **AIML for Rule-Based Responses** – Predefined chatbot conversations.  
- 🗣 **NLP for Natural Language Understanding** – Enhances user query processing.  
- 📚 **Prolog for Course Information** – Stores course details and prerequisites.  
- 👩‍🏫 **Neo4j for Faculty Information** – Manages faculty profiles and relationships.  

---

## ⚙️ Technologies Used
| Technology | Purpose |
|------------|---------|
| **AIML** | Chatbot response handling |
| **NLP (spaCy, NLTK)** | Text analysis & intent recognition |
| **Prolog** | Stores & processes course-related logic |
| **Neo4j** | Graph-based database for faculty info |

---

## 🛠 How It Works  
1. **User Query Processing** – NLP analyzes user input.  
2. **AIML Matching** – If a direct response exists, it is returned.  
3. **Prolog Course Lookup** – Queries related to courses are processed in Prolog.  
4. **Neo4j Faculty Search** – Queries related to faculty are handled by Neo4j.  
5. **Response Generation** – The system combines all results and provides an answer.  

---

## 📝 Example Queries  
| User Query | Processed In |
|------------|-------------|
| `"Which courses require Data Structures?"` | **Prolog** |
| `"Who is the head of the CS department?"` | **Neo4j** |
| `"Tell me about AI courses and instructors."` | **Both Prolog & Neo4j** |

---

## 🔧 Installation & Setup  
### 1️⃣ Clone the Repository  
```bash
git clone https://github.com/your-repo/umt-sst-bot.git
cd umt-sst-bot
