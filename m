Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2E38DF1
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359154; cv=none; b=IlwjF9EIVbsE0nOnrW3LQ+aee9gLTCj0tiYrKtr+A12Og2xXrbpC7PU4pFLSBJNdY84Hnjs6O3RCdhrdPVPegNNo+deh79ISuy3qPeK3TmoXH3IdXz2UWINDjnoo/kZJssgFnGpxbxgVC5aurFxaLTqqkOeDOb9yfpTchN+6FQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359154; c=relaxed/simple;
	bh=L3SXZwR1JzsVD0om0ns4QR6W0WDLFUzjjIy8z+hH6Jw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nwIp9RdgvAOaO4uzAf95DJ/cXvnFYjGrI5FJue6rV74PnnP7PrMRMqJrBCCnvbatQJffykS1eMxhQkrdLgDq+vDdZAc6meeuRTz/+M3pXVcLukxoyR/nDmVnhfOPydozLAwlMdtfzqoVIln4blowqFqHi7wJMSRIUBiayJzncJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdnWz1d5Cz6K66L;
	Tue, 20 Feb 2024 00:08:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B367140B54;
	Tue, 20 Feb 2024 00:12:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 16:12:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
	<alex.bennee@linaro.org>, <richard.henderson@linaro.org>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [RFC PATCH v2] arm/ptw: Handle atomic updates of page tables entries in MMIO during PTW.
Date: Mon, 19 Feb 2024 16:12:29 +0000
Message-ID: <20240219161229.11776-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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
v2: Thanks Peter for reviewing.
 - Handle the address space as in arm_ldq_ptw() - I should have looked
   at the code immediately above :(
   The result ends up a little more convoluted than I'd like. Could factor
   this block of code out perhaps. I'm also not sure on the fault type
   that is appropriate here.
 - Switch to 'need_lock' as per Philippe's feedback on the x86 fixes.
   likely() doesn't seem appropriate here though.
 
target/arm/ptw.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5eb3577bcd..ba1a27ca2b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -711,8 +711,68 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
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
+        bool need_lock = !bql_locked();
+
+        if (need_lock) {
+            bql_lock();
+        }
+        if (ptw->out_be) {
+            cur_val = address_space_ldq_be(as, ptw->out_phys, attrs, &result);
+            if (unlikely(result != MEMTX_OK)) {
+                fi->type = ARMFault_SyncExternalOnWalk;
+                fi->ea = arm_extabort_type(result);
+                if (need_lock) {
+                    bql_unlock();
+                }
+                return old_val;
+            }
+            if (cur_val == old_val) {
+                address_space_stq_be(as, ptw->out_phys, new_val, attrs, &result);
+                if (unlikely(result != MEMTX_OK)) {
+                    fi->type = ARMFault_SyncExternalOnWalk;
+                    fi->ea = arm_extabort_type(result);
+                    if (need_lock) {
+                        bql_unlock();
+                    }
+                    return old_val;
+                }
+                cur_val = new_val;
+            }
+        } else {
+            cur_val = address_space_ldq_le(as, ptw->out_phys, attrs, &result);
+            if (unlikely(result != MEMTX_OK)) {
+                fi->type = ARMFault_SyncExternalOnWalk;
+                fi->ea = arm_extabort_type(result);
+                if (need_lock) {
+                    bql_unlock();
+                }
+                return old_val;
+            }
+            if (cur_val == old_val) {
+                address_space_stq_le(as, ptw->out_phys, new_val, attrs, &result);
+                if (unlikely(result != MEMTX_OK)) {
+                    fi->type = ARMFault_SyncExternalOnWalk;
+                    fi->ea = arm_extabort_type(result);
+                    if (need_lock) {
+                        bql_unlock();
+                    }
+                    return old_val;
+                }
+                cur_val = new_val;
+            }
+        }
+        if (need_lock) {
+            bql_unlock();
+        }
+        return cur_val;
     }
 
     /*
-- 
2.39.2

