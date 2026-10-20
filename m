Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493188;
	b=giNqIMUGfULbfCsdUE4sV0sBFvqFWXoq7oyUib/5SMLrG5sp3+rYJm2A4hmKcKyGnBnP
	 0GxUify+SUick8QOkJmQHq1jr4MQRh5/5zZN/Gu+zf4jMfm9np2dYbdcl4x3DjkTK6mIq
	 BHTd2HsAmgUJ+AW7UypLciqNGGXqnbBDJHmgXwJ3j4YRufObTAZRD2lHr+YYTdJ4Kd4h6
	 2j1y5kyn5/ZukDKgY1de5VrFOBkQlSqg7qwS5Y4MvLfuvuFJs2xUVxqyce2yeG/oRUBB0
	 L05AmlmN2fIz3p7jQPsxlzdKhYr4HvGDZey9JAnjEgsaEhdXxOGynp2dCorTECDH+8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493188;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=Wrkputc8/RPpD4nnWHNw9T7RRAU4Kg2aM4nuyIGGs8E=;
	b=IQ57OupLFrD/Lh7BTGI66/VrFLTM9RaW6/1uEecBlMno4K0Xa+iWTjt8tTBVLxEhDh0x
	 dNJ6IS/AM55BWqGGGe8KWJEWgpybQsoTcSay2/Lg447/A/ZMcCU6uNo207GeT/3/jWKri
	 kj/W7kYsxzI5mPuTotE3F+iXbxZtfOLQLJy0sSGgTDx5iziJIM8o2K964zREay7oHUnyK
	 BJf+REFTMPND0qmbQHd6Vkne1q3O1+KlBRX3n/z4riBb3+XrKewOi0nXO+NcGD1EeS55K
	 2ssoWYEQ+BjHLIzDZ3kKVZ0Nz3HCQv31ejRaMyyDLpHbn8cBwzaCFgblgvFnrHtjbRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P2KwWbnS;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C34606A31D
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06C34606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P2KwWbnS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wrkputc8/RPpD4nnWHNw9T7RRAU4Kg2aM4nuyIGGs8E=;
	b=P2KwWbnS9ygGzQ/ZLqIaSEASARp1ANhH7OH8vh9SkqbCeKGzLAOjyDqcjuuzp56faazgvM
	eVmAUmPzTC4TVEhpvQOPAJ9X0YS6JelQZjBH9HP2Uas5A0/IsLtPfgKkGvQOsX/wNJ5DZv
	4s4hwEOGelFhvZpAi4BkPo99bXszpBM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-AZuVlQ_mNCWlMBKmGs5kWg-1; Tue,
 20 Oct 2026 10:46:23 +0000
X-MC-Unique: AZuVlQ_mNCWlMBKmGs5kWg-1
X-Mimecast-MFC-AGG-ID: AZuVlQ_mNCWlMBKmGs5kWg_1792493179
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73F281800D85;
	Tue, 20 Oct 2026 10:46:18 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D8411956088;
	Tue, 20 Oct 2026 10:46:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
Date: Tue, 20 Oct 2026 14:45:19 +0400
Subject: [PATCH v7 02/65] qapi: Ease access to introspection names
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-2-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7889;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=a2pApAt20adFheRFMFL0JhfgD1DBySkAUQki6ne7iLY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZX47T8N7MhCWr0sH+GZry8k5SuXuUXyZs9e
 X4b68TesAyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGVwAKCRDa6OEJdZac
 5auAD/4/Ie/cSClFbfq3pLk5G4chwRGPx/IkNYssN2QhE7SuensGeO9N3hAkiwjTWMQUa4RmIV3
 Ih/ody0cyQZ7ebEGwThhPd/0tDx7xTVJYKJlWKSTE5TWfQGUlgdud9VFnpmx8tSWLwXoFzA3/Hi
 z84mm5HxX4k1UOcwbKkeDY6EkPEVuH8/N0fn/A7MiLmcS+vrSdBq2tiEnHZ2QEopsTjy7Fg+8Dm
 trZ5cGqVMRvocoVM8CgiT6O62rCese/7CxN6AiIHPC523itkKI9FAhKp4RCjU92vE34Y4qb3OK7
 4nLiR3tXfQKU/YeaXR1MILIVGMiK5nF1dai6meQh2g2gFR5CZaT6gar5YZXLqO6P5vbb/h9A5B1
 XfERQ+8YYELHMZBHW9/k9O9lzRT4AaVsNM0NRp0v7q2tBK8LXDi/gCQ8p7fmH14kbbMpCNI05fK
 raCcLlKl6gYu52cO8zN9VqgDnMq9FRZW0+OUXJFULxZ30mbl8FV2VQh7yqS7Pjv7b0zNHWAunEZ
 wonP/p1G5r2Po5hwZOcexcv5WAK6BbCPlEQLoNz9USS4GnPaglfv0pEsF4RVBhsqmN/mm7S8mbt
 wlt5AqKpk3Y/XRH4EIFYc+5GuwKmie/wmHA0vfOmbqn2V9JRLHgrJL5pHEdbb6UDEt2kucPZXXU
 qlf+go84nzQ475Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: rHlkaD3X518Tt5a-sQ16jq4vpQZ8r8F4-pcl3u5tJvE_1792493179
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Markus Armbruster <armbru@redhat.com>

query-qmp-schema masks type names, because they are not part of the
external interface.  Marc-André Lureau would like to also use them
with qom-list & friends.  Trouble is the masked names are buried deep
in QAPISchemaGenIntrospectVisitor.  Lift them into schema.py: new
QAPISchemaDefinition method introspection_name() returns a
definition's name for use in introspection.

This changes the masked names, which is fine.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/introspect.py | 23 ++++-------------------
 scripts/qapi/schema.py     | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 7e28de2279ad..644461560c64 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -30,7 +30,6 @@
     QAPISchemaAlternatives,
     QAPISchemaArrayType,
     QAPISchemaBranches,
-    QAPISchemaBuiltinType,
     QAPISchemaEntity,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
@@ -177,7 +176,6 @@ def __init__(self, prefix: str, unmask: bool):
         self._schema: Optional[QAPISchema] = None
         self._trees: List[Annotated[SchemaInfo]] = []
         self._used_types: List[QAPISchemaType] = []
-        self._name_map: Dict[str, str] = {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-introspect.h"
@@ -208,18 +206,14 @@ def visit_end(self) -> None:
         self._schema = None
         self._trees = []
         self._used_types = []
-        self._name_map = {}
 
     def visit_needed(self, entity: QAPISchemaEntity) -> bool:
         # Ignore types on first pass; visit_end() will pick up used types
         return not isinstance(entity, QAPISchemaType)
 
     def _name(self, name: str) -> str:
-        if self._unmask:
-            return name
-        if name not in self._name_map:
-            self._name_map[name] = '%d' % len(self._name_map)
-        return self._name_map[name]
+        assert self._schema
+        return self._schema.definition_introspection_name(name, self._unmask)
 
     def _use_type(self, typ: QAPISchemaType) -> str:
         assert self._schema is not None
@@ -237,13 +231,6 @@ def _use_type(self, typ: QAPISchemaType) -> str:
         # Add type to work queue if new
         if typ not in self._used_types:
             self._used_types.append(typ)
-        # Clients should examine commands and events, not types.  Hide
-        # type names as integers to reduce the temptation.  Also, it
-        # saves a few characters on the wire.
-        if isinstance(typ, QAPISchemaBuiltinType):
-            return typ.name
-        if isinstance(typ, QAPISchemaArrayType):
-            return '[' + self._use_type(typ.element_type) + ']'
         return self._name(typ.name)
 
     @staticmethod
@@ -271,8 +258,7 @@ def _gen_tree(self, name: str, mtype: str, obj: Dict[str, object],
                 # Output a comment to make it easy to map masked names
                 # back to the source when reading the generated output.
                 comment = f'"{self._name(name)}" = {name}'
-            name = self._name(name)
-        obj['name'] = name
+        obj['name'] = self._name(name)
         obj['meta-type'] = mtype
         if features:
             obj['features'] = self._gen_features(features)
@@ -327,8 +313,7 @@ def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
                          ifcond: QAPISchemaIfCond,
                          element_type: QAPISchemaType) -> None:
         element = self._use_type(element_type)
-        self._gen_tree('[' + element + ']', 'array', {'element-type': element},
-                       ifcond)
+        self._gen_tree(name, 'array', {'element-type': element}, ifcond)
 
     def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
                                ifcond: QAPISchemaIfCond,
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 9c9e257a8fd5..11f3accec873 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -136,6 +136,13 @@ def __repr__(self) -> str:
     def c_name(self) -> str:
         return c_name(self.name)
 
+    def set_ordinal(self, ordinal: int) -> None:
+        pass
+
+    # pylint: disable=unused-argument
+    def introspection_name(self, unmask: bool) -> str:
+        return self.name
+
     def check(self, schema: QAPISchema) -> None:
         assert not self._checked
         super().check(schema)
@@ -323,6 +330,17 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
 
 
 class QAPISchemaType(QAPISchemaDefinition, ABC):
+    def __init__(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        doc: Optional[QAPIDoc],
+        ifcond: Optional[QAPISchemaIfCond] = None,
+        features: Optional[List[QAPISchemaFeature]] = None,
+    ):
+        super().__init__(name, info, doc, ifcond, features)
+        self._masked_name: Optional[str] = None
+
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
     @abstractmethod
@@ -363,6 +381,17 @@ def need_has_if_optional(self) -> bool:
         # Except for arrays; see QAPISchemaArrayType.need_has_if_optional().
         return not self.c_type().endswith(POINTER_SUFFIX)
 
+    def set_ordinal(self, ordinal: int) -> None:
+        assert not self._masked_name
+        self._masked_name = str(ordinal)
+
+    def introspection_name(self, unmask: bool) -> str:
+        # Type names are not part of the external interface.  Hide
+        # them in introspection.  Also saves a few characters on the
+        # wire.
+        assert self._masked_name
+        return self.name if unmask else self._masked_name
+
     def check(self, schema: QAPISchema) -> None:
         super().check(schema)
         for feat in self.features:
@@ -402,6 +431,11 @@ def json_type(self) -> str:
     def doc_type(self) -> str:
         return self.json_type()
 
+    def introspection_name(self, unmask: bool):
+        if self.json_type() == 'int':
+            return 'int'
+        return self.name
+
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_builtin_type(self.name, self.info, self.json_type())
@@ -503,6 +537,9 @@ def doc_type(self) -> Optional[str]:
             return None
         return 'array of ' + elt_doc_type
 
+    def introspection_name(self, unmask: bool):
+        return '[' + self.element_type.introspection_name(unmask) + ']'
+
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_array_type(self.name, self.info, self.ifcond,
@@ -1182,6 +1219,7 @@ def _def_definition(self, defn: QAPISchemaDefinition) -> None:
                     "'%s' is already defined\n%s" % (defn.name, where))
             raise QAPISemError(
                 defn.info, "%s is already defined" % other_defn.describe())
+        defn.set_ordinal(len(self._entity_dict))
         self._entity_dict[defn.name] = defn
 
     def lookup_defn(self, name: str) -> Optional[QAPISchemaDefinition]:
@@ -1208,6 +1246,11 @@ def resolve_type(
                 info, "%s uses unknown type '%s'" % (what, name))
         return typ
 
+    def definition_introspection_name(self, name: str, unmask: bool) -> str:
+        defn = self.lookup_defn(name)
+        assert defn
+        return defn.introspection_name(unmask)
+
     def _module_name(self, fname: str) -> str:
         if QAPISchemaModule.is_system_module(fname):
             return fname

-- 
2.56.0.116.g6de20f6092dc

