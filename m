Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4B3594B
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726424; cv=none; b=WqVNVcULHEC8uAV/ki20IfupClPzI29mz7oytxx41rOheBzJ4voMmGzl8YFmpVDQr1c7ZOoD5ZjtC3jqVOYWwe6eX4tO6J5BccPmzt0nQQQ8T4XrsIr1UoceM20eh+jU/vBJEBAQ/bP8q7LCU9CaLx+9CSZTssSgqoXq2nGK3/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726424; c=relaxed/simple;
	bh=rckY/p9CJ/+kO9Z7X53WwEvI9yjACuV2bTa5l+zIbDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owGg0MCjdqv6xRB/ZKIh3mM+n/05IH8UFIX/TWKgDLPYFSP/7VEed2jKIgzwihkjS+f3T1HJOSh+VcAda6S6KSaD9coHUnNBcgs3EKkr9OvRCkZuGaG41s664k7WzEwC0+dGgNBa9fNGiH+7fq/dRPr3lE71Jd9ZlK8kbY/oY9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRCVX8Zz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRCVX8Zz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750726423; x=1782262423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rckY/p9CJ/+kO9Z7X53WwEvI9yjACuV2bTa5l+zIbDU=;
  b=RRCVX8ZzjMHs/s6VWsN5PzuPm6FKsD1mecoBVSpWCUKOU4EqtNqAkOif
   c0mTwYycTU/jOhh8hghMpvMUEXNisSZAopDSdOc29luE3I6igMkhjXqcj
   O9ji5LfjXCs4OA60R3jIPTXIk8NHTtkOHcIykQmlQJnzCUshEYyaUI257
   t88QMfrCwWRMv8bNC/8zHwN9rYkNUDW0IYpqvFyYL4viYHb3IfMYH9gd3
   prKBGFzrml3reviIPQSKy/Z/2Uzi8mKfZZ0JuC5xQsCftngyu8DKbL0o3
   Z3VOJEgSGqnd6FsIitnmwX37VQi7n9Syk5uiGa0uQf3C6M8KIfps+sk2X
   w==;
X-CSE-ConnectionGUID: Gqi7kdSlQk2vSfEHP6M9tQ==
X-CSE-MsgGUID: Grqiy+KDSRu1CU1mbe6kEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56728802"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="56728802"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:53:43 -0700
X-CSE-ConnectionGUID: /DGxN+l5QuCOGthRShCO9A==
X-CSE-MsgGUID: 75ACe6nvT1CkUUVnxTxajw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="156129148"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.202])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:53:42 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 1/3] cxl/core: Add locked variants of the poison inject and clear funcs
Date: Mon, 23 Jun 2025 17:53:34 -0700
Message-ID: <71f51bcc7d335c9f558441bb68f05f546230696a.1750725512.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1750725512.git.alison.schofield@intel.com>
References: <cover.1750725512.git.alison.schofield@intel.com>
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
 drivers/cxl/core/memdev.c | 77 +++++++++++++++++++++++++--------------
 drivers/cxl/cxlmem.h      |  2 +
 2 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f88a13adf7fa..b38141761f47 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -280,7 +280,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
 	return 0;
 }
 
-int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
+int __inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_mbox_inject_poison inject;
@@ -292,19 +292,12 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
-		return rc;
-	}
+	lockdep_assert_held(&cxl_dpa_rwsem);
+	lockdep_assert_held(&cxl_region_rwsem);
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
-		goto out;
+		return rc;
 
 	inject.address = cpu_to_le64(dpa);
 	mbox_cmd = (struct cxl_mbox_cmd) {
@@ -314,7 +307,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	};
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
-		goto out;
+		return rc;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
@@ -327,7 +320,26 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
-out:
+
+	return rc;
+}
+
+int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	int rc;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	if (rc) {
+		up_read(&cxl_region_rwsem);
+		return rc;
+	}
+
+	rc = __inject_poison_locked(cxlmd, dpa);
+
 	up_read(&cxl_dpa_rwsem);
 	up_read(&cxl_region_rwsem);
 
@@ -335,7 +347,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");
 
-int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
+int __clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_mbox_clear_poison clear;
@@ -347,20 +359,12 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
-		return rc;
-	}
+	lockdep_assert_held(&cxl_dpa_rwsem);
+	lockdep_assert_held(&cxl_region_rwsem);
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
-		goto out;
-
+		return rc;
 	/*
 	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
 	 * is defined to accept 64 bytes of write-data, along with the
@@ -378,7 +382,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
-		goto out;
+		return rc;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
@@ -391,7 +395,26 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
-out:
+
+	return rc;
+}
+
+int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	int rc;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	if (rc) {
+		up_read(&cxl_region_rwsem);
+		return rc;
+	}
+
+	rc = __clear_poison_locked(cxlmd, dpa);
+
 	up_read(&cxl_dpa_rwsem);
 	up_read(&cxl_region_rwsem);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 551b0ba2caa1..c0643e8b9d8f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -861,6 +861,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
+int __inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
+int __clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
 
 #ifdef CONFIG_CXL_EDAC_MEM_FEATURES
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
-- 
2.37.3

