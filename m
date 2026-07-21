Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B986369D71
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655431; cv=none; b=c0GHxIPNy+1Lqzxv4Q7vUvWzKw4H22O+fH7SeQhmBCOIr2qZh2V0NxnZ9MTQJLHTDoAg3SmJqIOjbaWmXtvGdEYCs9pc2iy1Xz7fijirSTS/iNpu6UIKRYGRlm9F8cxAFzLxgroVsLyYjeRoPAUp/8J7QxLb3ZOT1U3T0OK6iF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655431; c=relaxed/simple;
	bh=9CansrlgyyP3gUMHNdV0ha6t+LH+ydqnVUS2qiTMQtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRXdAc1Shjhare3eCZjGYHWcEZycRy5eYQxRj/pBzhxxsVG2YziNe948/LbTUXAmAkDwsso0V8JjEu6DKu+gIoKw8JFcFrXAe2vUvhUeyjOwgRs9e5WBeN2zbV1M3fS8M9xTVOMYQ4bXp9TvYMi4YjDZxHOByM9b4ASYff7MnLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nebn8kWa; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nebn8kWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784655431; x=1816191431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9CansrlgyyP3gUMHNdV0ha6t+LH+ydqnVUS2qiTMQtE=;
  b=nebn8kWaBhyKatBk9S4tgKaPHysuq7UxL/4hthupKx5B18lSBSeM45b2
   3se8QqZJA1Yb67Gu7WepU/CcCslZUMeA9NQYERVmoaOrvfGMNBZssPDsY
   RV/ganSaqZRE2BCVt5oug/KxkPNIXp9V8/+wsKPGesA1P3YAkLTk1Q8YJ
   UJZEWqoayhX0kgvTauCuJ4W9FIwvyJ//7xqVqvnX+71T/tVcGvvsadmYy
   Len5YbnNMHw2x+g595aST2kIlKt6MVAQJgEAqI6aEV9h+ejqukOx/+nOy
   mGKwrv8BWxqTmCRmNJOlXmZnKqH7hzDPhUnRcEzP0rZ+64NNYoOQ1iq6S
   w==;
X-CSE-ConnectionGUID: I9sVEfIFT+i1ZH0ii/w2cg==
X-CSE-MsgGUID: QCTKd7PYQ5GfvKBhZ+c1+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96782119"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96782119"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 10:37:10 -0700
X-CSE-ConnectionGUID: o+pdtNEUT3mDMtWxe9jC7Q==
X-CSE-MsgGUID: fc2WBhZpRn6PsVYvNzsixA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="258486547"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.249])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 10:37:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 1/2] cxl/region: Fix use-after-free in find_pos_and_ways() error path
Date: Tue, 21 Jul 2026 10:37:03 -0700
Message-ID: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path releases its reference to a switch decoder before
logging an error that includes the decoder name. If the released
reference is the last one, the decoder can be freed before the error
message accesses its name.

Drop  the reference after the error is reported.

Fixes: d90acdf49e18 ("cxl/region: Add a dev_err() on missing target list entries")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

No changes in v2.
Reposted in series w the __free change in patch 2/2



 drivers/cxl/core/region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..c86dd9d55e93 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1938,8 +1938,6 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 			break;
 		}
 	}
-	put_device(dev);
-
 	if (rc)
 		dev_err(port->uport_dev,
 			"failed to find %s:%s in target list of %s\n",
@@ -1947,6 +1945,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 			dev_name(port->parent_dport->dport_dev),
 			dev_name(&cxlsd->cxld.dev));
 
+	put_device(dev);
+
 	return rc;
 }
 

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.37.3

