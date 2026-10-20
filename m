Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493203;
	b=WXDQGbg2g9cF519kLJJ59/kyeFxT2avcTLh5TgfNger5CZLSR1MPLqlgkY9eqAzTDMo3
	 3tdxiT+MdeWHOV+AldmBn83mw5mI3LpF468MTPqtzpHSAq8vHJTNDDxZjCW7jUqtE1BW/
	 PDD4dXHEi4FsUun5ay0bmfAKOxJA0tjpi4TaYHP8a/WgGM2eTNden2+hntT47K+dOFhxn
	 I2Yih/n3ztU8z0MumWyYI1bByeRWjN8/l/NOfnj56iDQiREs78Y1nZJfWWjsDS4xQCaSI
	 W/AR02tfITZBVaHdSfm5xHExkVGmyij3TngsrCbM3RGLJd6ew/y6IR1mUbIJqCjziyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493203;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=W4iwz5jM7eZNLXaBc15ajfHMaIvbcteyV5+hzYG/iP8=;
	b=Ig+8WbNrUW0NW7hbCcvW8XJ2UnOBiR4O2/Cd5HIvSqYEtZ8+hOzTsvZ4l7buP/xkUb3m
	 zieQ5KSFqYdKymioGXhVv7bBf0JIyZXNpwsyZIAbWjOKmOkMJd/Hys1EvtjlsgP8YxfAt
	 SwPdwntGgVWEWgN5aidJQSsX2SE8Cv4j2Ea0mSYAr/yBWzk4l4Zf26XJemqgBvIKQyncr
	 zA5z+xGJQsD85cw6BvuuOj5lbS8KPV6UZkYahOU+tBQ+6R4kwD1MOcWgbxKXX1w57Wtxp
	 K2hP+wNk7JYE8cAydbymjJAYrAPjtk7EKZp3KGtdlQ/nD8dV3MKSEvQJCjBFdYo9riA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RYpTwtrg;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2D606A323
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14E2D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RYpTwtrg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4iwz5jM7eZNLXaBc15ajfHMaIvbcteyV5+hzYG/iP8=;
	b=RYpTwtrgQV9LDr6PPPWCGIvUefmfFMfa4QnuHfFNKR6T1J7fKes+R3z0I8KtXFn2z8ykPI
	TZ7/jE9z0T4CMAosoU0dpsH8Uv9STFnF7A4I68YlGjP78SI/xiEZaifjpFv1LL4NUWuaQ4
	F93txUTVYjzk5Hi8WiKhD6jhIZqNuKo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-zY61osTGPTaA1pnSKnNHFQ-1; Tue,
 20 Oct 2026 10:46:38 +0000
X-MC-Unique: zY61osTGPTaA1pnSKnNHFQ-1
X-Mimecast-MFC-AGG-ID: zY61osTGPTaA1pnSKnNHFQ_1792493194
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CC261955D69;
	Tue, 20 Oct 2026 10:46:33 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14CBF30000E7;
	Tue, 20 Oct 2026 10:46:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
Date: Tue, 20 Oct 2026 14:45:21 +0400
Subject: [PATCH v7 04/65] qapi/introspect: Don't elide types
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-4-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5331;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mh48JZUSGfIpAp1DsQ/GZxfBrxYDTkjYALDPFWkE2w0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZXTj6BLvZgq0XBaDnDR415+cGHcMUxi/2dk
 ZicZ3/0CO+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGVwAKCRDa6OEJdZac
 5cNFEACs0g3nYzOw9mcOrDPnlJXKJuNeci0n6VbAEXZsFCZ1u4JNtS1ifs+0pHvISJaoZta0my6
 lvkGupWdwq079dv7nvmOoT5lGQxsx41FDbzeMAh2AqGRiaoTGIR34hQFf3sOLgmZraxp30Lt33v
 I9FftBFuBgNH1cHh44kywesPPVrmlfX1fGV1hURBsBolTEkpUT+VNW3Si1XrztZk2PXf1zupIB1
 6v4kYskKQkdj6v95qbfwBDHaMsgyUWRuc4dE9BsDkCCULJcdcOw0jQy+xkShVjgbTzRG/spQtdm
 OJgHTTwkqlLpLSzKkiZiWk130rNvNbU9ZPZZ7pWrSjD87w4sUoVTVlLNx7btfbj6VpkVI/lsNHX
 eXEv52qGqAcZCZptkK8oP/CIE6nCQvMdxcZ31fqe3HxosbVA5tVjhnoeC/tQyiJZuiyExxkFiJ7
 0ZbpjT/AIjGFffTJ3IYXzUgPfgdB1arCF3YD86a2cQEZgHpGQtJ675JNQAPfC7Gbgpu/znK2Txl
 QskafbOYE8+L5oukgyV+eYRWnqzZsRIXJeUrRhCXcOW2+NOIDZyh5yfQvEaIefITC4ILWuwtEEF
 F1kFYI7xr5ozlv5mmkOq6tEUPt+N9cLcy/vZVW0O4PEQCCt0FJuN5TvgfUPN9YjLObVm6vjQw9L
 JjRCn7EZx7/9Trw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 7DHdlt2W7caeguyjrZsjwZ5Ue41Adt9FdELNZhldpIs_1792493194
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Markus Armbruster <armbru@redhat.com>

query-qmp-schema elides types not reachable from commands and events.
It currently emits 1251 out of 1385 definitions, and elides 134 types.
Whether that's worthwhile is debatable.

Marc-André Lureau would like to make QOM introspection (qom-list &
friends) refer to QAPI types.  We additionally need types reachable
from QOM properties.

Unfortunately, the QAPI generator knows nothing about QOM properties.

We could manually mark the QAPI types to elide, or the QAPI types not
to elide even though they are not reachable from commands and events.
Feels very much not worthwhile to me.

We could conservatively approximate "reachable from QOM properties" by
"available for use with QOM properties".  These are the built-in and
user-defined types, and their arrays.  With that, we'd elide just 38
out of 1385 definitions.  Too few to be worthwhile.

Simply emit everything.

Output of query-qmp-schema grows from 247KiB to 274KiB for me.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.rst |  2 --
 scripts/qapi/introspect.py   | 31 ++++---------------------------
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index b1cc5b5f0db1..77f08bb68cac 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1250,8 +1250,6 @@ JSON array of strings.
 To examine a type, start with a command or event using it, then follow
 references by name.
 
-QAPI schema definitions not reachable that way are omitted.
-
 The SchemaInfo for a command has meta-type "command", and variant
 members "arg-type", "ret-type" and "allow-oob".  On the wire, the
 "arguments" member of a client's "execute" command must conform to the
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 49d1ed2897e8..15302ecf155a 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -28,9 +28,7 @@
 from .schema import (
     QAPISchema,
     QAPISchemaAlternatives,
-    QAPISchemaArrayType,
     QAPISchemaBranches,
-    QAPISchemaEntity,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
     QAPISchemaIfCond,
@@ -175,7 +173,6 @@ def __init__(self, prefix: str, unmask: bool):
         self._unmask = unmask
         self._schema: Optional[QAPISchema] = None
         self._trees: List[Annotated[SchemaInfo]] = []
-        self._used_types: List[QAPISchemaType] = []
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-introspect.h"
@@ -187,10 +184,6 @@ def visit_begin(self, schema: QAPISchema) -> None:
         self._schema = schema
 
     def visit_end(self) -> None:
-        # visit the types that are actually used
-        for typ in self._used_types:
-            typ.visit(self)
-        # generate C
         name = c_name(self._prefix, protect=False) + 'qmp_schema_qlit'
         self._genh.add(mcgen('''
 #include "qobject/qlit.h"
@@ -205,32 +198,12 @@ def visit_end(self) -> None:
                              c_string=_tree_to_qlit(self._trees)))
         self._schema = None
         self._trees = []
-        self._used_types = []
-
-    def visit_needed(self, entity: QAPISchemaEntity) -> bool:
-        # Ignore types on first pass; visit_end() will pick up used types
-        return not isinstance(entity, QAPISchemaType)
 
     def _name(self, name: str) -> str:
         assert self._schema
         return self._schema.definition_introspection_name(name, self._unmask)
 
     def _use_type(self, typ: QAPISchemaType) -> str:
-        assert self._schema is not None
-
-        # Map the various integer types to plain int
-        if typ.json_type() == 'int':
-            type_int = self._schema.lookup_type('int')
-            assert type_int
-            typ = type_int
-        elif (isinstance(typ, QAPISchemaArrayType) and
-              typ.element_type.json_type() == 'int'):
-            type_intlist = self._schema.lookup_type('intList')
-            assert type_intlist
-            typ = type_intlist
-        # Add type to work queue if new
-        if typ not in self._used_types:
-            self._used_types.append(typ)
         return self._name(typ.name)
 
     @staticmethod
@@ -295,6 +268,8 @@ def _gen_variant(self, variant: QAPISchemaVariant
 
     def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
                            json_type: str) -> None:
+        if json_type == 'int' and name != 'int':
+            return
         self._gen_tree(name, 'builtin', {'json-type': json_type})
 
     def visit_enum_type(self, name: str, info: Optional[QAPISourceInfo],
@@ -312,6 +287,8 @@ def visit_enum_type(self, name: str, info: Optional[QAPISourceInfo],
     def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
                          ifcond: QAPISchemaIfCond,
                          element_type: QAPISchemaType) -> None:
+        if element_type.json_type() == 'int' and name != 'intList':
+            return
         element = self._use_type(element_type)
         self._gen_tree(name, 'array', {'element-type': element}, ifcond)
 

-- 
2.56.0.116.g6de20f6092dc

