Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC027692B3
	for <linux-cxl@vger.kernel.org>; Thu, 14 Dec 2023 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUEKuzsO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702581239; x=1734117239;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HJm/9hbnq5wyWIQmxQ/XOo+35LGDnInOnBBl6CRhBgo=;
  b=MUEKuzsOaEheYFBOxHQ/407XAJpOINWcZtM8dyhu6BtXiBo72aNFE4Br
   svH45izIE36UgVrfqyWmLElr09OpL5UTeg3jq/aVPZFkBTAsqOOzLPA00
   wuEH5ap0GVyohI/UYxheXFNkPDm/oxqne0FvSUVUFOGhsWrtyXRbQV+7i
   Z1yDuP3STc1oLtIcSuVkeH8sI0Nd98dvQbXgxk5NVX9SVu14l2kGhWKSw
   btOWGOBET/N9oNZuASsMTdNDRZ7qrVFBCjXMBSVsCPgnUBHvbIXJqBGDQ
   Fbbsyj8P/N3g5JpujyCGOkAqCXMMTJ/pVTdBDXRsielr83qK9FG4hW1Mj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394041748"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="394041748"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 11:13:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="17724301"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.92.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 11:13:58 -0800
Subject: [PATCH] cxl: Fix unregister_region() callback parameter assignment
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 14 Dec 2023 12:13:58 -0700
Message-ID: <170258123810.952211.3907381447996426480.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In devm_cxl_add_region(), devm_add_action_or_reset() is called by passing
in unregister_region() with data ptr of 'cxlr'. However, in
unregister_region(), the passed in parameter is incorrectly assumed to be
a 'struct device' rather than the 'cxlr' pointer. The code has been
working because 'struct device' is the first member of 'struct
cxl_region'. Issue found by inspection. Fix the assignment so that cxlr is
pointing directly to the passed in parameter.

Fixes: 23a22cd1c98b ("cxl/region: Allocate HPA capacity to regions")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 56e575c79bb4..a61703c9d72a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2083,13 +2083,13 @@ static struct cxl_region *to_cxl_region(struct device *dev)
 	return container_of(dev, struct cxl_region, dev);
 }
 
-static void unregister_region(void *dev)
+static void unregister_region(void *_cxlr)
 {
-	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region *cxlr = _cxlr;
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
-	device_del(dev);
+	device_del(&cxlr->dev);
 
 	/*
 	 * Now that region sysfs is shutdown, the parameter block is now
@@ -2100,7 +2100,7 @@ static void unregister_region(void *dev)
 		detach_target(cxlr, i);
 
 	cxl_region_iomem_release(cxlr);
-	put_device(dev);
+	put_device(&cxlr->dev);
 }
 
 static struct lock_class_key cxl_region_key;


