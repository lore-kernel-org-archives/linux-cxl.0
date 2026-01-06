Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8C9238C36;
	Tue,  6 Jan 2026 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767669060; cv=none; b=r4PfLX2LnOrMcvT8okzDywqXuCaOkfJ0HZgGJQl2rwxM+mKFCHNZ1zTcAaAU1y6pWMLmsl5h7u1PBLjNDxRbayT1UkiCtpW76wKOnv00qC6KOVHsUxZgx4alvu3xWjKKNMJ3EWQBCi9ugzsimToV9xgZyETfgAauUjq+tuOjHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767669060; c=relaxed/simple;
	bh=XgYBh9Pkud8XL0bFxz3Z4z6UNZQtkibbOCjV5oa519M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ONclBqc0f6Q6JwKVJxPfZODicyt5T2iO7qrD5ui+lSAzlVpQh0YLkDy6bYLvTz4O1On/Gy4WnDk7+IwqGl6CKphZtNcdfGlxIsozFIviOyARd+aYR7C336j5TUP5Pg0WMZA5KksSkOSYDBUADtRgLpa4HRSbdiEVPDkLtd2btSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnCCU1fVxphiHoAg--.24166S2;
	Tue, 06 Jan 2026 11:10:45 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwCX7eozfVxpE1ARAA--.16517S3;
	Tue, 06 Jan 2026 11:10:45 +0800 (CST)
From: Cui Chao <cuichao1753@phytium.com.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mike Rapoport <rppt@kernel.org>
Cc: Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID of CFMW
Date: Tue,  6 Jan 2026 11:10:42 +0800
Message-Id: <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCX7eozfVxpE1ARAA--.16517S3
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAHAGlcG0AAvgAEsS
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7KrWxGr15JFykur17tFW5KFg_yoW8ZrWfpF
	4aqFWFgF4kJry7GFs2k3WUAw1xtFnYkF4YgFZrCwnxZ3WFqw1UZryavr1SvF1ktrWfCF1r
	XF4qy3WYvw18ZaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

In some physical memory layout designs, the address space of CFMW
resides between multiple segments of system memory belonging to
the same NUMA node. In numa_cleanup_meminfo, these multiple segments
of system memory are merged into a larger numa_memblk. When
identifying which NUMA node the CFMW belongs to, it may be incorrectly
assigned to the NUMA node of the merged system memory.

Example memory layout:

Physical address space:
    0x00000000 - 0x1FFFFFFF  System RAM (node0)
    0x20000000 - 0x2FFFFFFF  CXL CFMW (node2)
    0x40000000 - 0x5FFFFFFF  System RAM (node0)
    0x60000000 - 0x7FFFFFFF  System RAM (node1)

After numa_cleanup_meminfo, the two node0 segments are merged into one:
    0x00000000 - 0x5FFFFFFF  System RAM (node0) // CFMW is inside the range
    0x60000000 - 0x7FFFFFFF  System RAM (node1)

So the CFMW (0x20000000-0x2FFFFFFF) will be incorrectly assigned to node0.

To address this scenario, accurately identifying the correct NUMA node
can be achieved by checking whether the region belongs to both
numa_meminfo and numa_reserved_meminfo.

Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
---
 mm/numa_memblks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index 5b009a9cd8b4..e91908ed8661 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -568,15 +568,16 @@ static int meminfo_to_nid(struct numa_meminfo *mi, u64 start)
 int phys_to_target_node(u64 start)
 {
 	int nid = meminfo_to_nid(&numa_meminfo, start);
+	int reserved_nid = meminfo_to_nid(&numa_reserved_meminfo, start);
 
 	/*
 	 * Prefer online nodes, but if reserved memory might be
 	 * hot-added continue the search with reserved ranges.
 	 */
-	if (nid != NUMA_NO_NODE)
+	if (nid != NUMA_NO_NODE && reserved_nid == NUMA_NO_NODE)
 		return nid;
 
-	return meminfo_to_nid(&numa_reserved_meminfo, start);
+	return reserved_nid;
 }
 EXPORT_SYMBOL_GPL(phys_to_target_node);
 
-- 
2.33.0

