Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75B34889F;
	Fri, 17 Jul 2026 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305017; cv=none; b=sDZwyGoaJgrZA16daANTqlM1MEURY2+9e0s+HYCX/rbWoz82mtsgA3l4YgtB0JnZZYgoZQnIjPm9O5V7CDi70axRF+QN9Pt1hzkpDuYjGSL3EfbkUoqk4W4t7mxbw0jn+BhPEwn3M5x13T/wHlVmaOIWoFjwojvV9I3AENQkDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305017; c=relaxed/simple;
	bh=wXXoetZYNlp6MjeZm8DNhaJcT5SeeaiTmoWAZrE5yLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlPgGwZy7DPLubt0RCsVF8fQVfQGvdGRkAvyBsPcghdD14TFJvjw7STi8kzLVwEmrmxkmRsVWyNPSsW3zbF7w/UIIx0ATq2MYj1QGobrq7oO2jTMm8f+QvttfOeokZULdEczJjBxYmhFerCwYs3jH7G4InH8Cj14RLorFyC3zdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D40F1F000E9;
	Fri, 17 Jul 2026 16:16:55 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	terry.bowman@amd.com,
	sashiko-bot@kernel.org
Subject: [PATCH v3 04/10] ACPI: extlog: Avoid populating software AER metadata from raw hardware buffer
Date: Fri, 17 Jul 2026 09:16:41 -0700
Message-ID: <20260717161647.1493259-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717161647.1493259-1-dave.jiang@intel.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko-bot flagged that casting the raw aer_info buffer fills
software-only AER metadata with hardware data, driving an out-of-bounds
read.

extlog_print_pcie() casts pcie_err->aer_info directly to struct
aer_capability_regs *. That struct embeds struct pcie_tlp_log, whose
software-only header_len and flit fields sit at offset 84, within the
96-byte aer_info buffer, so the cast fills them with raw hardware data.
pcie_print_tlp_log() uses flit and header_len to bound a loop over the
dw[] array, so a large header_len walks past its end.

Copy aer_info into a zeroed local struct aer_capability_regs and clear
header_len and flit before passing it on.

Reported-by: sashiko-bot@kernel.org
Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/acpi_extlog.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 06a944dadbc1..fbc88c584c06 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -137,6 +137,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 			      int severity)
 {
 #ifdef ACPI_APEI_PCIEAER
+	struct aer_capability_regs aer_regs = {};
 	struct aer_capability_regs *aer;
 	struct pci_dev *pdev;
 	unsigned int devfn;
@@ -149,7 +150,12 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 		return;
 
 	aer_severity = cper_severity_to_aer(severity);
-	aer = (struct aer_capability_regs *)pcie_err->aer_info;
+
+	memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
+	aer_regs.header_log.header_len = 0;
+	aer_regs.header_log.flit = false;
+	aer = &aer_regs;
+
 	domain = pcie_err->device_id.segment;
 	bus = pcie_err->device_id.bus;
 	devfn = PCI_DEVFN(pcie_err->device_id.device,
-- 
2.55.0

