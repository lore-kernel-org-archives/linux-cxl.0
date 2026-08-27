Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583E2D662F;
	Thu, 27 Aug 2026 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863060; cv=none; b=lsLG9R7ZBl+cTmjVOECXh+Exx+Lvpsi2cLg2+nSGaH3scwZtq5t7OVin8h9+NGPLuG3qhecXIwfnr6FmXtmPJPi3QsPWiJSnyNdcM88wCjG/89zbL0oKR740NCcfs1liyeunteZ1USFHvLUfCAdr3ouAMKMT+9SCu2Kq7neZo3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863060; c=relaxed/simple;
	bh=y/tmW1hvUfO0381BJPP72AzywlW8py6JE6Pp1Jpt9nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSzAsjkdUfM5Fh98bQ/CIBEeVD2xh5lni6ULWMw6e/SbMpmMlcaPJowk250u7nyY3NnKQ34OJcUv0BMhN54c/KtuolOy//qHXNJN/8FjGJhdNr00zZ8f/OitXCWL/pLxtFrPE7ht6xORBon37xv7H+9b0ysruXPI/bDzgt2coTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EC31F00A3E;
	Thu, 27 Aug 2026 20:37:33 +0000 (UTC)
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
Subject: [PATCH v5 03/13] ACPI: extlog: Validate elog record length before walking sections
Date: Thu, 27 Aug 2026 13:37:16 -0700
Message-ID: <20260827203726.3027541-4-dave.jiang@intel.com>
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

extlog_print() copies a fixed ELOG_ENTRY_LEN (4096) bytes from the elog
record into elog_buf, then walks the sections using the firmware-controlled
data_length. Nothing keeps data_length inside the buffer, so a malformed
record walks the section pointer past elog_buf and reads adjacent memory.
Unlike the GHES paths, extlog never calls cper_estatus_check().

Reject a record longer than ELOG_ENTRY_LEN and run cper_estatus_check()
before walking the sections. The length test alone is not enough: a wrapped
length reads back short and passes it, which cper_estatus_check() catches
via the header check added earlier. Drop a malformed record with
NOTIFY_DONE and without MCE_HANDLED_EXTLOG, since extlog did not consume
it.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=6
Fixes: f6ec01da40e4 ("ACPI: extlog: Handle multiple records")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Expanded the comment to say why the length bound runs before
  cper_estatus_check() rather than after (Jonathan Cameron).
---
 drivers/acpi/acpi_extlog.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 7ad3b36013cc..046e92ee195f 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -208,6 +208,15 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 
 	tmp = (struct acpi_hest_generic_status *)elog_buf;
 
+	/*
+	 * Bound the length before cper_estatus_check() walks the sections: it
+	 * iterates over data_length, which is not yet known to fit elog_buf.
+	 * cper_estatus_check_header() then rejects a length that wrapped, which
+	 * the bound cannot see.
+	 */
+	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))
+		return NOTIFY_DONE;
+
 	if (!ras_userspace_consumers()) {
 		print_extlog_rcd(NULL, tmp, cpu);
 		goto out;
-- 
2.54.0

