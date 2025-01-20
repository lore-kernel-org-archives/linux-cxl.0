Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DBB182BC
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737342672; cv=none; b=iv8cHxrMDFfKjvdPE9iCa+PW9dzL11wilXSaCJAFnsRr0OCXMKfey5lslP8ZTDtxfRkOG3igBkVjojXllBuubtyp6zxygvQQY9N5ad4Sz6RpCShqHapDzf7K6uScXK3SvZ2na5XEbQonrGKLovw2R+wG2eDi7H7wew6Vj1b8rHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737342672; c=relaxed/simple;
	bh=EQIXurmzibcHcsG4mInmq0nLx5Lm78b8PKA8N1qOnJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k5tJWu8b4VeD+TfUGG2gcejHJI0WdnvwM6dczlhAVbfkAZAsEJF4hJaPKiivGJ9Rx2BWvHMx//GJD4rmu72PVrwAkwtZN2qrOkHg5pXViMy/Y8YRi+UZhxESgsHBp57t4TbzNvBtPGi3IzBval6o008NMzc0tf7wzp8wqbh8Zjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=lX5ttNMD; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="lX5ttNMD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1737342671; x=1768878671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EQIXurmzibcHcsG4mInmq0nLx5Lm78b8PKA8N1qOnJo=;
  b=lX5ttNMD4owXulCVXB75JfSRMmY9Cu81c04ZzTC8MzV2FTIjzX4BMBU4
   lPW/ezIslCmOFL2Mo7ncLr20mfi/75gAIxjxOnp43QgVKDMQFg8cOp66W
   9wJLdxI+UHZ2II+C4lBTgicJwML59RbpOYYRl4iH5Hc72ViHEA9CaXsYY
   FIVFWn4FpoByM6KVN/sez6RhfFGFlUCaEJlAH9s4g5akVIVA/ALy/SddB
   MUw6tFVGQ3PvC4U43VAJHqyz+DTt8qbhvhEhJxcQ85QDrxTFJkTr0Fkn1
   uX/DFaXjRhMkwmDQHSf18DyOEpsCEBoGDumga99owaMwJrZpuhWxoSgPh
   A==;
X-CSE-ConnectionGUID: SQtfFEbFTLmBLNgVslwZ/g==
X-CSE-MsgGUID: jJRS/eMQQnyCoaJt106Fsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="175449001"
X-IronPort-AV: E=Sophos;i="6.13,218,1732546800"; 
   d="scan'208";a="175449001"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 12:09:59 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id E664696743
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 12:09:56 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B87C9D5052
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 12:09:56 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3FED720071A22
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 12:09:56 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 5C8891A0071;
	Mon, 20 Jan 2025 11:09:55 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/3] hw/mem/cxl_type3: Add paired msix_uninit_exclusive_bar() call
Date: Mon, 20 Jan 2025 11:09:45 +0800
Message-Id: <20250120030947.254930-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28934.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28934.004
X-TMASE-Result: 10-0.176100-10.000000
X-TMASE-MatchedRID: toN6SH028bUy7r9tI4sSuomfV7NNMGm+1GdxOr7L6H2u9yzHHu0ZiSZl
	e49VkKqHIvrftAIhWmLy9zcRSkKatXwzxAv8kID0zr16YOzjZ13QiNv55aRoGrqln+jYe7Zh17f
	TaRrC7JloAzXI4Nhg5341niV9KymzHxPMjOKY7A/+HHE8LDNSg8RB0bsfrpPIcSqbxBgG0w4cPL
	OQ+phrrYqdbFd4X7QAKvPEkuwr1iSKfjOIOfJrLtIq+VrwLz72zNQ3fXMkh2SDToamn92pqqZUo
	ggwSSPywmvPT4lO6OdbjBuldNvkMkoq97WSHdFjfupJaud1uZCfRs6uIbkFVw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

msix_uninit_exclusive_bar() should be paired with msix_init_exclusive_bar()

Ensure proper resource cleanup by adding the missing
`msix_uninit_exclusive_bar()` call for the Type3 CXL device.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/mem/cxl_type3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f64af19ed6ae..9dad250f56d5 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -936,6 +936,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 err_release_cdat:
     cxl_doe_cdat_release(cxl_cstate);
 err_free_special_ops:
+    msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
 err_address_space_free:
     if (ct3d->dc.host_dc) {
@@ -959,6 +960,7 @@ static void ct3_exit(PCIDevice *pci_dev)
 
     pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
+    msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
-- 
2.47.0

