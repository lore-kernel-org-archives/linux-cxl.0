Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C3208972;
	Tue, 29 Oct 2024 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234119; cv=none; b=U9KQEks2PpuIwCVCbvd/viSMMB5DJq69A8oVGenT0ehqswhBaUj1hoEKXQWmztNdo5WmhdjtvlGk0DcXGO4bTo8F11n909utX1vrcDMjQJ6WfCVlc0edcXMwQUc9baNxSgoemVbAnMJSKiP7AGaBQJcM56IX4ITbkwRqo5/Z/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234119; c=relaxed/simple;
	bh=BVvQA0Wr2Feq0YcwEbv2GBXCYGRxu2UFOhLc7doL7LE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMs7Zy4rY5uB+dOapC5ENthnyKGxZlRgonWcQBNl/ZsK9E8tL+Npxb5KGEiT4bVH3i6lunifW8t1EET+6qbennTWfaadm/Gy9Z9/V01Q+aQOWbioX+10El3tuOJE5vSPKE0qqJY/UQaN5FUBdESk11rnwwNv1S4fW+PhixPkpiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qkum2Di1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qkum2Di1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730234117; x=1761770117;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=BVvQA0Wr2Feq0YcwEbv2GBXCYGRxu2UFOhLc7doL7LE=;
  b=Qkum2Di1wq2DP5LnZjFuUs6lrPG3GH2ZuMnPgT22spH5yKwFR2rM/VHR
   mYg1bSVgUGPjZFTl+PO3hrPJBZd467qJR5F49wznokzvawukMG410ZeT6
   ynmabLsx53Odut6FftDeOSobeKyLkFYgHIBXtqmqZnfZsk1SboEPZpz0k
   sdV4XzqAqf4N/zPQK7YbF/HVyoRXZgrYZCpReBwxWPDNpZu1++dETXbRJ
   hGcHtJu25lO+/Y+VMp0JkQo/TrVn756bnEsFvjqbnGQnhysExvMT2QXUM
   1Ny2EWCRaWEuDuNEJg14dWwHqbGIbNiDZencEhaUxD+6e9PpLXKLE22IX
   g==;
X-CSE-ConnectionGUID: oNRjlrbgTJWYIhWfMw+lNA==
X-CSE-MsgGUID: xZ+CT33CSySgWVq7CbTHIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29865484"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29865484"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 13:35:16 -0700
X-CSE-ConnectionGUID: GKi77yszSsWXnxrP4tXokw==
X-CSE-MsgGUID: zgmNxCB6S4S5fJnMqEjANw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="81712138"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.108.77])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 13:35:15 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 29 Oct 2024 15:34:38 -0500
Subject: [PATCH v5 03/27] dax: Document struct dev_dax_range
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-dcd-type2-upstream-v5-3-8739cb67c374@intel.com>
References: <20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com>
In-Reply-To: <20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730234086; l=2342;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=BVvQA0Wr2Feq0YcwEbv2GBXCYGRxu2UFOhLc7doL7LE=;
 b=j9JJ6cxqQGkVide+rb/rIC6Ht/pxZO5U3vJrBgtX01VodUfkmkKl7YD6/xp7Fvb71nHditg6s
 Ov0isqwUEviAUACXwg9dQOgk3uIVqteTsCBYTzZkdyrjLe5oYm57Ik2
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The device DAX structure is being enhanced to track additional DCD
information.  Specifically the range tuple needs additional parameters.
The current range tuple is not fully documented and is large enough to
warrant its own definition.

Separate the struct dax_dev_range definition and document it prior to
adding information for DC.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[Jonathan: break out the dax_dev_range structure]
---
 drivers/dax/dax-private.h | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 446617b73aeab2e6f5a2ec3ca4c3f740e1b3e719..0867115aeef2e1b2d4c88b5c38b6648a404b1060 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -40,12 +40,30 @@ struct dax_region {
 	struct device *youngest;
 };
 
+/**
+ * struct dax_mapping - device to display mapping range attributes
+ * @dev: device representing this range
+ * @range_id: index within dev_dax ranges array
+ * @id: ida of this mapping
+ */
 struct dax_mapping {
 	struct device dev;
 	int range_id;
 	int id;
 };
 
+/**
+ * struct dev_dax_range - tuple represenging a range of memory used by dev_dax
+ * @pgoff: page offset
+ * @range: resource-span
+ * @mapping: reference to the dax_mapping for this range
+ */
+struct dev_dax_range {
+	unsigned long pgoff;
+	struct range range;
+	struct dax_mapping *mapping;
+};
+
 /**
  * struct dev_dax - instance data for a subdivision of a dax region, and
  * data while the device is activated in the driver.
@@ -58,7 +76,7 @@ struct dax_mapping {
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @nr_range: size of @ranges
- * @ranges: resource-span + pgoff tuples for the instance
+ * @ranges: range tuples of memory used
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -72,11 +90,7 @@ struct dev_dax {
 	struct dev_pagemap *pgmap;
 	bool memmap_on_memory;
 	int nr_range;
-	struct dev_dax_range {
-		unsigned long pgoff;
-		struct range range;
-		struct dax_mapping *mapping;
-	} *ranges;
+	struct dev_dax_range *ranges;
 };
 
 /*

-- 
2.47.0

