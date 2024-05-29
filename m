Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7953979EF
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002913; cv=none; b=UFFTQdDnQWpI0cAYjKv82AFb37K6XfbIcqW3CpZJrvmS7S/Vbb2ZUb0dA2uOV4+I7yVoNzHA4WGdtgPyV9CJjxzJljt1rEQFuuQZw5CTdq1JBBI1Ry60gjLLdjIVCl/mFnhTTG8Dc8FaMy5nn42LUGb9oB8DHOID3qzHLCCWyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002913; c=relaxed/simple;
	bh=FY0SM+kzbiwYNRG+NpplhaQqM7hgI6jSpOr+TvkOWHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpdhTZxLHaQnPtvlV6GJNFG68CXldNX1g08CmWRgzx7I/uONtwgWun9IndObFcrRVp/astfl7C6QQFDrLa+d7QKoH2eA32jOwNZN3kGyJ4WwQJyjqZb6PL0bIA2q64+gDeUFbsT4M0eq9alG+uZERNllKj8aB5omMvFFniOmoxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqGB66sVPz6J9y8;
	Thu, 30 May 2024 01:11:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8666A1400CA;
	Thu, 30 May 2024 01:15:10 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 18:15:10 +0100
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
Subject: [RFC PATCH 5/8] arch_numa: Make numa_add_memblk() set nid for memblock.reserved regions
Date: Wed, 29 May 2024 18:12:33 +0100
Message-ID: <20240529171236.32002-6-Jonathan.Cameron@huawei.com>
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

Setting the reserved region entries to the appropriate Node ID means
that they can be used to establish the node to which we should add
hotplugged CXL memory within a CXL fixed memory window.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/base/arch_numa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 0630efb696ab..568dbabeb636 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -208,6 +208,13 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
 			start, (end - 1), nid);
 		return ret;
 	}
+	/* Also set reserved nodes nid */
+	ret = memblock_set_node(start, (end - start), &memblock.reserved, nid);
+	if (ret < 0) {
+		pr_err("memblock [0x%llx - 0x%llx] failed to add on node %d\n",
+			start, (end - 1), nid);
+		return ret;
+	}
 
 	node_set(nid, numa_nodes_parsed);
 	return ret;
-- 
2.39.2

