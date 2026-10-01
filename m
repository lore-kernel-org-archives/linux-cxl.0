Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174EB205E29
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 05:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790831754; cv=none; b=GTJzH58bU5OaH+Ugs/7N+2E3zgsJxhPeKqOXqho+xgWcr6DlTC5y9qBTMn/F9ydoOHqGgYGqaFWdR5pZJtlAYZ3FLKnIcj7MLrsqNqWgha18afHi0eiLS6I0W7CWqU43gNVC5Zn1yKc7YvnIznnxW2ZmYEq/+QCpq2GQzLp9FO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790831754; c=relaxed/simple;
	bh=3VLZo6j36tRWay3iBxnPFiXrNqoJy08gVTblYkOFE6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUfREPg6N8f3+8MKYrsq6Pt5uWiJKpH87n6tfWOPLce5MT8eQZV6aa0gRUSAWhcSjZE5ppzZPlP+YV3pWA5GV6/7me7qPdJjP9Nxz+TnWywOHFx6SK2Db3ZcKHfaYBLZccTRRluBh0u8LJRbK4PE2P6LjDwVZT12J2XS+jQ7tJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOsioHJK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOsioHJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790831751; x=1822367751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3VLZo6j36tRWay3iBxnPFiXrNqoJy08gVTblYkOFE6o=;
  b=JOsioHJKaa43MuUQQ59ZxuSjSGWw+a8G1krQATIzquRq9+zoisrQhE6H
   L81rJlQJjy2IRZARCUNJmrN1CBZ3ekdobgABLxUYVI+2/VmKfB9W0N7EI
   DFs3wvlLhfNO1Bb8kIyWwYUrX9d6Zx+rEb8EWR5AJ4lYwnBMNuZz4KFZt
   44po0vQ+PyRm/xrouhs2lXAbwJtrqGf8+kcLpYkBSQUkpMA9GmELCAxiL
   glkFV6YSmWXid8UtJ/fSMZND9h9xXcWuQbtJhD+L4VSoHUCjBQ4c7HRM9
   P0rXXRvCz+3mqkhsNg2plQRTgHoqmFHeGbaxRXWt1iyCVmS3bU7ogHRk2
   g==;
X-CSE-ConnectionGUID: PAj/sK5jTjqmrn5i2pKo4g==
X-CSE-MsgGUID: VbwY2ee1Q6CvXp7AXHQXgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102953772"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="102953772"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 22:15:50 -0700
X-CSE-ConnectionGUID: 36+b7W1mQQq/5s12nNZJVw==
X-CSE-MsgGUID: k/GX+WnCR1uW3xR6Mooa9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="274517233"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.57])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 22:15:50 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>
Subject: [ndctl PATCH] test/cxl-region-sysfs.sh: test a repeat write of a region target
Date: Wed, 30 Sep 2026 22:15:44 -0700
Message-ID: <20261001051546.126881-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A CXL driver fix making its way upstream [1] rejects a repeat write of
an endpoint decoder to the region targetN attribute that already holds
it. Without the fix, that write leaves the region half detached from the
endpoint's ports, and a later write can crash the kernel.

Add a test case to backstop that fix: write target0 twice on a partially
populated region and check that the second write fails and leaves the
region's decoders attached.

[1] https://lore.kernel.org/all/94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com/


Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 test/cxl-region-sysfs.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/test/cxl-region-sysfs.sh b/test/cxl-region-sysfs.sh
index db1a163efb30..957a1792fbd7 100644
--- a/test/cxl-region-sysfs.sh
+++ b/test/cxl-region-sysfs.sh
@@ -87,9 +87,19 @@ do
 						     select(.mode == \"pmem\") | .decoder")
 done
 
-# attach all endpoint decoders to the region
-pos=0
-for i in ${endpoint[@]}
+# a repeat write of an attached endpoint decoder must fail and leave
+# every decoder between it and the root attached
+echo "${endpoint[0]}" > "/sys/bus/cxl/devices/$region/target0"
+nr_attached=$(cat /sys/bus/cxl/devices/decoder*/region | grep -cx "$region")
+if echo "${endpoint[0]}" > "/sys/bus/cxl/devices/$region/target0" 2>/dev/null; then
+	err "$LINENO: repeat write of ${endpoint[0]} to target0 succeeded"
+fi
+nr=$(cat /sys/bus/cxl/devices/decoder*/region | grep -cx "$region")
+[ "$nr" -ne "$nr_attached" ] && err "$LINENO: $nr of $nr_attached decoders still attached"
+
+# attach the remaining endpoint decoders to the region
+pos=1
+for i in ${endpoint[@]:1}
 do
 	echo $i > /sys/bus/cxl/devices/$region/target$pos
 	pos=$((pos+1))
-- 
2.37.3

