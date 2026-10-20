Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493473;
	b=yNANEzCFMS3a5oeiig2SnkB7r2Rf/tQ6pGaZO4esPtZCpebEgbMszTUJS4E2zdBFBTf0
	 wWH7xMw6X1O8+6OA2TiUF48qHY5DCiefQc9KhvlrlpZzGfKrG8TrmIF9zHVnXphx0mtQs
	 +94dRZunj6rlI4QNAlAp5n2yFBYwH+S8WbmJcT9omG4iE9l6piIx5VtiFiaMb/9Pjmu4R
	 m4ZBvs+hxkMx8phVvudxwe2dYG92zggTdXCqiAf4YTPYPUY9bw3Me+mVoMubtb5sJoOLp
	 5p5kzYt1hTecQYbl44TjjkZIam2eqQ9lHhypaO9abZK2sYvEaB6tzrCDC7NwtoIuATg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493473;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=O4pdCz1MgQ3GeOtrPeQzKHNQrLJKFwMgs4D5tHNFOGI=;
	b=Yo5UJwI54VO2n9mM0n2hRTUK0OIpT+7nruzc4n2gc4RAZiVg3q4R+hUCO7+nHACHdnR6
	 lhV2/hD9brF5mNItiJVEsmnYwceopSB45gaB2TY2i2AFiLAL6pGjkUP40g9Qe7U7BGbLd
	 +SY1Y6Ri7NRMX8EV+sa/RwBcF3PU+rT9ZSJtSuMLFsIiS3qsKLMLcKf4+nz3JAdYwCNS6
	 +Rkeoz9uNXTSrOY+BkpbMQ2dYvstj2cu1ad9ML21vNA+D6EoY0gqOQUbMUDBsmvFxz+3O
	 xPUEhJwHxqYqMcbEPZ+7MesQ6F+X7T5hB9CYoKqv7FwVRxZTXUIO/QMdtXR0F6ZDq6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XsVRMeFF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488AD60A260D
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 488AD60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XsVRMeFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4pdCz1MgQ3GeOtrPeQzKHNQrLJKFwMgs4D5tHNFOGI=;
	b=XsVRMeFFt21/YhHE2stfcKEd33yp9FwNaoEOIFlWhKw0JoA9Ag1wdQB8kvNTJSsMztXxcc
	FTPNsz+G57IRpLci0SFzClu5GR4GyJCLxO9s7VWlAzfV3IL4kQcGDXFMxGEscRbwr0mb4Y
	pTHDiFkMG9yZRxtlNZumwpYJdCN+3GA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-_pwTePgnOyq7pM8ip4VO7Q-1; Tue,
 20 Oct 2026 10:51:01 +0000
X-MC-Unique: _pwTePgnOyq7pM8ip4VO7Q-1
X-Mimecast-MFC-AGG-ID: _pwTePgnOyq7pM8ip4VO7Q_1792493456
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91D281800EFA;
	Tue, 20 Oct 2026 10:50:56 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15C651956088;
	Tue, 20 Oct 2026 10:50:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:09 +0400
Subject: [PATCH v7 52/65] qdev: add qapi_type field to PropertyInfo with
 fallback registration
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-52-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7178;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MHwt79KEqovxMUVbjLHZbzyPQ3O7/QvHLzBLKn+XdlM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10Zcd4GS3Tym0oVL8eCpFa4hRCCy54I3T6LAS
 GF+IaGc/aeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXAAKCRDa6OEJdZac
 5WzhEACv7w/6wGYDKzLQ4S7kKafC2zvA6aWWltqZx5U2rfzcdYynrwTqRWspmtblrvG3W+dgEC+
 GAiDyLTgKT/lplKlqYBCdfo+mBOQ4RjrVFTquBNP7tb1Fd+qp3t9zQNOdVsG19deLE9AuNuonie
 dHae66WUQvaHL65hhmJipl9CSHWAnomOXOJyyJ5TL7veXseSM7+BeIhf9rfjjFO8FcXXPYefN7N
 Vj3I83aE6DPR/08nzenNixXWPzk/ArswJ6q/WcvvA4tPhYrSNEycqptfkH7BEXqVd7el6w8D/YN
 MPh3DkIQPMJRNazDp8xYwJ9S7WdeQafqvm2YRNH3av88ggfFTz7NYxyA1NqzQtYSoUdHWuIhTn4
 iEQZvksitISNyDmdkzfDLuR2kXyHOr5e/Ll/cSV0Ps9dQfXLywgbcnCbHnAusIvjx2/yJpdI/Kw
 UDLtSxgSEKeHrkvuJ1rkjQRWeS3sG8ZaCwAtAzrvEAf7FBdvdyzvLVfovAymyrCO3O4KUQsdLtc
 k505iFW90rwA+7wcXcuPkUs77jjArhUF6EOpJVKL6ErZLXV946xeHqqPjfKif9ol3evcCxzVX6r
 unBBDNEV7BsJc5ZHOQ+1Ftf9LXCkbgKFmXSobicTcap1DX/Io5n/fKrAoeaRBbBM42ysjZJzaqZ
 B28Z8/csjxKt2hA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 1G7mx_hSLglo5Wz6FLZp8U2MUGNW019-2t4DfQeAnUQ_1792493456
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add a qapi_type field to PropertyInfo to prepare for the transition
from string-based type metadata to QAPI type-info.

Add a qdev_prop_qapi_type() helper that resolves the QAPI type for a
property from .qapi_type. It will be later extended to cope with array
types.

Update qdev_property_add_static() and qdev_class_add_property() to
prefer object_property_add_qapi() when a QAPI type is available, falling
back to the old object_property_add() for unconverted properties.

Update the shared enum accessor functions to prefer .qapi_type->lookup
over .enum_table via a new qdev_propinfo_enum_lookup() helper.

No PropertyInfo definitions are changed, all .qapi_type fields
default to NULL, so the fallback paths are always taken. This patch
is no-op for now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c         | 68 ++++++++++++++++++++++++++++++---------
 include/hw/core/qdev-properties.h |  1 +
 2 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 34d7b26a7303..ee50fbb9f570 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -99,13 +99,22 @@ static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
     return info->set ? field_prop_set : NULL;
 }
 
+static const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info)
+{
+    if (info->qapi_type) {
+        assert(info->qapi_type->lookup);
+        return info->qapi_type->lookup;
+    }
+    return info->enum_table;
+}
+
 void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
 
-    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
+    visit_type_enum(v, name, ptr, qdev_propinfo_enum_lookup(prop->info), errp);
 }
 
 void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
@@ -114,14 +123,15 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
     const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
 
-    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
+    visit_type_enum(v, name, ptr, qdev_propinfo_enum_lookup(prop->info), errp);
 }
 
 void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
                                           const Property *prop)
 {
     object_property_set_default_str(op,
-        qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
+        qapi_enum_lookup(qdev_propinfo_enum_lookup(prop->info),
+                         prop->defval.i));
 }
 
 /* Bit */
@@ -941,8 +951,8 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
 
     prop = qdev_prop_find(dev, name);
     object_property_set_str(OBJECT(dev), name,
-                            qapi_enum_lookup(prop->info->enum_table, value),
-                            &error_abort);
+        qapi_enum_lookup(qdev_propinfo_enum_lookup(prop->info), value),
+        &error_abort);
 }
 
 void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
@@ -1143,18 +1153,33 @@ const PropertyInfo qdev_prop_link = {
     .set = set_link,
 };
 
+static const QAPITypeInfo *qdev_prop_qapi_type(const Property *prop)
+{
+    /* this will be later extended to cope with QAPI array properties */
+    return prop->info->qapi_type;
+}
+
 void qdev_property_add_static(DeviceState *dev, const Property *prop)
 {
     Object *obj = OBJECT(dev);
     ObjectProperty *op;
+    const QAPITypeInfo *qapi_type = qdev_prop_qapi_type(prop);
 
     assert(!prop->info->create);
 
-    op = object_property_add(obj, prop->name, prop->info->type,
-                             field_prop_getter(prop->info),
-                             field_prop_setter(prop->info),
-                             prop->info->release,
-                             (Property *)prop);
+    if (qapi_type) {
+        op = object_property_add_qapi(obj, prop->name, qapi_type,
+                                      field_prop_getter(prop->info),
+                                      field_prop_setter(prop->info),
+                                      prop->info->release,
+                                      (Property *)prop);
+    } else {
+        op = object_property_add(obj, prop->name, prop->info->type,
+                                 field_prop_getter(prop->info),
+                                 field_prop_setter(prop->info),
+                                 prop->info->release,
+                                 (Property *)prop);
+    }
 
     object_property_set_description(obj, prop->name,
                                     prop->info->description);
@@ -1176,12 +1201,23 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
     if (prop->info->create) {
         op = prop->info->create(oc, name, prop);
     } else {
-        op = object_class_property_add(oc,
-                                       name, prop->info->type,
-                                       field_prop_getter(prop->info),
-                                       field_prop_setter(prop->info),
-                                       prop->info->release,
-                                       (Property *)prop);
+        const QAPITypeInfo *qapi_type = qdev_prop_qapi_type(prop);
+
+        if (qapi_type) {
+            op = object_class_property_add_qapi(oc,
+                                               name, qapi_type,
+                                               field_prop_getter(prop->info),
+                                               field_prop_setter(prop->info),
+                                               prop->info->release,
+                                               (Property *)prop);
+        } else {
+            op = object_class_property_add(oc,
+                                           name, prop->info->type,
+                                           field_prop_getter(prop->info),
+                                           field_prop_setter(prop->info),
+                                           prop->info->release,
+                                           (Property *)prop);
+        }
     }
     if (prop->set_default) {
         prop->info->set_default_value(op, prop);
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index eba5436e53b1..1ea2ba66bb37 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -34,6 +34,7 @@ struct PropertyInfo {
     const char *type;
     const char *description;
     const QEnumLookup *enum_table;
+    const QAPITypeInfo *qapi_type;
     bool realized_set_allowed; /* allow setting property on realized device */
     char *(*print)(Object *obj, const Property *prop);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);

-- 
2.56.0.116.g6de20f6092dc

