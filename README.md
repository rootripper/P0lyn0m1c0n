# P0lyn0m1c0n

P0lyn0m1c0n is a bash scripting tool that aims to generate custom target wordlists to be used in password attacks during penetration testing exercises.
To generate these wordlists, the tool uses the name of the target and performs multiple combinations of this word, adding elements such as common password words, dates, and numeric characters.

The password combinations and/or patterns used in this tool are based on my experience as a penetration tester and the password patterns I have found throughout my career.

P0lyn0m1c0n uses a base dictionary "basedic.txt" that contains a list of words to be used during password pattern generation.
Currently this dictionary contains words that I personally recommend in password attacks where your target is a Spanish speaker.
Feel free to edit this dictionary according to your needs, so if your target likes raccoons, add raccoons to this dictionary and so on.

Mainly but not limited to, I recommend using these wordlists in WPA-2 password attacks.

## Dependencies

P0lyn0m1c0n requires sponge installed on our computer and sponge is a utility that is not installed by default on some distributions.

If we do not have sponge installed, we will install moreutils:

└─# apt-get install moreutils

## Run P0lyn0m1c0n

To run P0lyn0m1c0n, simply run the script on your Linux terminal and provide the name of your target, then a .txt file will be generated in the current directory called P0lyn0m1c0n_{target}.txt containing your custom wordlist.

![image](https://user-images.githubusercontent.com/53503609/198971855-99a16391-4dc8-4cb8-9252-354ea877aa0d.png)

Some examples of generated passwords are shown below:

![image](https://user-images.githubusercontent.com/53503609/198873777-09065ae4-8445-46f2-bf7c-686816f0b43e.png)
