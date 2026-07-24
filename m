Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BA1FBE90
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925449; cv=none; b=SK1NxnRPiirs8dqcMottNglxSjmYzmoAJGsXM0EyGSyYkkns1UVO0A4taK5sWpXeJijZ2tSMNGKFlSRDGLI3Mpmw1oyGioi4xWAaWjFw/MIqrxmasWAtPuoY4FzJKS51JloztPwDNlbe0rkiB3bZhXmpVlzJ9Q7pqs+HDawJRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925449; c=relaxed/simple;
	bh=SLtY6FjcuF1jjIDX5HTApvipR2v62QzhDNds7qOsCuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgKhh2mTvZEWw1J0jOMwkEnla+jWf8SLxSS9Gi3DnJ6OzJEn9hApTMpRNloZnpeTAuQ5n8vQH1+KcY6zGQNaLCHUGIIzuY+W1pdTAYWgijDVaRn6CdIvTafiMJzqkYssNu/Gs3m9Lmxfhv/W+6AatxuFbBdqpAGnU25g3rt/FFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtLHfusw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtLHfusw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784925448; x=1816461448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SLtY6FjcuF1jjIDX5HTApvipR2v62QzhDNds7qOsCuU=;
  b=XtLHfuswwZc2l8rlMQZAmwvO0kCiTqQkCDTJQ+etpfr9EQqv0BmAANXF
   0U3G8gZ0UlnCXOxqrJ0SIyVeIx3O/Pp6l5MDShTOOtC9lJw6DkmPgNXC0
   gcIgeR1fSkxebmoqU5vdJlisl58/wsVjfZ58gO0XpsceCVtPXC0YMvYOs
   OSY8VztbPF0NLuZeJBymcN+a+9wGRTA3115751/m9SuRLXNsRCNoxxPoZ
   NE703iYs/Y+XSMBjm5wh2qIKBA3TwuNOmIqiv5OYNZ3qFHNHLawwp3j6m
   hLcmQutYp68hzTg/abAS6gU8MYFCTin0MUtWNUhEgtbpzdVZ6wHf9PXms
   Q==;
X-CSE-ConnectionGUID: ijXaCA0ORxGqN6YTIbkH7Q==
X-CSE-MsgGUID: Xb0IeOVWQBq1oSVPZJZnNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="103008240"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="103008240"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:37:28 -0700
X-CSE-ConnectionGUID: G2S8XWPJTZu+TWjbChicsQ==
X-CSE-MsgGUID: 3eFSbWZOSd2D0yfzjP6Yug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="258872394"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.232])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:37:27 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 3/3] cxl/test: Assign one mock memdev a full-width serial number
Date: Fri, 24 Jul 2026 13:37:19 -0700
Message-ID: <3e569a748fce4424b8622032fbffc298d92153b9.1784924949.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784924949.git.alison.schofield@intel.com>
References: <cover.1784924949.git.alison.schofield@intel.com>
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

pdev->id 7 is unused by the auto-region topology so the larger serial
does not affect existing tests.

This enables adding a new test case to cxl-security.sh that verify
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

