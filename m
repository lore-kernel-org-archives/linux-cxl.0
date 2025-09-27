Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130319C540
	for <linux-cxl@vger.kernel.org>; Sat, 27 Sep 2025 00:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758932506; cv=none; b=WrE3IaCWDd7LbEF3/M4U/y9piB3VlAra+4qMaWt9DmhRh9RRlv7JiN5ZfcGtPVvLzdQnOKobDzs8oPyMA+mxyS7DAFROzLk0+6NJ4vP7dZ9546MHGUoxMtANRR8WGepqLnR2aQmWlPMRcrRHmBSrfT5BmlaTSf9mZzw5tTfbDJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758932506; c=relaxed/simple;
	bh=38eGXnCnD1VW5ZAktJMdkMHniVocT57UMCBlXDhjRyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ed+eTkmswHtG/RxyN4wbFETfj/KGponKtM/qoQrKD7bcZzN1UuvCBIgtCE4cK1E59czjRCuHjjlxBoIvbCl+7bEhke5xSFhVkj7s6O1NjbkBjqNC4wxlwoE94ISPYiwQ9ZqzwNBe9oq9/vgfh/5kK8MI/M9HJgDgK2LNL1OXZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbIxCwBj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbIxCwBj"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f7da24397so2507885b3a.2
        for <linux-cxl@vger.kernel.org>; Fri, 26 Sep 2025 17:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758932505; x=1759537305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgBS8TXXh/PJHvsCbZXkp2wZ9PaKkzgJFyRLqDXciTQ=;
        b=mbIxCwBjFiKCJ6yfKgFq/nYSab2RT+LgOJhG4kggTazquBmWDnhETSbBe8wA8IMG87
         foX7kR4sHgsDdikb2Hsrqz0JTKnOdUWEYY6VaNoJCWIRTmn8TucgNDrSOuHunfakVP/u
         gozaV0VA9ZDRRXeDKbBR1TsNmCZf2ab7Kjpq6xw6yCfJM4XbvS7iG9192Qn4DDhCiP7B
         DYKsXeGX3z0laB0aZfo93qvDmB0s6eVsEpdwwu39o4Uk2LsY/4iuc+mj8/Hw4VA/qheU
         KqSYuKrSSklY7sEG1ZdWuio702AndE84lMtPar3ejFQ5NNnqv5Klq/PQoL44+hUipzBs
         IR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758932505; x=1759537305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgBS8TXXh/PJHvsCbZXkp2wZ9PaKkzgJFyRLqDXciTQ=;
        b=FpSzWfBWbAO+cs7wF7CUGoO/pY+gwNmUIqoyxWy/lGkQiICz14Tvnn5KfvTRB8gsp5
         JLMDjqUxlb+13VMYprq/vyQqXczRXf+8A2qhUnnXIq5gLQh6rfX2ljqOlhj4bBC7+7OW
         w8BC5py9cZA3o4eCVyP/+IgFQf7ft+k/+xVxGTJndaC3/C6PIzE+nj5FqLLWF8WlQ2ID
         BEtAW33KjSFcygLqmyFm5vrLnbwO7Led0GUCX0lKXj6C/sjzP8voOKlUled5tWw9+tUo
         DVM6O7z7LIbXByNbd7+6uE0SDV073GI00o2JWpzxpLQDhlqr+/oO+1BKg6kBvQvWa27M
         6w8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZyNQfqpvip4p1txaG3vKwNGTxYOx37MTervwGLNkKfRrUu85DC3jrrmdiVnkoQfa/IofKE+W6pN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd2Abh7TJ6LfiuPUCuLVdiaA4jQYo7GNR+1j7shfLnQnF0Yk47
	cDacZx6GJVVPePg2BIbAC1uSGjuJAsWgCzH9Xw8g2OHWe5u0E714sRqG
X-Gm-Gg: ASbGncsRQYl98dXuN67X2t/wYM6xMmNkJX+466cHaX8zx2tdqJNpfKYuDTuK/HeOHob
	bMegksQNqaRW2tGazzdhB3i43RKvsrLjkbkca3ZBr310vx2rlj29kSaS7jKRgzght6V08yMIUoR
	P4uE8vvTBXuXHezxLafcJqGDxjSjxx9Ilb5rCBu9pBI4rMlSUapsTln6ILzu7dznxdExvEcCLGe
	WYW2TQftEQpj6ewMqzX5/kciiVjJGFpPQLcjfvT8tzwnNkOKu3igEJ3sGCsWncHUkTHk4snEsKZ
	ZT2+rSuDtjBgZi6hek/S+7RQEz0mSsHK8vj0Js4qTHV65n6I2LBPHD03d2pxpnJeyG24UUM6gWo
	LB18sujPMMKBFkXr9LtsGhlIzX7EGKyfhQ3Jq28F9DcY=
X-Google-Smtp-Source: AGHT+IEiVK/GMzpOhOc6Ms3m/uHtgMeXjMFirWPawAmkGC16ttcIQ4tMR5IRpWvj2pdHvtjFvsYukA==
X-Received: by 2002:a05:6a00:189a:b0:77f:472b:bc72 with SMTP id d2e1a72fcca58-780fcdc5b13mr8824571b3a.3.1758932504626;
        Fri, 26 Sep 2025 17:21:44 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238ca29sm5350489b3a.6.2025.09.26.17.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 17:21:44 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH 1/1] hw/cxl/cxl-mailbox-utils: Enable FMAPI Initiate Add for MHSLD
Date: Sat, 27 Sep 2025 00:18:07 +0000
Message-ID: <20250927002125.860668-2-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250927002125.860668-1-anisa.su887@gmail.com>
References: <20250927002125.860668-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

Call mhd_reserve_extents in FMAPI Init Add (5604h)to enable sending
FMAPI Add command to MHSLD.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c5177dfd92..9ac60db4e1 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -24,6 +24,7 @@
 #include "system/hostmem.h"
 #include "qemu/range.h"
 #include "qapi/qapi-types-cxl.h"
+#include "hw/cxl/mhsld/mhsld.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
@@ -4163,6 +4164,8 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
         CXLDCExtentRaw extents[];
     } QEMU_PACKED *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
+    CXLDCRegion *region = &ct3d->dc.regions[in->reg_num];
     int i, rc;
 
     switch (in->selection_policy) {
@@ -4201,6 +4204,28 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
                 return rc;
             }
 
+            /* If this is an MHD, attempt to reserve the extents */
+            if (cvc->mhd_reserve_extents) {
+                g_autofree CxlDynamicCapacityExtentList *records =
+                    g_malloc0(in->ext_count * sizeof(*records));
+                g_autofree CxlDynamicCapacityExtent *dc_exts =
+                    g_malloc0(in->ext_count * sizeof(*dc_exts));
+
+                for (i = 0; i < in->ext_count; i++) {
+                    CxlDynamicCapacityExtent *value = &dc_exts[i];
+                    value->offset =
+                        in->extents[i].start_dpa - region->base;
+                    value->len = in->extents[i].len;
+
+                    records[i].value = value;
+                    records[i].next = &records[i + 1];
+                }
+                records[in->ext_count - 1].next = NULL;
+                if (!cvc->mhd_reserve_extents(&ct3d->parent_obj, records, in->reg_num)) {
+                    return CXL_MBOX_INVALID_INPUT;
+                }
+            }
+
             CXLDCExtentGroup *group = NULL;
             for (i = 0; i < in->ext_count; i++) {
                 CXLDCExtentRaw *ext = &in->extents[i];
-- 
2.51.0

