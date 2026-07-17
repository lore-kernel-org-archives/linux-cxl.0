Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684B34887E;
	Fri, 17 Jul 2026 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305014; cv=none; b=TSgDx8GOhW9Xvjy/iwnANiz47fbajyHpVc+vN5/+swbP5xEcUn6URy6LqbPtrKmJoMm+j5HdFlnYxXIyvILl2HbOKR6OO5m7diQS0XUyZZ8VrEHFLzttS5XocBCDK7P2pzC4eSnxSuzXZliwot9xjlumuxokCIIKM7fDmcQrIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305014; c=relaxed/simple;
	bh=3rAvtf510ns5MbWfwxPhRhgCjNxxiM5BlZMFs4BTrCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGblj1EE6f9N1XVO8gRoUf/o3hZqr8Yptxfzf9dJ+CdMAqNzABbibMiNRuvVPy++fn6Jo093W+Bnny6uPGj7r3NF+bXp8uyXAnoBoLJkTPLS0fCefPPNEWURLbv+OZSWTiTp6AGQngoBFZvXeo6A3OscULoHmcodqOi8E071TG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12841F000E9;
	Fri, 17 Jul 2026 16:16:52 +0000 (UTC)
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
Subject: [PATCH v3 02/10] efi/cper: Reject CPER records with an out-of-range error_data_length
Date: Fri, 17 Jul 2026 09:16:39 -0700
Message-ID: <20260717161647.1493259-3-dave.jiang@intel.com>
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

sashiko-bot flagged that the "len < sizeof(*rec)" guard added in this
series can be bypassed by an integer overflow in the shared length check.

cper_estatus_check() bounds firmware CPER data before the section
handlers in ghes_do_proc() run. It sizes each section with
acpi_hest_get_record_size(), which adds the firmware-controlled u32
error_data_length to the header size using signed int helpers in
<acpi/ghes.h>. A value like 0xffffffb9 sign-converts to a negative
number, wraps the record size small, and slips past the
"record_size > data_len" check. A section handler then copies a
fixed-size payload out of it and reads past the record.

Reject a section whose error_data_length is negative once sign-converted
or larger than the remaining data, before the size arithmetic runs.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=1
Fixes: 45b14a4ffcc1 ("efi: cper: Fix possible out-of-bounds access")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- New patch. Fix the signed error_data_length overflow that lets a
  crafted section bypass cper_estatus_check() and defeat the per-caller
  size guards (sashiko).
---
 drivers/firmware/efi/cper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 06b4fdb59917..99a86b2675e3 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -765,6 +765,16 @@ int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
 		if (acpi_hest_get_size(gdata) > data_len)
 			return -EINVAL;
 
+		/*
+		 * error_data_length reaches record_size below as a signed int
+		 * (see <acpi/ghes.h>), so a value with the sign bit set can
+		 * wrap record_size small and slip past the bound check. Reject
+		 * it before the arithmetic.
+		 */
+		if (acpi_hest_get_error_length(gdata) < 0 ||
+		    acpi_hest_get_error_length(gdata) > data_len)
+			return -EINVAL;
+
 		record_size = acpi_hest_get_record_size(gdata);
 		if (record_size > data_len)
 			return -EINVAL;
-- 
2.55.0

