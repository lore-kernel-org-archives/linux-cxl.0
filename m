Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493502;
	b=BINuFo21Jburd6etl0A4IdCF5INpkUTkwSXl7MnlR5V/1jvEviBhRfvIn5ezkxWJvCde
	 Bt+tC+AO2AtrRIEF2mIef0M9ZimsEVKI3vgqj0yTCYGKSgOhwfIcdpNNpckyHQOxdBX25
	 pUOgVPIezqTx3YUk0iV19IEyYsnl/WeJfilC/rcfxe1BKM8uhebsAMQ2CHXhW0In1buZk
	 hAdxXw5CbB0o7xqZZL1qaTm/CMSKj5Hv0feygTL04/YyF2CZw+KbN4rv/uLo5H6O7GO+V
	 acWQ9B855bBsQd+SVmdaIzY9oaneo1j4uOacS8dg6+hgl8Q8btQuqs+pLXX80SBSMpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493502;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=nP79V/gtequIXU+t/Eu02ll/FN9WUbHuc8AyTpCeGFQ=;
	b=3PLTlq4hygVLIgF8Dec19GWX5ifT84NDd8yPdVJtfS2Tovv0RikKvk6m8mu6hn0KK2Vo
	 yhhKL2VU9fPSgRIRrj62SGu1zuajwnlFWg7cTbNu6N/1PgWUMvkgPsVeIK8cjRB+x/mRx
	 B78yBz4P0mhhAtasQMwLZEmLoU2cYi/T0kVEw8vSbsvO31Gh8PYhPS4IXisvLjfqNEBmV
	 7samT3phhFn0WzsP14a30+cL8JL3sqCiKOYV1bJMsWNN9BIcoMplnT2HdiBhy3dAtZtDO
	 lIv9rJ2LsxCtuAY15fyOk6rv4iEW7WlYEH6/FvwVdXCEVY6sdHZk2Vs/gBdrsAEbJ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RiU2O99M;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8260A2630
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D8260A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RiU2O99M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nP79V/gtequIXU+t/Eu02ll/FN9WUbHuc8AyTpCeGFQ=;
	b=RiU2O99MS/9m4AUnW/Fcmjaw+JFGOdWG1O+s0qlUffVMRqnese8zoUbJ5lSLHia8rcoiUh
	Fi9EvgyYeOBsr2brZyuy5P9HXEAhEM0TLflR5rAaCGazn7EYj6yDVpx3kAcQGGSGhpCEIi
	eNbN+iQflskkuyC/ypH9tLwlzoJ79uY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-xio_7je-O7qSetICYWdMZA-1; Tue,
 20 Oct 2026 10:51:36 +0000
X-MC-Unique: xio_7je-O7qSetICYWdMZA-1
X-Mimecast-MFC-AGG-ID: xio_7je-O7qSetICYWdMZA_1792493492
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1AEC19541A2;
	Tue, 20 Oct 2026 10:51:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDBF930000E7;
	Tue, 20 Oct 2026 10:51:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:16 +0400
Subject: [PATCH v7 59/65] qdev: introduce typed array PropertyInfos
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-59-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14678;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mlWOi/fW9OK4tckY+TRn1APE+VrJXQmOBnALGjwbEQ0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZcpE0N36exL5+QBGMlSA4uACN+Y42xftBBX
 h9qkQtQ0riJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXAAKCRDa6OEJdZac
 5c4yD/0UfQJG5WPTuqhdaOYQ99AXPKpribvFkipRwwlEz96K4bv7wRdXGRAr48+aD1LJmqKvk4f
 V17WHG4HitooSDv/eG/xUEtK/FocBxblDotXH8BhHVOB/Vm6+WZvumi1SaA7wsEEJTOmCoxI/+1
 JA4g74DbBXlF27s435rmq88I5yk503Hr5D/mtYjnBGEfJQJWP6gtGR0jJooy4WkKd1mu2/doJoa
 GW4yy09MADqm4HEVyvYVFq3jhw9DCTR1I6QOkWeiDwWMpsMGGG80At5F8/GBdJaNBTvKB8RZIx8
 MW0217lABMAz0nqw4WtpPqsol58KGjFV+nukL2w94iheX41hZlKyYMRt9HIMJvIlqJKkYnC/Pod
 Lf2LyJ9MJTjl3cStpGO6ZWTbaI7PTJTbDg/EPSgMc5bXZN+74W/24LNLnlAJV42D6Gn3H5x5HXc
 kRlLKg4vMoJA+KqASQpzEaMBcqXVKg5hlFivlzNZ783+Jo1g5fMBJCcH8BnPj9MWzmabnxLyWPU
 L/Vgjr2BOHK8D+hyhWAoWZGJSCdsQ+cvw06/E7oFhDC2pt/iuWjoHiDroClUn2z1un54JMSBOeF
 6koVyz1y+KYiYSH2xjv1sEelhoyWcBxu0Gsr6HR7pAkp7whYnNX+56uoutkbGSccx3fFcrczzZN
 x8oPZybEnxuzd7A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 6G-NCh2yVDwtwJRuFihIXJ76MP__qySVsqsXmUTINQg_1792493492
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add element_info and element_size fields to PropertyInfo, and extend
qdev_prop_qapi_type() to derive QAPI types for array properties via
element_info->qapi_type->list.

Add typed list PropertyInfo definitions that replace the generic
qdev_prop_array. Each typed list PropertyInfo knows its element type
at compile time through the element_info and element_size fields,
which allows the QAPI type to be derived automatically.

Infrastructure changes:
- Add prop_array_info() and prop_array_elem_size() helpers that
  prefer the new element_info/element_size fields with fallback to
  the old arrayinfo/arrayfieldsize fields for compatibility
- Make get_prop_array, set_prop_array, release_prop_array, and
  default_prop_array non-static so they can be used by
  DEFINE_PROP_ARRAY_INFO in other translation units
- Add DEFINE_PROP_ARRAY_INFO macro in qdev-prop-internal.h

The array of links needs special care for its "full type name" to follow
the "link<TYPE>List" pattern used by link properties ("link<TYPE>").

The old qdev_prop_array and DEFINE_PROP_ARRAY macro are preserved
for compatibility; they will be replaced in the next patch.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-prop-internal.h             |  21 +++++++
 hw/core/qdev-properties-system.c         |   5 ++
 hw/core/qdev-properties.c                | 104 ++++++++++++++++++++++++-------
 include/hw/core/qdev-properties-system.h |   2 +
 include/hw/core/qdev-properties.h        |   8 +++
 5 files changed, 119 insertions(+), 21 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index c190b7b88cf4..40fa4bc63f03 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -27,4 +27,25 @@ void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
 void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp);
 
+void get_prop_array(Object *obj, Visitor *v, const char *name,
+                    void *opaque, Error **errp);
+void set_prop_array(Object *obj, Visitor *v, const char *name,
+                    void *opaque, Error **errp);
+void release_prop_array(Object *obj, const char *name, void *opaque);
+void default_prop_array(ObjectProperty *op, const Property *prop);
+
+/*
+ * Note: .qapi_type is derived from element_info->qapi_type->list by
+ * qdev_prop_qapi_type()
+ */
+#define DEFINE_PROP_ARRAY_INFO(_elem_prop_info, _elem_type) \
+    {                                                       \
+        .element_info = &(_elem_prop_info),                 \
+        .element_size = sizeof(_elem_type),                 \
+        .get = get_prop_array,                              \
+        .set = set_prop_array,                              \
+        .release = release_prop_array,                      \
+        .set_default_value = default_prop_array,            \
+    }
+
 #endif
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 8819a9a0b748..ad4a00f776e6 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -484,6 +484,8 @@ const PropertyInfo qdev_prop_netdev = {
     .set   = set_netdev,
 };
 
+const PropertyInfo qdev_prop_netdev_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_netdev, NICPeers);
 
 /* --- audiodev --- */
 static void get_audiodev(Object *obj, Visitor *v, const char* name,
@@ -822,6 +824,9 @@ const PropertyInfo qdev_prop_reserved_region = {
     .set   = set_reserved_region,
 };
 
+const PropertyInfo qdev_prop_reserved_region_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_reserved_region, ReservedRegion);
+
 /* --- pci address --- */
 
 /*
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a9abc646d5d7..bace12b10e36 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -666,6 +666,22 @@ struct ArrayElementList {
     void *value;
 };
 
+static const PropertyInfo *prop_array_info(const Property *prop)
+{
+    if (prop->info->element_info) {
+        return prop->info->element_info;
+    }
+    return prop->arrayinfo;
+}
+
+static int prop_array_elem_size(const Property *prop)
+{
+    if (prop->info->element_size) {
+        return prop->info->element_size;
+    }
+    return prop->arrayfieldsize;
+}
+
 /*
  * Given an array property @parent_prop in @obj, return a Property for a
  * specific element of the array. Arrays are backed by an uint32_t length field
@@ -675,7 +691,7 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
                                 const char *name, char *elem)
 {
     return (Property) {
-        .info = parent_prop->arrayinfo,
+        .info = prop_array_info(parent_prop),
         .name = name,
         /*
          * This ugly piece of pointer arithmetic sets up the offset so
@@ -693,19 +709,21 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
  * underlying element's property release hook for each element and free the
  * property array.
  */
-static void release_prop_array(Object *obj, const char *name, void *opaque)
+void release_prop_array(Object *obj, const char *name, void *opaque)
 {
     const Property *prop = opaque;
     uint32_t *alenptr = object_field_prop_ptr(obj, prop);
     void **arrayptr = (void *)obj + prop->arrayoffset;
     char *elem = *arrayptr;
     int i;
+    const PropertyInfo *elem_info = prop_array_info(prop);
+    int elem_size = prop_array_elem_size(prop);
 
-    if (prop->arrayinfo->release) {
+    if (elem_info->release) {
         for (i = 0; i < *alenptr; i++) {
             Property elem_prop = array_elem_prop(obj, prop, name, elem);
-            prop->arrayinfo->release(obj, NULL, &elem_prop);
-            elem += prop->arrayfieldsize;
+            elem_info->release(obj, NULL, &elem_prop);
+            elem += elem_size;
         }
     }
 
@@ -719,8 +737,8 @@ static void release_prop_array(Object *obj, const char *name, void *opaque)
  * (a pointer to which is stored in the additional field described by
  * prop->arrayoffset).
  */
-static void set_prop_array(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
+void set_prop_array(Object *obj, Visitor *v, const char *name,
+                    void *opaque, Error **errp)
 {
     ERRP_GUARD();
     const Property *prop = opaque;
@@ -728,6 +746,8 @@ static void set_prop_array(Object *obj, Visitor *v, const char *name,
     void **arrayptr = (void *)obj + prop->arrayoffset;
     ArrayElementList *list, *elem, *next;
     const size_t size = sizeof(*list);
+    const PropertyInfo *elem_info = prop_array_info(prop);
+    int elem_size = prop_array_elem_size(prop);
     char *elemptr;
     bool ok = true;
 
@@ -746,9 +766,9 @@ static void set_prop_array(Object *obj, Visitor *v, const char *name,
     while (elem) {
         Property elem_prop;
 
-        elem->value = g_malloc0(prop->arrayfieldsize);
+        elem->value = g_malloc0(elem_size);
         elem_prop = array_elem_prop(obj, prop, name, elem->value);
-        prop->arrayinfo->set(obj, v, NULL, &elem_prop, errp);
+        elem_info->set(obj, v, NULL, &elem_prop, errp);
         if (*errp) {
             ok = false;
             goto out_obj;
@@ -770,8 +790,8 @@ out_obj:
         for (elem = list; elem; elem = next) {
             Property elem_prop = array_elem_prop(obj, prop, name,
                                                  elem->value);
-            if (prop->arrayinfo->release) {
-                prop->arrayinfo->release(obj, NULL, &elem_prop);
+            if (elem_info->release) {
+                elem_info->release(obj, NULL, &elem_prop);
             }
             next = elem->next;
             g_free(elem->value);
@@ -784,19 +804,19 @@ out_obj:
      * Now that we know how big the array has to be, move the data over to a
      * linear array and free the temporary list.
      */
-    *arrayptr = g_malloc_n(*alenptr, prop->arrayfieldsize);
+    *arrayptr = g_malloc_n(*alenptr, elem_size);
     elemptr = *arrayptr;
     for (elem = list; elem; elem = next) {
-        memcpy(elemptr, elem->value, prop->arrayfieldsize);
-        elemptr += prop->arrayfieldsize;
+        memcpy(elemptr, elem->value, elem_size);
+        elemptr += elem_size;
         next = elem->next;
         g_free(elem->value);
         g_free(elem);
     }
 }
 
-static void get_prop_array(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
+void get_prop_array(Object *obj, Visitor *v, const char *name,
+                    void *opaque, Error **errp)
 {
     ERRP_GUARD();
     const Property *prop = opaque;
@@ -806,6 +826,8 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     ArrayElementList *list = NULL, *elem;
     ArrayElementList **tail = &list;
     const size_t size = sizeof(*list);
+    const PropertyInfo *elem_info = prop_array_info(prop);
+    int elem_size = prop_array_elem_size(prop);
     int i;
     bool ok;
 
@@ -813,7 +835,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     for (i = 0; i < *alenptr; i++) {
         elem = g_new0(ArrayElementList, 1);
         elem->value = elemptr;
-        elemptr += prop->arrayfieldsize;
+        elemptr += elem_size;
 
         *tail = elem;
         tail = &elem->next;
@@ -826,7 +848,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     elem = list;
     while (elem) {
         Property elem_prop = array_elem_prop(obj, prop, name, elem->value);
-        prop->arrayinfo->get(obj, v, NULL, &elem_prop, errp);
+        elem_info->get(obj, v, NULL, &elem_prop, errp);
         if (*errp) {
             goto out_obj;
         }
@@ -848,7 +870,7 @@ out_obj:
     }
 }
 
-static void default_prop_array(ObjectProperty *op, const Property *prop)
+void default_prop_array(ObjectProperty *op, const Property *prop)
 {
     object_property_set_default_list(op);
 }
@@ -861,6 +883,39 @@ const PropertyInfo qdev_prop_array = {
     .set_default_value = default_prop_array,
 };
 
+const PropertyInfo qdev_prop_uint8_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint8, uint8_t);
+const PropertyInfo qdev_prop_uint16_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint16, uint16_t);
+const PropertyInfo qdev_prop_uint32_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint32, uint32_t);
+const PropertyInfo qdev_prop_uint64_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint64, uint64_t);
+const PropertyInfo qdev_prop_string_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_string, char *);
+
+static ObjectProperty *create_link_list_property(ObjectClass *oc,
+                                                  const char *name,
+                                                  const Property *prop)
+{
+    g_autofree char *full_type = g_strdup_printf("link<%s>List",
+                                                 prop->link_type);
+
+    return object_class_property_add(oc, name, full_type,
+                                     get_prop_array, set_prop_array,
+                                     release_prop_array, (Property *)prop);
+}
+
+const PropertyInfo qdev_prop_link_list = {
+    .element_info = &qdev_prop_link,
+    .element_size = sizeof(void *),
+    .create = create_link_list_property,
+    .get = get_prop_array,
+    .set = set_prop_array,
+    .release = release_prop_array,
+    .set_default_value = default_prop_array,
+};
+
 /* --- public helpers --- */
 
 static const Property *qdev_prop_walk(DeviceClass *cls, const char *name)
@@ -1159,8 +1214,15 @@ const PropertyInfo qdev_prop_link = {
 
 static const QAPITypeInfo *qdev_prop_qapi_type(const Property *prop)
 {
-    /* this will be later extended to cope with QAPI array properties */
-    return prop->info->qapi_type;
+    if (prop->info->qapi_type) {
+        return prop->info->qapi_type;
+    }
+    if (prop->info->element_info) {
+        assert(prop->info->element_info->qapi_type);
+        assert(prop->info->element_info->qapi_type->list);
+        return prop->info->element_info->qapi_type->list;
+    }
+    return NULL;
 }
 
 void qdev_property_add_static(DeviceState *dev, const Property *prop)
diff --git a/include/hw/core/qdev-properties-system.h b/include/hw/core/qdev-properties-system.h
index 2cbea16d615e..819dce7d5e5d 100644
--- a/include/hw/core/qdev-properties-system.h
+++ b/include/hw/core/qdev-properties-system.h
@@ -23,6 +23,8 @@ extern const PropertyInfo qdev_prop_fdc_drive_type;
 extern const PropertyInfo qdev_prop_drive;
 extern const PropertyInfo qdev_prop_drive_iothread;
 extern const PropertyInfo qdev_prop_netdev;
+extern const PropertyInfo qdev_prop_netdev_list;
+extern const PropertyInfo qdev_prop_reserved_region_list;
 extern const PropertyInfo qdev_prop_pci_devfn;
 extern const PropertyInfo qdev_prop_blocksize;
 extern const PropertyInfo qdev_prop_pci_host_devaddr;
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index 1ea2ba66bb37..0c067170079d 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -35,6 +35,8 @@ struct PropertyInfo {
     const char *description;
     const QEnumLookup *enum_table;
     const QAPITypeInfo *qapi_type;
+    const struct PropertyInfo *element_info;
+    int element_size;
     bool realized_set_allowed; /* allow setting property on realized device */
     char *(*print)(Object *obj, const Property *prop);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
@@ -75,7 +77,13 @@ extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_size32;
 extern const PropertyInfo qdev_prop_array;
+extern const PropertyInfo qdev_prop_uint8_list;
+extern const PropertyInfo qdev_prop_uint16_list;
+extern const PropertyInfo qdev_prop_uint32_list;
+extern const PropertyInfo qdev_prop_uint64_list;
+extern const PropertyInfo qdev_prop_string_list;
 extern const PropertyInfo qdev_prop_link;
+extern const PropertyInfo qdev_prop_link_list;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
         .name      = (_name),                                    \

-- 
2.56.0.116.g6de20f6092dc

