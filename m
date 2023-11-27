Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVOnF0zJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8385E10F
	for <linux-cxl@vger.kernel.org>; Sun, 26 Nov 2023 16:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701043799; x=1732579799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CXeTbREunVeqa4yGmfw5swoJDRL25zikB70vb/oeyEk=;
  b=kVOnF0zJ6zGAUlaQaprurhVUfmod6F0yUbiFYnlr46RvJNSoOO9wRSBy
   1sLecmIR28NhsrTvDTWKh9nKHkmg1CvDmRevOCqUxFN7F/IX7JRq3xUoC
   gQ3VbaO2PsSO+XxIbXDPAsU/NIAExNnztk1cx+i+ryrQ/0CL+F55l80+S
   OmPz2KJmdqR3oxxoQWfOENt7xWhTzFnPacFiRHWPoCercxPb1x65cWNHj
   qUZ6Kbm339rN5YD9CBVCaDjq2pGiTPBUDrguvmGMiy5qo7Bmztr4YEdDi
   HTH8alfW3483LRxtLmlEVSZIxPx8wqBVKVLJyh8QdE5k4I6RJ5ap/RR0C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="371969642"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="371969642"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 16:09:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="885837365"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="885837365"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.90.230])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 16:09:33 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 1/2] cxl/core: Always hold region_rwsem while reading poison lists
Date: Sun, 26 Nov 2023 16:09:29 -0800
Message-Id: <08e8e7ec9a3413b91d51de39e385653494b1eed0.1701041440.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1701041440.git.alison.schofield@intel.com>
References: <cover.1701041440.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

A read of a device poison list is triggered via a sysfs attribute
and the results are logged as kernel trace events of type cxl_poison.
The work is managed by either: a) the region driver when one of more
regions map the device, or by b) the memdev driver when no regions
map the device.

In the case of a) the region driver holds the region_rwsem while
reading the poison by committed endpoint decoder mappings and for
any unmapped resources. This makes sure that the cxl_poison trace
event trace reports valid region info. (Region name, HPA, and UUID).

In the case of b) the memdev driver holds the dpa_rwsem preventing
new DPA resources from being attached to a region. However, it leaves
a gap between region attach and decoder commit actions. If a DPA in
the gap is in the poison list, the cxl_poison trace event will omit
the region info.

Close the gap by holding the region_rwsem and the dpa_rwsem when
reading poison per memdev. Since both methods now hold both locks,
down_read both from the caller. Doing so also addresses the lockdep
assert that found this issue:
Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")

Fixes: 7ff6ad107588 ("cxl/memdev: Add trigger_poison_list sysfs attribute")
Fixes: f0832a586396 ("cxl/region: Provide region info to the cxl_poison trace event")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/memdev.c | 9 ++++++++-
 drivers/cxl/core/region.c | 5 -----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index fc5c2b414793..5ad1b13e780a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -227,10 +227,16 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 	if (!port || !is_cxl_endpoint(port))
 		return -EINVAL;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	rc = down_read_interruptible(&cxl_region_rwsem);
 	if (rc)
 		return rc;
 
+	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	if (rc) {
+		up_read(&cxl_region_rwsem);
+		return rc;
+	}
+
 	if (cxl_num_decoders_committed(port) == 0) {
 		/* No regions mapped to this memdev */
 		rc = cxl_get_poison_by_memdev(cxlmd);
@@ -239,6 +245,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 		rc =  cxl_get_poison_by_endpoint(port);
 	}
 	up_read(&cxl_dpa_rwsem);
+	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 56e575c79bb4..3e817a6f94c6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2467,10 +2467,6 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 	struct cxl_poison_context ctx;
 	int rc = 0;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-
 	ctx = (struct cxl_poison_context) {
 		.port = port
 	};
@@ -2480,7 +2476,6 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
 					     &ctx);
 
-	up_read(&cxl_region_rwsem);
 	return rc;
 }
 
-- 
2.37.3

