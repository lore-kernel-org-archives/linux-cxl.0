Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849320;
	b=IXeaNqC+2QY4WNmoXCF6Gmjy1uO+fuJHHo2NZZ7VuAX5q2cY69AQk81el+nKE/LBsE4B
	 yyrGTuqyG0nC6jDxVW8kt/E7ANtbIUJSj4Ma9Eeo+nDy0fbpP5FYuxY8C22arV+PDCidD
	 m+3KMrR8jlMGEVsSw9uD4jzJ3iPsMr9PlXnnuEpoN+QfBr4mj8wa12htJNsKxqdOZhWXP
	 ++/6IRD0rAP7IjXxoRGgDHb2zaw8fQfAU5peRJXXwP9jd4LCgkVhMaftlBBKeE5SUnjl2
	 4Z1jqXCLXZ5jA++BEIsb52g+qNd503vgZuhd9Cv72sR+J2e+kjCKVMOPl4GutmTGcSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849320;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hcw/Sk9bVTAyjh92DQBQNIEqzwf8IwBspSzfo9kDJgk=;
	b=mHxzKaJ41cJSQxsFnUyqgMxG9H/KSJ6VwQs7fW8V5B3RgTU3SdQBrfoNn/H5ppV6qo0N
	 rvYA4T29EhqEJA3kJbx2kgS2nO2xArd8UAQOs2vArj7JgarPzPJ3HYamiiED9DFwxS5Np
	 fxRYBAbEOZyIYumDXzsopFivdGxs2y+xXk43TSbbjIFftk8V2gIEAG4mw7WQYYT5KOhtp
	 lqMzf2QH0sezZPW6Rm2NR8GEnGTjIGkiOKFXLXICwURhIaTVEAOp/2mGP73tni8MESTEl
	 djBKl1eFL4+nOi8SJEVMgDLL9Ft47mTHIGkud2xHoHSyPEJ0wVP8BYuHwKk6iHlrPXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QbvxoCtp;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5D606A328
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 03:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE5D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QbvxoCtp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793849320; x=1825385320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n9cG0hyPL6HV3wKC8eCySI0CKXyOIPbvgf7sMH+qZUI=;
  b=QbvxoCtp8XPU3rp4OahLhcxzGayTv0++MH8CHrYqbL2a/5f6QJ8Paa87
   3zzioRm77/0jHKAT076Tgv3dtqLjkxbj2IpTMfutEpI0HcOBRZT6/gxSA
   /vA/DO8XF0UDlpFdEJ2ir1iNjhTd2BLGdEnwHLSd41uuxr2brMCs6y297
   eneTzQ09InEzYCG+AhVgqdo5/awOwxV7T/N5EZB1y1m1cqFrQi+tbb/mb
   l9Wi/Lm5i26Bo5bU8rsRfBQHYw7kVR3YPGPOmZ1Fk7KoLwy3EzaY9qAF2
   iwOfZA/Sq51K4g6P9XLhBGoviv5svRcpGGW95Cs5FB2ynV9jq5tCKVaP9
   w==;
X-CSE-ConnectionGUID: ayLolQvASDi98gV2gCUJuQ==
X-CSE-MsgGUID: v3RBuH5ZS6Ol8X87vGpBVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2511502"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2511502"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:28:40 -0800
X-CSE-ConnectionGUID: nrJa9Qk3RZaE5z6kT9lWnw==
X-CSE-MsgGUID: vSGhYZ6ESM6DgJFy8sM2Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6913293"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:28:39 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 4/4] cxl/test: Give each mock memdev its own performance data
Date: Wed,  4 Nov 2026 19:28:31 -0800
Message-ID: <a078fadc9d039a34645ab8778fbf17faa3c85f27.1793847269.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793847269.git.alison.schofield@intel.com>
References: <cover.1793847269.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assign distinct and predictable latency and bandwidth values to mock
memdevs so region performance calculations can be tested against the
expected contributions of individual targets.

Derive each memdev's performance data from its memdev id:
  latency   = 100 + 10 * id     (nanoseconds)
  bandwidth = 1000 + 100 * id   (MB/s)

These values allow tests to detect stale or duplicate contributions from
targets that are not members of the completed region. Since mock memdevs
are not PCI devices, the shared-upstream bandwidth calculation is skipped.
Region bandwidth in cxl_test will be the sum of the individual memdev
bandwidths, providing a predictable result for testing.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 3eb1051b1ee8..762c8b9ed4dd 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1629,18 +1629,29 @@ static struct cxl_dport *mock_cxl_add_dport_by_dev(struct cxl_port *port,
 }
 
 /*
- * Faking the cxl_dpa_perf for the memdev when appropriate.
+ * Derive mock performance data from the memdev id so tests can identify
+ * each memdev's contribution to region performance.
+ *
+ *   latency   = 100 + 10 * id     (nanoseconds)
+ *   bandwidth = 1000 + 100 * id   (MB/s)
+ *
+ * Keep the values nonzero so the region access attributes are visible.
+ * The ndctl cxl-perf-data.sh test relies on these formulas.
  */
 static void dpa_perf_setup(struct cxl_port *endpoint, struct range *range,
 			   struct cxl_dpa_perf *dpa_perf)
 {
+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
+	unsigned int bandwidth = 1000 + 100 * cxlmd->id;
+	unsigned int latency = 100 + 10 * cxlmd->id;
+
 	dpa_perf->qos_class = FAKE_QTG_ID;
 	dpa_perf->dpa_range = *range;
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
-		dpa_perf->coord[i].read_latency = 500;
-		dpa_perf->coord[i].write_latency = 500;
-		dpa_perf->coord[i].read_bandwidth = 1000;
-		dpa_perf->coord[i].write_bandwidth = 1000;
+		dpa_perf->coord[i].read_latency = latency;
+		dpa_perf->coord[i].write_latency = latency;
+		dpa_perf->coord[i].read_bandwidth = bandwidth;
+		dpa_perf->coord[i].write_bandwidth = bandwidth;
 	}
 }
 
-- 
2.37.3

