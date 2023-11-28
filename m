Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idalali7"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620371AD
	for <linux-cxl@vger.kernel.org>; Mon, 27 Nov 2023 20:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701144707; x=1732680707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s23M8GQJ0QGy6Tw/q4SmIxShJcKb+Z5G+O+sswjlU30=;
  b=idalali7Re3WYddbPHsLOKZJyyrFktRprtRkojuXP19KEGb9tFBGpNnW
   MU/Pc2YjJ+mhZhJRayoSBwxTw2V6Rjm1WyfLRFYOVilpFFF1lSntpmbEh
   /XQyfMuWjQPhCEb0VNfhC/QGnWsf2KCLJDaGYYSpYA7sUTLe06vwJwrxD
   11LemJWJAFB61+UQfFrb1liDJadvOCNu7MY27QjsjVaxfJXagQjCCnUMW
   F4ntYUt3uEaC/8KYpPx7sqpb2Vtrt2v/emyk8jVoiOca9f9nH/AzAEmrh
   JiUsvGXiyJkEe4v+QbJxq6vh7dOqSYF3iJoz1LHUjsxNk0C546ZNgTE/R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="390001069"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="390001069"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 20:11:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="891948442"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="891948442"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.170.56])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 20:11:46 -0800
From: alison.schofield@intel.com
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 3/3] cxl/test: use an explicit --since time in journalctl
Date: Mon, 27 Nov 2023 20:11:42 -0800
Message-Id: <1802cf15f22fe5c284167a9186eba8f2cd3c31c6.1701143039.git.alison.schofield@intel.com>
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

Using the bash variable 'SECONDS' plus 1 for searching the
dmesg log sometimes led to one test picking up error messages
from the previous test when run as a suite. SECONDS alone may
miss some logs, but SECONDS + 1 is just as often too great.

Since unit tests in the CXL suite are using common helpers to
start and stop work, initialize and use a "starttime" variable
with millisecond granularity for journalctl.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 test/common | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/common b/test/common
index c20b7e48c2b6..93a280c7c150 100644
--- a/test/common
+++ b/test/common
@@ -156,7 +156,7 @@ check_dmesg()
 cxl_check_dmesg()
 {
 	sleep 1
-	log=$(journalctl -r -k --since "-$((SECONDS+1))s")
+	log=$(journalctl -r -k --since "$starttime")
 	# validate no WARN or lockdep report during the run
 	grep -q "Call Trace" <<< "$log" && err "$1"
 	# validate no failures of the interleave calc dev_dbg() check
@@ -175,6 +175,7 @@ cxl_common_start()
 	check_prereq "dd"
 	check_prereq "sha256sum"
 	modprobe -r cxl_test
+	starttime=$(date +"%T.%3N")
 	modprobe cxl_test "$1"
 	rc=1
 }
-- 
2.37.3

