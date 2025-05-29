Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8FABE49
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526516; cv=none; b=q56ljUNPxtI+t/aUrehGFUon/Be8RaTdtXHZWCsRHe62vb7ohEIp3FkLgUCD+0Zmrk0GYp8jrtAT9zB0YK+CLgNd5H2jYm9q4HzU1Rq3MtPnFnZFlE7icOb4+7DQMP4tO6C4BYTOzHHgegP8ahKOQQvedVVGH361Ajc5OWG66rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526516; c=relaxed/simple;
	bh=ElP+UmoU6ABG+vgli9CAMhaEHHterPEZygKXR2uQGs4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KnQZga5we0x7kDSgeLvGZvhRQCJiq7cN9l4Ki/JwJMpKAc5R6zhIfIzup1VFid6kBiLZen3Yq7sJA2eM+Wv/kx1z03h4PpPuCy4O5nY8Ugk2m/h5WmWediuebN42fldRbwWtZdU3vCZqDX9CZdAv5P5SNkFwfrgHciT5J5XZ7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7SKd0qckz6L5cG;
	Thu, 29 May 2025 21:44:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E3C821402FE;
	Thu, 29 May 2025 21:48:29 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 May 2025 15:48:29 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu] hw/cxl: Fix register block locator size
Date: Thu, 29 May 2025 14:48:28 +0100
Message-ID: <20250529134828.403049-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

This has been wrong from day 1.  For now we only have
two entries (component and device registers).

The wrong size could lead to arbitrary data off the stack being presented
in PCIe config space.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index d0855ed78b..3bb882ce89 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -31,7 +31,7 @@
 #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH 0x20
 #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID  2
 
-#define REG_LOC_DVSEC_LENGTH 0x24
+#define REG_LOC_DVSEC_LENGTH 0x1C
 #define REG_LOC_DVSEC_REVID  0
 
 enum {
-- 
2.48.1

