Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0E5C5E0
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jan 2024 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439841; cv=none; b=JmOC7MEZzqqXhQlu9ZW5lfR3YBx3OR4/lfCWxD/ZvWlRQNeqND0riiDluZSSVAQq1g65/G/n/3oQx/cR4Yh57c/dHZpGeUK1Kujk9ctXq12rO52ZPyE+IiL0admR3Lu4ralBg5xsFxlv8XncBPzLJJpvjP8uX6FOlX3gCm9DheA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439841; c=relaxed/simple;
	bh=XLAoUidCuhl+ys51NscDYMbpTqKBpOdX9TAENIzO3aA=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Subject:From:To:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=uFtEPiAixF6iLzhLzxyDsHv7q0kuK8oN8Xdz4vS+cTttGnnyjSim4DIM+quLcwGnRFQ7TdyiAPOOWHYNTWOWt4H1MzSoKlQwCgJpTocJYEfHzcuW3mGBF26GN7GejAM+iB8d376PSsS7Ju6edBHxsRO3n2O3buwgTso/jfmPAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNouTzdr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNouTzdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705439839; x=1736975839;
  h=subject:from:to:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XLAoUidCuhl+ys51NscDYMbpTqKBpOdX9TAENIzO3aA=;
  b=MNouTzdrXV049sVn/ioa+1p14ATKs+AVih335bRhQp5xfnXJgBjkH+4y
   HevFt4AXiDQB0k4Jp7gvHuZDeJCnMGqV3x+Y/VuJPNfjO+qwfTwCbMXlK
   97IgjmYqy6XxNVwENlfJaJ4TXaB340FKiuDrUzeZi/t1K7fMczhxtvgNd
   6szAmFI+5mp3iWNn4nffCHHZIDA1S2iUxLgmWcbB/BNRDRrUX3C1dWDs4
   YMjXzTcFXj1ujFuz128oVwMtkRcIlHIY5HNASh9gU8ogHhALVgRHM/Rzs
   L47+JUdKnw+NHxiA2btDE8DmbUP6pBbma2CNCqj8Qq0xh0K5ukjrX9sY/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6704675"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="6704675"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:17:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="957308511"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="957308511"
Received: from dbsheffi-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.54.167])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:17:18 -0800
Subject: [PATCH] tools/testing/cxl: Disable "missing prototypes /
 declarations" warnings
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date: Tue, 16 Jan 2024 13:17:17 -0800
Message-ID: <170543983780.460832.10920261849128601697.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Prevent warnings of the form:

tools/testing/cxl/test/mock.c:44:6: error: no previous prototype for
‘__wrap_is_acpi_device_node’ [-Werror=missing-prototypes]

tools/testing/cxl/test/mock.c:63:5: error: no previous prototype for
‘__wrap_acpi_table_parse_cedt’ [-Werror=missing-prototypes]

tools/testing/cxl/test/mock.c:81:13: error: no previous prototype for
‘__wrap_acpi_evaluate_integer’ [-Werror=missing-prototypes]

...by locally disabling some warnings.

It turns out that:

Commit 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")

...in addition to expanding in-tree coverage, also impacts out-of-tree
module builds like those in tools/testing/cxl/.

Filter out the warning options on unit test code that does not effect
mainline builds.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/Kbuild      |    2 ++
 tools/testing/cxl/test/Kbuild |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 0b12c36902d8..caff3834671f 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -65,4 +65,6 @@ cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
 cxl_core-y += cxl_core_exports.o
 
+KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
+
 obj-m += test/
diff --git a/tools/testing/cxl/test/Kbuild b/tools/testing/cxl/test/Kbuild
index 61d5f7bcddf9..6b1927897856 100644
--- a/tools/testing/cxl/test/Kbuild
+++ b/tools/testing/cxl/test/Kbuild
@@ -8,3 +8,5 @@ obj-m += cxl_mock_mem.o
 cxl_test-y := cxl.o
 cxl_mock-y := mock.o
 cxl_mock_mem-y := mem.o
+
+KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))

