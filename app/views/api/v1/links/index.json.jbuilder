# frozen_string_literal: true

json.extract! @links, :per_page, :current_page, :total_entries, :total_pages
json.data @links, partial: 'api/v1/links/link', as: :link
