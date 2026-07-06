Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727B435A9D
	for <linux-cxl@vger.kernel.org>; Mon,  6 Jul 2026 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377063; cv=none; b=uXBZ2ynhla0OEcpN5pJ7vIIOCvGoBek6DSEWlzRwtgx8TTKXnWWlbX5xvD5XjDTUatdVfXjzUQcdtpk7GS+jfx9yX/UrcHxTzgrKrHUV9nPY4dG9jB0J/f5N01q9rRkiCipU3IwZ0BlYSduU+teVsGm5ZPiaeYFpJ8l4YANCWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377063; c=relaxed/simple;
	bh=rWMfI3y7vm7nsAXjzuJlMH0ZG0EnqyiJ7mqNW1Pejw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3AfEdZyqP49ISn6olIjoBP7Sml9xH+54y+7+kyqHlzn2cSfw7S8JUR88gFV9C+0D81YMg9FAjvk1Prd1G9B4AU5ev4HBc8HHyIs15l9KsF4r2TKxtpEyI5rQkqKTgTniphA4FbcJiV5Ttg5a7Mpnlj7bfptY99GohID2waHIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2853C1F000E9;
	Mon,  6 Jul 2026 22:31:02 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	sashiko-bot@kernel.org
Subject: [PATCH] cxl/pci: Honor -EPROBE_DEFER from component register setup
Date: Mon,  6 Jul 2026 15:30:59 -0700
Message-ID: <20260706223059.693499-1-dave.jiang@intel.com>
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

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-cxl/ajzhsubot_PSYtHQ@MWDK4CY14F/T/#m063bbf76b1c9c293ade52ab311018ae6bba11a44
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 267c679b0b3c..c85aa790ff6e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -826,9 +826,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	/*
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
+	 * A deferral request must still be honored, otherwise the component
+	 * and RAS registers are never mapped for the life of the binding.
 	 */
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
 				&cxlds->reg_map);
+	if (rc == -EPROBE_DEFER)
+		return rc;
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 	else if (!cxlds->reg_map.component_map.ras.valid)

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.54.0

