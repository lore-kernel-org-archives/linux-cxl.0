Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851074;
	b=BkmuYhM2kXtb7AkkX7fQ1ib6vd0hEqEKGxcRCQZxNgxJTFg4vj7Z8RYv+KntYGgCrvb6
	 X0pU1+PbYnUv+26o57luNxABOj54R6folv90Gbu8QdC5xt9X+Wbetkf5BwbZkT92Dn7AZ
	 WkrfC+fu08CNMADfbuuNVE2rJ+ti0ZoleujEWrzJXvt/P4lGOiWS00SZmAZwX/jFZgUze
	 JiNkYEkkiZyPxCiSoQh9jLMVwzVMSINc6j39x3LIIiN54QWJLNxuqU8LaM+4HBzN7xNU0
	 LJ4RjKhWKB86Yuadc2kArjSlCLHxDRgtVSXvZINHZUYAgODFd3vApjTs/RyRmmHkRsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851074;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4yG1GqHuYe6d8R+I/VuhxNxZKlouoY/FsOeRB9KhRqo=;
	b=tLQ5z4djDMt/kDDEm4N31LZTsA7XOZMifaZqocgLBM8PTJ9l+QNMwlKmKBwjZUbcbhs5
	 SHwefhNQNjADHaZoEktn0JNLGy75Cv1F9Ar2CiV7J7y7vM2BOX2CCUKr1h2Xl0vnYyDKM
	 VOgqb4zRb7a+C27FaOYdz+2R1dbMbNwxIPbIFvB4d/57WO41bzxStDl0A+xa4OgeYq3nW
	 ca9wyRPDkHMEsrzJRfGntO3o3HLQqRT6bEdH4j1RS1bRdoaRk3odnIYxb38L23ZdWczUX
	 nz2DS/8f0+IRTXY7i3Z+h/xZFVLnQmzmfe0qwH5nZv0rU/kZHD0Qmf5zAXaZaaeCe1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bfysAZiV;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47127606A31B
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 03:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47127606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bfysAZiV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793851074; x=1825387074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qqePg58fuQAGiuuntUYHxg+nXdasSxApNooVaj+aRf8=;
  b=bfysAZiV6j+Ek+7MoNuYjWnV95gAeb2oU95qu/ad246pJpWCee5KaAYz
   zb3raSGMtkiN6RKgEJUPIYNVRYEy7DYwrlt1a4IU5WGa5gNpSggQF6qbJ
   ZlFEBlx8VHlIAcsdzaLj2S+31icNqEBaHJArm9vzK7gKOYdpYSg71+F4O
   zyXywZYHpk74OnlKw9NF7ntBGH5nOV00TITUTVvfF+vUEGMFkCs6R7tx0
   QDLX9c7ZOyWsi4cBTgoq8vLcV20iY7aNKXQ4B5B+EG6iyYkjEE+Nvdlg3
   a73lEYFeDtWKtcCzkbD2nlTyJOVG4FTbGiQCJpSIxpdtJf5IfuakwIuyn
   A==;
X-CSE-ConnectionGUID: i5a1kFG1R/6MKEtSx7IIFQ==
X-CSE-MsgGUID: GmWuHEm1TcaKTrV8aavleg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2643972"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2643972"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:57:53 -0800
X-CSE-ConnectionGUID: BarbYX5mSICJFSpC5Ebtjg==
X-CSE-MsgGUID: NxgNyX4xSweNchor5b41Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6741084"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:57:51 -0800
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
Subject: [PATCH v3 1/3] tools/testing/cxl: Preserve DPA skip across mock decoder reset
Date: Wed,  4 Nov 2026 19:57:46 -0800
Message-ID: <ad04f2d561331f7b603ad89efc81e2abb31b7681.1793850480.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793850480.git.alison.schofield@intel.com>
References: <cover.1793850480.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mock decoder reset clears the DPA skip before releasing the decoder's
resources. This leaks skipped capacity and can cause a later DPA
allocation to fail with ENOSPC.

Preserve the skip until the DPA resource is released.

Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 3eb1051b1ee8..6819143640a9 100644
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

