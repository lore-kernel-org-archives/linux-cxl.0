Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38E818
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mj4yhg0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704762431; x=1736298431;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u84z6cYUpfZSzaD8cZG/bsJB9xb7SdSbHotwbrCYP0g=;
  b=Mj4yhg0nkHqQEYF8bcZkN3eUGJVgI287sfBdExT6cjCH/VyFHWNI66KP
   o2I5P2F6kXFbHTo9g0zAB7AmTfArnfITvNC0GaZuxSq0zFPWAIsjd35BX
   hvisMRdDauoWEYXJLqNlpM0tNDcab2jSsoLARF4HtLJb7VQjkaGyXyNP4
   5vukkXSB/AG4GZ62seYNGX1eRBm6ikkoO8gh06yZzwlV75wMtGxJQeUxJ
   x6Sa5lohTH1YKnJo5Q9YBhmRigR9QIdA8aGhAhLw6RDrYjxtWFbhjtKWc
   0N6Bfv2688BuQfTebbk4Nhs4RDyPXJigFV3JOCPJJ7T3Kk8nTuZ+MS7p0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="395206988"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="395206988"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:07:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="851987246"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="851987246"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.152.7])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:07:09 -0800
Subject: [PATCH 1/3] cxl: Remove cxl_root check after find_cxl_root
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Robert Richter <rrichter@amd.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Mon, 08 Jan 2024 18:07:08 -0700
Message-ID: <170476242895.115624.3127891331552985140.stgit@djiang5-mobl3>
In-Reply-To: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

find_cxl_root() can't fail in practice as CXL root exit unregisters all
descendant ports and that in turn synchronizes with cxl_port_probe().
Remove unnecessary check after calling find_cxl_root().

Suggested-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c |    6 ------
 drivers/cxl/core/pmem.c |    3 ---
 2 files changed, 9 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 6fe11546889f..f7ba7bd2e459 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -176,9 +176,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 
-	if (!cxl_root)
-		return -ENODEV;
-
 	if (!cxl_root->ops || !cxl_root->ops->qos_class)
 		return -EOPNOTSUPP;
 
@@ -357,9 +354,6 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 	struct cxl_root *cxl_root __free(put_cxl_root) =
 		find_cxl_root(cxlmd->endpoint);
 
-	if (!cxl_root)
-		return -ENODEV;
-
 	root_port = &cxl_root->port;
 
 	/* Check that the QTG IDs are all sane between end device and root decoders */
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index e69625a8d6a1..ed76d37e4fd9 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -68,9 +68,6 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
 		find_cxl_root(cxlmd->endpoint);
 	struct device *dev;
 
-	if (!cxl_root)
-		return NULL;
-
 	dev = device_find_child(&cxl_root->port.dev, NULL, match_nvdimm_bridge);
 
 	if (!dev)


