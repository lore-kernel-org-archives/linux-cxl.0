Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC31314B63;
	Fri,  4 Sep 2026 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542644; cv=none; b=cZlO0BsRr7key03a2OUOmARijsvfmJeIxJZfC0hibLDLQTWi3g6BNFQJ4XcKVrObMpNQvRuILdxYDiJKbSc1/TabyH2R+Kk8efvcACNR76qEDmucVGCXfSBy7TdQXvDwYfD3wYGsO+PiMCSr63mK4cRwtqMAYQVZuzHjIeCUW44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542644; c=relaxed/simple;
	bh=otqhtQ8FICngfUzldLBvqebkvzdHHchTadWhqnOwix4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7P5g/ttOh+XENQfs6v8KSXy71SnPc5Pz8e9RuJ07NVOdLag6whtL01FxwZPnhbLSGHbITEDluk95XPq0O7Qd8CQbJcp/X7kYYc6f+Yvz4Nbyvq7rRe7AffwfpKcijPzxZ0C9cYsCcjQZldLPMLjmVm/D3nBLGtpnzMjWfo5FgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFEE1F00A3E;
	Fri,  4 Sep 2026 17:23:56 +0000 (UTC)
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
Subject: [PATCH v6 12/13] ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
Date: Fri,  4 Sep 2026 10:23:36 -0700
Message-ID: <20260904172337.1409775-13-dave.jiang@intel.com>
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

ghes_handle_aer() copies sizeof(struct aer_capability_regs) out of the
fixed 96-byte pcie_err->aer_info. The struct is larger, so the copy reads
past the section, and it fills the software-only header_len and flit fields
of the embedded struct pcie_tlp_log from firmware bytes.
pcie_print_tlp_log() uses both to bound a loop over dw[], so a large value
walks past the array. Nothing checks the section can hold a struct
cper_sec_pcie either.

Validate error_data_length, zero the destination, and map aer_info onto the
struct as extlog_print_pcie() does: copy up to the four Header Log DWORDs,
then place the TLP Prefix Log from its own offset. The rest stays zero,
covering header_len and flit.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=3
Fixes: 7e077e6707b3 ("PCI/ERR: Handle TLP Log in Flit mode")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Also place the TLP Prefix Log from its own hardware offset rather than
  leaving it zero. It is the one field the print path reads that the
  shortened copy missed (sashiko).
---
 drivers/acpi/apei/ghes.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 2077cc90569a..08c985e729d6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -642,11 +642,14 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
+	if (gdata->error_data_length < sizeof(*pcie_err))
+		return;
+
 	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
 	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
+		struct aer_capability_regs *aer_info;
 		unsigned int devfn;
 		int aer_severity;
-		u8 *aer_info;
 
 		devfn = PCI_DEVFN(pcie_err->device_id.device,
 				  pcie_err->device_id.function);
@@ -664,13 +667,25 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 						  sizeof(struct aer_capability_regs));
 		if (!aer_info)
 			return;
-		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
+
+		/*
+		 * Map aer_info onto the struct as extlog_print_pcie() does:
+		 * copy up to the four Header Log DWORDs, then place the TLP
+		 * Prefix Log from where the hardware keeps it. The rest stays
+		 * zero, so firmware cannot drive the pcie_print_tlp_log() loop
+		 * over dw[] out of bounds.
+		 */
+		memset(aer_info, 0, sizeof(struct aer_capability_regs));
+		memcpy(aer_info, pcie_err->aer_info,
+		       offsetof(struct aer_capability_regs, header_log) +
+		       PCIE_STD_NUM_TLP_HEADERLOG * sizeof(u32));
+		memcpy(aer_info->header_log.prefix,
+		       pcie_err->aer_info + PCI_ERR_PREFIX_LOG,
+		       sizeof(aer_info->header_log.prefix));
 
 		aer_recover_queue(pcie_err->device_id.segment,
 				  pcie_err->device_id.bus,
-				  devfn, aer_severity,
-				  (struct aer_capability_regs *)
-				  aer_info);
+				  devfn, aer_severity, aer_info);
 	}
 #endif
 }
-- 
2.54.0

