class CreateDocumentFiles < ActiveRecord::Migration
  def change
    create_table :document_files do |t|
      t.string :documentable_type, null: false
      t.integer :documentable_id, null: false
      t.string :doc_file_name
      t.string :doc_content_type
      t.integer :doc_file_size

      t.timestamps
    end

    add_index "document_files", ["documentable_type", "documentable_id"], :name => "index_document_files_on_documentable_type_and_id"

  end
end
