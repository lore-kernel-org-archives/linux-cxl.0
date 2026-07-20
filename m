Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533F48AE35
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576134; cv=none; b=ka5EEVdTCn6XMfKbaPZM7aA/g5ujdrSDtxpkfJbaNnOZep13AyytwNceTZotkkKDfEyPqqsav68rjnYN4LLNFtu+ruRJinqjArCugaGbrWdnU/QQA9fwoUACQaMZUCpvBRGszDCVo7zD0Sx77vbnrcUrBpXp3ElNl0JvJ/a1s+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576134; c=relaxed/simple;
	bh=ifqNq225nfRuO77jzr3XXyC27iYCrW1SGYAlShFLthM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gf22k6MpUeWCvoixrHK3fFaEKL6IU+f2BSRngXCCer5WtXkciAlttB45/pOdIJCHBVfGRAPngJZJlIGNoebZFFGHpbXkVkh4urLA13kwy9k/0fddyTMZObj/n+JkISOZrMntLASLp7kp0d23BHAedUSVGh56Mz2dmIvZ8Q1Zd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=E/tVcDgT; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="E/tVcDgT"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e5cb052edso567176785a.2
        for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 12:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576128; x=1785180928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KU1C1BFWfSEqKvrRpWFHlkg4mZCsJC5WSVAsWkbzWmY=;
        b=E/tVcDgT7y3NoVzZT7KLiwOlpQ4lPhdrtRWlcd6UazdA1KnoL0/AcgEJde/VKvVnvR
         9a27bQ6CG2k0BynXRV1oZJm+gbcC3PRfMyPuDPNeQKNNxSBl+8QNLpd5N7tenhHUZAQW
         uKlTpoew9Z9c68rFnaKLd42GcnY1Mw/5obLt5lMUycLHXXUawWA+Mt6imP5jTJ7St4ou
         Pe7F+HZ6xgxH0aI2vQZSjH1/u7YoNxL1+yPxwNFR6dGAsOnJ9iDQi0Uc0p7uI+e2AqVc
         hURqDn72udUMRAxtkt6hLGro63G54FuIhq78FKTxdPqGU38Wan2INfREa70twQnfUTsS
         LmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576128; x=1785180928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KU1C1BFWfSEqKvrRpWFHlkg4mZCsJC5WSVAsWkbzWmY=;
        b=fGYEYFwq5BAth4Wm//0nd0YXwpJ4nNfM3P7aZawmcK/8gzvtGcqP7uf6ATjB/iRYvl
         9tHC4jwVVKpY6PNW+wyUC4t/rdL9AnEXeQ08b+mob91GPmQlxkrmE042ZcTJj9QYP+LS
         /ULwp0mE6Wk1IDuexJjJEQHj9fKl9Q+efbLzrXrPDys2aANr2Fx+acj74pJ9gwvBjwH4
         U1FJ6VCqV/sS5IRDDIyhp8+L/cGVBQI38Hu+Fa9NLpH7JbJguToT9QC+9qePsjLYYLxV
         X7Bjz68KY3TNk2ZnUHphaXhXqhBuPix2oxjNCwRky8pqGX1arg0N76bSej1GnNO1h+0H
         DQjQ==
X-Forwarded-Encrypted: i=1; AHgh+RoiixMoTGFPjw5dlPK/t1MD1oT9vWx6SE5sbEx+qBO8awXTNpl17aTlKISRDshC8mQ6kkPL/7XIsws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqsCauqYlWyzoubljdACiw2uyYzBfBV8DAI6uSc355fjBzFtPZ
	6whAF9zC3Wh3oeT+GESFWcDoAsdVg7dJQmKWX6kTr9G/TcW6EeuEPoxyvhqUij9ZFdg=
X-Gm-Gg: AfdE7clieRlVbsHTOZ/j/N36HQ88TZ0bb1O2vB7DUTsekQGXNRujIuuhiZlgsyehRwc
	01cILbuWTeRdhhCa7tPDRTNMnBhRra52PTJdfD7KjdRSWR7VVvrDTvTXvX35qZT/ln45c9x9xqK
	BhsH48EVmF6+sMmA1vANoTALs9M72+s2q6Zy69jAAr2IzYBIZZRduzY0BpWIlVmZqapEnHHstOF
	JoQ1NI7H82jwCTHF+KlQP0E4EyDFRjRWpst6xTW3QtCHUvffwhZUkrbFL6r3QqLwJjfe7yBNYW5
	tpgJqj8v9m0SKgwTb8EGn4FgrYU4ZRU49fBTa4W6Xm4v/o85mSdQKHg9N2hIXKYDFsLEcs04WPD
	VAiv2KKh1DMDIzuawNPiHtiWvJsHuI2SY0BO8A5ypxDQWzyAC89bFn01kij95JxOA3iMYluU8Q2
	/pyriZJr9KG42HUely+z0ixDGhySWpTcAlggPDZ4Ub+w9Grrw+I7JGn11ljbqERmA=
X-Received: by 2002:a05:620a:4588:b0:92e:4e88:f453 with SMTP id af79cd13be357-930b41a0726mr1469051085a.52.1784576127960;
        Mon, 20 Jul 2026 12:35:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:27 -0700 (PDT)
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
Subject: [PATCH v5 19/36] proc: include N_MEMORY_PRIVATE nodes in numa_maps output
Date: Mon, 20 Jul 2026 15:34:13 -0400
Message-ID: <20260720193431.3841992-20-gourry@gourry.net>
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

numa_maps collects per-node page counts in the page-table walkers
and emits them in show_numa_map.  All three filtered by N_MEMORY,
so pages on N_MEMORY_PRIVATE nodes were never gathered/printed.

Accept N_MEMORY_PRIVATE pages in both walkers and emit private nodes
in show_numa_map, so private-node mappings are visible in numa_maps.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 fs/proc/task_mmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 817e3e0f91943..e116cd5f157b9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3389,7 +3389,8 @@ static struct page *can_gather_numa_stats(pte_t pte, struct vm_area_struct *vma,
 		return NULL;
 
 	nid = page_to_nid(page);
-	if (!node_isset(nid, node_states[N_MEMORY]))
+	if (!node_isset(nid, node_states[N_MEMORY]) &&
+	    !node_isset(nid, node_states[N_MEMORY_PRIVATE]))
 		return NULL;
 
 	return page;
@@ -3414,7 +3415,8 @@ static struct page *can_gather_numa_stats_pmd(pmd_t pmd,
 		return NULL;
 
 	nid = page_to_nid(page);
-	if (!node_isset(nid, node_states[N_MEMORY]))
+	if (!node_isset(nid, node_states[N_MEMORY]) &&
+	    !node_isset(nid, node_states[N_MEMORY_PRIVATE]))
 		return NULL;
 
 	return page;
@@ -3602,6 +3604,10 @@ static int show_numa_map(struct seq_file *m, void *v)
 		if (md->node[nid])
 			seq_printf(m, " N%d=%lu", nid, md->node[nid]);
 
+	for_each_node_state(nid, N_MEMORY_PRIVATE)
+		if (md->node[nid])
+			seq_printf(m, " N%d=%lu", nid, md->node[nid]);
+
 	seq_printf(m, " kernelpagesize_kB=%lu", vma_kernel_pagesize(vma) >> 10);
 out:
 	seq_putc(m, '\n');
-- 
2.53.0-Meta

