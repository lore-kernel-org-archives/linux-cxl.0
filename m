Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3D3CF020
	for <linux-cxl@vger.kernel.org>; Sat, 11 Jul 2026 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783793281; cv=none; b=eA0W5zovJD1U4a2thakV37ItG0N4dZkKPIw5LgSo9OOIGSZyS8/MQpFtL1SFvuahxD9sPn3Ykbz6ztrWxaTCJ2CDYYsSR7ORBaS/vTsyeOs+8yaOTNEQcCywgJY2OYfVc0fS91hbgJfToJDZotWwtxoI5WSMUWW/a6+wQdPq7hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783793281; c=relaxed/simple;
	bh=DCgqREZS+1j78V+Q8afchf5sWEBuMtU24VQEQT1DajQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3tvcNZ9bmoFnp4ViT2l5FbLhXD2FB/o2Qm5jBfCRJNi06OZQnKp0ZoAHnC96MsHTTT33fD2tQexCC+w6E7Xafb7gaHsImPwWTAR7YalZTkrCy/z5+GyMpvvWnnZD/ibOs1MS6QItnBmNlb/4NNxPYMmCxngYadh+z9SPV0c/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0KceXZT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0KceXZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783793281; x=1815329281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DCgqREZS+1j78V+Q8afchf5sWEBuMtU24VQEQT1DajQ=;
  b=O0KceXZTS8xmCo8IJWqY/Urvd7oxSLPk1TkajEMRYLT2/iIwb8KBVHmz
   t3r6/5Puxy1lw9n70H/h+oyVg8xviNr5dOZDzb2tNTZQMovdAt2GV6wIq
   WGuujkaI0P0y3GYeXBCUKJHZgWrDrj0iyk7hJOg53CEyih3OAQjqUVZcO
   lO4iNw8daguFNRTOTNy9K1UUZlN3szSE+6JMhuYJQRTIxiLi2GqMKqjKA
   cmWJQkz/etkiyD0H+7vi3o4CR5dQgQSZdADKBFO+j95s46DkWhG2IUbZ0
   4wRn5Ve1atCAI1FMl0rjj8AzNtWGu7pOpy7pPsT5sc1GV9iPzUiMOh32W
   A==;
X-CSE-ConnectionGUID: idI36jxZS5mTs4LfPjyh7w==
X-CSE-MsgGUID: tR0SG9Y5Tb+L+jiq+j8Y9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95982616"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95982616"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 11:08:00 -0700
X-CSE-ConnectionGUID: rTT/pMLBSCmJkc12Bh1wjg==
X-CSE-MsgGUID: lLpcH3m0TyOWDStAQVUfqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248782199"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.190])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 11:07:58 -0700
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
Subject: [PATCH] cxl/region: Fix use-after-free in find_pos_and_ways() error path
Date: Sat, 11 Jul 2026 11:07:54 -0700
Message-ID: <20260711180755.1779002-1-alison.schofield@intel.com>
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

Drop the reference after the error is reported.

Found via inspection.

Fixes: d90acdf49e18 ("cxl/region: Add a dev_err() on missing target list entries")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
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

