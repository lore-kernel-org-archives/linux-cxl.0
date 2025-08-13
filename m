Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C3F3009E1
	for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121344; cv=none; b=QxFAKEN/vzLmCjd9Gq1n6q8e3YQSScyb/mpqFTUveKFqra1fazi+AfWquOK3wMExnxCc+0S06JteBEEf4LGeOZcTzJap0kI7abSiq5tA1uwKNyzPOxfucstRAKOKUYa/ptzVq4EGGS/t5IbwSoU6jgBTlDH1KP+AGeiZFQxSqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121344; c=relaxed/simple;
	bh=3gJ9XqQD9X6UXYVCwzQSav7gzjQw74cDbN1Hyp7QxYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UuYlwS5jbH+Ms01OeyPObwtwRdE3yI+kJJEBMKYYxMD06kTV7gSY7b/WdfXDDrBOIkrez3wlvPbOw5sEgjv3MRMDRvRX00ue14QCbXR7nrr27cOFz28xoDgmQD7H/BOQlc4wIFxWDPq/U0xEK5d+jsWfFe2LEYEh+NAaxPW5OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrEPnfVf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrEPnfVf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755121343; x=1786657343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3gJ9XqQD9X6UXYVCwzQSav7gzjQw74cDbN1Hyp7QxYk=;
  b=UrEPnfVfGuY3kgbtM+ZLj0zvdUvx3v4e04VZvd4I4MLYliAZuSKE8cQt
   GS5cJwNHtT1HtaUOF/Ir8f23idiBMLBh/2w7P0PGciMdSnHqw7fagIypy
   k4lQeGnVge2Pg26iHp4DTRknD+cv4YdXe0bRj6c4TCM6GgBaMCOUAj4Ug
   NH/faEXX57/KmkagxBb3fmLo/+AofiizyrLSvNpk0Cb/yGbION8XGK1vR
   xG1r6h4MM1ds8A2GcDuCnjDU3tZ6dVumLLa3R7tvckoULp606nnQfBHUI
   /nf6rYU78xvBZH/h2zk0hXE6vDoXZbWz09dzcMJTTpudrkfNAlTW5rBGP
   w==;
X-CSE-ConnectionGUID: pdrp4QPFQLSTCKlDMDY7Xw==
X-CSE-MsgGUID: H2xrrtxAS1On6iGfquuD5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57334478"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57334478"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 14:42:22 -0700
X-CSE-ConnectionGUID: HWDqM8wnSrW/DgAYBAUn6w==
X-CSE-MsgGUID: AiJKBzLrTT+zm1v17kwqlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="197437281"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 14:42:21 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/port: Validate decoder nr_targets against supported ways
Date: Wed, 13 Aug 2025 14:42:16 -0700
Message-ID: <20250813214218.2917555-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

nr_targets is the number of downstream ports in a decoder's target
list. It is limited to the supported interleave ways: 1, 2, 3, 4, 6,
8, 12, 16. The existing check only enforces nr_targets <=
CXL_DECODER_MAX_INTERLEAVE (16), allowing invalid values, like 5, 7,
etc, to pass through.

Add is_nr_targets_valid() to check for supported interleave ways using
ways_to_eiw(). Use it before allocating a decoder to avoid alloc/free
churn when nr_targets is already known to be invalid.

This was found by inspection and hardens the code.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/port.c | 23 ++++++++++-------------
 drivers/cxl/cxl.h       | 11 +++++++++++
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8f36ff413f5d..7d62797d1202 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1773,17 +1773,6 @@ static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
 	return 0;
 }
 
-static int cxl_switch_decoder_init(struct cxl_port *port,
-				   struct cxl_switch_decoder *cxlsd,
-				   int nr_targets)
-{
-	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
-		return -EINVAL;
-
-	cxlsd->nr_targets = nr_targets;
-	return cxl_decoder_init(port, &cxlsd->cxld);
-}
-
 /**
  * cxl_root_decoder_alloc - Allocate a root level decoder
  * @port: owning CXL root of this decoder
@@ -1805,13 +1794,17 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 	if (!is_cxl_root(port))
 		return ERR_PTR(-EINVAL);
 
+	if (!is_nr_targets_valid(nr_targets))
+		return ERR_PTR(-EINVAL);
+
 	cxlrd = kzalloc(struct_size(cxlrd, cxlsd.target, nr_targets),
 			GFP_KERNEL);
 	if (!cxlrd)
 		return ERR_PTR(-ENOMEM);
 
 	cxlsd = &cxlrd->cxlsd;
-	rc = cxl_switch_decoder_init(port, cxlsd, nr_targets);
+	cxlsd->nr_targets = nr_targets;
+	rc = cxl_decoder_init(port, &cxlsd->cxld);
 	if (rc) {
 		kfree(cxlrd);
 		return ERR_PTR(rc);
@@ -1859,11 +1852,15 @@ struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 	if (is_cxl_root(port) || is_cxl_endpoint(port))
 		return ERR_PTR(-EINVAL);
 
+	if (!is_nr_targets_valid(nr_targets))
+		return ERR_PTR(-EINVAL);
+
 	cxlsd = kzalloc(struct_size(cxlsd, target, nr_targets), GFP_KERNEL);
 	if (!cxlsd)
 		return ERR_PTR(-ENOMEM);
 
-	rc = cxl_switch_decoder_init(port, cxlsd, nr_targets);
+	cxlsd->nr_targets = nr_targets;
+	rc = cxl_decoder_init(port, &cxlsd->cxld);
 	if (rc) {
 		kfree(cxlsd);
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4fe3df06f57a..02b526a16492 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -132,6 +132,17 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 	return 0;
 }
 
+/* nr_targets must match a supported number of interleave ways */
+static inline bool is_nr_targets_valid(int nr_targets)
+{
+	u8 unused_eiw;
+
+	if (nr_targets <= 0)
+		return false;
+
+	return ways_to_eiw(nr_targets, &unused_eiw) == 0;
+}
+
 /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
 #define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
 #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))

base-commit: d9412f08e25a5b66f9021739c090cc9b8f1089b1
-- 
2.37.3

