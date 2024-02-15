Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC812C548
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009332; cv=none; b=uAy+ykQERHVxqHOON4nu1YixCxisdkQDbMv+36lNVbbAGZD/iV1eYD/8x/OdlcIgj4bCUVvtSI6FeQIBZWo6U/R5sHa+bE/DmYMI2hqn2e2pL5dViZY/wSNyEw2fE+RvvD/Bvxb2HqWCqEjSLzFi6DWzZueHoDEf4a7wlDPyniM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009332; c=relaxed/simple;
	bh=ROFd13/o8KfmCNW0GkK1JQgkcZn/d/vTOcezSbUvsTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjDy2jBL2U64+26Aml4HGnLrkgsUTWvV1p3q3pADlqYT3eBzQ+Uwj5NKelD96+wt0yWg7KIvzRvudFVvwYkKq3czep5oMA7Z72OUHG/jXlSVCfFd4jkSzU4UFeSZW9bMjin6PchH7hx9hbQKe4S1eNkLkf0O3YwSG4eA8e26dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbJ981cwqz6K8Xc;
	Thu, 15 Feb 2024 22:58:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 06233140DAF;
	Thu, 15 Feb 2024 23:02:04 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 15:02:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
	<alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
	<dimitrios.palyvos@zptcorp.com>, <richard.henderson@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
CC: <linux-cxl@vger.kernel.org>
Subject: [PATCH 1/3] accel/tcg: Set can_do_io at at start of lookup_tb_ptr helper
Date: Thu, 15 Feb 2024 15:01:31 +0000
Message-ID: <20240215150133.2088-2-Jonathan.Cameron@huawei.com>
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

From: Peter Maydell <peter.maydell@linaro.org>

Peter posted this in the thread trying to fix x86 TCG handling
of page tables in MMIO space (specifically emulated CXL interleaved memory)
https://lore.kernel.org/qemu-devel/CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com/#t

Peter, are you happy to give your SoB on this one?

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 accel/tcg/cpu-exec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 977576ca14..52239a441f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -396,6 +396,14 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     uint64_t cs_base;
     uint32_t flags, cflags;
 
+    /*
+     * By definition we've just finished a TB, so I/O is OK.
+     * Avoid the possibility of calling cpu_io_recompile() if
+     * a page table walk triggered by tb_lookup() calling
+     * probe_access_internal() happens to touch an MMIO device.
+     * The next TB, if we chain to it, will clear the flag again.
+     */
+    cpu->neg.can_do_io = true;
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
 
     cflags = curr_cflags(cpu);
-- 
2.39.2

