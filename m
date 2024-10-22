Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759017993;
	Tue, 22 Oct 2024 01:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561641; cv=none; b=hR161MLS0QfDrBzGjY5YFtMrBm4nN8Q9OxHgRkYYnrQPVDuASVEWTVwlXN3QDNZOxTSP8FxbLxrFB0xd5NZI9Jm2hkc3UdJhCDXxezwJ4/QFMwNshCmec24vzaCCBTyq6QuZEOPFrqIzAOU0Que+5eYgdaWZwKZBKHplq/sG86I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561641; c=relaxed/simple;
	bh=trcPzXO81btNBxnWfEODWpq59HemdULlrxWveNd/xjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HntZHWANz1+QrnB2wqoJRT/sUQc2bNH0nQMm6UYe/blNkAjBin+I8IukGq5ofIA8vjez7esRaKg+EW5+fTIvWCDIjqIncyN3pm1AUf6LlOzfGgNOnFj719hIjM9BO0qne4D+KRRwzxkq/q4S/nO+Ug1M0UBanxpKUyw0gK4uCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GekIshGN; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GekIshGN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729561639; x=1761097639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=trcPzXO81btNBxnWfEODWpq59HemdULlrxWveNd/xjg=;
  b=GekIshGN8TK6lEZMgf8Yfn3zg010h/wE7OhurS/xNG9jOK91Dvks7tUX
   2AQI9PyRSVCIyYNdHWnN84/+c0xceHrO4UWOUb9mwEXJwPH6KtsHk2u91
   p7ZWNc6SVJakyzbsAp0/kD+4s9uijImKh+PzJvYzb3PgfFmMwtJOdmzk5
   nViA1RVozCmy83wtzZeJiRub8WokfB44US3c3YW0/w8HkxTlxH0Z8qQm6
   gXoTeEJc1q6ApOARBtWKEX7ljMKekYQf5+xsm6yRh5PUeadus3GcxQD1i
   jhd3+e9XKsaKnfYAXhSUkKMDNOvxzk4x2IFqlCiaKcgZ/5AkozsrdgtFS
   Q==;
X-CSE-ConnectionGUID: aOH9OA5xSKKIPXgKL+NytA==
X-CSE-MsgGUID: TbkebVUWR1mfJoUfEr+SAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="179693976"
X-IronPort-AV: E=Sophos;i="6.11,221,1725289200"; 
   d="scan'208";a="179693976"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 10:47:10 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 24BECD4F56;
	Tue, 22 Oct 2024 10:47:08 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 567F112689;
	Tue, 22 Oct 2024 10:47:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id BD71A20071A06;
	Tue, 22 Oct 2024 10:47:06 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D36B11A000B;
	Tue, 22 Oct 2024 09:47:05 +0800 (CST)
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
Subject: [PATCH v2] cxl/core: Return error when cxl_endpoint_gather_bandwidth() handles a non-PCI device
Date: Tue, 22 Oct 2024 09:47:45 +0800
Message-ID: <20241022014745.231085-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28746.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28746.003
X-TMASE-Result: 10--2.919100-10.000000
X-TMASE-MatchedRID: H0y8l0/iTDe/CtrsiqyIUm03YawHJvPCuJpeHGRhXLF3de2OoBqgwolV
	jyyDX0fc2O8rx6ppBPhMQ8GITGODLT6fxw7fU9CZrMZ+BqQt2Nos9yCYjUR6SwnnZ4xTn7Kc9zA
	iLEDfYyml6OL12n7TiQOROoI9OuFOLvv2cUtLK/uZUG41i0Kjm/CrUlDnEXiSrvcsxx7tGYlChx
	BtpL1dHOFLYP4K7nGWtd9Cjy2dY4UpQVmYppf1gJ1U1lojafr/G24YVeuZGmOHjx+zJg4EmhskA
	daEfeQKidRdS3HmrXzkF9vFPTrZfC7SL1WWCs3qEXjPIvKd74BMkOX0UoduuZMWvwVjQ0C5GEG9
	aBmVf7zi8zVgXoAltsZfJcPORGlUC24oEZ6SpSmcfuxsiY4QFBdpHIY59+pWnWQv/+R82tbELHz
	hFhI0UdyWqM2IrLCbcRkOuGZJw5Jb8ZwKa8hM8NAlGt9KR6QUehPjPKBA+LHnURryLONa65sNEG
	pLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The function cxl_endpoint_gather_bandwidth() invokes
pci_bus_read/write_XXX(), however, not all CXL devices are presently
implemented via PCI. It is recognized that the cxl_test has realized a CXL
device using a platform device.

Calling pci_bus_read/write_XXX() in cxl_test will cause kernel panic:
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
V2:
  Check device type in original cxl_endpoint_gather_bandwidth() instead of mocking a new one. # Dan
  Also noticed that the existing cxl_switch_gather_bandwidth() also have the same check.
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/cxl/core/cdat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index ef1621d40f05..1a510e692ac0 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -641,6 +641,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
 	void *ptr;
 	int rc;
 
+	if (!dev_is_pci(cxlds->dev))
+		return -EINVAL;
+
 	if (cxlds->rcd)
 		return -ENODEV;
 
-- 
2.44.0

