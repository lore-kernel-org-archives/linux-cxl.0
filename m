Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96E35DA6A
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975465; cv=none; b=kJ7B5Y5DkSAn5rIZ2eqFqOUg6wjGct9vSMzWO9X2X0boyWA0SvBj740NmWnawTVvDEUAeew4ADBrBb9DKOqG54ig9ALgnpU9ywZE7f0iYg3QqxPadVrQaPQTZtieaUbluMfMywzUE7T9TXMR+/H6khXMiDzkd7loTnssgxqozAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975465; c=relaxed/simple;
	bh=q2WlQ2EnicigKdRapjtxoGExGP58evoTjuaDSmca5N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XocVKDrTZDfqXNFwAj9ac4l2bgKS5zaF9YCWDOjFYRk8sziSECFoqp9sAGTgd31wbR9WKpVVUY8EYWAp+NwULGajQGsVYnkx95MdH+R5idFLXMuxR0+nkRXEzxWPi9eb9ykB4CdhBCbDDExSoegw1SPUNSvBIsDq8hGOsJwqAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRSxARHh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRSxARHh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783975463; x=1815511463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q2WlQ2EnicigKdRapjtxoGExGP58evoTjuaDSmca5N0=;
  b=kRSxARHhOnqbHZE/UZMiCvq8MBtT+g0J9ScJzE3rHxDNx8FHEJ4UQdhL
   NTn/eMo5nrhVQfO2kfSL3EVzGaK5hQK+S0aExBRbjr8MS9DY78PZgA40y
   Eqbkl+U/MMWAi9vWwgM8gBXxoIdkGO2r8pjQsLB+hegjh6ZQqWz2UAxjH
   dFoERQPacfUmf5ikL1HMtUHje2iymLBV6URjXB3q/VePRNAtcMb8DnuBP
   QuqL8FsClA1fgPuxPFlIY4JsVUmLlAo3Irey3EACpUz98R4iScDAP7XGs
   piQHftKCoZW9weIS1hRaayN0hixqlSxLPOLjIlyMvvCQR4AdxcJd3/wJ7
   g==;
X-CSE-ConnectionGUID: JSQbVRgHQTGUIvENLhxL9g==
X-CSE-MsgGUID: lsThgLnSQxWO9u+Yu438cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95742156"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95742156"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 13:44:23 -0700
X-CSE-ConnectionGUID: 4RLHU/guTaW6LMmWpg0DQg==
X-CSE-MsgGUID: Vy9pqnhnR8iJIWpioUPJOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="256285861"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.12])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 13:44:22 -0700
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
Subject: [PATCH 1/3] cxl/hdm: Reject switch decoder interleave ways that overflow targets
Date: Mon, 13 Jul 2026 13:44:11 -0700
Message-ID: <dad02aebdc2d82537d779ddff459c8c4b5a614da.1783974681.git.alison.schofield@intel.com>
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

Switch decoder enumeration validates that the interleave ways encoding
is legal, but not that the resulting number of ways fits the available
targets.

A decoder reporting more interleave ways than available targets can
overflow the target arrays during enumeration and target population.

Reject decoders during enumeration if their interleave ways exceed
the hardware target list or the reported target count.

Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c | 18 ++++++++++++++++++
 drivers/cxl/cxl.h      |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..d86a607d2a2c 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1084,6 +1084,24 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+
+		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {
+			dev_err(&port->dev,
+				"decoder%d.%d: interleave ways: %d exceeds target list capacity: %d\n",
+				port->id, cxld->id, cxld->interleave_ways,
+				CXL_HDM_DECODER0_TL_TARGETS);
+			return -ENXIO;
+		}
+		if (cxld->interleave_ways > cxlsd->nr_targets) {
+			dev_err(&port->dev,
+				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
+				port->id, cxld->id, cxld->interleave_ways,
+				cxlsd->nr_targets);
+			return -ENXIO;
+		}
+
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
 		target_list.value = (hi << 32) + lo;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c0e5308e4d1b..6dda96c42849 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -67,6 +67,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
+/* Target list is two 32-bit registers holding one target id per byte */
+#define CXL_HDM_DECODER0_TL_TARGETS 8
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
 #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
 
-- 
2.37.3

