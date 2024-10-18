Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6A205AA3;
	Fri, 18 Oct 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280792; cv=none; b=bnav2LSWdCdnPH/1kghmXZAMVps+C5//RPymwjfZp4INA8EN2KKZGS4i+6GvT35h46jrIgkvlJn04T8QGtpGu6QiAuH+MyPLJd7bhoob7QAYPAUiq8MnPLwqH2aKKf/JkC+bJIxBSkSDz5uAxfkz2cL7tGBUlB7Mh9uMtaZqjxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280792; c=relaxed/simple;
	bh=Orx9NU1JXDRhmnV4iiGDSo5qc8ZgJogIS81BGkbWzEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5aBPpfVR4XpFE8TwM9T4bGZK+WFVo6FINjcJR9WPqv4dIJG+8hEEdL+XtcMZxrmlrIDJERek10JTktKKXXwb4CQpFeMYK/SLd2QSPNiLfLk9Atctqh4GpaxZ20mzA/mYGlAuAtkZRWPpUvQ1I7vS8iho2WiLaxdut43DniKk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZX1+bObo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZX1+bObo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729280791; x=1760816791;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Orx9NU1JXDRhmnV4iiGDSo5qc8ZgJogIS81BGkbWzEU=;
  b=ZX1+bOboNO0LWKtllgI5lAKuKl37VnNU94ToaIjwi/9QjUHzcLfvA8aM
   fp7R3T65XDjQbFCfRoIup4R4VR8pgJNZKfpo/IrBkZ5pEaZ/2Ar8uzRxs
   jQ3kH+6QlhlCJO5jV9Vbh13uPMbZQhbN9qq/wmJ8RgTSYcxWK3W/Q1WJx
   aSgZE6XfdFqxjYOQxoIYndDQXIgl0ZC/Xl3MRppZmk5tAAYwP894P10+m
   JpBopnXnWmEtNKIXU8R0C6CV3N4G+Kclk941z5kzZqDZ4kE/qC4HDjCuU
   PFeiMrDxDMTDX5DxP+y451VUkeKcOPnDg7TLgr+ZVZQcCLY4diQoCXrEJ
   Q==;
X-CSE-ConnectionGUID: bqSh6sukTjKpJ/w9HN0zYQ==
X-CSE-MsgGUID: ZqtAFxi/Sf+9OALj/VrWDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28704446"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="28704446"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:46:30 -0700
X-CSE-ConnectionGUID: E6pFp742Rv6/XqkWE2p6TA==
X-CSE-MsgGUID: kyeRiIOvTNaK5NH2GmRNmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79017568"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.109.148])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:46:29 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 18 Oct 2024 14:46:24 -0500
Subject: [PATCH 1/3] test printf: Add very basic struct resource tests
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-cxl-pra-v1-1-7f49ba58208b@intel.com>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
In-Reply-To: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729280784; l=2039;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Orx9NU1JXDRhmnV4iiGDSo5qc8ZgJogIS81BGkbWzEU=;
 b=7Dm1Njh7l5EKclKzUrGE+hSvD3mG3IDjwOXxfU80SpRaZPPKIfTKWxpelqTQ4h5bxRgFAtklV
 PaMyHYBl7aoBcj/wwtK00011fatWXNgwMRVDYidGJOz/1Nyt0Ry8Eqk
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The printf tests for struct resource were stubbed out.  struct range
printing will leverage the struct resource implementation.

To prevent regression add some basic sanity tests for struct resource.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Link: https://patch.msgid.link/20241007-dcd-type2-upstream-v4-1-c261ee6eeded@intel.com
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 lib/test_printf.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 8448b6d02bd9..5afdf5efc627 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -386,6 +386,50 @@ kernel_ptr(void)
 static void __init
 struct_resource(void)
 {
+	struct resource test_resource = {
+		.start = 0xc0ffee00,
+		.end = 0xc0ffee00,
+		.flags = IORESOURCE_MEM,
+	};
+
+	test("[mem 0xc0ffee00 flags 0x200]",
+	     "%pr", &test_resource);
+
+	test_resource = (struct resource) {
+		.start = 0xc0ffee,
+		.end = 0xba5eba11,
+		.flags = IORESOURCE_MEM,
+	};
+	test("[mem 0x00c0ffee-0xba5eba11 flags 0x200]",
+	     "%pr", &test_resource);
+
+	test_resource = (struct resource) {
+		.start = 0xba5eba11,
+		.end = 0xc0ffee,
+		.flags = IORESOURCE_MEM,
+	};
+	test("[mem 0xba5eba11-0x00c0ffee flags 0x200]",
+	     "%pr", &test_resource);
+
+	test_resource = (struct resource) {
+		.start = 0xba5eba11,
+		.end = 0xba5eca11,
+		.flags = IORESOURCE_MEM,
+	};
+
+	test("[mem 0xba5eba11-0xba5eca11 flags 0x200]",
+	     "%pr", &test_resource);
+
+	test_resource = (struct resource) {
+		.start = 0xba11,
+		.end = 0xca10,
+		.flags = IORESOURCE_IO |
+			 IORESOURCE_DISABLED |
+			 IORESOURCE_UNSET,
+	};
+
+	test("[io  size 0x1000 disabled]",
+	     "%pR", &test_resource);
 }
 
 static void __init

-- 
2.47.0

