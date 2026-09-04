Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F7511E80;
	Fri,  4 Sep 2026 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542632; cv=none; b=Rsr3e9aw5e0cYe4117ksg9y37kon2NQWEIpArSN84PhWLRSsbZIJTuKrsl66OKPLplhy44j6gIRDieWr1CYQlVqlpw66K2caRA+on1R9hmCiOBuZGcpIpuhBOiJHXovz9B6qLZfhUALmuGN+FGgDEHXgsn1Xe62EY1ZzlzRGEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542632; c=relaxed/simple;
	bh=1+rEB+dJg9bBkkVJIubcS6Iiz2CEPKGWhSl3pkTRv3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUP026hGjgXgUts/xtOWnoRNiyY6ZnLGeXI8QJnI4O9g3JASaQelFtww4CuwE/PB7+Lp2eKFhyb7onbYXqFKyzlgiwYDACGEL8ga76J6ILT992qKILgUJB9XsuM2psKKgtOd2s3DXhwrXgDEc6F4s0B0m1bB+Cz5Xdch3iBUIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A401F00ACA;
	Fri,  4 Sep 2026 17:23:46 +0000 (UTC)
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
Subject: [PATCH v6 05/13] ACPI: extlog: Avoid populating software AER metadata from raw hardware buffer
Date: Fri,  4 Sep 2026 10:23:29 -0700
Message-ID: <20260904172337.1409775-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904172337.1409775-1-dave.jiang@intel.com>
References: <20260904172337.1409775-1-dave.jiang@intel.com>
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

Copy into a zeroed local struct, and only as far as aer_info maps onto it:
the leading registers and the four Header Log DWORDs. Place the TLP Prefix
Log separately, from the offset the hardware keeps it at. The rest stays
zero, which covers header_len and flit and keeps the Root Error registers
out of the prefix log, where pcie_print_tlp_log() would print them as
end-to-end prefixes.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Also place the TLP Prefix Log from its own hardware offset rather than
  leaving it zero. It is the one field the print path reads that the
  shortened copy missed (sashiko).
---
 drivers/acpi/acpi_extlog.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 2451362e696d..1b61788abd5a 100644
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
@@ -149,7 +149,21 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 		return;
 
 	aer_severity = cper_severity_to_aer(severity);
-	aer = (struct aer_capability_regs *)pcie_err->aer_info;
+
+	/*
+	 * struct pcie_tlp_log is larger than the hardware layout, so aer_info
+	 * only maps onto the struct up to the four Header Log DWORDs. Copy that
+	 * much, then place the TLP Prefix Log from where the hardware keeps it.
+	 * Everything else stays zero: nothing reads root_command, root_status or
+	 * the error source IDs, and header_len and flit are software-only.
+	 */
+	memcpy(&aer_regs, pcie_err->aer_info,
+	       offsetof(struct aer_capability_regs, header_log) +
+	       PCIE_STD_NUM_TLP_HEADERLOG * sizeof(u32));
+	memcpy(aer_regs.header_log.prefix,
+	       pcie_err->aer_info + PCI_ERR_PREFIX_LOG,
+	       sizeof(aer_regs.header_log.prefix));
+
 	domain = pcie_err->device_id.segment;
 	bus = pcie_err->device_id.bus;
 	devfn = PCI_DEVFN(pcie_err->device_id.device,
@@ -158,7 +172,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 	if (!pdev)
 		return;
 
-	pci_print_aer(pdev, aer_severity, aer);
+	pci_print_aer(pdev, aer_severity, &aer_regs);
 	pci_dev_put(pdev);
 #endif
 }
-- 
2.54.0

