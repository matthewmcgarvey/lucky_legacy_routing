module LuckyLegacyRouting
  VERSION = "0.1.0"

  macro nested_route
    infer_nested_route

    setup_call_method({{ yield }})
  end

  macro route
    infer_route

    setup_call_method({{ yield }})
  end

  macro infer_nested_route
    infer_route(has_parent: true)
  end


  macro infer_route(has_parent = false)
    {{ run "./run_macros/infer_route", @type.name, has_parent }}
  end
end
