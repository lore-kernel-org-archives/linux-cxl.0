Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D037C0FD;
	Mon, 24 Aug 2026 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593795; cv=none; b=iD/orUxhbECLHEG4NdqQO5oFyu0SwLoQglp9PpSghu4XOrHPxo3kd5KWtG0mi2cekWNv7WGn78OUFpE+a1cIstd8y7YQEckA0rg7tfm3Cw8O49Ebs/jDMGuE6VIjpHoLykklzBUH9i23XDo/pDl1lcAfk6L56jfre2Zno8zCuXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593795; c=relaxed/simple;
	bh=82r8he4KpYEn+odofjIBAbkDJzfN8g1IgrZkFdyvbmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAzA/PgQIJi0qTRCUxnd5nJhvW/f90BYebfe2+qoOKFxtCS2KgulE5kHQ72ljZ6bfk+HcCgJthe33ANkx6Ei3//u2R2Zx/5xuCBxKhtJQeLe6tcVqIQBtuHBW/W5vwGUy2+90Cu92AIkLXOBP+TsJp9+XAphW/dAAlLTey3FrHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8C81F000E9;
	Mon, 24 Aug 2026 17:49:53 +0000 (UTC)
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
Subject: [PATCH v4 11/13] ACPI: APEI: GHES: Validate memory error section length before payload access
Date: Mon, 24 Aug 2026 10:49:34 -0700
Message-ID: <20260824174936.939059-12-dave.jiang@intel.com>
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

ghes_do_proc() hands the CPER_SEC_PLATFORM_MEM payload to the report chain,
arch_apei_report_mem_error() and ghes_handle_memory_failure() without
checking gdata->error_data_length. All three read validation_bits and
physical_addr, at offsets 0 and 16, so a shorter section reads past the
record.

Check the length once in ghes_do_proc(), before any consumer runs. Take the
73-byte struct cper_sec_mem_err_old as the floor: older firmware
legitimately emits that UEFI 2.1/2.2 layout, and it makes validation_bits
safe to read.

The fields from "extended" on are absent from that layout, so also require
whatever length the validation bits claim. Derive it per field rather than
demanding the full 80 bytes: rank needs only 76, and the BANK_GROUP and
BANK_ADDRESS bits describe "bank" at offset 38, which every record carries.
cper_print_mem() tests the whole range above CPER_MEM_VALID_RANK_NUMBER
against the 73-byte size instead, which both admits 74 to 79 and rejects a
record claiming only "bank".

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=7
Fixes: ca104edc1784 ("ACPI, APEI, GHES: Cleanup ghes memory error handling")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Derive the required length from the claimed validation bits instead of
  testing the whole mask against one size. The blanket form rejected a
  76-byte record that legitimately carries rank, and any short record
  claiming only bank (sashiko).
- Dropped Alison's and Shuai's Reviewed-by; the check gained a helper and
  is no longer the patch they reviewed.
---
 drivers/acpi/apei/ghes.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b8dbd99da47e..0cc1e6383635 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -915,6 +915,28 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
 	hwerr_log_error_type(HWERR_RECOV_OTHERS);
 }
 
+/*
+ * The fields from "extended" on are absent from the 73-byte UEFI 2.1/2.2
+ * layout that older firmware still emits. Return the length needed for the
+ * fields the validation bits claim, so over-claiming is rejected without
+ * rejecting an honest short record.
+ */
+static u32 ghes_mem_err_min_len(u64 validation_bits)
+{
+	u32 len = sizeof(struct cper_sec_mem_err_old);
+
+	if (validation_bits & (CPER_MEM_VALID_ROW_EXT | CPER_MEM_VALID_CHIP_ID))
+		len = offsetof(struct cper_sec_mem_err, rank);
+	if (validation_bits & CPER_MEM_VALID_RANK_NUMBER)
+		len = offsetof(struct cper_sec_mem_err, mem_array_handle);
+	if (validation_bits & CPER_MEM_VALID_CARD_HANDLE)
+		len = offsetof(struct cper_sec_mem_err, mem_dev_handle);
+	if (validation_bits & CPER_MEM_VALID_MODULE_HANDLE)
+		len = sizeof(struct cper_sec_mem_err);
+
+	return len;
+}
+
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -940,6 +962,25 @@ static void ghes_do_proc(struct ghes *ghes,
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
+			/*
+			 * Check once for all three consumers below. The 73-byte
+			 * UEFI 2.1/2.2 layout is the floor, matching
+			 * cper_estatus_print_section() and making
+			 * validation_bits safe to read.
+			 */
+			if (gdata->error_data_length <
+			    sizeof(struct cper_sec_mem_err_old))
+				continue;
+
+			/* Then require what the claimed fields actually need. */
+			if (gdata->error_data_length <
+			    ghes_mem_err_min_len(mem_err->validation_bits)) {
+				pr_warn_ratelimited(FW_WARN GHES_PFX
+						    "memory error section too small (%u) for the fields it claims\n",
+						    gdata->error_data_length);
+				continue;
+			}
+
 			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-- 
2.54.0

