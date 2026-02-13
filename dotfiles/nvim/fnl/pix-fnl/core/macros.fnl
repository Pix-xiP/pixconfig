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

(fn wk-entry [lhs kvs]
	(let [t [lhs]]
		(when kvs
			(each [k v (pairs kvs)]
				(tset t k v)))
		t))

;; makes: { mode = {..}, {..}, {..}}
(fn wk-spec [modes entries]
	(let [t []]
			(tset t :mode modes)
			(each [_ e (ipairs entries)]
				(table.insert t e))
			t))

{: tx : keymap : wk-entry : wk-spec}


