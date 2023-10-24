

<div class="text-center">
   <div class="flicker_pagination">
    <div class="page_info">
      <%= page_entries_info @posts %>
    </div>
    <%= will_paginate @articles, :container => false %>
  </div>
</div>