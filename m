Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CEE42F6FF;
	Tue, 14 Jul 2026 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071134; cv=none; b=iVJvlQdaz18AkDvhi/BnSGXfGCOevFgs7rfWrm0vrWFWbd3PVfKI0yv9OJTMli2jJJo5RrCC5G8CUkATZF0zX0dc1e1KG63X1qAr8CFZjyt1vx3M/opUvuQHQJF0upq0n3nCvZv1+hqkkxEq7zWzXFS63qiEb4Xi/bOuGXslOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071134; c=relaxed/simple;
	bh=CYuGqPebOa+68k3sPA5VPXqBdAEEEDHlTiXg4D8Q//0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpuSzXyIzLxdS+FWKqoUNwcCh1nsrEOMq2gb6nyHt5P4PCgPRE0RkfhTJ/pfxlPzYkosEJgOReL+QHW2mbsOkhx11iuoHzdMOX9N2UCkJAsRgfllytGfGYJf4abGlVujanzPw6A2R3+ZDKr8Qf86a807UVFDYdN/OwOPUasamgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC4A1F000E9;
	Tue, 14 Jul 2026 23:18:52 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	terry.bowman@amd.com
Subject: [PATCH v2 4/7] ACPI: extlog: Validate PCIe error section length before payload access
Date: Tue, 14 Jul 2026 16:18:32 -0700
Message-ID: <20260714231835.303081-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714231835.303081-1-dave.jiang@intel.com>
References: <20260714231835.303081-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

extlog_print_pcie() reads pcie_err->validation_bits and device_id and
copies the fixed 96-byte pcie_err->aer_info buffer without first checking
that gdata->error_data_length is large enough to hold a struct
cper_sec_pcie.

cper_estatus_check() guarantees the reported error_data_length lies
within the estatus block, so a short section does not read unmapped
memory, but it does let stale bytes from adjacent padding or the next
section be interpreted as PCIe error data. Reject a section too small to
hold the record before touching any field, matching the convention used
elsewhere.

Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- new patch, issue raised by sashiko
---
 drivers/acpi/acpi_extlog.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index fbc88c584c06..0c440d75d9a7 100644
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
@@ -145,6 +145,9 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 	int aer_severity;
 	int domain;
 
+	if (len < sizeof(*pcie_err))
+		return;
+
 	if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
 	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
 		return;
@@ -247,7 +250,8 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
-			extlog_print_pcie(pcie_err, gdata->error_severity);
+			extlog_print_pcie(pcie_err, gdata->error_severity,
+					  gdata->error_data_length);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
-- 
2.55.0

