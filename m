Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0F37A83D
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551960; cv=none; b=f38UT1PhOJW9PUl8Bw890pP+KFjHg/vg3EkiLwCn5D9Wmc5dplQY2JoW3YhCL6DRL2nQxupQXX5a7pdiq6i5qhUULHMEGGo3j6lf04ladHrC8gKwmiR/7bfScmTCDjsy5G/W0eC4+KShC+1e/1ZtoFzNFkwGEUUZZHSLN/rvFcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551960; c=relaxed/simple;
	bh=zi3fSX27M23Y9fYFv+SIfAQ4hQmfHUHoyc41kup2lFg=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=QCrq4K593hjozG5SjRwlwLi2I6VmrAQiATcxuyS6og2Ju5Y7+zqjmZ2kNbNlL6jEXDMtRuzgTJehRmj79Vav/5ulP4hjJqgfW/Gf2HHa/i4/BpvtdzWEp5/QXMqtZLIrIY71rhEihENaJYubsWYQC2tclywiAzaoVDnFX9IKtvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUxCZnue; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUxCZnue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788551955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8nXlOf33FzZu4Uffx1FIQkjSH+p+ULqjHe80q6rVhY=;
	b=AUxCZnuef1cibAtpjnGoOQodPpiokAbPXun0sFJDGOhVgVhnoasBVhTPJE3GBTDIpRB7gc
	zzZJqa4Gnzyv+GKW5L2JNDpVvs9eN3sQ+v4mNFlJI6ZO6124teu4jIB7JT1zFyicR8lgOR
	boWE83olcdgUKF/k3Mg9wsDKtGXcCCQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-YxeiT9KEM9CL3GLYPFrLFA-1; Fri,
 04 Sep 2026 15:59:13 -0400
X-MC-Unique: YxeiT9KEM9CL3GLYPFrLFA-1
X-Mimecast-MFC-AGG-ID: YxeiT9KEM9CL3GLYPFrLFA_1788551951
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E619A18E9B24;
	Fri,  4 Sep 2026 19:59:10 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04C9030002F4;
	Fri,  4 Sep 2026 19:59:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:00 +0400
Subject: [PATCH v4 17/75] qom: convert struct properties to QAPI-aware
 registration
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260904-qom-qapi-v4-17-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 qemu-block@nongnu.org, linux-cxl@vger.kernel.org, kvm@vger.kernel.org, 
 qemu-s390x@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=12033;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zi3fSX27M23Y9fYFv+SIfAQ4hQmfHUHoyc41kup2lFg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLJhl6wjdQXv6uRaDpImlq7Y+q7VIayXtIRn
 CW/XrWnRE2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyQAKCRDa6OEJdZac
 5XpDD/9eUxr7UYMoApTDkXoFITjcNVZZQIA3Ikuw1CmKFjrLevYvXdwyCFfGtbAT7y4y1fn80Jp
 7yvY2zKMle2IegfAH41gnD3VM1npLzC8gdSZ378Nor0Afp4jLYNTyXZzZPSzjXj26plUjrNo9F4
 W2lPtEGdMK5oS5FKOYroBRHrqI8NTWDz/eDNS3Yp3qUbw0RuUPfKm21Hubo59n+wGWo/nwmNNZb
 t9YF42FUoGSPk8TyRAslEO3rHGWchserfcc83fxp6WiBw0Cq7ODP5G9R0aNkgYwBQtTeStDuQwJ
 Mr4oH/I4CyqYyi6TumwYJfA2Ini5B65I0vv+aAJgp9TNgDHqnoB10E7jh/A/cUdhQDSS/jCMMe4
 hGvsUs5CCjgxeIsl8hKljLsMihAZWcy6fzYyYDwixedaq3mZaIXTar2S1aGS2wcZ/qlViaOWkca
 8WHX0PPIKq9Bc85D+VF0A/UxCnYqtGB9OEBQAP5Pfjw26jTAxCoOCUqcGYwearwnpX9OjJm89eQ
 J16sJc08KgjCo7f6BW0PqN8bOzCDebLd8X8T8GBGZkqRXhklrLnUEyR2biGy8xsK9FvGwUn7fVx
 QVLv9OhZfvYZAU9ehIUXDzVivO++onAsj3JypFeEVUCQzkRubLC78db2CEJlpfeCZTjIZj9TTgg
 IKTWfxDkbQil4bg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: hW710n_m3M3E6xeOziW2lJt4KpJcoI-wdsS0BfUgNVI_1788551951
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
(not a real QAPI type) to "CXLFixedMemoryWindowOptions".

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
index 363b2ee12c98..ed3d346004c2 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -128,7 +128,7 @@ qauthz_list_class_init(ObjectClass *oc, const void *data)
         .set = qauthz_list_prop_set_policy,
     ));
 
-    object_class_property_add(oc, "rules", "QAuthZListRule",
+    object_class_property_add_qapi(oc, "rules", &QAuthZListRule_type_info,
                               qauthz_list_prop_get_rules,
                               qauthz_list_prop_set_rules,
                               NULL, NULL);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 805e47270c7e..a9d3aea3b54e 100644
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
@@ -991,8 +992,8 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
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
index 8939ae16666c..530fbaeb0b28 100644
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
@@ -1114,19 +1115,20 @@ static void machine_class_init(ObjectClass *oc, const void *data)
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
@@ -1208,7 +1210,8 @@ static void machine_class_init(ObjectClass *oc, const void *data)
                                           "Set RAM backend"
                                           "Valid value is ID of hostmem based backend");
 
-    object_class_property_add(oc, "memory", "MemorySizeConfiguration",
+    object_class_property_add_qapi(oc, "memory",
+        &MemorySizeConfiguration_type_info,
         machine_get_mem, machine_set_mem,
         NULL, NULL);
     object_class_property_set_description(oc, "memory",
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index eba13c9e7cba..7592c4ac6c7b 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -13,6 +13,7 @@
 #include "system/qtest.h"
 #include "hw/core/boards.h"
 
+#include "qapi/qapi-type-infos-machine.h"
 #include "qapi/qapi-visit-machine.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
@@ -570,7 +571,8 @@ void cxl_machine_init(Object *obj, CXLState *state)
                                     "Set on/off to enable/disable "
                                     "CXL instantiation");
 
-    object_property_add(obj, "cxl-fmw", "CXLFixedMemoryWindow",
+    object_property_add_qapi(obj, "cxl-fmw",
+                        &CXLFixedMemoryWindowOptions_type_info,
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
index e7573d4a9f08..246bd5a90925 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include "qapi/qapi-type-infos-sockets.h"
 #include "qapi-visit-sockets.h"
 #include "qemu/error-report.h"
 
@@ -466,8 +467,8 @@ static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, vfio_user_pci_reset);
     device_class_set_props(dc, vfio_user_pci_properties);
 
-    object_class_property_add(klass, "socket", "SocketAddress", NULL,
-                              vfio_user_pci_set_socket, NULL, NULL);
+    object_class_property_add_qapi(klass, "socket", &SocketAddress_type_info,
+                              NULL, vfio_user_pci_set_socket, NULL, NULL);
     object_class_property_set_description(klass, "socket",
                                           "SocketAddress (UNIX sockets only)");
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d01ff1948e5e..7c24eba3e0c3 100644
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
@@ -10514,10 +10516,12 @@ static void x86_cpu_initfn(Object *obj)
 
     x86_cpu_init_default_topo(cpu);
 
-    object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
+    object_property_add_qapi(obj, "feature-words",
+                        &X86CPUFeatureWordInfo_type_info,
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)env->features);
-    object_property_add(obj, "filtered-features", "X86CPUFeatureWordInfo",
+    object_property_add_qapi(obj, "filtered-features",
+                        &X86CPUFeatureWordInfo_type_info,
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)cpu->filtered_features);
 
@@ -10980,7 +10984,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
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
index cc9685221ae8..4c2a91d0ff51 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -30,6 +30,7 @@
 #include "system/reset.h"
 #include "qemu/timer.h"
 #include "trace.h"
+#include "qapi/qapi-type-infos-run-state.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "system/hw_accel.h"
 
@@ -130,7 +131,8 @@ void s390_cpu_system_init(Object *obj)
     S390CPU *cpu = S390_CPU(obj);
 
     cs->start_powered_off = true;
-    object_property_add(obj, "crash-information", "GuestPanicInformation",
+    object_property_add_qapi(obj, "crash-information",
+                        &GuestPanicInformation_type_info,
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL);
     cpu->env.tod_timer =
         timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);

-- 
2.55.0.543.g5ebe2ebe4ea8

