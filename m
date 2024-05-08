Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A154B7C6CE
	for <linux-cxl@vger.kernel.org>; Wed,  8 May 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194080; cv=none; b=F81b62mbPPyzrfuT7k8fXXyhLWcKGZVXIxEv5P4mRYSU3Jhnrk/QVr4iIGK4TSfkAhhnqTQRM+d0Wf3ZwCFm+UvewBDvuk24acVeLbbCfKfnVE+/knlirJ46ZCUKVyzJCRP5SGDXIacNb3geWkikycZ1rHvln9k+tDg7mFdO5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194080; c=relaxed/simple;
	bh=VM/Yol1pgkm1vC/WnCTMkBF7VRGnNQzXEBX5CkJhHaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IpH9hPidlzrOhGiQEXOYk1DgDx9VyRXNbpOuUeqPuaWpOjQM7MjCk+ql+jAWt2XSWxdmRVJvQ3R5PTZUbrLGRE4c9jWRN4S9laj4rUoWkzyLMBsOdAEYYLqk5kl/+3V/F3RY8ZdYmtlaI0p4u+OyZie4/MTRDQnZ6TJaIFvbPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/rvN8Lz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/rvN8Lz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194079; x=1746730079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VM/Yol1pgkm1vC/WnCTMkBF7VRGnNQzXEBX5CkJhHaQ=;
  b=l/rvN8Lzes3ipWwPqsbh3Rgt0/wlJvNMqyIoPHedGMMYgAzogOK6xp0v
   uFA0CT5w/wDyN4a8F0yMZTWxnGmTNrwc01jUGrhMm9AOrXG1FbgtDFQp0
   1gciLvJgaPxGBCKw9JT3+vLBXAJWbgyqoVHrt7MSeEmk6P1ygzqJBJZ9L
   9wW0u/OjEJ+8QyAmpryfpjRzLBVEqimXkRpkwI65AoPb89zb+nvdF6//H
   uEJ2UwXSf0MZnmuOhW5ZvDvZodLcH1/Q+oJCPYSUdRr4piIGoTj1uXns5
   Z4FW/w5awhhhMNOzP50gfPjf5Ke5voqF+iNXBNomZ02xm9xk9Nzzf93Wf
   w==;
X-CSE-ConnectionGUID: rIdgSLYORf6rw38zgPALyA==
X-CSE-MsgGUID: 7mDX5Wv+RAi+n1aKBknsKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10928016"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10928016"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:47:58 -0700
X-CSE-ConnectionGUID: 2RP6hSznSnCV0oDjbtQZ3Q==
X-CSE-MsgGUID: 9QIDkd4SRKyt1p5gP3rO7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33811964"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.242.107])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:47:57 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 3/4] cxl/region: Verify target positions using the ordered target list
Date: Wed,  8 May 2024 11:47:52 -0700
Message-Id: <562c5e2097f32567bf7aa505d7952d9c068d830b.1715192606.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1715192606.git.alison.schofield@intel.com>
References: <cover.1715192606.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

When a root decoder is configured the interleave target list is read
from the BIOS populated CFMWS structure. Per the CXL spec 3.1 Table
9-22 the target list is in interleave order. The CXL driver populates
its decoder target list in the same order and stores it in 'struct
cxl_switch_decoder' field "@target: active ordered target list in
current decoder configuration"

Given the promise of an ordered list, the driver can stop duplicating
the work of BIOS and simply check target positions against the ordered
list during region configuration.

The simplified check against the ordered list is presented here.
A follow-on patch will remove the unused code.

For Modulo arithmetic this is not a fix, only a simplification.
For XOR arithmetic this is a fix for HB IW of 3,6,12.

Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2fe93c5a8072..6aa2c981f1c4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1559,10 +1559,13 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 				      const struct cxl_dport *dport, int pos)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
+	struct cxl_decoder *cxld = &cxlsd->cxld;
+	int iw = cxld->interleave_ways;
 	struct cxl_port *iter;
 	int rc;
 
-	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
+	if (dport != cxlrd->cxlsd.target[pos % iw]) {
 		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			dev_name(&cxlrd->cxlsd.cxld.dev));
-- 
2.37.3

