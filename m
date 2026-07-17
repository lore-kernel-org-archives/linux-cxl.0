Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298633D5C0C;
	Fri, 17 Jul 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305022; cv=none; b=muRqiASj+5a8LLVUFJRGJnELSx2ThsTXCs07z1+fxUE1yRJ7602ieUFwe/72eqO1scc76lmlHCjdXkea0TXSsI1tJxTkexON2y/cjpq+x3K1wCDr0n7nzPMiNb6M0vxcvQmXN1aD3eKNTyHzH5tRZQMYIiRhl9Us5lBgcYegBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305022; c=relaxed/simple;
	bh=SwW40a7PWCyLB3jcsO9Xmb3+BwjbdoTT6+quMKAR5M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8f98tuYe9yBv5yCFvwsXwCbdCNgYtsIcH2aN/wG84jIBK/L5/pTQ20IdrK270Io2QHik2c+9KXPEphyiP3v5IjsrigZRjuP+NFFDkMy2x5iO/NMDtxEll8NJJpcnrsNcliGAggO4ydcA1dqE2phiBowLPPfq+SHhPeaf9LM7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80991F00A3D;
	Fri, 17 Jul 2026 16:17:00 +0000 (UTC)
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
Subject: [PATCH v3 08/10] ACPI: APEI: GHES: Validate memory error section length before payload access
Date: Fri, 17 Jul 2026 09:16:45 -0700
Message-ID: <20260717161647.1493259-9-dave.jiang@intel.com>
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

sashiko-bot flagged that the memory error length check was placed too
late, leaving the other payload consumers unprotected.

ghes_do_proc() hands the CPER_SEC_PLATFORM_MEM payload to the report
chain, arch_apei_report_mem_error() and ghes_handle_memory_failure()
without checking gdata->error_data_length. These read validation_bits
and physical_addr (offsets 0 and 16), so a shorter section reads past the
record.

Validate error_data_length once in ghes_do_proc(), before any consumer
runs, so every consumer is covered. Bound against struct
cper_sec_mem_err_old (the UEFI 2.1/2.2 layout) rather than the full
struct: the section length is authoritative, older firmware legitimately
emits the shorter record, and the trailing fields, though packed
unconditionally by cper_mem_err_pack(), are only acted on under
validation bits that a short record leaves clear. This matches the lower
bound already used in drivers/firmware/efi/cper.c.

A malformed sub-record no longer reaches ghes_handle_memory_failure().

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=7
Fixes: ca104edc1784 ("ACPI, APEI, GHES: Cleanup ghes memory error handling")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Move the length check into ghes_do_proc() so the report chain and arch
  reporter are covered too, and bound against the older UEFI 2.1/2.2
  layout instead of the full struct (sashiko).
---
 drivers/acpi/apei/ghes.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b8dbd99da47e..1d2966a437bd 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -940,6 +940,17 @@ static void ghes_do_proc(struct ghes *ghes,
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
+			/*
+			 * Several consumers below dereference the record, so
+			 * check the length once here. Bound against the shorter
+			 * UEFI 2.1/2.2 layout that older firmware still emits;
+			 * the extra fields are only used under validation bits
+			 * such records leave clear.
+			 */
+			if (gdata->error_data_length <
+			    sizeof(struct cper_sec_mem_err_old))
+				continue;
+
 			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-- 
2.55.0

