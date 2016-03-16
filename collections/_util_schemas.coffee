@UtilSchemas =
  Timestamps: new SimpleSchema
    createdAt:
      type: Date
      label: "The date and time this was created at"
      denyUpdate: true
      autovalue: -> return new Date if @isInsert
    updatedAt:
      type: Date
      label: "The date and time this was last updated at"
      autovalue: -> return new Date if @isUpdate