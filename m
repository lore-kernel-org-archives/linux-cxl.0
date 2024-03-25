Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115A748A
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393503; cv=none; b=UgpyO9vDYB6wvO76tiGaXPZ/+7v1aOtA1/lV5G6N8HfOfM3zu+kF2efujYcYRNzK4h4w4S5c5NK3Mrt6bwV0wDVsmEvbszZzJ0OYpYtFV5z3WA/99cjCfPd2/MhMR/skxHak8NFkxvxxKcfL3NMCZE2EB0Ejav/SJVHFxr6QLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393503; c=relaxed/simple;
	bh=CZzdOAcOeX/C0dqOhd8+qNxV7JSySd44+FqRVJgf21w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvQi7oyVcJUXjiToH5vkgSHN0z+HisvyEGMO31l1jWPx0QmQhAZ/cSPwbiSd1TX3BPMrqrDmB1ZAX1uMhOUVplO24UDGPOfM+TZD1fAyzl8Ob7D8+vaTabDzuiXIf7fvBLq+dib8jG0av7TriSWjCsX1AhTljv30hbuFhr9w1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwX+0hFA; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwX+0hFA"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c89cd8df36so96297839f.1
        for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393501; x=1711998301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eyoni5qZtSKjt9z3QzKJDUPa9p/nHFzydRxiuFbxHok=;
        b=dwX+0hFA/5Q7mqBjP3PEomIgVWsKzKpuxnOMr349tqQZZBp5Mey4+cemu+zl+GDdBh
         KC6iRw/T5Lh+cJw7fbCTGkV2n0JGPP/YyxWx72L60/RchH7TuTcJY2U3pdiC7VE2WUY3
         vaXftZd9A7zgdNdfZVKFy3Y51kYa0vOUopFiTAn4nlEVp7zejIUtmb/45nSZuxeFlbGN
         T/Z8jF8JlCNhD5qzVgLPQM2+cQ1zRCd/w/W1y5y/iH7O12Saawcgflok3POXsr+fXq2o
         LpbvusyiTGXFW43H3cSUAAK9uVahxo4k2Uk4r1drNg9hRgF39UovtIqVPrZZysNv4i2O
         M3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393501; x=1711998301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eyoni5qZtSKjt9z3QzKJDUPa9p/nHFzydRxiuFbxHok=;
        b=etwT++AO0oQZT6Vq6TgmBFPMazCkLLvNW1ESkLGljl/+Y+fahX6AOLLA8408KWmDfZ
         rvg2cKy7hVBp5KPEJ6u7Tce2MbJbh6VMrgnXe8oVofnicgHE5KRK2KLpV5OeFvtJQzhG
         lNprAaYpIfJ9yoN0PbH6HgV+vFmT2cjpvIZP/AOQJ0dz/Smwnx9FX6v8vX8kew3zWUs1
         3haU+Z43i70Q1vfh/JgyLlj86j9/8D3KKvIF8xgZgPRGnFPQwtGUXQK4AvcOaMNAlsDY
         ZI9nbkMUa1UA6VUbZ+GqUgqP0TlGtm5qeyUBVtMpnVoyIFcf13MIsUAvDYzzTCQhedh0
         uwcA==
X-Forwarded-Encrypted: i=1; AJvYcCXIChcXnqHFD8d8pnio/ZqPP5sXUQHp0Ivz9OTr3RI5hE9CrEqw1H0/sSDTn+rMsWIZfCG9y6GMB35U9FauZ5YQeL3U28dOicKg
X-Gm-Message-State: AOJu0YzLgSO93ZiaUayVTiIqkX7o2iWb7Qc3E3ulwsdUtxMqmd8M07N2
	NDbwRjJNya66ul39KKJlmAPd9hkRBH2LuhlMfV/pHZ+M0H4Yl5HfLg021SnI
X-Google-Smtp-Source: AGHT+IFFOVVYKVLk+nUgND3cD8rgUQNgsrXraNM2gggO8CtW2mKT/2B7DOt2cMvN8p4yrw0yaEYmJg==
X-Received: by 2002:a05:6602:c5:b0:7d0:3d39:5fbc with SMTP id z5-20020a05660200c500b007d03d395fbcmr7642622ioe.1.1711393500891;
        Mon, 25 Mar 2024 12:05:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:05:00 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	gregory.price@memverge.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v6 11/12] hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
Date: Mon, 25 Mar 2024 12:02:29 -0700
Message-ID: <20240325190339.696686-12-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

With the change, we extend the extent release mailbox command processing
to allow more flexible release. As long as the DPA range of the extent to
release is covered by accepted extent(s) in the device, the release can be
performed.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 41 ++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a0d2239176..3b7949c364 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1674,6 +1674,12 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
 
+        /* Check if the DPA range is not fully backed with valid extents */
+        if (!ct3_test_region_block_backed(ct3d, dpa, len)) {
+            ret = CXL_MBOX_INVALID_PA;
+            goto free_and_exit;
+        }
+        /* After this point, extent overflow is the only error can happen */
         while (len > 0) {
             QTAILQ_FOREACH(ent, &tmp_list, node) {
                 range_init_nofail(&range, ent->start_dpa, ent->len);
@@ -1713,25 +1719,27 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                             goto free_and_exit;
                         }
                     } else {
-                        /*
-                         * TODO: we reject the attempt to remove an extent
-                         * that overlaps with multiple extents in the device
-                         * for now, we will allow it once superset release
-                         * support is added.
-                         */
-                        ret = CXL_MBOX_INVALID_PA;
-                        goto free_and_exit;
+                        len1 = dpa - ent_start_dpa;
+                        len2 = 0;
+                        len_done = ent_len - len1 - len2;
+
+                        cxl_remove_extent_from_extent_list(&tmp_list, ent);
+                        cnt_delta--;
+                        if (len1) {
+                            cxl_insert_extent_to_extent_list(&tmp_list,
+                                                             ent_start_dpa,
+                                                             len1, NULL, 0);
+                            cnt_delta++;
+                        }
                     }
 
                     len -= len_done;
-                    /* len == 0 here until superset release is added */
+                    if (len) {
+                        dpa = ent_start_dpa + ent_len;
+                    }
                     break;
                 }
             }
-            if (len) {
-                ret = CXL_MBOX_INVALID_PA;
-                goto free_and_exit;
-            }
         }
     }
 free_and_exit:
@@ -1819,10 +1827,9 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
                     }
 
                     len -= len_done;
-                    /*
-                     * len will always be 0 until superset release is add.
-                     * TODO: superset release will be added.
-                     */
+                    if (len > 0) {
+                        dpa = ent_start_dpa + ent_len;
+                    }
                     break;
                 }
             }
-- 
2.43.0

