Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790FD26D4DF;
	Tue, 27 Jan 2026 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503747; cv=none; b=hT18LPyAmsk8eeLOYd3Hk8rmyPwMr0SwnR2+uq4knLYrnourIlQytQyAgukMsCasHBXGy6j0x7ldPEbbDACU4OQVXIdtyZ2OehGciVoD2l9uP9q6rn5P0ocTE7V2TVml1IzbbeKXNaSHMSMaXcoFW6ESz7yWn678fjvogWQxx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503747; c=relaxed/simple;
	bh=h5f1N7/akgl+MhfNYChrwhCdsgTpfKHmua+eRyf7pe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCZMJHzbAzW1c+niowtM7w5CMKrAGAUxiB1aM3mJvsGCxSUobxnGUvwMUzqHmcOsyxyTrEwK2kXqSQsuHjOjyHxIvKl3D02Lr+Ws5piu63+blCcTyhIMHAUgVOr45U4Uy7Hlh3eeJm6GPyZ2CzjC+c/YgnL6a2t6ZE5XANT9UuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i9XuR2J0; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i9XuR2J0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769503737; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Yym78sDxqn+8d70EAUdSPpqJaOkddqt0YFrR1rykp5w=;
	b=i9XuR2J0w2rPMc8aUP9VPTMSc7pdHeWY1UJSeOv5AolTjnw4vMNjCB1XWL45TugLZHBSvp9l0wnRHl2OYbeZOczVeagK2MSzTwFcYTBOgFeMyUXA4VgX4heVhSP9u1JUWKYUL0kN12OmJ3HmPEaXP0VEL6+1BZV5P1Q90ilR2Dk=
Received: from localhost.localdomain(mailfrom:yuxiong.wang@linux.alibaba.com fp:SMTPD_---0Wy.E9kM_1769503735 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Jan 2026 16:48:56 +0800
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
Subject: [RFC PATCH] cxl: Fix premature commit_end increment on decoder commit failure
Date: Tue, 27 Jan 2026 16:48:55 +0800
Message-ID: <20260127084855.66916-1-yuxiong.wang@linux.alibaba.com>
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
Since cxld_await_commit() clears the decoder commit bit on failure, no additional
reset is required. Remove the ineffective cxld->reset() call in this case.

Fixes: 176baef ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
Acked-by: Huang Ying <ying.huang@linux.alibaba.com>
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

