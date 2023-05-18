Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1460AC77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 02:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjERCqK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 22:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjERCqH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 22:46:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1A23C30
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 19:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684377965; x=1715913965;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Zvl4Us5nFwXM+K5uC8NSDV+qsek+5uIPfbxF6GEL2Jw=;
  b=l4nOO0ZxbLfXNUjHufWl2mVjxXiJfMgmJaq3RDafD3inKAkG8Qr8rMt0
   3h8moX28Cahf2GkTSKbdioHf/qyo+xl5QLq2aLES05VL8oLAE6CvdVgOd
   obR0TQ0ku2CaK0wxODKkBehj7lQSEBjJWeA9OmMrH27TYfFbKeaCtRddq
   rD8+v/yXEW7n1MxM2FTTf6o7+bdr7WSAiKXx+n0PTm33DgPb86CleFC86
   xqYqoxVIAQ9mpCaD7dlmxxAUDb+eFFs8ddxcC7r1zt+FRCMmbkLqkBah8
   CzEVeNUjz80M0t5HBwOSoO8DjF20w/oOSN8mlcV26eyqaz/QVorgJ4GnY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380147108"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="380147108"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652466733"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="652466733"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.143.168])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:46:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 17 May 2023 19:45:56 -0700
Subject: [PATCH RFC 3/5] hw/cxl: Derive a CXL accelerator device from
 Type-3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-rfc-type2-dev-v1-3-6eb2e470981b@intel.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
In-Reply-To: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684377956; l=4453;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Zvl4Us5nFwXM+K5uC8NSDV+qsek+5uIPfbxF6GEL2Jw=;
 b=t6ps/6MKxcDQEG2REfSRjLaEhVncO5i5rhmh8QiXSfeH4Z7SDLmaKDpZXI5Xv19k8ydbyl7uA
 GyZTLf0eDebDoXj3C3zJZIv+0RLg919zQo6QcqKHakcGW/zC8UkERx6
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

It is desirable to have a test accelerator device to present various
accelerator features such as Back-Invalidate (BI) registers to OS
software for testing.

BI accelerator devices require memory that can be easily modeled as a
sub-class of Type-3 device.

Derive 'cxl-accel' from cxl-type3.  Add documentation for such a device.

Follow on patches will add BI registers and other simulation of the
accelerator device.

Adding devices qemu can be done with the following example:

...
  -device cxl-accel,bus=sw0p0,volatile-memdev=cxl-ac-mem5,id=cxl-dev5,sn=0xCAFE0005
...

Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
The device ID and class code are completely made up by me.  As discussed
in the last community call perhaps these could be declared in some more
official capacity?
---
 docs/system/devices/cxl.rst | 11 +++++++++++
 hw/mem/cxl_type3.c          | 28 ++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h | 16 ++++++++++++++++
 include/hw/pci/pci_ids.h    |  1 +
 4 files changed, 56 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 95900252c56a..5bc931be44b3 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -321,6 +321,17 @@ A very simple setup with just one directly attached CXL Type 3 Volatile Memory d
   -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
 
+A very simple setup with just one directly attached CXL Type 2 Volatile Memory
+Accelerator device::
+
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
+  ...
+  -object memory-backend-ram,id=vmem0,share=on,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
+  -device cxl-accel,bus=root_port13,volatile-memdev=vmem0,id=cxl-accel0 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
+
 The same volatile setup may optionally include an LSA region::
 
   qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3e63dbd83551..c7eafd76d1ea 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1691,3 +1691,31 @@ static void ct3d_registers(void)
 }
 
 type_init(ct3d_registers);
+
+static void cxl_accel_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+
+    pc->class_id = PCI_CLASS_CXL_QEMU_ACCEL;
+    pc->vendor_id = PCI_VENDOR_ID_INTEL;
+    pc->device_id = 0xd94; /* LVF for now */
+    pc->revision = 1;
+
+    dc->desc = "CXL Accelerator Device (Type 2)";
+}
+
+static const TypeInfo cxl_accel_dev_info = {
+    .name = TYPE_CXL_ACCEL,
+    .parent = TYPE_CXL_TYPE3,
+    .class_size = sizeof(struct CXLAccelClass),
+    .class_init = cxl_accel_class_init,
+    .instance_size = sizeof(CXLAccelDev),
+};
+
+static void cxl_accel_dev_registers(void)
+{
+    type_register_static(&cxl_accel_dev_info);
+}
+
+type_init(cxl_accel_dev_registers);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cd7f28dba884..f7f6688ee6e2 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -432,6 +432,22 @@ struct CXLType3Class {
     bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
 };
 
+/*
+ * Accel devices are a type3 device but with additional functionality.
+ */
+struct CXLAccelDev {
+    /* Private: Must be first */
+    CXLType3Dev parent_obj;
+};
+
+struct CXLAccelClass {
+    /* Private: Must be first */
+    CXLType3Class parent_class;
+};
+
+#define TYPE_CXL_ACCEL "cxl-accel"
+OBJECT_DECLARE_TYPE(CXLAccelDev, CXLAccelClass, CXL_ACCEL)
+
 struct CSWMBCCIDev {
     PCIDevice parent_obj;
     CXLComponentState cxl_cstate;
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index e4386ebb2038..2dbf350ebba4 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -54,6 +54,7 @@
 #define PCI_CLASS_MEMORY_RAM             0x0500
 #define PCI_CLASS_MEMORY_FLASH           0x0501
 #define PCI_CLASS_MEMORY_CXL             0x0502
+#define PCI_CLASS_CXL_QEMU_ACCEL         0x0503
 #define PCI_CLASS_MEMORY_OTHER           0x0580
 
 #define PCI_BASE_CLASS_BRIDGE            0x06

-- 
2.40.0

