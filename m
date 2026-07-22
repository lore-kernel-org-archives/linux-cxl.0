Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6436EAA8
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753591; cv=none; b=BsTxlhyOrFmgfHUsCDLR0LGGDE+V7qUBcdWgh+sYpM4S0QgCf0kuH9uWi3SblKL4Y1NPIJ3jEgp4M1o0FTQUXBhsfDhw/TvO70kst/MXUAkSbNdCS6c2o2nHxyGH+Jg/iAkaOS+mVrR03+VUBppfk1j2ruX+4X7gc5seqIMLduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753591; c=relaxed/simple;
	bh=7/8I9Odjy+zgltxERz8cK9zg/sdnw6bGsANMQ744CS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuuCr4bvtfwQw3BSkueyS0yN6n+Oh0aFHJn8X7uQQyHBAxOW7EsWGuXgqC182gUC9qP14xiwbEkw2CpszlSV865VrlAu/7ncH24yStgcmZakdsWKXKtUuNBuX3Ig2v++Cogd9zVA5vA8v61n297ZgspAu2lKeX4dRJdr6b2D+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2643E1F00A3A;
	Wed, 22 Jul 2026 20:53:10 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	sashiko-bot@kernel.org
Subject: [PATCH 2/3] cxl/ras: Clear software-only TLP log fields after RCH AER copy
Date: Wed, 22 Jul 2026 13:53:01 -0700
Message-ID: <20260722205303.3184787-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722205303.3184787-1-dave.jiang@intel.com>
References: <20260722205303.3184787-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_rch_get_aer_info() copies the AER capability from MMIO into struct
aer_capability_regs by dword. That struct embeds struct pcie_tlp_log,
whose software-only header_len and flit fields sit past the hardware
registers, so the raw copy fills them with garbage. pcie_print_tlp_log()
then walks dw[] up to header_len (a u8, up to 255) over a 14-entry
array, reading off the stack and leaking it into the error log.

Reset header_len and flit after the copy so only the standard header is
walked.

Fixes: 7e077e6707b3 ("PCI/ERR: Handle TLP Log in Flit mode")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260717222706.3540281-1-terry.bowman@amd.com?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/ras_rch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 0a8b3b9b6388..a847727686df 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -69,6 +69,13 @@ static bool cxl_rch_get_aer_info(void __iomem *aer_base,
 	for (n = 0; n < read_cnt; n++)
 		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
 
+	/*
+	 * header_len and flit are software-only metadata in struct
+	 * pcie_tlp_log; Clear to remove garbage register contents.
+	 */
+	aer_regs->header_log.header_len = 0;
+	aer_regs->header_log.flit = false;
+
 	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
 	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
 
-- 
2.55.0

