Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF02853E3
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751515418; cv=none; b=FkljG7BzLsDjfg5FAXGcfu+dvYUXU02QfMqtfgfbhYwi2KB4NfgUbqhtpeHzNtLV0qUQMcD3x1x/w3Jf3Dpu9VO2kBzT7w0VPDiIkj1W8JnEKVVHfhEKeSsq/3E45F+g16lxIqN/cI7FNEH2zVCn/V2qCh7sh5XrcgoVvTHU1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751515418; c=relaxed/simple;
	bh=tGvjVjuBOjtZ4hFAPUgmNHlwZmq/QLxfPYfWu8K77gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/kUUbia7/jwI6KVxa4smApbEoU86mI++L6HvJ15i/dFdn6n/Dn2sKlon9se3EaMrrx88INOc80XljPikEaRDKfoyvqR+uiLfincBeS/N2QzKxTq56XUy+POkwoxZrgB68YKxtCB1HnbpDrV1pAJbpb5UbhQARZDcGnNjLool/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FqJDFci/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqJDFci/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751515417; x=1783051417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tGvjVjuBOjtZ4hFAPUgmNHlwZmq/QLxfPYfWu8K77gQ=;
  b=FqJDFci/3gjZ1IUOEvpWokg+2zuSLvpfbXneRVH7zO3JJ1C3hRwyXTtM
   JxAYJ+jpNxe8y9Mxqs1wM8B/Oq0AxEwLcQA8tS9KL69sSwTh+tIAhfTDF
   +mqDF1tMejdb5+ZzJutu2ynhCFCegcJD03RJnx5ZweCR8LJo7CFFkrYb+
   oK4OrEKHD+MTXGlEnV/blTChfd1HBQmPWD2gFiJ+PcqriQtD6165IuRgn
   weN1pCnTpHuaMUNy0sY6XxewpdiStA0HgQsOYHEZT7ArAsNdFzY3O6rYc
   kT0czY9yG1+E5rM+QqzsdCxLuF7U1TKbrenYtBFIcUH8cmGa+l1wBRG93
   g==;
X-CSE-ConnectionGUID: V9I14SNKQlWIRtc5PdctBg==
X-CSE-MsgGUID: fNFoW1BCTEqohlLpra4qvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53692340"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="53692340"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 21:03:35 -0700
X-CSE-ConnectionGUID: I3MEH0srTI2sW0dVlWV3aQ==
X-CSE-MsgGUID: V654CBCLR6mpw465waelrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="159951153"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.14])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 21:03:35 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 3/4] cxl/core: Add locked variants of the poison inject and clear funcs
Date: Wed,  2 Jul 2025 21:03:22 -0700
Message-ID: <2b713ef8bc5e090ec5da61157749bb6ac315ed3c.1751513505.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1751513505.git.alison.schofield@intel.com>
References: <cover.1751513505.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The core functions that validate and send inject and clear commands
to the memdev devices require holding both the dpa_rwsem and the
region_rwsem.

In preparation for another caller of these functions that must hold
the locks upon entry, split the work into a locked and unlocked pair.

Consideration was given to moving the locking to both callers,
however, the existing caller is not in the core (mem.c) and cannot
access the locks.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
Return the rc from locked variants in cxl_clear/inject_poison
Remove the not customary __ prefix from locked variants


 drivers/cxl/core/memdev.c | 60 +++++++++++++++++++++++++++------------
 drivers/cxl/cxlmem.h      |  2 ++
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f5fbd34310fd..7af626f69ac4 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -276,7 +276,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
 	return 0;
 }
 
-int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
+int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_mbox_inject_poison inject;
@@ -288,13 +288,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
-		return rc;
-
-	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
-	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
-		return rc;
+	lockdep_assert_held(&cxl_rwsem.dpa);
+	lockdep_assert_held(&cxl_rwsem.region);
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
@@ -322,11 +317,28 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
 
-	return 0;
+	return rc;
+}
+
+int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
+		return rc;
+
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
+		return rc;
+
+	rc = cxl_inject_poison_locked(cxlmd, dpa);
+
+	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");
 
-int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
+int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_mbox_clear_poison clear;
@@ -338,13 +350,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
-		return rc;
-
-	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
-	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
-		return rc;
+	lockdep_assert_held(&cxl_rwsem.dpa);
+	lockdep_assert_held(&cxl_rwsem.region);
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
@@ -381,7 +388,24 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
 
-	return 0;
+	return rc;
+}
+
+int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
+		return rc;
+
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
+		return rc;
+
+	rc = cxl_clear_poison_locked(cxlmd, dpa);
+
+	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, "CXL");
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index f5b20641e57c..869c73de12c8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -861,6 +861,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
+int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
+int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
 
 #ifdef CONFIG_CXL_EDAC_MEM_FEATURES
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
-- 
2.37.3

