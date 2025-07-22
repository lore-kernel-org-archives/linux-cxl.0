Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981927FD56
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217278; cv=none; b=LdnjzWSnpnjj6nEnsqQqzMkm2MikJiDT1XWFadjDCqQkXQy6b9mXGBZi6chJJNhtq5korv2Uqzv2J8A4LSCaT8FRYNNnFaoKUWNlPrkE3M0AJJHMgXOimIpnGzw435uRQ1fszF3o5UG+OAvSoB6zprU3Ygqt6VN1zFf1azQ9giU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217278; c=relaxed/simple;
	bh=XAnlOeQiYZKbhZkqgWczmzcNiXuwe2h9OchQlHpPJVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyUI4qRrBvT3G3WNqB5EduUnkfubJDmjM7wgyegUBrzNISWbUAvlc6oYPcXAo6rpG2r0tsAhpupIqnTcKk4yjbpLqYfq6SW1n70Rh8sH8BWCzNbYoJdXKXj23hSepB9RDt/oIVMs+Dk9/yis+cWKfuU5xtGfsPHBo1BKI+80Hr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoPHNgGO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoPHNgGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753217277; x=1784753277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XAnlOeQiYZKbhZkqgWczmzcNiXuwe2h9OchQlHpPJVc=;
  b=GoPHNgGObrcVB3Zs8ufBLIQZ9SfjSMH4jU5MJxB8GGC695eigQZv93sJ
   gwfetZy4WF/9F1H3Etd/sd/zCHQlW/uwQky1a90qIYSZ8S41u0HZ4UJCv
   QWTEUN9uwn3rFpz8rTNPMEHDTuj3U+W0jjn7xaFdDLrJtoRB/eBuOpkJK
   XuBO1vpZRvn8Q/FZP22jcnPttIB10fJg0JmRJt4fipj9eY1PEzuK943FS
   n111uuHImRZKNmphknXeXEatHdc1y8ueqbSkdi1Qcy22rFp7/+j5pwH0f
   jzcI9zuzhu6+3SpVAyI/xpW6oWfSZAvb14ZIwNe9v8JZLkgwddSN9lVVu
   g==;
X-CSE-ConnectionGUID: L2vfROYcTQuRATT2l0H92Q==
X-CSE-MsgGUID: JOjJsIWnSmW7Pemv0/MHUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="58100190"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="58100190"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:47:56 -0700
X-CSE-ConnectionGUID: iUNY36dkRT2JaFcmREgudw==
X-CSE-MsgGUID: mATABzgJTP24bj7Wefm0Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="159001634"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.207])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:47:56 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 4/5] cxl/core: Add locked variants of the poison inject and clear funcs
Date: Tue, 22 Jul 2025 13:47:43 -0700
Message-ID: <b243f7e5ac2c34ae8e792cb2614802a2d20ab0eb.1753214969.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1753214969.git.alison.schofield@intel.com>
References: <cover.1753214969.git.alison.schofield@intel.com>
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---

Changes in v4:
Simplify return in cxl_[inject|clear]_poison() (Jonathan)

 drivers/cxl/core/memdev.c | 52 +++++++++++++++++++++++++++------------
 drivers/cxl/cxlmem.h      |  2 ++
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index c569e00a511f..90d3390d9c7c 100644
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
@@ -324,9 +319,24 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 
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
+	return cxl_inject_poison_locked(cxlmd, dpa);
+}
 EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");
 
-int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
+int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_mbox_clear_poison clear;
@@ -338,13 +348,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
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
@@ -383,6 +388,21 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 
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
+	return cxl_clear_poison_locked(cxlmd, dpa);
+}
 EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, "CXL");
 
 static struct attribute *cxl_memdev_attributes[] = {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 751478dfc410..434031a0c1f7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -869,6 +869,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
+int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
+int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
 
 #ifdef CONFIG_CXL_EDAC_MEM_FEATURES
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
-- 
2.37.3

