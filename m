Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD142F6FF;
	Tue, 14 Jul 2026 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071138; cv=none; b=TzAghjSVGpSX3awYuGIcd3GeZHsItti8fn4+DGyqnT9nOTLxHNZ4wdgqyBPBCmGSekJm3bd12Za+2MIa4uM5hf+6yikEeErX+uQFOfXSuuMQD2RB4z8mOvHh9A1HxTWEsKdbvg+mQZdk8i5sbVWAkAd7jDfthVqwoVc7osHEb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071138; c=relaxed/simple;
	bh=MSaYA5WcY+sHKNhzb/na0roVShFJIOoi5aNje1w8TXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hp6LIXFhBCb0croOORR4N3zK+iDmug6BC2Fcves87RFbDTy06sPz777SaCVwVaWzmpyaLTw4wIakptjfIwlvn3h/wyfa8YJH67Qtp/+G+8X6+irUVBoSeklW5436CEP9otyN0L8C/nU3p04vkfNfRoiMZUzCIA16G9/KQiQgi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304F81F00A3A;
	Tue, 14 Jul 2026 23:18:57 +0000 (UTC)
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
Subject: [PATCH v2 7/7] ACPI: APEI: GHES: Validate memory error section length before payload access
Date: Tue, 14 Jul 2026 16:18:35 -0700
Message-ID: <20260714231835.303081-8-dave.jiang@intel.com>
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

ghes_handle_memory_failure() dereferences the CPER section payload
(mem_err->validation_bits, and mem_err->physical_addr) without first
checking that gdata->error_data_length is large enough to hold a
struct cper_sec_mem_err.

Fixes: ca104edc1784 ("ACPI, APEI, GHES: Cleanup ghes memory error handling")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- new from issue raised by sashiko
---
 drivers/acpi/apei/ghes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b36f6d268c9f..e8b2980bd5fe 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -535,6 +535,9 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	int sec_sev = ghes_severity(gdata->error_severity);
 	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
+	if (gdata->error_data_length < sizeof(*mem_err))
+		return false;
+
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return false;
 
-- 
2.55.0

