Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE859241686
	for <linux-cxl@vger.kernel.org>; Mon,  4 Aug 2025 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294425; cv=none; b=SI1bdqaLLF+UVzf9VcFtR0vgYga8JznuxBhT9a7ZWl0lUeXes/IGDKBBM8kx/eIiWiE4ii2y8JK3J03aGWRO84lTrVZ+k3X3BndrWm/VgRiNE6M8EmJo3Eo+hkHKFrDJw5j3FTRouXvlnOrrDfUTGIs3BjGpXsDDohDx2MA51mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294425; c=relaxed/simple;
	bh=m7f+XRjk7fWNe1H+QR9ZsXbyZJMacbt1rIVniuHqFaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoLPJh6SPiqg8AN0u0j63L0p2JGtrcIhUWDltX/XI9fqy4OXKY7LWayMvKfR57Ou39xNAMhAA+c9WwXYs/tw9+RZOAl8i2jDpHAj/3dnRR+FNMeM7WFxrhSib+kWlfnxHhm1fc2X5E0IvBToVww4/KTvN8KQNc9TMC4wWXO2o1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ngt47E29; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ngt47E29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754294424; x=1785830424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m7f+XRjk7fWNe1H+QR9ZsXbyZJMacbt1rIVniuHqFaI=;
  b=Ngt47E29kLnFbrurxvDKH0Szt2PIT76SFINEpEur0PNpDtoKLsvhueE+
   EAwBFZNZX/QcNYICS425uklRUEiqmFQWvOJj0cvMloaGgtUX6AO5N9RHG
   CfYpXDXgBif5jZ8lSLMO40DDR+HgAqFj9eiKaL4Y/K83XabVcgRCxHEE7
   sNZPCAYkuuhZ/ErdjxzCAY6AlLFzgvSjazzo/yIvJFPIAjpEjVQKb3MUq
   YK9Q82dyczdu68Jhy9ufuJGr/n9mdlqeIRmcd8uVf/K5N4D/Q0aDCyUD+
   xMwPjB8S5EPsVqaKN0R2ksMa06Dlx5aBAQmU9P5hkboKcxpmFzFZKHK+A
   A==;
X-CSE-ConnectionGUID: MBRKvf4eT+mWh5NOAe80Aw==
X-CSE-MsgGUID: 4O1Ap84cSWOUZ9ssAWUoHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56474229"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56474229"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:00:23 -0700
X-CSE-ConnectionGUID: iBilAtG7R1C47E69WyOe9g==
X-CSE-MsgGUID: 5B9+alBlTMOypcMkzy76ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168548872"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.77])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:00:24 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v5 4/5] cxl/core: Add locked variants of the poison inject and clear funcs
Date: Mon,  4 Aug 2025 01:00:12 -0700
Message-ID: <1d601f586975195733984ca63d1b5789bbe8690f.1754290144.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1754290144.git.alison.schofield@intel.com>
References: <cover.1754290144.git.alison.schofield@intel.com>
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

Changes in v5: none

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

