Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB1C64ED8
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 15:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjB0Pc1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjB0PcB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 10:32:01 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19874D527
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 07:32:00 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PQPVw5bBbz686qC;
        Mon, 27 Feb 2023 23:27:04 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Feb 2023 15:31:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v2 1/2] hw/pci: Add pcie_count_ds_port() and pcie_find_port_first() helpers
Date:   Mon, 27 Feb 2023 15:31:27 +0000
Message-ID: <20230227153128.8164-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230227153128.8164-1-Jonathan.Cameron@huawei.com>
References: <20230227153128.8164-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

These two helpers enable host bridges to operate differently depending on
the number of downstream ports, in particular if there is only a single
port.

Useful for CXL where HDM address decoders are allowed to be implicit in
the host bridge if there is only a single root port.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci/pcie_port.c         | 38 ++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie_port.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index 65a397ad23..1e9c485e5e 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -161,6 +161,44 @@ PCIDevice *pcie_find_port_by_pn(PCIBus *bus, uint8_t pn)
     return NULL;
 }
 
+/* Find first port in devfn number order */
+PCIDevice *pcie_find_port_first(PCIBus *bus)
+{
+    int devfn;
+
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        PCIDevice *d = bus->devices[devfn];
+
+        if (!d || !pci_is_express(d) || !d->exp.exp_cap) {
+            continue;
+        }
+
+        if (object_dynamic_cast(OBJECT(d), TYPE_PCIE_PORT)) {
+            return d;
+        }
+    }
+
+    return NULL;
+}
+
+int pcie_count_ds_ports(PCIBus *bus)
+{
+    int dsp_count = 0;
+    int devfn;
+
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        PCIDevice *d = bus->devices[devfn];
+
+        if (!d || !pci_is_express(d) || !d->exp.exp_cap) {
+            continue;
+        }
+        if (object_dynamic_cast(OBJECT(d), TYPE_PCIE_PORT)) {
+            dsp_count++;
+        }
+    }
+    return dsp_count;
+}
+
 static const TypeInfo pcie_port_type_info = {
     .name = TYPE_PCIE_PORT,
     .parent = TYPE_PCI_BRIDGE,
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 6c40e3733f..90e6cf45b8 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -41,6 +41,8 @@ struct PCIEPort {
 void pcie_port_init_reg(PCIDevice *d);
 
 PCIDevice *pcie_find_port_by_pn(PCIBus *bus, uint8_t pn);
+PCIDevice *pcie_find_port_first(PCIBus *bus);
+int pcie_count_ds_ports(PCIBus *bus);
 
 #define TYPE_PCIE_SLOT "pcie-slot"
 OBJECT_DECLARE_SIMPLE_TYPE(PCIESlot, PCIE_SLOT)
-- 
2.37.2

