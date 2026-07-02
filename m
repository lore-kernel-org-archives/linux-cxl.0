Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385D019CD1B
	for <linux-cxl@vger.kernel.org>; Thu,  2 Jul 2026 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952260; cv=none; b=Xfg1vGdunXGq7lBrP/+D+EPtKtuL34wPvvX6lCwUUvj/Eo6l7zlvRZmEORP4826ms972Ko4Gn42Uab2D606DyIWSAk2GfQbnPJzlBMGSdJw0YKQvNhztZfa7R105fckQftTWeT5ZhNw0qV3+Br8ciyTWfeeIv0EmF+zkHh4MgdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952260; c=relaxed/simple;
	bh=5NELd3GwPgNAqwbyuRg2/wom50MkFq3E9s3U/c7w1XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N35z17ayoRM7c9ZoKh6eMpXQhEAXLv2uIgb+Wi8B0ZqXmZP+M6WHWIvaRcotLrWu3LGBNu61crTRtIbECH4J4AvQqmmi/EOtDmhOZLTrbbTxWwcMRaoKs1JxrhbOPL1ROmWHwqvWH3SltWUUV8KqblIZQlSHMzicX8xVbKq3Hzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3tFJhsV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3tFJhsV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782952258; x=1814488258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5NELd3GwPgNAqwbyuRg2/wom50MkFq3E9s3U/c7w1XQ=;
  b=e3tFJhsVAvrcSzdDqZfbsTvH4ljrgC5Uz/bFfVvHZKNGr/SeKEt6mAa/
   LbfD34dlYyX37HaLUOLkgSDyGwt4641SvTeJqqbIu26LLryEBAeu1N0mg
   y/PrzwrD/lWJ9mAA43nsfzJHscCSYqiA3D6WpU+nNC9hh6Nh7mTuhKxVg
   qYl9F56r10SYTPcjH4Qc+hvZN/yQB2fYLPZ/8qSg0Mv2TES9iOrIihWn4
   crOXMjHalXcHM8rL+8rBDavHm9FhLgGRmyfIWg9xOjTIz6YrEHtwcM+ZP
   naNbaoAd7W2eHjNIrEwIX/LL9O476iPUKqfxKvUAUAPpYmYeoMZPs577b
   g==;
X-CSE-ConnectionGUID: kj2Tuil4Q5Gz9yn/cUSKHA==
X-CSE-MsgGUID: Y2Pq5RXDS5+VrKuJsd2Syw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83565782"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="83565782"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:30:57 -0700
X-CSE-ConnectionGUID: xotFP3wKSKWGL3pqXOKxRg==
X-CSE-MsgGUID: 0A2RlU5GQOmIl+pyK6VWgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="275920062"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.139])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:30:56 -0700
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
Subject: [PATCH v2 3/3] cxl/test: Assign one mock memdev a full-width serial number
Date: Wed,  1 Jul 2026 17:30:46 -0700
Message-ID: <be03cc3762929ca0ac4e619a5fc7bd8ee7fe701d.1782948930.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1782948930.git.alison.schofield@intel.com>
References: <cover.1782948930.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mock memdev serial numbers have historically been derived from
pdev->id, leaving them single-digit. As a result they never exercised
either the decimal-vs-hex security-key lookup or unsigned formatting
of large serial numbers.

Give one mock memdev a full-width serial with bit 63 set. This mirrors
real hardware (for example, Montage devices) and provides a test
device that exposes both the hexadecimal-vs-decimal and signed-vs-
unsigned formatting differences.

This enables adding a new test case to cxl-security.sh that does an
auto-unlock using a mock device whose serial exposes both formatting
differences.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/mem.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index a1d170f88fee..42f5ffd29651 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1714,6 +1714,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	struct cxl_mockmem_data *mdata;
 	struct cxl_mailbox *cxl_mbox;
 	struct cxl_dpa_info range_info = { 0 };
+	u64 serial;
 	int rc;
 
 	/* Increase async probe race window */
@@ -1740,7 +1741,19 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	mds = cxl_memdev_state_create(dev, pdev->id + 1, 0);
+	/*
+	 * Mock serials have historically been derived from pdev->id and stayed
+	 * single-digit, so they never exercised either decimal-vs-hex key
+	 * lookup or unsigned formatting. Give one mock device a full-width
+	 * serial with bit 63 set, matching real hardware such as Montage CXL
+	 * devices. pdev->id 7 is unused by the auto-region topology.
+	 */
+	if (pdev->id == 7)
+		serial = 0x8a34567890abcdef;
+	else
+		serial = pdev->id + 1;
+
+	mds = cxl_memdev_state_create(dev, serial, 0);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 
-- 
2.37.3

