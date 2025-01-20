Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC60182BC
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 03:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737342675; cv=none; b=Lf1ls6jPMbK79dGFTu2DjaHD1OcZkVcD0Nc+n1MQINH0+Sl0djCZ+OWvtihaN3GX9jCCG+0ScxMzUUAy46SrZiFh2clhr/8sg4wPxY6/kGqaaV/Qj/Gc7pz1nD68VNNXVmcN+LoheCHdwXh+U/80egSTxYNJDEJ6wEXZN3pLCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737342675; c=relaxed/simple;
	bh=nYOxTDylACvmP6qrLuOl+iu07QERTW/jLVVEpGxqnfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UmjpTRwdO3A+SLuKKkCQQuf4hWbpZcfQ9QYaP6/yW25G57QL/6qQWObp7/mCw5MVSDFk995kiqu1LLnjWw8DQygeaV40Fx5btjnk9hIeoKdgu1CIAtG+ETUau+DMKhdO9NDp0OZuxe/oZ3LitHkPK7tEbC6CO/PEDUs084USKSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Adu0OTq6; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Adu0OTq6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1737342673; x=1768878673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nYOxTDylACvmP6qrLuOl+iu07QERTW/jLVVEpGxqnfo=;
  b=Adu0OTq6e/fEVMjJULeAB6ZTkSsGCuutjFL5nWPTk0R6xYDjRDdPYLdj
   0n99rxGEKfaiwMz6VR0iJIeK3Mt4Fg4kHJHJZA7ZjUWgFmKJhjWXWsyVN
   IAulo8So59G8h6tAzdM6/Iz3T7qCbl2T6RA6a3qB4f7mVA41HJ6CjAI8o
   jWsXwCDVQXEUxgOIuOYOjddeKbqfLMFRrFwfjZkCYUwwPBAka1KFmRlPC
   Md7/PYPXTlnaJk0EHuGNfla3/FYw4lFAiTRdPPaf+gvsrMC7poCxNdOHN
   A1XpFB51ntsL8eybEkyCMhbxpmd4LDSkeJhcGIgWP3mDTlcMqzsvT8VuO
   g==;
X-CSE-ConnectionGUID: rW23ircVTOKlfewny+I0xQ==
X-CSE-MsgGUID: /S8nfvBUR6ak59GxHwSXpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="175449005"
X-IronPort-AV: E=Sophos;i="6.13,218,1732546800"; 
   d="scan'208";a="175449005"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 12:09:59 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8857CD6EA7
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 12:09:57 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5CBF610432
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 12:09:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E21746BACB
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 12:09:56 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6B1111A0071;
	Mon, 20 Jan 2025 11:09:56 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 3/3] hw/mem/cxl_type3: Ensure errp is set on realization failure
Date: Mon, 20 Jan 2025 11:09:47 +0800
Message-Id: <20250120030947.254930-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250120030947.254930-1-lizhijian@fujitsu.com>
References: <20250120030947.254930-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10-2.571100-10.000000
X-TMASE-MatchedRID: DVe2RIcZexn+iwYk8es7vxFbgtHjUWLy2FA7wK9mP9dULhp+W/a9mb8F
	Hrw7frluf146W0iUu2tMCgkc3/BmTUwYXRRr2ymnzr16YOzjZ126hgVvSdGKo5NciW4ks8ZLbf4
	4QeBkGfvi8zVgXoAltuJ5hXsnxp7jC24oEZ6SpSmcfuxsiY4QFP2uYHfvH0BeyPnbtDEL25Nc5N
	vwi7UFuJWuTH306ghoOV8kmsf1pLOGjucNK4EBjs3VrL4N2KveoBg/1GfUNgr5rOGgS9jIc5sNE
	GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Simply pass the errp to its callee which will set errp if needed, to
enhance error reporting for CXL Type 3 device initialization by setting
the errp when realization functions fail.

Previously, failing to set `errp` could result in errors being overlooked,
causing the system to mistakenly treat failure scenarios as successful and
potentially leading to redundant cleanup operations in ct3_exit().

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/mem/cxl_type3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 9eb3d0979cf5..c3b6a1d6a612 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -883,7 +883,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                      &ct3d->cxl_dstate.device_registers);
 
     /* MSI(-X) Initialization */
-    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
+    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, errp);
     if (rc) {
         goto err_free_special_ops;
     }
@@ -904,7 +904,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_cap_deverr_init(pci_dev);
     /* Leave a bit of room for expansion */
-    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
+    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, errp);
     if (rc) {
         goto err_release_cdat;
     }
-- 
2.47.0

