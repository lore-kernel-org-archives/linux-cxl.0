Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E11381B9
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594346; cv=none; b=ZHr4jVQUbRN3four0QuPypzgnX7uwErGemFPej3sDKQkdHTkhefrCWXUsG1f2Q5ukRiutbmqIlNuvjSKkaGD16deGHFHFw5CC+uNn6AG9cWGODlnHSqTa83tLwXfgjqLEY2nlvwPtilrOVACUDBjkFXm2NT9u1i02AnSXhEL10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594346; c=relaxed/simple;
	bh=Y6va72XvL+G6mUO7VSgGinf5Y4gN+W/rwGMZbcx/Jbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZX2L4sBGVakqkHDXYdEC+X3PmguKSplwdj8h12mFh7tzCw3icoXKU9bk8fIcdyzFtJl6l4vYRuBkmkTA6VyWbxo7R1X3qcUxYL4+5FmcRvLyFP9QN5vtYVomwIc2lJvfclmHddlPlasYeJ0wy6NGL5Rjoe8N6X4e0USPTCW8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=VNED6B63; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="VNED6B63"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706594343; x=1738130343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y6va72XvL+G6mUO7VSgGinf5Y4gN+W/rwGMZbcx/Jbk=;
  b=VNED6B63PkQB+F7Ed97FXWiiyMRuUxeR0kK+pRvUzHmGWHNOXa0jsLpl
   wS2nK9iaM/NA9SVgAKpk0Pvm28n64VEnLusEll8Ee7V5hb5T5GKDpx8+5
   SiG04GXM4prombtPhR11azZ9yWASdfIKhEmqXjutNtdi9e+Rvo/L22LW5
   MSxAKbgKZCmcLKfAuxRZLw6IS45B5Jrpp3/bX6k6x5hZAIck1advFFVw7
   xYOytn9c5kZp1YnDrPvlA7Of3fCuw1dAWoNRNPH2zuPpj8NNd7IInjlqj
   nSWdfKbl1hDWkgXAlw8xDOLRz1/72SYarWxEAVQFj69gZ5EUru2jUgjMZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="127053948"
X-IronPort-AV: E=Sophos;i="6.05,707,1701097200"; 
   d="scan'208";a="127053948"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:58:53 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E9023331A4
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 14:58:51 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1E498D4F5B
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 14:58:51 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id AA9BEE207A
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 14:58:50 +0900 (JST)
Received: from Fedora-38-3.g08.fujitsu.local (unknown [10.167.220.145])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 34A1E1A006A;
	Tue, 30 Jan 2024 13:58:50 +0800 (CST)
From: Quanquan Cao <caoqq@fujitsu.com>
To: dave.jiang@intel.com,
	vishal.l.verma@intel.com
Cc: linux-cxl@vger.kernel.org,
	Quanquan Cao <caoqq@fujitsu.com>
Subject: [PATCH] cxl/mbox: Code readability improvement
Date: Tue, 30 Jan 2024 13:58:44 +0800
Message-ID: <20240130055844.19811-1-caoqq@fujitsu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28150.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28150.004
X-TMASE-Result: 10--2.023800-10.000000
X-TMASE-MatchedRID: pJz6LQcw6+P1QAnohbAHMtZfgYyzPJbKwTlc9CcHMZerwqxtE531VIPc
	XuILVCbasMSLRTPBLMswxMrHy3hJ7h8TzIzimOwPlpYqKNmWxsHZs3HUcS/scCq2rl3dzGQ1exo
	9wuDn6iaf/9CSUQzCpbEzvZ7Iw+XhamBJVkgt54gHW/zDykAKHUb9DSiO61Fy8wXJyom6MbB9h6
	HRCIrRgmgBQY/mlrhdhLvAid2uj0YVxRB/din+uJ07T8ZSLiAVvR84/OmB1wQp4n8eQBnwiw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

"send_cmd->id == 0" indicates an invalid command, so replace 0
to CXL_MEM_COMMAND_ID_INVALID to make it easy for reading/understanding.

Signed-off-by: Quanquan Cao <caoqq@fujitsu.com>
---
 drivers/cxl/core/mbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 27166a411705..2e5ee05011d6 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -485,7 +485,8 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 	struct cxl_mem_command mem_cmd;
 	int rc;
 
-	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
+	if (send_cmd->id == CXL_MEM_COMMAND_ID_INVALID ||
+	    send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
 		return -ENOTTY;
 
 	/*
-- 
2.43.0

