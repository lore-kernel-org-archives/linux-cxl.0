Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B637F30B;
	Mon, 24 Aug 2026 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593781; cv=none; b=UedSjuva4+a4HvC/yhCSr1KR43vIiCbHlB67BBy0ElTH+HB4eFGEuDDkHKlicX/Dnl+VEWAgiAmKM55yJ5OMxQRo94KrNQB/pYMCYEWWiLra0dKIxixMB5T2RfGYZH4Hlhdo5tBeKdsv75xAEK4/CRSWSeyEWu47rGqRicLd+AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593781; c=relaxed/simple;
	bh=zbvUQJpor8kBwksZ9JyFTsOOzkzp81utvHOUpDhBLJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+T6vIQOgdaeOzfwf7MwVcQD4rEpTMPYy8apkpp14eV5/62k7bNhRLt8xI6IEqyQ71O+7lJpnVmdrNpEgNOuvy8NDEoqseuszolS2hZCFDfxAJQ/G2lL9zVQUcg/7bd5LEH6Z4DR2RhDkmI2vq58Fg7yZzSVHFU8hHQhOXHdO1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B151F000E9;
	Mon, 24 Aug 2026 17:49:40 +0000 (UTC)
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
Subject: [PATCH v4 01/13] efi/cper: Reject CPER records with an out-of-range error_data_length
Date: Mon, 24 Aug 2026 10:49:24 -0700
Message-ID: <20260824174936.939059-2-dave.jiang@intel.com>
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

cper_estatus_check() sizes each section with acpi_hest_get_record_size(),
which adds the firmware-controlled u32 error_data_length to the header size
as a signed int (see <acpi/ghes.h>). A value in the top sizeof(*gdata)
bytes of the u32 range wraps the sum small rather than large, so it slips
past the "record_size > data_len" check: against the 72-byte v300 header,
0xffffffb9 sizes the record at 1 and acpi_hest_get_next() walks it a byte
at a time, off the end. 0xffffffb8 sizes it at 0 and loops forever.

Sum in u64 so the check sees the real size, and reject a size the int
helpers cannot carry, since the walk advances by their return value.

This is the per-section upper bound the later "len < sizeof(*foo)" guards
rely on; they are lower bounds only.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=1
Fixes: 45b14a4ffcc1 ("efi: cper: Fix possible out-of-bounds access")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Do the arithmetic in u64 at the choke point instead of bounding the u32
  error_data_length against data_len, so the check no longer depends on the
  signed helpers in <acpi/ghes.h> behaving (Tony Luck). Bounding the u32
  still left a window when data_length itself was within a header of
  U32_MAX, and it did not stop acpi_hest_get_next() advancing by a wrapped
  int. The v3 "< 0" arm was dead either way, since data_len is unsigned and
  promoted the int back (Tony Luck, Shuai Xue).
- Dropped Alison's and Shuai's Reviewed-by; the check was reworked after
  they reviewed it.
---
 drivers/firmware/efi/cper.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 06b4fdb59917..ec092729cacc 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -752,7 +752,7 @@ EXPORT_SYMBOL_GPL(cper_estatus_check_header);
 int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
 {
 	struct acpi_hest_generic_data *gdata;
-	unsigned int data_len, record_size;
+	unsigned int data_len;
 	int rc;
 
 	rc = cper_estatus_check_header(estatus);
@@ -762,11 +762,21 @@ int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
 	data_len = estatus->data_length;
 
 	apei_estatus_for_each_section(estatus, gdata) {
+		u64 record_size;
+
 		if (acpi_hest_get_size(gdata) > data_len)
 			return -EINVAL;
 
-		record_size = acpi_hest_get_record_size(gdata);
-		if (record_size > data_len)
+		/*
+		 * acpi_hest_get_record_size() sums these as a signed int (see
+		 * <acpi/ghes.h>), which wraps small for a huge
+		 * error_data_length and slips past the check below. Sum in u64,
+		 * and reject what those helpers cannot carry, since the walk
+		 * advances by their return value.
+		 */
+		record_size = (u64)acpi_hest_get_size(gdata) +
+			      gdata->error_data_length;
+		if (record_size > data_len || record_size > INT_MAX)
 			return -EINVAL;
 
 		data_len -= record_size;
-- 
2.54.0

