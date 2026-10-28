Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207792;
	b=Oeno5SyL6h/qTEHMJQQrPy1uBfqpT+sPcb8EgblS5UYeioLKfoQDsT1gZZCiTkIe5gjp
	 O+EYZnqwFh4qI/0dqZQU9OO0OVWTXuR3fO+9MNFLhYleaHK1jeBqRAxNNMjZrUKy6wTQ7
	 P+IiHJn9xuEgl1OUKfK6bi+V5R+zKRHXgtBSiHby8DGwnbxx06BPlbzJlPpo5caNWLeo5
	 lZd9JkOrSixlBGVRWE5JKO0W2wdC0KW7IulJTbTtUCtDsOB07Iedy/+FNfKwwkWZOtgZW
	 3rkBmxNppFNpJ2mUclj0ferA8rcMABhidtoz0K8Tk04eGkvjb1vAVDTIBfKQfmYXrPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207792;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=266/aZuuZJj1dv13T/cRFg8LVOsF8F1fa7XWd/oESG4=;
	b=KyVfESnX+15FF+hPDBz2UJyyQUw1Ii4RKrmYKm8fK33xjMSzJYn7pln/7KwHMjFkNonc
	 LHcCEkGvniOWowE4Vkwm4/FKlI3HCRsb0BO+Kq4AjmQZj3LIV1ZpIU3XU321uZrMZtuky
	 suiX4YUcg34R12VJPpdUnJWY6Ueo80WOAsZi+wBzXmnqh9tp5Bwpig6vuQoyTIKzN1667
	 3WR3cE46Rwa0ceITGu8J8n9pZxnNKjG0seoHPww+UBrONYZ/x/KrY/fNbmDjEjvx3aYT/
	 MV4W8Gu4KWo6SKm95sX9PAiSErLGl3Cz59Sto0UziPaI5ebWYKq1XEgFZR/Inlih1MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGY9gTLm;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C5606A31E
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 17:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C6C5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGY9gTLm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793207791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=266/aZuuZJj1dv13T/cRFg8LVOsF8F1fa7XWd/oESG4=;
	b=KGY9gTLmCzF41z1Mq8hjiJM40Dx7CR7TeMXMP/BlHhTYbQBpprpYZxfRoQ9mZFtET1gvNI
	AdTr3ooVmyemK08d2wQQg9OQpsrS/a6pkaO71aVYh/w/vhcKO+jpwzDlfcaOfMqCchjg4w
	5DKVWNPlBmLCCAfwfOnRUgu9xdrotaY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-evoC6ptyPCKxyaYpTLkV8w-1; Wed, 28 Oct 2026 13:16:29 -0400
X-MC-Unique: evoC6ptyPCKxyaYpTLkV8w-1
X-Mimecast-MFC-AGG-ID: evoC6ptyPCKxyaYpTLkV8w_1793207788
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a35e1d2dddso11367795e9.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 10:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207788; x=1793812588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=266/aZuuZJj1dv13T/cRFg8LVOsF8F1fa7XWd/oESG4=;
        b=n0LJcsP8Zj9Anf5kSKhpI6vGoDe0oHb2NTYaZGdp1kbW5jcD73Bk+aTIFpkGcnbyXS
         v64kABikhRgct+2T/fF18SHFIjB+JzaSs8vC5UbHKnxzPsVCVQRM7NohwwFVn2M4iSMl
         7GX2/dutmHRh6wdP+qoS65IbbdfUYeGvQyCBZsB6LfkRmKZxZwRXtgpJh0bk/eqXVIwW
         xdTMz0AZUWOjdzjdXxOIRlVigyaeQOf6unGXmkXh0cE7HlX2duE+hPx77JBLs/oSBE5A
         2drSZl6MDS81dMKA9bD+7V+MtOfim5bxfsQc5EPHw8ySJ/0ArceniR5ejC3KSk15AG9P
         nA0A==
X-Forwarded-Encrypted: i=1; AKwUvBwY4Ib7rFrN8/Xzip90X0ClyOeKaUqsfbkeZLJMw7bOC3zwAiExvLfd5wmg5TZxaHos3RMfswlJcFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3N5LiUD/136zhbTfYbeoMY8RMKe1yLsiOGRtMZWguhq9XDQJ4
	hH383GUY5FVaOQz3IcL43Eto3BLNwdzhJ+EWkF4hUsNkh9jFzigOVSScs1++7OQKo0qiUJMPrss
	z3+9YEc/zYcXO4yAnPE0ejstabj4s3MY2Z9+OHs1eF7Gnch5DbXLUXIHgc/B3qQ==
X-Gm-Gg: AYBFou29b6O/KGSJGK4TZyUSTe8G12vyc+E2tO/KyQ1q/BbTLsL9iVUctnvyq5LR1zx
	cXHPQVWVA4TBfCxd211mePfru/kkxlFI8xt/EU24GaWKka9jeZ63rlhF5CYkpbqjy50Lmx4mAhE
	Mr7hXwCg9KBcpuNezuju/o2qyZUynzfOPO80yo3S/G2YIgBCKA6Em/o5IfPJ1efqxo2EZ22nOH3
	RenE5rjJkU515uKMXAKMXhBLMvKZLMtp7Nm1BMwgdQUJ3cppO7B4KepZ/zMu0OmQIknk5SZ3ZMx
	C4M1ZMlsBseruXqIu7SuLUJBwN2lpUV5WC2R1OmmBkYX54N68wAbpvkyKHr1cuHsv/vWEEBBJCk
	13J2vVD19A0TTaYzqNPMVK7ls+P4auZqQZfJyuaTp
X-Received: by 2002:a05:600c:8183:b0:4a2:1a:a129 with SMTP id 5b1f17b1804b1-4a9677c92d0mr54489235e9.35.1793207788033;
        Wed, 28 Oct 2026 10:16:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8183:b0:4a2:1a:a129 with SMTP id 5b1f17b1804b1-4a9677c92d0mr54488635e9.35.1793207787387;
        Wed, 28 Oct 2026 10:16:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f248sm29239446f8f.6.2026.10.28.10.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:16:26 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
	linux-cxl@vger.kernel.org
Subject: [PULL 56/78] hw/pci-bridge: split CXL PXB into separate file
Message-ID: <e6b0101a30025ed22deb99f6c956be33d842be16.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u3apWKfjNIDMP6EAr8dY1DyzNTcVAeF7-0jcrxPcz3A_1793207788
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

From: Daniel P. Berrangé <berrange@redhat.com>

If CONFIG_CXL=n is added to the Kconfig, the build fails to link
the PXB device:

/usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_realize':
/home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:202:(.text+0x330): undefined reference to `cxl_component_register_block_init'
/usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_dev_reset':
/home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:309:(.text+0x768): undefined reference to `cxl_component_register_init_common'

We cannot use CONFIG_CXL in pci_expander_bridge.c because the
identifier is poisoned. Instead the CXL pieces must be split
off into a separate source file which can be conditionally
built.

With this change, the stubs file is no longer required, since
the code referencing the stub was already protected by CONFIG_CXL.

Fixes: 6e4e3ae936e6 ("hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142)")
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260928095646.3555447-3-berrange@redhat.com>
---
 hw/pci-bridge/pci_expander_bridge_common.h    |  28 +++
 ...der_bridge.h => pci_expander_bridge_cxl.h} |   0
 hw/cxl/cxl-host.c                             |   2 +-
 hw/pci-bridge/pci_expander_bridge.c           | 194 +----------------
 hw/pci-bridge/pci_expander_bridge_cxl.c       | 201 ++++++++++++++++++
 hw/pci-bridge/pci_expander_bridge_stubs.c     |  14 --
 hw/pci-bridge/meson.build                     |   2 +-
 7 files changed, 240 insertions(+), 201 deletions(-)
 create mode 100644 hw/pci-bridge/pci_expander_bridge_common.h
 rename include/hw/pci-bridge/{pci_expander_bridge.h => pci_expander_bridge_cxl.h} (100%)
 create mode 100644 hw/pci-bridge/pci_expander_bridge_cxl.c
 delete mode 100644 hw/pci-bridge/pci_expander_bridge_stubs.c

diff --git a/hw/pci-bridge/pci_expander_bridge_common.h b/hw/pci-bridge/pci_expander_bridge_common.h
new file mode 100644
index 0000000000..d894ed0add
--- /dev/null
+++ b/hw/pci-bridge/pci_expander_bridge_common.h
@@ -0,0 +1,28 @@
+/*
+ * PCI Expander Bridge Device Emulation Common Code
+ *
+ * Copyright (C) 2015 Red Hat Inc
+ *
+ * Authors:
+ *   Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+enum BusType { PCI, PCIE, CXL };
+
+typedef struct PXBBus PXBBus;
+
+struct PXBBus {
+    /*< private >*/
+    PCIBus parent_obj;
+    /*< public >*/
+
+    char bus_path[8];
+};
+
+int pxb_bus_num(PCIBus *bus);
+void pxb_bus_class_init(ObjectClass *class, const void *data);
+bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
+                            Error **errp);
+void pxb_dev_exitfn(PCIDevice *pci_dev);
diff --git a/include/hw/pci-bridge/pci_expander_bridge.h b/include/hw/pci-bridge/pci_expander_bridge_cxl.h
similarity index 100%
rename from include/hw/pci-bridge/pci_expander_bridge.h
rename to include/hw/pci-bridge/pci_expander_bridge_cxl.h
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e279ce5fe3..cda4dfed50 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -20,7 +20,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
+#include "hw/pci-bridge/pci_expander_bridge_cxl.h"
 
 static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
                                            int index, Error **errp)
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 40ffbc4e08..2498df480b 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -18,57 +18,29 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
-#include "hw/cxl/cxl.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "system/numa.h"
 #include "hw/core/boards.h"
 #include "qom/object.h"
-
-enum BusType { PCI, PCIE, CXL };
+#include "pci_expander_bridge_common.h"
 
 #define TYPE_PXB_BUS "pxb-bus"
-typedef struct PXBBus PXBBus;
+
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
                          TYPE_PXB_BUS)
 
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
                          TYPE_PXB_PCIE_BUS)
 
-DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
-                         TYPE_PXB_CXL_BUS)
-
-struct PXBBus {
-    /*< private >*/
-    PCIBus parent_obj;
-    /*< public >*/
-
-    char bus_path[8];
-};
-
 OBJECT_DECLARE_SIMPLE_TYPE(PXBPCIEDev, PXB_PCIE_DEV)
 
 static GList *pxb_dev_list;
 
 #define TYPE_PXB_HOST "pxb-host"
 
-CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb)
-{
-    CXLHost *host = PXB_CXL_HOST(hb);
-
-    return &host->cxl_cstate;
-}
-
-bool cxl_get_hb_passthrough(PCIHostState *hb)
-{
-    CXLHost *host = PXB_CXL_HOST(hb);
-
-    return host->passthrough;
-}
-
-static int pxb_bus_num(PCIBus *bus)
+int pxb_bus_num(PCIBus *bus)
 {
     PXBDev *pxb = PXB_DEV(bus->parent_dev);
 
@@ -96,7 +68,7 @@ static void prop_pxb_uid_get(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &uid, errp);
 }
 
-static void pxb_bus_class_init(ObjectClass *class, const void *data)
+void pxb_bus_class_init(ObjectClass *class, const void *data)
 {
     PCIBusClass *pbc = PCI_BUS_CLASS(class);
 
@@ -123,20 +95,11 @@ static const TypeInfo pxb_pcie_bus_info = {
     .class_init    = pxb_bus_class_init,
 };
 
-static const TypeInfo pxb_cxl_bus_info = {
-    .name          = TYPE_PXB_CXL_BUS,
-    .parent        = TYPE_CXL_BUS,
-    .instance_size = sizeof(PXBBus),
-    .class_init    = pxb_bus_class_init,
-};
-
 static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
                                           PCIBus *rootbus)
 {
-    PXBBus *bus = pci_bus_is_cxl(rootbus) ?
-                      PXB_CXL_BUS(rootbus) :
-                      pci_bus_is_express(rootbus) ? PXB_PCIE_BUS(rootbus) :
-                                                    PXB_BUS(rootbus);
+    PXBBus *bus = pci_bus_is_express(rootbus) ?
+        PXB_PCIE_BUS(rootbus) : PXB_BUS(rootbus);
 
     snprintf(bus->bus_path, 8, "0000:%02x", pxb_bus_num(rootbus));
     return bus->bus_path;
@@ -192,64 +155,6 @@ static const TypeInfo pxb_host_info = {
     .class_init    = pxb_host_class_init,
 };
 
-static void pxb_cxl_realize(DeviceState *dev, Error **errp)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    CXLHost *cxl = PXB_CXL_HOST(dev);
-    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
-    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
-
-    cxl_component_register_block_init(OBJECT(dev), cxl_cstate,
-                                      TYPE_PXB_CXL_HOST);
-    sysbus_init_mmio(sbd, mr);
-}
-
-/*
- * Host bridge realization has no means of knowning state associated
- * with a particular machine. As such, it is nececssary to delay
- * final setup of the host bridge register space until later in the
- * machine bring up.
- */
-void pxb_cxl_hook_up_registers(CXLState *cxl_state, PCIBus *bus, Error **errp)
-{
-    PXBCXLDev *pxb =  PXB_CXL_DEV(pci_bridge_get_device(bus));
-    CXLHost *cxl = pxb->cxl_host_bridge;
-    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
-    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
-    hwaddr offset;
-
-    offset = memory_region_size(mr) * cxl_state->next_mr_idx;
-    if (offset > memory_region_size(&cxl_state->host_mr)) {
-        error_setg(errp, "Insufficient space for pxb cxl host register space");
-        return;
-    }
-
-    memory_region_add_subregion(&cxl_state->host_mr, offset, mr);
-    cxl_state->next_mr_idx++;
-}
-
-static void pxb_cxl_host_class_init(ObjectClass *class, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(class);
-    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
-
-    hc->root_bus_path = pxb_host_root_bus_path;
-    dc->fw_name = "cxl";
-    dc->realize = pxb_cxl_realize;
-    /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
-    dc->user_creatable = false;
-}
-
-/*
- * This is a device to handle the MMIO for a CXL host bridge. It does nothing
- * else.
- */
-static const TypeInfo cxl_host_info = {
-    .name          = TYPE_PXB_CXL_HOST,
-    .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(CXLHost),
-    .class_init    = pxb_cxl_host_class_init,
-};
 
 /*
  * Registers the PXB bus as a child of pci host root bus.
@@ -297,34 +202,6 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
     return pin - PCI_SLOT(pxb->devfn);
 }
 
-static void pxb_cxl_dev_reset(DeviceState *dev)
-{
-    CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
-    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
-    PCIHostState *hb = PCI_HOST_BRIDGE(cxl);
-    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
-    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
-    int dsp_count = 0;
-
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
-    /*
-     * The CXL specification allows for host bridges with no HDM decoders
-     * if they only have a single root port.
-     */
-    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {
-        dsp_count = pcie_count_ds_ports(hb->bus);
-    }
-    /* Initial reset will have 0 dsp so wait until > 0 */
-    if (dsp_count == 1) {
-        cxl->passthrough = true;
-        /* Set Capability ID in header to NONE */
-        ARRAY_FIELD_DP32(reg_state, CXL_HDM_CAPABILITY_HEADER, ID, 0);
-    } else {
-        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT,
-                         8);
-    }
-}
-
 static gint pxb_compare(gconstpointer a, gconstpointer b)
 {
     const PXBDev *pxb_a = a, *pxb_b = b;
@@ -334,8 +211,8 @@ static gint pxb_compare(gconstpointer a, gconstpointer b)
            0;
 }
 
-static bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
-                                   Error **errp)
+bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
+                            Error **errp)
 {
     PXBDev *pxb = PXB_DEV(dev);
     DeviceState *ds, *bds = NULL;
@@ -417,7 +294,7 @@ static void pxb_dev_realize(PCIDevice *dev, Error **errp)
     pxb_dev_realize_common(dev, PCI, errp);
 }
 
-static void pxb_dev_exitfn(PCIDevice *pci_dev)
+void pxb_dev_exitfn(PCIDevice *pci_dev)
 {
     PXBDev *pxb = PXB_DEV(pci_dev);
 
@@ -496,67 +373,14 @@ static const TypeInfo pxb_pcie_dev_info = {
     },
 };
 
-static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
-{
-    /* A CXL PXB's parent bus is still PCIe */
-    if (!pci_bus_is_express(pci_get_bus(dev))) {
-        error_setg(errp, "pxb-cxl devices cannot reside on a PCI bus");
-        return;
-    }
-
-    if (!pxb_dev_realize_common(dev, CXL, errp)) {
-        return;
-    }
-    pxb_cxl_dev_reset(DEVICE(dev));
-}
-
-static const Property pxb_cxl_dev_properties[] = {
-    DEFINE_PROP_BOOL("hdm_for_passthrough", PXBCXLDev, hdm_for_passthrough, false),
-};
-
-static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc   = DEVICE_CLASS(klass);
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->realize             = pxb_cxl_dev_realize;
-    k->exit                = pxb_dev_exitfn;
-    /*
-     * XXX: These types of bridges don't actually show up in the hierarchy so
-     * vendor, device, class, etc. ids are intentionally left out.
-     */
-
-    dc->desc = "CXL Host Bridge";
-    device_class_set_props(dc, pxb_cxl_dev_properties);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-
-    /* Host bridges aren't hotpluggable. FIXME: spec reference */
-    dc->hotpluggable = false;
-    device_class_set_legacy_reset(dc, pxb_cxl_dev_reset);
-}
-
-static const TypeInfo pxb_cxl_dev_info = {
-    .name          = TYPE_PXB_CXL_DEV,
-    .parent        = TYPE_PXB_PCIE_DEV,
-    .instance_size = sizeof(PXBCXLDev),
-    .class_init    = pxb_cxl_dev_class_init,
-    .interfaces =
-        (const InterfaceInfo[]){
-            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-            {},
-        },
-};
 
 static void pxb_register_types(void)
 {
     type_register_static(&pxb_bus_info);
     type_register_static(&pxb_pcie_bus_info);
-    type_register_static(&pxb_cxl_bus_info);
     type_register_static(&pxb_host_info);
-    type_register_static(&cxl_host_info);
     type_register_static(&pxb_dev_info);
     type_register_static(&pxb_pcie_dev_info);
-    type_register_static(&pxb_cxl_dev_info);
 }
 
 type_init(pxb_register_types)
diff --git a/hw/pci-bridge/pci_expander_bridge_cxl.c b/hw/pci-bridge/pci_expander_bridge_cxl.c
new file mode 100644
index 0000000000..ceb8928f8f
--- /dev/null
+++ b/hw/pci-bridge/pci_expander_bridge_cxl.c
@@ -0,0 +1,201 @@
+/*
+ * CXL PCI Expander Bridge Device Emulation
+ *
+ * Copyright (C) 2015 Red Hat Inc
+ *
+ * Authors:
+ *   Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/pci-bridge/pci_expander_bridge_cxl.h"
+#include "qom/object.h"
+#include "pci_expander_bridge_common.h"
+
+DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
+                         TYPE_PXB_CXL_BUS)
+
+CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb)
+{
+    CXLHost *host = PXB_CXL_HOST(hb);
+
+    return &host->cxl_cstate;
+}
+
+bool cxl_get_hb_passthrough(PCIHostState *hb)
+{
+    CXLHost *host = PXB_CXL_HOST(hb);
+
+    return host->passthrough;
+}
+
+static const char *pxb_cxl_host_root_bus_path(PCIHostState *host_bridge,
+                                              PCIBus *rootbus)
+{
+    PXBBus *bus = PXB_CXL_BUS(rootbus);
+    snprintf(bus->bus_path, 8, "0000:%02x", pxb_bus_num(rootbus));
+    return bus->bus_path;
+}
+
+
+static const TypeInfo pxb_cxl_bus_info = {
+    .name          = TYPE_PXB_CXL_BUS,
+    .parent        = TYPE_CXL_BUS,
+    .instance_size = sizeof(PXBBus),
+    .class_init    = pxb_bus_class_init,
+};
+
+static void pxb_cxl_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    CXLHost *cxl = PXB_CXL_HOST(dev);
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+
+    cxl_component_register_block_init(OBJECT(dev), cxl_cstate,
+                                      TYPE_PXB_CXL_HOST);
+    sysbus_init_mmio(sbd, mr);
+}
+
+/*
+ * Host bridge realization has no means of knowning state associated
+ * with a particular machine. As such, it is nececssary to delay
+ * final setup of the host bridge register space until later in the
+ * machine bring up.
+ */
+void pxb_cxl_hook_up_registers(CXLState *cxl_state, PCIBus *bus, Error **errp)
+{
+    PXBCXLDev *pxb =  PXB_CXL_DEV(pci_bridge_get_device(bus));
+    CXLHost *cxl = pxb->cxl_host_bridge;
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+    hwaddr offset;
+
+    offset = memory_region_size(mr) * cxl_state->next_mr_idx;
+    if (offset > memory_region_size(&cxl_state->host_mr)) {
+        error_setg(errp, "Insufficient space for pxb cxl host register space");
+        return;
+    }
+
+    memory_region_add_subregion(&cxl_state->host_mr, offset, mr);
+    cxl_state->next_mr_idx++;
+}
+
+static void pxb_cxl_host_class_init(ObjectClass *class, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
+
+    hc->root_bus_path = pxb_cxl_host_root_bus_path;
+    dc->fw_name = "cxl";
+    dc->realize = pxb_cxl_realize;
+    /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
+    dc->user_creatable = false;
+}
+
+/*
+ * This is a device to handle the MMIO for a CXL host bridge. It does nothing
+ * else.
+ */
+static const TypeInfo cxl_host_info = {
+    .name          = TYPE_PXB_CXL_HOST,
+    .parent        = TYPE_PCI_HOST_BRIDGE,
+    .instance_size = sizeof(CXLHost),
+    .class_init    = pxb_cxl_host_class_init,
+};
+
+static void pxb_cxl_dev_reset(DeviceState *dev)
+{
+    CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    PCIHostState *hb = PCI_HOST_BRIDGE(cxl);
+    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
+    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
+    int dsp_count = 0;
+
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
+    /*
+     * The CXL specification allows for host bridges with no HDM decoders
+     * if they only have a single root port.
+     */
+    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {
+        dsp_count = pcie_count_ds_ports(hb->bus);
+    }
+    /* Initial reset will have 0 dsp so wait until > 0 */
+    if (dsp_count == 1) {
+        cxl->passthrough = true;
+        /* Set Capability ID in header to NONE */
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_CAPABILITY_HEADER, ID, 0);
+    } else {
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT,
+                         8);
+    }
+}
+
+static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
+{
+    /* A CXL PXB's parent bus is still PCIe */
+    if (!pci_bus_is_express(pci_get_bus(dev))) {
+        error_setg(errp, "pxb-cxl devices cannot reside on a PCI bus");
+        return;
+    }
+
+    if (!pxb_dev_realize_common(dev, CXL, errp)) {
+        return;
+    }
+    pxb_cxl_dev_reset(DEVICE(dev));
+}
+
+static const Property pxb_cxl_dev_properties[] = {
+    DEFINE_PROP_BOOL("hdm_for_passthrough", PXBCXLDev,
+                     hdm_for_passthrough, false),
+};
+
+static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc   = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize             = pxb_cxl_dev_realize;
+    k->exit                = pxb_dev_exitfn;
+    /*
+     * XXX: These types of bridges don't actually show up in the hierarchy so
+     * vendor, device, class, etc. ids are intentionally left out.
+     */
+
+    dc->desc = "CXL Host Bridge";
+    device_class_set_props(dc, pxb_cxl_dev_properties);
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+
+    /* Host bridges aren't hotpluggable. FIXME: spec reference */
+    dc->hotpluggable = false;
+    device_class_set_legacy_reset(dc, pxb_cxl_dev_reset);
+}
+
+static const TypeInfo pxb_cxl_dev_info = {
+    .name          = TYPE_PXB_CXL_DEV,
+    .parent        = TYPE_PXB_PCIE_DEV,
+    .instance_size = sizeof(PXBCXLDev),
+    .class_init    = pxb_cxl_dev_class_init,
+    .interfaces =
+        (const InterfaceInfo[]){
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            {},
+        },
+};
+
+static void pxb_cxl_register_types(void)
+{
+    type_register_static(&pxb_cxl_bus_info);
+    type_register_static(&cxl_host_info);
+    type_register_static(&pxb_cxl_dev_info);
+}
+
+type_init(pxb_cxl_register_types)
diff --git a/hw/pci-bridge/pci_expander_bridge_stubs.c b/hw/pci-bridge/pci_expander_bridge_stubs.c
deleted file mode 100644
index b35180311f..0000000000
--- a/hw/pci-bridge/pci_expander_bridge_stubs.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0-or-later
- *
- * Stubs for calls made from machines to handle the case where CONFIG_PXB
- * is not enabled.
- */
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
-#include "hw/cxl/cxl.h"
-
-void pxb_cxl_hook_up_registers(CXLState *state, PCIBus *bus, Error **errp) {};
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index aa9959df04..563d3f5147 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -6,7 +6,7 @@ pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pci
                                                     'gen_pcie_upstream_port.c', 'gen_pcie_downstream_port.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
 pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'))
-stub_ss.add(files('pci_expander_bridge_stubs.c'))
+pci_ss.add(when: 'CONFIG_CXL', if_true: files('pci_expander_bridge_cxl.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
 pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c', 'cxl_upstream.c', 'cxl_downstream.c'))
 
-- 
MST

