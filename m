Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54B3BBCE
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694254; cv=none; b=dp/Glxvi9fD2pGxZd/KsU+ZjgnrBSLAt3S3C3Akyv0EKlrlF+cM4XG2FB+tV60OahYnlvzr662Xh0H/jUirU4ZKGZDL3lNCoYt4aX2e3eAFufRxnRTQ5f7XipqK4V1+goQ59JkqrrClQOnGhqeE2TIL2Q/FzjhcUUcAZ71viy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694254; c=relaxed/simple;
	bh=Om0rTA9WbsSAo7t6tlUEm6jtC04fsfKD+Idi78A3PwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gK0dTGwGjuUj4NSISJUUCQ/GCTWp9oTzZTD0xo6R0iDZIiPUBEGs2iKUvAoLCukDR23PP/hbQvT81t7Z3IMi+nx+YXvlr0qUxOTXMdFx7xjaKxJ8CevP5dDagrpVXPtCvCDEZotaw9bnmCOnWKAejjeT2sIIAXB2FiNFpxg4S28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=oJ6eQja+; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="oJ6eQja+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1711694252; x=1743230252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Om0rTA9WbsSAo7t6tlUEm6jtC04fsfKD+Idi78A3PwY=;
  b=oJ6eQja+++8WusJ6gRaasAyD5ewRDKe1/YcXaVzisfEG5k8Lgu90xtb7
   LcfklFIvWWTW/vESJSBb8MtfmdrOQxKqiB5sarIzsvg71Wvh/SbFtYGCj
   zKWlkuRaisZCJt+jgLkjKZbGodFLRNKmAeA+dIaaoqF5qF2JsRAW8yhLT
   2YyQiCHD9g2E6ndmAfLl1ATaw5y8woW/rCJ1qpwsKkoRpQYyQ9Wi5R/Nj
   mhlT/PXUG2RNtszWIXiiCQyn2wht52u2vkqXbxctxtVY4ww+ZOdXK2S+L
   BaZ4OKg41je/NEzJ8n3UuzgG7qZN1Iw1Jj9pgl9D0cgVJl08kS4FK0F2s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="153723889"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; 
   d="scan'208";a="153723889"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 15:36:20 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id BD0A5E966B
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:17 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id E9F77D5EAF
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7ED19200A80C1
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 24B0C1A006D;
	Fri, 29 Mar 2024 14:36:16 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com
Subject: [RFC PATCH v2 4/6] cxl/core: report poison when injecting from debugfs
Date: Fri, 29 Mar 2024 14:36:12 +0800
Message-Id: <20240329063614.362763-5-ruansy.fnst@fujitsu.com>
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
X-TMASE-Result: 10--1.096700-10.000000
X-TMASE-MatchedRID: It5tpevY7hTR6RKL7TRTbhF4zyLyne+ATJDl9FKHbrnLBiiIoKf6r6PF
	jJEFr+olKE0Je8DR/D4NXwNUB3oA790H8LFZNFG76sBnwpOylLOGGOXsAst2EY71S6fa2jIEbbi
	ume7ndEjAl7InEAdrZfsQLJr4C1gANHYsYoI80lgKm9Bb+04k3Mw0hF8jARVgyLf0xPiHr9ghya
	dlGFXHKsTgfCdKUS4cicSkmYsAV+kLUU1zqiphVX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Poison injection from debugfs is silent too.  Add calling
cxl_mem_report_poison() to make it able to do memory_failure().

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/memdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index e976141ca4a9..b0dcbe6f1004 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -366,6 +366,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
+	cxl_mem_report_poison(cxlmd, cxlr, &record);
 out:
 	up_read(&cxl_dpa_rwsem);
 	up_read(&cxl_region_rwsem);
-- 
2.34.1

