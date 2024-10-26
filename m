Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512512E7F;
	Sat, 26 Oct 2024 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903625; cv=none; b=ikyhjHOxcmegKp1b+0pzLHOasXQYUuPQ7hf29hWTHNawIDb3eyM3DtpRaQmheHdvryoT29GSMMkvn0hr8kg1IJ59HHny2ChqOezM6JaSkkqNrPVdZXNQZPgt6fKMSojU3fNPPoA1Y+sOjb3Yq9rBxlsbLMKFTPrjjif+9viigjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903625; c=relaxed/simple;
	bh=2Vnmkz1SVO7/e2yim2K6ewALI0lceemicbolVGaUX/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V9WnySEeS/NeTmPkS36qnOJLtf5C4yeZ1V9C7N9Hu8QWyHgsrnswohv66QhCFzIKqlklzt0DFfMh1OtHfbKTB1driBoeW4ufVP5EVo1oy2LirGiTNMDJ+dl9at86KsSIH1WMmWQdg1f+QRNP6TyeJabk6UHi2ag0Yb+spKEPFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qr2uKx8g; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qr2uKx8g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729903624; x=1761439624;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2Vnmkz1SVO7/e2yim2K6ewALI0lceemicbolVGaUX/8=;
  b=Qr2uKx8ghGRRXVZGEOpYqzAiIJyArYuKAvh6mHDNn93WiVFkvBg7M71L
   zhLOs6WhEay82c/KWJljyHHm2vQe/t9y495s0tKcEi+VokGLNjsnE0AhH
   UFUAMTAsZ/afCXyRduIzJGQVNhpJj+0hfnMzF8+slvCJVGUV1RwDFVS4e
   gNxZyix4JEW+uipBmGynCE8AN4j7Ge/VVPXctbArbq2pcDXIv6tCvjUHI
   Kck2StUIy6HRUsSeItN2z3jNg0ETpercbjoJ1onJU/JppbaH4OTn7ZRek
   U1+SJ28TDxtHvFrPSrvDlCW1Gy/s9q5rf/dM5yI40MIwBckbnOtuwkNsO
   Q==;
X-CSE-ConnectionGUID: f9UevKL1QU2nhdwdreRewQ==
X-CSE-MsgGUID: lrYfoBLoRN6hA0LN82MizQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40974450"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40974450"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:47:03 -0700
X-CSE-ConnectionGUID: xl/wdLdIRXyUTyqjfrQ0DA==
X-CSE-MsgGUID: ISoRcsRATpq4RTb5cusLxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85851646"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO localhost) ([10.125.111.138])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:47:00 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 25 Oct 2024 19:46:54 -0500
Subject: [PATCH v2 2/4] Documentation/printf: struct resource add start ==
 end special case
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-cxl-pra-v2-2-123a825daba2@intel.com>
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
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729903614; l=1292;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=2Vnmkz1SVO7/e2yim2K6ewALI0lceemicbolVGaUX/8=;
 b=kvjyerXc+lKQyyaaeUCwbbNoLJuzUXi/BXXCKxLDSJzoecD/Ry6z+EZzxbysUBqRCaALtcW0P
 ETNfQBtuy44Bq8UX0Lk/N4Szdu6e9MvU81rxbSOICM+xXLVSYUh/IqV
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The code when printing a struct resource will check for start == end and
only print the start value.

Document this special case.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/core-api/printk-formats.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 14e093da3ccd..552f51046cf3 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -209,12 +209,17 @@ Struct Resources
 ::
 
 	%pr	[mem 0x60000000-0x6fffffff flags 0x2200] or
+		[mem 0x60000000 flags 0x2200] or
 		[mem 0x0000000060000000-0x000000006fffffff flags 0x2200]
+		[mem 0x0000000060000000 flags 0x2200]
 	%pR	[mem 0x60000000-0x6fffffff pref] or
+		[mem 0x60000000 pref] or
 		[mem 0x0000000060000000-0x000000006fffffff pref]
+		[mem 0x0000000060000000 pref]
 
 For printing struct resources. The ``R`` and ``r`` specifiers result in a
-printed resource with (R) or without (r) a decoded flags member.
+printed resource with (R) or without (r) a decoded flags member.  If start is
+equal to end only print the start value.
 
 Passed by reference.
 

-- 
2.47.0

