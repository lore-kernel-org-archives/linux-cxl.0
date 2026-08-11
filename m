Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33939E177
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448185; cv=none; b=vAGOnRgyz/ljcgXb2DhYq6RsCmt7xq00+Lqit5DRVJMj+Ncv6HZTMpHmAMSpWHm36mae6t9EjW3vhBO2NBWNwYvQ1W67tluEpo6lQz7M1UHyBdQQY1Wgz6a4Hy1Ft10yfGgiBLPTt19bTunVEPA/c9M1DqpfYdhF4dvUJyuKc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448185; c=relaxed/simple;
	bh=gJUMtt5Cs27gdt3j/Z6OWH9rMG1CWpXm39xno4yOTN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAAMozw8g+Rf3uhRaVcPlVsqgYt48yeSfyBuhKmfK2HfcslLmGsLnFb5R8jRIo9Y4C4dBAQpVKEY0vTXOUXZ3PfHYJuey580ACrwGPx2lXS0vSEULmrQWtOPBCjyH8M7Fs2POOMGMyzhPQ44UfhnFODDpEq97LeQJA6nfk16FDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E5PvOCCC; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E5PvOCCC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786448179; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=o4C0fRkLjZ1d20A8vx7yv8Z5cLe4fNmymlfjVRTLRqI=;
	b=E5PvOCCCNSqU16RLTpByBaw6YMvNqxs84d7JvTe+GelVvWbnl8GONYp+LaWgpjCw2jyJGAIm+cSnAkbgpd8ZNY2SfsxXLwBaUvC+V7AkeL/3Nkge0DWCv/I9IyqerQC9VWPeFqf2ceqYxU26NGOGd40sQc2G4ckBVuOar3/3lcQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8oKJ-6_1786448178;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8oKJ-6_1786448178 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 19:36:19 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH 4/8] cxl/pci: Fix NULL pointer dereference in reset detection
Date: Tue, 11 Aug 2026 19:36:04 +0800
Message-ID: <20260811113608.2815625-5-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260811113608.2815625-1-kanie@linux.alibaba.com>
References: <20260811113608.2815625-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__cxl_endpoint_decoder_reset_detected() reads the HDM decoder control
register without checking that the endpoint has any:

	cxlhdm = dev_get_drvdata(&port->dev);
	hdm = cxlhdm->regs.hdm_decoder;
	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));

For a device that has no component registers and describes its HDM ranges
through the CXL DVSEC range registers instead, devm_cxl_setup_hdm() returns
early with cxlhdm->regs.hdm_decoder left NULL and the decoder count taken
from the DVSEC ranges. Those emulated decoders are published with
CXL_DECODER_F_ENABLE set by cxl_setup_hdm_decoder_from_dvsec(), so
cxl_reset_done() walking the endpoint's decoders after an FLR or SBR
reaches the readl() with a NULL base and oopses.

Bail out when there are no HDM decoder registers, mirroring the existing
!hdm test in should_emulate_decoders(). Without those registers there is no
Committed bit to sample, so report "no reset detected" rather than
dereferencing NULL.

Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e4338fd7e01b..2515ef4282f2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -684,6 +684,14 @@ static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
 
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
-- 
2.43.7

