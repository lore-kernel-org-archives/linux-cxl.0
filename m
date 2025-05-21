Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F11A317A
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747870590; cv=none; b=rcley/KuoUrIDiS+g7SIAyJELQtE6Bu/MlRKgzNcuhe9Ao31eAVG6FoTYoxBlAMJVOwaH4ww26uKdoKWxDF5DJidNcjuRLr/AvJUd9dy1fgEdaAuorFr92PrTmxznExtxUlj+C34drXcc3q402T/QmWcNdSrGrRpIuGt+oJVoko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747870590; c=relaxed/simple;
	bh=OYJLStOjNYB0MAJVLbPxMdBdAWKQDmMRy+GQPZpiEYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WgtFnIW47PDIufff4Ffwy8nhGirKc/xZqG+2i/P2Ct0mmwHPI6ar83xwi2Uy5oSYKbooNDUDXQ6wDRRWG/cA6VKoIwUJp9UypFz4Vy5nnNu151fMAEj4h0COAoQ6OQINjXD6o0uezxPuiL3kVwaOuDGpHvT4jxc7ORRtAyOMwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AETsdcVd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AETsdcVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747870588; x=1779406588;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OYJLStOjNYB0MAJVLbPxMdBdAWKQDmMRy+GQPZpiEYk=;
  b=AETsdcVdq9cv2vL3f8WNWqHLSlLrcwbMCyz2REaz2Hf0m7lzNq6RzuvX
   Lnaev1btEio5+ui2GkAnjrMmANl02+c1aAKZsa0ns4loBh904R6wNHcul
   6ZmogNIJn4PLvGnmLU53x2XWJpPq4B2Yrt+XQjln43jejhajuWwsLeRx7
   MGHRdiO0ts2JZ0x8BMxi25w5bSsIU9RIVdry228D09cvqFZTXJ5KkdQxn
   XTp5rXg86jFIUR5XnhXGTZN2wXaOSJJP4miP2aN0VnSDowmqX7t5ViaHx
   kbPx3XYLraO9S5SCwG596r+rf8a0KGb4PYJI2rOy0FqnZSh1aCiKkOfOJ
   Q==;
X-CSE-ConnectionGUID: YSwChGQYTKeIz7nvB2Ea5Q==
X-CSE-MsgGUID: xa6oG2soScGsZw98c+jtJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49976525"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49976525"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:36:27 -0700
X-CSE-ConnectionGUID: 57HFj18pRniRrxYxmq/5fw==
X-CSE-MsgGUID: /3+wtPk/TaOuyh4wzzM0nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="145030315"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.225])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:36:28 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/features: Remove the inline specifier from to_cxlfs()
Date: Wed, 21 May 2025 16:36:23 -0700
Message-ID: <20250521233625.1745849-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

to_cxlfs() was declared 'inline' in the header but only defined in
drivers/cxl/core/features.c. This has worked because features.c was
the only file using the function and the definition happened to be
available in the same compilation unit.

However, in preparation for a second .c file using the header and
needing to call the function, the inline specifier became an issue.
Sparse flagged the declaration as invalid since 'inline' requires a
visible definition at the point of use.

Defining the function in the header was considered but rejected, as
it depends on internal symbols not visible at that level.

Remove the inline specifier to correct the linkage violation.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

I intentionally did not add a Fixes Tag at the point this was
introduced because there is no breakage until the second user
comes along. 

The second user is this patchset being reviewed:
[PATCH v6 0/8] cxl: support CXL memory RAS features
https://lore.kernel.org/linux-cxl/20250521124749.817-1-shiju.jose@huawei.com/


 drivers/cxl/core/features.c | 2 +-
 include/cxl/features.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 1498e2369c37..efe88c043227 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -36,7 +36,7 @@ static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
 	return is_cxl_feature_exclusive_by_uuid(&entry->uuid);
 }
 
-inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
+struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
 {
 	return cxlds->cxlfs;
 }
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 5f7f842765a5..b9297693dae7 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -64,7 +64,7 @@ struct cxl_features_state {
 struct cxl_mailbox;
 struct cxl_memdev;
 #ifdef CONFIG_CXL_FEATURES
-inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
+struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
 int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
 int devm_cxl_setup_fwctl(struct device *host, struct cxl_memdev *cxlmd);
 #else

base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
-- 
2.37.3

