Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2B21DA32
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717645993; cv=none; b=liy0dFCMvI4EJ/JhySiBHXBN/lXdePXCJypqQjrnFwBLh5qVaBoeaf6D6n3D0k3jBd7nj0eqJZi8TY4qWjawJWp9Gys1ZGLvHaSB/t1lG4Lpjk3IzgBk6HMVv4xaE2BlrywM2qvl2Q8BMsSGDpcJRxqUu6u9epfLbEwc6xfJeIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717645993; c=relaxed/simple;
	bh=pfwN24pMokjgAHOp1BB69eIt/t2Yel77P+50tad7Y+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eT2tMxIMovFituDKpKcGJAnP6Dh0pW8XDo+IS3B+Pq5Z/r7BjF9E8fmOBAlbtAjvRi3BVCHTUvCwmgAyFsWBHbc2XaQVEy2pARN5hQXWbjIZ/WKI1eTnQbtnTmG74rEAweGz5VVFwHhxW5vFVV0cS3r0qafmhiZ0Arq0BOqCXvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XIgG5/Qj; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XIgG5/Qj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717645992; x=1749181992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pfwN24pMokjgAHOp1BB69eIt/t2Yel77P+50tad7Y+A=;
  b=XIgG5/QjrPEcbdNSod8vuX+Hp8xhnoD1suZjw3LTq02QfFQINn8NFJPW
   DPgMRRrsyNQTCU4/R+Vl5lOLNFPNIWuKyJaEIbo8Qip3X0EbdGNsOzI47
   7t5/wYivKxI13fJ9g2eEOrD4VIx79SJTXn5nZlVP0ZPpLxnnrNvtpsXP6
   4lz3lG6t9NSr3CpUtPA+H0DgfVPSG8RDx1MTieDM0xpTmaLOi4vTwaRcl
   3HZRD+FvA3xmrt7H0aLR40GZJUo3YCIqPakvr9Hen7ZtG5UZmSDJ06JDc
   hpq65SdaVrZgoOQUVpgNbtGTYTv/3R8Jb2iAxztQuD2nNC3otSP+TverO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="162141539"
X-IronPort-AV: E=Sophos;i="6.08,218,1712588400"; 
   d="scan'208";a="162141539"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 12:52:00 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2CF08C68E5
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 12:51:58 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 78C44CFFA5
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 12:51:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id F230220081314
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 12:51:56 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 7424E1A000C;
	Thu,  6 Jun 2024 11:51:56 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: [ndctl PATCH v3 2/2] daxctl: Remove unused options in create-device usage message
Date: Thu,  6 Jun 2024 11:51:49 +0800
Message-Id: <20240606035149.1030610-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240606035149.1030610-1-lizhijian@fujitsu.com>
References: <20240606035149.1030610-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28434.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28434.004
X-TMASE-Result: 10-2.789500-10.000000
X-TMASE-MatchedRID: D7uj3L7FQ3IZHQl0dvECsQvBTB90+he+MVx/3ZYby78lTfGXXk+l8879
	PlJmAmXDoKHWBVnoJHPmn3xyPJAJoh2P280ZiGmROWUWxTQJdI8mLcCO64Exkpsoi2XrUn/J8m+
	hzBStansUGm4zriL0oQtuKBGekqUpnH7sbImOEBRFzth5Inra65DPQ/OWjuSi09eMkkde1DbbJi
	uAbwHBJyPzf07AeiJ8Q1mBwk8ucWczUbs4+5aCjfBsDwidnGiRczTonAH5/C2bDRBqS2n66yzP5
	xAyz9Oenvkw4sh/+PcMX5CwH5DTUmgGZNLBHGNe
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

RECONFIG_OPTIONS and ZONE_OPTIONS are not implemented for create-device
and they will be ignored by create-device. Remove them so that the usage
message is identical to the manual.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
  Collect reviewed-by tags.
  update subject # Aliso

V2: make the usage match the manual because the usage is wrong.
---
 daxctl/device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index 6ea91eb45315..dc166d593336 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -98,8 +98,6 @@ OPT_BOOLEAN('\0', "no-movable", &param.no_movable, \
 static const struct option create_options[] = {
 	BASE_OPTIONS(),
 	CREATE_OPTIONS(),
-	RECONFIG_OPTIONS(),
-	ZONE_OPTIONS(),
 	OPT_END(),
 };
 
-- 
2.29.2

