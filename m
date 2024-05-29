Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021111B810
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002883; cv=none; b=cguEm4DoKVWCo9vFSO/4P7jVY/6wNoPIBgwiNldPPBdhuLx1oNq6Dz/rjK2wyMC7gtV5L2hsADnxLFL8ZyWtx5QOArfBKvLwgWVu8rRC0ZKfsvW9G69UUi46g3eHjKuEXIhwnEp+pnbuVlGEyJ4gGFxru/Cv3+I0cenTOZzbbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002883; c=relaxed/simple;
	bh=VpjirnCAOfsYPMgutjru4Qzy3vXk5Oj29Tazw2J+v84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLex4ImlPW6l1DqY/VYP4a0BzG5chEZCeZR6XM1/vkM3KRaQdrKAC15/PnTbwgG7yFusuCoBd7LwmFod+EwTMvala4HvWx1oObyvv2CBsIqSqVZvnYCQzpNF/3t54WoOqSa80WBGvUi/cO8zU8ci3Fhk2L8drqQCk43fYNpUNc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqGDy5XCQz6K95K;
	Thu, 30 May 2024 01:13:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B3F3E140B33;
	Thu, 30 May 2024 01:14:39 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 18:14:39 +0100
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
Subject: [RFC PATCH 4/8] arch_numa: Avoid onlining empty NUMA nodes
Date: Wed, 29 May 2024 18:12:32 +0100
Message-ID: <20240529171236.32002-5-Jonathan.Cameron@huawei.com>
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

ACPI can declare NUMA nodes for memory that will be along later.
CXL Fixed Memory Windows may also be assigned NUMA nodes that
are initially empty.  Currently the generic arch_numa handling will
online these empty nodes. This is both inconsistent with x86 and
with itself as if we add memory and remove it again the node goes
away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/base/arch_numa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 5b59d133b6af..0630efb696ab 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -363,6 +363,11 @@ static int __init numa_register_nodes(void)
 		unsigned long start_pfn, end_pfn;
 
 		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		if (start_pfn >= end_pfn &&
+		    !node_state(nid, N_CPU) &&
+		    !node_state(nid, N_GENERIC_INITIATOR))
+			continue;
+
 		setup_node_data(nid, start_pfn, end_pfn);
 		node_set_online(nid);
 	}
-- 
2.39.2

