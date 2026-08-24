Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C997356A0D;
	Mon, 24 Aug 2026 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593791; cv=none; b=ihbk5eKZwV5pZMSktZ/QmycaFqK9lFSd//nvy1KBrCWBcZ7xrrcA2Wm1n39pXWogd/VQF+RjQlTmxvSp1ftG1+tbAYPnWVx6FcaUk4wJXy0mYcIh3Yr7aSfc42a6uNj+xY3js7LWLg0DZEDzk3ajYREjxgtUuqlU5d9in/SPo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593791; c=relaxed/simple;
	bh=I49tO7SxSWr7QC9g4FI16uV42gVZs68FNrSNHRArt0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSY4Cfx1PP/MFYzXIOcUPq2z7MIxLtY/Yd+8tlRGztNHQwewLg9f05fdpP2QYQTIjEcZAoT5aX1xxol5kZ5DR6nW4+DFE8Ov+G++5r33QnYLzPlvT3dCgEuFG2cKDKgFo13NWODV8KRjw9CVTRpGydJfXEcPX/qip1YqnxVQiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59E21F00A3A;
	Mon, 24 Aug 2026 17:49:49 +0000 (UTC)
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
Subject: [PATCH v4 08/13] ACPI: APEI: GHES: Bound CXL event record copy to the firmware section length
Date: Mon, 24 Aug 2026 10:49:31 -0700
Message-ID: <20260824174936.939059-9-dave.jiang@intel.com>
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

cxl_cper_post_event() copies a fixed sizeof(struct cxl_cper_event_rec)
out of the firmware CPER section without checking how long the section
actually is, so a short one reads past the record.

Pass gdata->error_data_length in and reject a section too small to hold
the record before the copy.

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/apei/ghes.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a382aabf9835..e5f8dbd17017 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -816,10 +816,15 @@ static DEFINE_SPINLOCK(cxl_cper_work_lock);
 struct work_struct *cxl_cper_work;
 
 static void cxl_cper_post_event(enum cxl_event_type event_type,
-				struct cxl_cper_event_rec *rec)
+				struct cxl_cper_event_rec *rec, u32 len)
 {
 	struct cxl_cper_work_data wd;
 
+	if (len < sizeof(*rec)) {
+		pr_err(FW_WARN "CXL CPER section too small (%u)\n", len);
+		return;
+	}
+
 	if (rec->hdr.length <= sizeof(rec->hdr) ||
 	    rec->hdr.length > sizeof(*rec)) {
 		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
@@ -950,15 +955,18 @@ static void ghes_do_proc(struct ghes *ghes,
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
2.54.0

