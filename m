Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52AE433B9
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009389; cv=none; b=fL4FLcY1lRZi2Xn5ZbqiGtd9E1cpr15fD3edWi4sug6TaWNV8vY6GLciLU3qt0EYFKltQI9aLFP7j6cGX02u53m0ik3hMJDWmXmkgu6gG056RTdz8w+QfmeYxw7ZWWfexpvY73HdPUqca15I2rHh0DvH7i60UwAwNCEsEELj0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009389; c=relaxed/simple;
	bh=pqV+j9Q2UAeGwPNp4LbUNp2jHgGPU7VLolQxQcu6Mrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACViLMdmxGVvGasi11KWQ+bM+ddebkgiLUl9Ioc/arWTlH2EtVP2rMHrsSHmyZocVhNZJ3j9eUyOeGT9CUyGKvQUic3vJth/M3jR/tFrfUuHmpOJFgGZ/wAFKRQyCiOQaWPlihy9q2Pft/h0uqIz6b/uFw/rSG9niu2KC9JDltM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbJ9f2MFnz6J9fv;
	Thu, 15 Feb 2024 22:59:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EC5031400CD;
	Thu, 15 Feb 2024 23:03:04 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 15:03:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
	<alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
	<dimitrios.palyvos@zptcorp.com>, <richard.henderson@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
CC: <linux-cxl@vger.kernel.org>
Subject: [PATCH 3/3] tcg: Avoid double lock if page tables happen to be in mmio memory.
Date: Thu, 15 Feb 2024 15:01:33 +0000
Message-ID: <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On i386, after fixing the page walking code to work with pages in
MMIO memory (specifically CXL emulated interleaved memory),
a crash was seen in an interrupt handling path.

Useful part of bt

Peter identified this as being due to the BQL already being
held when the page table walker encounters MMIO memory and attempts
to take the lock again.  There are other examples of similar paths
TCG, so this follows the approach taken in those of simply checking
if the lock is already held and if it is, don't take it again.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 accel/tcg/cputlb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 047cd2cc0a..3b8d178707 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2019,6 +2019,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
                                int mmu_idx, MMUAccessType type, uintptr_t ra)
 {
     MemoryRegionSection *section;
+    bool locked = bql_locked();
     MemoryRegion *mr;
     hwaddr mr_offset;
     MemTxAttrs attrs;
@@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
-    bql_lock();
+    if (!locked) {
+        bql_lock();
+    }
     ret = int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
                           type, ra, mr, mr_offset);
-    bql_unlock();
+    if (!locked) {
+        bql_unlock();
+    }
 
     return ret;
 }
-- 
2.39.2

