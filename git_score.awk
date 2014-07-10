# This code was pulled and then enhanced from intridea.com:
#   http://www.intridea.com/blog/2009/2/11/awk-tricks

# WHAT: Gives decently complete stats on Conributer's "Score" (contributions) for a repo
# WHY:  Because I wanted to.
# HOW:  Download & place this file somewhere accessible.
#       Inside of your git repo, run the command:
#           git log --numstat | awk -f /path/to/git_score.awk
#       And there ya go.
# COPY: Uh, I'm not sure what the standard protocol is since I already admitted to taking much of this from a very helpful blog post.
#       But I feel like code on Github needs a license, so let's just say MIT and call it good, yeah?

/^Author:/ {
   author = $2
   if (author=="MrQweex" || author=="notbryant")
       author = "Jon";
   if (author=="mettledrum")
       author = "Andrew";
   data[author, "Commits"] += 1
   total["Commits"] += 1
   authors[author] = 1
}

/^[0-9].*framework/ { next }

/^[0-9]/ {
   data[author, "Added"] += $1
   data[author, "Removed"] += $2
   data[author, "Files"] += 1

   total["Added"]  += $1
   total["Removed"]  += $2
   total["Files"]  += 1
}

END {

    # So first lets calculated some last-minutely needed data
    total["Changed"] = total["Added"] + total["Removed"]
    
    for (author in authors) {
        data[author, "%Added"]    = data[author, "Added"]   / total["Added"]   * 100
        data[author, "%Removed"]  = data[author, "Removed"] / total["Removed"] * 100
        data[author, "%Files"]    = data[author, "Files"]   / total["Files"]   * 100
        data[author, "%Commits"]  = data[author, "Commits"] / total["Commits"] * 100

        data[author, "Changed"]   = data[author, "Added"] + data[author, "Removed"] 
        data[author, "%Changed"]  = data[author, "Changed"] / total["Changed"] * 100
    }
    
    
    # These are all the attributes we will iterate over; pipe signifies an empty line.
    attr_size = split("Added Removed Changed | %Added %Removed %Changed | Files %Files | Commits %Commits", attributes, " ")
    
    # Column widths; for the 1st, and then all others
    col_1w = 10;
    col_w = 12;
    
    # Print the header
    printf("%-" col_1w "s", "");  # Empty space, for alignment
    for (author in authors)
        printf("%" col_w "s", author);
    printf("%" col_w "s", "Total");
    printf("\n");
    
    # Print the horizontal line
    # (this is, ironically, the least elegant part about this script)
    for (x = 0; x < col_1w; x++)
        printf("%s", " ");
    for (author in authors)
        for (x = 0; x < col_w; x++)
            printf("%s", "-");
    for (x = 0; x < col_w; x++)
        printf("%s", "-");
    printf("\n");
    
    
    # Finally, let's iterate over the list of attributes we had earlier
    for (i=1; i<=attr_size; i++) {
        if (attributes[i] != "|") {
            printf("%+" col_1w "s", attributes[i]);     # 1st column: attribute name
            
            # Iterate over each author
            for (author in authors) {
                # Handle special formatting for percents
                if (attributes[i] ~ /%/)
                    printf("%" col_w-1 "d%%", data[author, attributes[i]]);
                else
                    printf("%" col_w "d", data[author, attributes[i]]);
            }
            # Last column: total; only print if it is a thing!
            if (total[attributes[i]]!=0)
                printf("%" col_w "d", total[attributes[i]]);
            else
                printf("%" col_w "s", "-");
            
        }
        printf("\n");
    }
}
