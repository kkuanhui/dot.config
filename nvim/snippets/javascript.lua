-- Put this in ~/.config/nvim/snippets/javascript.lua (and/or typescript.lua)

local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.snippet
local i = ls.insert_node

ls.add_snippets("javascript", {
  s("mig", fmt([[
{}'use strict';

module.exports = {{
  up: async (queryInterface, Sequelize) => {{
    const transaction = await queryInterface.sequelize.transaction();
    try {{
      {}

      await transaction.commit();
    }} catch (error) {{
      await transaction.rollback();
      throw error;
    }}
  }},

  down: async (queryInterface, Sequelize) => {{
    const transaction = await queryInterface.sequelize.transaction();
    try {{
      {}

      await transaction.commit();
    }} catch (error) {{
      await transaction.rollback();
      throw error;
    }}
  }}
}};
]], {
    i(1,""),
    "// TODO: write migration code here",
    "// TODO: write rollback code here",
  }, {
    delimiters = "{}"  -- optional: changes {} to [] if you prefer
  }))
})
