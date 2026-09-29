Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3BA2F7EE4
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643393; cv=none; b=py7RFFYtkWTKsUDlAKhRHYNKn4MKXD97s/UvETLk9m47ma6HVRYsqzkIS5dYGZ6SYQ5bVaMMX0ajnplymztdORD4kM52Fjst9qw4KZOnNC0bLDUGfPZJx2MLAXgIEeMgzqF3ZDpj1vh8ezezFk5DIILxMnrpYSde3bEuE2nSRMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643393; c=relaxed/simple;
	bh=PHMWUwn4y1ODWrp85yJYylJU11FWT2RTr2TE0SR7g1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkuFGEr/rPmd8vPJbP0p8nidnvLZodWsiG2CC7MuYF4mMB3vkqyow2U1izN+EBTAtZI8bPr6miyYTP8SKwkckJ5NTQNjfVYLbsROaFVR4vvnsdNUPHzCqllTKb9wSQzSiemJac8XjblVf+4M0Je2aCM+D/925r9gm46RmNTHUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzXAQvjh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzXAQvjh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790643392; x=1822179392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PHMWUwn4y1ODWrp85yJYylJU11FWT2RTr2TE0SR7g1o=;
  b=LzXAQvjhhWidc5Di3vWLRNHN3Jfo5rTl647uX9XTtzExiMYgQQHAgkuj
   o40EOvKboj5E+Kaq/4D/4vZ8hhyQGUktzBkUTIPLPDH2sQMcSS54oVM8V
   nbeLGys+xX04AJ09DuD76YURVOjeQfavV8REU1YKxUYTY9PyC4Z7h+StA
   Rg67siS5LSMnjhEzP0tN1BMZ1rxbGEgyqToTuPg5NO42Z8zMphbyQ8AbZ
   abo2519hCSLqUBxVqSu3KCJDM9c152NkzaCPTcvzVg33obxNJ04D6uXTG
   3h9P/whsS2yR76fml/gqm7phbUY92jig6+vjTEVwCLontBZYfKS1bIxnC
   g==;
X-CSE-ConnectionGUID: hNoTfz0ERwGmeJysbFRWJQ==
X-CSE-MsgGUID: CThRtwHERA+iIc3LZdIR0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101923928"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101923928"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 17:56:29 -0700
X-CSE-ConnectionGUID: hcWKT2GRSkCsByIYx1cFjQ==
X-CSE-MsgGUID: sB/HwJIrS/SebgfwRS5qnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273012210"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.149])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 17:56:29 -0700
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
Subject: [PATCH 1/3] tools/testing/cxl: Preserve DPA skip across mock decoder reset
Date: Mon, 28 Sep 2026 17:56:16 -0700
Message-ID: <51807396d62a65dc457706b454102cedb6446bbb.1790641236.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1790641236.git.alison.schofield@intel.com>
References: <cover.1790641236.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mock decoder reset clears the DPA skip before releasing the decoder's
resources. This leaks skipped capacity and can cause a later DPA
allocation to fail with ENOSPC.

Preserve the skip until the DPA resource is released.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 62bd92b3be45..aa140307e0c3 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -913,15 +913,13 @@ static void __cxld_registry_save(struct cxl_test_decoder *td,
 
 		cxld_copy(&td->cxled.cxld, cxld);
 		td->cxled.state = cxled->state;
-		td->cxled.skip = cxled->skip;
 
-		if (!(cxld->flags & CXL_DECODER_F_ENABLE)) {
-			td->dpa_range.start = 0;
-			td->dpa_range.end = -1;
-		} else if (cxled->dpa_res) {
+		if ((cxld->flags & CXL_DECODER_F_ENABLE) && cxled->dpa_res) {
+			td->cxled.skip = cxled->skip;
 			td->dpa_range.start = cxled->dpa_res->start;
 			td->dpa_range.end = cxled->dpa_res->end;
 		} else {
+			td->cxled.skip = 0;
 			td->dpa_range.start = 0;
 			td->dpa_range.end = -1;
 		}
@@ -1001,7 +999,6 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 			to_cxl_endpoint_decoder(&cxld->dev);
 
 		cxled->state = CXL_DECODER_STATE_MANUAL;
-		cxled->skip = 0;
 	}
 	if (decoder_reset_preserve_registry)
 		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
-- 
2.37.3

