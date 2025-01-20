Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B82A1D8
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737342673; cv=none; b=h8isBzHsoFEixAgFzF1+CAiXS5prb2KT42OL+z2DQmI22OYhSASxdePz2mkm9zFxQPnUuMZOlKEDEn2nDS79yNDzg43f7aiQZSz7VlHoFOpFJHBRfkU9oF4pWlih8qAMhg+JIxhBg/ccGz1GFSIJFpos89m9dLd1im9YL20dwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737342673; c=relaxed/simple;
	bh=nXzUK/sz09DWb4nGyQfonpqJK7eujChpZ4+W5SccXTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ew9jSAXA6lDJNKOSiHX0Mfli1EjJVZgJT26Uvx7d+Nuv0TLnYI7U78fKADNIYCY4KuuJFyJqJm1rq1NNlp0hIUlE8eDaROOoXboCVf/EN8TkIYFUk6vv0HCa/42F+vOLUZBaIS8yZOXjcHdeVyZXhrog23cWC76M9tTf3EYSOR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=q4W9Ey1U; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="q4W9Ey1U"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1737342670; x=1768878670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nXzUK/sz09DWb4nGyQfonpqJK7eujChpZ4+W5SccXTM=;
  b=q4W9Ey1UqBMAuZoCrzF+zCi+GRp0C1yrBgPxARZYmyvu3UPDcqngsAoi
   5qbbV0xPavLaa+65okjRqM8HIYhFD7t9Gnjl0PFn9c8ikG+jLu5Xw1HtR
   nkBujckn0o6xuaA7ZFPCOBkKwIU81wRsPz8KZePCEakOR+HvM+SdKxvwv
   eMQXhxMLZWMcbSwMd4dA9wxyOUYus4r392N8UeKXG0bum5pYLEMYsaxSf
   KnL66f2+4ZSqMtDd+qwxxgqbJXxnxdAvN+iobKbJ4yeeMg2SRtxLAq/5s
   hsVT/w30l95fok42VFqVl+YIQvWVFn0VM0ujkIKOZfDApFQ31QUgcyaFu
   g==;
X-CSE-ConnectionGUID: zvdYl+xeSMOhM0irvVy+mA==
X-CSE-MsgGUID: eWBxSpEaREO+6IHj5HG3LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="165960119"
X-IronPort-AV: E=Sophos;i="6.13,218,1732546800"; 
   d="scan'208";a="165960119"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 12:09:58 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 39AB7D4C84
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 12:09:57 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0E488BF3E6
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 12:09:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 902F520074739
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 12:09:56 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 0D40D1A0073;
	Mon, 20 Jan 2025 11:09:56 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 2/3] hw/mem/cxl_type3: Fix special_ops memory leak on msix_init_exclusive_bar() failure
Date: Mon, 20 Jan 2025 11:09:46 +0800
Message-Id: <20250120030947.254930-2-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--4.187500-10.000000
X-TMASE-MatchedRID: VbO/xkC3pzsHdJSFlLCdzomfV7NNMGm+w4SuXsUCGYgli8Y5a0svL9e3
	02kawuyZnuC4VmJFPYZZO+ygKNx8vKWgCWYvFMxFxVQFfLw4zf+6hgVvSdGKo8C5DTEMxpeQfiq
	1gj2xET856WD6kuo88S//MlDRqI8mEd0YyW6tLbmCM7Vvo31KuH0tCKdnhB589yM15V5aWpj6C0
	ePs7A07aqzOOiUJy/IuinVLBUcG6y5uCtM/wfGlIx9zWcOKuXW2Kph7/SS809B/LeDv7BJAMkja
	rEF4+w+uSGtLYy5tELefneus6YT/gd0ruCUrh2IhpPsVGqnTA8BxCsB8GHr28FEsV4fo4lIJMMP
	4MGO4TA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Address a memory leak issue by ensuring `regs->special_ops` is freed when
`msix_init_exclusive_bar()` encounters an error during CXL Type3 device
initialization.

Additionally, this patch renames err_address_space_free to err_msix_uninit
for better clarity and logical flow

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/mem/cxl_type3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 9dad250f56d5..9eb3d0979cf5 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -885,7 +885,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     /* MSI(-X) Initialization */
     rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
     if (rc) {
-        goto err_address_space_free;
+        goto err_free_special_ops;
     }
     for (i = 0; i < CXL_T3_MSIX_VECTOR_NR; i++) {
         msix_vector_use(pci_dev, i);
@@ -899,7 +899,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
     cxl_cstate->cdat.private = ct3d;
     if (!cxl_doe_cdat_init(cxl_cstate, errp)) {
-        goto err_free_special_ops;
+        goto err_msix_uninit;
     }
 
     pcie_cap_deverr_init(pci_dev);
@@ -936,9 +936,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 err_release_cdat:
     cxl_doe_cdat_release(cxl_cstate);
 err_free_special_ops:
-    msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
-err_address_space_free:
+err_msix_uninit:
+    msix_uninit_exclusive_bar(pci_dev);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
-- 
2.47.0

