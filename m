Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD468306483;
	Wed, 11 Feb 2026 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806027; cv=none; b=m5/x6iJvfG3/3gh8TKvybKjy3T4kU8rw/hXeoGrKFQreW7rO3tzMDvKCmaiVL/mwpsvcjXoydaZhtGAUlwlS/mkTlDLQBkUQTnGfX2BZvvC3j+u6h1CHQfJCROXq5aKQQ1ghyxxaEeZFLnDqwrJ1FmAzz1if3yPzHGXAxSdHd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806027; c=relaxed/simple;
	bh=nNZhmrAXS9NCV/+mZaC0TgUuUNpq63EomL6wb8jr/DM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgxEcXiX16FQmHsgDHhN0XG3SkZICipXQh3U60wdLb7oCiK57imEGjZd17t96yp49pQ+pKBF2N6lKTmBdyqjUfNK0F0r24Wm+UgQ2FUEVrchHtM2g/5/EZ4UyvFVkRVbMO2/lv1+tpHZFY/0dxV/zoiF0A17LHxplzL9nhocIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAXF5P2WoxphOYHBw--.348S2;
	Wed, 11 Feb 2026 18:33:26 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwDXMO7yWoxptIgaAA--.31566S2;
	Wed, 11 Feb 2026 18:33:22 +0800 (CST)
From: Cui Chao <cuichao1753@phytium.com.cn>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	dan.j.williams@intel.com,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
	Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 0/1] Identify the accurate NUMA ID of CFMW
Date: Wed, 11 Feb 2026 18:33:19 +0800
Message-Id: <20260211103320.2064211-1-cuichao1753@phytium.com.cn>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDXMO7yWoxptIgaAA--.31566S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQADAGmLkQQCTwADs7
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Changes in v3:
- Clearly state that this issue was discovered in QEMU emulation.
  While it may theoretically occur on hardware, no such case has
  been observed so far.
- Describe the runtime effects in the changelog.
- Add the Fixes: tag information in the changelog.
- Update the comments to clarify the selection logic between
  numa_meminfo and numa_reserved_meminfo.
- Add Jonathan's Reviewed-by tag.

Cui Chao (1):
  mm: numa_memblks: Identify the accurate NUMA ID of CFMW

 mm/numa_memblks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.33.0

