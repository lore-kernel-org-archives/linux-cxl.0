Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152769D2B;
	Wed, 16 Oct 2024 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043508; cv=none; b=LlA3gmb1e97IDN73mMmyXMXnU14Eb8IsIqz/UDzzhdQLzSpFjBsBd0FdsHBmz5pF64ZcrW+fyvCy4w5emjtzRtAmTigGgAy/YO0wWrTd1w7wZWav2zHBVU82si2rd5BoyXdqql9ToBcs8m+TqUZdFhspu2zsyE0SiiAD2XuZG30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043508; c=relaxed/simple;
	bh=j7qOHC4J4CEpVnKIhfVxPI4BkVnPiOW+nm/eX7OdYm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KA23yGc2v2zDrtTPNh0UyC+tvph8HH2rT19uBIe//AlodY202/DcDeSLlRYj0C37Yi2wqIqIz/Oo1wTRP9nj78yR/jLsn7PXhrAWy/co4W5WapNxDCl21BS8o+42fb6A0SzXkg10zsJIILUafOnjy40MP8Ijv1QHtAd7kF3swqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KTddlpuV; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KTddlpuV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729043505; x=1760579505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j7qOHC4J4CEpVnKIhfVxPI4BkVnPiOW+nm/eX7OdYm0=;
  b=KTddlpuV/siw5xGxuzTUoOql3XGK/yyxGO0p7Kr/MEmUZcFzy1PlmUXZ
   J4OkITbIv8x9MA2xXIS1fhX8wK0EuGilom6PGJO5YJ95Rhc0oU3va4UQm
   23cYxDcBqgM7Wvdb9aUqOZ/+BkGM7HUPs8+86Fj6xOEg4CUOhGzaHqK1e
   YiWLy3TDvW4sNObbPKfKFTPDR9WFDyoFM0JXv1hKi02hdNEU8KNsX4GrT
   Y8bVwfXdUJvAu8TNvZjukiPzhI9dVjaFhz8Yfa3wqtOHAIgxV0YE3Sg53
   BADpY3fm4Ymc3eWDgBxGz95+qgRNZAzJ7MX7XsfA10RxkAjfhyXJRFw19
   w==;
X-CSE-ConnectionGUID: 3dIjEyeQRSaq3ES0LbST+g==
X-CSE-MsgGUID: fCigllwgQ16FCJpFk2qUNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="155759722"
X-IronPort-AV: E=Sophos;i="6.11,206,1725289200"; 
   d="scan'208";a="155759722"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 10:51:34 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E792DD800A;
	Wed, 16 Oct 2024 10:51:32 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id BBC5ED8CB4;
	Wed, 16 Oct 2024 10:51:31 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5320B20071A2B;
	Wed, 16 Oct 2024 10:51:31 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 729841A000B;
	Wed, 16 Oct 2024 09:51:30 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Huang, Ying" <ying.huang@intel.com>
Subject: [PATCH] testing/cxl: Fix abused pci_bus_read_config_word() on platform device
Date: Wed, 16 Oct 2024 09:52:13 +0800
Message-ID: <20241016015213.900985-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28734.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28734.003
X-TMASE-Result: 10--9.738800-10.000000
X-TMASE-MatchedRID: 5tAkVIfDYR6/CtrsiqyIUhFbgtHjUWLya9qiaDSLgo3j7F/ald2q5Nxp
	athSJH+2A9H5R5f2ce3Xcf4B0rHCc7+wzU3ImWPrkCThXPqsqivSde/CNbaZJdALOWoT1h/Un+n
	rvjaMDYE07flFHfXJs3UofCUICGvnPetSk5bB6twCOoDG5aR1MW+twLxyosqhuSp7W+BawKAfg4
	t/uEEkXM+7+sxizLzN8e8JBtC0n8uzVFZ6osYjDoL5ja7E+OhyV9/n5IZng2Q6FHRWx2FGsI3ce
	RXYSJoDIvrftAIhWmLy9zcRSkKatQ719kpOO37PCtzGvPCy/m5SuvtBzlaEqFH3rkvzbWPM4Ibz
	3CH3vCeZL0XMB8MktZ2oLZ8u2T3EHxPMjOKY7A9t1O49r1VEa8RB0bsfrpPIfiAqrjYtFiTnZwI
	PZIlPj4+nYgHbS6oneIvBCuZpVZJyl8yGHuEJkH7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The cxl_region_shared_upstream_bandwidth_update() in clx_core works on
PCI/PCIe CXL device only while cxl_test was implemeneted by platform
device.

Mock a cxl_region_shared_upstream_bandwidth_update() which does nothing
for cxl_core so that the cxl_test goes well.

Abuse cxl_region_shared_upstream_bandwidth_update() on platform device
will cause a kernel panic with calltrace:
 platform cxl_host_bridge.3: host supports CXL (restricted)
 Oops: general protection fault, probably for non-canonical address 0x3ef17856fcae4fbd: 0000 [#1] PREEMPT SMP PTI
 CPU: 1 UID: 0 PID: 9167 Comm: cxl Kdump: loaded Tainted: G           OE      6.12.0-rc3-master+ #66
 Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
 Hardware name: LENOVO 90CXCTO1WW/, BIOS FCKT70AUS 04/23/2015
 RIP: 0010:pci_bus_read_config_word+0x1c/0x60
 Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 53 b8 87 00 00 00 48 83 ec 08 c7 44 24 04 00 00 00 00 f6 c2 01 75 29 <48> 8b 87 c0 00 00 00 48 89 cb 4c 8d 44 24 04 b9 02 00 00 00 48 8b
 RSP: 0018:ffffa115034dfbb8 EFLAGS: 00010246
 RAX: 0000000000000087 RBX: 0000000000000012 RCX: ffffa115034dfbfe
 RDX: 0000000000000016 RSI: 000000006f4e2f4e RDI: 3ef17856fcae4efd
 RBP: ffff8cc229121b48 R08: 0000000000000010 R09: 0000000000000000
 R10: 0000000000000001 R11: ffff8cc225434360 R12: ffffa115034dfbfe
 R13: 0000000000000000 R14: ffff8cc2f119a080 R15: ffffa115034dfc50
 FS:  00007f31d93537c0(0000) GS:ffff8cc510a80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f31d95f3370 CR3: 00000001163ea001 CR4: 00000000001726f0
 Call Trace:
  <TASK>
  ? __die_body.cold+0x19/0x27
  ? die_addr+0x38/0x60
  ? exc_general_protection+0x1f5/0x4b0
  ? asm_exc_general_protection+0x22/0x30
  ? pci_bus_read_config_word+0x1c/0x60
  pcie_capability_read_word+0x93/0xb0
  pcie_link_speed_mbps+0x18/0x50
  cxl_pci_get_bandwidth+0x18/0x60 [cxl_core]
  cxl_endpoint_gather_bandwidth.constprop.0+0xf4/0x230 [cxl_core]
  ? xas_store+0x54/0x660
  ? preempt_count_add+0x69/0xa0
  ? _raw_spin_lock+0x13/0x40
  ? __kmalloc_cache_noprof+0xe7/0x270
  cxl_region_shared_upstream_bandwidth_update+0x9c/0x790 [cxl_core]
  cxl_region_attach+0x520/0x7e0 [cxl_core]
  store_targetN+0xf2/0x120 [cxl_core]
  kernfs_fop_write_iter+0x13a/0x1f0
  vfs_write+0x23b/0x410
  ksys_write+0x53/0xd0
  do_syscall_64+0x62/0x180
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

And Ying also reported a KASAN error with similar calltrace.

Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/linux-cxl/87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com/
Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/cxl/Kbuild      | 2 ++
 tools/testing/cxl/mock_cdat.c | 8 ++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 tools/testing/cxl/mock_cdat.c

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index b1256fee3567..ed9f50dee3f5 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -15,6 +15,7 @@ ldflags-y += --wrap=devm_cxl_add_rch_dport
 ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=cxl_dport_init_ras_reporting
+ldflags-y += --wrap=cxl_region_shared_upstream_bandwidth_update
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
@@ -61,6 +62,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
+cxl_core-y += mock_cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
diff --git a/tools/testing/cxl/mock_cdat.c b/tools/testing/cxl/mock_cdat.c
new file mode 100644
index 000000000000..99974153b3f6
--- /dev/null
+++ b/tools/testing/cxl/mock_cdat.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 FUJITSU LIMITED. All rights reserved. */
+
+#include <cxl.h>
+
+void __wrap_cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
+{
+}
-- 
2.44.0

