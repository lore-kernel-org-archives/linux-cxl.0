Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E4376E2
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694256; cv=none; b=uP1YrxYF9uktKoqUNw3/FfrKVZWlJB43reaEpGXU9tVDID3SgJ38cibSG2YYtIXl3Uxr5w+lM/hyfxwnlD7GcDC5FIjMOlktEfdsdq2iel6GNVkdDZwpBjYJs25Ojbn6jOJQuuXF741zeuJyL2bsXtf7ypUilU2mc3yPQXBSCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694256; c=relaxed/simple;
	bh=bCrcdq4lNI8kIJNZkx/SfFaA95id3/KBVLHFuh8UmNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkqFlvagr/7E23n/teccT6KCXJbR86bYH00xAS04Rv6w4cOoWi9iz81VE/Lcvpjg+b184XQMma0CdTokbdTJZXrDaOVWJfyDouHT5xwSeEaJnXQh3HmZfZJaU4B5jJCFjXeG3OAgbVeuujO63+rhQ88dS8s82bujH2efIkU54/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=auabaMAs; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="auabaMAs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1711694255; x=1743230255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bCrcdq4lNI8kIJNZkx/SfFaA95id3/KBVLHFuh8UmNU=;
  b=auabaMAsvdw3fQY+GCn0zvx59ewRMOkPVKlKOu6HBDt9JbH7w3nbsn8n
   uFlzOxPfcd3zxmI8O/9ma1AaQFQIixtK9Czz/7GFiesFoMwxGLF+35iTB
   lqUOSj+lFybA9N43H2qv1gkoTW7N5s37EA+foGnn/HLGLggSbc938OSZw
   wqdSboV9Q3CSgR4Z39+XzZrk0ygjb5WTnaviu3EqxBMhWWuUKL+/xiAtH
   YUkTy2u2hC+y/q7IpkAf1qxENWemmhI+gmp5T22te2vjBDDzxRu9xqPwd
   3CBbfMl1RNf1xIwr4zulQwRGyAB21mwp1ciayF2CdV3oIfONIjPYYZAbY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="153723890"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; 
   d="scan'208";a="153723890"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 15:36:21 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2BC3FD9F01
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:18 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5DF1AD5610
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E80DD224950
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 783B21A006A;
	Fri, 29 Mar 2024 14:36:16 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com
Subject: [RFC PATCH v2 5/6] cxl: add definition for transaction types
Date: Fri, 29 Mar 2024 14:36:13 +0800
Message-Id: <20240329063614.362763-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28282.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28282.003
X-TMASE-Result: 10--4.520000-10.000000
X-TMASE-MatchedRID: NuUGwdOZh4ZkQckJEC3Q2tyBRU/cKn69F4r8H5YrEqxOeMm3G6m0Tb8F
	Hrw7frluf146W0iUu2tR9er5wo4xLchblrt58TvtqdwbW9Wx9tAv5vY1YvMqbuUlKuNFfcJqo8W
	MkQWv6iV3LAytsQR4e42j49Ftap9ExlblqLlYqXJt4l4q/wnikovCfpj71RK4UrGm7aSNDOJYJI
	xPFhImJcZoZKsx29ZV9DCWgDRvWseCgKQPezcuADwdpcMIVCZT+OYGlmIZze4RZbRsQk5MBUB1Q
	Pq9bxnWZkAxAwjIrrMHz/H0kiLyEqGAtHMDjkk9
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The transaction types are defined in General Media Event Record/DRAM Event
per CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43 and
Section 8.2.9.2.1.2; Table 8-44.  Add them for Event Record handler use.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 include/linux/cxl-event.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 03fa6d50d46f..0a50754fc330 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -23,6 +23,19 @@ struct cxl_event_generic {
 	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
 } __packed;
 
+/*
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+enum cxl_event_transaction_type {
+	CXL_EVENT_TRANSACTION_UNKNOWN = 0X00,
+	CXL_EVENT_TRANSACTION_READ,
+	CXL_EVENT_TRANSACTION_WRITE,
+	CXL_EVENT_TRANSACTION_SCAN_MEDIA,
+	CXL_EVENT_TRANSACTION_INJECT_POISON,
+	CXL_EVENT_TRANSACTION_MEDIA_SCRUB,
+	CXL_EVENT_TRANSACTION_MEDIA_MANAGEMENT,
+};
+
 /*
  * General Media Event Record
  * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
@@ -33,7 +46,7 @@ struct cxl_event_gen_media {
 	__le64 phys_addr;
 	u8 descriptor;
 	u8 type;
-	u8 transaction_type;
+	u8 transaction_type;	/* enum cxl_event_transaction_type */
 	u8 validity_flags[2];
 	u8 channel;
 	u8 rank;
@@ -52,7 +65,7 @@ struct cxl_event_dram {
 	__le64 phys_addr;
 	u8 descriptor;
 	u8 type;
-	u8 transaction_type;
+	u8 transaction_type;	/* enum cxl_event_transaction_type */
 	u8 validity_flags[2];
 	u8 channel;
 	u8 rank;
-- 
2.34.1

