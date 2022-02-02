Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB6C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Feb 2022 14:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344757AbiBBOLK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:11:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4618 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiBBOLJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Feb 2022 09:11:09 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JpkBv4PdYz67lTK;
        Wed,  2 Feb 2022 22:07:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 15:11:07 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:11:06 +0000
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
Subject: [PATCH v5 01/43] hw/pci/cxl: Add a CXL component type (interface)
Date:   Wed, 2 Feb 2022 14:09:55 +0000
Message-ID: <20220202141037.17352-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
References: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

A CXL component is a hardware entity that implements CXL component
registers from the CXL 2.0 spec (8.2.3). Currently these represent 3
general types.
1. Host Bridge
2. Ports (root, upstream, downstream)
3. Devices (memory, other)

A CXL component can be conceptually thought of as a PCIe device with
extra functionality when enumerated and enabled. For this reason, CXL
does here, and will continue to add on to existing PCI code paths.

Host bridges will typically need to be handled specially and so they can
implement this newly introduced interface or not. All other components
should implement this interface. Implementing this interface allows the
core PCI code to treat these devices as special where appropriate.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/pci/pci.c         | 10 ++++++++++
 include/hw/pci/pci.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5d30f9ca60..474ea98c1d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -201,6 +201,11 @@ static const TypeInfo pci_bus_info = {
     .class_init = pci_bus_class_init,
 };
 
+static const TypeInfo cxl_interface_info = {
+    .name          = INTERFACE_CXL_DEVICE,
+    .parent        = TYPE_INTERFACE,
+};
+
 static const TypeInfo pcie_interface_info = {
     .name          = INTERFACE_PCIE_DEVICE,
     .parent        = TYPE_INTERFACE,
@@ -2128,6 +2133,10 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
     }
 
+    if (object_class_dynamic_cast(klass, INTERFACE_CXL_DEVICE)) {
+        pci_dev->cap_present |= QEMU_PCIE_CAP_CXL;
+    }
+
     pci_dev = do_pci_register_device(pci_dev,
                                      object_get_typename(OBJECT(qdev)),
                                      pci_dev->devfn, errp);
@@ -2884,6 +2893,7 @@ static void pci_register_types(void)
     type_register_static(&pci_bus_info);
     type_register_static(&pcie_bus_info);
     type_register_static(&conventional_pci_interface_info);
+    type_register_static(&cxl_interface_info);
     type_register_static(&pcie_interface_info);
     type_register_static(&pci_device_type_info);
 }
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 023abc0f79..908896ebe8 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -195,6 +195,8 @@ enum {
     QEMU_PCIE_LNKSTA_DLLLA = (1 << QEMU_PCIE_LNKSTA_DLLLA_BITNR),
 #define QEMU_PCIE_EXTCAP_INIT_BITNR 9
     QEMU_PCIE_EXTCAP_INIT = (1 << QEMU_PCIE_EXTCAP_INIT_BITNR),
+#define QEMU_PCIE_CXL_BITNR 10
+    QEMU_PCIE_CAP_CXL = (1 << QEMU_PCIE_CXL_BITNR),
 };
 
 #define TYPE_PCI_DEVICE "pci-device"
@@ -202,6 +204,12 @@ typedef struct PCIDeviceClass PCIDeviceClass;
 DECLARE_OBJ_CHECKERS(PCIDevice, PCIDeviceClass,
                      PCI_DEVICE, TYPE_PCI_DEVICE)
 
+/*
+ * Implemented by devices that can be plugged on CXL buses. In the spec, this is
+ * actually a "CXL Component, but we name it device to match the PCI naming.
+ */
+#define INTERFACE_CXL_DEVICE "cxl-device"
+
 /* Implemented by devices that can be plugged on PCI Express buses */
 #define INTERFACE_PCIE_DEVICE "pci-express-device"
 
-- 
2.32.0

