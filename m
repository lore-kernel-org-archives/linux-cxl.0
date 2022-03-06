Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27635C433EF
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Mar 2022 17:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiCFR5n (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Mar 2022 12:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiCFR5m (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Mar 2022 12:57:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDE94C402
        for <linux-cxl@vger.kernel.org>; Sun,  6 Mar 2022 09:56:50 -0800 (PST)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KBTmX5GBTz67Gvv;
        Mon,  7 Mar 2022 01:56:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Sun, 6 Mar 2022 18:56:48 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 17:56:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v7 30/46] pci/pcie_port: Add pci_find_port_by_pn()
Date:   Sun, 6 Mar 2022 17:41:21 +0000
Message-ID: <20220306174137.5707-31-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Jonathan Cameron <jonathan.cameron@huawei.com>

Simple function to search a PCIBus to find a port by
it's port number.

CXL interleave decoding uses the port number as a target
so it is necessary to locate the port when doing interleave
decoding.

Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/pci/pcie_port.c         | 25 +++++++++++++++++++++++++
 include/hw/pci/pcie_port.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index e95c1e5519..687e4e763a 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -136,6 +136,31 @@ static void pcie_port_class_init(ObjectClass *oc, void *data)
     device_class_set_props(dc, pcie_port_props);
 }
 
+PCIDevice *pcie_find_port_by_pn(PCIBus *bus, uint8_t pn)
+{
+    int devfn;
+
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        PCIDevice *d = bus->devices[devfn];
+        PCIEPort *port;
+
+        if (!d || !pci_is_express(d) || !d->exp.exp_cap) {
+            continue;
+        }
+
+        if (!object_dynamic_cast(OBJECT(d), TYPE_PCIE_PORT)) {
+            continue;
+        }
+
+        port = PCIE_PORT(d);
+        if (port->port == pn) {
+            return d;
+        }
+    }
+
+    return NULL;
+}
+
 static const TypeInfo pcie_port_type_info = {
     .name = TYPE_PCIE_PORT,
     .parent = TYPE_PCI_BRIDGE,
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index e25b289ce8..7b8193061a 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -39,6 +39,8 @@ struct PCIEPort {
 
 void pcie_port_init_reg(PCIDevice *d);
 
+PCIDevice *pcie_find_port_by_pn(PCIBus *bus, uint8_t pn);
+
 #define TYPE_PCIE_SLOT "pcie-slot"
 OBJECT_DECLARE_SIMPLE_TYPE(PCIESlot, PCIE_SLOT)
 
-- 
2.32.0

