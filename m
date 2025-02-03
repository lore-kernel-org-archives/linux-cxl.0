Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2C2204C34
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599647; cv=none; b=NEhmzvZwpnffO1gA4gT0gcf50LzYvgip6qpDFxkUlGj17CHaXG/DAaqgfd4qVbAahZ/B+vUCp0ypwTIX3I1vGVWNg9sC86271VYIDWy2Q6zEtgNyGjaC5Cy0ZivyxqLyDfY86Cbn6mWSv0hx6+TI2DwHc4JJHk1yE54JrSR2Pzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599647; c=relaxed/simple;
	bh=gEaE/S7ZgBHITGJdx7ynkg/+pWGAPJy8YPErFYCrEfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSbfNKh8lYK6M0FLPwaU2OlOsZWbneVsmF5RK07pSaEO6NIQm7akWVFrSwEv+9alkoA5l+WjKCw1N/r1P945hfh1jovJeOMBuAxW+xhUnjk5+NQD4ryMJFgoR4e61qRqycTwVWGoTbjsvc0MKpXzVC9elImhI6qGxCMhKD05bJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yms9Y5HDCz67HnY;
	Tue,  4 Feb 2025 00:18:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 239E3140B3C;
	Tue,  4 Feb 2025 00:20:42 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 17:20:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 3/5] hw/mem/cxl_type3: Fix special_ops memory leak on msix_init_exclusive_bar() failure
Date: Mon, 3 Feb 2025 16:19:06 +0000
Message-ID: <20250203161908.145406-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
References: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Li Zhijian <lizhijian@fujitsu.com>

Address a memory leak issue by ensuring `regs->special_ops` is freed when
`msix_init_exclusive_bar()` encounters an error during CXL Type3 device
initialization.

Additionally, this patch renames err_address_space_free to err_msix_uninit
for better clarity and logical flow

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4775aab0d6..ff6861889b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -893,7 +893,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     /* MSI(-X) Initialization */
     rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
     if (rc) {
-        goto err_address_space_free;
+        goto err_free_special_ops;
     }
     for (i = 0; i < CXL_T3_MSIX_VECTOR_NR; i++) {
         msix_vector_use(pci_dev, i);
@@ -907,7 +907,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
     cxl_cstate->cdat.private = ct3d;
     if (!cxl_doe_cdat_init(cxl_cstate, errp)) {
-        goto err_free_special_ops;
+        goto err_msix_uninit;
     }
 
     pcie_cap_deverr_init(pci_dev);
@@ -943,10 +943,10 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
 err_release_cdat:
     cxl_doe_cdat_release(cxl_cstate);
-err_free_special_ops:
+err_msix_uninit:
     msix_uninit_exclusive_bar(pci_dev);
+err_free_special_ops:
     g_free(regs->special_ops);
-err_address_space_free:
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
-- 
2.43.0

