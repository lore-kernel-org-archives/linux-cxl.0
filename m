Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740FDD272
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270738; cv=none; b=aWVLBMj0YRGuPk03LclWc3efyA+ZZeKs5wivphEu6rwtSaHuVEOjxG/zkXS0qqXD8CxsdUnDr2nTsnn8kTTbj4gUijzxSoFNt47fcWqIyCee96+eHjHSRP93RN3cPOfzjpYKObC0DexYaFQQtSNNEze/OMIcyrqz4SpBwCYNBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270738; c=relaxed/simple;
	bh=KTwehYQbOOaUZATqJL+NblQ6zOMkBeLfYAl9HX0epaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZx4/fH9Amv5yh+/pYbaDmP2c0UnoA6z3pUMVKr02qfrfaeuM7+xhXvpEENQz3Ht34KTi//FJywsqbLXrWpJdORZTljELNT91TAL+YFsqhRBBwO9dPdfpuzBnkzCXBPeVEY4IGzIBIMf0sSEVn0KOVvZJ6TwFOMC+YLM0qGwBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLxC92XTcz67pJF;
	Fri, 26 Jan 2024 20:02:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DBBEA140CF4;
	Fri, 26 Jan 2024 20:05:34 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 12:05:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<peter.maydell@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon
 Yoo <42.hyeyoo@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, Stefan
 Hajnoczi <stefanha@gmail.com>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/12] hw/cxl: Pass NULL for a NULL MemoryRegionOps
Date: Fri, 26 Jan 2024 12:01:28 +0000
Message-ID: <20240126120132.24248-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126120132.24248-1-Jonathan.Cameron@huawei.com>
References: <20240126120132.24248-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Li Zhijian <lizhijian@fujitsu.com>

a NULL parameter is enough for a NULL MemoryRegionOps

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-component-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 9dfde6c0b3..5ddd47ed8d 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -197,7 +197,7 @@ void cxl_component_register_block_init(Object *obj,
                        CXL2_COMPONENT_BLOCK_SIZE);
 
     /* io registers controls link which we don't care about in QEMU */
-    memory_region_init_io(&cregs->io, obj, NULL, cregs, ".io",
+    memory_region_init_io(&cregs->io, obj, NULL, NULL, ".io",
                           CXL2_COMPONENT_IO_REGION_SIZE);
     memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cstate,
                           ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
-- 
2.39.2

