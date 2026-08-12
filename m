Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764DB2E7F20
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515040; cv=none; b=nxBTKiUfRF6eg5khfCnl5JZnq1a1wwyeYCkjido7/gjq8wHyCewr6Mi75lUTfGz9wyp/bUHCXlhTiiSW+ZytzlyQfgTOJvTIm2PyAhqCYlko4XCEbfD2qy3TP6pTjW8NpPsrnO3qBaFUrmsCAMT0TlzkqkNXw75ibi+X+K1klkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515040; c=relaxed/simple;
	bh=gS9I41+LuoViO4M39c+wVQYgs5rtMWkPbyJgVraNK6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4JDQzDvjAhWD5fvkGuFsH3Fw8EhawJrcQo66f03+r9TixT5t1zzUZ4QALZQQaMP6h9taHmGAIprJY1/s3pzZ6yIlyLPtX/J1GmwNw8OnfUotSclc1LBmjaSieh+h0IOsO3TvWwtejHzp91UwlkCpsov0p2J0hqGwVb/DBhPC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=unQV21JJ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="unQV21JJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786515028; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MAO/NY5Dg6PP4fOe3xLnTT2svj8ldv1vksAyCiuDMwo=;
	b=unQV21JJDoVR/I1slCvcO5tTrU1nzmEqCsWBrk0Q8FZDTs6EuLsR85/N3qXzzqIqkciB19Ru5E+C9DOhdC8e5ID3JBJ/h9Gt0+OY18NhAW9X5/Yu1dd+N/tGHNTFs1sM7PvepLwzYjVaV7WwICJxu8sZyxl+PTG/wZsNz82TLlY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8qdtsS_1786515027;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8qdtsS_1786515027 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 14:10:27 +0800
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
Subject: [PATCH v2] cxl/pci: Fix NULL pointer dereference in reset detection
Date: Wed, 12 Aug 2026 14:10:27 +0800
Message-ID: <20260812061027.57037-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__cxl_endpoint_decoder_reset_detected() samples the Committed bit of an
enabled endpoint decoder by reading the decoder control register at
cxlhdm->regs.hdm_decoder, without testing that pointer.
should_emulate_decoders(), the other consumer of the same field, does test
it, because the field is optional.

A memory device that exposes no component registers and describes its HDM
ranges through the CXL DVSEC range registers takes the early return in
devm_cxl_setup_hdm(), which leaves regs.hdm_decoder NULL and derives the
decoder count from the DVSEC ranges instead.
cxl_setup_hdm_decoder_from_dvsec() then publishes those emulated decoders
with CXL_DECODER_F_ENABLE set, and CXL_DECODER_F_ENABLE is the only filter
cxl_reset_done() applies when it walks the endpoint's decoders after an FLR
or an SBR. So on such a device every reset reaches the readl() with a NULL
base and oopses in the PCI reset completion path.

Report "no reset detected" when the endpoint has no HDM decoder registers,
as should_emulate_decoders() already does for the same condition. A range
described by the DVSEC registers has no Committed bit that a reset could
clear, so there is nothing for the post-reset warning to observe.

Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
This was patch 4/8 of the "cxl: Assorted fixes" series [1]. Per review
feedback that series is not being reworked as a whole; the fixes are resent
individually instead. Patches 1, 2 and 7 of the series are dropped, as those
issues are already fixed in cxl/next.

v1->v2:
- rebase onto cxl/next
- rewrite the commit message to describe the behaviour rather than narrate
  the code change (Alison Schofield)

[1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/

 drivers/cxl/core/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d807c1a002c..611175f29d24 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -685,6 +685,14 @@ static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
 
 	cxlhdm = dev_get_drvdata(&port->dev);
 	hdm = cxlhdm->regs.hdm_decoder;
+
+	/*
+	 * Devices that describe their HDM ranges with the DVSEC range
+	 * registers have no HDM decoder registers to consult.
+	 */
+	if (!hdm)
+		return 0;
+
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
 
 	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.7

