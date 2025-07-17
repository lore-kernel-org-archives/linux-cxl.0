Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D533E1EA7C4;
	Thu, 17 Jul 2025 03:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752722059; cv=none; b=Xue3gT9HHt9+cqKOvxw6vbwVrRYtIK5nO5sSpe1l8tBGGAZOOiGnFIhAhsUs8gRgrCmPQg5PMYbRB1QOtVpMI73tDgHQJrA8R7kHeUdpAhcyNqDUXp9bAZ233gBZ819Y23YGWOuuQOmHQrQ/BayPnJfgbwsRhZr2dgUhJJokTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752722059; c=relaxed/simple;
	bh=HrO9HbcZaw+Yizcckt6SicAxm2AMunUDyxumEYtZkVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a7kdWNgF2UGgLstxWns3VKW9SMQU2rrISmwR1iWWdLjL0kWXjCIILtXww6U+rd9mHgEdAikdmFV/4vV2Zk/u9ipqalqqXpFcfowNqCe046bnSsUmZySS7rMTMx34e3S2emVJeGuDMiMKL3/D1w7AOvj8rtqT/M9HOiPOu4Xa11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=B4YJXtHv; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="B4YJXtHv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1752722058; x=1784258058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HrO9HbcZaw+Yizcckt6SicAxm2AMunUDyxumEYtZkVM=;
  b=B4YJXtHvj0rR7ifThL+k4hzQ/eWjQc41zu+CmBWdW5CQ/sMyy+tbf+C0
   /LMssEVPUel/6bI2EY7pmzM8cl11e8njeIe2BrEqmG4zRE2/2yGhl8WVb
   FouaImDVLsdp3elR/8kqdj4GkBRng+EI0tHKh9Wy/p3lS85+jfg878azF
   vWvFUOXmy42NKH04ABWls9PzQ5V29dHsk0ZqDqEEJHTKoVbws0nrd7gBf
   eeJqouDXfXzQ257YCWP+AsrLAxf/J/bkVBQIds5wQcFn128Hgc6dN0FWR
   G52Z4b/bFEek0f/TCjf4UZtTOLpJI4TZcWoh/u8yZ5BkV19/JXMjBWIbM
   Q==;
X-CSE-ConnectionGUID: D4Vd6AjFRSuHfsDzz4A2Jw==
X-CSE-MsgGUID: 93FTKPqeRe68f4ZDHP3xsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="193997250"
X-IronPort-AV: E=Sophos;i="6.16,317,1744038000"; 
   d="scan'208";a="193997250"
Received: from unknown (HELO az2nlsmgr3.o.css.fujitsu.com) ([20.61.8.234])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 12:13:07 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr3.o.css.fujitsu.com (Postfix) with ESMTPS id 66FCE1000372;
	Thu, 17 Jul 2025 03:13:07 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id C01E51C0015D;
	Thu, 17 Jul 2025 03:13:06 +0000 (UTC)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 81B621A0071;
	Thu, 17 Jul 2025 11:13:02 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next] cxl: Fix -Werror=return-type in cxl_decoder_detach()
Date: Thu, 17 Jul 2025 11:12:51 +0800
Message-ID: <20250717031251.1043825-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix following compiling errors:
In file included from ../drivers/cxl/core/pmu.c:10:
../drivers/cxl/core/core.h: In function ‘cxl_decoder_detach’:
../drivers/cxl/core/core.h:65:1: error: no return statement in function returning non-void [-Werror=return-type]
 }
 ^
cc1: some warnings being treated as errors
  CC [M]  drivers/nvdimm/claim.o
make[6]: *** [../scripts/Makefile.build:287: drivers/cxl/core/pmu.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  CC [M]  drivers/infiniband/core/verbs.o

Fixes: b3a88225519c ("cxl/region: Consolidate cxl_decoder_kill_region() and cxl_region_detach()")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
I'm curious why the LKP robot didn't report this.
---
 drivers/cxl/core/core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 705a5f09aa78..2669f251d677 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -62,6 +62,7 @@ static inline int cxl_decoder_detach(struct cxl_region *cxlr,
 				     struct cxl_endpoint_decoder *cxled,
 				     int pos, enum cxl_detach_mode mode)
 {
+	return 0;
 }
 static inline int cxl_region_init(void)
 {
-- 
2.41.0

