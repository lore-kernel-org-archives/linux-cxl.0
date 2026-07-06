Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22642E8F8
	for <linux-cxl@vger.kernel.org>; Mon,  6 Jul 2026 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377806; cv=none; b=ncVqIUMVdXt5iT4ZtGWkyXcbC0+ZC9bInZ5mDdOUj60WVzCIKg/xdu14N8vGi/6/htxfGlAm+LIyEvzGEtT2QE7NWbFgQez+lU5XsutLjkHkc4JuDhmg3+Kvfj/BjT4AVB9mnpXjPMq2E6V3rh40FB9dKh9ZIeC3NLpX42GoE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377806; c=relaxed/simple;
	bh=JY60vL28bqSSCs2Rw0tNr34El4dNFY6Rwoc8CnIDDuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WkPES755yw2YIycWFvmNmUH4Ox7eVB+8luxKQSTrBvsKDsd4p8bmob9sFAYHUBfphESLZ6Lj/VfCSwRG9F+skRrWXS7RyR15JVudGBFVy5NzN+jNfSpo8BDbNAiR2Zi00Q8HZnEKgmXz6xRi1aE1nGXlba2U/yKRrkBFPDNoaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725061F000E9;
	Mon,  6 Jul 2026 22:43:25 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	sashiko-bot@kernel.org
Subject: [PATCH v2] cxl/pci: Honor -EPROBE_DEFER from component register setup
Date: Mon,  6 Jul 2026 15:43:22 -0700
Message-ID: <20260706224322.714934-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_pci_setup_regs() for CXL_REGLOC_RBI_COMPONENT can return
-EPROBE_DEFER on a Restricted CXL Host (RCD) when the upstream port
has not yet been enumerated and the Component Registers must be
extracted from the RCRB. cxl_pci_probe() treats every non-zero return
from that call as the benign "component registers not found" case,
logs a warning, and continues. The rc is then immediately overwritten
by the subsequent cxl_pci_type3_init_mailbox() call, so the deferral
is silently swallowed.

Return -EPROBE_DEFER instead of continuing so the probe is retried
once the upstream port is available.

Fixes: 733b57f262b0 ("cxl/pci: Early setup RCH dport component registers from RCRB")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-cxl/ajzhsubot_PSYtHQ@MWDK4CY14F/T/#m063bbf76b1c9c293ade52ab311018ae6bba11a44
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 267c679b0b3c..6a132a6c4c5b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -829,10 +829,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 */
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
 				&cxlds->reg_map);
-	if (rc)
+	if (rc) {
+		if (rc == -EPROBE_DEFER)
+			return rc;
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
-	else if (!cxlds->reg_map.component_map.ras.valid)
+	} else if (!cxlds->reg_map.component_map.ras.valid) {
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
+	}
 
 	rc = cxl_pci_type3_init_mailbox(cxlds);
 	if (rc)

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.54.0

