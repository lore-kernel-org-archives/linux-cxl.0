Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E587CF2B
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649608; cv=none; b=dm5HCK54nhoohti3+rxX4zBmJrdNSBYXZy9Vut5QIUpGQm1c4ggSokZAD/XyWTpFzn3RT7UdryzNteQ7Nz8p/SlqYub0IIy30CyM48heGgOA69SKoGIFzkHx6nktps8WmA0EHndJxr9dU4aQY8+K2Z9N/NkA8u4sblaSYqmH97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649608; c=relaxed/simple;
	bh=cr75vmQQ4tjMyuDlPBiVrzxG5Gv0w637W9cL2RfcGas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=saa63gKh32JvZIPZLwU99zdFmHpxmvDCEG+x61zwgwqqc3HLTOu0bdUrX/PQ6PkdkC3OvIzCEqFUUN6ONUPm/9LMGW57Jkkj2abIZYVyucCUCbMOiYEL1wSX7TVIMEeuzHCiv+VN5UAfuf7DzuipvdLP/HRuOBBjLtwuV4bY2Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QUB58m8F; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QUB58m8F"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712649606; x=1744185606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cr75vmQQ4tjMyuDlPBiVrzxG5Gv0w637W9cL2RfcGas=;
  b=QUB58m8FRCVE7SEhrs8iNg0So8VRvn+kLaB1r5XdwJDi5SSMarSdG4uP
   sx2xAOYC0QhSliNC6e6NY2PZOPtH2EghRPi9P2zzu7zDazZT5d5EWEc7C
   djbJkEe+UDM9/3cgwh/q/gguPRocvfKuJex5wDOdqfmYHV0KGJMQ+gPxL
   bk+sP9TuEpNh1Ki69TiVPJvI2SAQiTcQ+2CKv56udQ2Ex1Ce7zPfyNW2m
   sCjK7N7E7jJIUSKXqiMJi1maL/HpCAOzDEts0SvF3ASdEYmcaSOeByP5N
   tqsMjAE4M7oJZ8O6ghkoW9nnBcuX13BAZt2Iv2oSTcd/0CjeHuODOpVae
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="143015836"
X-IronPort-AV: E=Sophos;i="6.07,189,1708354800"; 
   d="scan'208";a="143015836"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:58:54 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 68688D9F01
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 16:58:52 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 96248D5620
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 16:58:51 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2586A20098E12
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 16:58:51 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6293D1A0002;
	Tue,  9 Apr 2024 15:58:50 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2] hw/mem/cxl_type3: reset dvsecs in ct3d_reset()
Date: Tue,  9 Apr 2024 15:58:46 +0800
Message-Id: <20240409075846.85370-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28306.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28306.006
X-TMASE-Result: 10--9.351400-10.000000
X-TMASE-MatchedRID: uWxJDmPsnWHOugYCEJUMNSrLqyE6Ur/j1Ee54j3itDaJXRC/bWSJueLa
	AlZI/DlqEpqGYdoOBVcHw5SpXQUTkBT0CagFsN1kEVuC0eNRYvIXivwflisSrCWLxjlrSy8vuxW
	P7AlD8NO3nQMqHp+dH+affHI8kAmiHY/bzRmIaZGdd2mFBNIr8gV54COoxb6XR6RHdVK85hXuQ7
	Jl58fF92sRrupgWdD3DHgfvPgXVeSel3N+gDvB50VOF9zLtdyMeF+F9LT9kRKbKItl61J/yZ+in
	TK0bC9eKrauXd3MZDVt7biF0Cnq/FsUqcjBanlSra5fkKjdyekD49NFNTBfWdZEUZ4TJWg7
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

After the kernel commit
0cab68720598 ("cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window")
CXL type3 devices cannot be enabled again after the reboot because the
control register(see 8.1.3.2 in CXL specifiction 2.0 for more details) was
not reset.

These registers could be changed by the firmware or OS, let them have
their initial value in reboot so that the OS can read their clean status.

Fixes: e1706ea83da0 ("hw/cxl/device: Add a memory device (8.2.8.5)")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
root_port, usp and dsp have the same issue, if this patch get approved,
I will send another patch to fix them later.

V2:
   Add fixes tag.
   Reset all dvsecs registers instead of CTRL only
---
 hw/mem/cxl_type3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b0a7e9f11b64..4f09d0b8fedc 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "hw/pci/msix.h"
 
 #define DWORD_BYTE 4
+#define CT3D_CAP_SN_OFFSET PCI_CONFIG_SPACE_SIZE
 
 /* Default CDAT entries for a memory region */
 enum {
@@ -284,6 +285,10 @@ static void build_dvsecs(CXLType3Dev *ct3d)
              range2_size_hi = 0, range2_size_lo = 0,
              range2_base_hi = 0, range2_base_lo = 0;
 
+    cxl_cstate->dvsec_offset = CT3D_CAP_SN_OFFSET;
+    if (ct3d->sn != UI64_NULL) {
+        cxl_cstate->dvsec_offset += PCI_EXT_CAP_DSN_SIZEOF;
+    }
     /*
      * Volatile memory is mapped as (0x0)
      * Persistent memory is mapped at (volatile->size)
@@ -664,10 +669,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
     if (ct3d->sn != UI64_NULL) {
-        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
-        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
-    } else {
-        cxl_cstate->dvsec_offset = 0x100;
+        pcie_dev_ser_num_init(pci_dev, CT3D_CAP_SN_OFFSET, ct3d->sn);
     }
 
     ct3d->cxl_cstate.pdev = pci_dev;
@@ -907,6 +909,7 @@ static void ct3d_reset(DeviceState *dev)
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d);
+    build_dvsecs(ct3d);
 
     /*
      * Bring up an endpoint to target with MCTP over VDM.
-- 
2.29.2

