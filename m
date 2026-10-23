Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.130.129.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763256;
	b=ArZEq3u3Xu+j4HfVirDVP7HwXXm9wNY5jZq8Ee4L9BDlf8/OzQx+AgHeOKbeQBZm3adU
	 Xo9EGGP95DB0EvgZSsRMhefvfZHunEuXSGTk20dp8Ogo5AYkkEScMCu1zK4xulYgYgK1y
	 dnlDuXcRC5GQiQ9iVPpHk26m9DXA7UYw9r1lo2osTmvblbnK5zGvvEcXEEN5GOaU+iEkB
	 ULFtY0o4TtoauRX16UUkbmC1/7X67sNIAoi9ksVtl++vky1i3J4MajpnrXo1AlIVkIJjr
	 WKi70j87j2tmypCjWVGo8+QSHEEAOAtv49bJUz2I1W4DMIqDj0rxyBar6wGk2cEyNog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763256;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OAxWznnfDGLMW7OldkZqUjP2oac3UG2TjUk3rieuc58=;
	b=NXKnuWh2H31fC/n6KexutUzylZly2QAqfTPqbTKoL6jJAYl3KBBhCDVs/9HzzAHH2Qk9
	 mJjGt7lR07jMWcSa8W3cdzml5S40Gd9mO8jkoYwudUEAwcGClrk4x4jqWwN17WuRjHYjq
	 uzSY/50bcXteNxdUeUxxeIN76yV8h4dUeLQDru0f1jQ/CxZ610AoFP2wJnlv9MQKihIoS
	 OomB4zPYZsuVRFMfB8ZrqJsunpzwkzOI7uMU8qJvYyEz8n5q3Yw69L1i5IhxiAaxxm4el
	 27YM0S5IZVRPMTUxhERoCf2kus+asQq9lii5NuMah/F+jMx/oruVy7Mm+gcyHaVX8uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=pond.sub.org;
	arc=none smtp.remote-ip=94.130.129.15
Received: from oxygen.pond.sub.org (oxygen.pond.sub.org [94.130.129.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7F606A31A;
	Fri, 23 Oct 2026 13:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AF7F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pond.sub.org
Received: from blackfin.pond.sub.org (p50902d79.dip0.t-ipconnect.de [80.144.45.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by oxygen.pond.sub.org (Postfix) with ESMTPSA id 5F19F1FFDF;
	Fri, 23 Oct 2026 15:47:24 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 2402C21E6A04; Fri, 23 Oct 2026 15:47:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  John Snow
 <jsnow@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
  Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kostiantyn
 Kostiuk
 <kkostiuk@redhat.com>,  Eric Blake <eblake@redhat.com>,  David Hildenbrand
 <david@kernel.org>,  Igor Mammedov <imammedo@redhat.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Jason Wang <jasowangio@gmail.com>,
  Marcelo Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org,  Alberto
 Garcia <berto@igalia.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
  Zhao Liu <zhao1.liu@intel.com>,  Jonathan Cameron <jic23@kernel.org>,
  Junjie Cao <junjie.cao@intel.com>,  Anisa Su <anisa.su@samsung.com>,
  Elena Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  John Levon <john.levon@nutanix.com>,  Thanos
 Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
  Cornelia Huck <cohuck@redhat.com>,  Eric Farman <farman@linux.ibm.com>,
  Matthew Rosato <mjrosato@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
  qemu-block@nongnu.org,  linux-cxl@vger.kernel.org,
  qemu-s390x@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Sergio
 Lopez <slp@redhat.com>,  qemu-arm@nongnu.org,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Alistair Francis <alistair.francis@wdc.com>,
  Weiwei Li <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
  qemu-riscv@nongnu.org,  Song Gao <17746591750@163.com>,  Bibo Mao
 <maobibo@loongson.cn>,  Xianglai Li <lixianglai@loongson.cn>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Pedro Barbuda <pbarbuda@microsoft.com>,
  Mohamed Mediouni <mohamed@unpredictable.fr>,  Nicholas Piggin
 <npiggin@gmail.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,  Amit
 Machhiwal <amachhiw@linux.ibm.com>,  qemu-ppc@nongnu.org,  Zhang Chen
 <zhangckid@gmail.com>,  Li Zhijian <lizhijian@fujitsu.com>,  Alistair
 Francis <alistair@alistair23.me>,  Alexander Graf <graf@amazon.com>,
  "Gonglei (Arei)" <arei.gonglei@huawei.com>,  zhenwei pi
 <zhenwei.pi@linux.dev>,  Ani Sinha <anisinha@redhat.com>,  Luc Michel
 <luc@lmichel.fr>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Jamin
 Lin
 <jamin_lin@aspeedtech.com>,  Kane Chen <kane_chen@aspeedtech.com>,  Samuel
 Tardieu <sam@rfc1149.net>,  "Denis V. Lunev" <den@openvz.org>,  FangSheng
 Huang <FangSheng.Huang@amd.com>,  Tyrone Ting <kfting@nuvoton.com>,  Hao
 Wu <wuhaotsh@google.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  Jesper Devantier <foss@defmacro.it>,  Aditya Gupta
 <adityag@linux.ibm.com>,  Glenn Miles <milesg@linux.ibm.com>,  Conor
 Dooley <conor@kernel.org>,  Sebastian Huber
 <sebastian.huber@embedded-brains.de>,  Halil Pasic <pasic@linux.ibm.com>,
  Christian Borntraeger <borntraeger@linux.ibm.com>,  Jason Herne
 <jjherne@linux.ibm.com>,  Titus Rwantare <titusr@google.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Anthony PERARD
 <anthony@xenproject.org>,  Peter Xu <peterx@redhat.com>,  Chinmay Rath
 <rathc@linux.ibm.com>,  Hendrik Brueckner <brueckner@linux.ibm.com>,
  xen-devel@lists.xenproject.org,  Roman Bolshakov <rbolshakov@ddn.com>,
  Phil Dennis-Jordan <phil@philjordan.eu>,  Fam Zheng <fam@euphon.net>,
  Farhan Ali <alifm@linux.ibm.com>,  Alex Williamson <alex@shazbot.org>,
  Tao Tang <tangtao1634@phytium.com.cn>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Artyom Tarasenko
 <atar4qemu@gmail.com>,  Yoshinori Sato <yoshinori.sato@nifty.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Eric Auger <eric.auger@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v7 09/65] qapi: add type-infos generator
In-Reply-To: <20261020-qom-qapi-v7-9-431a86b02b58@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 20 Oct 2026 14:45:26 +0400")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
	<20261020-qom-qapi-v7-9-431a86b02b58@redhat.com>
Date: Fri, 23 Oct 2026 15:47:21 +0200
Message-ID: <87mrs4a5qu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> New QAPISchemaGenTypeInfoVisitor produces per-module
> qapi-type-infos-*.h/c files. Each file declares QAPITypeInfo constants
> pairing the QAPI type name with its masked introspection name.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst |  92 ++++++++++++++++++++++++
>  meson.build                  |   1 +
>  scripts/qapi/backend.py      |   2 +
>  scripts/qapi/type_infos.py   | 163 +++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 258 insertions(+)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index 77f08bb68cac..1cc5338a210a 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -1250,6 +1250,9 @@ JSON array of strings.
>  To examine a type, start with a command or event using it, then follow
>  references by name.
>=20=20
> +.. TODO document QOM introspection (qom-list, qom-list-properties,
> +   qom-get) and how it relates to QAPI type information.
> +
>  The SchemaInfo for a command has meta-type "command", and variant
>  members "arg-type", "ret-type" and "allow-oob".  On the wire, the
>  "arguments" member of a client's "execute" command must conform to the
> @@ -2099,3 +2102,92 @@ Example::
>      }));
>=20=20
>      [Uninteresting stuff omitted...]
> +
> +
> +Code generated for type information
> +-----------------------------------
> +
> +Type information is generated for user-defined types and their array
> +types.  With option --builtins, it is also generated for the built-in
> +types.
> +
> +The following files are created:
> +
> + ``$(prefix)qapi-type-infos.c``
> +     A ``QAPITypeInfo`` instance for each type listed above, providing
> +     a mapping between the QAPI type name and the masked name used by
> +     introspection, along with optional enum lookup table and array
> +     type pointers.
> +
> + ``$(prefix)qapi-type-infos.h``
> +     Declarations for the above type info instances
> +
> +Each ``QAPITypeInfo`` struct has the following fields:
> +
> +``name``
> +    The QAPI type name (e.g. ``"UserDefOne"``).
> +
> +``masked_name``
> +    The masked name used in ``query-qmp-schema`` output.
> +
> +``lookup``
> +    For enum types, a pointer to the corresponding ``QEnumLookup``
> +    table.  ``NULL`` for non-enum types.
> +
> +``list``
> +    For types that have an array variant, a pointer to the array type's
> +    ``QAPITypeInfo``.  ``NULL`` when no array type exists.
> +
> +These type info instances are used by QOM property registration
> +functions (``object_property_add_qapi()``,
> +``object_class_property_add_qapi_enum()``, etc.) to associate each
> +property with its QAPI type.  The ``qom-list`` and
> +``device-list-properties`` QMP commands then expose the ``qapi-type``
> +field, giving management tools a formal type reference they can look
> +up in the introspection schema.
> +
> +Example::
> +
> +    $ cat qapi-generated/example-qapi-type-infos.h
> +    [Uninteresting stuff omitted...]
> +
> +    #ifndef EXAMPLE_QAPI_TYPE_INFOS_H
> +    #define EXAMPLE_QAPI_TYPE_INFOS_H
> +
> +    #include "qapi/qapi-builtin-type-infos.h"
> +
> +    extern const QAPITypeInfo UserDefOne_type_info;
> +
> +    extern const QAPITypeInfo UserDefOneList_type_info;
> +
> +    #endif /* EXAMPLE_QAPI_TYPE_INFOS_H */
> +    $ cat qapi-generated/example-qapi-type-infos.c
> +    [Uninteresting stuff omitted...]
> +
> +    const QAPITypeInfo UserDefOne_type_info =3D {
> +        .name =3D "UserDefOne",
> +        .masked_name =3D "1",

Code generated right now has "32".  Doesn't matter to readers, but using
generated code verbatim eases maintenance a bit.


> +        .list =3D &UserDefOneList_type_info,
> +    };
> +
> +    const QAPITypeInfo UserDefOneList_type_info =3D {
> +        .name =3D "UserDefOneList",
> +        .masked_name =3D "[1]",

Likewise.

> +    };
> +
> +    [Uninteresting stuff omitted...]
> +
> +For a modular QAPI schema (see section `Include directives`_), code for
> +each sub-module SUBDIR/SUBMODULE.json is actually generated into ::
> +
> + SUBDIR/$(prefix)qapi-type-infos-SUBMODULE.h
> + SUBDIR/$(prefix)qapi-type-infos-SUBMODULE.c
> +
> +If qapi-gen.py is run with option --builtins, additional files are
> +created:
> +
> + ``qapi-builtin-type-infos.h``
> +     Type info instances for built-in types
> +
> + ``qapi-builtin-type-infos.c``
> +     Definitions for the above type info instances
> diff --git a/meson.build b/meson.build
> index bbef9d9c2932..e51fb7a37740 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3510,6 +3510,7 @@ qapi_gen_depends =3D [ meson.current_source_dir() /=
 'scripts/qapi/__init__.py',
>                       meson.current_source_dir() / 'scripts/qapi/parser.p=
y',
>                       meson.current_source_dir() / 'scripts/qapi/schema.p=
y',
>                       meson.current_source_dir() / 'scripts/qapi/source.p=
y',
> +                     meson.current_source_dir() / 'scripts/qapi/type_inf=
os.py',
>                       meson.current_source_dir() / 'scripts/qapi/types.py=
',
>                       meson.current_source_dir() / 'scripts/qapi/visit.py=
',
>                       meson.current_source_dir() / 'scripts/qapi-gen.py'
> diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
> index 49ae6ecdd33e..508ab2173539 100644
> --- a/scripts/qapi/backend.py
> +++ b/scripts/qapi/backend.py
> @@ -8,6 +8,7 @@
>  from .features import gen_features
>  from .introspect import gen_introspect
>  from .schema import QAPISchema
> +from .type_infos import gen_type_infos
>  from .types import gen_types
>  from .visit import gen_visit
>=20=20
> @@ -63,3 +64,4 @@ def generate(self,
>          gen_commands(schema, output_dir, prefix, gen_tracing)
>          gen_events(schema, output_dir, prefix)
>          gen_introspect(schema, output_dir, prefix, unmask)
> +        gen_type_infos(schema, output_dir, prefix, builtins, unmask)
> diff --git a/scripts/qapi/type_infos.py b/scripts/qapi/type_infos.py
> new file mode 100644
> index 000000000000..b29e31d92640
> --- /dev/null
> +++ b/scripts/qapi/type_infos.py
> @@ -0,0 +1,163 @@
> +"""
> +QAPI type info generator
> +
> +SPDX-License-Identifier: GPL-2.0-or-later
> +"""
> +
> +from typing import List, Optional
> +
> +from .common import c_name, mcgen
> +from .gen import QAPISchemaModularCVisitor, ifcontext
> +from .schema import (
> +    QAPISchema,
> +    QAPISchemaAlternatives,
> +    QAPISchemaBranches,
> +    QAPISchemaEnumMember,
> +    QAPISchemaFeature,
> +    QAPISchemaIfCond,
> +    QAPISchemaObjectType,
> +    QAPISchemaObjectTypeMember,
> +    QAPISchemaType,
> +)
> +from .source import QAPISourceInfo
> +
> +
> +class QAPISchemaGenTypeInfoVisitor(QAPISchemaModularCVisitor):
> +
> +    def __init__(self, prefix: str, unmask: bool):
> +        super().__init__(
> +            prefix, 'qapi-type-infos',
> +            ' * Schema-defined QAPI type info',
> +            ' * Built-in QAPI type info', __doc__)
> +        self._unmask =3D unmask
> +        self._schema: Optional[QAPISchema] =3D None
> +
> +    def visit_begin(self, schema: QAPISchema) -> None:
> +        super().visit_begin(schema)
> +        self._schema =3D schema
> +
> +    def _begin_builtin_module(self) -> None:
> +        self._genc.preamble_add(mcgen('''
> +#include "qemu/osdep.h"
> +#include "qapi/qapi-builtin-types.h"
> +#include "qapi/qapi-builtin-type-infos.h"
> +'''))
> +        self._genh.preamble_add(mcgen('''
> +#include "qapi/qapi-type-info.h"
> +'''))
> +
> +    def _begin_user_module(self, name: str) -> None:
> +        type_infos =3D self._module_basename('qapi-type-infos', name)
> +        types =3D self._module_basename('qapi-types', name)
> +        self._genc.preamble_add(mcgen('''
> +#include "qemu/osdep.h"
> +#include "%(types)s.h"
> +#include "%(type_infos)s.h"
> +''',
> +                                      types=3Dtypes,
> +                                      type_infos=3Dtype_infos))
> +        self._genh.preamble_add(mcgen('''
> +#include "qapi/qapi-builtin-type-infos.h"
> +'''))
> +
> +    def _has_list(self, name: str) -> bool:
> +        assert self._schema is not None
> +        return self._schema.lookup_type(name + 'List') is not None

Relies on QAPISchema._make_array_type()'s

           name =3D element_type + 'List'    # reserved by check_defn_name_=
str()

Suggest to point to ._make_array_type() with a comment.

There's another name + 'List' below, at [*].  One comment here could do,
though.

> +
> +    def _masked_name(self, name: str) -> str:
> +        assert self._schema is not None
> +        return self._schema.definition_introspection_name(name, self._un=
mask)
> +
> +    def _gen_type_info(self, name: str,
> +                       ifcond: Optional[QAPISchemaIfCond] =3D None,
> +                       with_lookup: bool =3D False,
> +                       with_list: bool =3D False) -> None:
> +        c_id =3D c_name(name + '_type_info')
> +        masked_name_str =3D '"%s"' % self._masked_name(name)
> +        with ifcontext(ifcond or QAPISchemaIfCond(),
> +                       self._genh, self._genc):
> +            self._genh.add(mcgen('''
> +
> +extern const QAPITypeInfo %(c_id)s;
> +''',
> +                                 c_id=3Dc_id))
> +            self._genc.add(mcgen('''
> +
> +const QAPITypeInfo %(c_id)s =3D {
> +    .name =3D "%(name)s",
> +    .masked_name =3D %(masked_name)s,
> +''',
> +                                 c_id=3Dc_id, name=3Dname,
> +                                 masked_name=3Dmasked_name_str))

Simpler and clearer, I think:

       .masked_name =3D "%(masked_name)s",
                                    ...
                                    masked_name=3D self._masked_name(name))

> +            if with_lookup:
> +                self._genc.add(mcgen('''
> +    .lookup =3D &%(c_name)s_lookup,
> +''',
> +                                     c_name=3Dc_name(name)))
> +            if with_list:
> +                self._genc.add(mcgen('''
> +    .list =3D &%(list_id)s,
> +''',
> +                                     list_id=3Dc_name(name + 'List_type_=
info')))

[*]

> +            self._genc.add(mcgen('''
> +};
> +'''))

Three variations of c_name(name maybe with suffix) in this function:

    c_name(name + '_type_info')
    c_name(name)
    c_name(name + 'List_type_info')

Let's put just

    cname =3D c_name(name)

at the beginning, and add the suffix within the template like we do in
events.py, types.py, and visit.py, i.e. like this:

               self._genh.add(mcgen('''

   extern const QAPITypeInfo %(cname)s_type_info;
   ''',
                                    cname=3Dcname))

> +
> +    def visit_builtin_type(self,
> +                           name: str,
> +                           info: Optional[QAPISourceInfo],
> +                           json_type: str) -> None:
> +        self._gen_type_info(name, with_list=3Dself._has_list(name))
> +
> +    def visit_enum_type(self,
> +                        name: str,
> +                        info: Optional[QAPISourceInfo],
> +                        ifcond: QAPISchemaIfCond,
> +                        features: List[QAPISchemaFeature],
> +                        members: List[QAPISchemaEnumMember],
> +                        prefix: Optional[str]) -> None:
> +        self._gen_type_info(name, ifcond,
> +                            with_lookup=3DTrue,
> +                            with_list=3Dself._has_list(name))
> +
> +    def visit_array_type(self,
> +                         name: str,
> +                         info: Optional[QAPISourceInfo],
> +                         ifcond: QAPISchemaIfCond,
> +                         element_type: QAPISchemaType) -> None:
> +        self._gen_type_info(name, ifcond)
> +
> +    def visit_object_type(self,
> +                          name: str,
> +                          info: Optional[QAPISourceInfo],
> +                          ifcond: QAPISchemaIfCond,
> +                          features: List[QAPISchemaFeature],
> +                          base: Optional[QAPISchemaObjectType],
> +                          members: List[QAPISchemaObjectTypeMember],
> +                          branches: Optional[QAPISchemaBranches]) -> Non=
e:
> +        assert self._schema is not None
> +        typ =3D self._schema.lookup_type(name)
> +        assert typ
> +        if typ.is_implicit():
> +            return
> +        self._gen_type_info(name, ifcond,
> +                            with_list=3Dself._has_list(name))
> +
> +    def visit_alternate_type(self,
> +                             name: str,
> +                             info: Optional[QAPISourceInfo],
> +                             ifcond: QAPISchemaIfCond,
> +                             features: List[QAPISchemaFeature],
> +                             alternatives: QAPISchemaAlternatives) -> No=
ne:
> +        self._gen_type_info(name, ifcond,
> +                            with_list=3Dself._has_list(name))

All but one caller of ._gen_type_info() pass
with_list=3Dself._has_list(name).  The exception is visit_array_type(),
where we let with_list default to False.  Since .has_list(name) would
surely be False there, we could do away with with_list and check
._has_list() in ._gen_type_info().

The array business complicates review of this patch and PATCH 07 a bit.
It isn't actually needed until PATCH 59.  I'd like you to delay it until
then to get it out of the way here:

* Create QAPITypeInfo without member @list in PATCH 07.

* Don't generate member @list in PATCH 09.

* Do both right before PATCH 59.

Might also enable quicker merging of the bulk of this series.

> +
> +
> +def gen_type_infos(schema: QAPISchema,
> +                   output_dir: str,
> +                   prefix: str,
> +                   opt_builtins: bool,
> +                   opt_unmask: bool) -> None:
> +    vis =3D QAPISchemaGenTypeInfoVisitor(prefix, opt_unmask)
> +    schema.visit(vis)
> +    vis.write(output_dir, opt_builtins)
