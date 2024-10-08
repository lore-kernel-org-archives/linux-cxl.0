Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548E1E0E16
	for <linux-cxl@vger.kernel.org>; Tue,  8 Oct 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406009; cv=none; b=S0MFMZq+nuxcDV8hKsdmzJQ8nzWlpw95VRv+j8/X1cQs0PsWTE4zoe5tsl9q9hT9/X3YlAHgFEtLvOsljqecIokt20axBBi5SiBkrfZfJdKAXvBWOSad+5JpbqilZKK5FUkOTZaFEGB4SoMSy+KWd5OR9Ketb6oLp8/gIboq2nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406009; c=relaxed/simple;
	bh=oIEpobW89N9+KK4+Tz7Db2dMNiBEtuLSPOjUnJIZFPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COC9trsTwJmYUXkUnPHWkRELVQdgB+9lxzxIKEqvAx2JhzHscl/0Ufy3trGmTotaHHpLmD2B9GyI8StrwK8fYeJHeE4HIdUPxQVK+tWKclEh70GfUBZtOUC+j6AV9sa/RpRO1ew3Pp6xgM6SqXKQLD2jRo2yT2WG4vQWQLb3DNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRUspVCd; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRUspVCd"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e129c01b04so47389667b3.1
        for <linux-cxl@vger.kernel.org>; Tue, 08 Oct 2024 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728406006; x=1729010806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VZ6DCcUZIpjkjbo+HdIBkZWSoiW8VwPF5vcnXRm5F/c=;
        b=HRUspVCd7CA7e4jTZxWns6ZCcTLi/4g1Jtt1wMrggGtaue9Jm6zUTJWDHiRXRyQ+w7
         r6KHK1ETxllaRzhVDaTDNH7/culXIyiIEP39qbVTTCQRi1Oz0ECjxaoQxd0lsRPMreTo
         vBR7FVUCQfFh3/H4OmGQk5L0eTyj0DWPfivMInrEIJxZXKsta3Bsco/jiilnvbMcmgJ+
         Lgapv/lUmBbgHpMyMjffNq0fTkVxDte456w/nEMj1IyZWJ5R0d1K5x1DEbIDH7r+Hz72
         ratqku8AagP5dkd2S3wfnvmsoy7kx4vitAFxp5PykRZyX8hkEry9pxcIRQFXHKTmt5Mt
         eoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728406006; x=1729010806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZ6DCcUZIpjkjbo+HdIBkZWSoiW8VwPF5vcnXRm5F/c=;
        b=FGqhdOMdgXymOYcGXXkUkGJaKBjllXavjLIHhWCOUXIjt8hfOAtQBBqa3vCHM+4fhk
         uvNHvCLfpu8Zqv0ZWnXiV2naifV1rH9YtkRrWT/ICF7XFVCZBmXCHAWHfG/33WhxrOnB
         A+FQ5XMp6kQDGHE+CnyuY0QswFazvDHU5ULhstnRSVIzAoWqrrbKLdD7on7BFkgM7Mbd
         fHBGIKA+fzmZLGttnE6vxKyw/gf/X1JqTxQFLT4UlETcji2d/eVyCk1vqIiN060hNw5t
         5hDxeXYZ3pCqHr8WlF42iDuh3WflDXFIoM7/JHnbHRGmobQkXhmxmatszfEeHPNeTPsM
         ofYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwUOGSW8UBfPbpgRaSA+iroKtFyu4Snn3cbJjml4c6wu5xwInG6LNbtIayK/Z1pg/sN/jxrt2VEt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYW/B3B1e6tyYNSxrQKnTLU5eE11O7a/ilj7yJOmJ5FnOeXfi
	x1FPPDsp0fMvL/E+bK/09RmiH3YSLKZ3IOu1M3jWaupmC2xenWIv
X-Google-Smtp-Source: AGHT+IHIAkPgWXq889nUNPQVkfBDdMNYDtX2A5WPUAZtxx3p+5qTBrz4vYbkueDHvb3dy+IAHwcXnA==
X-Received: by 2002:a05:690c:2d03:b0:6b1:61e0:5359 with SMTP id 00721157ae682-6e2c723f257mr103013247b3.21.1728406006535;
        Tue, 08 Oct 2024 09:46:46 -0700 (PDT)
Received: from fan.. ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d9387db8sm14978437b3.59.2024.10.08.09.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:46:46 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	abhi.n@samsung.com,
	alok.rathore@samsung.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH] cxl/cxl-mailbox-utils: Fix size check for cmd_firmware_update_get_info
Date: Tue,  8 Oct 2024 09:44:47 -0700
Message-ID: <20241008164624.78608-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

In the function cmd_firmware_update_get_info for handling Get FW info
command (0x0200h), the vmem, pmem and DC capacity size check were
incorrect. The size should be aligned to 256MiB, not smaller than
256MiB.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9258e48f95..c82ad50ac8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -649,9 +649,9 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
-    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
+    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-- 
2.43.0

