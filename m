Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+tynN/C"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6E8113
	for <linux-cxl@vger.kernel.org>; Sun, 26 Nov 2023 16:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701043800; x=1732579800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7HG0O6z51HAU2m0klmzb15jjMXtxNMhkM01eOFe0ExA=;
  b=K+tynN/CSkCwzkbQ5L9ZGeyJ+JoMre/kCPPfcgqRIUhulSGXayK/wB3H
   gmu2Roentj+BuWvwwYZf0w+lniNy2gSXsEMqFKNbnd0XEe7AenxZf8FsZ
   YlF8aOtfM5ASnuhFNb21aTTUvU42ASJ9dkgJWtTA9Sv1GQuUuJv+Y5foW
   F4cUhyYqLvkSqWWvcQ5kOO/kd8jMcOGZ0pFyn0Ar/kdTpo13pulRQVPv0
   xSThPzEvAL9oO6rKXmwSWaBAIqLogSYp/c/9ruoZ9I4W0trT+Aun47I+u
   03aEk0nduebAxScnF04JmkZHjWQyLzLC4qEPwO0NHRU5UOdghKrztl3J2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="371969646"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="371969646"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 16:09:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="885837369"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="885837369"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.90.230])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 16:09:34 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] cxl/memdev: Hold region_rwsem during inject and clear poison ops
Date: Sun, 26 Nov 2023 16:09:30 -0800
Message-Id: <08721dc1df0a51e4e38fecd02425c3475912dfd5.1701041440.git.alison.schofield@intel.com>
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

Poison inject and clear are supported via debugfs where a privileged
user can inject and clear poison to a device physical address.

Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
added a lockdep assert that highlighted a gap in poison inject and
clear functions where holding the dpa_rwsem does not assure that a
a DPA is not added to a region.

The impact for inject and clear is that if the DPA address being
injected or cleared has been attached to a region, but not yet
committed, the dev_dbg() message intended to alert the debug user
that they are acting on a mapped address is not emitted. Also, the
cxl_poison trace event that serves as a log of the inject and clear
activity will not include region info.

Close this gap by snapshotting an unchangeable region state during
poison inject and clear operations. That means holding both the
region_rwsem and the dpa_rwsem during the inject and clear ops.

Fixes: d2fbc4865802 ("cxl/memdev: Add support for the Inject Poison mailbox command")
Fixes: 9690b07748d1 ("cxl/memdev: Add support for the Clear Poison mailbox command")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/memdev.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 5ad1b13e780a..2f43d368ba07 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -331,10 +331,16 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
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
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
 		goto out;
@@ -362,6 +368,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
 out:
 	up_read(&cxl_dpa_rwsem);
+	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
@@ -379,10 +386,16 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
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
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
 		goto out;
@@ -419,6 +432,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
 out:
 	up_read(&cxl_dpa_rwsem);
+	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
-- 
2.37.3

