Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176B47DD5A
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576115; cv=none; b=VYgUpULgOflzbq2VaF9u/vjQ2O4kWC3RSZoYqINwmDC+f/kSVjVZJGe9GZ9V5Nku82QO2YwEaZk/wpWGoyPuuY+2cbCKy1jqsL5QyUor6ZATt5qLAE2F6fUwISmOS4vSUWQ8f6fHkiMdo+J9gEbxY87S99TLXY3LYntUhtM2Gl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576115; c=relaxed/simple;
	bh=cwT1qxzu5mcEtwbfCjbjp1x2zlkj7iTH/wP2YBbJ88A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mdzqyz4rTGKc2FwX4wNlUmlp59hmPJ3PvOWbBtOfPX8J1SkxA2bzCosSylOB3l5h1/73L9QBVuuk/IU900xTfqwZZTKDt+8untN1jswCLKnjAf2rO9xXiaRR4ZUBJfL7fUb4La5sev97yjXiMtOps+wbhUmHMQB52Zq/8h0SGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eyxoedwA; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eyxoedwA"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5cb052edso567160185a.2
        for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 12:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576110; x=1785180910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zRBuTTcFDLFkxWr76FAXg5UPkm9NjmBW+wSCIxxIlUw=;
        b=eyxoedwAgKPwlER6cisueYVhnwGikgeb6n92xljUQIvdVPafD6U5vCCdqvQmpHWntT
         CmQA/p9doNwRA9EfJnbBmapZcEIwVradgPhUl/Ny1o0Ghnk+E3P+ZWbWHxOaPf4kmWiW
         KPxTvjO7j+k9X4G0cXhViItoWgy888RpaocJo+HrBB30ZYWxIAiRGHNdjhGiq88btefv
         rywIAwhmVtE7AAK10m3inPwKhWivK6Yv4PGNR5kYiv1CGm/IroMqBHDRtgcaTQRgjX+9
         YlRdKqvQhOgvstox5F1CdKoHsoVtvyMPOdHB0+xhXdOL37S3ZlNV/ckZJkmvxGZ9U68c
         vVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576110; x=1785180910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zRBuTTcFDLFkxWr76FAXg5UPkm9NjmBW+wSCIxxIlUw=;
        b=PsVuPTdcfvoMa8swOsdraCGtiSoFUNEp+nov6/hzEOSx2hyEqtXUt71Tt8fgag8BDn
         ywodEDqkCQ/Ow4+1iwHk5UeLxYepWLCjKZamr2G9ti7G1925dLpMKGbvV+HozuDlyas8
         KNeXUMj7Zlt//XR7dmiRXtR7/8vWxt6VJOf3FFQ77wOPFVIhv9YiCdS667DOL2RJ14Sd
         QyGAmfzvnXN1YS1tUMmLKzcPnLsXaC6t5aWsv94L/XeQ/aMdBx3AfAJUvnNRcXDPBvV5
         Apogw/0UxsH9ec1OMRXtmZtG/rlXvdxH3DLn6rEXxcUyRrUAITwDkqTDNpRw0+EhNKUY
         dHTA==
X-Forwarded-Encrypted: i=1; AHgh+RrLeT4EY/rk0VR+uRbwfmztXfPfIeqKaI1x+3f5Voits0DAeqkVqsZ+o9NQkXWtm+UlCbuQJFG6YMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1nzc5qPYpaBzXaqO4wqEG81KqLczMaovMDW3RWBcyvO7fX+D
	hw36Rf6rBTA2eRZwjL1230PbqBmZu5To+6EXUxrrVeGDO6PWeRJCp0jDJ1DMrA67JHM=
X-Gm-Gg: AfdE7cnhumn3BtvgqTWwJpOOkpnLztjon6zvFSJXVelbd6eC9kD7DkayFGVTSj6K+el
	0Fw95vUaPDx5+ctiehijP7pecGTep+AxzWbmtTuHHMCdyt/6UuQiSwx/1UX4rtnKBzXv7c/9ADD
	EM4d7CeAUig6Z2kkFffz+4643VidN9PfwR7GqE2xHPlDX+qOetQLafKyI3dIEcsA05u5/KQl0Hl
	NWbpTQXrk1PEQCG+oB7cZUFxAnFchp2xMNTmBeL/+PmOvPIGvyzyM3mFSk6Pv8qVb1fP+Bjj7UO
	z35nDgQRhMHoZinF16xP/meTLxLRuTtdsg994v4osdKw5axb5aUQzSNRu2LqYaI3gVzbY3PR56B
	w/dz2miQY5VSfZiHCHEKh1vUwzzJZvzOmmiveGaakDOuZ9J9UbbxGSCOJxLcXPN7qCgxTQTkEpG
	xVfIUrxpyRIjS1yYa09l2VxG6XoRm9rbDMhjsjMRxO7wo12V8G9EbcAvqJsU9Myug=
X-Received: by 2002:a05:620a:3706:b0:92e:f212:98df with SMTP id af79cd13be357-930b3ec8d4emr1550494985a.34.1784576110290;
        Mon, 20 Jul 2026 12:35:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:09 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 12/36] mm/page_alloc: clear private node watermarks and system reserves
Date: Mon, 20 Jul 2026 15:34:06 -0400
Message-ID: <20260720193431.3841992-13-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set private node watermarks to 0 (reclaim isn't supported yet, so they
are pointless), and do not include private nodes in system reserves.

The oom killer can't actually resolve general system pressure by
releasing private node capacity, so including them in system reserve
calculations dilutes DRAM watermarks and causes poor OOM kill behavior.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/page_alloc.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 78755a55b1540..2b08bea2379a9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6555,6 +6555,10 @@ static void calculate_totalreserve_pages(void)
 
 		pgdat->totalreserve_pages = 0;
 
+		/* private nodes have zero watermarks */
+		if (node_is_private(pgdat->node_id))
+			continue;
+
 		for (i = 0; i < MAX_NR_ZONES; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 			long max = 0;
@@ -6647,9 +6651,15 @@ static void __setup_per_zone_wmarks(void)
 	struct zone *zone;
 	unsigned long flags;
 
-	/* Calculate total number of !ZONE_HIGHMEM and !ZONE_MOVABLE pages */
+	/*
+	 * Calculate total number of !ZONE_HIGHMEM and !ZONE_MOVABLE pages
+	 *
+	 * Private nodes are excluded because they are not in the regular
+	 * allocation fallback path - including them dilutes DRAM watermarks.
+	 */
 	for_each_zone(zone) {
-		if (!is_highmem(zone) && zone_idx(zone) != ZONE_MOVABLE)
+		if (!is_highmem(zone) && zone_idx(zone) != ZONE_MOVABLE &&
+		    !node_is_private(zone_to_nid(zone)))
 			lowmem_pages += zone_managed_pages(zone);
 	}
 
@@ -6657,6 +6667,16 @@ static void __setup_per_zone_wmarks(void)
 		u64 tmp;
 
 		spin_lock_irqsave(&zone->lock, flags);
+		if (node_is_private(zone_to_nid(zone))) {
+			zone->_watermark[WMARK_MIN] = 0;
+			zone->_watermark[WMARK_LOW] = 0;
+			zone->_watermark[WMARK_HIGH] = 0;
+			zone->_watermark[WMARK_PROMO] = 0;
+			zone->watermark_boost = 0;
+			spin_unlock_irqrestore(&zone->lock, flags);
+			continue;
+		}
+
 		tmp = (u64)pages_min * zone_managed_pages(zone);
 		tmp = div64_ul(tmp, lowmem_pages);
 		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
-- 
2.53.0-Meta

