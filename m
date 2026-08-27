Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452C332917;
	Thu, 27 Aug 2026 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863077; cv=none; b=kHTCnp/5fW/qW067cAvNzLAXzWRKeDw7WF9ET9wd84tknYITtvoeDdxJV1pWWiOzupAurmuvuEXl06ODXAVbh1gM4D7kHIkd9XySVnmLzsJI/PIDYDvspj7vVFTlyZgfuU3nG+XPfmKohBnblK7j8CnrLiEHnWa5OgNG5mrAs1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863077; c=relaxed/simple;
	bh=8gvcXl/+mbtLOhoH/vFZOrAVO9ybP9F+upi8ygb2WgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFOdcE4SXQ6ViS/QnA72R51IkJXURwlg4Iaj0sYUdFfoDELZQWXSjxG5Am0dj9dVFMp3qsvE7hZMIk3HzhlHTXWwrEEKnRGUhQUwRO83gYYWeZwmvCKRDFFqGHkNh5oQUs84BIB2657k0W202hdfbxr/SAxT29H6gH0Uh7yS3ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F9C1F00A3F;
	Thu, 27 Aug 2026 20:37:43 +0000 (UTC)
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
Subject: [PATCH v5 10/13] efi/cper: Read only validated fields in cper_mem_err_pack()
Date: Thu, 27 Aug 2026 13:37:23 -0700
Message-ID: <20260827203726.3027541-11-dave.jiang@intel.com>
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

cper_mem_err_pack() copies extended, rank, mem_array_handle and
mem_dev_handle unconditionally. Those live at offsets 73 to 79, past the
end of struct cper_sec_mem_err_old, the 73-byte UEFI 2.1/2.2 layout that
older firmware still emits and that cper_estatus_print_section() admits.
On such a record the copy reads up to seven bytes past the payload, and off
the end of the error status block when that section is the last one.

Copy each of the four only when its validation bit is set, and zero it
otherwise. Nothing is lost: a 2.1/2.2 record leaves those bits clear, and
every consumer of struct cper_mem_err_compact already gates the fields on
the same bits. Zeroing also stops callers reading them back out of the
uninitialised on-stack struct they pass in.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=7
Fixes: 2dfb7d51a61d ("trace, RAS: Add eMCA trace event interface")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/firmware/efi/cper.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 3dcef618ad39..13b3e72c3b62 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -389,10 +389,28 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 	cmem->requestor_id = mem->requestor_id;
 	cmem->responder_id = mem->responder_id;
 	cmem->target_id = mem->target_id;
-	cmem->extended = mem->extended;
-	cmem->rank = mem->rank;
-	cmem->mem_array_handle = mem->mem_array_handle;
-	cmem->mem_dev_handle = mem->mem_dev_handle;
+
+	/*
+	 * These four sit past the end of the UEFI 2.1/2.2 layout, which older
+	 * firmware still emits, so reading them unconditionally runs off a
+	 * short record. Every consumer of the compact record gates them on the
+	 * same validation bits, so leave them zero when firmware does not
+	 * claim them.
+	 */
+	cmem->extended = 0;
+	cmem->rank = 0;
+	cmem->mem_array_handle = 0;
+	cmem->mem_dev_handle = 0;
+
+	if (mem->validation_bits &
+	    (CPER_MEM_VALID_ROW_EXT | CPER_MEM_VALID_CHIP_ID))
+		cmem->extended = mem->extended;
+	if (mem->validation_bits & CPER_MEM_VALID_RANK_NUMBER)
+		cmem->rank = mem->rank;
+	if (mem->validation_bits & CPER_MEM_VALID_CARD_HANDLE)
+		cmem->mem_array_handle = mem->mem_array_handle;
+	if (mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE)
+		cmem->mem_dev_handle = mem->mem_dev_handle;
 }
 EXPORT_SYMBOL_GPL(cper_mem_err_pack);
 
-- 
2.54.0

