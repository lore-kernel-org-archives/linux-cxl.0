Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610312AAD7
	for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711266; cv=none; b=dk/0pluTTwUWP6i5/SMZ+D0kzf59kBRnP7+OannvfxCeQ2/u46nb/51hpOcveN1ovCrEO8+FDd6fr4OKE5DN0GqMFDcPgtOq6L8Cux2AxF17Vtx/E4Bl0bnj2GwjC7D/qvaYQHma7Tsi1OfkCTaybfq/8Hxt3bCunxMpboMhKRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711266; c=relaxed/simple;
	bh=QMMRSBYYygQk8hzcIbH7/XqfSvVdODx7ej7Ws3JlNII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jWJU03yF30a0fFsBs1QemZwt1ggjvDXzk6T0o9tA/fHYaDOw3ZByjufhguQF8unF8Xg9wcfNbtbEFdbuWsjYHmcdp470dDmGTmKCC77bbn5MmG1McCpap6kaS9b7vB7rLedaWORFKGRRu/pnVPfJc6YU6DCmYZT2enpRQ2sEq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThHl648vyz6K5ly;
	Sat, 24 Feb 2024 01:56:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D80614153B;
	Sat, 24 Feb 2024 02:01:00 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 18:01:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
	<alex.bennee@linaro.org>, <richard.henderson@linaro.org>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v3] arm/ptw: Handle atomic updates of page tables entries in MMIO during PTW.
Date: Fri, 23 Feb 2024 18:01:02 +0000
Message-ID: <20240223180102.7657-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
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

Seen testing of CXL emulation on arm64 (currently out of tree).

CXL interleave occurs at subpage granularity so is emulated using an IO
Memory Region. The memory is general purpose and as such may contain page
tables. FEAT_HADFS using atomic accesses from the page table walkers to
update accessed and dirty bits.

Note that disabling kernel support this ARM 8.1 feature avoids this issue
as the PTW no longer does an atomic update of the page table entries, but
that is a nasty workaround beyond its use in root causing this issue.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

v3: Thanks Richard and Peter for reviewing.
Much simpler error handle + use of BQL_LOCK_GUARD() (Richard)
Dropped RFC and updated description as seems this is converging!
---
 target/arm/ptw.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5eb3577bcd..140afed451 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -711,8 +711,35 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
     void *host = ptw->out_host;
 
     if (unlikely(!host)) {
-        fi->type = ARMFault_UnsuppAtomicUpdate;
-        return 0;
+        /* Page table in MMIO Memory Region */
+        CPUState *cs = env_cpu(env);
+        MemTxAttrs attrs = {
+            .space = ptw->out_space,
+            .secure = arm_space_is_secure(ptw->out_space),
+        };
+        AddressSpace *as = arm_addressspace(cs, attrs);
+        MemTxResult result = MEMTX_OK;
+        BQL_LOCK_GUARD();
+
+        cur_val = (ptw->out_be
+                   ? address_space_ldq_be(as, ptw->out_phys, attrs, &result)
+                   : address_space_ldq_le(as, ptw->out_phys, attrs, &result));
+        if (result == MEMTX_OK && cur_val == old_val) {
+            if (ptw->out_be) {
+                address_space_stq_be(as, ptw->out_phys, new_val, attrs,
+                                     &result);
+            } else {
+                address_space_stq_le(as, ptw->out_phys, new_val, attrs,
+                                     &result);
+            }
+        }
+        if (unlikely(result != MEMTX_OK)) {
+            fi->type = ARMFault_SyncExternalOnWalk;
+            fi->ea = arm_extabort_type(result);
+            return old_val;
+        }
+
+        return cur_val;
     }
 
     /*
-- 
2.39.2

