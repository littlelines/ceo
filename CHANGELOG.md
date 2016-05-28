# Changelog

* __v0.2.0__
    * Two controllers are now available, `CEOController` and
      `AdminController`. All main functionality is now in `CEOController`.
    * Authentication is now enabled by default via the
      `#authenticate_admin!` method.
    * A styleguide and dashboard are now available by
      default. (see `/admin/styleguide` & `/admin/dashboard`)
* __v0.1.7__
    * Allows passing options to `admin_for`, just like with `resources`.
* __v0.1.6__
    * Allows passing a block to `admin_for` which delegates the block
      to the new resource routes. It's like passing a block to
      `resources`, but with all the benefits of `admin_for`
      (pagination and the `admin` namespace).
    * Updates dependencies

* __v0.1.5__
    * Fixes the problems revealed in v0.1.4 and extends
      `AdminMiddleware` instead of `AdminHelper` inside of `AdminHelper`.

* __v0.1.4__
    * Allows for `AdminHelper` to be included as a means of extending
      `AdminController`

* __v0.1.3__
    * Adds #show method view.
    * Reorganizes tests and tests more in-depth.

* __v0.1.2__
    * Adds generators for routes, controllers, and `_form` view.
    * Fixes pagination errors and adds tests for pagination.

* __v0.1.1__
    * Adds default views and removes need for simple_form.
    * Adds tests for basic functionality of all main actions.

* __v0.1.0__
    * Initial release.
