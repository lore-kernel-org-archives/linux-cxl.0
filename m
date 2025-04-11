Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7B15D5B6
	for <linux-cxl@vger.kernel.org>; Fri, 11 Apr 2025 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361559; cv=none; b=quDOV1BNUwZo8ZRYKpq3plzfDfW41FgYU5/L6nCxRTMOazZPKAVjwMjXPzdUXAYJjH4cT/rOwPTzorGDfE9+R+fVfq4Vw2nsNy3xSU2NYsQJWZ1QcTwatst1A+Ue7mP8oj+QRamlmdlfycfQc27g3+BkFv/xcqMaRctztWsxBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361559; c=relaxed/simple;
	bh=c02MFPyU5EbdFQEsTTx2HPJujZUKNMUWSocYhlDpPxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U199tB3Bx9OFoPkCklmVDfegL7El7tfB4qpHqOk2WDKUP6DgdY85hb20FvcQQ08OCBZXFrdiHomYBlvTr0Z+muZfUudANcIanFwTqpihu+G/rsCqZ5RQ6pzAJqXXEh3RZ+68Ruyp9lJn0yBMK+xoWLhy/bJDpW06eYQ1M3RguFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=tCqU/8iF; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="tCqU/8iF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1744361557; x=1775897557;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c02MFPyU5EbdFQEsTTx2HPJujZUKNMUWSocYhlDpPxY=;
  b=tCqU/8iFX85WyRrToDq74oeDu5W6n4wuOs3hxv2IlPimuDySe7F5FS1k
   W5F8+PFQVOidn953nF2lulz05GHIVoTuq/zEjszjaR0IKWasEX9eWPJw2
   76RoWkCyjgXlbIuyB2uxI+MuYmP+fBoddKZf07eCxKYYYZ4kOjoDmZlnd
   cBaZ2KN1CByB481+F9FE6AKqjnwZuY04qqfgZYkLyIc3jVH1QkEpYnS21
   LcsHDbnuwXQxqsT68qUwl7TCPEre3UfuXx89KrYzt+k/hM3pH/4JJoZtq
   Eiv04TlgfgMJMR1F4r0Ma0e9s2untzCP5dCbOdolqE5aqiYRSdLqSzXLR
   g==;
X-CSE-ConnectionGUID: dL7rk4E9Q6qBpL6g9tAmDw==
X-CSE-MsgGUID: UOBHCwqdTamXcCR0fBzMxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="195328916"
X-IronPort-AV: E=Sophos;i="6.15,203,1739804400"; 
   d="scan'208";a="195328916"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 17:52:28 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id D727AD4F6F
	for <linux-cxl@vger.kernel.org>; Fri, 11 Apr 2025 17:52:25 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 97CED144CB
	for <linux-cxl@vger.kernel.org>; Fri, 11 Apr 2025 17:52:25 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 85A1A1A0078;
	Fri, 11 Apr 2025 16:52:24 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH] cxl/region: Prevent destroying region out of order
Date: Fri, 11 Apr 2025 16:52:18 +0800
Message-Id: <20250411085218.120312-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The destruction operation lacks atomicity, which may result in partial
completion of the destruction process when attempting to destroy an out
of order region.

Previously, a out of order destroy will return:
$ sudo cxl destroy-region region1 -f
cxl region: destroy_region: decoder4.0: set_dpa_size failed: Device or resource busy
cxl region: decoder_region_action: region1: failed: Device or resource busy
cxl region: region_action: one or more failures, last failure: Device or resource busy
cxl region: cmd_destroy_region: destroyed 0 region

Then, the components under this root decoder enter a stale state, the user
cannot create region any more under this root decoder.

The kernel has already ensured that region/decoder committed in order,
so just ensure to destroy the last region is enough.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 cxl/lib/libcxl.c   |  7 +++++++
 cxl/lib/libcxl.sym |  1 +
 cxl/libcxl.h       |  1 +
 cxl/region.c       | 11 ++++++++++-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 63aa4ef3acdc..c13bb9377237 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -706,6 +706,13 @@ CXL_EXPORT struct cxl_region *cxl_region_get_first(struct cxl_decoder *decoder)
 	return list_top(&decoder->regions, struct cxl_region, list);
 }
 
+CXL_EXPORT struct cxl_region *cxl_region_get_last(struct cxl_decoder *decoder)
+{
+	cxl_regions_init(decoder);
+
+	return list_tail(&decoder->regions, struct cxl_region, list);
+}
+
 CXL_EXPORT struct cxl_region *cxl_region_get_next(struct cxl_region *region)
 {
 	struct cxl_decoder *decoder = region->decoder;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 0c155a40ad47..3ce408b9cc55 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -180,6 +180,7 @@ global:
 	cxl_decoder_set_dpa_size;
 	cxl_decoder_set_mode;
 	cxl_region_get_first;
+	cxl_region_get_last;
 	cxl_region_get_next;
 	cxl_region_decode_is_committed;
 	cxl_region_is_enabled;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 0a5fd0e13cc2..9b5657203eec 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -305,6 +305,7 @@ int cxl_memdev_is_enabled(struct cxl_memdev *memdev);
 
 struct cxl_region;
 struct cxl_region *cxl_region_get_first(struct cxl_decoder *decoder);
+struct cxl_region *cxl_region_get_last(struct cxl_decoder *decoder);
 struct cxl_region *cxl_region_get_next(struct cxl_region *region);
 int cxl_region_decode_is_committed(struct cxl_region *region);
 int cxl_region_is_enabled(struct cxl_region *region);
diff --git a/cxl/region.c b/cxl/region.c
index 96aa5931d228..2eb6f5416433 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -835,7 +835,16 @@ static int destroy_region(struct cxl_region *region)
 {
 	const char *devname = cxl_region_get_devname(region);
 	unsigned int ways, i;
-	int rc;
+	int rc = 0, , did = cxl_region_get_id(region);
+	struct cxl_decoder *decoder = cxl_region_get_decoder(region);
+	struct cxl_region *last_region = cxl_region_get_last(decoder);
+	int last_id = cxl_region_get_id(last_region);
+
+	if (last_id > did) {
+		log_err(&rl, "Unable to destroy region out of order, "
+			"please destroy region%d first.\n", last_id);
+		return -EINVAL;
+	}
 
 	/* First, unbind/disable the region if needed */
 	if (cxl_region_is_enabled(region)) {
-- 
2.47.0

