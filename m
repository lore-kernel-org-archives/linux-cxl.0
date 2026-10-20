Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493286;
	b=WayZmDIUzUiUXV4NPTVWfbtDJ6K2TRrqcY9tbIuxT1Yx8rPf9qo9/V9gyRCbEZKVFa5F
	 6+LWNYYHqbnFaFDwOkYN0oqzxVs8L3dT1PYKJiG0kI90QfUwhFFkKLIQxEWcouhroUKku
	 Xxj6SzrajZzVtgfoLltl+ckVsLZg2DEbH0AGcmwNtkpXWoln//21vGeJ+ZCnWfWOaLtqL
	 ekdEgxL7imVfwyUwyjM+WXa1qzDN6Q/eGRVxVdH1WckYbCZzePSekWXiJkI3jlJ36Tvo/
	 9K2G2HEJ9zQeHdk18NmCCmd0Pl06BkguXlXIewElKm7sexPs2V2GmuLCHv8SibyHNYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493286;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=VhnuP9GUFWkUKVrWiyyQ4TwAPJA5jCWzmPwQlY7WHrg=;
	b=k4TxEYjJ82EWKtRGVRyLLgWou/wO+6o7Xbci6mtYrVA6bl79hhn4O4r6mthXj0aHyYYG
	 NKi4KcfX8/Hg2o0uhlCWPFxl+385zJKO6kNujS7oYiPgjfhxhI2kZ7eVaPxEzlRGx6Gll
	 MPal+dKv+eMAUsD+bczVtujNO1a92rG6Ly9+i5sV2GUyBaqbwsuPev6DGFS2xXV1XBKEl
	 estR+H2ZT0Zzz6XGUpxHKXy/YyUGtl1W3yM9DJH80QEfxXq8wtHradd/0VtjUsXTwaF0m
	 9Z4Ffk5axW6yaLOMgzv2pyAdD2N2eRVuRP+fH6zW971Jrw63uJWrVL73/LA1tijD7oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=if9HlzBN;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3E606A31D
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBF3E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=if9HlzBN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VhnuP9GUFWkUKVrWiyyQ4TwAPJA5jCWzmPwQlY7WHrg=;
	b=if9HlzBNKeHYQloilpcZZcciTW66M25xfz7eQ3zmif7cST1GxqnoVf5ifydDELsT2DuPO5
	xT0ADbjWc3TFa/rRdFvclFDEcoXlEGvUI5LG7Z5R2cacADxvpVkHxZrrm1Ed+vVeNM1Ffm
	qfxzfD7SSX22oR09GT6PThp7Tfzx/i8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-X4ttvQKTOGG9YvCqjtTwwQ-1; Tue,
 20 Oct 2026 10:48:00 +0000
X-MC-Unique: X4ttvQKTOGG9YvCqjtTwwQ-1
X-Mimecast-MFC-AGG-ID: X4ttvQKTOGG9YvCqjtTwwQ_1792493277
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11DD51802573;
	Tue, 20 Oct 2026 10:47:57 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8CE561800444;
	Tue, 20 Oct 2026 10:47:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:36 +0400
Subject: [PATCH v7 19/65] qom: convert QAPI enum properties to QAPI-aware
 registration
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-19-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=17948;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6HmJUS8ti31K3a3a2qrKIDTAV1LxUYYBxrUY2iMoiRk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZZPwxGnXSq4QWDKEGgMqYI/Z8qJ2n4E63t1
 CAug9EBmVyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWQAKCRDa6OEJdZac
 5RHYD/0VR6RzZzElo//CjihnI3BcxT2JM6duKVAvqwMTKrGjqQtVIr3yVB0WUDpv88WeJIFdg0g
 K44rtv1wBk3k27wWQHYXY7c7JCopqGlklnoCl86FeoYYYtNUsZPVs9q0ULFWIGI4Tqp9X1F3SN4
 dbjLnZ1Ds0GY7fjQa/rXmv1xBN/ahVlo1NQKDWaeCSJwkAUBJwZiQQ736DUVGC/tvtwX84EN9Lj
 tzSSsfMTBvx8cfQd8cXEIO6dhfddIinGu4eywL3AK9pJrNpx6dC5Dnam87ouxnsCWLlA+6dFsLe
 2Bdmci2g1kcW2nSWb7I9o9TCiM/vYwjLeUAqn7U/0L3UQ8bGN7FSEWEVuyu1zZ5cMJK9629XRc3
 4Y/qFNn34AbWMmCBopkJp/i6yYUt2EfML+gU2n9Bk+HcR+bjmDaQQYN7HtB0Gtgy9+XmlJXrvMP
 bkXFMpwWuoCn1YI6Bva6xjA/IWMdU/ZWW3UtIEZPXG8WkIw38aJVQormQ3+2lWqXnL94+ZMpScV
 kW49h/CEZOyzQQD21DXh7geRV1HjhOnTlfIUNdehs+faDS+daQfvUFXcgFyCeq7y+3TDtO1xakH
 yHL8HFJRXqWCOyvHMBUDfw0xmYBnia9NugUUUqNrAEMaAvPgcg6yI34b2O1h2KaPpyFe5IVMSAA
 p5e/RxCRFKHbH2Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: trTNBgOi7KCVgoPBGjyatAs8oCizfUM_dhzQq1MCYBA_1792493277
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Convert all callers of object_class_property_add_enum() but one to use
the new object_class_property_add_qapi_enum() with the
QAPI_ENUM_PROP() macro, which provides type information via
QAPITypeInfo instead of raw lookup tables and string type names.

This enables QMP QOM introspection to report accurate QAPI type names
for enum properties. Where a separate set_description call was used,
the description is now embedded in the QAPI_ENUM_PROP initializer.

Leave pc_i440fx_machine_options() for later, because enum
PCSouthBridgeOption is a handmade QAPI-like enum instead of a real
one.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 authz/list.c                             | 12 +++++++-----
 backends/hostmem.c                       | 14 ++++++++------
 crypto/secret_common.c                   | 12 +++++++-----
 crypto/tlscreds.c                        | 12 +++++++-----
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 19 +++++++++++--------
 include/chardev/char.h                   |  8 --------
 monitor/qmp.c                            | 12 +++++++-----
 net/filter.c                             | 10 +++++++---
 target/i386/kvm/kvm.c                    | 30 +++++++++++++++++-------------
 ui/console-vc.c                          |  8 +++++++-
 ui/dbus.c                                | 18 ++++++++++++++----
 ui/input-linux.c                         | 11 +++++++----
 12 files changed, 99 insertions(+), 67 deletions(-)

diff --git a/authz/list.c b/authz/list.c
index 17aa0efd80e8..363b2ee12c98 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -22,6 +22,7 @@
 #include "authz/list.h"
 #include "trace.h"
 #include "qom/object_interfaces.h"
+#include "qapi/qapi-type-infos-authz.h"
 #include "qapi/qapi-visit-authz.h"
 #include "qemu/module.h"
 
@@ -120,11 +121,12 @@ qauthz_list_class_init(ObjectClass *oc, const void *data)
 {
     QAuthZClass *authz = QAUTHZ_CLASS(oc);
 
-    object_class_property_add_enum(oc, "policy",
-                                   "QAuthZListPolicy",
-                                   &QAuthZListPolicy_lookup,
-                                   qauthz_list_prop_get_policy,
-                                   qauthz_list_prop_set_policy);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "policy",
+        .qapi_type = &QAuthZListPolicy_type_info,
+        .get = qauthz_list_prop_get_policy,
+        .set = qauthz_list_prop_set_policy,
+    ));
 
     object_class_property_add(oc, "rules", "QAuthZListRule",
                               qauthz_list_prop_get_rules,
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 8782c8b1ea98..edb8e6ab4502 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -16,6 +16,7 @@
 #include "hw/core/boards.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
 #include "qom/compat-properties.h"
@@ -551,12 +552,13 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "host-nodes",
         "Binds memory to the list of NUMA host nodes");
-    object_class_property_add_enum(oc, "policy", "HostMemPolicy",
-        &HostMemPolicy_lookup,
-        host_memory_backend_get_policy,
-        host_memory_backend_set_policy);
-    object_class_property_set_description(oc, "policy",
-        "Set the NUMA policy");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "policy",
+        .description = "Set the NUMA policy",
+        .qapi_type = &HostMemPolicy_type_info,
+        .get = host_memory_backend_get_policy,
+        .set = host_memory_backend_set_policy,
+    ));
     object_class_property_add_bool(oc, "share",
         host_memory_backend_get_share, host_memory_backend_set_share);
     object_class_property_set_description(oc, "share",
diff --git a/crypto/secret_common.c b/crypto/secret_common.c
index a5ecb876aeba..381d23ecc8e0 100644
--- a/crypto/secret_common.c
+++ b/crypto/secret_common.c
@@ -22,6 +22,7 @@
 #include "crypto/secret_common.h"
 #include "crypto/cipher.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-crypto.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
 #include "qemu/module.h"
@@ -269,11 +270,12 @@ qcrypto_secret_class_init(ObjectClass *oc, const void *data)
 
     ucc->complete = qcrypto_secret_complete;
 
-    object_class_property_add_enum(oc, "format",
-                                   "QCryptoSecretFormat",
-                                   &QCryptoSecretFormat_lookup,
-                                   qcrypto_secret_prop_get_format,
-                                   qcrypto_secret_prop_set_format);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "format",
+        .qapi_type = &QCryptoSecretFormat_type_info,
+        .get = qcrypto_secret_prop_get_format,
+        .set = qcrypto_secret_prop_set_format,
+    ));
     object_class_property_add_str(oc, "keyid",
                                   qcrypto_secret_prop_get_keyid,
                                   qcrypto_secret_prop_set_keyid);
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index fb09e295a65c..54859720bf74 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-crypto.h"
 #include "qapi-types-crypto.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
@@ -221,11 +222,12 @@ qcrypto_tls_creds_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "dir",
                                   qcrypto_tls_creds_prop_get_dir,
                                   qcrypto_tls_creds_prop_set_dir);
-    object_class_property_add_enum(oc, "endpoint",
-                                   "QCryptoTLSCredsEndpoint",
-                                   &QCryptoTLSCredsEndpoint_lookup,
-                                   qcrypto_tls_creds_prop_get_endpoint,
-                                   qcrypto_tls_creds_prop_set_endpoint);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "endpoint",
+        .qapi_type = &QCryptoTLSCredsEndpoint_type_info,
+        .get = qcrypto_tls_creds_prop_get_endpoint,
+        .set = qcrypto_tls_creds_prop_set_endpoint,
+    ));
     object_class_property_add_str(oc, "priority",
                                   qcrypto_tls_creds_prop_get_priority,
                                   qcrypto_tls_creds_prop_set_priority);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c5f64319009b..9a8fcc667812 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -27,6 +27,7 @@
 #include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "target/microblaze/cpu.h"
 #include "hw/core/sysbus.h"
 #include "net/net.h"
@@ -174,14 +175,16 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
     mc->init = petalogix_s3adsp1800_init;
     mc->is_default = true;
 
-    prop = object_class_property_add_enum(oc, "endianness", "EndianMode",
-                                          &EndianMode_lookup,
-                                          machine_get_endianness,
-                                          machine_set_endianness);
-    object_property_set_default_str(prop, target_big_endian() ? "big"
-                                                              : "little");
-    object_class_property_set_description(oc, "endianness",
-            "Defines whether the machine runs in big or little endian mode");
+    prop = object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "endianness",
+        .description =
+            "Defines whether the machine runs in big or little endian mode",
+        .qapi_type = &EndianMode_type_info,
+        .get = machine_get_endianness,
+        .set = machine_set_endianness,
+    ));
+    object_property_set_default_enum(prop,
+        target_big_endian() ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE);
 }
 
 static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 2616c19cc095..21bf85d197eb 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -352,12 +352,4 @@ static void set_encoding(Object *obj, int value, Error **errp)  \
     cast_func(obj)->encoding = value;                           \
 }
 
-static inline void chardev_vc_add_encoding_prop(ObjectClass *oc,
-    int (*get)(Object *, Error **),
-    void (*set)(Object *, int, Error **))
-{
-    object_class_property_add_enum(oc, "encoding", "ChardevVCEncoding",
-                                   &ChardevVCEncoding_lookup, get, set);
-}
-
 #endif
diff --git a/monitor/qmp.c b/monitor/qmp.c
index eb44012643f6..c2849214d58b 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -30,6 +30,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-char.h"
+#include "qapi/qapi-type-infos-qom.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
@@ -133,11 +134,12 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
     object_class_property_add_bool(cls, "pretty",
                                    monitor_qmp_get_pretty,
                                    monitor_qmp_set_pretty);
-    object_class_property_add_enum(cls, "close-action",
-                                   "MonitorQMPCloseAction",
-                                   &MonitorQMPCloseAction_lookup,
-                                   monitor_qmp_get_close_action,
-                                   monitor_qmp_set_close_action);
+    object_class_property_add_qapi_enum(cls, QAPI_ENUM_PROP(
+        .name = "close-action",
+        .qapi_type = &MonitorQMPCloseAction_type_info,
+        .get = monitor_qmp_get_close_action,
+        .set = monitor_qmp_set_close_action,
+    ));
 
     moncls->emit_event = monitor_qmp_emit_event;
     moncls->requires_iothread = monitor_qmp_requires_iothread;
diff --git a/net/filter.c b/net/filter.c
index 389f3b0bfefb..79883af22a54 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 
@@ -342,9 +343,12 @@ static void netfilter_class_init(ObjectClass *oc, const void *data)
 
     object_class_property_add_str(oc, "netdev",
                                   netfilter_get_netdev_id, netfilter_set_netdev_id);
-    object_class_property_add_enum(oc, "queue", "NetFilterDirection",
-                                   &NetFilterDirection_lookup,
-                                   netfilter_get_direction, netfilter_set_direction);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "queue",
+        .qapi_type = &NetFilterDirection_type_info,
+        .get = netfilter_get_direction,
+        .set = netfilter_set_direction,
+    ));
     object_class_property_add_str(oc, "status",
                                   netfilter_get_status, netfilter_set_status);
     object_class_property_add_str(oc, "position",
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index da922f72d71e..f2e8dc8c156d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -14,6 +14,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/qapi-events-run-state.h"
+#include "qapi/qapi-type-infos-common.h"
+#include "qapi/qapi-type-infos-run-state.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include <math.h>
@@ -7089,12 +7091,13 @@ static void kvm_arch_set_honor_guest_pat(Object *obj, int value, Error **errp)
 
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
-    object_class_property_add_enum(oc, "notify-vmexit", "NotifyVMexitOption",
-                                   &NotifyVmexitOption_lookup,
-                                   kvm_arch_get_notify_vmexit,
-                                   kvm_arch_set_notify_vmexit);
-    object_class_property_set_description(oc, "notify-vmexit",
-                                          "Enable notify VM exit");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "notify-vmexit",
+        .description = "Enable notify VM exit",
+        .qapi_type = &NotifyVmexitOption_type_info,
+        .get = kvm_arch_get_notify_vmexit,
+        .set = kvm_arch_set_notify_vmexit,
+    ));
 
     object_class_property_add(oc, "notify-window", "uint32",
                               kvm_arch_get_notify_window,
@@ -7127,13 +7130,14 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
     object_class_property_set_description(oc, "xen-evtchn-max-pirq",
                                           "Maximum number of Xen PIRQs");
 
-    object_class_property_add_enum(oc, "honor-guest-pat", "OnOffAuto",
-                                   &OnOffAuto_lookup,
-                                   kvm_arch_get_honor_guest_pat,
-                                   kvm_arch_set_honor_guest_pat);
-    object_class_property_set_description(oc, "honor-guest-pat",
-                                          "Disable KVM quirk that ignores guest PAT "
-                                          "memory type settings (default: auto)");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "honor-guest-pat",
+        .description = "Disable KVM quirk that ignores guest PAT "
+                       "memory type settings (default: auto)",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = kvm_arch_get_honor_guest_pat,
+        .set = kvm_arch_set_honor_guest_pat,
+    ));
 }
 
 void kvm_set_max_apic_id(uint32_t max_apic_id)
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 99cc8f09c887..cca4790c993c 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -6,6 +6,7 @@
 
 #include "chardev/char.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-char.h"
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qom/compat-properties.h"
@@ -326,7 +327,12 @@ static void char_vc_class_init(ObjectClass *oc, const void *data)
     cc->supports_size_opts = true;
     cc->supports_encoding_opts = true;
 
-    chardev_vc_add_encoding_prop(oc, get_encoding, set_encoding);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "encoding",
+        .qapi_type = &ChardevVCEncoding_type_info,
+        .get = get_encoding,
+        .set = set_encoding,
+    ));
 }
 
 static void char_vc_init(Object *obj)
diff --git a/ui/dbus.c b/ui/dbus.c
index 7be0f8e26119..afc321514c68 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -38,6 +38,8 @@
 #include "qemu/audio.h"
 #include "audio/audio_int.h" /* FIXME: use QOM dynamic cast instead of drv->name */
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-char.h"
+#include "qapi/qapi-type-infos-ui.h"
 #include "trace.h"
 
 #include "dbus.h"
@@ -508,9 +510,12 @@ dbus_display_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "p2p", get_dbus_p2p, set_dbus_p2p);
     object_class_property_add_str(oc, "addr", get_dbus_addr, set_dbus_addr);
     object_class_property_add_str(oc, "audiodev", get_audiodev, set_audiodev);
-    object_class_property_add_enum(oc, "gl-mode",
-                                   "DisplayGLMode", &DisplayGLMode_lookup,
-                                   get_gl_mode, set_gl_mode);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "gl-mode",
+        .qapi_type = &DisplayGLMode_type_info,
+        .get = get_gl_mode,
+        .set = set_gl_mode,
+    ));
 }
 
 #define TYPE_CHARDEV_VC "chardev-vc"
@@ -602,7 +607,12 @@ dbus_vc_class_init(ObjectClass *oc, const void *data)
     cc->chr_open = dbus_vc_open;
     cc->supports_encoding_opts = true;
 
-    chardev_vc_add_encoding_prop(oc, get_encoding, set_encoding);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "encoding",
+        .qapi_type = &ChardevVCEncoding_type_info,
+        .get = get_encoding,
+        .set = set_encoding,
+    ));
 }
 
 static void
diff --git a/ui/input-linux.c b/ui/input-linux.c
index f4eee1ffd7ec..715d1f589297 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -6,6 +6,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qemu/config-file.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -506,10 +507,12 @@ static void input_linux_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "repeat",
                                    input_linux_get_repeat,
                                    input_linux_set_repeat);
-    object_class_property_add_enum(oc, "grab-toggle", "GrabToggleKeys",
-                                   &GrabToggleKeys_lookup,
-                                   input_linux_get_grab_toggle,
-                                   input_linux_set_grab_toggle);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "grab-toggle",
+        .qapi_type = &GrabToggleKeys_type_info,
+        .get = input_linux_get_grab_toggle,
+        .set = input_linux_set_grab_toggle,
+    ));
 }
 
 static const TypeInfo input_linux_info = {

-- 
2.56.0.116.g6de20f6092dc

