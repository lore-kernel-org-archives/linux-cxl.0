Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300353D9048;
	Fri,  3 Apr 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249978; cv=none; b=ARbLuUGiDWXpNUBDX97XBGZC1wwByZ/AzJlRKtwjM6stmT2JAr6C1p5V/Vu8njrS/7xIEr0RncjnfjnCsTJF7DMN9fLkORTXpmdYK+lF32pUiiy7v2Fb69RYIx/5FaFD4wJN4hlC0uBDYLI9mlBa07MIYbL90dP846rMjUCb5hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249978; c=relaxed/simple;
	bh=PitfgQo4DHj0Y96d92T8kxsOJx3DCq6tKvhXLvqAKdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hj7lURoFlAi8Dsc5GpZIGW3uqe/L416K6dO662Ro8T1mKCRtCF+VS7gem0QTgO9B7l9HC4piX3LItUtt9qpyYV4jQqm5Te37ZxyrmqDrOAQEhcVSwaPgzJC8HAQq/hN+JpdORTG5DVMTJPbvGuXpqvqAwcYlYs/C7Eqv0lBVTyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SoGVo38o; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SoGVo38o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775249977; x=1806785977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PitfgQo4DHj0Y96d92T8kxsOJx3DCq6tKvhXLvqAKdY=;
  b=SoGVo38ov8NCtztx4eRWbAqDPISHPO/WDFs0KPUZu3G0tt6PyoktgEfh
   caP+kV2r0PJqLCaAQTLeb2WU6iw+VpprHc6a7getnk6rN2u15xqC6jmbj
   PdVKHQuTA3+2r8xJeqmr2z8kTIZE4LZk4JaCMnAJg0EulCNO/V/ZeZx47
   iQN2TH4O5VuaB3TxUdq1RnNNCozSLYDVvczdzgwxu2jIJy3kGpyUxzhTK
   dqr9VIla4EqXAxpTZ9Dh6vqNKEOnhYZRZaj2nfXLvwgCSQNbpNcd8obqN
   ruTWhS2HEQQNnZYAGpm++oEmJ7mOfIK51QmgLdjGX6YX18mnN+FyE/F8i
   Q==;
X-CSE-ConnectionGUID: vKWsVicVS0+1+VaaA4ix2w==
X-CSE-MsgGUID: PUyjPd0CQFK6zyYoHxzutQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76281472"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76281472"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 13:59:34 -0700
X-CSE-ConnectionGUID: V/QEnClgQ42FhPPcKzdEZA==
X-CSE-MsgGUID: DTjH9IRYT+C3x5wB7brC9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="265280483"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa001.jf.intel.com with ESMTP; 03 Apr 2026 13:59:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alejandro.lucero-palau@amd.com
Subject: [RFC PATCH 3/4] cxl/region: Block region delete for locked regions
Date: Fri,  3 Apr 2026 14:00:49 -0700
Message-ID: <20260403210050.1058650-4-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403210050.1058650-1-dan.j.williams@intel.com>
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In support of reducing the number of failure conditions an accelerator
driver needs to consider, block user initiated delete of locked regions.

This might turn out to be too heavy and some region unlock mechanism needs
to be considered, but in the interest of doing something simple to get
accelerators enabled, take this coarse step.

Switch to scope-based cleanup now that there is an early exit case.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 600c96be0888..11bc0b88b05f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2768,17 +2768,20 @@ static ssize_t delete_region_store(struct device *dev,
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 	struct cxl_port *port = to_cxl_port(dev->parent);
-	struct cxl_region *cxlr;
 
-	cxlr = cxl_find_region_by_name(cxlrd, buf);
+	struct cxl_region *cxlr __free(put_cxl_region) =
+		cxl_find_region_by_name(cxlrd, buf);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
+	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
+		return -EBUSY;
+
 	devm_release_action(port->uport_dev, unregister_region, cxlr);
-	put_device(&cxlr->dev);
 
 	return len;
 }
+
 DEVICE_ATTR_WO(delete_region);
 
 static void cxl_pmem_region_release(struct device *dev)
-- 
2.53.0

