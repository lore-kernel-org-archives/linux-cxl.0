Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E68371071;
	Thu, 27 Aug 2026 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863065; cv=none; b=t5Rwhi3hCAiFUoyyory39WvLSzDoXdUAqKP3ErFca03r+iWbCTM6wBzqMSwN8OZOifqt7adJn3fPAVKa14gJS2ortF21EosI01dEKl4MzL9Yq0h7mplYiegu2Ba1ZuTjy7vk0ozc+jV2s7Wjr7AItzCC0npEywLC2Kco2GVgBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863065; c=relaxed/simple;
	bh=anFqC8Uh7SIZrovNIGDBRUMKdu6KKN3iUe1pV9XmqBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Za8LLz9DIsOSHhH7JAyrgjuVo/Yu3WTjsSEDryXs80Wc+hAuS/1QkY5PXeCKwpFD0c6CYoDyaWQalEI6F4pikqjvRk3ISSpA6tL/uGaA2yDDIL+nRP/qx7zNi8Y2FP+zQw5uAZZrWsMHnpBsyMeWDSjYJbfhs/zrvgIJucuU+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAB51F000E9;
	Thu, 27 Aug 2026 20:37:37 +0000 (UTC)
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
	sashiko-bot@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 06/13] ACPI: extlog: Validate PCIe error section length before payload access
Date: Thu, 27 Aug 2026 13:37:19 -0700
Message-ID: <20260827203726.3027541-7-dave.jiang@intel.com>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/acpi_extlog.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index feb7c002a713..7c45a9865726 100644
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
@@ -242,7 +248,8 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
-			extlog_print_pcie(pcie_err, gdata->error_severity);
+			extlog_print_pcie(pcie_err, gdata->error_severity,
+					  gdata->error_data_length);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
-- 
2.54.0

