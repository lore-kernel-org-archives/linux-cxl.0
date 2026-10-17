Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1383E44F8
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264810; cv=none; b=kXm5W5Oskc80bN1m+ITaLxwiP9Vx4Al8nE9xLdC/qEqvkNSMwrXRLo5R8qe6FmHx3Wrhm4xXHwyadF/1/3l3lmYS934r5EyNoN/eimU00FuryZ0dqIz1CDqu4IawZs4YPda9qQdM8Uh+3V6tbSPaaJJwl1c5ZnOk/tsrBZ6jBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264810; c=relaxed/simple;
	bh=HKKsS3gTZ9hrpFU1A6id6sXQeffyzEkVuGa6CJqvJDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdInI9eA1Zn/HJ0CJiJMle3l6B8eMZ1P3YFiWaGyKC8F7jUH5yJZ6FbGeX1L5eTuOJ4i6J4o9fe6NLxuMkE39IQgdV/6/t4c3ydOavG+VArFvAGVd9nKQxvUl6SxYR4/xpW5LR+sO8izHCd1gLF5UL5+yc7KIW/bNR3WNpW70sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNrHJ//5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNrHJ//5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792264809; x=1823800809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HKKsS3gTZ9hrpFU1A6id6sXQeffyzEkVuGa6CJqvJDo=;
  b=PNrHJ//59e3qx2S+ZRTHVubDFVrCUq+upNUZEPgJ6n3MYZEF7ew1UThG
   ULu9k2urKg3WbPwSkyrrlsXmz8q85XoPKKe7A6l2TsRdvRXq6Y3CVlpb6
   iEpSeY4CIJp2BfSX+FAdnr+lA5aIeCc6Gt5KqvDIv5qYPOYiZs3GW+E+N
   yGD5hJCA0dJt2UyhMF5ckbgK6joqWWic3fOYSpGVcT36NmLGGNbi6mEeU
   T/AnWbkGSz677IEGhjzDkK+fotn4V+oAWkNiic+BXdtze7hfbv+mCPUC4
   7al04fQ/w1GZAA4PAvZbDTenOLbowA+HU0N9nxSQOYu00+sxl9/ti3WKd
   g==;
X-CSE-ConnectionGUID: V2e0TL61Sei3Mt0nFe/hTg==
X-CSE-MsgGUID: pfbITvjETry79Srerk2Fyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1034683"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1034683"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:20:09 -0700
X-CSE-ConnectionGUID: jiwKfv3HSoGaGb5epLttDg==
X-CSE-MsgGUID: GHXIsNJkQJe1M/14IvwwSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2282223"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:20:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 4/9] cxl/region: Calculate peer distance only for reused targets
Date: Sat, 17 Oct 2026 12:19:49 -0700
Message-ID: <6ac7f8fae75f7cd29b5d530a552aec2b6c6169b5.1792263750.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1792263750.git.alison.schofield@intel.com>
References: <cover.1792263750.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Cheng <icheng@nvidia.com>

cxl_switch_port_setup_targets() calculates peer distance before
searching the existing targets. When the endpoint needs a new target,
the calculated distance is never used.

Move cxl_port_peer_distance() into the matching-target branch,
immediately before check_last_peer(). This avoids unnecessary ancestor
walks and per-port region lookups when adding distinct targets.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4ab5a1d025a9..8bfebe3e1025 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1485,10 +1485,10 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 	}
 
 	if (cxl_rr->nr_targets_set) {
-		int distance = cxl_port_peer_distance(port, cxlr);
-
 		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
+				int distance = cxl_port_peer_distance(port, cxlr);
+
 				rc = check_last_peer(cxled, ep, cxl_rr,
 						     distance);
 				if (rc)
-- 
2.37.3

