Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE604C74;
	Wed, 19 Jun 2024 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802010; cv=none; b=S30g4A1IC2wGgUX6xi3CW5K/OtgZnesPK76MYrBnrQXsXAmUkU1C8yKQtI7Ng4wYNaOVb8sGDBCT8AwEW0eXr3w1ZRP5m1dXnSdKqFIPF79UFVkKnPzegHsumYFxumK+P3VL999X3rkwfPLMYrVWDuJn6nZ5HHlx7yt8X+77rco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802010; c=relaxed/simple;
	bh=dUF7xar2mLM2PTNG/U4sGslKcRPjmrXUFHC6uCB2Fys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9HMyv+SpQIEbNqsGM52A8/fXThPihyq/CNKaEs52//hi122rwTcIYjwTonDmYtZbSZRr9smUQ7S2r8aDxrYhqBT9hlwfTyxU+lcaneuRt1dCipQ5v6CcQKXTL/uH7bmBr2fmb3i88hIbx87c45ZvY0NkFSc6i/W0q+EkRI3OpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjY4ibRm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjY4ibRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718802009; x=1750338009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dUF7xar2mLM2PTNG/U4sGslKcRPjmrXUFHC6uCB2Fys=;
  b=DjY4ibRmXNNDsSuQNzyzDfDJrYMbX3ORY6kxkMQ+jwkYUlPZcabWV5Tq
   UZoa0Wn868yTeHhoFDNlpFP1hXSrDfCulyuWBJOfpJq/7smREFIXosiQ/
   6Xwgip31/NUoxF3HrJBhpd6seud4gaEZXt0mKN6FnuVloTn6eeMaLSBux
   3kwXtZdQKyy08Bv7WgVnjzd2s4yAYv2zR+mLz71+aM5aKrshrK16fQMVP
   9h5jMCyvKntL/3dFGtrdPdL5SNUwStz585d15/YWuBrb7pGQk/UqcLW3u
   ZXzC+j3HvplZiVkpHuUZx5s1hIXjn15nMNVpimBXYxGEYIqgky9VNjg8S
   Q==;
X-CSE-ConnectionGUID: 2LWK8G5HTl+J+q7MmOjjmg==
X-CSE-MsgGUID: USwPlYeHTvGa4L3SEeDI0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="12147504"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="12147504"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 06:00:08 -0700
X-CSE-ConnectionGUID: v96991b5Q2qKojuDqI3v0A==
X-CSE-MsgGUID: 0RNK1CVzRqaPBCv2wZHM1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="79396303"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.246.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 06:00:04 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH] cxl/acpi: Warn on unsupported platform config detection
Date: Wed, 19 Jun 2024 14:59:41 +0200
Message-ID: <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>
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
two types: RCRB and CHBCR.

If a Host Bridge is attached to a device that is operating in Restricted
CXL Device Mode (RCD), BIOS publishes an RCRB with the base address of
registers that describe its capabilities.

However, the new (CXL 2.0+) Component registers (e.g., Extended Security
Capability), can only be accessed by means of a base address published
with a CHBCR.

An algorithm to locate a CHBCR associated with an RCRB would be too
invasive to land without some concrete motivation.

Therefore, just print a message to inform of unsupported config.

Count how many different CHBS "Version" types are detected by
cxl_get_chbs_iter(). Then make cxl_get_chbs() print a warning if that sum
is greater than 1.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/acpi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 571069863c62..9e226a65a5ea 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -482,6 +482,7 @@ struct cxl_chbs_context {
 	unsigned long long uid;
 	resource_size_t base;
 	u32 cxl_version;
+	int count;
 };
 
 static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
@@ -490,10 +491,17 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 	struct cxl_chbs_context *ctx = arg;
 	struct acpi_cedt_chbs *chbs;
 
-	if (ctx->base != CXL_RESOURCE_NONE)
+	chbs = (struct acpi_cedt_chbs *) header;
+
+	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
+	    chbs->length != CXL_RCRB_SIZE)
 		return 0;
 
-	chbs = (struct acpi_cedt_chbs *) header;
+	if (ctx->cxl_version != chbs->cxl_version)
+		ctx->count++;
+
+	if (ctx->base != CXL_RESOURCE_NONE)
+		return 0;
 
 	if (ctx->uid != chbs->uid)
 		return 0;
@@ -502,10 +510,6 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 	if (!chbs->base)
 		return 0;
 
-	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
-	    chbs->length != CXL_RCRB_SIZE)
-		return 0;
-
 	ctx->base = chbs->base;
 
 	return 0;
@@ -533,6 +537,10 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
 
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
 
+	if (ctx->count > 1)
+		/* Disclaim eRCD support given some component register may only be found via CHBCR */
+		dev_info(dev, "Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.");
+
 	return 0;
 }
 
-- 
2.45.2

