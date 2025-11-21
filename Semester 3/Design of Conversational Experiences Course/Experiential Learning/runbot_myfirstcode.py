# Open a terminal and type > "pip install python-aiml"
# It will show response as -> "Successfully installed python-aiml-0.9.3"
# Run the script by typing in terminal > python runbot_myfirstcode.py

import aiml

# Create the kernel (bot brain)
kernel = aiml.Kernel()

# Load the AIML files
kernel.learn("/Users/bharathis/Dropbox/BITS/DoCE/Lab/AIML/MyFirstCode.aiml") 

# Main loop to chat with the bot
print("Hello! You can start chatting with the bot now. Type 'quit' to exit.")

while True:
    user_input = input("You: ")
    if user_input.lower() == "quit":
        print("Goodbye!")
        break
    
    # Get the bot's response
    response = kernel.respond(user_input)
    print("Bot: ", response)
