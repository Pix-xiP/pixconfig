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

(fn keymap [lhs rhs opts]
  (let [t [lhs rhs]]
    (when opts
      (each [k v (pairs opts)]
        (tset t k v)))
    t))

{: tx : keymap}


