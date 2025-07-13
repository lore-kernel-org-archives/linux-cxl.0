Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604E613B2A4
	for <linux-cxl@vger.kernel.org>; Sun, 13 Jul 2025 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752374288; cv=none; b=dPFu8uWHS6vQbe/CVmX0F21AMlbbXZr1FMkW7pYBmzNHceB1V/yinK47us6LZvm5GlJXtqv1f8LkGchFOQmCk46640KMlqDgTTxCYbL2MJFu3W05qQLrGI/GWAIuUUZoD/dS1zB9q+9cHES0NxTF20UsVK9UHNAGI7InlMFUw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752374288; c=relaxed/simple;
	bh=JhrLcIFQeWrS56F7ysH5OxjHdI9ALIoxQfyiO6LhvG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s65qdGdqkWDLxuVynxiI1zOX3zi0WZOlNTeWr2S6xTqsjkukWk7ecxoFarS1zm0GR4bwzDTDBIm5Z/FSyUHaRO56nV0pkFFaTuUJX/5+mVTtAnwe6IgvzqGE3MTEhpQw3jWL6kGk82IzCkb94Xa2mgE3S0tWpLOesvEqhlRGtl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pnd7cXij; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pnd7cXij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752374286; x=1783910286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JhrLcIFQeWrS56F7ysH5OxjHdI9ALIoxQfyiO6LhvG4=;
  b=Pnd7cXijy0x4k3GMR2vl2TKbD3pMBVFe44EkZ5nVwkGeJJu0q8kBpmvr
   PYIEtIwDBysd5LgaXd+Vp7vi2LMsgFDlVBnYSBxVTHq42cNtzV84RUzXJ
   AIXTK/Pe9j1Ym2CV/or5FnqLn942pPD9rAbCJzFON80MgQKTfEJ7iqD0T
   ZDLrASNE8KG9pnPzbMrIudIahRUeW3lwBKPEPggV+XaMgrizyWmIvcELI
   aIma1OwiQhHvs35PBayhBE51phUXVYwfLeeWX4ErRlF0f918je8MtZCJT
   QMTtOMlDudabbjvRQShhI78VcQojbM5S9ukHKdH/dd4OrJRbyMLKNg+4p
   Q==;
X-CSE-ConnectionGUID: w0HAqwH8SQS2RW90K9g2vA==
X-CSE-MsgGUID: /8d/O7zrSCSeAQH28sc0jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65967445"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="65967445"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 19:38:06 -0700
X-CSE-ConnectionGUID: tIgB4y3MR/6xaPMwhPw2KA==
X-CSE-MsgGUID: iWPwWxv8SLWLyDH5T/wCSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="157206921"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.247])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 19:38:05 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 3/4] cxl/core: Add locked variants of the poison inject and clear funcs
Date: Sat, 12 Jul 2025 19:37:56 -0700
Message-ID: <fce084f133cd1d53fe442ae67dc0cf3b00b2c2af.1752365427.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1752365427.git.alison.schofield@intel.com>
References: <cover.1752365427.git.alison.schofield@intel.com>
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

Changes in v3:
Undo v2 return of rc from locked variants. Return 0. (Jonathan)

 drivers/cxl/core/memdev.c | 56 ++++++++++++++++++++++++++++-----------
 drivers/cxl/cxlmem.h      |  2 ++
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f5fbd34310fd..097fc9828f3a 100644
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
@@ -324,9 +319,26 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 
 	return 0;
 }
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
+}
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
@@ -383,6 +390,23 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 
 	return 0;
 }
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
+}
 EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, "CXL");
 
 static struct attribute *cxl_memdev_attributes[] = {
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

