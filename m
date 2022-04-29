Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0CCC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Apr 2022 14:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbiD2Ouk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Apr 2022 10:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356851AbiD2Ouk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Apr 2022 10:50:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE34195485
        for <linux-cxl@vger.kernel.org>; Fri, 29 Apr 2022 07:47:21 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KqZyN2GdRz67P81;
        Fri, 29 Apr 2022 22:44:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 16:47:19 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 15:47:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <k.jensen@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v10 12/45] hw/pci/cxl: Create a CXL bus type
Date:   Fri, 29 Apr 2022 15:40:37 +0100
Message-ID: <20220429144110.25167-13-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
References: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

The easiest way to differentiate a CXL bus, and a PCIE bus is using a
flag. A CXL bus, in hardware, is backward compatible with PCIE, and
therefore the code tries pretty hard to keep them in sync as much as
possible.

The other way to implement this would be to try to cast the bus to the
correct type. This is less code and useful for debugging via simply
looking at the flags.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/pci-bridge/pci_expander_bridge.c | 9 ++++++++-
 include/hw/pci/pci_bus.h            | 7 +++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index d4514227a8..a6caa1e7b5 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -24,7 +24,7 @@
 #include "hw/boards.h"
 #include "qom/object.h"
 
-enum BusType { PCI, PCIE };
+enum BusType { PCI, PCIE, CXL };
 
 #define TYPE_PXB_BUS "pxb-bus"
 typedef struct PXBBus PXBBus;
@@ -35,6 +35,10 @@ DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
                          TYPE_PXB_PCIE_BUS)
 
+#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
+DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
+                         TYPE_PXB_CXL_BUS)
+
 struct PXBBus {
     /*< private >*/
     PCIBus parent_obj;
@@ -251,6 +255,9 @@ static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
     ds = qdev_new(TYPE_PXB_HOST);
     if (type == PCIE) {
         bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
+    } else if (type == CXL) {
+        bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_CXL_BUS);
+        bus->flags |= PCI_BUS_CXL;
     } else {
         bus = pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
         bds = qdev_new("pci-bridge");
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 347440d42c..eb94e7e85c 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -24,6 +24,8 @@ enum PCIBusFlags {
     PCI_BUS_IS_ROOT                                         = 0x0001,
     /* PCIe extended configuration space is accessible on this bus */
     PCI_BUS_EXTENDED_CONFIG_SPACE                           = 0x0002,
+    /* This is a CXL Type BUS */
+    PCI_BUS_CXL                                             = 0x0004,
 };
 
 struct PCIBus {
@@ -53,6 +55,11 @@ struct PCIBus {
     Notifier machine_done;
 };
 
+static inline bool pci_bus_is_cxl(PCIBus *bus)
+{
+    return !!(bus->flags & PCI_BUS_CXL);
+}
+
 static inline bool pci_bus_is_root(PCIBus *bus)
 {
     return !!(bus->flags & PCI_BUS_IS_ROOT);
-- 
2.32.0

