Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109822CBC0
	for <linux-cxl@vger.kernel.org>; Sun, 22 Feb 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750172; cv=none; b=d1lfIAcEpEUFuNrtCCLJOxMnd+BHfvA5ovTFK/tydrtXPqhcAYzoDL5I5PQLZB5xhQQhD+QZSu/anfeSignBxkb9kP2TA1izSGG2OcEW1v9LuQuUNnJKwpf5EQZQ5G9rffsJx9CmhKbLUd0gdV3gfEp64K9xlfphauMwjDthx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750172; c=relaxed/simple;
	bh=fY2O2ukegsBDPZTxA7RgjpegM4UC0FoSjHYp6ZA4CME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2I+U07Z4gQUyGM9s4/JIc9rBuPa7c5/4BuFcQzn62WibAvGmWUDBCOrPSjTUFfCZGcCMG/tz36Yqm+QU5m5FRtEw3hoWXQkwEnOa1sZw216Skio1aPXt9aLOJGmT5BrQR+0FPoPhm9Zn+SuOUZz13Wrf/sfsP0v7kpo4GYR4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NWrp7Hpc; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NWrp7Hpc"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50334dd44d2so41382911cf.1
        for <linux-cxl@vger.kernel.org>; Sun, 22 Feb 2026 00:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750170; x=1772354970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0SIufGPxfCWQh/+gXEhZXOnJbmqG7niTtTuU93HVZQ=;
        b=NWrp7Hpcvpj9mkZbKrSc0+P2vmdVV65cXSZPjH+K2Xh+NIPAfvZv+vXn493H2JUVGK
         T+4IlHJrum2kMjxxdrho7R1HzdFdlbOHn52axMOxi+/aLi7rg1VbMIkGKaFgclTaAdq5
         TkKro0I9ybhO7cvYf9JxuGiLVBVlTjJvkpfaffqxeAFD1gG+4Afr5agcoSt87ynUDttx
         gjsL7v1JhGmXCPFpqnmNth/ykpxkv+ePTr0ikdfRbs4URShBKADvBLf48Y9emXLhteyK
         GF+doUpTnEg6Wx8nQF0SFOhkJFKLVjwM50YLYqUQBOle4bItkN5G9xZdpmQZ6FA9pmmp
         xiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750170; x=1772354970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H0SIufGPxfCWQh/+gXEhZXOnJbmqG7niTtTuU93HVZQ=;
        b=u+9cB/RaZ8Gl+Q2CarQvAfDZPLeARblcjfCPGCsSEboFaYmaoAupy1JzvF53yKjne8
         YcjEu++vdT0qU4sEYT5KZ0KZnyBRwwXuSv1Kf8DV1q8fsRF36mmR1tNXwbA0PgFkKiYg
         C6PZ7hTtYFbdg1zPBj39HeOzawkwhqjU2ADT6MCABulWndOVnGULMT/4/MHVxfqbi5nJ
         WEevyioYVG51gPKaiZelw1DNmXScMtBS1X3Le1C4rk7He4phEeVGSXa3dEE8QAG6fNPQ
         t28mXscsPuuil0DuJvpPP3oXofpBcpK4A3AWxfSEUk1yaCrr20N3n3DZ3VT0+h6TGK/M
         VVSA==
X-Forwarded-Encrypted: i=1; AJvYcCVSWNvF/vKGHqqjOjyZ98S2dkWRXoL8twsg+kvM8vTa1GYfBSi9qU5fE6hpvbM29MwuPI4D+BkqEZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlow73RXRYk3hnj+ncpU0rHElrU2kl2emYcj1f1Eexlbi5Mqzg
	/O2P3ZOzWwCljR1X5er0XayadNVYEtTPdMdxDD2kG0t+dhTiXORrVtOtwMprwjkuyGw=
X-Gm-Gg: AZuq6aJwY/1C3VY3S9NFeH0lIUlcfo4zujgYnCgr2JyUn7UCHy+th+f+Mw01qKrqgVB
	jUmEtrRrgLsu0bW6mc/CfiT1p9YSlWTwTq9svEhvAqzmjG0pJHb6E3w63zRLcd0Oklyp7289Rbj
	RicGG0OOBpemP5w42vsG354R+E5K8FlqT9T5tVII9tqDaPdpAAdRDd7BNc8ZfUl3im8/wW6BujN
	NXL10Jz+DtMA4geSv1LJBUK519/XFaE4gKlJc/Qj++vRI8abXRG/F7BqkTRqW9C4dUpvI6Cw01E
	92k4TeyK5WqsENx1Zg3gW4VrqwZAgf14DSLNGgAosCw9KyrPAKJ0qQUKUy04KtbMFHtc8eVLbK6
	40LqixHZyPC10SHKn/MTr7DUht3xme37QG/l7rYzFYKWQbS5rGDJ2zQXKXdiP2TBnPZGjnkC1P6
	zZsGeh+fopnq2lMm/oig1fWT3C8qnS1X9BTwq90MO3/L5Sn13fdzNMSCfvgQMULAp8dz4gilB0T
	M6ZuAUOUJK6UUE=
X-Received: by 2002:ac8:7d84:0:b0:506:8a2:b1ca with SMTP id d75a77b69052e-5070bcedb32mr65601961cf.73.1771750170035;
        Sun, 22 Feb 2026 00:49:30 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:29 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 09/27] mm/khugepaged: skip private node folios when trying to collapse.
Date: Sun, 22 Feb 2026 03:48:24 -0500
Message-ID: <20260222084842.1824063-10-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A collapse operation allocates a new large folio and migrates the
smaller folios into it.  This is an issue for private nodes:

  1. The private node service may not support migration
  2. Collapse may promotes pages from the private node to a local node,
     which may result in an LRU inversion that defeats memory tiering.

Handle this just like zone_device for now.

It may be possible to support this later for some private node services
that report explicit support for collapse (and migration).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/khugepaged.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 97d1b2824386..36f6bc5da53c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -21,6 +21,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/dax.h>
 #include <linux/ksm.h>
+#include <linux/node_private.h>
 #include <linux/pgalloc.h>
 
 #include <asm/tlb.h>
@@ -571,7 +572,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(page_is_private_managed(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out;
 		}
@@ -1323,7 +1324,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		}
 
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(page_is_private_managed(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out_unmap;
 		}
@@ -1575,7 +1576,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		}
 
 		page = vm_normal_page(vma, addr, ptent);
-		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
+		if (WARN_ON_ONCE(page && page_is_private_managed(page)))
 			page = NULL;
 		/*
 		 * Note that uprobe, debugger, or MAP_PRIVATE may change the
-- 
2.53.0

