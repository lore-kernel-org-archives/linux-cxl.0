Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88093356A0D;
	Mon, 24 Aug 2026 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593796; cv=none; b=i/RvLh04wBvgs1Tgz3iTZwB7ug47sknt/78fI9e3J0x3agEWILWvkKTU5cUpLPqMs7myFI4XNZwm5QbMQMKtSYxfgIM+9vAWb/b7tL9K/FvyaKEbHIa2nV31QchxYxgJnGMcoSgToWwzI2a8XFpnC71qixNoTeK6ZBVj/uMGSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593796; c=relaxed/simple;
	bh=RJ1f6i6gYG3eKNJJfQgoQ6pPe6JHujokWFOkFTF5eFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qetbUZCvFMAbKrFtvUDxwo5XYmR6O+wcwzcgmmEUx4sCnI3XHO9hVzsqlTJ0KMChebCN25/tlps1nTas57oriOBuUN2+usK7HSnYQSmAH0quiKUWOD8WOsRFAilTrcRKYVmlKDMDwvj3c1V7O0GbT9jm+WWt8PqxjJ9dJpRoswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561D31F00A3A;
	Mon, 24 Aug 2026 17:49:55 +0000 (UTC)
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
Subject: [PATCH v4 12/13] ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
Date: Mon, 24 Aug 2026 10:49:35 -0700
Message-ID: <20260824174936.939059-13-dave.jiang@intel.com>
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

ghes_handle_aer() copies sizeof(struct aer_capability_regs) out of the
fixed 96-byte pcie_err->aer_info. The struct is larger, so the copy reads
past the section. It also fills the software-only header_len and flit
fields of the embedded struct pcie_tlp_log from raw firmware bytes, and
pcie_print_tlp_log() uses both to bound a loop over dw[], so a large value
walks past the array. Nothing checks that the section can hold a struct
cper_sec_pcie either.

Validate error_data_length, zero the destination, bound the copy to the
96-byte source, and clear header_len and flit, mirroring the
extlog_print_pcie() fix.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=3
Fixes: 7e077e6707b3 ("PCI/ERR: Handle TLP Log in Flit mode")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/apei/ghes.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0cc1e6383635..d6643127a2df 100644
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
+		 * The CPER source is a fixed 96 bytes, shorter than struct
+		 * aer_capability_regs, so bound the copy to it. header_len and
+		 * flit are software-only and land inside those 96 bytes; clear
+		 * them so firmware cannot drive the pcie_print_tlp_log() loop
+		 * over dw[] out of bounds.
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
2.54.0

