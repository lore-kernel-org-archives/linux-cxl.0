Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391437C0FD;
	Mon, 24 Aug 2026 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593788; cv=none; b=U6J6Y5dq3KgEAmcYVvoBd5Gp6QOEOvv43K+LNUSnmvtXW5gdkAqWmXyEIPVA1bry9ivCxAZUZ7GjuFXpkWw7fu1mKLMJQfSywRmrC+VqA6hOb4yvPIw9RZOrX15rItxy5T/6G3hjTYY+zwRG2+OFmzhD+2GoywwNURNY+w6ANjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593788; c=relaxed/simple;
	bh=IAViHcY+3Oekuc8oipm0pzKQ89gQ/hqCHiYiEe89ZXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/WNico7MzmOPScnFligXenhNS2WuTRgSRNeSJ1MI55jq6aK+dsi8dSQ77++irXLvE6jwoWMgu36o1eEHSZYqn8kLN9G16EpH+Eq5Kvqym04SD9YdFVl9Blid1++UWeyYHaFDHjFLAbsTMlf2xl6cojOLYPG6hFyn0OlDVtGsRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0921F00A3A;
	Mon, 24 Aug 2026 17:49:46 +0000 (UTC)
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
Subject: [PATCH v4 06/13] ACPI: extlog: Validate PCIe error section length before payload access
Date: Mon, 24 Aug 2026 10:49:29 -0700
Message-ID: <20260824174936.939059-7-dave.jiang@intel.com>
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

extlog_print_pcie() reads pcie_err->validation_bits and device_id and
copies the 96-byte aer_info buffer without checking that
gdata->error_data_length is big enough for a struct cper_sec_pcie. The
cper_estatus_check() call added earlier keeps the read inside the estatus
block, but a short section still gets stale adjacent bytes treated as PCIe
error data.

Reject a section too small to hold the record before touching any field,
and warn: a truncated section means firmware is emitting malformed records.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Warn instead of returning silently, matching the other length
  rejections in the series (Shuai Xue).
- Added the Closes: link to the sashiko report, which v3 omitted.
---
 drivers/acpi/acpi_extlog.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 6d5532ec0920..3aec73187b51 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -134,7 +134,7 @@ static int print_extlog_rcd(const char *pfx,
 }
 
 static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
-			      int severity)
+			      int severity, u32 len)
 {
 #ifdef ACPI_APEI_PCIEAER
 	struct aer_capability_regs aer_regs = {};
@@ -144,6 +144,12 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 	int aer_severity;
 	int domain;
 
+	if (len < sizeof(*pcie_err)) {
+		pr_warn_ratelimited(FW_WARN
+				    "PCIe error section too small (%u)\n", len);
+		return;
+	}
+
 	if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
 	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
 		return;
@@ -231,7 +237,8 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
-			extlog_print_pcie(pcie_err, gdata->error_severity);
+			extlog_print_pcie(pcie_err, gdata->error_severity,
+					  gdata->error_data_length);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
-- 
2.54.0

