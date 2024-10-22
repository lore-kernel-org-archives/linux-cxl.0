Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61426281;
	Tue, 22 Oct 2024 03:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566092; cv=none; b=mGIAZDLtBaFFWZdjs0p8qpZDgielbVfHFpRKMaREiJNiwisCywH0jpPZL4qZQ6UHpO0AzYsdafCHVlGjUBPaiqM+C3FOOmQXCipg9pIOdDswu+2gTYmQJlMQSSOjsw0RVHqPK42QNxnGJYq4vkhDIpIGqcyyoomNQ3JQsb+5Tdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566092; c=relaxed/simple;
	bh=OqmSW+PZ75K8vygMvkaHIpjJJ9w6qrlByejanZJEk1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFJcWvlateMKXjfhb8lrX4IU6Hin3AAYy9qLVTHMPl+c+J5CRGCJjhG78/Y60u/1Lmx2Rfq03uadDOQplGmwiyX/Ex14QdLl7MkWLWDxJ0sqR26rGtsBvxorsCaS09XwtBp+RXXXAPaSWl+o/cKSjSr4BtckXY3DPnW83Lr0MdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=aWPq+1fA; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="aWPq+1fA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729566090; x=1761102090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OqmSW+PZ75K8vygMvkaHIpjJJ9w6qrlByejanZJEk1c=;
  b=aWPq+1fArsJkK4uI2eh4RaJp4lLNHUCKLoo0VLCBEDDN9o8BUR8fqywf
   NTUULR9MG+QOpjXP5TTQyKkdARB/+X8QhglCrKxn+8VLlh8PepK7oywEA
   1Qbm6UsfBM4TNIA5ZQ8ar4Uv8rV+ezvE0r9VwhfuA2wRg2gXN76kUNIHs
   gK0+T7QW5BU+TgkEcQw+mIg62b2saj9V1wzrDKDA3PQNZ28ErVqo8N/aY
   e9q67DQrrrhOGIsm1aNaAcMyUa1kZLv2rs2GSEsi9am5adq7NKJcpGp8K
   FAyFrs3RvuttrH0Bld+atOkUiYzX2mucKs8QCiLGXaJvBX77ophhQT7At
   g==;
X-CSE-ConnectionGUID: 0FkQAr/KSvOEV9Mbp4tUTA==
X-CSE-MsgGUID: 9hQ32j9mRCKtU140Dt+WOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="165493116"
X-IronPort-AV: E=Sophos;i="6.11,222,1725289200"; 
   d="scan'208";a="165493116"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:00:19 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 31244DB3C1;
	Tue, 22 Oct 2024 12:00:17 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5D6A9D9695;
	Tue, 22 Oct 2024 12:00:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E10B4E2A14;
	Tue, 22 Oct 2024 12:00:15 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E64E41A000B;
	Tue, 22 Oct 2024 11:00:14 +0800 (CST)
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
Subject: [PATCH v3] cxl/core: Return error when cxl_endpoint_gather_bandwidth() handles a non-PCI device
Date: Tue, 22 Oct 2024 11:00:54 +0800
Message-ID: <20241022030054.258942-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28746.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28746.004
X-TMASE-Result: 10--6.740200-10.000000
X-TMASE-MatchedRID: FY3Fgmk8Tgm/CtrsiqyIUm03YawHJvPCuJpeHGRhXLF3de2OoBqgwolV
	jyyDX0fc2O8rx6ppBPhMQ8GITGODLT6fxw7fU9CZrMZ+BqQt2Nos9yCYjUR6SwnnZ4xTn7Kc9zA
	iLEDfYyml6OL12n7TiQOROoI9OuFONb/zAqrSaDUCOoDG5aR1MX607foZgOWyBuPIqCTBSzEfg4
	t/uEEkXAa/vzANp5clSWpDJesgiOOk+AYa0R5ReKBw6BKdk7MxwMc7ZZ8e7/fSJfGV2JAq5BskA
	daEfeQKegz5rXV3e7SqcFoiuu90Xy/7QU2czuUNA9lly13c/gGLGrmaMd6vRwZZ8N3RvTMxo8WM
	kQWv6iX7ev9h4HyIA1cppCzPq+1UOwBXM346/+ydFXI3QoFqdfd7zn8KE4nff1x7MMBrYnyWfC2
	wFjGvMbAcXQZvnx3t
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The function cxl_endpoint_gather_bandwidth() invokes
pci_bus_read/write_XXX(), however, not all CXL devices are presently
implemented via PCI. It is recognized that the cxl_test has realized a CXL
device using a platform device.

Calling pci_bus_read/write_XXX() in cxl_test will cause kernel panic:
 platform cxl_host_bridge.3: host supports CXL (restricted)
 Oops: general protection fault, probably for non-canonical address 0x3ef17856fcae4fbd: 0000 [#1] PREEMPT SMP PTI
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
Closes: http://lore.kernel.org/87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com
Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
V3:
  update return code to ENODEV and change logs #Dan

V2:
  Check device type in original cxl_endpoint_gather_bandwidth() instead of mocking a new one. # Dan
  Also noticed that the existing cxl_switch_gather_bandwidth() also have the same check.
---
 drivers/cxl/core/cdat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index ef1621d40f05..e9cd7939c407 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -641,6 +641,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
 	void *ptr;
 	int rc;
 
+	if (!dev_is_pci(cxlds->dev))
+		return -ENODEV;
+
 	if (cxlds->rcd)
 		return -ENODEV;
 
-- 
2.44.0

