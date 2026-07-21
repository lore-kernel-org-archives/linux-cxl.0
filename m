Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73D3FF882
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599190; cv=none; b=a+ftXzYtcnLFJy+fQwy1ouRQWxa6aDBt2HpLK6zjh750d5fr3YIp0ujUl02emwQbSuLZ2LaYku4wWHhONcneQ23wN2DKt4tKtg74TqUvNUKRzZpn1+okvHiZfwitllYXbdZYhw6xUnTlAaZlNL+ZXel6MacWbQTkKE57LYAi+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599190; c=relaxed/simple;
	bh=wa25C3yX4LThgnFEj3OdhwNc9HwgVsf3vV11wO71fp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eai3kYASJ1Gg7NH6r5zD6jq3qx5hKG17pXif6rkMoidfQognDjzpvFw8+FryLs02LZpqdfUzIzqAoX7Gceeq14w8hMmUUHjzYL3B7pqO1+31Bs8nzG9XPLVso3nIK/Rc9+gkeV3DpYMR7KO6NrGaoF4TP/GhJiIfSIGfdNjUv+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D85nGlEh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D85nGlEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784599189; x=1816135189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wa25C3yX4LThgnFEj3OdhwNc9HwgVsf3vV11wO71fp0=;
  b=D85nGlEhiI6AlR7ItR9I1y5ziXELUzMYC+iQhQ9zSMQA3GgWxV2skz0y
   r5ttVeCOddZWNdWVLxQiFpwJ6RUCOl90lLshC5GnXZhLqxYaHGcXQfHm6
   NmIFVusJUQb//bbjqqJdgNbhKaACTpw/SdBgSw6LwfzDpB6TXAkSCJgjB
   kO6LRZ8ySCoTEmjWNLGF8b7ip5Kwazgs8cWfRrezHkNC8wyEpFdFA1Xls
   OsiMtLpV1gLhJrXCPzoxH1r6RDAtMmTrhCHW48os3EchNmMurb0hJj1Ne
   e0qwi/Pcgnn+NKyMhjj/K9nxyo1zJkN07sJTGL0GLQATcN18X9zTdz/xZ
   A==;
X-CSE-ConnectionGUID: PJJhBKsOSLSa+Z5EFhLEYQ==
X-CSE-MsgGUID: wumj5d9ORMazeWf1bhMihQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85209223"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85209223"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:59:49 -0700
X-CSE-ConnectionGUID: tbjRMXwqTSCbMXTGVxwTDg==
X-CSE-MsgGUID: QwTbEjRASNmdQG+U0iR+HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="255837068"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.174])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:59:48 -0700
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
Subject: [PATCH v4 2/4] cxl/hdm: Only interpret interleave settings on committed decoders
Date: Mon, 20 Jul 2026 18:59:38 -0700
Message-ID: <48e04e2688a636d90b6e49f3e0c2dca78f773c4f.1784595445.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784595445.git.alison.schofield@intel.com>
References: <cover.1784595445.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Decoder enumeration reads the interleave ways and granularity fields
from the CTRL register unconditionally, then decodes and validates
them for every decoder. On an uncommitted decoder these fields are
stale. They hold whatever was last latched and are reprogrammed when
the decoder is committed. Interpreting them serves no purpose, and
rejecting enumeration on a reserved encoding in those stale bits can
fail an otherwise usable decoder.

Decode and validate interleave ways and granularity only when the
decoder is committed. On an uncommitted decoder the stale register
values are not interpreted. The interleave fields are set when the
decoder is programmed at commit time.


Reported-by: Li Ming <ming.li@zohomail.com>
Closes: https://lore.kernel.org/all/171d58db-3555-4a79-a9f9-8a3c2e14d91d@zohomail.com/
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d81df45d8005..1f995191baf5 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1064,21 +1064,24 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
 	}
-	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			  &cxld->interleave_ways);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				 &cxld->interleave_granularity);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
+	/* Interleave settings are only valid on a committed decoder */
+	if (committed) {
+		rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+				 &cxld->interleave_ways);
+		if (rc) {
+			dev_warn(&port->dev,
+				 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
+				 port->id, cxld->id, ctrl);
+			return rc;
+		}
+		rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
+					&cxld->interleave_granularity);
+		if (rc) {
+			dev_warn(&port->dev,
+				 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
+				 port->id, cxld->id, ctrl);
+			return rc;
+		}
 	}
 
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
-- 
2.37.3

