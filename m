Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2307209F55
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599616; cv=none; b=sPNR4DnzczOJibo5XU2PXXgPQIBxUNBXARfFml6It4OmAH7wTcu7nxkAOLyUOiTUamtcoUE4hw7rAOkL/Om0GJ3UpLooXnnMxENELZ2JmPr2/TYktCX9HLbUBZ0y42MMLtH9wRtnjlYpO/9OUiG+6zzj4MH/9cv/TeEFFiflwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599616; c=relaxed/simple;
	bh=mnv/ec0KoyAv+hLsxWbFGeHY78/BeD+5S8H6zOZJLS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYId8aKOjz0ScOwLlvTCC7z+aUS0DRezD/+HSv4VM1ETGRe5gqQsRUQs00zGbH3aWTqbGYTBWOm21jfIy5JfkztLZDTCzwu6p1rP6e9ovd4jLooDu3nj+NSH8oH3BV7fPKVikG/Fs59yRKe5K0U7E3nX3GNvo83Rb76sSQaYXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yms8y6Wz4z6L4rx;
	Tue,  4 Feb 2025 00:17:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4890E140442;
	Tue,  4 Feb 2025 00:20:11 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 17:20:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 2/5] hw/mem/cxl_type3: Add paired msix_uninit_exclusive_bar() call
Date: Mon, 3 Feb 2025 16:19:05 +0000
Message-ID: <20250203161908.145406-3-Jonathan.Cameron@huawei.com>
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

msix_uninit_exclusive_bar() should be paired with msix_init_exclusive_bar()

Ensure proper resource cleanup by adding the missing
`msix_uninit_exclusive_bar()` call for the Type3 CXL device.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ebc0ec536e..4775aab0d6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -944,6 +944,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 err_release_cdat:
     cxl_doe_cdat_release(cxl_cstate);
 err_free_special_ops:
+    msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
 err_address_space_free:
     if (ct3d->dc.host_dc) {
@@ -967,6 +968,7 @@ static void ct3_exit(PCIDevice *pci_dev)
 
     pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
+    msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
-- 
2.43.0

