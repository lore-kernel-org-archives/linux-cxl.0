Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84E1F4CB3;
	Mon, 23 Jun 2025 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750667934; cv=none; b=YEvrAnXE960fZvuI1YyB3JQnhpR48Q3JGiTUWkeWr+73pmEEk2xogoAvu7J9Vd7SzIBwoxX7eOCTj0sTDyz3isI/8ye54+kUu7QX79GYXVr2vAWGmO/3ZR3IoWIuMfdJI1lNGpmKP+BzzkZmh27S4XwuBfqe4oDD0xmpwBCVKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750667934; c=relaxed/simple;
	bh=KPTfA+lD82RyS97lfltBlDwFaXpnQXlrck43kgnV2pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hBw5bdH51gdi73bL6/4JTHSGZPk1OMbafu0R+FpYqqpcFk0ryGANpKp8HopbJ8YVeTBIM8BGiDq1I8p92K4InWm9vezetzpWaqHk9OLb+ThAFnD5UQdu++VxNUkPsgG564hvYlqKlRDx85Kv8EmWuSyqortOW3n/+LtaAgIH4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAaIMywU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAaIMywU"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so2917514b3a.0;
        Mon, 23 Jun 2025 01:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750667933; x=1751272733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PyVVTWaZgryZ9TMNe9jpkxLwz3WmJyduY+dRovtnePo=;
        b=PAaIMywUzuPrJF8Z0XrCE+DZjPfsvL8Lua1lekfife5QOQc8aasFaGPuFXxrHf2k/R
         g1rd1uT8FQcyfIY185zYI+uheBFOCCh05c2hBIqbMJRPFAQz8AA20rmoRe6F1QEkLpqn
         lFJg1R4ZVCa36TWAgvguTuAsXCMXIrSBUGDluwYrn6gSYcuDkJavIUUelH08hT7KQILR
         nzYrcxE51zETRYUsixruSkP6nlzFcGNHPa21LKfcYv5tTzPavN8L4/YXX3+mjhCATGfx
         mNXDTFE76uF4K+B2e4fhjDzfv5CWPxuLNx1sr7utBUMe3SHdBDPVngbY7k4QjPOPl60E
         UcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750667933; x=1751272733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyVVTWaZgryZ9TMNe9jpkxLwz3WmJyduY+dRovtnePo=;
        b=K8jOKfOx6hZ8OC2FDjg8tDsbHCgwr1mUyoButzJtsE1c+UFEiix6u5OTiVKP4QecEG
         GOKc2p9Azm3Sq2HdrrUpxUrk83kjSbOjlNMdLDDOMxQ9BDoE2SJWNqvWQFWbn/FGjIgi
         19hRzVMT8Wk5FRUFFfWYxRUEW3/7gETzhywS0wLt2KzWMFqlpPfshOcN/VuDj4TYzhFW
         t8YcvlabJzqmLAnkRzbgQnHUmXc6PPPn4KtVKlwiiES19+8A4kJdR1vYvAjw4cPfjhYb
         unCoJ9jykrqxzK+f9f1lPzBFMAXbWOvc1tL9D/KBMaxznuuL4S09EP1grsuU9lDvDApL
         LgaA==
X-Forwarded-Encrypted: i=1; AJvYcCV1HaGaCQHCyoBF7cnDK+MXu/bClpO42rUjtKoh7STA/1b2SjYuekHJeuFyyxB1Gpwwl8X1BzZygmp9UOc3@vger.kernel.org, AJvYcCVzTg9h+lL45cDv60M0leUpjngJAx5+S/EkCaKyzEV3U71AA04K+wEhN/wKzogs5RQoGSE/3gVFY34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5e8/vMwi64tdx7sOHbJoZOB8Ecdg6X91FkbTYu+C7q2ZcIZD
	jcg8nZLBMjTqGJ11EWg178fUh2laneZkf9hyLfN6/arwOPUM7RLRO5EU
X-Gm-Gg: ASbGncv8zin2hjWKkqqPtc/DeYAwWPb0Gw9JTU/xnXwv3t2KTaeFWHZMZzRH4Cj+va7
	8CwvlqTtbcHHMyoHrn8feLDlXaFwr5fvrX4sFxQHq3cu5db6gZ1UKnWPkbtadBgyNDxePGDITyL
	vRbMKCHh+9uxq9EwzOWPyTg08GlgcRAnG/Out50hFsdIDXYdsr8HLq1+tJNTEWF2smdh0fbUFd7
	7RhnylRLYApyIXIxBZrFNjOv1UCBv91cYGXg32H8+l59MHMu6dwBbcf7XguOqTgz+hGxKsypzOF
	dxWf9QgSz6dWPL7AdnuA7PzhuIqcvm36FXMRBH7jrFRkJEnAi7WK2TGuQxqhHP2U84x36ur9kD6
	FeQoGayE=
X-Google-Smtp-Source: AGHT+IGUeFiCv00KVBMrpOmKRu6YCsOh3f2syfhlZ6O0RFPGj97gwW+e+gn6L9Eq8La3deVTY0MrQA==
X-Received: by 2002:a05:6a21:6d91:b0:1ee:ab52:b8cc with SMTP id adf61e73a8af0-2202934b9e0mr18197566637.21.1750667932543;
        Mon, 23 Jun 2025 01:38:52 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c66:8091:47dd:9377:3ab1:4e4c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1258b55sm6209442a12.61.2025.06.23.01.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 01:38:52 -0700 (PDT)
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
Subject: [PATCH v2] cxl/memdev: automate cleanup with __free()
Date: Mon, 23 Jun 2025 14:08:41 +0530
Message-ID: <20250623083841.364002-1-pranav.tyagi03@gmail.com>
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
 drivers/cxl/core/memdev.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f88a13adf7fa..38f4449f9740 100644
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
@@ -802,11 +803,10 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
 static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
-	struct cxl_mbox_transfer_fw *transfer;
 	struct cxl_mbox_cmd mbox_cmd;
-	int rc;
-
-	transfer = kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
+	
+	struct cxl_mbox_transfer_fw *transfer __free(kfree) =
+		kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
 	if (!transfer)
 		return -ENOMEM;
 
@@ -821,9 +821,7 @@ static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
 
 	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
 
-	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
-	kfree(transfer);
-	return rc;
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
 
 static void cxl_fw_cleanup(struct fw_upload *fwl)
@@ -880,7 +878,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct cxl_mbox_transfer_fw *transfer;
+	struct cxl_mbox_transfer_fw *transfer __free(kfree);
 	struct cxl_mbox_cmd mbox_cmd;
 	u32 cur_size, remaining;
 	size_t size_in;
@@ -949,7 +947,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0) {
 		rc = FW_UPLOAD_ERR_RW_ERROR;
-		goto out_free;
+		return rc;
 	}
 
 	*written = cur_size;
@@ -963,14 +961,11 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
 			dev_err(&cxlmd->dev, "Error activating firmware: %d\n",
 				rc);
 			rc = FW_UPLOAD_ERR_HW_ERROR;
-			goto out_free;
+			return rc;
 		}
 	}
 
 	rc = FW_UPLOAD_ERR_NONE;
-
-out_free:
-	kfree(transfer);
 	return rc;
 }
 
-- 
2.49.0

