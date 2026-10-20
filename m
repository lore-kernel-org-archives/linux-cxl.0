Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493524;
	b=ZDE4UE+erE22etYOwK8xfkACO/mF4MSLh22IgEm9Q0u3gFr0Sqx+KfAXKgJK5+QObnd3
	 3JAALlir1C1z5jmNivg/fe+Zm5MaD+TPaiXGJHSIap4ntuT5orgM5jOEyfv/8q6vCr6wR
	 9EjxgnB2p5Oe5WBLiv5NwoXq6qq8N+q5O15ofAXypbQOtohuOs6QN+sh6oMNrEsL+/l3W
	 4TjFNsWI5q7ulxrhZEC67WlTV8i5W9WS1swfawRAZKmdsIFFiSqL1idR1U4Tf2GexjijI
	 hLRMMNzuDE3PodjmTiyXX6h/BLjVxIXKhReyN8NZ259BLOh7g900KpQS6evxJLdl6Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493524;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=ccOsUIeVtpZ4LAvRKvLPIKBLjfW8xoZv/G7l+9bsArM=;
	b=EmzpWeRn/7c5QrWsZndHc/ot+sxg4xalHZiIyuW3wGuvMwDEm3FvPR/zEH57+tznVCy9
	 /S1q+IO3XU83bNqsgXx4ws/CnWCYcG81i2GQqd7iAaNlpJI0yHMPB7AkGq3RN2e5nWDzJ
	 lSEg6mTp8IFjXN7TmtOiTB10CvTeAqXx4daFA+yKDOLC24mXGN6ovIKazV9DypSBDyyJC
	 u07OwZoKeXWWAuABiWQhQpKYeFK0f1EKw4okWHVZ1sGgiO4bwblXdkTCAFAdhLc23FryZ
	 qybQy+wh50mhJnHhtNSiLhKk1GCncJLyEpoa1zC6jcAh53BkJOhMTC/1ofLVVQYiJ8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K9WCtTdV;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCE60A261C
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86FCE60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K9WCtTdV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccOsUIeVtpZ4LAvRKvLPIKBLjfW8xoZv/G7l+9bsArM=;
	b=K9WCtTdV7r+EwLaE5aExv1tr5fJoh2XluabdFEhxfEp9wMxhw2+AQrv4f2IVNopJDnm/9r
	bp7AhES0I5qEEOrdIJVTuVBNAOqM6niBB7I/mQNquYYGkGUcOdMlzSnnPykL7d4sXR3sXi
	+20y5Lzn3wqgIeRJbsmw9RoZQeTdkos=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-LUDw3GgDOriOUgUPMvJZCA-1; Tue,
 20 Oct 2026 10:51:57 +0000
X-MC-Unique: LUDw3GgDOriOUgUPMvJZCA-1
X-Mimecast-MFC-AGG-ID: LUDw3GgDOriOUgUPMvJZCA_1792493513
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55CF01955BD4;
	Tue, 20 Oct 2026 10:51:53 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7054130000E7;
	Tue, 20 Oct 2026 10:51:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:20 +0400
Subject: [PATCH v7 63/65] qom: remove old enum property registration API
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-63-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7342;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4DUVOH2Il1uXarwapsGNw4Sqxi5JL+XRDYj5v/DxTXw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZdSCtnqLwFsuDwikbI6gRflGPZtD05w5lEa
 CvQaDVyJvKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXQAKCRDa6OEJdZac
 5VbJEACAn2E9Fh4lFMReVrd4NHuC3naIFHBUIw5ZLoxN7mbcaqivG69WFWxx7ZOrTDRmg/G7yWj
 fDJpczz3Mb0e0IfqafD0Zo52HRprrS3vQqsPJaRNSQkXu2fm6LC1O8aSPWSYAU1eanghk9OhXWy
 YrwTj+hC9ewJZHcH2F93rQKIhbccNRiQPCGgJPy4Lrq/uTwsScJ1VwIlavz58EMOc8D5pLsrqcC
 yq0g6DK4SrNPSK30qRc1DYPDZzDv6UP/6SYl4MOl80b/lEg9HtMa3nOcPYat73Xrz4lJ34zsyq2
 DaiEjhshxRzeWlxSRKFBlCtFXeclBqDgqyY/wXjt1O7g+q+UUKYGqmFXdH3HZHF2a0DzqVUoNpl
 4FKV2A5wr9Y9wmy+YIR0Lnw3Te8+UkuWx8TJu4UGPD64J7Am8Zdr+5lc4k63v3MIxbJ3V6i3/gx
 xcPgIxzQ2tjUAC413GKGiKMZihOU5ca3wMMcT+SurJ4f6AckLphRseXIw6lV64r07VMlIt2v/on
 t/KCYg7F6sIRLgxf7Q8rsFrDB/0o+lW42EJjrEKIKBVNwdsoxM+4Tc7BWJ7ciCx3ovDWcgc+b9G
 Z8i3KE57kVIhAV2xKZSycVzEGQWVUjJagDqkIlSLS/+8A/FeLV/wYW0PQJQEo9s4t45BXPSFjoI
 Q65g0nQz/0Olqvw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: jQ28Azco3qem1TQmHex8t3a1p6EHFMfq60iTrmJr4-w_1792493513
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Now that all callers use object_class_property_add_qapi_enum(), remove
the legacy object_property_add_enum() and object_class_property_add_enum()
functions along with their EnumProperty struct and property_get_enum /
property_set_enum helpers.

Simplify object_property_get_enum() to assert on qapi_type rather than
falling back to the old EnumProperty opaque data.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 45 ++--------------------------
 qom/object.c         | 82 ++--------------------------------------------------
 2 files changed, 4 insertions(+), 123 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 29cbd84b8d03..a9bbc44cfcc9 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1697,12 +1697,12 @@ char *object_get_canonical_path(const Object *obj);
  *   because it was ambiguous, or %NULL. Set to %false on success.
  *
  * There are two types of supported paths--absolute paths and partial paths.
- * 
+ *
  * Absolute paths are derived from the root object and can follow child<> or
  * link<> properties.  Since they can follow link<> properties, they can be
  * arbitrarily long.  Absolute paths look like absolute filenames and are
  * prefixed with a leading slash.
- * 
+ *
  * Partial paths look like relative filenames.  They do not begin with a
  * prefix.  The matching rules for partial paths are subtle but designed to make
  * specifying objects easy.  At each level of the composition tree, the partial
@@ -1986,47 +1986,6 @@ ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
                                     bool (*get)(Object *, Error **),
                                     void (*set)(Object *, bool, Error **));
 
-/**
- * object_property_add_enum:
- * @obj: the object to add a property to
- * @name: the name of the property
- * @typename: the name of the enum data type
- * @lookup: enum value namelookup table
- * @get: the getter or %NULL if the property is write-only.
- * @set: the setter or %NULL if the property is read-only
- *
- * Add an enum property using getters/setters.  This function will add a
- * property of type '@typename'.
- *
- * Returns: The newly added property on success, or %NULL on failure.
- */
-ObjectProperty *object_property_add_enum(Object *obj, const char *name,
-                              const char *typename,
-                              const QEnumLookup *lookup,
-                              int (*get)(Object *, Error **),
-                              void (*set)(Object *, int, Error **));
-
-/**
- * object_class_property_add_enum:
- * @klass: the object class to add a property to
- * @name: the name of the property
- * @typename: the name of the enum data type
- * @lookup: enum value namelookup table
- * @get: the getter or %NULL if the property is write-only.
- * @set: the setter or %NULL if the property is read-only
- *
- * Add an enum property using getters/setters.  This function will add a
- * property of type '@typename'.
- *
- * Returns: The newly added property on success, or %NULL on failure.
- */
-ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
-                                    const char *name,
-                                    const char *typename,
-                                    const QEnumLookup *lookup,
-                                    int (*get)(Object *, Error **),
-                                    void (*set)(Object *, int, Error **));
-
 /**
  * struct QapiEnumProp: Descriptor for a property backed by a QAPI enum type
  *
diff --git a/qom/object.c b/qom/object.c
index cf18880c6c0c..791d981dc689 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1774,12 +1774,6 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
     return retval;
 }
 
-typedef struct EnumProperty {
-    const QEnumLookup *lookup;
-    int (*get)(Object *, Error **);
-    void (*set)(Object *, int, Error **);
-} EnumProperty;
-
 int object_property_get_enum(Object *obj, const char *name,
                              const char *typename, Error **errp)
 {
@@ -1803,12 +1797,8 @@ int object_property_get_enum(Object *obj, const char *name,
         return -1;
     }
 
-    if (prop->qapi_type) {
-        ret = qapi_enum_parse(prop->qapi_type->lookup, str, -1, errp);
-    } else {
-        EnumProperty *enumprop = prop->opaque;
-        ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
-    }
+    assert(prop->qapi_type);
+    ret = qapi_enum_parse(prop->qapi_type->lookup, str, -1, errp);
     g_free(str);
 
     return ret;
@@ -2543,74 +2533,6 @@ object_class_property_add_bool(ObjectClass *klass, const char *name,
                                      prop);
 }
 
-static void property_get_enum(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    EnumProperty *prop = opaque;
-    int value;
-    Error *err = NULL;
-
-    value = prop->get(obj, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
-    visit_type_enum(v, name, &value, prop->lookup, errp);
-}
-
-static void property_set_enum(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    EnumProperty *prop = opaque;
-    int value;
-
-    if (!visit_type_enum(v, name, &value, prop->lookup, errp)) {
-        return;
-    }
-    prop->set(obj, value, errp);
-}
-
-ObjectProperty *
-object_property_add_enum(Object *obj, const char *name,
-                         const char *typename,
-                         const QEnumLookup *lookup,
-                         int (*get)(Object *, Error **),
-                         void (*set)(Object *, int, Error **))
-{
-    EnumProperty *prop = g_malloc(sizeof(*prop));
-
-    prop->lookup = lookup;
-    prop->get = get;
-    prop->set = set;
-
-    return object_property_add(obj, name, typename,
-                               get ? property_get_enum : NULL,
-                               set ? property_set_enum : NULL,
-                               property_release_data,
-                               prop);
-}
-
-ObjectProperty *
-object_class_property_add_enum(ObjectClass *klass, const char *name,
-                                    const char *typename,
-                                    const QEnumLookup *lookup,
-                                    int (*get)(Object *, Error **),
-                                    void (*set)(Object *, int, Error **))
-{
-    EnumProperty *prop = g_malloc(sizeof(*prop));
-
-    prop->lookup = lookup;
-    prop->get = get;
-    prop->set = set;
-
-    return object_class_property_add(klass, name, typename,
-                                     get ? property_get_enum : NULL,
-                                     set ? property_set_enum : NULL,
-                                     NULL,
-                                     prop);
-}
-
 static void get_qapi_enum(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {

-- 
2.56.0.116.g6de20f6092dc

