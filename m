Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEAF204C34
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599586; cv=none; b=c5NL6q9cjap0Ssyu7Z7fjelWsS9bCKXgOEsZ6DB/bHtYgEZ99nOIZeBeKtHjNRowa9j6lAaaOCgaUZnVEWJp7y7xtR5h2i2f9FaXl22OXHWHB/saj9sursiVku7n5wtu8w3qRzUfL8gDbFUNBnqnBJgPR72C2sPMlt9GGh03G80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599586; c=relaxed/simple;
	bh=L32lMUpORxjy5MFgrm6uUyWaytuMmB2GULsb++ZjeyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5qSwtbBhcSsGuCUbttSKRYegaoXaTDQ2faipzzzGARxThmAVxw9Ma6f/3UwPNh3+XN2rfASJQgPS2e9iFvaKup+YQRPbxccxSCHyrqK+eOquDmLTf5zybwH4ww7OpOX4+G/Do2jp0PWlLM71+ZotqFBR+Bg4xMu6Uph1Do3u7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YmsBL2BDdz6K8yT;
	Tue,  4 Feb 2025 00:18:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 74E4F1401F4;
	Tue,  4 Feb 2025 00:19:40 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 17:19:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 1/5] hw/cxl: Introduce CXL_T3_MSIX_VECTOR enumeration
Date: Mon, 3 Feb 2025 16:19:04 +0000
Message-ID: <20250203161908.145406-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
References: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Li Zhijian <lizhijian@fujitsu.com>

Introduce the `CXL_T3_MSIX_VECTOR` enumeration to specify MSIX vector
assignments specific to the Type 3 (T3) CXL device.

The primary goal of this change is to encapsulate the MSIX vector uses
that are unique to the T3 device within an enumeration, improving code
readability and maintenance by avoiding magic numbers. This organizational
change allows for more explicit references to each vector’s role, thereby
reducing the potential for misconfiguration.

It also modified `mailbox_reg_init_common` to accept the `msi_n` parameter,
reflecting the new MSIX vector setup.

This pertains to the T3 device privately; other endpoints should refrain from
using it, despite its public accessibility to all of them.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  4 ++--
 hw/cxl/cxl-device-utils.c   | 12 +++++-------
 hw/cxl/switch-mailbox-cci.c |  4 +++-
 hw/mem/cxl_type3.c          | 20 ++++++++++++++------
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 561b375dc8..3a0ee7e8e7 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -264,8 +264,8 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev,
 typedef struct CXLType3Dev CXLType3Dev;
 typedef struct CSWMBCCIDev CSWMBCCIDev;
 /* Set up default values for the register block */
-void cxl_device_register_init_t3(CXLType3Dev *ct3d);
-void cxl_device_register_init_swcci(CSWMBCCIDev *sw);
+void cxl_device_register_init_t3(CXLType3Dev *ct3d, int msi_n);
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw, int msi_n);
 
 /*
  * CXL r3.1 Section 8.2.8.1: CXL Device Capabilities Array Register
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 035d034f6d..52ad1e4c3f 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -352,10 +352,8 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
     }
 }
 
-static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
+static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate, int msi_n)
 {
-    const uint8_t msi_n = 9;
-
     /* 2048 payload size */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
@@ -382,7 +380,7 @@ static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->memdev_status = memdev_status_reg;
 }
 
-void cxl_device_register_init_t3(CXLType3Dev *ct3d)
+void cxl_device_register_init_t3(CXLType3Dev *ct3d, int msi_n)
 {
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     uint64_t *cap_h = cxl_dstate->caps_reg_state64;
@@ -398,7 +396,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
     device_reg_init_common(cxl_dstate);
 
     cxl_device_cap_init(cxl_dstate, MAILBOX, 2, CXL_DEV_MAILBOX_VERSION);
-    mailbox_reg_init_common(cxl_dstate);
+    mailbox_reg_init_common(cxl_dstate, msi_n);
 
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000,
         CXL_MEM_DEV_STATUS_VERSION);
@@ -408,7 +406,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
                               CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 }
 
-void cxl_device_register_init_swcci(CSWMBCCIDev *sw)
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw, int msi_n)
 {
     CXLDeviceState *cxl_dstate = &sw->cxl_dstate;
     uint64_t *cap_h = cxl_dstate->caps_reg_state64;
@@ -423,7 +421,7 @@ void cxl_device_register_init_swcci(CSWMBCCIDev *sw)
     device_reg_init_common(cxl_dstate);
 
     cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
-    mailbox_reg_init_common(cxl_dstate);
+    mailbox_reg_init_common(cxl_dstate, msi_n);
 
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
     memdev_reg_init_common(cxl_dstate);
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 65cdac6cc1..833b824619 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -17,10 +17,12 @@
 #include "hw/qdev-properties.h"
 #include "hw/cxl/cxl.h"
 
+#define CXL_SWCCI_MSIX_MBOX 3
+
 static void cswmbcci_reset(DeviceState *dev)
 {
     CSWMBCCIDev *cswmb = CXL_SWITCH_MAILBOX_CCI(dev);
-    cxl_device_register_init_swcci(cswmb);
+    cxl_device_register_init_swcci(cswmb, CXL_SWCCI_MSIX_MBOX);
 }
 
 static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0ae1704a34..ebc0ec536e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,14 @@
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
 
+/* type3 device private */
+enum CXL_T3_MSIX_VECTOR {
+    CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS = 0,
+    CXL_T3_MSIX_EVENT_START = 2,
+    CXL_T3_MSIX_MBOX = CXL_T3_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
+    CXL_T3_MSIX_VECTOR_NR
+};
+
 #define DWORD_BYTE 4
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
@@ -843,7 +851,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 10;
     int i, rc;
     uint16_t count;
 
@@ -884,16 +891,17 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                      &ct3d->cxl_dstate.device_registers);
 
     /* MSI(-X) Initialization */
-    rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
+    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
     if (rc) {
         goto err_address_space_free;
     }
-    for (i = 0; i < msix_num; i++) {
+    for (i = 0; i < CXL_T3_MSIX_VECTOR_NR; i++) {
         msix_vector_use(pci_dev, i);
     }
 
     /* DOE Initialization */
-    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 0);
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
+                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
@@ -908,7 +916,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     if (rc) {
         goto err_release_cdat;
     }
-    cxl_event_init(&ct3d->cxl_dstate, 2);
+    cxl_event_init(&ct3d->cxl_dstate, CXL_T3_MSIX_EVENT_START);
 
     /* Set default value for patrol scrub attributes */
     ct3d->patrol_scrub_attrs.scrub_cycle_cap =
@@ -1202,7 +1210,7 @@ static void ct3d_reset(DeviceState *dev)
 
     pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
-    cxl_device_register_init_t3(ct3d);
+    cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
      * Bring up an endpoint to target with MCTP over VDM.
-- 
2.43.0

