  <% article.errors.full_messages_for(:title).each do |message| %>
                  <div><%= message %></div>
                <% end %>