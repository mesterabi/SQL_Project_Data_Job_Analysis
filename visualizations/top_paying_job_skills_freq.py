import json
import pandas as pd
import matplotlib.pyplot as plt
from collections import Counter

# Extract skills from Approach 1 JSON (flattened list)
skills_list = [
    "sql", "python", "r", "azure", "databricks", "aws", "pandas", "pyspark", "jupyter", "excel", "tableau", "power bi", "powerpoint",
    "sql", "python", "r", "hadoop", "tableau",
    "sql", "crystal", "oracle", "tableau", "flow",
    "sql", "python", "go", "snowflake", "pandas", "numpy", "excel", "tableau", "gitlab",
    "sql", "python", "azure", "aws", "oracle", "snowflake", "tableau", "power bi", "sap", "jenkins", "bitbucket", "atlassian", "jira", "confluence",
    "sql", "python", "r", "git", "bitbucket", "atlassian", "jira", "confluence",
    "sql", "python", "go", "snowflake", "pandas", "numpy", "excel", "tableau", "gitlab",
    "sql", "python", "r"
]

# Count frequencies
skill_counts = Counter(skills_list)
df = pd.DataFrame(list(skill_counts.items()), columns=['skills', 'frequency'])
df = df.sort_values(by='frequency', ascending=False).head(10)

# Plot
fig, ax = plt.subplots(figsize=(10, 6))
ax.bar(df['skills'], df['frequency'], color='green')
ax.set_ylabel('Frequency in Top Jobs')
ax.set_title('Top Skills Frequency in High-Paying Data Analyst Jobs')
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.savefig('top_paying_job_skills_freq.png')  # Save to file