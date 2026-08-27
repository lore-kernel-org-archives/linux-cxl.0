Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFEF36B900;
	Thu, 27 Aug 2026 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863072; cv=none; b=BBJ8TNsDc6VQtkmD6tLZOaKe3T5hPuBgz+gN2Fh8bLRDKhQVoHmLxaDm7+nyH/hikQcmBa277CquFQcQcFCx9N7njGvG5ArfUWV7A/6Ep3SXZwz9AOi1lvjJykRYIjh7LCfLZz9iJ47VWWnOCwAl7Q5zBbbHVvTD5b7Hc73ihZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863072; c=relaxed/simple;
	bh=+LLt/4ipy7LVu7wcnFEO1jZ/9qx4fGOwYn8k/JC0BLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWAhOD3QKBfUdrmJuL251dqxfp1wnGvWb8ERGMRnArnBAME9hVbvJUvXlXRmDRkxkrS2vO1Xi7yCKVYEr1MWP22nZxZ6IlbAksfV/ZkmQEMyn2/IXlIoD3HJ6Jd59dASxhJGJmmzQc31f3yd4ak/CvUUMKVBsRx5axXqrmomNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFD11F000E9;
	Thu, 27 Aug 2026 20:37:46 +0000 (UTC)
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
Subject: [PATCH v5 12/13] ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
Date: Thu, 27 Aug 2026 13:37:25 -0700
Message-ID: <20260827203726.3027541-13-dave.jiang@intel.com>
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

ghes_handle_aer() copies sizeof(struct aer_capability_regs) out of the
fixed 96-byte pcie_err->aer_info. The struct is larger, so the copy reads
past the section, and it fills the software-only header_len and flit fields
of the embedded struct pcie_tlp_log from firmware bytes.
pcie_print_tlp_log() uses both to bound a loop over dw[], so a large value
walks past the array. Nothing checks the section can hold a struct
cper_sec_pcie either.

Validate error_data_length, zero the destination, and copy only what maps
onto the struct: the leading registers and the four Header Log DWORDs,
mirroring the extlog_print_pcie() fix. The rest stays zero, covering
header_len and flit.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=3
Fixes: 7e077e6707b3 ("PCI/ERR: Handle TLP Log in Flit mode")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Copy only the registers that match the hardware layout rather than all 96
  bytes plus explicit clears, matching the same change in the extlog path
  (Jonathan Cameron).
- Note the copy length changed, so the printed TLP prefix log changes too;
  Alison's and Shuai's Reviewed-by are kept since the intent and location
  are the same, but please re-check if you disagree.
---
 drivers/acpi/apei/ghes.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0cc1e6383635..3df62ec20cf9 100644
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
@@ -664,13 +667,21 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 						  sizeof(struct aer_capability_regs));
 		if (!aer_info)
 			return;
-		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
+
+		/*
+		 * Copy only what maps onto the struct, as extlog_print_pcie()
+		 * does: the leading registers and the four Header Log DWORDs.
+		 * The rest stays zero, so firmware cannot drive the
+		 * pcie_print_tlp_log() loop over dw[] out of bounds.
+		 */
+		memset(aer_info, 0, sizeof(struct aer_capability_regs));
+		memcpy(aer_info, pcie_err->aer_info,
+		       offsetof(struct aer_capability_regs, header_log) +
+		       PCIE_STD_NUM_TLP_HEADERLOG * sizeof(u32));
 
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

