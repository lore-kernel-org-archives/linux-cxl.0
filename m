Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A2E19D8A5
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718335316; cv=none; b=n/A/U73YTzW+oR1WzVKWpE3VKfejF5/Wi6jiV0j9JFjT0L/UdO2K9P6lOvYP9eyCW1VjGN4Hhr4M7j+ho+dREOq04Tgg9QzMNXHyrz/FCiZoHhE5PkTrRU7uxAwELqUQb6aPYeHUCO3oo2W/DSPaq9GHp1pXYZfiw73qy9gYC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718335316; c=relaxed/simple;
	bh=ZG89C/2X2Hlp6o+DUmuZGpRDCEHwQpkP7MdmD8lx9xI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBl/3/xmQA2BnHwysE4tAcMDQKR7wLDk7L2KnSXoPWSWYhrs8CgZ460f+34epliTPCgVfGHXpoh9HJEAsUM5ZlldMVLs2NLOatmMkF6Jvpr9lUV7slpvcHRPOpXJQtFuViDXvMhQ6fmcM5yMsknU8Hg5PIMU4qFuUgV/4bu28Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=mJtcJykZ; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="mJtcJykZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718335314; x=1749871314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZG89C/2X2Hlp6o+DUmuZGpRDCEHwQpkP7MdmD8lx9xI=;
  b=mJtcJykZfD0uVX528/8PWCl3yS0bbqZiP0b1W0FyNL3BdyzqsukNVmif
   lf+YWWU4gTKeu7+1wp3f+Yr4ebU9qh+B5FjQ/X9VxCDTFxNss2/RmStvf
   1zKl1HkWfVtduqrhcVW5I9WE23l8TF/hyvx1B5nYjdAKyqCscG+C/4UeP
   u3+Ax8Lo/M+ql2lxkqb15nTAvq5ROcOwav79juOGjPtFq6kX0mlANFvpR
   nxmfEQIu1jaflK7uR5fmEq+5voyOatWnqCw5V1LOS/NJa3LMvpKtRTl6W
   162LYU7jUduqJ8jAFAWG2UcyE82Vvh97anxX98eJUSgElaQ0bR+1np7H/
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="163206075"
X-IronPort-AV: E=Sophos;i="6.08,236,1712588400"; 
   d="scan'208";a="163206075"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 12:21:45 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 31AA2C9168
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 12:21:43 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6C0E6D976A
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 12:21:42 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E5200E51A4
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 12:21:41 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 411D71A0002;
	Fri, 14 Jun 2024 11:21:41 +0800 (CST)
From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	jim.harris@samsung.com
Cc: linux-cxl@vger.kernel.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v8 3/3] cxl_test: fix the 'create region failed' error
Date: Thu, 13 Jun 2024 23:21:33 -0400
Message-Id: <20240614032133.45365-4-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240614032133.45365-1-yaoxt.fnst@fujitsu.com>
References: <20240614032133.45365-1-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28452.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28452.004
X-TMASE-Result: 10--4.075300-10.000000
X-TMASE-MatchedRID: c0O9f5VVZtaROBVNmXUDuKqHmm/V4M/PNYh6DLllTEUBLwIiWDU8a78F
	Hrw7frluf146W0iUu2sd33EAFlDlnTuBsKLHO7oUGYJhRh6ssev0swHSFcVJ6JGj3muQFIZTo8W
	MkQWv6iV3LAytsQR4e1cppCzPq+1UxlblqLlYqXJERfsGWgpzrZyLlW9SKeXT7XF+vGGbtBIW0+
	n9FqqeDRWSbUxeHenvnQVgeyW9a1R+09idj0tY/lahq/U+abNCiaXNjIos8GcRZbRsQk5MBUB1Q
	Pq9bxnWZkAxAwjIrrMHz/H0kiLyEqGAtHMDjkk9
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Since the interleave capability check is supported, the cxl_test will
fail.
Support any and all possibilities for the mock cxl device (host bridge,
switch, cxl_mem .etc).

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 tools/testing/cxl/test/cxl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 61c69297e797..fbebcda4364c 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -630,11 +630,15 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port,
 					  struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm = devm_kzalloc(&port->dev, sizeof(*cxlhdm), GFP_KERNEL);
+	struct device *dev = &port->dev;
 
 	if (!cxlhdm)
 		return ERR_PTR(-ENOMEM);
 
 	cxlhdm->port = port;
+	cxlhdm->interleave_mask = ~0U;
+	cxlhdm->iw_cap_mask = ~0UL;
+	dev_set_drvdata(dev, cxlhdm);
 	return cxlhdm;
 }
 
-- 
2.37.3

