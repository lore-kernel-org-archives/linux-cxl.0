Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C40018B1A
	for <linux-cxl@vger.kernel.org>; Mon, 16 Sep 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508195; cv=none; b=jOZbTO1ebWiixHrsP9e39MCbAGtTTD6Xz82aIyDpBybsfWFXSnpJcCl2tGQMvE6cA6H/hJqvtv7MNQqO0wPTBEM0Fbp73DVQ7PqPTZMyMvMt6jUDI7NQaNvAczsV64fXkpUW8ZwBDKblRA17S9pI6iY2KURy38ryjXJHmmdAQFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508195; c=relaxed/simple;
	bh=n0g697SEwFq/+vRqbHJCSaPjULhZU+WS7rFwKnvkORc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHD+6nnJFtY3q+/Ulg2Y/2HffbyozeiT/obV7rWfJI9mb9aQ6UKn19XsHuCzY5FWI3zxmXqGuUQ6C+ZyzOBH9T8pllKhTV6BwHBdlLG2bbNfQd7LtOY+qyomrdmDmutnAkeMdp7A17mWS1T6baD7IZMVnZQXxrTQgVv01FUhnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6sRk6RTKz6K5pZ;
	Tue, 17 Sep 2024 01:32:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 16E9E14058E;
	Tue, 17 Sep 2024 01:36:31 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:36:28 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
	<fan.ni@samsung.com>
Subject: [PATCH 2/6] hw/pci-bridge/cxl_upstream: Provide x-speed and x-width properties.
Date: Mon, 16 Sep 2024 18:35:14 +0100
Message-ID: <20240916173518.1843023-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
References: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

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
index 4b42984360..c347ac06f3 100644
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

