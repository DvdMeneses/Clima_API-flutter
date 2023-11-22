import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconeCondicao extends StatelessWidget {
  final String condicao;

  String getCodicaoIconUrl(String condicao) {
    return 'https://assets.hgbrasil.com/weather/icons/conditions/${condicao}.svg';
  }

  const IconeCondicao({
    super.key,
    required this.condicao,
  });

  @override
  Widget build(BuildContext context) {
    String condicaoIconUrl = getCodicaoIconUrl(condicao);

    return Row(
      children: [
        SizedBox(
          child: condicaoIconUrl.isNotEmpty
              ? SvgPicture.network(
                  condicaoIconUrl,
                ) // Carregar a imagem do URL
              : Text('URL da imagem está vazio'),
        ),
      ],
    );
  }
}

class IconeLua extends StatelessWidget {
  final String faseDaLua;

  String getLuaIconUrl(String faseDaLua) {
    return 'https://assets.hgbrasil.com/weather/icons/moon/${faseDaLua}.png';
  }

  const IconeLua({
    super.key,
    required this.faseDaLua,
  });

  @override
  Widget build(BuildContext context) {
    String LuaIconUrl = getLuaIconUrl(faseDaLua);

    return Row(
      children: [
        SizedBox(
          child: LuaIconUrl.isNotEmpty
              ? Image.network(LuaIconUrl) // Carregar a imagem do URL
              : Text('URL da imagem está vazio'),
        )
      ],
    );
  }
}
