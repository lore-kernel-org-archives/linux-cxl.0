Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C571BD01D;
	Sat, 29 Mar 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743246155; cv=none; b=oSI9htOuLc5W/5UMA7pDNrxxe/5mzhaAVKCYix745Q7vnjL0h9iv8ZsRAgISJWxvqv4e/ithYPyzURR+usiSA9lX6rcZ36ICL0pMyIudo/RRmMkRpiM2Yl6cijSu6cccUedAeUGN/B2pv4vLpp26KXdp2wzqys/RDc0ERPMzMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743246155; c=relaxed/simple;
	bh=5R9hzXaHIloEixtk4wd4P/Jbk/Qez0T6Wvo4Cm/eNHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtdmDiioNn5uUxiueUKgs0ue47AaxZ9HeiaBxjdsYDru2iXMdLd5N+N9hHM0LqYkpF8YP2TPsfSgGbMxEJ+U6atAbYnujR0/ObRGX79wN4ES6RdMVVKqNupqSFUjQCqGUNIkxhtFoh0C5y52ZI9qclZLRveU3te15jTasmyQXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lscB1D19; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lscB1D19"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e643f0933afso3294292276.1;
        Sat, 29 Mar 2025 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743246153; x=1743850953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jsq1kdQlFLn6WmPKzWPYjHoxE5hbtalWfUYgVjm4hmU=;
        b=lscB1D19ZqIVRIVOwjs5cSyT2LELOMSuN0uVlq/m8LXyNK/v9c1ipmhZ4ec8VtTy6f
         Bsm3Cx/Ej3+S6423wAaytoKpRGBsHro5rLx37VBE3tpP0MuveGVIY92XWFjBOvRUj51C
         K/LqSb0s54HwvG5KjfZq+xRBVFjE8owuLhs6Fa0XKEpycHRrrWsocAYuVv2+6A2B08XA
         EUy3mevhLEReQuo5bJR7UDhrO+smuGKzZbF+PtdrcagQqHEZ0/kEwxJjgoeJilvUahdH
         aRaLiwkFhgAXV86UmH6moAjI3fxgEIiJdqD+oWCoEN7KQEqIC9TALAYCROfWQvuWnLZe
         AlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743246153; x=1743850953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jsq1kdQlFLn6WmPKzWPYjHoxE5hbtalWfUYgVjm4hmU=;
        b=WxA2mvPOglgvSaYvsos7QR6myReWmcxqRiuUjKRcybuNnOowwWdl7Ehz5pOixb5Y61
         SPKkBRz9H9gv2U4TH3M3YFF5RFpFHl9Mwl8w9wyi4ctvm2p8lyk5MjtXGHT8IeW+ggoi
         Y6R465eCib0bregdy9COwBRpEM1vemp1Rg5VTt7Pqxl3tQP5qhtUmbX9RiQaOM77sfVL
         bbR7LtaOcG/8p0HCOuHoD1c1iTfNm096XZtZ4Yr89VSE46Zjt5SqkIHrsEKg2u+DjCsr
         cETiolowWfgiYob3AbFSocsq1zr1q37nqnwa7faqiqz0Jy+W9ZzTOv963hxAZRBjklDN
         AY2A==
X-Forwarded-Encrypted: i=1; AJvYcCUqY9blSAcwmzRmxR2JOitbvGvgu4TPlA7roXwIi2jyKUv3cb7F6fZh0OMIp23t/1RyDg4eLVDL6ck=@vger.kernel.org, AJvYcCXxIyAAibpmxMEIq/ks9wJPAo6B6SygW5WYzrMDkdG6FGOUSabBmie7ZcgqTSR9U9Dh13j9sdyJGGH0FOOF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu5buxT5Xa7xu2pm6emFfiCZyXzBYffJ2YzplGHav5g1jGlXKD
	gV/bs6UGitvrpzeARPwyz7yuA7l+RYWA6q5Srbf0Vp19XGGwtpeq
X-Gm-Gg: ASbGncurphxFQFUlQ+HqR6FPFfdMn7GbOWvopnnBz9seqoSSRadZT5SKYq3Ys+jFrc1
	kJmo3ftdePuxvABhmOLFZhNr/J1zoG0uQ0mfhG/8mtkM4+KCV7IFi0zKP+qcaarkd3K41EDm2Jo
	+KFDBVN1IZLaWe+v2qNpUh6sTszCXO7O1AGv0geP3bi5CKm7qL6lQZ4YRW383W41xHpohpMEkvE
	U0xt69r26ua54u6dGcV+94EQ3h0hA807a6k2UqVOUH2sLVJbLTpOF0RHABavPj5I+PxaUXR+fP8
	ujD3lk6jBxYpgENjWDiUfqKI7xb2nNVIAso=
X-Google-Smtp-Source: AGHT+IH2l8g9eICi5VxjR50z5D2Rf7QYBYscXVtxEG4K+/DFEXhUzLsi2QX42gax29HRevowTi1+Bg==
X-Received: by 2002:a05:6902:1581:b0:e6b:7e33:b637 with SMTP id 3f1490d57ef6-e6b82e2e712mr3210420276.14.1743246152740;
        Sat, 29 Mar 2025 04:02:32 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e6b8473463fsm324084276.23.2025.03.29.04.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 04:02:32 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	sj@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	gourry@gourry.net,
	willy@infradead.org,
	ying.huang@linux.alibaba.com,
	jonathan.cameron@huawei.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	minchan@kernel.org,
	senozhatsky@chromium.org
Subject: [RFC PATCH 2/2] zswap: add sysfs knob for same node mode
Date: Sat, 29 Mar 2025 04:02:30 -0700
Message-ID: <20250329110230.2459730-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250329110230.2459730-1-nphamcs@gmail.com>
References: <20250329110230.2459730-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Taking advantage of the new node-selection capability of zsmalloc, allow
zswap to keep the compressed copy in the same node as the original page.

The main use case is for CXL systems, where pages in CXL tier should
stay in CXL when they are zswapped so as not to create memory pressure
in higher tier.

This new behavior is opted-in only, and can be enabled as follows:

echo Y > /sys/module/zswap/parameters/same_node_mode

Suggested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/mm/zswap.rst |  9 +++++++++
 mm/zswap.c                             | 10 ++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index fd3370aa43fe..be8953acc15e 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -142,6 +142,15 @@ User can enable it as follows::
 This can be enabled at the boot time if ``CONFIG_ZSWAP_SHRINKER_DEFAULT_ON`` is
 selected.
 
+In a NUMA system, sometimes we want the compressed copy to reside in the same
+node as the original page. For instance, if we use the NUMA nodes to represent
+a CXL-based memory tiering system, we do not want the pages demoted to the
+lower tier to accidentally return to the higher tier via zswap, creating
+memory pressure in the higher tier. The same-node behavior can be enabled
+as follows::
+
+	echo Y > /sys/module/zswap/parameters/same_node_mode
+
 A debugfs interface is provided for various statistic about pool size, number
 of pages stored, same-value filled pages and various counters for the reasons
 pages are rejected.
diff --git a/mm/zswap.c b/mm/zswap.c
index 89b6d4ade4cd..2eee57648750 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -129,6 +129,9 @@ static bool zswap_shrinker_enabled = IS_ENABLED(
 		CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
 module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
 
+static bool zswap_same_node_mode;
+module_param_named(same_node_mode, zswap_same_node_mode, bool, 0644);
+
 bool zswap_is_enabled(void)
 {
 	return zswap_enabled;
@@ -942,7 +945,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 {
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct scatterlist input, output;
-	int comp_ret = 0, alloc_ret = 0;
+	int comp_ret = 0, alloc_ret = 0, nid = page_to_nid(page);
 	unsigned int dlen = PAGE_SIZE;
 	unsigned long handle;
 	struct zpool *zpool;
@@ -981,7 +984,10 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 
 	zpool = pool->zpool;
 	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
-	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle, NULL);
+	if (zswap_same_node_mode)
+		alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle, &nid);
+	else
+		alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle, NULL);
 	if (alloc_ret)
 		goto unlock;
 
-- 
2.47.1

