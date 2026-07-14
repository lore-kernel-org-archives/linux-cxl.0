Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD21429CEF;
	Tue, 14 Jul 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071133; cv=none; b=uJ2k0noQtFG9tH7R1FccVsQaHImIArcSFeW2D9v0UYxsZUiVLCCeIkp1+nzbSemXRbQOmmWiGwW7uDIF43PGL/2/RkFZLgDOtfvovVgenuHI1cOpQEHgKTUTJchBAbOJ3i6Vl45cbfeVuFcq07ClFqWidmJa/XlvuZiz2h/EdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071133; c=relaxed/simple;
	bh=euoRwyFHQJCzrGuGz/NUhv60acaPV+Om55YE3lw2mEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TG9t4xCwR0qA3Mm7sWQul7cC6Rswt50aJAI1LMaIQg+kKt7JhNb3EVXAWhTx6J90galemp8QM8dAVZa+Y16Ze8uMmpqxxUOZGJ8ozdS4vNATjVfYxK8c60Nf4dV1Q8UM/RHK/3cluKhEyWtetoLkwZAOe0RTeNBKEv2x6L93DdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CEE1F00A3A;
	Tue, 14 Jul 2026 23:18:48 +0000 (UTC)
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
Subject: [PATCH v2 1/7] ACPI: APEI: GHES: Bound CXL event record copy to the firmware section length
Date: Tue, 14 Jul 2026 16:18:29 -0700
Message-ID: <20260714231835.303081-2-dave.jiang@intel.com>
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

cxl_cper_post_event() blindly copies a fixed
sizeof(struct cxl_cper_event_rec) out of the firmware-provided CPER
section without checking the length. Pass gdata->error_data_length into
the function and reject a section too small to hold the record before
the copy.

Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Corrected err_data_length to error_data_length in commit log
---
 drivers/acpi/apei/ghes.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..9916271a8151 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -815,10 +815,21 @@ static DEFINE_SPINLOCK(cxl_cper_work_lock);
 struct work_struct *cxl_cper_work;
 
 static void cxl_cper_post_event(enum cxl_event_type event_type,
-				struct cxl_cper_event_rec *rec)
+				struct cxl_cper_event_rec *rec, u32 len)
 {
 	struct cxl_cper_work_data wd;
 
+	/*
+	 * The record is copied whole below, so the firmware-provided section
+	 * must be at least as large as the record. cper_estatus_check() only
+	 * validates the section fits the error block, not that it satisfies a
+	 * given section type's size, so guard the fixed-size copy here.
+	 */
+	if (len < sizeof(*rec)) {
+		pr_err(FW_WARN "CXL CPER section too small (%u)\n", len);
+		return;
+	}
+
 	if (rec->hdr.length <= sizeof(rec->hdr) ||
 	    rec->hdr.length > sizeof(*rec)) {
 		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
@@ -949,15 +960,18 @@ static void ghes_do_proc(struct ghes *ghes,
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
 
-			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
+			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec,
+					    gdata->error_data_length);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
 
-			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
+			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec,
+					    gdata->error_data_length);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
 
-			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
+			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec,
+					    gdata->error_data_length);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
-- 
2.55.0

