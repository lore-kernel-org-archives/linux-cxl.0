Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7891338F4A
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770852401; cv=none; b=dRfNzloLBgEgXN/uEk2bCtXpB0JSuA6OpQKA8AuuzISdzi47DkshpwV7n+gAGNBWKHGO5/WwJQ7JPAcyzOZSMb0f2V0xMBhUpJtDWyM/VqIHRgNd4A73Hi3PDV/UxxdKUF36eDaPOgxk85LsujFP/nPSkcDRFM94NBjt8GjcxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770852401; c=relaxed/simple;
	bh=OB9EarRRMw7aT7WB9Pqq78MM/J7nxWNCqfOViKnYDEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhMgHeOTK4LlD1+Y9VYpTdkCgP4/pTUosPCDIN3XXHuhlGBGNa9pKKr9c3vbpbLkETG/BHkSN/gyKaNKQsCtblU+7uPiT38A1mbBarTfPmqCMCDZ9g5VrneA9gAUIh2M9TBBfX0iWi/Dk4BjRFs5Yuv0IqZ+TwbI+sdzHkJOps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCEBC4CEF7;
	Wed, 11 Feb 2026 23:26:41 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v2 3/3] cxl: Clean up cxl_nvdimm devices when removing nvdimm_bus
Date: Wed, 11 Feb 2026 16:26:30 -0700
Message-ID: <20260211232630.480509-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211232630.480509-1-dave.jiang@intel.com>
References: <20260211232630.480509-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation, when the nvdimm_bus is removed, the
cxl_nvdimm devices only have the driver unbound which leaves orphaned
cxl_nvdimm devices around. Add removal of cxl_nvdimm devices when the
nvdimm_bus object is removed on cxl_nvb driver removal.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pmem.c | 6 +++++-
 drivers/cxl/cxl.h       | 1 +
 drivers/cxl/pmem.c      | 5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index f7f784047450..4edc87ceb993 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -142,18 +142,22 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
 	return cxl_nvd;
 }
 
-static void cxlmd_release_nvdimm(void *_cxlmd)
+void cxlmd_release_nvdimm(void *_cxlmd)
 {
 	struct cxl_memdev *cxlmd = _cxlmd;
 	struct cxl_nvdimm *cxl_nvd = cxlmd->cxl_nvd;
 	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
 
+	dev_info(&cxlmd->dev, "XXX release nvdimm %s\n",
+		 cxl_nvd ? dev_name(&cxl_nvd->dev) : "none");
+
 	cxl_nvd->cxlmd = NULL;
 	cxlmd->cxl_nvd = NULL;
 	cxlmd->cxl_nvb = NULL;
 	device_unregister(&cxl_nvd->dev);
 	put_device(&cxl_nvb->dev);
 }
+EXPORT_SYMBOL_NS_GPL(cxlmd_release_nvdimm, "CXL");
 
 /**
  * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and an nvdimm
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3b79d5c4765a..3f0d927e5772 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -926,6 +926,7 @@ bool is_cxl_nvdimm(struct device *dev);
 int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
 			struct cxl_memdev *cxlmd);
 struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
+void cxlmd_release_nvdimm(void *cxlmd);
 
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 0b200be1fd36..edce5269a682 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -397,6 +397,7 @@ static int cxl_pmem_ctl(struct nvdimm_bus_descriptor *nd_desc,
 static int detach_nvdimm(struct device *dev, void *data)
 {
 	struct cxl_nvdimm *cxl_nvd;
+	struct cxl_memdev *cxlmd;
 	bool release = false;
 
 	if (!is_cxl_nvdimm(dev))
@@ -411,6 +412,10 @@ static int detach_nvdimm(struct device *dev, void *data)
 	}
 	if (release)
 		device_release_driver(dev);
+
+	cxlmd = cxl_nvd->cxlmd;
+	devm_release_action(&cxlmd->dev, cxlmd_release_nvdimm, cxlmd);
+
 	return 0;
 }
 
-- 
2.52.0

