Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A1D27E
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003006; cv=none; b=U1HtyUEcygg+6c4CKNhon8Osu75N5PH9oZTADAyCAfa85cAXOKnRftzsJt5WSll9f5JbLvJ68m5KbxI/2bg/JPcwDCLhDNw0hUtEfVOFzgzsq7ODyS4EzQCdlDz0m13Pkc3NdVGRGrb0OBCgYdjpSRxtT9eOUmcFpWdW54CZpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003006; c=relaxed/simple;
	bh=W0MuivBn95KYv14CJ8fad6piUaTvcrG7q6Io3TmiYbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0o9rfipdwiPkhmeOEq70qLaA5b12zYRoITKis9XI8SuKVXygN+UHTmrfQ50Ae1SBk7qOv12oMCxG+GkUhCEi4Yho2YwXyLJoguyHcuSaNyKrP9uJu6tutndUn3Q8fPHjN+Q0PHx7LKlzXnttw1lyFHZP0Nm1zOtrh7dR506VE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqGCv4KMlz6JBK9;
	Thu, 30 May 2024 01:12:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 30308140D96;
	Thu, 30 May 2024 01:16:43 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 18:16:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Will Deacon <will@kernel.org>, Jia He
	<justin.he@arm.com>, Mike Rapoport <rppt@linux.ibm.com>,
	<linuxarm@huawei.com>, <catalin.marinas@arm.com>,
	<Anshuman.Khandual@arm.com>, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Oscar Salvador <osalvador@suse.de>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, James Morse <james.morse@arm.com>
Subject: [RFC PATCH 8/8] HACK: mm: memory_hotplug: Drop memblock_phys_free() call in try_remove_memory()
Date: Wed, 29 May 2024 18:12:36 +0100
Message-ID: <20240529171236.32002-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

I'm not sure what this is balancing, but it if is necessary then the reserved
memblock approach can't be used to stash NUMA node assignments as after the
first add / remove cycle the entry is dropped so not available if memory is
re-added at the same HPA.

This patch is here to hopefully spur comments on what this is there for!

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 431b1f6753c0..3d8dd4749dfc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2284,7 +2284,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
 	}
 
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
-		memblock_phys_free(start, size);
+		//		memblock_phys_free(start, size);
 		memblock_remove(start, size);
 	}
 
-- 
2.39.2

