Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB621B810
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002853; cv=none; b=sUmhQsjTpePdyQ6vJuIxx84d+EvtoHFk8VP96fno8X2J+EAXfOLEPVUOxiZVXRNZCBuO4PJWmGf4Qb2IgF0c4so0r+WMHFoXF14O4TjcwGVViChB852GAPwVodjoimfXXt2FdTSsgJRsUaD0oBOG5f0o2BhMa5tuP+cHn7pF588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002853; c=relaxed/simple;
	bh=Ld0RkCVr6v779tDnOF3KVOIoLCaOUVRNiYRaj6lPLDc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDY2MUdDPXkPFxNxFG0llPBjZR0MnO9AOYikV4Thh1LCpejne9VdWPJpTsa5XMXFdPvCZz6VUbJ2nLRenAlmHVhaEb99zgGccWFW/RYv9G3uU0VQ6e0TbZMHAtNIg4HsFJLjg885Xz1kBX2w51K1ikDQNxUYyzIdpwWXhDcR5O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqG8f4kdnz689rg;
	Thu, 30 May 2024 01:09:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E523114038F;
	Thu, 30 May 2024 01:14:08 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 18:14:08 +0100
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
Subject: [RFC PATCH 3/8] mm: memblock: Add a means to add to memblock.reserved
Date: Wed, 29 May 2024 18:12:31 +0100
Message-ID: <20240529171236.32002-4-Jonathan.Cameron@huawei.com>
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

For CXL CFMWS regions, need to add memblocks that may not be
in the system memory map so that their nid can be queried later.
Add a function to make this easy to do.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/memblock.h |  2 ++
 mm/memblock.c            | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index c7d518a54359..9ac1ed8c3293 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -113,6 +113,8 @@ static inline void memblock_discard(void) {}
 void memblock_allow_resize(void);
 int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid,
 		      enum memblock_flags flags);
+int memblock_add_reserved_node(phys_addr_t base, phys_addr_t size, int nid,
+		      enum memblock_flags flags);
 int memblock_add(phys_addr_t base, phys_addr_t size);
 int memblock_remove(phys_addr_t base, phys_addr_t size);
 int memblock_phys_free(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 5498d5ea70b4..8d02f75ec186 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -714,6 +714,17 @@ int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_t size,
 	return memblock_add_range(&memblock.memory, base, size, nid, flags);
 }
 
+int __init_memblock memblock_add_reserved_node(phys_addr_t base, phys_addr_t size,
+				      int nid, enum memblock_flags flags)
+{
+	phys_addr_t end = base + size - 1;
+
+	memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
+		     &base, &end, nid, flags, (void *)_RET_IP_);
+
+	return memblock_add_range(&memblock.reserved, base, size, nid, flags);
+}
+
 /**
  * memblock_add - add new memblock region
  * @base: base address of the new region
-- 
2.39.2

