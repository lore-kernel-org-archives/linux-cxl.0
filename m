Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F33F8FB
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136033; cv=none; b=byulhVc2Yk5yN9trTxOnzclb3ZQlb4A52C5BAMAZuQo9i5aFGcYlbmKx7efq1AXjh68Tk5zEfRaSH6SGy5TRJC+JgOywnoIBZhJs3J57jAfokMERKCbDheRcLAxRNUUEc697XavEawwvvJorCSXxlgPsnOAaWtNAWlibUFR7bT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136033; c=relaxed/simple;
	bh=zOrG5nL7sj8c2PAFPO5ajZsnXzp1fBu9mcV/Tl5hyq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZoASk3U79qfycQ5+4OPRF2pKJgBehgz8lw6LgKmrk1ygitwYoBtRj5bqaO7qsxxvbA03lrq6TEL7dw95yFTD+Na3CI+7UHl00pSQJ5lsFfmR6EiSa+iZKFd+V54v7d997AKxaBSPPq2IlFMoNFxlm9CTUMnhyXSGVXElK8VJ9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CXQKd5sq; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CXQKd5sq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717136031; x=1748672031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zOrG5nL7sj8c2PAFPO5ajZsnXzp1fBu9mcV/Tl5hyq0=;
  b=CXQKd5sqVMB+reVsl2qjpAi0Z2tDstCyWkhgmXrSB72ZLxjcr3SqKZuu
   8TPu6aIYMj5SmLLQn45loXdgBy8VnwDX4oclv7moir8ZsYiHTXBS1iMi1
   YELJK2s60m3x0dq+bVZwgk6iwDF8EXxcsJliZM+exla+wp5RE4q6nvJTn
   QOT5S+BHp7AakfKn7N1TK2oyz9N5gU2Dvw4bHnvTRZ7fkhoMyFRwTzJ3t
   +AnpybZexgMiJJojYxitVBDVFg0vqTfAKmCmeFOc1AMCmCibp4nXuF0Qq
   BykLLw5gUZgQSe+wPFYwDQ9ZOoNGhpRKkV2BEYbR3vFrZkjvtdaJwIu9L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="162847267"
X-IronPort-AV: E=Sophos;i="6.08,203,1712588400"; 
   d="scan'208";a="162847267"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 15:13:41 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E0CB7D8063
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 15:13:38 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id D872BD7489
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 15:13:37 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 75F6F20094ADD
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 15:13:37 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id A2F1F1A000A;
	Fri, 31 May 2024 14:13:36 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: fan.ni@samsung.com,
	jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] cxl: Get rid of unused cfmw_list
Date: Fri, 31 May 2024 14:13:17 +0800
Message-Id: <20240531061317.865673-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28420.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28420.005
X-TMASE-Result: 10-7.221300-10.000000
X-TMASE-MatchedRID: HyBr+9HIEaxyeiFPOFIChC0UvD/exuSeT5ysQDj6eFmOVdQAiMmbZ87F
	l0igGfZUSUQWNWP9oCy12HagvbwDji/7QU2czuUNA9lly13c/gE/Ff5CERZ4s3wo4j2I0uMKo8W
	MkQWv6iV3LAytsQR4e1cppCzPq+1UsjvNV98mpPONH2f4xCl6E7zJzOMWskDwkj0HIfV2979fLF
	KMGcObee/1WebgI1lXy3hZ3qDjsrMOYyK1rEtv/gMwxaUMm86ivxp/Q03XTWw=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

There is no user for this member. All '-M cxl-fmw.N' options have
been parsed and saved to CXLState.fixed_windows.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/cxl/cxl-host.c    | 1 -
 include/hw/cxl/cxl.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index c5f5fcfd64d0..926d3d3da705 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -335,7 +335,6 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
     for (it = cfmw_list; it; it = it->next) {
         cxl_fixed_memory_window_config(state, it->value, errp);
     }
-    state->cfmw_list = cfmw_list;
 }
 
 void cxl_machine_init(Object *obj, CXLState *state)
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b686441..e3ecbef03872 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -43,7 +43,6 @@ typedef struct CXLState {
     MemoryRegion host_mr;
     unsigned int next_mr_idx;
     GList *fixed_windows;
-    CXLFixedMemoryWindowOptionsList *cfmw_list;
 } CXLState;
 
 struct CXLHost {
-- 
2.29.2

