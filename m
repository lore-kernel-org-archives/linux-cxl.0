Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493300;
	b=C8VVAtFR/x5SgGqDepOx8jw0g1A72X4d9tn1gktGL9KXucpvn5niMVspJRob0B+U2o2X
	 xWnILiLJ2VHsM2a5FRnSlqf/jir77x/RALRL3ECQ//s7X0eMSQiROWosqDSTe5nOC2kix
	 01LUPzlBlRNNcJVr36eRbKlA+r+HleooNjOtp3S6+l65UT3XxXITTBzYoc+l6p1I0KXPn
	 QNthh1SVrANzeG7Um6ExXUc/BZVWlFLmKjXll6vY0y+WteuXS+pK8ZlY6W80Kw+zezLo7
	 ta5PJhvs9gntV4JHIyTr5wjQuoLH+APaDIWGBtP88TRQ9oAQMzYNHcFaoN/uPMGqX6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493300;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=Vp5ZhrZ42bWj3S549eW3vIVawiZYq0pfGezhyH5wDcg=;
	b=o+XfDe5jLI+tSV9+0ItbyxCukjEFVd391p593wK13yccJVjgytH1MSX95rOyIAwJlxUC
	 2aZNKFJSbWw7V2kww5VB9ve5JuaAl6Y51ZC6u1BS+fBhvoVhJuC32Dxx0Xaaem2Rfl5d0
	 YPFimcAeRSTbZu5gzY6pMmA1w1SOtQjeP++hATdZhF2wjamBuWxLWtHMQGQRV4P2Zk/JZ
	 cwNVk8L8g3bTA/NoZAxZFYnhouQXkg4/BSfnp37QUSJ832IHyUcVW23If1VzQh2FB1Kci
	 vMl4inBRc3ES64js2JnC/VRiGsK2CiPuffK4TUJO48tS15STz7JseFZs6pokP0B67HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YZF4ux0O;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43193606A33D
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43193606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YZF4ux0O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp5ZhrZ42bWj3S549eW3vIVawiZYq0pfGezhyH5wDcg=;
	b=YZF4ux0OKMtT1jRFmHLCvXL3koIXg1SXPI+0HdoBl8Q1NzgYCtZlDL/lLHf3rTel6P350F
	tX6d+Jm4h/V71CvnfqPTZz2/j8JBj0vDl0QubEgiVbKvgNAqE27SnrdbfdmZ/7ejh/X88P
	AHpWzAMnzMQnS150UIsdGrYNgu/OzOc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-JzE2Aw8dO7qEs2TC0tJQ1g-1; Tue,
 20 Oct 2026 10:48:07 +0000
X-MC-Unique: JzE2Aw8dO7qEs2TC0tJQ1g-1
X-Mimecast-MFC-AGG-ID: JzE2Aw8dO7qEs2TC0tJQ1g_1792493283
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3D2518005BC;
	Tue, 20 Oct 2026 10:48:02 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA4BE1956041;
	Tue, 20 Oct 2026 10:47:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:37 +0400
Subject: [PATCH v7 20/65] qom: convert struct properties to QAPI-aware
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
Message-Id: <20261020-qom-qapi-v7-20-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12148;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eg+SxgTFJgIB4Yau2dF+w/HtN0glmjOwr1JI4WkR+8g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZZQGFK/ZN3udAc6CNCpipD4AhiQQoJIGozU
 /UDWSaFQtOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWQAKCRDa6OEJdZac
 5RtTD/4kY/PNza23E86wJfF/fcJzESsEo8MEy/VqKsja5Oehs0XOVVUYFNHeM3Hoz1tn0t6gfEB
 gEdZ6/dJUGUJsPT0Dj0TYlXOOC8uD6Zvml9ph4IssmkkoEVdOYCBEEh67ckdRLA+NhNogviRDgz
 pCf2Zf7wUKqc1WkJF7sDNgP2H346XFj5MJrvHYj+nchuXlLLJoJ2p8HRttnZVit3Bdcc8EVPLeq
 AiHdKE812PiIqx1KWVmo/AZD0Lve7bA8x3s9o2bXTj/C5WfXxaruFK1SEfvzwTSqS+eDZQa+9fR
 7myj8VpQE8yMn4VkxlzMrQIdY3RLVol5dLbJqyOXixRGS7tup1ZTrthFFukzQ+JCIscmo0IFAzV
 5Si0D6bITCS6Tuut/xCbHDT8PSneeFZ0cWij9WWp5dAB/MsZaiDjGU6VMM1DQbYxVVuPSDXujjZ
 TWfeG0zqk2YrLWTnqGDFDYN8sWFPB7hVAyu+5Z0C6WsRhAW6yJvDeRVFo09jibHvtdFtdDs6rZl
 TpG4qpJJgjL9ZoJid62lKL1oqVwWecyUyjvka9DVriGfw5BrWPlNKx6/zMNe82tz/yXa4413sCM
 /wmN+rl/byVmDvaAb/tgK1r7TXAwbPeuTuY/7eZ/wdgx3JWRblmU8A4iQI4d152HVQpmQjZ/jgZ
 aNhHsQ21q2Xo4hw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: gIlc6uKfiCwW30H3bF3pKVHenfprKNJcFNqyfdHoFo0_1792493283
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Convert all callers of object_property_add() and
object_class_property_add() that register struct-typed properties with
QAPI visitor-based getters/setters to use object_property_add_qapi() and
object_class_property_add_qapi() instead.

This replaces the manual string type name with a reference to the
generated QAPITypeInfo constant, enabling QMP introspection to report
accurate QAPI type information for struct properties. Existing
getters/setters are preserved unchanged.

The cxl-fmw property type is corrected from "CXLFixedMemoryWindow"
(not a real QAPI type) to "CXLFixedMemoryWindowOptionsList", along with
other mis-typed list properties.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 authz/list.c              |  2 +-
 block/throttle-groups.c   |  5 +++--
 chardev/char-socket.c     |  3 ++-
 hw/core/machine.c         | 11 +++++++----
 hw/cxl/cxl-host.c         |  4 +++-
 hw/remote/vfio-user-obj.c |  5 +++--
 hw/vfio-user/pci.c        |  5 +++--
 target/i386/cpu.c         | 11 ++++++++---
 target/i386/kvm/tdx.c     |  4 +++-
 target/s390x/cpu-system.c |  4 +++-
 10 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/authz/list.c b/authz/list.c
index 363b2ee12c98..3efbe1fa1687 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -128,7 +128,7 @@ qauthz_list_class_init(ObjectClass *oc, const void *data)
         .set = qauthz_list_prop_set_policy,
     ));
 
-    object_class_property_add(oc, "rules", "QAuthZListRule",
+    object_class_property_add_qapi(oc, "rules", &QAuthZListRuleList_type_info,
                               qauthz_list_prop_get_rules,
                               qauthz_list_prop_set_rules,
                               NULL, NULL);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 37814b84fe09..987867477acc 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -31,6 +31,7 @@
 #include "qemu/thread.h"
 #include "system/qtest.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-block-core.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
@@ -993,8 +994,8 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
     }
 
     /* ThrottleLimits */
-    object_class_property_add(klass,
-                              "limits", "ThrottleLimits",
+    object_class_property_add_qapi(klass,
+                              "limits", &ThrottleLimits_type_info,
                               throttle_group_get_limits,
                               throttle_group_set_limits,
                               NULL, NULL);
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 81bac42a1587..8e0e5d4343aa 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -31,6 +31,7 @@
 #include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
+#include "qapi/qapi-type-infos-sockets.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qemu/yank.h"
 #include "trace.h"
@@ -1568,7 +1569,7 @@ static void char_socket_class_init(ObjectClass *oc, const void *data)
     cc->chr_listener_cleanup = tcp_chr_listener_cleanup;
     cc->chr_get_filename = tcp_chr_get_filename;
 
-    object_class_property_add(oc, "addr", "SocketAddress",
+    object_class_property_add_qapi(oc, "addr", &SocketAddress_type_info,
                               char_socket_get_addr, NULL,
                               NULL, NULL);
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d9ac4b419a36..94737e17e66f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -18,6 +18,7 @@
 #include "hw/core/loader.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-machine.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qemu/madvise.h"
@@ -1118,19 +1119,20 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "dumpdtb",
         "Dump current dtb to a file and quit");
 
-    object_class_property_add(oc, "boot", "BootConfiguration",
+    object_class_property_add_qapi(oc, "boot", &BootConfiguration_type_info,
         machine_get_boot, machine_set_boot,
         NULL, NULL);
     object_class_property_set_description(oc, "boot",
         "Boot configuration");
 
-    object_class_property_add(oc, "smp", "SMPConfiguration",
+    object_class_property_add_qapi(oc, "smp", &SMPConfiguration_type_info,
         machine_get_smp, machine_set_smp,
         NULL, NULL);
     object_class_property_set_description(oc, "smp",
         "CPU topology");
 
-    object_class_property_add(oc, "smp-cache", "SmpCachePropertiesWrapper",
+    object_class_property_add_qapi(oc, "smp-cache",
+        &SmpCachePropertiesWrapper_type_info,
         machine_get_smp_cache, machine_set_smp_cache, NULL, NULL);
     object_class_property_set_description(oc, "smp-cache",
         "Cache properties list for SMP machine");
@@ -1212,7 +1214,8 @@ static void machine_class_init(ObjectClass *oc, const void *data)
                                           "Set RAM backend"
                                           "Valid value is ID of hostmem based backend");
 
-    object_class_property_add(oc, "memory", "MemorySizeConfiguration",
+    object_class_property_add_qapi(oc, "memory",
+        &MemorySizeConfiguration_type_info,
         machine_get_mem, machine_set_mem,
         NULL, NULL);
     object_class_property_set_description(oc, "memory",
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e279ce5fe3ae..8997bf1785c8 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -13,6 +13,7 @@
 #include "system/qtest.h"
 #include "hw/core/boards.h"
 
+#include "qapi/qapi-type-infos-machine.h"
 #include "qapi/qapi-visit-machine.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
@@ -616,7 +617,8 @@ void cxl_machine_init(Object *obj, CXLState *state)
                                     "Set on/off to enable/disable "
                                     "CXL instantiation");
 
-    object_property_add(obj, "cxl-fmw", "CXLFixedMemoryWindow",
+    object_property_add_qapi(obj, "cxl-fmw",
+                        &CXLFixedMemoryWindowOptionsList_type_info,
                         machine_get_cfmw, machine_set_cfmw,
                         NULL, state);
     object_property_set_description(obj, "cxl-fmw",
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index a0498d218faf..7e6819f670b5 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -47,6 +47,7 @@
 #include "hw/core/boards.h"
 #include "hw/remote/machine.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-sockets.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-events-misc.h"
 #include "qemu/notify.h"
@@ -931,8 +932,8 @@ static void vfu_object_class_init(ObjectClass *klass, const void *data)
 
     k->nr_devs = 0;
 
-    object_class_property_add(klass, "socket", "SocketAddress", NULL,
-                              vfu_object_set_socket, NULL, NULL);
+    object_class_property_add_qapi(klass, "socket", &SocketAddress_type_info,
+                              NULL, vfu_object_set_socket, NULL, NULL);
     object_class_property_set_description(klass, "socket",
                                           "SocketAddress "
                                           "(ex: type=unix,path=/tmp/sock). "
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 983e1d4ad470..f58c4a0f3965 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include "qapi/qapi-type-infos-sockets.h"
 #include "qapi-visit-sockets.h"
 #include "qemu/error-report.h"
 
@@ -471,8 +472,8 @@ static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, vfio_user_pci_reset);
     device_class_set_props(dc, vfio_user_pci_properties);
 
-    object_class_property_add(klass, "socket", "SocketAddress", NULL,
-                              vfio_user_pci_set_socket, NULL, NULL);
+    object_class_property_add_qapi(klass, "socket", &SocketAddress_type_info,
+                              NULL, vfio_user_pci_set_socket, NULL, NULL);
     object_class_property_set_description(klass, "socket",
                                           "SocketAddress (UNIX sockets only)");
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5da80ade70eb..4553ef0892a1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -35,6 +35,8 @@
 #include "sev.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-type-infos-machine.h"
+#include "qapi/qapi-type-infos-run-state.h"
 #include "qapi/qapi-visit-machine.h"
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/core/qdev-properties.h"
@@ -10540,10 +10542,12 @@ static void x86_cpu_initfn(Object *obj)
 
     x86_cpu_init_default_topo(cpu);
 
-    object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
+    object_property_add_qapi(obj, "feature-words",
+                        &X86CPUFeatureWordInfoList_type_info,
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)env->features);
-    object_property_add(obj, "filtered-features", "X86CPUFeatureWordInfo",
+    object_property_add_qapi(obj, "filtered-features",
+                        &X86CPUFeatureWordInfo_type_info,
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)cpu->filtered_features);
 
@@ -11007,7 +11011,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
                               NULL, NULL);
 
 #if !defined(CONFIG_USER_ONLY)
-    object_class_property_add(oc, "crash-information", "GuestPanicInformation",
+    object_class_property_add_qapi(oc, "crash-information",
+                              &GuestPanicInformation_type_info,
                               x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
 #endif
 
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 8294dbde3aa8..81c5ba3a1b54 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -14,6 +14,7 @@
 #include "qemu/base64.h"
 #include "qemu/mmap-alloc.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-sockets.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qom/object_interfaces.h"
 #include "crypto/hash.h"
@@ -1586,7 +1587,8 @@ static void tdx_guest_init(Object *obj)
                             tdx_guest_get_mrownerconfig,
                             tdx_guest_set_mrownerconfig);
 
-    object_property_add(obj, "quote-generation-socket", "SocketAddress",
+    object_property_add_qapi(obj, "quote-generation-socket",
+                            &SocketAddress_type_info,
                             tdx_guest_get_qgs,
                             tdx_guest_set_qgs,
                             NULL, NULL);
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index d963d9e940e1..30992ef654f4 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -30,6 +30,7 @@
 #include "system/reset.h"
 #include "qemu/timer.h"
 #include "trace.h"
+#include "qapi/qapi-type-infos-run-state.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "system/hw_accel.h"
 
@@ -137,7 +138,8 @@ void s390_cpu_system_init(Object *obj)
     S390CPU *cpu = S390_CPU(obj);
 
     cs->start_powered_off = true;
-    object_property_add(obj, "crash-information", "GuestPanicInformation",
+    object_property_add_qapi(obj, "crash-information",
+                        &GuestPanicInformation_type_info,
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL);
     cpu->env.tod_timer =
         timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);

-- 
2.56.0.116.g6de20f6092dc

