Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F43171D2
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747787224; cv=none; b=c1aX+mIbdXQioQvUg85DD6Vam5poVfJACt3y+Y/s6vTKESuOIG3oansBN/tGBzuUnkz3SJtn9cF9o5/wFqXIA0dFgRo2wqbwxhAwBH4jPcMOLzjbsu/ezWcTRzWqIu5ia2AikjGW+Y+E5i/rGATLxn8rtIZheY4YPxpDEzuMK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747787224; c=relaxed/simple;
	bh=JsasuI8EBSJUBttnTRl0qIa0Ar7cUOSsCYI4XvK1ekc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4UVnMvPr4r1wk9I1s2lQJ/fVVQeTO3yzRDYvolQlsO03kBOujrpEB5zUv1HyYv6NYfTVhBOOSzeYS4dU78TjXi6KJM3qwC/mQW2FF/i/eIQx2aXeQyrI0OV43Q0uqX6C2NlTJmm/z+sbSwqe+yFls5nn++dNAIUp7hLGjDpcGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4wdLkdH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4wdLkdH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747787222; x=1779323222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JsasuI8EBSJUBttnTRl0qIa0Ar7cUOSsCYI4XvK1ekc=;
  b=S4wdLkdHofaSg1hSdLTjLqId4AIPZdb41GOAEKWyWU+6Zjl5gpl4ml0q
   HDeIDVkMAcX7d0c07JjMh1P0P4MojLKgHbHuqQvGthGcB4ld0WUXz7YE8
   40uBE+cUpunDEWrmaFFWpAboZvDy33aBiZJsW/lxqtYtY8k92n9SKg5nP
   e4xuP316DmRM6zrMB7aHMJCHfm2aE5wDr8NZpblF7cQfCg5CLQG6JDiWs
   4QkAB9571Meg9Gpwaa8SSF35g9OSIIR9WpB9fRKqO6FhDfnUpEq4sUXry
   Bbi/yI+GkMB+SMEJC94KM3jfSGluOIlZW1Gebiqu7VLOyuS19jRX4BRC2
   A==;
X-CSE-ConnectionGUID: cqdbHEhMTfGgmwd4cvPsrg==
X-CSE-MsgGUID: pGTH1zAaSkqguCIVvDWD8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49645888"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49645888"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 17:27:01 -0700
X-CSE-ConnectionGUID: 0TP4sVPVSl6xpftLe7g22Q==
X-CSE-MsgGUID: C49aQXHRQfa2YOiDcJbohQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="144735084"
Received: from unknown (HELO hyperion.jf.intel.com) ([10.243.61.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 17:27:00 -0700
From: marc.herbert@linux.intel.com
To: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	alison.schofield@intel.com,
	dan.j.williams@intel.com
Cc: Marc Herbert <marc.herbert@linux.intel.com>
Subject: [ndctl PATCH 1/2] README.md: add CONFIG_s missing to pass NFIT tests
Date: Wed, 21 May 2025 00:26:39 +0000
Message-ID: <20250521002640.1700283-1-marc.herbert@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Herbert <marc.herbert@linux.intel.com>

Found by trial and error. As of kernel v6.15, the CONFIG_s in this
version are enough to give to ./scripts/kconfig/merge_config.sh and pass
`meson test --suite=ndctl:ndctl` and `meson test --suite=ndctl:dax`

This has been manually tested with only `make defconfig ARCH=x86_64` as
a starting point. This is admittedly incomplete test coverage but still
a massively better starting point for other ARCHs and a big time
saver. There's a good chance it's enough for other ARCHs too.

Link: https://lore.kernel.org/nvdimm/aed71134-1029-4b88-ab20-8dfa527a7438@linux.intel.com/
Signed-off-by: Marc Herbert <marc.herbert@linux.intel.com>
---
 README.md | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/README.md b/README.md
index db25a9114402..a37991ccefa2 100644
--- a/README.md
+++ b/README.md
@@ -69,10 +69,20 @@ loaded.  To build and install nfit_test.ko:
    CONFIG_NVDIMM_PFN=y
    CONFIG_NVDIMM_DAX=y
    CONFIG_DEV_DAX_PMEM=m
+   CONFIG_FS_DAX=y
+   CONFIG_XFS_FS=y
+   CONFIG_DAX=m
+   CONFIG_DEV_DAX=m
    CONFIG_ENCRYPTED_KEYS=y
    CONFIG_NVDIMM_SECURITY_TEST=y
    CONFIG_STRICT_DEVMEM=y
    CONFIG_IO_STRICT_DEVMEM=y
+   CONFIG_ACPI_NFIT=m
+   CONFIG_NFIT_SECURITY_DEBUG=y
+   CONFIG_MEMORY_FAILURE=y
+   CONFIG_MEMORY_HOTPLUG=y
+   CONFIG_MEMORY_HOTREMOVE=y
+   CONFIG_TRANSPARENT_HUGEPAGE=y
    ```
 
 1. Build and install the unit test enabled libnvdimm modules in the
-- 
2.49.0

