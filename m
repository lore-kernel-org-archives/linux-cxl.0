Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C17E60EC4
	for <linux-cxl@vger.kernel.org>; Tue, 13 Aug 2024 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547593; cv=none; b=W560KP7/WiDdXMhnlQ0E5DzFOqa1KKRd8AmLBRdxYNB2EXCo4Nq8P6oLmLB9zndqEDSAKszHaDLhm+qwdzOQtL+kqwQhELqRQZ0854MGDcTIO3cj6z2s11e7ElxtRhpiEdMLU6cv9GpXkA9SEqk1GMwCW0Ob4qB+OMwVks7WJRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547593; c=relaxed/simple;
	bh=HtbhDkCJFzG9yz3rILklI4MVQo2jGhPyNbk4lIsj02U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BW+6Ajo6elulhdA/aZGHmEOQ/ZUCobSVeURuSP9Dbjp2kEB0Qp2CkcsxY9I7+FnfG8xoKx2fSp+ito88YhHztSZFvKWhdHLOR4L1u6PJkHST00+CPBmYtGRQ2ycqymLHRrQZhpHBqgxmuee9x1AWEnELIFZwTILsgP4GJSz3F/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkCuA4Eb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkCuA4Eb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723547592; x=1755083592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HtbhDkCJFzG9yz3rILklI4MVQo2jGhPyNbk4lIsj02U=;
  b=PkCuA4Eb+sWy45TiNAIBiFI1mwBI5f0hsLn1vqrWIQwZxoeH1RzEjQcE
   +3iZlIG/So3ZnG69q80zhub4gdfNp8TonaEfswTL0YiRQXl7ptXO+fOSX
   5Otnm9nrREJ/jI/CJR6vzu0Qu1GQm8IC5NNx/OjLk2euwPRgpkLPXUYvM
   Xvo2WFYy/uhTjyN0AR3a9Yt4D/0ggB5H3HTowTXgnQmQrp8pjQ7t4FQOG
   pI9JCIVnzIKF7/nOJLkvC/S5pFjNh+ZmGn/3YWBrLzpU+qtfroV+Q3eny
   ZPtg2SCMN1mBeRSxN2D8LlUXKfJxS4pbqEbf7M0TM6+vW+oFlosR5W2+7
   g==;
X-CSE-ConnectionGUID: khRhn2dZQL+l8c2+b3BGZw==
X-CSE-MsgGUID: 52ZBBNcdQoaG1FaJS4Sigg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21262341"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21262341"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:13:12 -0700
X-CSE-ConnectionGUID: f3H6uXsGRY2WycN3Ix924g==
X-CSE-MsgGUID: C5MnOlrDS3iHmnWF1+HgTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58568797"
Received: from tower.bj.intel.com ([10.238.157.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:13:10 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	ming4.li@intel.com,
	yanfei.xu@intel.com
Subject: [v3 3/4] cxl/pci: Check Mem_info_valid bit for each applicable DVSEC
Date: Tue, 13 Aug 2024 19:05:31 +0800
Message-Id: <20240813110532.870869-4-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813110532.870869-1-yanfei.xu@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The right way is to checking Mem_info_valid bit for each applicable
DVSEC range against HDM_COUNT, not only for the DVSEC range 1, hence
let's move the check into the "for loop" of handling each DVSEC range.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/cxl/core/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 38c567727dbb..519989ada48e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -324,10 +324,6 @@ int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 	if (!hdm_count || hdm_count > 2)
 		return -EINVAL;
 
-	rc = cxl_dvsec_mem_range_valid(cxlds, 0);
-	if (rc)
-		return rc;
-
 	/*
 	 * The current DVSEC values are moot if the memory capability is
 	 * disabled, and they will remain moot after the HDM Decoder
@@ -345,6 +341,10 @@ int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 		u64 base, size;
 		u32 temp;
 
+		rc = cxl_dvsec_mem_range_valid(cxlds, i);
+		if (rc)
+			return rc;
+
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
 		if (rc)
-- 
2.39.2

