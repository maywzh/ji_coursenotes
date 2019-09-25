import collections
import string


# XORs two string
def str_xor(a, b):     # xor two strings (trims the longer input)
    return "".join([chr(ord(x) ^ ord(y)) for (x, y) in zip(a, b)])

# Initialize the ciphertexts list and targetciphertext


def read_ciphertexts(ciphertextpath, targetciphertextpath):
    cyphertext_list = []
    target_ciphertext = ""
    with open(ciphertextpath) as f:
        for line in f:
            cyphertext_list.append(line)
    with open(ciphertextpath) as f:
        target_ciphertext = f.readline()
    return cyphertext_list, target_ciphertext

# Gusee key by the space


def dectect_key(ciphertext_list):
    # For each ciphertext
    for i, cti in enumerate(ciphertext_list):
        counter = collections.Counter()
        for j, ctj in enumerate(ciphertext_list):
            if i != j:  # Just dont compare with itself 
                for k, char in enumerate(str_xor(cti, ctj)):
                    if char in string.printable and char.isalpha():
                        # space(0x20) ^ letter == letter
                        # the kth position are likely to be the space
                        counter[k] += 1
        possible_space_idxs = []

        # Loop through all positions where a space character was possible in the current_index cipher
        for i, val in list(counter.items()):
            # assume position with this situation occuring no less than 6 times as space.
            if val >= 6:
                possible_space_idxs.append(i)
        # print knownSpaceIndexes # Shows all the positions where we now know the key!

        # Now Xor the current_index with spaces, and at the knownSpaceIndexes positions we get the key back!
        space_xor_test = str_xor(cti, ' '*150)
        for i in possible_space_idxs:
            # Store the key's value at the correct position
            final_key[i] = space_xor_test[i]
            # Record that we known the key at this position
            possible_space_idxs.add(i)


def run(target):
    cyphertext_list, target_ciphertext = read_ciphertexts(
        "./ciphertext.txt", "./target_ciphertext.txt")
    # To store the final key
    final_key = [None]*150
    # To store the positions we know are broken
    known_key_positions = set()

    # Construct a hex key from the currently known key, adding in '00' hex chars where we do not know (to make a complete hex string)
    final_key_hex = ''.join(
        [val if val is not None else '00' for val in final_key])
    # Xor the currently known key with the target cipher
    output = str_xor(target_ciphertext, final_key_hex)
    # Print the output, printing a * if that character is not known yet
    print(''.join(
        [char if index in known_key_positions else '*' for index, char in enumerate(output)]))
