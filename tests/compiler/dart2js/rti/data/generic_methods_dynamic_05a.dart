// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.7

// Reduced version of generic_methods_dynamic_05a_strong.

import "package:expect/expect.dart";

/*prod:nnbd-off.class: A:deps=[C.bar],explicit=[A<B>],needsArgs*/
/*spec:nnbd-off.class: A:deps=[C.bar],direct,explicit=[A.T,A<B>,A<bar.T>],needsArgs*/
/*spec:nnbd-sdk.class: A:deps=[C.bar],direct,explicit=[A.T*,A<B*>*,A<bar.T*>*],needsArgs*/
/*prod:nnbd-sdk.class: A:deps=[C.bar],explicit=[A<B*>*],needsArgs*/
class A<T> {
  final T field;

  A(this.field);
}

/*prod:nnbd-off.class: B:explicit=[A<B>]*/
/*spec:nnbd-off.class: B:explicit=[A<B>],implicit=[B]*/
/*spec:nnbd-sdk.class: B:explicit=[A<B*>*],implicit=[B]*/
/*prod:nnbd-sdk.class: B:explicit=[A<B*>*]*/
class B {}

class C {
  /*spec:nnbd-sdk.member: C.bar:explicit=[A<bar.T*>*],implicit=[bar.T],indirect,needsArgs,selectors=[Selector(call, bar, arity=1, types=1)]*/
  /*prod:nnbd-off|prod:nnbd-sdk.member: C.bar:needsArgs,selectors=[Selector(call, bar, arity=1, types=1)]*/
  /*spec:nnbd-off.member: C.bar:explicit=[A<bar.T>],implicit=[bar.T],indirect,needsArgs,selectors=[Selector(call, bar, arity=1, types=1)]*/
  A<T> bar<T>(A<T> t) => new A<T>(t.field);
}

main() {
  C c = new C();

  dynamic x = c.bar<B>(new A<B>(new B()));
  Expect.isTrue(x is A<B>);
}
