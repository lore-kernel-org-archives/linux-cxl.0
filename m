Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E371B3D
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483040; cv=none; b=qFKxhQDEV/6Sw3uURgG/eflr3s9A9nbG/b1gMUOvwNqIulMx3HMKpkKryu/GDi5L8S8pnw7WJ16SbjFJmbK81onq27YA6htwG8DzP6kaXCNRZgOHgP9fRYQ/9xFIAqkjG9xV1ZN+yWe2DPN7rtL9K/H5zBLyb4aLqC7kC/B7YvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483040; c=relaxed/simple;
	bh=fKQfvxmJJEaAzzudRynJlBCu52ZiuXIxL0lJkEGYdj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qu9XEWrfQ9ZNkuW0loEqUw5O3tuC1xeQTYosxM+ISHKucXk3utPB6j/bDJJbatmDHa4aXKv5+EPZVFQKGVY1LhFg7H9DI9vBvwgEdw9vqHrbr5ovCUXYeQ/sfXKkICDUjVH/9t6mK9kxzP55Qyj45dheOrcIvnNYmnEokN/sLIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWo/YWrz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWo/YWrz"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f074520c8cso1461324b3a.0
        for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713483038; x=1714087838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9/QnnmOfKtdXC4mQDt19ExscjIokR+8yGloQuw3o6U=;
        b=kWo/YWrzMGZFIicv/TT5YuxHN4s15phHlW9IQuFMu23Bm+hz2ytchE7f+/cAbktncL
         A9FsLseNwawnNZuL0o+9lpgJZHVq/RYTqgFP7pAVcLPLBxAqR/L0REKzwZMyztwTc0H3
         zdj5YAMOCNfBpq3U82QZym8rMf46mLDHn4HebYLEsfP7m6wBJR++/S9ai99nK34W0dma
         fv1jrlkbwEOzEyjTKj/rYpv/GLpWLquln/nt9sinCxMKCmOPQDpYC13YcpCaBIuRLHF4
         dI9oGYVQXGnhWBgSrl0dYVPSlF5zGwfZG8yf02kyJa92UfSHcuceqoVLL2YaFQltfH3d
         3MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713483038; x=1714087838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9/QnnmOfKtdXC4mQDt19ExscjIokR+8yGloQuw3o6U=;
        b=jHpB2MpsHOoB0CU/WWA7yz4seXATFOun1q5vmoF7mICLPBIkSlx6otgRNJS/7WuXR5
         LF0Ih8b+0vcBYHVCohubQwwp6B8yX6hT2Whg/o75/Co0VEwQCNrLzW87L5FVucI+JQZp
         D2Ko7yRZC4f8q5ABvKQLLEfuykagmnsdv4/8Q20tgrHhuAOXRiRzmLnpLAuC1xW3MkUw
         vE+m2mgbInSb8HkKr/BPGqqDxOZ7o5hZuI0mkz/sRY4NRQu8sPYH1AZwZOrNnFCD0Tvf
         goQjzhUvhjVdHrR2xiQZFxMGhSXUBBfZrgthU6eV53P3Dwf2b+H5flxdvW4xJnmckf3j
         MWTA==
X-Forwarded-Encrypted: i=1; AJvYcCVd97VyTxipqrFcu3/ODtFLY6hasOblAkQUtG3ly2Ein5tsM8t2U4HwXYVAv/H/F35jv9UK0J8mNoeuszQ+oH+NregE0wQhD4Wa
X-Gm-Message-State: AOJu0YxhZTgGbLxfPYzp1/Eb9Dv6dGNHPhPDsPANHYsWW4oR2S//uG/K
	bcmu/wfIctxm+8zoIH9bst1QrXwqeqtxht2fNg/7sA1svx7621RA
X-Google-Smtp-Source: AGHT+IFxmyePkARZkckg2WodGL2yH1e7nz5yCu71kjTaoavsu6MpQP1H/JH9iZsF6BUah9nvlvDQTQ==
X-Received: by 2002:a05:6a00:1a8e:b0:6ee:1d68:d33 with SMTP id e14-20020a056a001a8e00b006ee1d680d33mr644097pfv.15.1713483038197;
        Thu, 18 Apr 2024 16:30:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 16:30:37 -0700 (PDT)
From: nifan.cxl@gmail.com
X-Google-Original-From: fan.ni@samsung.com
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
Subject: [PATCH v7 11/12] hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
Date: Thu, 18 Apr 2024 16:11:02 -0700
Message-ID: <20240418232902.583744-12-fan.ni@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418232902.583744-1-fan.ni@samsung.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
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
 hw/cxl/cxl-mailbox-utils.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 57f1ce9cce..89f0ab8116 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1704,6 +1704,13 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
 
+        /* Check if the DPA range is not fully backed with valid extents */
+        if (!ct3_test_region_block_backed(ct3d, dpa, len)) {
+            ret = CXL_MBOX_INVALID_PA;
+            goto free_and_exit;
+        }
+
+        /* After this point, extent overflow is the only error can happen */
         while (len > 0) {
             QTAILQ_FOREACH(ent, updated_list, node) {
                 range_init_nofail(&range, ent->start_dpa, ent->len);
@@ -1718,14 +1725,7 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     if (range_contains(&range, dpa + len - 1)) {
                         len2 = ent_start_dpa + ent_len - dpa - len;
                     } else {
-                        /*
-                         * TODO: we reject the attempt to remove an extent
-                         * that overlaps with multiple extents in the device
-                         * for now. We will allow it once superset release
-                         * support is added.
-                         */
-                        ret = CXL_MBOX_INVALID_PA;
-                        goto free_and_exit;
+                        dpa = ent_start_dpa + ent_len;
                     }
                     len_done = ent_len - len1 - len2;
 
@@ -1752,14 +1752,9 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     }
 
                     len -= len_done;
-                    /* len == 0 here until superset release is added */
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
-- 
2.43.0

