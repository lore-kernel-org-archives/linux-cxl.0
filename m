Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4E3D73
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278240; cv=none; b=mc51JBUsGWHQtE+qAwYE7GYY00Y6mQNg/QhRg3UreMJFvpfmC9MlDB0RBxt6qd9F40qAfeaT0907HWPYkA7vpfB3v98wl0fqDe3qJwG34jH0HLV/JrbFfKEBQXtpUqGcro6dwxz7Ysbi3raATrk/cv8P6JAHldA2IiwMieExjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278240; c=relaxed/simple;
	bh=//HZSYsS8NCRx6hJPQZoR46ECWuqro5AGFrI9bFHGQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tU2MXYT7BOjJYNlU2hP0z2C8HPKRQewJ7TvBCCMyVDmU7Zh+ifzuToxGlcnK6SKuJzaMr75qGYOuH5o4klmt3ljpXUIl+fhLgjv6kOJKb5os7vhElc/UB7xTc74wKOFaVW3B5XsRLg+t4z5qFCJna6i7yOYyoHoxvbda7E32Tsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nL9whKyi; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nL9whKyi"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787278235; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NHG5YdmJ2dcGprHB0YDqGjHjWCoPt14wH91ES84USa8=;
	b=nL9whKyiSmyt2IPewrypglhMxtoscZ10ThplEiPCPm/l0/H1T0qp++VBwQ9DHUE7fUCyEnagaQiKxnLVEcKuZe7NhB3OhSeUukvARJf7jrF6oix9qKyQrpnHB2eIY0MIOYChbHLI4Q5FYX6v5AbPTsczVVvxHxWC/7ZBkTcvEvg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X9KlFhV_1787278234;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9KlFhV_1787278234 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 10:10:34 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4] cxl/pci: Skip reset detection for DVSEC emulated decoders
Date: Fri, 21 Aug 2026 10:10:29 +0800
Message-ID: <20260821021029.2550584-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After an FLR or SBR, __cxl_endpoint_decoder_reset_detected() samples the
Committed bit at cxlhdm->regs.hdm_decoder for every decoder that has
CXL_DECODER_F_ENABLE set. Decoders emulated from the CXL DVSEC range
registers carry that flag too, but their state does not live in the HDM
decoder registers. When the component registers expose no HDM decoder
capability, regs.hdm_decoder is NULL and the readl() oopses in the reset
completion path. When the capability is present but firmware left
Mem_Enable set with the global HDM decoder enable clear, the Committed bit
reads zero and cxl_reset_done() reports a reset that never happened: it
taints the kernel and strips CXL_DECODER_F_ENABLE and CXL_DECODER_F_LOCK
from every endpoint decoder, even though the driver still cannot reprogram
the DVSEC ranges.

Skip the check when cxld->commit is NULL. Only
cxl_setup_hdm_decoder_from_dvsec() leaves that callback unset, so that one
test covers both emulation paths, and a DVSEC-described range has no
Committed bit for a reset to clear.

Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
This was patch 4/8 of the "cxl: Assorted fixes" series [1], resent
individually per review feedback.

The two synchronisation concerns the review bot raised on v2 - the missing
exclusion against a cxl_port unbind freeing the devm allocated cxl_hdm, and
the plain read-modify-write of cxld->flags in
cxl_endpoint_decoder_clear_reset_flags() while the region paths update the
same word under cxl_rwsem.region - are still untouched here. Both are
about the reset handler's locking rather than about which registers it
reads, and neither fix is local; happy to follow up with separate patches.

v1->v2:
- rebase onto cxl/next
- rewrite the commit message to describe the behaviour rather than narrate
  the code change (Alison Schofield)

v2->v3:
- test cxld->commit instead of cxlhdm->regs.hdm_decoder, so that decoders
  emulated from the DVSEC ranges are also skipped when the HDM decoder
  registers exist but are globally disabled (Richard Cheng)
- update the subject and the commit message for the widened scope

v3->v4:
- shorten the commit message (Dave Jiang)

[1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/

 drivers/cxl/core/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d807c1a002c..d8b07f86bab0 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -683,6 +683,13 @@ static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
 	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
+	/*
+	 * Decoders emulated from the DVSEC range registers have no commit
+	 * callback and no HDM decoder registers to consult.
+	 */
+	if (!cxld->commit)
+		return 0;
+
 	cxlhdm = dev_get_drvdata(&port->dev);
 	hdm = cxlhdm->regs.hdm_decoder;
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.7

