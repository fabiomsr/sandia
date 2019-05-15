library sandia;

import 'package:flutter/widgets.dart';

abstract class Resolver {
  T get<T>(Type type);
}

abstract class Provider<T> {
  final Type type;

  final T Function(Resolver resolver) _builder;

  Provider(this.type, this._builder);

  T value(Resolver resolver);
}

class Single<T> extends Provider<T> {
  T _value;

  Single(Type type, T Function(Resolver resolver) builder)
      : super(type, builder);

  @override
  T value(Resolver resolver) {
    if (_value == null) {
      _value = _builder(resolver);
    }
    return _value;
  }
}

class Factory<T> extends Provider {
  Factory(Type type, T Function(Resolver resolver) builder)
      : super(type, builder);

  T value(Resolver resolver) {
    return _builder(resolver);
  }
}

abstract class Module {
  List<Provider> providers();
}

class Injector extends InheritedWidget {
  final _Resolver _resolver;

  Injector._(key, child, this._resolver) : super(key: key, child: child);

  factory Injector({
    Key key,
    List<Provider> providers = const [],
    List<Module> modules = const [],
    @required Widget child,
  }) {
    modules.forEach((module) => providers.addAll(module.providers()));
    final providerMap =
        Map<Type, Provider>.fromIterable(providers, key: (item) => item.type);
    final resolver = _Resolver(providerMap);
    return Injector._(key, child, resolver);
  }

  static Injector of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(Injector);

  @override
  bool updateShouldNotify(Injector oldWidget) =>
      this._resolver != oldWidget._resolver;

  T resolve<T>(BuildContext context, Type type) {
    _resolver.buildContext = context;
    return _resolver.get(type);
  }

  bool hasProvider(Type type) => _resolver.hasProvider(type);
}

class _Resolver implements Resolver {
  final Map<Type, Provider> _providers;
  BuildContext _buildContext;

  bool hasProvider(Type type) => _providers.containsKey(type);

  set buildContext(BuildContext buildContext) {
    _buildContext = buildContext;
  }

  _Resolver(this._providers);

  @override
  T get<T>(Type type) {
    final provider = _providers[type];

    if (provider == null) {
      return getFromParent(type);
    }

    return provider != null ? provider.value(this) : null;
  }

  T getFromParent<T>(Type type) {
    T value;

    _buildContext.visitAncestorElements((e) {
      if (e.widget is Injector) {
        final parent = e.ancestorWidgetOfExactType(Injector) as Injector;
        if (parent != null && parent.hasProvider(type)) {
          value = parent.resolve(e, type);
          return false;
        }
      }
      return true;
    });

    return value;
  }
}
