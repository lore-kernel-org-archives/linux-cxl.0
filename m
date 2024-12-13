Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F801B21B5
	for <linux-cxl@vger.kernel.org>; Fri, 13 Dec 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082643; cv=none; b=hPDOJfD2RgETdKfcPOg7z9uMc5PqVFD42ZHdo9Hfs5Ng79r8c49odBqJJ/QBXzXTOLhHKIFqkh3+yixG1yKSAJDGAwTzmkJjfEllGiwzP3LfBwMfIgxah0pMK6DLArbSJgFub+RiKVjBKBUbElbebwlKrmHTxWScqsn55VLpPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082643; c=relaxed/simple;
	bh=6NrpNnngy2DN9FFMrEyRuXx+lmv5gqBPAayUJXmUL/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8sp1pF6ma36LI2++EVTi69jR2DkwI62keTcqZDpFh2k/SJcNcWkrcv3/yE2I6Y9oyjE/TTWbngWIqiywomTXwLN0CqO50WMDAGJI4rh3nCDMAK7kNGQtxLTBhTG0ko2s4ISrkswGlBXUWYvM0lnqSAB0nztO+DTcvMNkEIRQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=k2IgztGI; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="k2IgztGI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734082641; x=1765618641;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6NrpNnngy2DN9FFMrEyRuXx+lmv5gqBPAayUJXmUL/M=;
  b=k2IgztGIgkewB4hQmusOoi190e+sQSg71sATDZA/kkprfhafy2fDfM69
   rTzLPwxB+HeYXK4QeCXFEX+btAq/PUoFNyNv7Ny2hQmCZp+dYhn29qG8z
   L4WVy4ZzpFZF57x5iHW2EsBAmZNxoZnfXqMfeU+7i/E38K8A29XP7OG9I
   jwpE1k75UuZmJbgWJdIdAG6oP1GhuH9OEqI/7zXUSeAOHxUx2/HUsuPci
   cctYOVzI/cLt/qnW5SYn3R3fM7nKrBrxut2TBSEtqKMThxFMX8/taoAF+
   kMkW4gxR3FsMvll8LgctWY0rixBwLowB6B7iuS6LwnyKCuUqjkrf1I+lh
   Q==;
X-CSE-ConnectionGUID: cp+7CDPzQSG00LgIICneSQ==
X-CSE-MsgGUID: tFR9PmINT9mC5DhZarVFlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="183832531"
X-IronPort-AV: E=Sophos;i="6.12,230,1728918000"; 
   d="scan'208";a="183832531"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 18:36:09 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id BED4ED4F41
	for <linux-cxl@vger.kernel.org>; Fri, 13 Dec 2024 18:36:07 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 891DCD97D5
	for <linux-cxl@vger.kernel.org>; Fri, 13 Dec 2024 18:36:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D53C2007C3F7
	for <linux-cxl@vger.kernel.org>; Fri, 13 Dec 2024 18:36:07 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 3E0031A006C;
	Fri, 13 Dec 2024 17:36:06 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2] hw/cxl: Fix msix_notify: Assertion `vector < dev->msix_entries_nr`
Date: Fri, 13 Dec 2024 17:36:02 +0800
Message-ID: <20241213093602.3248246-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28856.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28856.006
X-TMASE-Result: 10--8.981400-10.000000
X-TMASE-MatchedRID: IVNJzyZeXh7CVJdexVBqdn1zro62qhdCLL6mJOIs/vZGQgIVrmBL5G7l
	BX/37R4p+xFlvZshf1aUrbS7Rz/s6duWQuISDK/klTsGW3DmpUsWUg/hm489yFy92pa0KjKSZ28
	gEzxS4tKPfJJz7Ia9+rXYdqC9vAOOL/tBTZzO5Q0D2WXLXdz+AaGD6ovXqA23Cb7y9s8XSuQTgt
	4grpaSCs2ghO0gXEiI8ypyOLdjkCpAh0h+ieLkqGe0R3NAF/chGB9/bxS68hM0DNPwjqLncDzdD
	+58t9bI7foLApH+eB4kZf7JZKlNJtgW4k6aveo4uLt50vtxBA4HyFMDF+j4Apsoi2XrUn/Jn6Kd
	MrRsL14qtq5d3cxkNYLH5oQAcCkqRf3IpRODLzw/eYK5BWAtfKcn2QlF2WYhxKtXrSwh7t8=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This assertion always happens when we sanitize the CXL memory device.
$ echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize

It is incorrect to register an MSIX number beyond the device's capability.

Expand the device's MSIX number and use the enum to maintain the *USED*
and MAX MSIX number

Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: just increase msix number and add enum to maintainer their values #
Jonathan
---
 hw/cxl/cxl-device-utils.c   |  6 ++----
 hw/mem/cxl_type3.c          | 10 +++++-----
 include/hw/cxl/cxl_device.h |  7 +++++++
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 035d034f6d..bc2171e3d4 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -354,8 +354,6 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
-    const uint8_t msi_n = 9;
-
     /* 2048 payload size */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
@@ -364,8 +362,8 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      BG_INT_CAP, 1);
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
-                     MSI_N, msi_n);
-    cxl_dstate->mbox_msi_n = msi_n;
+                     MSI_N, CXL_MSIX_MBOX);
+    cxl_dstate->mbox_msi_n = CXL_MSIX_MBOX;
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      MBOX_READY_TIME, 0); /* Not reported */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5cf754b38f..f2f060ed9e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -843,7 +843,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 6;
     int i, rc;
     uint16_t count;
 
@@ -884,16 +883,17 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                      &ct3d->cxl_dstate.device_registers);
 
     /* MSI(-X) Initialization */
-    rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
+    rc = msix_init_exclusive_bar(pci_dev, CXL_MSIX_MAX, 4, NULL);
     if (rc) {
         goto err_address_space_free;
     }
-    for (i = 0; i < msix_num; i++) {
+    for (i = 0; i < CXL_MSIX_MAX; i++) {
         msix_vector_use(pci_dev, i);
     }
 
     /* DOE Initialization */
-    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 0);
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
+                  CXL_MSIX_PCIE_DOE);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
@@ -908,7 +908,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     if (rc) {
         goto err_release_cdat;
     }
-    cxl_event_init(&ct3d->cxl_dstate, 2);
+    cxl_event_init(&ct3d->cxl_dstate, CXL_MSIX_EVENT_START);
 
     /* Set default value for patrol scrub attributes */
     ct3d->patrol_scrub_attrs.scrub_cycle_cap =
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 561b375dc8..3f89b041ce 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -133,6 +133,13 @@ typedef enum {
     CXL_MBOX_MAX = 0x20
 } CXLRetCode;
 
+enum {
+    CXL_MSIX_PCIE_DOE = 0,
+    CXL_MSIX_EVENT_START = 2,
+    CXL_MSIX_MBOX = CXL_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
+    CXL_MSIX_MAX
+};
+
 typedef struct CXLCCI CXLCCI;
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
-- 
2.41.0

