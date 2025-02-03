Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14846209F55
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599677; cv=none; b=hc1F/Tqp5fB2enG9GfwDPoO0jUP9uknCPBPxWzmPcUFBeRNAG43nbPKjatx20+OkKnC6jtzsKvghbo2BH73YvfBcYvvQIaE1LCONsqkpL/fN03nfnHhT6wQN98Kj4zo7EQT39+bmn86dnctRwdT89GbOVIcc4kRyL/xtM/Apc8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599677; c=relaxed/simple;
	bh=242XxMrjr8ab328Z+cmvjZECgYcQivwqizgwojwHJNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3nnNIm+lJIpFH8zeVkTpqbKLe5NKXXYxVTXMjlOTDZmVrMffHO88JPGKUEqezk0qBtwpEyDzZwBvfQ4lWMHHi5VsKcvwdHcuQp+i4yuJwZudvJC9ljYjhfejb34J8NPrVN1grvmv3561Vs68Y9LXwFtIPn4wCGFvyWGzT56wJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YmsD70QGyz6K8kY;
	Tue,  4 Feb 2025 00:20:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 35655140A36;
	Tue,  4 Feb 2025 00:21:13 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 17:21:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 4/5] hw/mem/cxl_type3: Ensure errp is set on realization failure
Date: Mon, 3 Feb 2025 16:19:07 +0000
Message-ID: <20250203161908.145406-5-Jonathan.Cameron@huawei.com>
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

Simply pass the errp to its callee which will set errp if needed, to
enhance error reporting for CXL Type 3 device initialization by setting
the errp when realization functions fail.

Previously, failing to set `errp` could result in errors being overlooked,
causing the system to mistakenly treat failure scenarios as successful and
potentially leading to redundant cleanup operations in ct3_exit().

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ff6861889b..d8b45f9bd1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -891,7 +891,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                      &ct3d->cxl_dstate.device_registers);
 
     /* MSI(-X) Initialization */
-    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
+    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, errp);
     if (rc) {
         goto err_free_special_ops;
     }
@@ -912,7 +912,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_cap_deverr_init(pci_dev);
     /* Leave a bit of room for expansion */
-    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
+    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, errp);
     if (rc) {
         goto err_release_cdat;
     }
-- 
2.43.0

