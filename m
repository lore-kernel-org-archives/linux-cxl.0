Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184A1DE4E3;
	Sun, 22 Jun 2025 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750594214; cv=none; b=KaPxSCwnB0Z3rfBKucX4KmOorRqpoQzZaHB6fCquGpF4N2x4VieILo4mGXdsdH86KLjhYYTWqBy317jNOv5p/8mkPm5GPOISunTU+Hm34SDH11/EvAUcUp5zxarp+0AckOKz9CqohQ6HpAgnzeBLJQOHyvSVdZR/U3wO9pCi1Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750594214; c=relaxed/simple;
	bh=GPJghAiVi7VOk63edVJqM24DcZ/CIPgZ1+4yLmkPb4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCqos7qczZicQ1IHz9QLgHK+QhdXNEoLKH2UUkkCJHvJeIilPI1JX/KqCH7gWK310IPOtwUdxixWk2DVPe0tOjkVTgi8Y5vl45zKLs+AlbbE3liDKmteV2fF+NGbvpGNZOh/Nzp0MgqcqguTXEgAdpoglmlVizMWfEhe4axwSow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAAvbHFk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAAvbHFk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-236192f8770so22326555ad.0;
        Sun, 22 Jun 2025 05:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750594212; x=1751199012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGN8wUzqZT1QG27/qcAPHinagutLgUrz9NBWB07ySsQ=;
        b=dAAvbHFkVVxhUIg1AtDITO5hD+Mvd+gYytcYMm1yXJ7NJJM9l6qNOIMRrBhbtPYZI7
         H2QXFa57EE0sbZG5oU3+EBtNtZs0wPAtzGuLHBEuSWCi/lL0fuKsAG6aXduvWCAdpPjL
         DhhntIdkp6Q1KanO4a/bD5kDmzog3WGySCTOS785bZpETjivvLAnkPLinbCbwZu+7TVT
         P9nHjB06P48XHkRzlvvQXp9mvVnOZ9WpaMfCR0CeBiv+JzgN+bfCbH6H346+qA++yQS5
         TPnStUdH+bwljvsRm0LaIcITEuM3hrb21gnFM2QAE7TFvihf5wrZ7AO9qGe9aVYSe4KH
         7Ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750594212; x=1751199012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGN8wUzqZT1QG27/qcAPHinagutLgUrz9NBWB07ySsQ=;
        b=UtAJkCVJYtNTijs3q5q/2D5VfMCxt1CKT1Nbgm7dHduJAFY6RVjdG6/R+jj2CW9bs+
         HHaxUe/rLFrint9vXBDuvpTbh+W9VsDPwTl3mqV1+862yXFi4n8SX8P5tugrZ5eiQdNM
         jZt5yFX1i4WI37VtCeiN7if5i9CyXCYyKIhTBjvjJygUtevXuVR1kLhok1ZkobJFhyPG
         l7z9kKEGnDweZkYqxtaCyNLI9bhYASHGVqqytjVfLmYGHfzNVgiTLfNfXHs7KvdVEzDo
         mqcUcSJr6wG18rTqwRcvhDPxsu872N0cZ0YYy4EFXtA8PxDzWAIXZsvX15PkpZSwq9CI
         SN9w==
X-Forwarded-Encrypted: i=1; AJvYcCW+0vPeuMC6XrOuReFdIZMG1bBf29nJ8uAc490s7ClDheQ95Ptl07Jg9a9dD+bQuSBS/rstU+ByXEbdFizi@vger.kernel.org, AJvYcCWukHkaP1MMTKepDNTEuBm8YpwixCh+7GPIbmapgHOPQ2FqssezarDMtMytuYnqAuumVIpV9lP1I0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVijrRzbf/zz5QdzBvJra5Xyw64YzeYpGGCNNx52xCALmxKoUp
	6v2cZVgcCPYH5NMFTxDQT3CN9z4Gpa0HvtCmPxO2iGgbsZgWvQtZjbvP
X-Gm-Gg: ASbGncsn16bT68oRwQWZLSEdun05i2xjpMdJWY4I2TiO+EIkmk0rH1N44M9YI6Ww7yj
	YHUVQdicb8hJdTE0KwwbRlaDK6vD76rVtDcBVxLzfByC3m5pplK1uDsKyN21pzt4NEhaAmE9etX
	YMudobZnvTBx+nMGAHM4f/I7k4AQ30NuZaY9j7S3IiAVklGafMzcOcMLFcAl19LscEbTgw4Gatm
	DFI9xGh9JapgB0k3Oah1S8BS2hEVH7oGLx/+VWEiESTHBGbSWK3w5R+BoQ03udf0XA1G5DLZlmB
	oO5UJgJDyPYM196Ru/QrnDeGoB/U15jXInb/qFapxAFiq6hVGUeob0IYw7NZbCrA89A3J2JSSjm
	gTRLHC0b9Vw==
X-Google-Smtp-Source: AGHT+IGvdawMvIJY2ifIVY5mQKrQfzDv/WHMHmDJxnhRFUaxlfdkEFCX9tHKTzTnj0IwvQ5q9m5ElA==
X-Received: by 2002:a17:902:e54e:b0:215:6c5f:d142 with SMTP id d9443c01a7336-237db0d5a62mr114971305ad.20.1750594212310;
        Sun, 22 Jun 2025 05:10:12 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:a059:4a3d:406c:f7fc:472d:e49b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86f381bsm60677085ad.220.2025.06.22.05.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 05:10:11 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.li@zohomail.com,
	rrichter@amd.com,
	peterz@infradead.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] cxl/memdev: automate cleanup with __free()
Date: Sun, 22 Jun 2025 17:39:58 +0530
Message-ID: <20250622120958.475765-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the scope based resource management (defined in linux/cleanup.h) to
automate the lifetime control of struct cxl_mbox_transfer_fw. This
eliminates explicit kfree() calls and makes the code more robust and
maintainable in presence of early returns.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 drivers/cxl/core/memdev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f88a13adf7fa..be73a6099cb6 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
+#include <linux/cleanup.h>
 #include <cxlmem.h>
 #include "trace.h"
 #include "core.h"
@@ -802,11 +803,11 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
 static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
-	struct cxl_mbox_transfer_fw *transfer;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
-	transfer = kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
+	struct cxl_mbox_transfer_fw *transfer __free(kfree) =
+		kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
 	if (!transfer)
 		return -ENOMEM;
 
@@ -822,7 +823,6 @@ static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
 	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
 
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
-	kfree(transfer);
 	return rc;
 }
 
@@ -880,7 +880,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct cxl_mbox_transfer_fw *transfer;
+	struct cxl_mbox_transfer_fw *transfer __free(kfree);
 	struct cxl_mbox_cmd mbox_cmd;
 	u32 cur_size, remaining;
 	size_t size_in;
@@ -970,7 +970,6 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
 	rc = FW_UPLOAD_ERR_NONE;
 
 out_free:
-	kfree(transfer);
 	return rc;
 }
 
-- 
2.49.0

