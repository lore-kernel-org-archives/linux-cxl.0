Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B022FDF7
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927927; cv=none; b=dDmlZR3Ca0p7LAmIWlUOViw9He0LmzbcXH3zb9Ma9tdRkomGSUCcLJmRu+3L7uJOkTv0/48U87vw5ebcMWUoDWSY/1CyIecM7IXpLMUam+j9s3cOnrvivkgptVmrCSmBEABixolv8gZcomSRmKbHQmxhj4+G+8Uyklg1hurULs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927927; c=relaxed/simple;
	bh=jQDeMN5xwl1RJXxiEogsOPcsBD/ElhkO4QpF1REr5uk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aWW2rmTXee7/7Auy38XeAQHGG7iqJctaOvYBeZyoysyGTCNnAixT/xQR56mCLfCdp0tq3j3bfqGCNGWkrUaT7GQpTAiWIORV5+ntFBsBpZtoYHBedQYxXYhvfofLQinTof+fTYAnXQJW7E2/GptmwtTQ1MYptTDxpy/0DE4laMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=K52lbylZ; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="K52lbylZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736927926; x=1768463926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jQDeMN5xwl1RJXxiEogsOPcsBD/ElhkO4QpF1REr5uk=;
  b=K52lbylZUZOLVVc/xtfqGzuI5KO+RHvCKUQN9lVvM+vjQ0D01MrTBEu2
   pO1BwCr7LU6mVd+lSpJEvc9LitalA9SQp1aNR7y7wQWentfnTAuSYi1id
   M8HgpVS4q3dIS3JrQH3wj+IalejzSicGS0xFOuvEFO3wJcvAy+NNmjDZQ
   gsj42cYEtN6MPV+R2T2rtoR7TkFSfh2GL+EGqo8s6dz/4n+jAg42eTKhh
   Qv8C4d3aHmpyTQP2ZkYe5VMEQnAClGV+wVXhXiou8XepWlvAZT7s+xo0n
   OGU9k3r7TKMmUFHm1LUkHFUPBktAD1K3BxiUAZdUebKvA+KJNe/L38V82
   A==;
X-CSE-ConnectionGUID: FryIJx7eQ2OCgXx3dXb2KQ==
X-CSE-MsgGUID: L+onPQpPQWSn/LbBkfAr/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="186637340"
X-IronPort-AV: E=Sophos;i="6.12,316,1728918000"; 
   d="scan'208";a="186637340"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 16:58:43 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id DABD6DE67A
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 16:58:40 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id AF5C2D88D9
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 16:58:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3501C20071A37
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 16:58:40 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 582B81A000B;
	Wed, 15 Jan 2025 15:58:39 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3] hw/cxl: Fix msix_notify: Assertion `vector < dev->msix_entries_nr`
Date: Wed, 15 Jan 2025 15:58:34 +0800
Message-Id: <20250115075834.167504-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28924.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28924.005
X-TMASE-Result: 10--1.451200-10.000000
X-TMASE-MatchedRID: llTo18AJfvHCVJdexVBqdn1zro62qhdCLL6mJOIs/vZGQgIVrmBL5G7l
	BX/37R4p+xFlvZshf1aUrbS7Rz/s6duWQuISDK/kF63b38RTfu8bbhhV65kaY1gLks93sG9tOiw
	t/WQfkJ/tRjFyEsLiS4fv9hpetzmsL/tBTZzO5Q0D2WXLXdz+AVK6+0HOVoSoP/c8VwmgfSOjxY
	yRBa/qJXcsDK2xBHh7jaPj0W1qn0TGVuWouVipcs92lnk/vvrz/Vzb9/cD9OdIQGnyl2vpAl1nS
	gx1e+RcLNDgPaZ4SCFOIvGQcPibAygA7v0fn2MGBA2j/sFHfYC/yGMuHed7PxFltGxCTkwFQHVA
	+r1vGdZmQDEDCMiuswfP8fSSIvISoYC0cwOOST0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This assertion always happens when we sanitize the CXL memory device.
$ echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize

It is incorrect to register an MSIX number beyond the device's capability.

Increase the device's MSIX number to cover the mailbox msix number(9).

Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
  Just increate the device's msix number, A new enumeration will be introduced in later patch. # Jonathan

V2:
  Just increase msix number and add enum to maintainer their values # Jonathan
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index bd7652740f4b..0ae1704a345c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -843,7 +843,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 6;
+    unsigned short msix_num = 10;
     int i, rc;
     uint16_t count;
 
-- 
2.47.0

