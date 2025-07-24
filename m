Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAFC246BBA
	for <linux-cxl@vger.kernel.org>; Thu, 24 Jul 2025 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395377; cv=none; b=WOgmDDOX+1jQoWaIICu1mmtTNnu87y8v/mKsE8aL26WVVq2r7imhOKWkHl3ZTFxWQXu+Bq7zdYQg2qXZlM7zjFD2JuMqexM3az+CfUhIf7Ba7fvYW4rXmSbCxi1RhovoH3rkKA7nYblG78/OfeDT2Rqr5NHSJ/o2sZd3SRgKJVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395377; c=relaxed/simple;
	bh=VcikA3UnCwqrCY5NEwwfm7B+1JKK+OkZgnq+NMvjpUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGbHLlTK289+OWgGv4+tscaiCakmq1gSr30XruVScuokLr/adL62+kRy0aNXmJXJ2Bm8mOqbnW3wyNQV1opd3wC8o6z8vQuwNGqtA6cxfw8ZJyXtqCUUMbEX2ZNTMKhrn7f7JrLaOBX5CCFmzXl6wwvNsTVG/gdCQCBd0LnQpsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A82Z9zAs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A82Z9zAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753395375; x=1784931375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VcikA3UnCwqrCY5NEwwfm7B+1JKK+OkZgnq+NMvjpUI=;
  b=A82Z9zAsfTB6s9X32WPDJqTRyPhU4zI31zshvzL45OO9U0gsFEP+Mj/I
   +R14JXPMz6mIWM8lEwETYXrGtcja9oCL0y8JpJrBOYXQ1eVdIcrJHAVEA
   dB/lARbHcqw3revuwobnw6ErYXQPxj3rgYFhJxHtQFk8+tG1rMxGXfKoo
   gcr12sTmyFsi90AWIM/c8B0Y7DMjarsHmVkuW3ay779dm4EbAQ7Y5YYBn
   4HR/FzO3auTv/+6f22jahfLNric9kr+jT8kuyVp2ryni4WBsApri8ZGUp
   5DCHvUYG+wb45zBAMxwYHYoQ300MHcMtLnDKQ3BjwNs31FVdo98dBZqrW
   Q==;
X-CSE-ConnectionGUID: hQAasVMuTeuE311GHBtSsQ==
X-CSE-MsgGUID: tQIop82kRFO3yEJ3l023PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="54941718"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="54941718"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 15:16:15 -0700
X-CSE-ConnectionGUID: g0L8JAI3S4eaxtysAGj4Tw==
X-CSE-MsgGUID: I8id3XjETdSBl7IMLSqYqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160504718"
Received: from unknown (HELO hyperion.jf.intel.com) ([10.243.61.29])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 15:16:15 -0700
From: marc.herbert@linux.intel.com
To: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	alison.schofield@intel.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com
Cc: Marc Herbert <marc.herbert@linux.intel.com>
Subject: [ndctl PATCH 2/3] test/common: move err() function at the top
Date: Thu, 24 Jul 2025 22:00:45 +0000
Message-ID: <20250724221323.365191-3-marc.herbert@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724221323.365191-1-marc.herbert@linux.intel.com>
References: <20250724221323.365191-1-marc.herbert@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Herbert <marc.herbert@linux.intel.com>

move err() function at the top so we can fail early. err() does not have
any dependency so it can be first.

Signed-off-by: Marc Herbert <marc.herbert@linux.intel.com>
---
 test/common | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/test/common b/test/common
index 2d8422f26436..2d076402ef7c 100644
--- a/test/common
+++ b/test/common
@@ -1,6 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2018, FUJITSU LIMITED. All rights reserved.
 
+# err
+# $1: line number which error detected
+# $2: cleanup function (optional)
+#
+
+test_basename=$(basename "$0")
+
+err()
+{
+	echo test/"$test_basename": failed at line "$1"
+	[ -n "$2" ] && "$2"
+	exit "$rc"
+}
+
 # Global variables
 
 # NDCTL
@@ -53,17 +67,6 @@ E820_BUS="e820"
 
 # Functions
 
-# err
-# $1: line number which error detected
-# $2: cleanup function (optional)
-#
-err()
-{
-	echo test/$(basename $0): failed at line $1
-	[ -n "$2" ] && "$2"
-	exit $rc
-}
-
 reset()
 {
 	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
-- 
2.50.1

