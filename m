Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA43F12EF
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 05:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660232; cv=none; b=s9MDobMLnXlyQChuu90iWvtBBC6hJx027ZtLrdI3c48h4Ylj1Pgbv2C+FBmDGqOL8tet5cBB1Hdsec8lW1h3u8tQTpO/OYC5hz7L4JzPP852cfFW3uPHt0dgGbWPsDdh40dP6rLQPj/7h4hi66DO463CNYImXDsV4ASgli/Q76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660232; c=relaxed/simple;
	bh=fnzaeLx7gy8SJJnJe5RBXXbaPYUfSZ9qcNgeHoD+lRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7YrY9whmCzA6aCGdE45M9zx0u1FL/QI2enTb/xvplR+7I4jOMfbsYgSXrT9NZrSm4AhwfqffCoTIKsgi7TyEDLDOAKAWYq/43l477z90svvLHf+qdlRv0+/AmT8f9bgCDio52E+0XlBPpJ50U+MIhcAv3IoI93lMK0SihFgJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHsFtOA6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHsFtOA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790660230; x=1822196230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fnzaeLx7gy8SJJnJe5RBXXbaPYUfSZ9qcNgeHoD+lRo=;
  b=PHsFtOA6Nv5UUmKzyoudhQPrVWZcAVDaFxtToPLI1cuNYgawc06Swu38
   54Dba2ZDWQKHm6+qgumxfh38cfFWtrqP3guBlWfuqhqjEg/hf6gSciMhO
   4A7ylXgDONPQloawhISID+c5aCUptlYvaMFMHscC/o/8bDolGVTm1s3H3
   TMTZ9CUXucPUss9Jkl8gOtEFq5zCICR5XbIKQflRqzBNjvlP8pEhNz9tW
   Gg3zGfqHmneJ5fGmZLFSPrUqboFC0qY2tosXBYmnwowSSPZzM61a0ZbNU
   RNPV/du0YEXDtjafAygTdnhvZc4AZzx1gmydKg5rjN9nbenbl+eLwMzOR
   g==;
X-CSE-ConnectionGUID: Iu4SAxN5ST2kW/UwVE6m3w==
X-CSE-MsgGUID: 8JT6AMfhTFSfouTnXxO+lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="100700086"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="100700086"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 22:37:10 -0700
X-CSE-ConnectionGUID: S3X7o2phTUeZFxAETGKd5g==
X-CSE-MsgGUID: hMc5jwS7QRCn4rUs2RqfrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="304767501"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.149])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 22:37:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>
Subject: [ndctl PATCH 7/7] cxl/region: document --decoder as required
Date: Mon, 28 Sep 2026 22:36:59 -0700
Message-ID: <2c079cbc4b37271f0b7f06da0990233539890ed6.1790658549.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1790658549.git.alison.schofield@intel.com>
References: <cover.1790658549.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cxl create-region documentation describes automatic root decoder
selection when --decoder is omitted, but that behavior has never been
implemented. Users see:

	# cxl create-region -m mem0 mem1
	cxl region: parse_create_options: no root decoder specified
	cxl region: cmd_create_region: created 0 regions

Document --decoder as required.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Automatic root decoder selection may be revisited as part of future
usability enhancements to the cxl create-region command.
---
 Documentation/cxl/cxl-create-region.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/cxl/cxl-create-region.txt b/Documentation/cxl/cxl-create-region.txt
index b244af60b8a6..47c23ffb2565 100644
--- a/Documentation/cxl/cxl-create-region.txt
+++ b/Documentation/cxl/cxl-create-region.txt
@@ -94,16 +94,15 @@ include::bus-option.txt[]
 -g::
 --granularity=::
 	The interleave granularity for the new region. Must match the selected
-	root decoder's (if provided) granularity. If the root decoder is
+	root decoder's granularity. If the root decoder is
 	interleaved across more than one host-bridge then this value must match
 	that granularity. Otherwise, for non-interleaved decode windows, any
 	granularity can be specified as long as all devices support that setting.
 
 -d::
 --decoder=::
-	The root decoder that the region should be created under. If not
-	supplied, the first cross-host bridge (if available), decoder that
-	supports the largest interleave will be chosen.
+	The root decoder under which to create the region. This option is
+	required.
 
 -Q::
 --enforce-qos::
-- 
2.37.3

