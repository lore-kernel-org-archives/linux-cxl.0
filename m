Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794011712;
	b=kTBM7xk2mo3QJITBO72rLMGSJcthSfPJ68jJCt3jecdQdsuxgklP4iragA6gNRr6CXrY
	 kiDV4hql6nnxAXlXsrMpOgDYl4P+kwgK9hI7p0WfuyDl13X2e+frfVN03vtsfiup9f5hI
	 uNZQiXJDCbJqlREOB17GjiqUH6Vr8NPhhtr4wuDsxRcInXl/Bn+M7X2GWZybvsBUJoD30
	 LBlmPx07/tNDGdZJeG1mai7PkcM7s0yXySIsmbVzPNfFk2LjRKcg50SUawI21SUx/UFI8
	 EAOfbNOoZPuHlshkqe7TVpCf4ioOAji0xQrO0AXEPUg5+0as9R8u0v+XnA0lsPxyAXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011712;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XXDVZ8hYeQ4fzFyAyzYPFa43ljwRZSyDH7BD9Dv6hwk=;
	b=dMiX75KBWCEjkWFQi6MLxJffACFA5OoGPUW6wQZCfstEAOzXbM//WPPME3W0DUqkuG0K
	 yhI6ZlduM/Z86rZ2I6DMebDKUqABbW1M4iiodfBOGPL3sJ3UgMhKINrfyFYW2RDwg/SiM
	 jYuaVRs1sE9mxnILDUfDLdWpd+uhIsf0VhS7uwmbEHCIFskPODIrZ/dU1jDUUOaBRzJrZ
	 tTRhe4Loe8olvA3zHsXR+m4YSLlUYwSeUrO6cuV8AV8437I/R3DvSnX6BltkKFg4Uv9wE
	 u49t3DYogSsxUd3YOmOQHQq/f6kZn/6zZ75kq3+VzjOLspwHKBrWcQI2FwGqBpW/+1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="F/hshgHa";
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A7606A32C
	for <linux-cxl@vger.kernel.org>; Sat,  7 Nov 2026 00:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 737A7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F/hshgHa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794011710; x=1825547710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UPYRCaZot1eV7JfgL6c0dVA9KbaGXcQP6Pw+7Wymuzs=;
  b=F/hshgHaedUf7P/+fB7huGhOyWn1Ksg1BrCAYbKEplDB6sInNcO3LSHd
   FFZ+CUtGXbyO2XEuLUm3Z/sgInfERUzUH6jcK2KZGVTPeorkRcco9HWlr
   EULlKnzsrPhVq/cV741o29i8r1ZaUpN06PRyGmqjdvaXeRWuNmRh+JCoD
   04WPJllzj6vXi9Lby4l094ViTpYn0VaLN+yUfTQ4mjdy3EsV5fqcpVKyG
   T6j1cg71TyjH7ZSHH9c+8s6kMHb6sDR0Cl/EwKqFyc1Y4tfTnGcQ+95ZK
   0pZUN4wDuX5/zvQ4m08m84qO54cSsCxLMAO9Zs4oQoD1D3DUQPrwhFOKK
   w==;
X-CSE-ConnectionGUID: wfvAXTkmS5Seh9gMuBt10w==
X-CSE-MsgGUID: RD4g0fxDQ/yJdZMqEfLJUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2710324"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2710324"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 16:35:10 -0800
X-CSE-ConnectionGUID: hTQTYMlCRjOdIzK7g4GV0Q==
X-CSE-MsgGUID: h09o++c6TNKsxQl4aE2H8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9176237"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 16:35:10 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 3/3] cxl/test: Program a don't-care granularity into the passthrough host bridge
Date: Fri,  6 Nov 2026 16:35:02 -0800
Message-ID: <8724399275232657490080a526e202e797ef7962.1794010889.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1794010889.git.alison.schofield@intel.com>
References: <cover.1794010889.git.alison.schofield@intel.com>
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

The auto region mock gives the passthrough host bridge decoder the same
4K granularity as the switch decoder below it. Hardware ignores
granularity at 1-way, so matching values leave propagation of a firmware
don't-care value untested.

Set the host bridge decoder's granularity to 256 bytes. Auto region
assembly then fails unless target setup carries the effective interleave
state through the passthrough decoder.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 76154c4bc15d..cd4a99fface6 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1374,13 +1374,17 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 		iter->commit_end = 0;
 		/*
 		 * Switch targets 2 endpoints, while host bridge targets
-		 * one root port
+		 * one root port. Like some platform firmware, program the
+		 * passthrough host bridge with a granularity that differs
+		 * from the region's, since hardware ignores it at 1-way.
 		 */
-		if (i == 0)
+		if (i == 0) {
 			cxld->interleave_ways = 2;
-		else
+			cxld->interleave_granularity = 4096;
+		} else {
 			cxld->interleave_ways = 1;
-		cxld->interleave_granularity = 4096;
+			cxld->interleave_granularity = 256;
+		}
 		cxld->hpa_range = (struct range) {
 			.start = base,
 			.end = base + mock_auto_region_size - 1,
-- 
2.37.3

