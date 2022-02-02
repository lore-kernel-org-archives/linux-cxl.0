Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B9EC433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Feb 2022 14:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiBBO1C (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:27:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4649 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbiBBO1B (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Feb 2022 09:27:01 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JpkXB1xh6z67HpF;
        Wed,  2 Feb 2022 22:22:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 2 Feb 2022 15:26:58 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:26:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v5 32/43] pci/pcie_port: Add pci_find_port_by_pn()
Date:   Wed, 2 Feb 2022 14:10:26 +0000
Message-ID: <20220202141037.17352-33-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
References: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
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

