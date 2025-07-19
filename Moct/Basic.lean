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

/- 
  Here, α is a type of morphisms.
  We compose morphisms through R as a witness to their composition: R x y z ↔ x ∘ y = z.
-/

class moct (α : Type) (dom : α → α) (cdm : α → α) (R : α → α → α → Bool) where
  moct_partial_map : ∀ x y z z', R x y z ∧ R x y z' → z = z'           -- Composition is a partial mapping in two variables.
  moct_comp : ∀ x y, dom x = cdm y ↔ ∃ z, R x y z                      -- Morphisms are composable iff their domains and codomains match.
  moct_dom_cdm_comp : ∀ x y z, R x y z → dom z = dom y ∧ cdm z = cdm x -- The domain and codomain of a composite z = x ∘ y.
  moct_assoc : ∀ x y z a b, R x y a ∧ R y z b → ∃ w, R x b w ∧ R a z w -- Associativity. If x ∘ y = a and y ∘ z = b, then there is a common composite w such that x ∘ b = x ∘ (y ∘ z) = w and a ∘ z = (x ∘ y) ∘ z = w.
  moct_left_id : ∀ x, R x (dom x) x                                    -- dom witnesses the left identity.
  moct_right_id : ∀ x, R (cdm x) x x                                   -- cdm witnesses the right identity.
