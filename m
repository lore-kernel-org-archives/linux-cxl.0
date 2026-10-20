Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493273;
	b=n9jc9ZxdrX6SRF5+YHPUZEVthu09Nt71+HG8a16lHDaEjyO+IwUmFMoEcsoaHPsdRS/u
	 GYXTZrODdG26LqjosOH++hXoFv+CnMtJRV5IcSYbdvDb18DX/GDvnbZlBiAO3iyExaqa8
	 oE76lkTRDhcoMBxcGiGsqkIIyOAg1+GHZrlp82yhaAfTwRWhaR9qIPxS8pOAd7idUaYX6
	 3SR0iTcPJ1pXmd1oT71MhsrMoeXJ0dK8c5SMoEhY+IQF/m/LoNPPgxOxxCakutsfp8R+N
	 f8YOsBueOGMUGaA5GdH8pxrbv4OKQ9D6EAprcAZTtsRc5LMlWtH15S6x7ydKmY8rmQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493273;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=w3CoU0QuGNI+p7I3jy6WGQ0mlfEWpp4sXXt2/m2QXAI=;
	b=0JdvrQ690jDw3JIBNgBQG9Li5QPZTYsPYU0ACAB/owwnFUjJxUPRdAxQP+66xlqMohcp
	 Mpp/SjnzhvbHjhBUn8/tZPWOTJnxuLzIZPE/cso78ozndg5XMyVDaaV4SHhMY3FLI2xot
	 OKuuVhJ7ZFEsWFmR2FbLULgTz3YdVrtkvIoPupBSU6XlpEb2biPleLXT3t8LS6X40l7SS
	 n1H9EYGz4ue6Q6+KNt/UV1I4iPdMJeXXQL0P0fmajPBSMrbJynA/fDYPrqc6VXnLDNTGM
	 35bBdFh7xxYeWOhpGVMg7mj966UnogNCgIOMGL8Cyhk7717+d18ByVpfLaiiiNkNu4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h6QbXwHw;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023E606A326
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1023E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h6QbXwHw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3CoU0QuGNI+p7I3jy6WGQ0mlfEWpp4sXXt2/m2QXAI=;
	b=h6QbXwHwhTdcxDOPamD9S1CDMKpTWtwbROt/SmEJXK+jcB5jYO648i9gQ1Asn9F7a11lki
	nnmHftL01bnAdZHW3Eh1R0MGpwa0jqMEaDsL42A+j+8jcZsZoP2oDBWNFkBTfD7D1XnJP2
	LlqmPwZzbNeL9gJZlwKBR9LUq4MZaDc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-qnN94N6QPK2vA93ceMbHjQ-1; Tue,
 20 Oct 2026 10:47:46 +0000
X-MC-Unique: qnN94N6QPK2vA93ceMbHjQ-1
X-Mimecast-MFC-AGG-ID: qnN94N6QPK2vA93ceMbHjQ_1792493261
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9161F1955F02;
	Tue, 20 Oct 2026 10:47:41 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15EC75BC;
	Tue, 20 Oct 2026 10:47:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:33 +0400
Subject: [PATCH v7 16/65] qom: add object_{class_}property_add_qapi
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-16-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4847;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Kq06N3iO6F8AhEf3w27s03u+jnvcQuJjGRRe4Zmd+Hw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZYIBdWrkS5tz+9/UTddwYES8EXuUjGwwr7o
 DY/JyPpfPaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWAAKCRDa6OEJdZac
 5YwTEACxwwoxioLPKJmAISYmT8CzcjaWz6/mg9O/RdNTtr/Qe5SgKfnNgHmYpowIFXzfKxXxVk0
 B1ORjczYVaJ2+0sEYatt98MR4cL6Hv6jxJmuNPVhuZm/dGP4xT8zjDnqPWrzyhuGDnRW314fM0G
 cs/+K/C+Nwe2hpLMybC8gw/whDhlPfHu8KTvLEBX5v7tKzgP6D7PedIBYWNwqFSmpuO0PlQuMHR
 vN33ahh98LvZbfbEhdgO2kdICQMa0DUZEF3ng3OASLe7+t8JVNn+KdmUEBihcL1bJKaAVpj30Xa
 akndT9MZhwYvZw095fcPoxfNhNpNXbRLhzvdGBMkE2j3b8DxfYnc+JFviLUfeaEL/RnpAHO/io7
 w903ZGKDrm8kPlKsMwWsMLrWGdPLR5Kc5NsiK0+s+/lExqWl6WXGAKpJ1XWiI9SvSRFr+pT8sRG
 YQnTqX+5yjvMZjHUf8jZ5kJOLYZxU/73vOGIBhxLDvlVywwQz+b5C3azNqGdFSLYqf+PbAJiruh
 g7uaTSrEABrr0xm+UN5VZL/yxAJEyP0wzq4K8tg3ZRfb9EeYCKYxoaRTQnBz5hWjPVnJbnUqt4X
 lIR0HJed6Cwk5m/Qb1NAZshRIkE3JTkSJUbwmlB1M99oPiceyZi0qG1emOPy0nq/lenfk9B+FRX
 AIGs9zGqOul8NUQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 7cx6RzZYHvt6BAnqv_NEP8XDZCy7QywUuXeXt56doaI_1792493261
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 qom/object.c         | 32 ++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 2a5723c555e9..eb61d8842b80 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2027,6 +2027,61 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **));
 
+/**
+ * object_property_add_qapi:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @qapi_type: QAPI type info descriptor
+ * @get: The getter to be called to read a property.  If this is NULL, then
+ *   the property cannot be read.
+ * @set: the setter to be called to write a property.  If this is NULL,
+ *   then the property cannot be written.
+ * @release: called when the property is removed from the object.  This is
+ *   meant to allow a property to free its opaque upon object
+ *   destruction.  This may be NULL.
+ * @opaque: an opaque pointer to pass to the callbacks for the property
+ *
+ * Add a property with a QAPI type association. The property type name
+ * is derived from @qapi_type->name.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_property_add_qapi(Object *obj, const char *name,
+                         const QAPITypeInfo *qapi_type,
+                         ObjectPropertyAccessor *get,
+                         ObjectPropertyAccessor *set,
+                         ObjectPropertyRelease *release,
+                         void *opaque);
+
+/**
+ * object_class_property_add_qapi:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @qapi_type: QAPI type info descriptor
+ * @get: The getter to be called to read a property.  If this is NULL, then
+ *   the property cannot be read.
+ * @set: the setter to be called to write a property.  If this is NULL,
+ *   then the property cannot be written.
+ * @release: called when the property is removed from the object.  This is
+ *   meant to allow a property to free its opaque upon object
+ *   destruction.  This may be NULL.
+ * @opaque: an opaque pointer to pass to the callbacks for the property
+ *
+ * Add a property with a QAPI type association. The property type name
+ * is derived from @qapi_type->name.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_class_property_add_qapi(ObjectClass *klass,
+                               const char *name,
+                               const QAPITypeInfo *qapi_type,
+                               ObjectPropertyAccessor *get,
+                               ObjectPropertyAccessor *set,
+                               ObjectPropertyRelease *release,
+                               void *opaque);
+
 /**
  * object_property_add_tm:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index 1d09315b328b..bebbfc43556d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2609,6 +2609,38 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
                                      prop);
 }
 
+ObjectProperty *
+object_property_add_qapi(Object *obj, const char *name,
+                         const QAPITypeInfo *qapi_type,
+                         ObjectPropertyAccessor *get,
+                         ObjectPropertyAccessor *set,
+                         ObjectPropertyRelease *release,
+                         void *opaque)
+{
+    ObjectProperty *prop;
+
+    prop = object_property_add(obj, name, qapi_type->name,
+                               get, set, release, opaque);
+    prop->qapi_type = qapi_type;
+    return prop;
+}
+
+ObjectProperty *
+object_class_property_add_qapi(ObjectClass *klass, const char *name,
+                               const QAPITypeInfo *qapi_type,
+                               ObjectPropertyAccessor *get,
+                               ObjectPropertyAccessor *set,
+                               ObjectPropertyRelease *release,
+                               void *opaque)
+{
+    ObjectProperty *prop;
+
+    prop = object_class_property_add(klass, name, qapi_type->name,
+                                     get, set, release, opaque);
+    prop->qapi_type = qapi_type;
+    return prop;
+}
+
 typedef struct TMProperty {
     void (*get)(Object *, struct tm *, Error **);
 } TMProperty;

-- 
2.56.0.116.g6de20f6092dc

