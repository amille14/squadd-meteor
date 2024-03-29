module.exports =
  Timestamps: new SimpleSchema
    createdAt:
      type: Date
      label: "The date and time this was created at"
      denyUpdate: true
      autoValue: -> return new Date if @isInsert
    updatedAt:
      type: Date
      label: "The date and time this was last updated at"
      optional: true
      autoValue: -> return new Date if @isUpdate