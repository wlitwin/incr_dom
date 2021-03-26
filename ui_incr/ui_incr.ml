open! Core_kernel
let callback = ref (fun () -> ())
module Incr = Incremental.Make_with_config (struct
    let bind_lhs_change_should_invalidate_rhs = true
    let on_dirty_callback () =
        !callback()
end)()

let clock = Incr.Clock.create ~start:(Time_ns.now ()) ()

include Incr
module Map = Incr_map.Make (Incr)
module Select = Incr_select.Make (Incr)
