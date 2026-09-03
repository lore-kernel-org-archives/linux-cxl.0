Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979133C1B6
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477852; cv=none; b=iVX7+J5RuWDsG9zBUtWyI9qOSJz28l06OWgGt4oOZV9jnpLl/H7d6f6yMdvB0dlTBghs3N3uwvXDC7/3Sh3QjZGsGTidKaQRYkPcw9lQg84OcQbELePWYGTei1Ps18uy/ouP90DbhtCtQyqgavLQpaqIRF/7hQ32b6ED4mSh0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477852; c=relaxed/simple;
	bh=IGFVQmBz2Dm8Iwz7VAkpIHuUTYJ9RxtgG33AN72bj+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biMqxbg6ghF3W9qu8v7YJzuDanqxk11iMTiG2H1Tq+n38UkS43ELNsAy67Y84WZBApPP2RJxLU6VgSaqCnBYkGf6u8a4ZK5h6DtRhZbUabOctgBi/Oz2WQWCVUQqYIE3SpONFfrgfIalcmmLV0DyQds/jivDOebM1Get72N4Xvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWPXGm5E; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWPXGm5E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788477851; x=1820013851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IGFVQmBz2Dm8Iwz7VAkpIHuUTYJ9RxtgG33AN72bj+g=;
  b=AWPXGm5EIyHic9ldFocjgfWHZTNzArqfHHKMR1Nus1ZbvuYI15CeMRn9
   2viBMHZKXYlFkmS43GsNVS9Scd8sb4hK6XWqLT8+r22HSkjBs3ga39XkC
   4e1fiqARnpL7FuNKxONNPlRmFRSY0i3MXdTm9X/FL4qe3yf4hFWZUF0Ef
   b1ZIK1LdPcCMM1D99OZRQfYXMwHyhV6Hcp5DHi4LXfgycCRRKmHo8LFl5
   6KO/WCbZ+e8mV7R15AYeL+dtG3hB9apgagC3O4xYPuGAVbpbap8PX01YG
   rW35wMGTDNqLrUj6pTKAhtSw2Eeen/nEYBuCfvCfYnkQ/YJz9h0ukuliH
   w==;
X-CSE-ConnectionGUID: TcLaeOVtSHCX6toz14Sdmw==
X-CSE-MsgGUID: 1pOelZm1TRiEqIrptBH9Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106344644"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="106344644"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:10 -0700
X-CSE-ConnectionGUID: paGr/jXYQIOtoheQ2oVPQw==
X-CSE-MsgGUID: Qm6u0LKGQuKstT/ygrBcjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="308087791"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 2/7] cxl/region: Warn on user region position mismatch
Date: Thu,  3 Sep 2026 16:23:44 -0700
Message-ID: <1d662e3ea78ec8b05fceb500f04e69ee9f6d4a72.1788475206.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1788475206.git.alison.schofield@intel.com>
References: <cover.1788475206.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User region creation includes a self-test that checks the assigned endpoint
positions against the position calculation used by auto region creation.
The result, matching or not, is reported with dev_dbg().

Promote that to a dev_warn() that fires only on a mismatch, so bugs in the
auto region position calculation are easier to catch as that calculation is
extended to support more region configurations.

The matching case no longer prints, so dynamic debug on region.c no longer
confirms that the self-test ran.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/cxl/core/region.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..6a698f36aa6d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2215,10 +2215,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		int test_pos;
 
 		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range);
-		dev_dbg(&target->cxld.dev,
-			"Test cxl_calc_interleave_pos(): %s test_pos:%d target->pos:%d\n",
-			(test_pos == target->pos) ? "success" : "fail",
-			test_pos, target->pos);
+		if (test_pos != target->pos)
+			dev_warn(&cxlr->dev,
+				 "%s: position mismatch: calculated:%d assigned:%d\n",
+				 dev_name(&target->cxld.dev), test_pos,
+				 target->pos);
 	}
 
 	return 0;
-- 
2.37.3

