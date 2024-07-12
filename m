Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493B15B548
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720787121; cv=none; b=mTVXcCNqgC/hTS9r1Nm+ts4Zky3jUh+gUs+N+4UuTLVXVL6GHsk8IZWkg4abthk5X5Lg+eLR9r7xQluUb7jjdXNth/BR/fZzRsctv6p0geEpzfCR+5AKMmdtOJVHWC+VObXDintGoQ59C6HmYB5DyiUfzV/JVD+//L8BzROs5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720787121; c=relaxed/simple;
	bh=7zj7WlU13bYc35RoK2EGHEuBksY1+NHS3KmgMHv0t18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADxfahByq4z3WZyO+cuegtsyzECxnUeh522Yd1K5SK+37BKB6bVBVIOQ4QoNQuB8PrLx/4Wigw3Mq1B0n55l/SsIeMTt/sY2FL/g34hCrKHZENZBxrEtQB+iYNZH6gmecjNWtQ8jLu7QHqa/6UmS+wN5TYBZ960vhFk8WW8ENQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL9jT4kNsz6K9GW;
	Fri, 12 Jul 2024 20:23:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8382C1400CF;
	Fri, 12 Jul 2024 20:25:16 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 13:25:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
	<fan.ni@samsung.com>
Subject: [RFC qemu 2/6] hw/pci-bridge/cxl_upstream: Provide x-speed and x-width properties.
Date: Fri, 12 Jul 2024 13:24:10 +0100
Message-ID: <20240712122414.1448284-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712122414.1448284-1-Jonathan.Cameron@huawei.com>
References: <20240712122414.1448284-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Copied from gen_pcie_root_port.c
Drop the previous code that ensured a valid value in s->width, s->speed
as now a default is provided so this will always be set.

Note this changes the default settings but it is unlikely to have a negative
effect on software as will only affect ports with now downstream device.
All other ports will use the settings from that device.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci-bridge/cxl_downstream.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 742da07a01..c0b4fac735 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -13,6 +13,8 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/cxl/cxl.h"
 #include "qapi/error.h"
 
@@ -210,24 +212,20 @@ static void cxl_dsp_exitfn(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
 
-static void cxl_dsp_instance_post_init(Object *obj)
-{
-    PCIESlot *s = PCIE_SLOT(obj);
-
-    if (!s->speed) {
-        s->speed = QEMU_PCI_EXP_LNK_2_5GT;
-    }
-
-    if (!s->width) {
-        s->width = QEMU_PCI_EXP_LNK_X1;
-    }
-}
+static Property cxl_dsp_props[] = {
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
+                                speed, PCIE_LINK_SPEED_64),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
+                                width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_END_OF_LIST()
+};
 
 static void cxl_dsp_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, cxl_dsp_props);
     k->config_write = cxl_dsp_config_write;
     k->realize = cxl_dsp_realize;
     k->exit = cxl_dsp_exitfn;
@@ -243,7 +241,6 @@ static const TypeInfo cxl_dsp_info = {
     .name = TYPE_CXL_DSP,
     .instance_size = sizeof(CXLDownstreamPort),
     .parent = TYPE_PCIE_SLOT,
-    .instance_post_init = cxl_dsp_instance_post_init,
     .class_init = cxl_dsp_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
-- 
2.43.0

