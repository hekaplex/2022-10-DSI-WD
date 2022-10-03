def orange_whip(guess, dudlist):
    import copy
    import collections
    from english_words import english_words_lower_alpha_set
    alpha = {a for a in "abcdefghijklmnopqrstuvwxyz"}
    duds = {a for a in dudlist}
    choices = "".join(list(alpha - duds))
    numch = len(list(choices))
    #print(f"{numch} letters in play: {choices}")
    wordslop = []
    repl = collections.Counter(guess)['*']
    for blank in range(0,repl):
        #print(f"iterations: {collections.Counter(guess)['*']}")
        #print(f"iteration: {blank}")
        for ltr1 in choices:
            if blank == 0:
                wordslop.append(guess.replace("*",ltr1,1))
            else:
                newslop = [w.replace("*",ltr1,1) if "*" in w  else w for w in wordslop]
                wordslop += newslop  
        wordset = list(set(wordslop) & english_words_lower_alpha_set)

    return wordset

g = input("guess:")
d = input("duds:")   
print(orange_whip(g, d))