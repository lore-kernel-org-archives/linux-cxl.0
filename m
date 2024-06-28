Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AFA15253B;
	Fri, 28 Jun 2024 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719597347; cv=none; b=BNDGGt3rEcT/eStqsauqm1mF7CNa7DBL800pOD1CVOw/N/d/F+Sd8smH0Dcn1MiTSmqkjWsq844rg6iFjs+Myk+Z6w2usFglp0EcuvweeSBMwiz7YC/3EYUbqlykKqTO7ohiVY7grvlyW55HHpgoFnbm1whsormGPmDP4ILuw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719597347; c=relaxed/simple;
	bh=RbeZW0Wlzc0mLCx/jtbjh/TrjzaKWO+6tkhNz/h4y+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gwhIxugs5u9FpiyNWjk4DYrPoJ2rYG1RrOzMhayi9d3lu5lL0hTU0Rf8w4iIXv6qSQxFfDjzj0vLn3kjrIN0H3TsB9zg5ws/eouUFrevj/q3KWXsH0r9czJ2frzz3OpH0z9Ltax43LxUBNOpmDUNyQ8gdlubQG7hI9FS+hzS+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NuPWh2x2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuPWh2x2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719597345; x=1751133345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RbeZW0Wlzc0mLCx/jtbjh/TrjzaKWO+6tkhNz/h4y+8=;
  b=NuPWh2x2SYPj0f11ipmINegpjQtVxo8V+BDCCkbJ1dhTloe7VDqtnuRK
   h0O7/yIYH1D4Ri5FQ4ujXPhNIn5o6n6bRE/2py27pSBqKphjK53IkwjP0
   M8xICpgEhs6w19Sv7jpICPUVcmVfRjc1RkFMwr+1uDkj8GlumjoP6gLiR
   F0HZX4+aVpgQcI1aI+756G03vyJRVYNglcPuGYl/eNO9LoLOjBAyMtRjF
   l5VjuZdqYAFEcmy/DcHGte2dJYb3FKvPpoXgkwzqYOwqtbAmhmspuqboV
   ejNh3iUD5JN+aE6y48mmleNKGJSsSxHbcNg5PS9ZfGaR42jj1Xc9nBMiz
   g==;
X-CSE-ConnectionGUID: I9Pq51a7S5ODjdonZlbTGQ==
X-CSE-MsgGUID: I0x0uvSxTcOWNI8OsRMVog==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16627256"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16627256"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 10:55:45 -0700
X-CSE-ConnectionGUID: 3rCB9qDUSVq2D8cyHLbvxQ==
X-CSE-MsgGUID: y0B9bD+/RC2agQ9iyCQe/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="45473920"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.5])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 10:55:41 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v2] cxl/acpi: Warn on mixed CXL VH and RCH/RCD Hierarchy
Date: Fri, 28 Jun 2024 19:48:07 +0200
Message-ID: <20240628175535.272472-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each Host Bridge instance has a corresponding CXL Host Bridge Structure
(CHBS) ACPI table that identifies its capabilities. CHBS tables can be
two types (CXL 3.1 Table 9-21): The PCIe Root Complex Register Block
(RCRB) and CXL Host Bridge Component Registers (CHBCR).

If a Host Bridge is attached to a device that is operating in Restricted
CXL Device Mode (RCD), BIOS publishes an RCRB with the base address of
registers that describe its capabilities (CXL 3.1 sec. 9.11).

Instead, the new (CXL 2.0+) Component registers can only be accessed
by means of a base address published with a CHBCR (CXL 3.1 sec. 9.12).

If an eRCD (a device that forces the host-bridge into CXL 1.1 Restricted
CXL Host mode) is attached to a CXL 2.0+ Host-Bridge, the current CXL
specification does not define a mechanism for finding CXL-2.0-only
root-port component registers like HDM decoders and Extended Security
capability.

An algorithm to locate a CHBCR associated with an RCRB, would be too
invasive to land without some concrete motivation.

Therefore, just print a message to inform of unsupported config.

Count how many different CHBS "Version" types are detected by
cxl_get_chbs_iter(). Then make cxl_get_chbs() print a warning if that sum
is greater than 1.

Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---

--- Changes for v2 ---

	- Rewrite the Subject line (Alison)
	- Address a bug found by Alison while testing (thanks!)
	- Add reference to CXL 3.1 Spec. (Alison)
	- Extend the commit messages by borrowing comments to v1 (Dan)
	- Rename field "count" to "nr_versions" (Alison)
	- Add brackets to oneline 'if' statement in precence of comments
	  (Dan)

--- Link to v1 ---

https://lore.kernel.org/linux-cxl/20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com/

 drivers/cxl/acpi.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 571069863c62..f9035dbabb1c 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -482,6 +482,8 @@ struct cxl_chbs_context {
 	unsigned long long uid;
 	resource_size_t base;
 	u32 cxl_version;
+	int nr_versions;
+	u32 saved_version;
 };
 
 static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
@@ -490,22 +492,31 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 	struct cxl_chbs_context *ctx = arg;
 	struct acpi_cedt_chbs *chbs;
 
-	if (ctx->base != CXL_RESOURCE_NONE)
-		return 0;
-
 	chbs = (struct acpi_cedt_chbs *) header;
 
-	if (ctx->uid != chbs->uid)
+	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
+	    chbs->length != CXL_RCRB_SIZE)
 		return 0;
 
-	ctx->cxl_version = chbs->cxl_version;
 	if (!chbs->base)
 		return 0;
 
-	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
-	    chbs->length != CXL_RCRB_SIZE)
+	if (ctx->saved_version != chbs->cxl_version) {
+		/*
+		 * cxl_version cannot be overwritten before the next two
+		 * checks, then use saved_version
+		 */
+		ctx->saved_version = chbs->cxl_version;
+		ctx->nr_versions++;
+	}
+
+	if (ctx->base != CXL_RESOURCE_NONE)
+		return 0;
+
+	if (ctx->uid != chbs->uid)
 		return 0;
 
+	ctx->cxl_version = chbs->cxl_version;
 	ctx->base = chbs->base;
 
 	return 0;
@@ -529,10 +540,19 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
 		.uid = uid,
 		.base = CXL_RESOURCE_NONE,
 		.cxl_version = UINT_MAX,
+		.saved_version = UINT_MAX,
 	};
 
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
 
+	if (ctx->nr_versions > 1) {
+		/*
+		 * Disclaim eRCD support given some component register may
+		 * only be found via CHBCR
+		 */
+		dev_info(dev, "Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.");
+	}
+
 	return 0;
 }
 
-- 
2.45.2

