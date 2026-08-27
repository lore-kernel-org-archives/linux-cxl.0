Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09D73644BC;
	Thu, 27 Aug 2026 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863068; cv=none; b=fr3lgvmMCvHG4n1FMDRV1os/WnimxcLoXg2oJPkqSnoQtQM1RwMHqet/6IseOdOALc+ZlKifj4M+sdIB3WmBfaMBeiGOqxJQXf01U6wF8L6lei6uWcmlMgqKP/Gj/7XBQb/xJ7sm3zGfEl85ZaXXj9hI/RmnD6I4liDlueMgIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863068; c=relaxed/simple;
	bh=GiUwVgjGBpklw243Wl2JaJgllMug0pxvd4MSw2jcJM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJUlR9VHBgV0k6rbnNJs5igRFH8ecvo9pLwBir65kECO4VdFEie4ysq9cAsdRJoXIlBoumpVrAh4oqXYQ4SB7ZVlsuJbB3KUnHHRfyscs7cjtEytozFa8Gir+V/uZj1of/c7olhxKuHJMX2/8J1+KWtuNnEYOtyIvuP4yS85F/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBA51F00AC4;
	Thu, 27 Aug 2026 20:37:36 +0000 (UTC)
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
Subject: [PATCH v5 05/13] ACPI: extlog: Avoid populating software AER metadata from raw hardware buffer
Date: Thu, 27 Aug 2026 13:37:18 -0700
Message-ID: <20260827203726.3027541-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827203726.3027541-1-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
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

Copy into a zeroed local struct, and only the part of aer_info that maps
onto it: the leading registers and the four Header Log DWORDs. The rest
stays zero, which covers header_len and flit and keeps the Root Error
registers out of the TLP prefix log, where pcie_print_tlp_log() would print
them as end-to-end prefixes.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Copy only the registers that match the hardware layout instead of all 96
  bytes plus explicit clears, so the rest falls out zero (Jonathan
  Cameron).
---
 drivers/acpi/acpi_extlog.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 2451362e696d..feb7c002a713 100644
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
@@ -149,7 +149,17 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 		return;
 
 	aer_severity = cper_severity_to_aer(severity);
-	aer = (struct aer_capability_regs *)pcie_err->aer_info;
+
+	/*
+	 * struct pcie_tlp_log is larger than the hardware layout, so only the
+	 * leading registers and the four Header Log DWORDs of aer_info map onto
+	 * the struct. Copy that much and leave the rest zero, which covers the
+	 * software-only header_len and flit.
+	 */
+	memcpy(&aer_regs, pcie_err->aer_info,
+	       offsetof(struct aer_capability_regs, header_log) +
+	       PCIE_STD_NUM_TLP_HEADERLOG * sizeof(u32));
+
 	domain = pcie_err->device_id.segment;
 	bus = pcie_err->device_id.bus;
 	devfn = PCI_DEVFN(pcie_err->device_id.device,
@@ -158,7 +168,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 	if (!pdev)
 		return;
 
-	pci_print_aer(pdev, aer_severity, aer);
+	pci_print_aer(pdev, aer_severity, &aer_regs);
 	pci_dev_put(pdev);
 #endif
 }
-- 
2.54.0

