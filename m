Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13A1B810
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002792; cv=none; b=INIVKbANy6zbHULcvXcOcf8iU03SWDKkv2HrE+uF3sEmbEVXBrhwSCx9pYThk90R6B3x+qAxazZ4AyiT41LHDViPJNtzFFs9AFOiIQ9B8ugeoRv6AIvQ6n7S3pE36m1B1sA4PZvwtaDo3wae3/vgu6lAUQeI2oyBEcmXZ0hom88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002792; c=relaxed/simple;
	bh=QRqSxhSL1bizFBbKfNS3mIHdVNZ3cu7quVf2ES0tZoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b38gZUdvv1rxCAqYR/H/wA9VuYX5lZ2bzoMnC7Q+M2uEfGsijLPP52aeTr9DR/pbfKjPOBvTnJDBiz8KLpLMo/R1r46oEDlDLLq4U81KWh5pEOB5mjnpaxm5mWZede7z2BqkEESSrnJS7EbGLreER68wyGb7oqlnZSr/857FE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqG7T0pnWz6K6Mx;
	Thu, 30 May 2024 01:08:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E7B71400CA;
	Thu, 30 May 2024 01:13:07 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 18:13:06 +0100
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
Subject: [RFC PATCH 1/8] arm64: numa: Introduce a memory_add_physaddr_to_nid()
Date: Wed, 29 May 2024 18:12:29 +0100
Message-ID: <20240529171236.32002-2-Jonathan.Cameron@huawei.com>
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

From: Dan Williams <dan.j.williams@intel.com>

Based heavily on Dan William's earlier attempt to introduce this
infrastruture for all architectures so I've kept his authorship. [1]

arm64 stores it's numa data in memblock. Add a memblock generic
way to interrogate that data for memory_Add_physaddr_to_nid.

Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Jia He <justin.he@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/159457120334.754248.12908401960465408733.stgit@dwillia2-desk3.amr.corp.intel.com [1]
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/arm64/include/asm/sparsemem.h |  4 ++++
 arch/arm64/mm/init.c               | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 8a8acc220371..8dd1b6a718fa 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -26,4 +26,8 @@
 #define SECTION_SIZE_BITS 27
 #endif /* CONFIG_ARM64_64K_PAGES */
 
+#ifndef __ASSEMBLY__
+extern int memory_add_physaddr_to_nid(u64 addr);
+#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+#endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9b5ab6818f7f..f310cbd349ba 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -48,6 +48,35 @@
 #include <asm/alternative.h>
 #include <asm/xen/swiotlb-xen.h>
 
+#ifdef CONFIG_NUMA
+
+static int __memory_add_physaddr_to_nid(u64 addr)
+{
+	unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
+	int nid;
+
+	for_each_online_node(nid) {
+		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		if (pfn >= start_pfn && pfn <= end_pfn)
+			return nid;
+	}
+	return NUMA_NO_NODE;
+}
+
+int memory_add_physaddr_to_nid(u64 start)
+{
+	int nid = __memory_add_physaddr_to_nid(start);
+
+	/* Default to node0 as not all callers are prepared for this to fail */
+	if (nid == NUMA_NO_NODE)
+		return 0;
+
+	return nid;
+}
+EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+
+#endif /* CONFIG_NUMA */
+
 /*
  * We need to be able to catch inadvertent references to memstart_addr
  * that occur (potentially in generic code) before arm64_memblock_init()
-- 
2.39.2

