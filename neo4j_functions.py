# neo4j_functions.py

from neo4j import GraphDatabase

# Initialize the Neo4j driver
def get_neo4j_driver():
    return GraphDatabase.driver("bolt://localhost:7687", auth=("neo4j", "11223344"))

# Query Neo4j to get the email or designation of a faculty member
def query_neo4j(query_type, faculty_name):
    driver = get_neo4j_driver()
    with driver.session() as session:
        if query_type == "email":
            result = session.run(
                "MATCH (f:Faculty) WHERE toLower(f.name) = toLower($name) RETURN f.email AS info",
                name=faculty_name
            )
        elif query_type == "designation":
            result = session.run(
                "MATCH (f:Faculty) WHERE toLower(f.name) = toLower($name) RETURN f.designation AS info",
                name=faculty_name
            )
        else:
            return "I don't have information about that."

        record = result.single()  # Get the first (or only) record
        if record:
            info = record.get("info")
            if info:
                return info
            else:
                return f"No {query_type} found for {faculty_name}."
        else:
            return f"No {query_type} found for {faculty_name}."
