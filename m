Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF12BFC7B;
	Fri, 17 Jul 2026 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305025; cv=none; b=SHq+ozryYSh5DrYYjW/NkDklV2Windi25HL0orUkfrEyfRKsKBN4nZj2JcsfPTlJO45tTT844Zl0wRsKo0ftH+XKMSZSJEKhJqgaAyIR1aUn7Au4VK3pFlXhwDt36Pz8siSyyJ8sGfNEDgPx2DSn+ZQ1KBERySRiiEXUSl26NAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305025; c=relaxed/simple;
	bh=Y87/0sGWahN2SvXEmGa9jixnkEGvO+sjLIKberF4ACw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVpAGQPXuUqX+Wlf/IwKpcWpqR1h5DaYnyynRSkU08GND1her3jlHGNmjBHNZE6AH7CmBv8g6OSv/Ge5zyCHDMs9TMLcP1JscJflYqpPRZ+ToDB7m6Y2xOuR9S42VPCSrOOOqCvHZaqixd9Rm4ts2iJLa9nyru8nIqsFdDEhthQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C451F00A3A;
	Fri, 17 Jul 2026 16:17:03 +0000 (UTC)
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
Subject: [PATCH v3 10/10] ACPI: extlog: Validate elog record length before walking sections
Date: Fri, 17 Jul 2026 09:16:47 -0700
Message-ID: <20260717161647.1493259-11-dave.jiang@intel.com>
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

sashiko-bot flagged a missing bounds check on data_length that allows
an out-of-bounds read of elog_buf.

extlog_print() copies a fixed ELOG_ENTRY_LEN (4096) bytes from the elog
record into elog_buf, then walks the sections using the
firmware-controlled data_length. Nothing checks that data_length stays
within the buffer, so a malformed record can walk the section pointer
past elog_buf and read adjacent memory.

Unlike the GHES paths, extlog never calls cper_estatus_check(). Reject a
record whose length exceeds ELOG_ENTRY_LEN and run cper_estatus_check()
before walking the sections.

A malformed record is now dropped with NOTIFY_DONE without setting
MCE_HANDLED_EXTLOG, reflecting that extlog did not consume it.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=6
Fixes: f6ec01da40e4 ("ACPI: extlog: Handle multiple records")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- New patch. sashiko's review of v2 pointed out extlog walks the elog
  sections without the cper_estatus_check() bound the GHES paths use.
---
 drivers/acpi/acpi_extlog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 1fbaf134c04e..30863fd3f5b0 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -200,6 +200,13 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 
 	tmp = (struct acpi_hest_generic_status *)elog_buf;
 
+	/*
+	 * data_length is firmware controlled, so make sure the record and its
+	 * sections stay within elog_buf before anything walks them.
+	 */
+	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))
+		return NOTIFY_DONE;
+
 	if (!ras_userspace_consumers()) {
 		print_extlog_rcd(NULL, tmp, cpu);
 		goto out;
-- 
2.55.0

