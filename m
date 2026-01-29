Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEF727C866;
	Thu, 29 Jan 2026 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769669167; cv=none; b=idHQJfp99b1cdt0s+G2Cdz9sCv1qO3/XaeKCBIdqXPHSIpalhzKJXCB14Rz91dQ7BRgD+GyCZ6LsUfJ0o4nJ3tF3GJB93iPrsumKEN5fzfAe1AMmGDjDuVwU2ou3bCxDXAHgtKFoBWOzsOVdFzC6BD7pYl+esPKOi5od8+GueMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769669167; c=relaxed/simple;
	bh=q7Jqz03krzY7JyNNKby1vqH28mFVqMWBem8YjOmv7fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXFqN0MEQd7hTwhUK+VuikUN+hWRUBFk9+3jss8B8JlxSvqyLgoyzUp4U5VdGzhXWkSS33ck42M0bnIIBV6mtehtw4Mo7WTUE4ciQW4E2CQUVpqeDfp6to2dyyimfXNwXFUP0j1yR2Y0hklhIFYd3o83flB5TDfE9Vk/APOCzwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pAAKlBfG; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pAAKlBfG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769669154; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=aoCd4ph40Eq+tTvf93omCSylUeG/I5R/94HVLL/cqx4=;
	b=pAAKlBfGfk1ErkZrmwzUuj41Fo1dnKG3azNbhRjJPFtSY1LhUI89FCBsv7VnEy1Zffoakkn4yp1cSEscry2coVDQ98jnyeaPg59vW0HRpnFvL8kphs7UQ0nuM13dWSWrU7wlFlMBDP1MosqG94AiqEf9nGftSHbps2qIyttDtkI=
Received: from localhost.localdomain(mailfrom:yuxiong.wang@linux.alibaba.com fp:SMTPD_---0Wy6MoUu_1769669153 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Jan 2026 14:45:53 +0800
From: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: ming.li@zohomail.com,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuxiong Wang <yuxiong.wang@linux.alibaba.com>,
	Huang Ying <ying.huang@linux.alibaba.com>
Subject: [PATCH] cxl: Fix premature commit_end increment on decoder commit failure
Date: Thu, 29 Jan 2026 14:45:52 +0800
Message-ID: <20260129064552.31180-1-yuxiong.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cxl_decoder_commit(), commit_end is incremented before verifying whether the
commit succeeded, and the CXL_DECODER_F_ENABLE bit in cxld->flags is only set
after a successful commit. As a result, if the commit fails, commit_end has been
incremented and cxld->reset() has no effect since the flag is not set, so commit_end
remains incorrectly incremented. The inconsistency between commit_end and
CXL_DECODER_F_ENABLE causes failure during subsequent either commit or reset
operations.

Fix this by incrementing commit_end only after confirming the commit succeeded.
Also, remove the ineffective cxld->reset() call. According to CXL 3.2 Spec 8.2.4.20.12
Committing Decoder Programming, since cxld_await_commit() has cleared the decoder
commit bit on failure, no additional reset is required.

Fixes: 176baef ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
Acked-by: Huang Ying <ying.huang@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
Change log:
 * Added CXL 3.2 Spec 8.2.4.20.12 Committing Decoder Programming statement. Thanks
   Alison.
 * Collected reviewed-by. Thanks Dave and Alison.
RFC Link: https://lore.kernel.org/linux-cxl/aXqKC-bscufh1ggq@aschofie-mobl2.lan/
---
 drivers/cxl/core/hdm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index eb5a3a7640c6..912f648a6b7a 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -844,14 +844,13 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
 		setup_hw_decoder(cxld, hdm);
 
-	port->commit_end++;
 	rc = cxld_await_commit(hdm, cxld->id);
 	if (rc) {
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
-		cxld->reset(cxld);
 		return rc;
 	}
+	port->commit_end++;
 	cxld->flags |= CXL_DECODER_F_ENABLE;
 
 	return 0;
-- 
2.50.1 (Apple Git-155)

