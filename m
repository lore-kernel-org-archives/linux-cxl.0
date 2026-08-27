Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A218371041;
	Thu, 27 Aug 2026 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863065; cv=none; b=n7tW+pNlwVaWLL8sgCHtwFsaEo5sBPhIvoaTFsRe49I9DXp9SCBWJSCcwI3scbCbtILIroENE09V6M05lbLaiWChY+CsEI9Rs0e2nIl3bBaSjgHZUmp+/9Yt/yjVfziEbkWr9/cd7S17lt2ppVJIJgEIhhvVgjUJMfVNYjAIC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863065; c=relaxed/simple;
	bh=G2p6iWc4QokKg1eeqAvZn9kCfoir2M8txi1JXkLcUyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzFCyhZcuMPheWXzANsdI+05tW/l470A4WQH9jCHXKHmfZ3kx34wU+mz7/rCUUNVXwl7AETGBFUqRqsbt2h7QP63tWm7NnMuP9vatqfkPmA5IXFFN9tXrByDol3Gch0tyJKCQauJkWvYu/vmhIRHGoxdz8d2G7x9W0IVSpuQNWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27441F00A3D;
	Thu, 27 Aug 2026 20:37:31 +0000 (UTC)
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
Subject: [PATCH v5 02/13] efi/cper: Reject an error status block length that wraps a u32
Date: Thu, 27 Aug 2026 13:37:15 -0700
Message-ID: <20260827203726.3027541-3-dave.jiang@intel.com>
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

cper_estatus_len() sums the firmware-controlled data_length (or
raw_data_offset plus raw_data_length) into a u32. A data_length of
0xffffffec wraps that sum to 0, and a length that reads back short defeats
every bound built on it: bert_print_all() passes its "remain <
estatus_len" check, then advances "estatus += estatus_len" by zero and
loops forever. GHES survives only because __ghes_check_estatus() rejects a
length below sizeof(*estatus) first.

Reject a length that cannot be expressed in a u32 in
cper_estatus_check_header(), which both of today's callers reach: GHES via
__ghes_check_estatus() and BERT via cper_estatus_check(). extlog reaches
neither yet; a later patch routes it through cper_estatus_check(), whose
ELOG_ENTRY_LEN bound needs this to hold.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=1
Fixes: 06d65deade9a ("ACPI, APEI, UEFI Common Platform Error Record (CPER) header")
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/firmware/efi/cper.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 332c78f2d561..3dcef618ad39 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -745,6 +745,17 @@ int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus)
 	    estatus->raw_data_offset < sizeof(*estatus) + estatus->data_length)
 		return -EINVAL;
 
+	/*
+	 * cper_estatus_len() sums these into a u32, and a wrapped sum reads
+	 * back smaller than the record. Reject a length that cannot be
+	 * expressed so no caller is handed the short value.
+	 */
+	if ((u64)sizeof(*estatus) + estatus->data_length > U32_MAX)
+		return -EINVAL;
+	if (estatus->raw_data_length &&
+	    (u64)estatus->raw_data_offset + estatus->raw_data_length > U32_MAX)
+		return -EINVAL;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cper_estatus_check_header);
-- 
2.54.0

