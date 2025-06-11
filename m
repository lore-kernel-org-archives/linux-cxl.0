Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE32D8DBD
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686028; cv=none; b=LhZseWh3sXKZnx5Wn4G/Qb8ILLM52yDQSILH10PVCw4Mm7yrzRvy5EZl3pnJev5vG0sk8lucVVL8Ck8Ki1FOIFbRVYbLcg61CPAClZYXUyuqvgoB5TgXcttJfwJ5ijAUXheZ4q5YdMxQtkSp9Yiic7t/6Su4kypZUnLX8g2cX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686028; c=relaxed/simple;
	bh=wN5rDH56DrHhY+AkxZioAxFuoyv/HBhzURbdog7wjz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYDYfE8qZJMo6NWYiugri8POc296USHJ5ORH9YxxrCg4fgADk/073uj4SMgE7Zd6j5zhW0600heT8Dj6tlfGNhY3mlxO0yN9YrQEK4ai0H/uxC1tv7ao9QoqGi+Lx/zTyskPOgT18LbyEKTC9yFO6v5WdnlnXhZAPj8hjLB6VVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9Z53L78; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9Z53L78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749686025; x=1781222025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wN5rDH56DrHhY+AkxZioAxFuoyv/HBhzURbdog7wjz8=;
  b=n9Z53L781b4/wq0Lg5MCV98JcRHuCaKU91Pf7yjmQm5nDDruXlyuQwqF
   iGrVXwEgMLms/PtakLKM0Fd66/TFeSfNwfViJisvqvtsIDEKHQ0ZxuVYN
   RWLcQczOx5dajkOsEjWHXiSoSaYnwE6lsYw3u4TmnAVZYmHRQsfGTssY7
   pX8tE8KMnyUscwD/wMsuXLH+sZwocLvAZr3JJBbKltzAJWq6vAAScmm2X
   9IOD7r55IjXfifQy15htykT4HI602cAAOoo+xLzIbuCbuFg7b7YC+0MC2
   4SBnKD4d80xlqIPeNaz63mFz/9yUMLlzpCdgPQSDeajDnnACZbq1xKg3A
   Q==;
X-CSE-ConnectionGUID: VpiL+rwDQCaXWFlYMGP7Iw==
X-CSE-MsgGUID: 5nx/GqfWSFK7dIyhCc6rNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="50955772"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="50955772"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 16:53:44 -0700
X-CSE-ConnectionGUID: VuMjCmWtQWqY8Q3oE4dIhA==
X-CSE-MsgGUID: jzQSR6x5TMW+qZtPwF74Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="147243931"
Received: from unknown (HELO hyperion.jf.intel.com) ([10.243.61.29])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 16:53:44 -0700
From: marc.herbert@linux.intel.com
To: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	alison.schofield@intel.com,
	dan.j.williams@intel.com
Cc: Marc Herbert <marc.herbert@linux.intel.com>
Subject: [ndctl PATCH v3 1/2] test: move err() function at the top
Date: Wed, 11 Jun 2025 23:44:20 +0000
Message-ID: <20250611235256.3866724-2-marc.herbert@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611235256.3866724-1-marc.herbert@linux.intel.com>
References: <20250611235256.3866724-1-marc.herbert@linux.intel.com>
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
index 75ff1a6e12be..74e74dd4fff9 100644
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
2.49.0

