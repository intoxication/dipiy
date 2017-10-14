
require "html/pipeline"

context = {
  gfm: true,
  video_width: 700,
  video_height: 387
}

filters = [
  Homeland::Pipeline::NormalizeMentionFilter,
  Homeland::Pipeline::EmbedVideoFilter,
  Homeland::Pipeline::MarkdownFilter,
  Homeland::Pipeline::MentionFilter,
  Homeland::Pipeline::FloorFilter,
  Homeland::Pipeline::TwemojiFilter
]

TopicPipeline = HTML::Pipeline.new(filters, context)

module Homeland
  class Markdown
    class << self
      def call(body)
        result = TopicPipeline.call(body)[:output].inner_html
        result.strip!
        result
      end

      def example
        @example ||= <<~EXAMPLE
        # Guide

        This is an example of how to correctly use ** Markdown ** typesetting, learn this is necessary, make your articles have better clarity typesetting.

        > Quote text: Markdown is a text formatting syntax inspired

        ## 语法指导

        ### 普通内容

       This content shows some small format in the content, such as:

       - ** bold ** - `** bold **`
        - * tilt * - `* tilt *`
        - ~ ~ remove the line ~ ~ ~ `~ ~ remove the line ~ ~`
        - `Code tag` - `\` Code tag \ ``
        - [hyperlinks] (http://github.com) - `[hyperlinks] (http://github.com)`
### mention the user

        @foo @bar @someone ... can be mentioned in the post and replies inside the user, after the information submitted, the user will be mentioned will receive a system notification. So that he can pay attention to this post or Replies.

        ### Emoji Emoji

        Support emoticons, you can use the system default Emoji symbols (can not support Windows users).
        You can also use the expression of the picture, enter `:` will appear smart tips.

        #### Some examples of expressions

        : smile:: laughing:: dizzy_face:: sob:: cold_sweat:: sweat_smile:: cry:: triumph:: heart_eyes:: relaxed:: sunglasses:: weary:

        : Kiss:: kiss:: sweat_drops:: hankey: : exclamation:: anger:

        ### Headline - Heading 3

        You can choose to use H2 to H6, use ## (N) at the beginning, H1 can not be used, will automatically convert to H2.

        > NOTE: Do not forget # behind the need for a space!

        #### Heading 4

        ##### Heading 5

        ###### Heading 6
- [username@gmail.com] (mailto: username@gmail.com) - `[username@gmail.com] (mailto: username@gmail.com)`
       
        ### picture

       `` ``
        ! [alt text] (http: //image-path.png)
        ! [alt text] (http: //image-path.png "picture title value")
        ! [Set Image Width Height] (http: //image-path.png = 300x200)
        ! [Set Picture Width] (http: //image-path.png = 300x)
        ! [Set picture height] (http: //image-path.png = x200)
        `` ``

        ### code block

        #### Ordinary

        `` ``
        * highlight * ** strong **
        _emphasize_ __strong__
        @a = 1
        `` ``

        #### Syntax highlight support

        If the \ `\` `` later with the language name, you can have the effect of grammar highlight Oh, for example:

        ##### Demonstrate Ruby code highlighting

        `` `ruby
        class PostController <ApplicationController
          def index
            @posts = Post.last_actived.limit (10)
          end
        end
        `` ``

        ##### Demo Rails View highlight

        `` `erb
        <% = @ posts.each do | post |%>
        <div class = "post"> </ div>
        <% end%>
        `` ``

        ##### Demo YAML file

        `` `yml
        en:
          name: name
          age: age
        `` ``

      > Tip: language names support the following: `ruby`,` python`, `js`,` html`, `erb`,` css`, `coffee`,` bash````sson`````` xml`

        ### orderly, unordered list

        #### Unordered list

        - Ruby
          - Rails
            - ActiveRecord
        - Go
          - Gofmt
          - Revel
        - Node.js
          - Koa
          - Express

        #### Ordered list

        1. Node.js
          1. Express
          2. Koa
          3. Sails
        2. Ruby
          1. Rails
          2. Sinatra
        3. Go

        ### form

        If you need to show what the data, you can choose to use the form Oh

        header 1 | header 3 |
        | -------- | -------- |
        cell 1 | cell 2 |
        cell 3 | cell 4 |
        cell 5 | cell 6 |

        ### Paragraph

        Leaving blank line, will be automatically converted into a paragraph, there will be a certain paragraph spacing, easy to read.

        Please note that the next line of Markdown source code is blank.

        ### Video is inserted

        At present, support Youtube and Youku two video insert, you only need to copy the video playback page, the browser address bar page URL address, and paste into the topic / reply text box, after the submission will automatically convert to video player.

        #### E.g

        ** Youtube **

        https://www.youtube.com/watch?v=CvVvwh3BRq8

        ** Vimeo **

        https://vimeo.com/199770305

        ** Youku **

        http://v.youku.com/v_show/id_XMjQzMTY1MDk3Ng==.html

        To

        EXAMPLE
      end
    end
  end
end