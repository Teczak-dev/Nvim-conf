return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			
			-- Custom PHP snippets
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node
			
			ls.add_snippets("php", {
				s("class", {
					t("<?php"), t({"", "", "class "}), i(1, "ClassName"), t({" {", ""}),
					t("    public function __construct()"), t({"", "    {", "        "}), i(0),
					t({"", "    }", "", "}"}),
				}),
				s("function", {
					t("public function "), i(1, "functionName"), t("("), i(2), t(")"), t({"", "{", "    "}), i(0),
					t({"", "}"}),
				}),
				s("laravel_controller", {
					t("<?php"), t({"", "", "namespace App\\Http\\Controllers;", "", "use Illuminate\\Http\\Request;", "", "class "}),
					i(1, "Controller"), t({"Controller extends Controller", "{", "    public function index()", "    {", "        "}), i(0),
					t({"", "    }", "}"}),
				}),
				s("laravel_model", {
					t("<?php"), t({"", "", "namespace App\\Models;", "", "use Illuminate\\Database\\Eloquent\\Factories\\HasFactory;", "use Illuminate\\Database\\Eloquent\\Model;", "", "class "}),
					i(1, "Model"), t({" extends Model", "{", "    use HasFactory;", "", "    protected $fillable = ["}), i(0),
					t({"", "    ];", "}"}),
				}),
				s("blade_extends", {
					t("@extends('"), i(1, "layout"), t("')"), t({"", "", "@section('"}), i(2, "content"), t("')"), t({"", ""}), i(0), t({"", "@endsection"}),
				}),
			})
		end,
	},
}