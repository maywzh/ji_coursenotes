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
        lines = f.readlines()
        for line in lines:
            cyphertext_list.append(line.strip('\n'))
    with open(targetciphertextpath) as f:
        target_ciphertext = f.readline().strip('\n')
    return cyphertext_list, target_ciphertext

# Gusee key by the space
def dectect_key(ciphertext_list):
    # For each ciphertext
    final_key = [None]*150
    possible_space_idxs = []
    for i, cti in enumerate(ciphertext_list):
        counter = collections.Counter()
        for j, ctj in enumerate(ciphertext_list):
            if i != j:  # Just dont compare with itself
                for k, char in enumerate(str_xor(cti, ctj)):
                    if char in string.printable and char.isalpha():
                        # space(0x20) ^ letter == letter
                        # the kth position are likely to be the space
                        counter[k] += 1
        
        for i, val in list(counter.items()):
            # assume position with this situation occuring no less than 6 times as space.
            if val >= 6:
                possible_space_idxs.append(i)
        
        # This is core idea: XOR the current ciphertext with spaces, we can get key in these positions.
        space_xor_test = str_xor(cti, ' '*150)
        for i in possible_space_idxs:
            final_key[i] = space_xor_test[i]
            possible_space_idxs.add(i)
    return final_key, possible_space_idxs


def run(target):
    ciphertext_list, target_ciphertext = read_ciphertexts(
        "./ciphertext.txt", "./target_ciphertext.txt")
    final_key,possible_space_idxs = dectect_key(ciphertext_list)
    final_key_hex = ''.join(
        [val if val is not None else '00' for val in final_key])
    output = str_xor(target_ciphertext, final_key_hex)
    print(''.join(
        [char if index in possible_space_idxs else '*' for index, char in enumerate(output)]))
    print(str_xor(final_key_hex, target_ciphertext))
if __name__ == "__main__":
    run()