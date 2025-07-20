/-    Copyright 2025 Judah Towery

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-/

import Moct.Basic
import Mathlib.CategoryTheory.Category.Basic

open CategoryTheory

/-
  A moct induces a category in the usual sense.
  The objects are the image of dom, encoded as a subtype of α.
  A morphism f : X → Y is an object with dom f = X and cdm f = Y.
  The identity morphism on X is the identity function on X. 
-/

def moct_cat {α : Type} {dom : α → α} {cdm : α → α} {R : α → α → α → Bool} [C : moct α dom cdm R] : 
    Category { a : α // ∃ x : α, dom x = a } where
  Hom X Y := { f : α // dom f = X.val ∧ cdm f = Y.val }
  id X := ⟨id X, ⟨by obtain ⟨x, h⟩ := X.property
                     rw [id, ←h]
                     exact (C.moct_dom_cdm_comp x (dom x) x (C.moct_right_id x)).1.symm, 
                  by obtain ⟨x, h⟩ := X.property
                     rw [id, ←h]
                     exact (C.moct_exists_comp x (dom x) ⟨x, C.moct_right_id x⟩).symm⟩⟩
  comp f g := have := C.moct_comp_exists g.val f.val (by rw [f.property.2, g.property.1])
              sorry

  /-⟨_, by obtain ⟨x, h⟩ := C.moct_comp_exists g.val f.val (by rw [f.property.2 , g.property.1])
                     have := C.moct_dom_cdm_comp _ _ _ h
                     _⟩-/
