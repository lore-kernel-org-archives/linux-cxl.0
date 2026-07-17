Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795753B813D;
	Fri, 17 Jul 2026 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305023; cv=none; b=fTmcUeNXvQzeNCNYTUFu+46SYlWswfQtrpO7HzcrNmUi+y3cvivxJSraX/r1VKv8o56Ea6ohWLOxe/8vC46DddqdYWY2T+ryVhEH4ejN4PbSnX/nH3YVXXJGSjRYNN4jGrEHSgk8+JUpJwqcJ98tbbHEs36+cRqnEo+EO92nCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305023; c=relaxed/simple;
	bh=iTX6n+vqFe/p9x4XNvReGP5RiV48PGw6whjXX+5vQ5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHnu66EoLBE05cGJUB0i9i+Nqcjcn8DhN+m1RP+NX+JkOlE0M+WVowrRVeTZtvQ1O7Yw00cMsi7ji2sDD6het8iH/Si8W2x8pC3RlYhqR5s2GnUzq47A/vl3o5s8nLngR+hRJviN1Tp0Dr7IkFvJ+JDxF2Yybi6p3XTSPY1tEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7E11F000E9;
	Fri, 17 Jul 2026 16:17:02 +0000 (UTC)
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
Subject: [PATCH v3 09/10] ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
Date: Fri, 17 Jul 2026 09:16:46 -0700
Message-ID: <20260717161647.1493259-10-dave.jiang@intel.com>
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

sashiko-bot flagged that ghes_handle_aer() has the same unvalidated
AER buffer handling plus a 4-byte over-read.

ghes_handle_aer() copies sizeof(struct aer_capability_regs) from the
fixed 96-byte pcie_err->aer_info, reading past the section since the
struct is larger. It also fills the software-only header_len and flit
fields of the embedded struct pcie_tlp_log from raw firmware bytes;
pcie_print_tlp_log() uses them to bound a loop over dw[], so a large
value walks past the array. There is also no check that the section can
hold a struct cper_sec_pcie.

Validate error_data_length, zero the destination, bound the copy to the
96-byte source, and clear header_len and flit. This mirrors the
extlog_print_pcie() fix.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=3
Fixes: 7e077e6707b3 ("PCI/ERR: Handle TLP Log in Flit mode")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- New patch. sashiko's review of v2 flagged the same unvalidated AER
  buffer handling in ghes_handle_aer() that v2 fixed for extlog.
---
 drivers/acpi/apei/ghes.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 1d2966a437bd..bd53509dcab3 100644
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
@@ -664,13 +667,22 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 						  sizeof(struct aer_capability_regs));
 		if (!aer_info)
 			return;
-		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
+
+		/*
+		 * aer_info is a fixed 96-byte buffer, smaller than struct
+		 * aer_capability_regs, so bound the copy to the source. Clear
+		 * the software-only header_len and flit fields afterwards so
+		 * firmware bytes cannot drive the pcie_print_tlp_log() loop over
+		 * dw[] out of bounds.
+		 */
+		memset(aer_info, 0, sizeof(struct aer_capability_regs));
+		memcpy(aer_info, pcie_err->aer_info, sizeof(pcie_err->aer_info));
+		aer_info->header_log.header_len = 0;
+		aer_info->header_log.flit = false;
 
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
2.55.0

