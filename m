Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493234;
	b=vqNFu9dgYGjgA6YR3gU0/F8XaV8eZ06CfSFZjRwVEl5CdCZsyD+3X3yrOWrfq2JUSvqY
	 RiL1nJMvjQkWaftvVpZQyIvskKU5Cl3bWPMgzuV68TJ4+WxsB3JLabtDh+2OYgUx5KFrw
	 oCVuSwiL5EEzN1TE4NvIBkQTSgHarsw83+wRYAvfMdpMd3LrAxg02JXi3Uf8pPTjfN2bB
	 0jgP+D08DqI+md2eorGMUpSDYtPrvmE1EiO0NjBnLBj4dxNJDECi3H9LgesXWd19uG25e
	 i/UdYhyTHszRO+2/KYz2+748McUbqOkx4SdYnA6GtwsYMbTLyELtm9qEJuOnz7NHGGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493234;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=9fsJslKCeoRdmSlurWERnpkKgveOnsXmWR9P5zsycws=;
	b=O6HuDMsbMykAgJmgEYxKUQv3A1OHleoPSzkB6es2HezUF221ldjzIgEtV+OxhxxseFQL
	 /DpMgacuKUwu4mUGZqi+lJai1o1ZYawE8oylV/gWcwpbcwtKV2dYeC7Kp+b56K4KXl84F
	 xuqKzOtB/r9i4wmDzkBW4EE223w28lKuqI5kQcPIC1zQZhmtKN8fk4S5tRYM75DoRwa53
	 uS40dq6iKzi0iTeSAK4wibTxDH7wEo0oLE2jv/rOJTEhasbxGC0uR0vytg/NSeLu1p1bB
	 tca/go+0axLqAtABKU/bfLNEId0IBypLb4/Qu8nKPl0OvMGj84wj/wzEzTXUlQBLXdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H69cYq6F;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33563606A320
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33563606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H69cYq6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fsJslKCeoRdmSlurWERnpkKgveOnsXmWR9P5zsycws=;
	b=H69cYq6FuKpeO2ENt7EWyJq4cJDN4BNwP+POU9R4QeAhtq1+yBPt24jsOAydLC1+VujDQH
	MnPZlItPWrzoGxlDFNCN0OCcmhez9a9mKrcfgXO0wOvnaX18Gt5aCXA1kkiN4WqNtYe4ip
	8TqXKEL0rgT+A92PqOcl8cIsYakVQNA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-CaChFFwCP4K-8MY9RuA87Q-1; Tue,
 20 Oct 2026 10:47:08 +0000
X-MC-Unique: CaChFFwCP4K-8MY9RuA87Q-1
X-Mimecast-MFC-AGG-ID: CaChFFwCP4K-8MY9RuA87Q_1792493224
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ECE719560BA;
	Tue, 20 Oct 2026 10:47:04 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6FCFD1800643;
	Tue, 20 Oct 2026 10:47:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:26 +0400
Subject: [PATCH v7 09/65] qapi: add type-infos generator
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-9-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, 
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>, 
 Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Eric Auger <eric.auger@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=11937;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=g11BDsqjD7nTY1JkXgXYml3RSI9xXvonR2GIve0ncmU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZYJJsN/o3bE8+2FCYnBUPV5NJQM5Nv0DZ+W
 cs66TGPSluJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWAAKCRDa6OEJdZac
 5X89D/9JRzqpQfKNC9gbQGRY59/nwxgGa32YPoyHyyoM0h2BvDmF7ZbinfNq2T9MVqshAYEoiFR
 xc7ljZ9NoGxlTuLVwS1aNl6HHnsmDhKb5jVgr5AoMWWz4rVqi+xj63l45jNUSseCUXeuy0bCkEg
 yZQBQUFEMFUZf304KtU3Njd18Egs4T0KuLqkFEEw5dkzWV3eZ/b5OhaCAKqoZedcvkQsZW7uvwI
 6Ae0AjBOYIfxG3WN9Ij9DoZ8/I8X4ziwRqXr89st8Dtr0I2t6e9J2cXetf9OWT4OGfPwxsEliyT
 icKaxTcbiSyEP+QhBnS7Vz3hB/KApZDT+czUQX6T29+2H8KRyPs41CClGk1MQ4rUIz5QDTn98sZ
 SSY/ZdRafGBX/r+hQ8bLdy5WzBHNtnn5vjrxoOalrZQ3lkgmFSB+R3UMIxHTPRzij+vsVtmiGxw
 U5gv0Srb6iZ8qjMjcqiupzChnZtsLekIggh80TZwGRjdhyZdXY7Xn2FoW/Hn7QVfxpGn+9wEUQ3
 bpdpQSG0xXFH+C38NmXfJ72C/QyZIu9PqL8R5H/iyqxdRJd92ojKG3qoIStS+8l19dNilIxa2YR
 eL1VActz/GY+9zR11F3R3dnsROQAhx1070vOdfVrv0WbKEHtXIw+k49jML+OTKNlgawyHNIFBDf
 bKqUQ5KwfG4PxOA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: fDDaUGFdFYBgDJR7bqCqkRA-6aM7GimSjOZE_6GnDo4_1792493224
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

New QAPISchemaGenTypeInfoVisitor produces per-module
qapi-type-infos-*.h/c files. Each file declares QAPITypeInfo constants
pairing the QAPI type name with its masked introspection name.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.rst |  92 ++++++++++++++++++++++++
 meson.build                  |   1 +
 scripts/qapi/backend.py      |   2 +
 scripts/qapi/type_infos.py   | 163 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 258 insertions(+)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 77f08bb68cac..1cc5338a210a 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1250,6 +1250,9 @@ JSON array of strings.
 To examine a type, start with a command or event using it, then follow
 references by name.
 
+.. TODO document QOM introspection (qom-list, qom-list-properties,
+   qom-get) and how it relates to QAPI type information.
+
 The SchemaInfo for a command has meta-type "command", and variant
 members "arg-type", "ret-type" and "allow-oob".  On the wire, the
 "arguments" member of a client's "execute" command must conform to the
@@ -2099,3 +2102,92 @@ Example::
     }));
 
     [Uninteresting stuff omitted...]
+
+
+Code generated for type information
+-----------------------------------
+
+Type information is generated for user-defined types and their array
+types.  With option --builtins, it is also generated for the built-in
+types.
+
+The following files are created:
+
+ ``$(prefix)qapi-type-infos.c``
+     A ``QAPITypeInfo`` instance for each type listed above, providing
+     a mapping between the QAPI type name and the masked name used by
+     introspection, along with optional enum lookup table and array
+     type pointers.
+
+ ``$(prefix)qapi-type-infos.h``
+     Declarations for the above type info instances
+
+Each ``QAPITypeInfo`` struct has the following fields:
+
+``name``
+    The QAPI type name (e.g. ``"UserDefOne"``).
+
+``masked_name``
+    The masked name used in ``query-qmp-schema`` output.
+
+``lookup``
+    For enum types, a pointer to the corresponding ``QEnumLookup``
+    table.  ``NULL`` for non-enum types.
+
+``list``
+    For types that have an array variant, a pointer to the array type's
+    ``QAPITypeInfo``.  ``NULL`` when no array type exists.
+
+These type info instances are used by QOM property registration
+functions (``object_property_add_qapi()``,
+``object_class_property_add_qapi_enum()``, etc.) to associate each
+property with its QAPI type.  The ``qom-list`` and
+``device-list-properties`` QMP commands then expose the ``qapi-type``
+field, giving management tools a formal type reference they can look
+up in the introspection schema.
+
+Example::
+
+    $ cat qapi-generated/example-qapi-type-infos.h
+    [Uninteresting stuff omitted...]
+
+    #ifndef EXAMPLE_QAPI_TYPE_INFOS_H
+    #define EXAMPLE_QAPI_TYPE_INFOS_H
+
+    #include "qapi/qapi-builtin-type-infos.h"
+
+    extern const QAPITypeInfo UserDefOne_type_info;
+
+    extern const QAPITypeInfo UserDefOneList_type_info;
+
+    #endif /* EXAMPLE_QAPI_TYPE_INFOS_H */
+    $ cat qapi-generated/example-qapi-type-infos.c
+    [Uninteresting stuff omitted...]
+
+    const QAPITypeInfo UserDefOne_type_info = {
+        .name = "UserDefOne",
+        .masked_name = "1",
+        .list = &UserDefOneList_type_info,
+    };
+
+    const QAPITypeInfo UserDefOneList_type_info = {
+        .name = "UserDefOneList",
+        .masked_name = "[1]",
+    };
+
+    [Uninteresting stuff omitted...]
+
+For a modular QAPI schema (see section `Include directives`_), code for
+each sub-module SUBDIR/SUBMODULE.json is actually generated into ::
+
+ SUBDIR/$(prefix)qapi-type-infos-SUBMODULE.h
+ SUBDIR/$(prefix)qapi-type-infos-SUBMODULE.c
+
+If qapi-gen.py is run with option --builtins, additional files are
+created:
+
+ ``qapi-builtin-type-infos.h``
+     Type info instances for built-in types
+
+ ``qapi-builtin-type-infos.c``
+     Definitions for the above type info instances
diff --git a/meson.build b/meson.build
index bbef9d9c2932..e51fb7a37740 100644
--- a/meson.build
+++ b/meson.build
@@ -3510,6 +3510,7 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
                      meson.current_source_dir() / 'scripts/qapi/parser.py',
                      meson.current_source_dir() / 'scripts/qapi/schema.py',
                      meson.current_source_dir() / 'scripts/qapi/source.py',
+                     meson.current_source_dir() / 'scripts/qapi/type_infos.py',
                      meson.current_source_dir() / 'scripts/qapi/types.py',
                      meson.current_source_dir() / 'scripts/qapi/visit.py',
                      meson.current_source_dir() / 'scripts/qapi-gen.py'
diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 49ae6ecdd33e..508ab2173539 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -8,6 +8,7 @@
 from .features import gen_features
 from .introspect import gen_introspect
 from .schema import QAPISchema
+from .type_infos import gen_type_infos
 from .types import gen_types
 from .visit import gen_visit
 
@@ -63,3 +64,4 @@ def generate(self,
         gen_commands(schema, output_dir, prefix, gen_tracing)
         gen_events(schema, output_dir, prefix)
         gen_introspect(schema, output_dir, prefix, unmask)
+        gen_type_infos(schema, output_dir, prefix, builtins, unmask)
diff --git a/scripts/qapi/type_infos.py b/scripts/qapi/type_infos.py
new file mode 100644
index 000000000000..b29e31d92640
--- /dev/null
+++ b/scripts/qapi/type_infos.py
@@ -0,0 +1,163 @@
+"""
+QAPI type info generator
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+
+from typing import List, Optional
+
+from .common import c_name, mcgen
+from .gen import QAPISchemaModularCVisitor, ifcontext
+from .schema import (
+    QAPISchema,
+    QAPISchemaAlternatives,
+    QAPISchemaBranches,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaIfCond,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+)
+from .source import QAPISourceInfo
+
+
+class QAPISchemaGenTypeInfoVisitor(QAPISchemaModularCVisitor):
+
+    def __init__(self, prefix: str, unmask: bool):
+        super().__init__(
+            prefix, 'qapi-type-infos',
+            ' * Schema-defined QAPI type info',
+            ' * Built-in QAPI type info', __doc__)
+        self._unmask = unmask
+        self._schema: Optional[QAPISchema] = None
+
+    def visit_begin(self, schema: QAPISchema) -> None:
+        super().visit_begin(schema)
+        self._schema = schema
+
+    def _begin_builtin_module(self) -> None:
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "qapi/qapi-builtin-types.h"
+#include "qapi/qapi-builtin-type-infos.h"
+'''))
+        self._genh.preamble_add(mcgen('''
+#include "qapi/qapi-type-info.h"
+'''))
+
+    def _begin_user_module(self, name: str) -> None:
+        type_infos = self._module_basename('qapi-type-infos', name)
+        types = self._module_basename('qapi-types', name)
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "%(types)s.h"
+#include "%(type_infos)s.h"
+''',
+                                      types=types,
+                                      type_infos=type_infos))
+        self._genh.preamble_add(mcgen('''
+#include "qapi/qapi-builtin-type-infos.h"
+'''))
+
+    def _has_list(self, name: str) -> bool:
+        assert self._schema is not None
+        return self._schema.lookup_type(name + 'List') is not None
+
+    def _masked_name(self, name: str) -> str:
+        assert self._schema is not None
+        return self._schema.definition_introspection_name(name, self._unmask)
+
+    def _gen_type_info(self, name: str,
+                       ifcond: Optional[QAPISchemaIfCond] = None,
+                       with_lookup: bool = False,
+                       with_list: bool = False) -> None:
+        c_id = c_name(name + '_type_info')
+        masked_name_str = '"%s"' % self._masked_name(name)
+        with ifcontext(ifcond or QAPISchemaIfCond(),
+                       self._genh, self._genc):
+            self._genh.add(mcgen('''
+
+extern const QAPITypeInfo %(c_id)s;
+''',
+                                 c_id=c_id))
+            self._genc.add(mcgen('''
+
+const QAPITypeInfo %(c_id)s = {
+    .name = "%(name)s",
+    .masked_name = %(masked_name)s,
+''',
+                                 c_id=c_id, name=name,
+                                 masked_name=masked_name_str))
+            if with_lookup:
+                self._genc.add(mcgen('''
+    .lookup = &%(c_name)s_lookup,
+''',
+                                     c_name=c_name(name)))
+            if with_list:
+                self._genc.add(mcgen('''
+    .list = &%(list_id)s,
+''',
+                                     list_id=c_name(name + 'List_type_info')))
+            self._genc.add(mcgen('''
+};
+'''))
+
+    def visit_builtin_type(self,
+                           name: str,
+                           info: Optional[QAPISourceInfo],
+                           json_type: str) -> None:
+        self._gen_type_info(name, with_list=self._has_list(name))
+
+    def visit_enum_type(self,
+                        name: str,
+                        info: Optional[QAPISourceInfo],
+                        ifcond: QAPISchemaIfCond,
+                        features: List[QAPISchemaFeature],
+                        members: List[QAPISchemaEnumMember],
+                        prefix: Optional[str]) -> None:
+        self._gen_type_info(name, ifcond,
+                            with_lookup=True,
+                            with_list=self._has_list(name))
+
+    def visit_array_type(self,
+                         name: str,
+                         info: Optional[QAPISourceInfo],
+                         ifcond: QAPISchemaIfCond,
+                         element_type: QAPISchemaType) -> None:
+        self._gen_type_info(name, ifcond)
+
+    def visit_object_type(self,
+                          name: str,
+                          info: Optional[QAPISourceInfo],
+                          ifcond: QAPISchemaIfCond,
+                          features: List[QAPISchemaFeature],
+                          base: Optional[QAPISchemaObjectType],
+                          members: List[QAPISchemaObjectTypeMember],
+                          branches: Optional[QAPISchemaBranches]) -> None:
+        assert self._schema is not None
+        typ = self._schema.lookup_type(name)
+        assert typ
+        if typ.is_implicit():
+            return
+        self._gen_type_info(name, ifcond,
+                            with_list=self._has_list(name))
+
+    def visit_alternate_type(self,
+                             name: str,
+                             info: Optional[QAPISourceInfo],
+                             ifcond: QAPISchemaIfCond,
+                             features: List[QAPISchemaFeature],
+                             alternatives: QAPISchemaAlternatives) -> None:
+        self._gen_type_info(name, ifcond,
+                            with_list=self._has_list(name))
+
+
+def gen_type_infos(schema: QAPISchema,
+                   output_dir: str,
+                   prefix: str,
+                   opt_builtins: bool,
+                   opt_unmask: bool) -> None:
+    vis = QAPISchemaGenTypeInfoVisitor(prefix, opt_unmask)
+    schema.visit(vis)
+    vis.write(output_dir, opt_builtins)

-- 
2.56.0.116.g6de20f6092dc

