Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493279;
	b=pWnqXiAlja7aLhW5OIZY2H+Fp3WHpCC6F8tiymzfDkXDMEQS36d3lbGG4Pqh36HOjOg+
	 NSfk+5MXbmsWW101XQAM3gagC2rPoWx3g42vG3HkXpaWrYVPeuinD5iOSWlkO9WtAH5wa
	 nx53Yi6Z/2k4LC7NAPAaC0E9z/EKctC3Z/JiZGRjUZdnfbI5WEsf429caU+loa5Li3MKi
	 yqklocOhdU96NSqTpgjg8EBeYa0EGtzJusSKeOkw9Sx3n9GAwV8LG6ire1728Cl/lLgpb
	 j7aozX/3d1PwbBrG9bNdpy3tHFiE0bYUkzeFn+SAXvawVyHc3bnCEs7h8IIM3BZWBkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493279;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=VkXUlwrEvWdaFT7ZgPzD9XegjPTV54S9i+Wt7fwK38w=;
	b=qSfW29jD8flshpDyAOcCoweA+8YxeKK4nbuCR+lA1HjVAj6l+XRCb0CMCM1SnBo2ncwl
	 7MIMAQVISwj2Oz029Pj7mrIF7ad6MSnRig9A+JdIiKON2bSnSCFnQdO05uSSYHWNLR6Gz
	 OSVyN35xoCB9XqFbzsu0e2cn/SX5AbafeFzaYbQwjVD2fqBXWPu2TVm/mCZY5G9JFJEEd
	 dQc4ZbgbDciBbDHVUiqoALgL1FQLAJSEjCvg++fH/TChuKalKFGRz2vN48Hw7F0l98OCs
	 YzAwl114miiFaGtinv6wQjKdR3eXMHejC/vATUL3IGK2nHYxBk0ye6X8JHKWIH/v87A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=INNtbXku;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14347606A31B
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14347606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=INNtbXku
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VkXUlwrEvWdaFT7ZgPzD9XegjPTV54S9i+Wt7fwK38w=;
	b=INNtbXkuyJVdnAyft3dYOsgDSWFhLZHr3UlU3vDj3Ajlierj9plW1xe6WmyQvfm8mBuBaH
	TKkPDIzHeaDfiV4FeksxjdE4ILqm9d6iIp+mU4C7BjMtR5t/P13yzvtCjhTRpx0o8eMSkA
	ca7dyKqV0vPrlkr8OLnj6vbte5gAZII=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-ofM9Jc0cNLCC9EhH-k12SQ-1; Tue,
 20 Oct 2026 10:47:51 +0000
X-MC-Unique: ofM9Jc0cNLCC9EhH-k12SQ-1
X-Mimecast-MFC-AGG-ID: ofM9Jc0cNLCC9EhH-k12SQ_1792493267
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10F8B19560B6;
	Tue, 20 Oct 2026 10:47:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05BB51800444;
	Tue, 20 Oct 2026 10:47:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:34 +0400
Subject: [PATCH v7 17/65] qom: add object_{class_}property_add_qapi_enum
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-17-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7651;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6wd/SoQY2q+EMLwTd/AeIQErpXbBILREXSh6bn43Lqo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZZB/jExQFvbdi+wU3hKVxpaaPc1XbpmkIhP
 WMqxmJ0I1aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWQAKCRDa6OEJdZac
 5dBmD/9iljR90PsVPSEMouwGTqd5u0I3uFFVeGE6aj8If5dMfAJeES/9tbvs9mRjLcapLLGllYU
 TQNIPpVo9+5Q6yWoXDup+0bZugqArDJn+E+oR5GWaIn14K0W/lTsFVa1fdorL5FJzcZt9nLwPbs
 qBkK2X0Tow/JAOq9beFe0nqvt9e3h8csBkY2OzylCKV8xgUUa/N7/jUd9n3xMAaklrEguKhws7p
 RB2EmxgN94MyEQXZtZhqjVrWq/vsUKgCcwLJ7z6Xyu8ikQIh00qHstMPJONSLnW5X32860y2JUn
 RdI6UxJof0RAZu18Ge3d8Qgv+eKmoIfivMtXvHmI0YJtHLFqrI6rXfocRQLrZTDmpURYQ6U9u1U
 9yB9eLpPbMa9W1bghYaq4IAEJtvVsjv1kKDYGVAIPSlYH4dCgI/2TzssabsosxuEN1Phkx1epKW
 nBgKSEf8pt2cQsFq4SKILCVz/lUAkaZIcqrcLdVjN41qVK33dbV9SETzfNzbcypT0qn3Uvh31bB
 cekeBayXn2khLf+x2Dyym0EbRSJPRvIWIuFiabEG6a8kpeAZgLkNy8ux2Hrid+xaEV/Q2NlRSrc
 gxaEBZ3gRSWWWvkLE9xRhqAlVrj2m9egPJPQhy1zP1+3Zkc94/+TwXdjvCND2ByqbflBsfGVWJ7
 eokXUJapDD7zDZg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: PVO_cRXyb3gsm4xe_-WwiM1PlN1bhkZYcLs0peUCR9I_1792493267
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 74 ++++++++++++++++++++++++++++++++++++++++++
 qom/object.c         | 90 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 159 insertions(+), 5 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index eb61d8842b80..e04be4caed57 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2027,6 +2027,80 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **));
 
+/**
+ * struct QapiEnumProp: Descriptor for a property backed by a QAPI enum type
+ *
+ * Binds a QOM object property to a QAPI enum, providing automatic
+ * string<->int conversion through QAPI visitors and optional
+ * default-value initialization during object instance init.
+ *
+ * Use the QAPI_ENUM_PROP() macro to construct instances inline.
+ *
+ * @name: property name exposed on the QOM object
+ * @description: human-readable description (shown in ``-device help``, etc.)
+ * @default_value: initial enum value applied via @set during instance init,
+ *                 or -1 (the QAPI_ENUM_PROP default) to skip initialization
+ * @qapi_type: pointer to the generated QAPITypeInfo for the enum
+ *             (provides the string<->int lookup table)
+ * @get: getter that returns the current enum value as int, or -1 on error
+ * @set: setter that receives the enum value as int; %NULL for read-only props
+ */
+typedef struct QapiEnumProp {
+    const char *name;
+    const char *description;
+    const int default_value;
+    const QAPITypeInfo *qapi_type;
+    int (*get)(Object *, Error **);
+    void (*set)(Object *, int, Error **);
+} QapiEnumProp;
+
+#define QAPI_ENUM_PROP(...) ({                                           \
+    static const QapiEnumProp _prop = {                                  \
+        .default_value = -1, __VA_ARGS__                                 \
+    };                                                                   \
+    &_prop; })
+
+/**
+ * object_property_add_qapi_enum:
+ * @obj: the object to add a property to
+ * @prop: property descriptor
+ *
+ * Add an enum property with QAPI type association.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_property_add_qapi_enum(Object *obj, const QapiEnumProp *prop);
+
+/**
+ * object_class_property_add_qapi_enum:
+ * @klass: the class object to add a property to
+ * @prop: property descriptor
+ *
+ * Add an enum property with QAPI type association.
+ *
+ * Use the QAPI_ENUM_PROP() macro to construct the property descriptor
+ * inline. If .default_value is not set, the property is not initialized
+ * (default_value is -1). Otherwise, the setter is called with
+ * default_value during object instance init.
+ *
+ * Example::
+ *
+ *   object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+ *       .name = "policy",
+ *       .description = "Set the NUMA policy",
+ *       .default_value = HOST_MEM_POLICY_DEFAULT,
+ *       .qapi_type = &HostMemPolicy_type_info,
+ *       .get = my_get_policy,
+ *       .set = my_set_policy,
+ *   ));
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_class_property_add_qapi_enum(ObjectClass *klass,
+                                    const QapiEnumProp *prop);
+
 /**
  * object_property_add_qapi:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index bebbfc43556d..cc113c0810e7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1219,7 +1219,7 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
         return;
     }
 
-    if (data->implements_type && 
+    if (data->implements_type &&
         !object_class_dynamic_cast(k, data->implements_type)) {
         return;
     }
@@ -1786,7 +1786,6 @@ int object_property_get_enum(Object *obj, const char *name,
     char *str;
     int ret;
     ObjectProperty *prop = object_property_find_err(obj, name, errp);
-    EnumProperty *enumprop;
 
     if (prop == NULL) {
         return -1;
@@ -1799,14 +1798,17 @@ int object_property_get_enum(Object *obj, const char *name,
         return -1;
     }
 
-    enumprop = prop->opaque;
-
     str = object_property_get_str(obj, name, errp);
     if (!str) {
         return -1;
     }
 
-    ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
+    if (prop->qapi_type) {
+        ret = qapi_enum_parse(prop->qapi_type->lookup, str, -1, errp);
+    } else {
+        EnumProperty *enumprop = prop->opaque;
+        ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
+    }
     g_free(str);
 
     return ret;
@@ -2609,6 +2611,84 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
                                      prop);
 }
 
+static void get_qapi_enum(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    const QapiEnumProp *prop = opaque;
+    int value;
+    Error *err = NULL;
+
+    value = prop->get(obj, &err);
+    assert(value >= 0 || err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp);
+}
+
+static void set_qapi_enum(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    const QapiEnumProp *prop = opaque;
+    int value;
+
+    if (!visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp)) {
+        return;
+    }
+    prop->set(obj, value, errp);
+}
+
+static void init_qapi_enum(Object *obj, ObjectProperty *prop)
+{
+    const QapiEnumProp *e = prop->opaque;
+
+    if (e->set && e->default_value >= 0) {
+        e->set(obj, e->default_value, &error_abort);
+    }
+}
+
+ObjectProperty *
+object_property_add_qapi_enum(Object *obj, const QapiEnumProp *e)
+{
+    ObjectProperty *prop;
+
+    assert(e && e->qapi_type && e->qapi_type->lookup);
+
+    prop = object_property_add_qapi(obj, e->name, e->qapi_type,
+                                    e->get ? get_qapi_enum : NULL,
+                                    e->set ? set_qapi_enum : NULL,
+                                    NULL,
+                                    (void *)e);
+    prop->description = g_strdup(e->description);
+    if (e->default_value >= 0) {
+        prop->init = init_qapi_enum;
+    }
+
+    return prop;
+}
+
+ObjectProperty *
+object_class_property_add_qapi_enum(ObjectClass *klass, const QapiEnumProp *e)
+{
+    ObjectProperty *prop;
+
+    assert(e && e->qapi_type && e->qapi_type->lookup);
+
+    prop = object_class_property_add_qapi(klass, e->name, e->qapi_type,
+                                          e->get ? get_qapi_enum : NULL,
+                                          e->set ? set_qapi_enum : NULL,
+                                          NULL,
+                                          (void *)e);
+    prop->description = g_strdup(e->description);
+    if (e->default_value >= 0) {
+        prop->init = init_qapi_enum;
+    }
+
+    return prop;
+}
+
 ObjectProperty *
 object_property_add_qapi(Object *obj, const char *name,
                          const QAPITypeInfo *qapi_type,

-- 
2.56.0.116.g6de20f6092dc

