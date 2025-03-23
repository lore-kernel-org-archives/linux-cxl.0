Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D592AE68
	for <linux-cxl@vger.kernel.org>; Sun, 23 Mar 2025 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742717142; cv=none; b=PlD4VOnC1FXFFBOznx7JRVyZe+UcqP5QyGle1Pikgd8v0ALzQJIQbGH8S9t8+qMSOKOTx1h4DII78pxvb9yEEjEgQA73dc34lCnQ/QkeK0qKyjNz+CVh6/xf7STuPmC0eyMmiCkEGPATKzYdL3i2gRctbuHj7vbkP+ic4FFWHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742717142; c=relaxed/simple;
	bh=58LqqjA2NDxKt5Zx4AeK6Ham2POP/vmhVzEhbT7fq3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJk5ORddmZvW+WIztf4tjXPqRtJA+DbsFp7f+wbd69FbE45h9nJ2y/A5bw4ZzmceOb76jG7CpUFBp80Bcu433p3eNyzUTH2sjwCShEOghOYe/49iL6QMoDRtEwLNo3YLStrpXhkeZuEaQk6rPvCv3HzFl7HcK3J8Gu+GDRY5F5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=rD/MiEHN; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="rD/MiEHN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1742717140; x=1774253140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=58LqqjA2NDxKt5Zx4AeK6Ham2POP/vmhVzEhbT7fq3g=;
  b=rD/MiEHNzR11jkNmK1EVM5E6duEmeG7p6gSiEMFVVlLK5jr7NfopObeO
   DDHismQxoaF16tRSC7kmR9+0/3QCkCt5GFu+DwJw3LAlQZ4cYlWP3CdmM
   wwYlbYCfBvynlZO6S3+fSYclFsLvdde8mUDg/Qt7tDfKiQi0VcQpkaqfB
   35mo23DO0KRyXmhaJe+nFRD9F/g/EH5QotYDy+tOIUCaKKtfeAdEvlJ8k
   5+5oONHIjYWX64wnzoxeAf3l/VJ+BzNSduTgC9X7MhPoVwV8WUBOM9BS1
   ErToLMKAM5csg9L1QdQFe2odID3JO9R0lKuX0ZkifMhA4M2hmdKGs0pDg
   A==;
X-CSE-ConnectionGUID: mLrFizDlSGOREYxcZPxgAQ==
X-CSE-MsgGUID: uPSv+md0RYapE4pgBNm8Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="172788276"
X-IronPort-AV: E=Sophos;i="6.14,269,1736780400"; 
   d="scan'208";a="172788276"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 17:04:29 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 85CC1DC717
	for <linux-cxl@vger.kernel.org>; Sun, 23 Mar 2025 17:04:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 44616D7723
	for <linux-cxl@vger.kernel.org>; Sun, 23 Mar 2025 17:04:27 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E6BF01A00A0;
	Sun, 23 Mar 2025 16:04:25 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
	qemu-devel@nongnu.org
Cc: Fan Ni <fan.ni@samsung.com>,
	linux-cxl@vger.kernel.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] hw/pci-bridge/pci_expander_bridge: Fix HDM passthrough condition
Date: Sun, 23 Mar 2025 16:04:20 +0800
Message-ID: <20250323080420.935930-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reverse the logical condition for HDM passthrough support in
pci_expander_bridge. This patch ensures the HDM passthrough condition
is evaluated only when hdm_for_passthrough is set to true, aligning
behavior with intended semantics and comments.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---

This change corrects what appears to be a previous mistake in logic
regarding HDM passthrough conditions.
---
 hw/pci-bridge/pci_expander_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 3396ab4bdd..25f8922d76 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -307,7 +307,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
      * The CXL specification allows for host bridges with no HDM decoders
      * if they only have a single root port.
      */
-    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {
+    if (PXB_CXL_DEV(dev)->hdm_for_passthrough) {
         dsp_count = pcie_count_ds_ports(hb->bus);
     }
     /* Initial reset will have 0 dsp so wait until > 0 */
-- 
2.41.0

