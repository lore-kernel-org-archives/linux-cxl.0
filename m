Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3787E
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgJH7Xem"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204571A1
	for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 18:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699930426; x=1731466426;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=unFs1d55oe8d801JkyZfP7qrlITNMTt98mlYr9oqR/g=;
  b=NgJH7Xem1sxWxI8vfQqB/9JZRoha7guZoS3dLDUqEsOx3oHNa7qJnH+A
   +DKoI51U7wknEYZTG56iMiw405vWC5bKM9DRW38p7OYCA900a/nz1mjCl
   kFveqHbKqUx4MTb8UxLKsFYhSblKXzISs6T0VSk8Vt0TSOioLzUmMQWHC
   vscPrV/HT2QVTL2HlVzDoxNYUYCmhGx+YKR2ELDzEID1uU8FoTf7/ucRf
   fdDdSKkWQhxrxGYQ4OwYpp3G/eYTdpBap9LOxoP9uxeMlEEkfOSx0ynRP
   AIJBIGicq81/GiXrmY+ucq3pZ8p2KLaDmeK2I2JF61ocHWbCEMxsd5S/H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="390361746"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="390361746"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 18:53:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="764524599"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="764524599"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.206.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 18:53:44 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/core: Hold the region rwsem during poison ops
Date: Mon, 13 Nov 2023 18:53:42 -0800
Message-Id: <20231114025342.1123681-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
added a lockdep_assert_held() to make sure all callers hold the
region state stable while doing work that depends on the number
of committed decoders.

That lockdep assert triggered in poison list, inject, and clear
functions highlighting a gap between region attach and decoder
commit where holding the dpa_rwsem is not enough to assure that
a DPA is not added to a region. In such a case, if poison is
found in at that DPA, the trace event omits the region info
that users expect.

Close the gap by snapshotting an unchangeable region state during
all poison ops. Hold the region_rwsem in all the places that hold
the dpa_rwsem rather than in the region specific function only.

Fixes: 7ff6ad107588 ("cxl/memdev: Add trigger_poison_list sysfs attribute")
Fixes: f0832a586396 ("cxl/region: Provide region info to the cxl_poison trace event")
Fixes: d2fbc4865802 ("cxl/memdev: Add support for the Inject Poison mailbox command")
Fixes: 9690b07748d1 ("cxl/memdev: Add support for the Clear Poison mailbox command")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/memdev.c | 18 +++++++++---------
 drivers/cxl/core/region.c |  5 -----
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index fc5c2b414793..961da365b097 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -227,9 +227,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 	if (!port || !is_cxl_endpoint(port))
 		return -EINVAL;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc)
-		return rc;
+	down_read(&cxl_region_rwsem);
+	down_read(&cxl_dpa_rwsem);
 
 	if (cxl_num_decoders_committed(port) == 0) {
 		/* No regions mapped to this memdev */
@@ -239,6 +238,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 		rc =  cxl_get_poison_by_endpoint(port);
 	}
 	up_read(&cxl_dpa_rwsem);
+	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
@@ -324,9 +324,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc)
-		return rc;
+	down_read(&cxl_region_rwsem);
+	down_read(&cxl_dpa_rwsem);
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
@@ -355,6 +354,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
 out:
 	up_read(&cxl_dpa_rwsem);
+	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
@@ -372,9 +372,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc)
-		return rc;
+	down_read(&cxl_region_rwsem);
+	down_read(&cxl_dpa_rwsem);
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
@@ -412,6 +411,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
 out:
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
 

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.37.3

