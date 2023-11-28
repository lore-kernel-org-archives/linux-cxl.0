Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HL/whBc9"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812091AA
	for <linux-cxl@vger.kernel.org>; Mon, 27 Nov 2023 20:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701144706; x=1732680706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ip5PyEhyvYbbRH/6U5LIUuhALeMlHi0XxMtqRdbksTc=;
  b=HL/whBc9IkJnEWVyCrNwnD6jCzGHSzUBwwfNY6wDX75e70QrUis6VLc2
   k0yhFKMJ9Eppd5T8SKUS2niiVF/p3aazbm++wRP2M5Fc1b9ajUAEqOZ/w
   KIjhfqLZpTtipILey3bwrmvEifOmcWZ6uypFiiaeS8MqWTLutkrBwc1mH
   uWl1J6ZMdTqGFsC8IxlIbEH0KRgzvPB+NaxmHOgOJGmTrIHrwUJKHMvIB
   ah2/h+r5mBHlTG5lZC2ZyQKObdHxD3wVv+pdzzs2ZPcf30XgKmljNI44n
   /F8Ul4daojVWeQ05tpDS4oSgNAoieopmGQEQzSLcneUiP8mUYUYTQPny2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="390001066"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="390001066"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 20:11:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="891948439"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="891948439"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.170.56])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 20:11:45 -0800
From: alison.schofield@intel.com
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 2/3] cxl/test: add a cxl_ derivative of check_dmesg()
Date: Mon, 27 Nov 2023 20:11:41 -0800
Message-Id: <39c11efdefeb12c3c928f36e9c59eeb40a841e72.1701143039.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1701143039.git.alison.schofield@intel.com>
References: <cover.1701143039.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

check_dmesg() is used by CXL unit tests as well as by a few
DAX unit tests. Add a cxl_check_dmesg() version that can be
expanded for CXL special checks like this:

Add a check for an interleave calculation failure. This is
a dev_dbg() message that spews (success or failure) whenever
a user creates a region. It is useful as a regression check
across the entire CXL suite.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 test/common | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/test/common b/test/common
index 7a4711593624..c20b7e48c2b6 100644
--- a/test/common
+++ b/test/common
@@ -151,6 +151,19 @@ check_dmesg()
 	true
 }
 
+# cxl_check_dmesg
+# $1: line number where this is called
+cxl_check_dmesg()
+{
+	sleep 1
+	log=$(journalctl -r -k --since "-$((SECONDS+1))s")
+	# validate no WARN or lockdep report during the run
+	grep -q "Call Trace" <<< "$log" && err "$1"
+	# validate no failures of the interleave calc dev_dbg() check
+	grep -q "Test cxl_calc_interleave_pos(): fail" <<< "$log" && err "$1"
+	true
+}
+
 # cxl_common_start
 # $1: optional module parameter(s) for cxl-test
 cxl_common_start()
@@ -170,6 +183,6 @@ cxl_common_start()
 # $1: line number where this is called
 cxl_common_stop()
 {
-	check_dmesg "$1"
+	cxl_check_dmesg "$1"
 	modprobe -r cxl_test
 }
-- 
2.37.3

