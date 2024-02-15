Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0264132C07
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010319; cv=none; b=jds3Q3JQQLc+4eh+qgE6fKbQaK2Wie3G9XHTCXcNL1zf1U2Cl89IeJldMYfE0nKCJj1/Hrl4oOXtkXWljl+qPwx7vBzQW5cC7rOVWFowfeQJiD0YkM5LEufJU3KvUPZN5pMsbp3Uvj7o3aHrQFXfgTweFlkXk54hg5gl2ktpNWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010319; c=relaxed/simple;
	bh=hcGuM9pEi2knAV47VyKoRtcl4366h50cB4D+I2DQx7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKwsVBIUe/bhPgIBe1N54qZxCnSL0954aGyUVk6VbgNhK/u8/rl0WmPU+Er87PVoIEn2DdNEnAV+N6vzCba6zwnXtUr8JhqdViDBh6e/wRlFC5neIfF+E15SX5C7P/rCYnW6LhcRcDzDBA5tELgdX5hRIGLAhnG+mxO+o0+X8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbJWt5spZz689Hq;
	Thu, 15 Feb 2024 23:14:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D6EF1400CD;
	Thu, 15 Feb 2024 23:18:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 15:18:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
	<alex.bennee@linaro.org>, <richard.henderson@linaro.org>
CC: <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, <linuxarm@huawei.com>
Subject: [RFC PATCH 1/1] arm/ptw: Handle atomic updates of page tables entries in MMIO during PTW.
Date: Thu, 15 Feb 2024 15:18:04 +0000
Message-ID: <20240215151804.2426-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215151804.2426-1-Jonathan.Cameron@huawei.com>
References: <20240215151804.2426-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

I'm far from confident this handling here is correct. Hence
RFC.  In particular not sure on what locks I should hold for this
to be even moderately safe.

The function already appears to be inconsistent in what it returns
as the CONFIG_ATOMIC64 block returns the endian converted 'eventual'
value of the cmpxchg whereas the TCG_OVERSIZED_GUEST case returns
the previous value.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 target/arm/ptw.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5eb3577bcd..37ddb4a4db 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -711,8 +711,38 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
     void *host = ptw->out_host;
 
     if (unlikely(!host)) {
-        fi->type = ARMFault_UnsuppAtomicUpdate;
-        return 0;
+        /* Can I do a load and store via the physical address */
+
+        bool locked = bql_locked();
+        if (!locked) {
+            bql_lock();
+        }
+        /* Page table in MMIO Memory Region */
+        if (ptw->out_be) {
+            old_val = cpu_to_be64(old_val);
+            new_val = cpu_to_be64(new_val);
+            cpu_physical_memory_read(ptw->out_phys, &cur_val, 8);
+            if (cur_val == old_val) {
+                cpu_physical_memory_write(ptw->out_phys, &new_val, 8);
+                cur_val = be64_to_cpu(new_val);
+            } else {
+                cur_val = be64_to_cpu(cur_val);
+            }
+        } else {
+            old_val = cpu_to_le64(old_val);
+            new_val = cpu_to_le64(new_val);
+            cpu_physical_memory_read(ptw->out_phys, &cur_val, 8);
+            if (cur_val == old_val) {
+                cpu_physical_memory_write(ptw->out_phys, &new_val, 8);
+                cur_val = le64_to_cpu(new_val);
+            } else {
+                cur_val = le64_to_cpu(cur_val);
+            }
+        }
+        if (!locked) {
+            bql_unlock();
+        }
+        return cur_val;
     }
 
     /*
-- 
2.39.2

