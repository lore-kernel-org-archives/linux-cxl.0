Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6E35E1AC
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975468; cv=none; b=qjBP3AYzAwxVA9KI0d3ViIDCUdtNfaXNaFSU4PGwF6JOGSGKtMpMUS90YBwcWIEfciRjxO7OOjD2xdcNXJvbBXNX/XYPe8cevO/tCk+p9gnobYff+VfAv5rzIRGUtb3hLMsDz0KUXmizW5mDAZA+6K2+kfy0Yo6SHBh25Ou0vC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975468; c=relaxed/simple;
	bh=kN1qXtZFXpBa0+QRC897LikaXKUaqgVsvbNc0AwzcTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZORhNfvP+wgGoJbeveSizr4M2TDL2fvU9Yw4DyqsVDVtM0hMRP7EdU6HF406JXssHgeOmoKGE/5Ngl5Aceo8n36UU/02dDD/jar+a4UjjZqkBmxvaMDoW0ZmDNqDGdBEhM5KZVddzvfHWAdJhlQWrdxFRe/Wbtu6fSf+ae+DpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJc4hcQd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJc4hcQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783975467; x=1815511467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kN1qXtZFXpBa0+QRC897LikaXKUaqgVsvbNc0AwzcTY=;
  b=dJc4hcQdgL1n8/J8Yigoq2mfwFw6IbIyUGC7wGlxbBnfhlYCmh/Gw95p
   g7IoULEAEyTvq1lKQW/OAtUN3nN9EwrML90suKGnwicJTyPEpo4wRgvZa
   GTfDVMmzJvKLYKW0j0Xpn5H3S3QqLb8Dz271vgC08VCqIbZ8Vh8efBwnP
   SoNYu5aRtov4W9HElsKjnwlJdoxCxMcu2I6UeTs6KIN93+ePcLboFjfFO
   gVxFaMUT0q8PmrergZaXgQunMW1DFYYqCtEWHP7B7YyJMgPTQZgviKl/+
   Xd1VdRg5BYxJE6HTv8gQF/jnBGQvSlKQmIg/WngQuIIuan1TGdUTPWd12
   A==;
X-CSE-ConnectionGUID: FXyD/smwSZGWQvhwwZ+nVg==
X-CSE-MsgGUID: w+DpAGgvQ8mFLyFvEwyN1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95742169"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95742169"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 13:44:27 -0700
X-CSE-ConnectionGUID: UBN5KKaCRiO4fclvZt7ekQ==
X-CSE-MsgGUID: zw/6iIt3S+y1tcEcwfua7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="256285923"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.12])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 13:44:25 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH 3/3] cxl/hdm: Restore commit_end when decoder enumeration fails
Date: Mon, 13 Jul 2026 13:44:13 -0700
Message-ID: <dd46f240738e3eb2663b23ed79fd9544ff5dccfa.1783974681.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1783974681.git.alison.schofield@intel.com>
References: <cover.1783974681.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit_end tracks the highest committed decoder on a port. It gets
advanced before decoder enumeration is complete, so a later failure
leaves it pointing at a decoder that was never added. The next probe
then rejects decoder0 as out of order and enumeration fails.

Reset commit_end before enumerating so it is rebuilt from the decoders
actually committed on each probe.

Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 75d17120233d..0145d3db3107 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1178,6 +1178,10 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 
 	cxl_settle_decoders(cxlhdm);
 
+	/* Reset to the none committed baseline for a fresh enumeration */
+	scoped_guard(rwsem_write, &cxl_rwsem.region)
+		port->commit_end = -1;
+
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
 		int rc, target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
-- 
2.37.3

