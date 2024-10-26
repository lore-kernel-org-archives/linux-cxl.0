Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA218460;
	Sat, 26 Oct 2024 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903622; cv=none; b=Eq5/1pzYNzBYo93p7gEQU7SKByQ2Q7jnNJfU7I/7dPYE/tSp8nCA75cXgGC2KaKNxgVAN+EHqpkjp5YEBrN0Zi04O7mGqCVmHsKCuKxjiAWbAGOyBWW4L/+Mkugf3O2KBPgtgLbsWjWsMVfEV1loKAg+OU5fCc57ksljNiALVys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903622; c=relaxed/simple;
	bh=PlYWMyblOiHnSgikBnvQ88kKKoxtE5z9I5CsWUz8/T4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3niL0hXCBCBXIQOeNBF1uwNZpY/saRh+qJFUNC64MQrDDOHbRQRoMRzjCJU13cKi9hYRK2FDzyG7p2nBUzIgpIKW0R04GYh0m7Oy/WB23F7g5H6/HTx4qNMtusJ/+bE0BpRUEKOHCRAzhBB5dyA875oFMrLiJ0Jaq5YQc7NgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1T+yCl/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1T+yCl/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729903621; x=1761439621;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PlYWMyblOiHnSgikBnvQ88kKKoxtE5z9I5CsWUz8/T4=;
  b=T1T+yCl/xBZoovKIK4my9W/5eQ2KvSOIRp340IvPPotGhsZHjvdvCVG4
   El8aS03e1t7o37jDrA97zNbM/RKQ9E1HgkNrWKgYJiBKTjXxtyknec3io
   QPiQyGp2aI9UG0tpEWnbiQ03oFkMNRpA9J6LKDgDwnbqhE0LnxMpPmdVz
   P7zUmuMuxIoO3iAXnzSQVxuiB48mlw+nAQ2A8lPYA8mdIkW36oUuCGWjN
   AlT1C2Q48gthJXysyluJ/UlAHtE0bZHdqicnZMTgsupnJCqiA/yDQkWGZ
   i3VYbwjCWQ/PvK0JlMoCUDqUP6UuCj70/apU7s55Dp3NoxNfYuNXLpVup
   g==;
X-CSE-ConnectionGUID: qW2pbiv+S7CYxGpUbUFVJQ==
X-CSE-MsgGUID: en6anB/CQDm0m42eSkSUpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40974439"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40974439"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:47:00 -0700
X-CSE-ConnectionGUID: xcKdkoOFRIye+sBeFjUGYA==
X-CSE-MsgGUID: OcSpOJWyQEmU40v8m+QD9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85851634"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO localhost) ([10.125.111.138])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:46:58 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 25 Oct 2024 19:46:53 -0500
Subject: [PATCH v2 1/4] test printf: Add very basic struct resource tests
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-cxl-pra-v2-1-123a825daba2@intel.com>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
In-Reply-To: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729903614; l=2082;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=PlYWMyblOiHnSgikBnvQ88kKKoxtE5z9I5CsWUz8/T4=;
 b=pw+sEZIjeqU+2KmsBFBUSsBdzAFWdts1IDd2AJ6Qf8EOxKWB4ELnYEn6Kpywmb9828ErTYOpt
 Uu4TB4ptCZ8D3pdw+160uW0hHvlmJBwch7yWgN/yEZxkgPHZypwEYfM
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
Tested-by: Petr Mladek <pmladek@suse.com>
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

