Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BAE37C0FD;
	Mon, 24 Aug 2026 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593787; cv=none; b=hZ2yc82ytS3FTSGGErIDtwNNd4eL6CHmqOuqh9Ii3n+oorfs0sFSm0XTfqK1XI6uxTCWOFQbKZVXt7M+MT++1eAEiFgd6FQ3Viy4gJeBcB+ELlyN5sFMKE+v8q0/VgoAm41I6N5CzXAK3y3Pc0nlm1g3MUXE0nF2TLh9bAtSImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593787; c=relaxed/simple;
	bh=9kt+Xg/vpJ4OWcg2+Q9UMpsLZY9YB0zOlK3Qqo+nYdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZ2eC2O2rLWh3dnHDgFL7FqtJsap+Mnq80IP3oJiz0kEmngkC4/3hZ5VcuFeDUysIx5sfHSGatrFPK0M6kaEoN5Fi3I4zg+iZ9v3ckqzkiU0tqS9E4GkGOZdv0WI/g62Dv1ppg4ZQyZ2YMf4Roxk93h7NwCEIwU6G2WIIrNsx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8A71F000E9;
	Mon, 24 Aug 2026 17:49:45 +0000 (UTC)
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
	benjamin.cheatham@amd.com,
	alison.schofield@intel.com,
	sashiko-bot@kernel.org
Subject: [PATCH v4 05/13] ACPI: extlog: Avoid populating software AER metadata from raw hardware buffer
Date: Mon, 24 Aug 2026 10:49:28 -0700
Message-ID: <20260824174936.939059-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824174936.939059-1-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

extlog_print_pcie() casts pcie_err->aer_info straight to struct
aer_capability_regs *. That struct embeds struct pcie_tlp_log, whose
software-only header_len and flit fields sit at offset 84 - inside the
96-byte aer_info buffer - so the cast fills them with raw firmware bytes.
pcie_print_tlp_log() uses both to bound a loop over dw[], and a large
header_len walks past the end of the array.

Copy aer_info into a zeroed local struct aer_capability_regs and clear
header_len and flit before passing it on.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Dropped the now-pointless aer pointer alias.
---
 drivers/acpi/acpi_extlog.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index f6e3da4e13e7..6d5532ec0920 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -137,7 +137,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 			      int severity)
 {
 #ifdef ACPI_APEI_PCIEAER
-	struct aer_capability_regs *aer;
+	struct aer_capability_regs aer_regs = {};
 	struct pci_dev *pdev;
 	unsigned int devfn;
 	unsigned int bus;
@@ -149,7 +149,11 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 		return;
 
 	aer_severity = cper_severity_to_aer(severity);
-	aer = (struct aer_capability_regs *)pcie_err->aer_info;
+
+	memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
+	aer_regs.header_log.header_len = 0;
+	aer_regs.header_log.flit = false;
+
 	domain = pcie_err->device_id.segment;
 	bus = pcie_err->device_id.bus;
 	devfn = PCI_DEVFN(pcie_err->device_id.device,
@@ -158,7 +162,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 	if (!pdev)
 		return;
 
-	pci_print_aer(pdev, aer_severity, aer);
+	pci_print_aer(pdev, aer_severity, &aer_regs);
 	pci_dev_put(pdev);
 #endif
 }
-- 
2.54.0

