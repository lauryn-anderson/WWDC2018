/*:
 # Blank It
 ## Your very own Mad Libs® generator – created by you!
 Have you ever played Mad Libs®? It's a fun fill-in-the-blanks game that has been well-loved for years. But even though there are lots of Mad Libs® out there, wouldn't it be fun to be able to make a fill-in-the-blanks game out of...anything?
 
 Cue **Blank It**, the ultimate Mad Lib generator.
 
 ## Are you ready?
 
 Let's find out how **Blank It** works!
 
 First, we need a paragraph from the user. Either use the quote provided below or type in your own.
*/
let text = /*#-editable-code*/"The king's stinking son fired me. And thank you so much for bringing up such a painful subject. While you're at it, why don't you give me a nice paper cut and pour lemon juice on it? We're closed!"/*#-end-editable-code*/
/*:
 **Run My Code** to move on to the next step!
*/
//#-hidden-code
import PlaygroundSupport
let page = PlaygroundPage.current
page.keyValueStore["text"] = .string(text)

show("The paragraph you are using is: ")
show(text)

PlaygroundPage.current.assessmentStatus =
    .pass(message: "### Great job! \nNow, we need to **do** something with the paragraph! \n\n[**Next Page**](@next)")
//#-end-hidden-code
