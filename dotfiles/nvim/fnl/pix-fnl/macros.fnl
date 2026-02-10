;; [nfnl-macro]

(fn tx [& args]
	"Mixed sequential and associative tables at compile time"
	(let [to-merge (when (table? (. args (length args)))
										(table.remove args))]
		(if to-merge
			(do
				(each [k v (pairs to-merge)]
					(tset args k v))
				args)
			args)))

{: tx}
