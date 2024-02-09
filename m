Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8382E852
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479675; cv=none; b=hAey9WAzyd6Vbl/aQuBqNgUzKvhVbp5GOdlj3X8wkkQUgwcPQ0bHuFp6WmFM2mHGhqRheGRsYEXUkkAupCpSlZFnwkrNEkFpmshx7ppp9wDYPtjv7S1jXo4StWP+6JhaXRk5Hc+z+F5/PPbwHBh/eHyvEQDY4KAHE/ebeD/NVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479675; c=relaxed/simple;
	bh=SKVS38o1Km3z4Luil8Xfaslo0HYVtFO34MsPNdZRqi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uLgm3WJIlBmRvhaIfvprJo8fGC6mVXNi1RG+WjlQMgARERgMzJnzQfB8Qev+FE2wPblEe2XIQ/+3IE3WEmqzZZikzJcWwfN3FmaRPu/o5gp4B7LM6sFmIqRwOu7Dr683DrQ2o0lOkGifQlpcTONE8cobH1noC0zDgXe/ZVn+SQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WuEDcAj6; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WuEDcAj6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707479673; x=1739015673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SKVS38o1Km3z4Luil8Xfaslo0HYVtFO34MsPNdZRqi8=;
  b=WuEDcAj6g2MLlN17FfrWU0M/JGLy7UmB2t3pOZJyeF28gufrRc2S4FsM
   NiOW+O2NdPH7ZmoVyKLOoAb7V+vJETDE5079gmBfafhtG5qMI7FEAaCQL
   +BawxgeT4yPg65ggKyTnCNaxULbFUX8lc98lTKoKd+i2xM2pomlqhah8V
   IsVgbZWwyHZgvpS3ley5hEH0TsPY4hH+X6H6K8Ko2tSig+UrZkI2gerOj
   9fKf2opdmM7es6VZ0AIM3L6DpOe3IRmCz0vgRv49hB1qrhvkFJ39X/CP/
   hiq3u7GlCS8CILYdq6G/N4insdW5A0dmnO4QrnBAlzeXsTzpSbmDrwIYu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="149214305"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; 
   d="scan'208";a="149214305"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 20:54:22 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C988F2382C
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D154D7B8F
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 973951EA835
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 573551A00A1;
	Fri,  9 Feb 2024 19:54:19 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 3/5] cxl/core: introduce cxl_mem_report_poison()
Date: Fri,  9 Feb 2024 19:54:15 +0800
Message-Id: <20240209115417.724638-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--10.314200-10.000000
X-TMASE-MatchedRID: iRE9Ev702i8M5CG8CYBPxRhvfWx0TE/bpUdkPtBbnm48DTfVRLTQzC/6
	oQ/dDcvKjFsElAmG+V4AFpgHFBD8OTalR2nLpNunvVD3+zz/FW/0swHSFcVJ6DoUdFbHYUawvwU
	evDt+uW5/XjpbSJS7a1Tdr6jAw79qMzwe5s18okMe4SzTjxRVolgy2ozNthE2S1jK4vkKprEEk8
	U+JlahFNbw3DIpBm/jzHj1xOR70ZBNBEVz6twCz54CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyH4gK
	q42LRYk15qh5+XAYnW7HdUyxQzt8SsIfslr3ZFShfFE3dU460d+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

If poison is detected(reported from cxl memdev), OS should be notified to
handle it.  Introduce this function:
  1. translate DPA to HPA;
  2. construct a MCE instance; (TODO: more details need to be filled)
  3. log it into MCE event queue;

After that, MCE mechanism can walk over its notifier chain to execute
specific handlers.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 arch/x86/kernel/cpu/mce/core.c |  1 +
 drivers/cxl/core/mbox.c        | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bc39252bc54f..a64c0aceb7e0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -131,6 +131,7 @@ void mce_setup(struct mce *m)
 	m->ppin = cpu_data(m->extcpu).ppin;
 	m->microcode = boot_cpu_data.microcode;
 }
+EXPORT_SYMBOL_GPL(mce_setup);
 
 DEFINE_PER_CPU(struct mce, injectm);
 EXPORT_PER_CPU_SYMBOL_GPL(injectm);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 27166a411705..f9b6f50fbe80 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -4,6 +4,7 @@
 #include <linux/debugfs.h>
 #include <linux/ktime.h>
 #include <linux/mutex.h>
+#include <asm/mce.h>
 #include <asm/unaligned.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
@@ -1290,6 +1291,38 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
 
+static void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
+				  struct cxl_poison_record *poison)
+{
+	struct mce m;
+	u64 dpa = le64_to_cpu(poison->address) & CXL_POISON_START_MASK;
+	u64 len = le64_to_cpu(poison->length), i;
+	phys_addr_t phys_addr = cxl_memdev_dpa_to_hpa(cxlmd, dpa);
+
+	if (phys_addr)
+		return;
+
+	/*
+	 * Initialize struct mce.  Call preempt_disable() to avoid
+	 * "BUG: using smp_processor_id() in preemptible" for now, not sure
+	 * if this is a correct way.
+	 */
+	preempt_disable();
+	mce_setup(&m);
+	preempt_enable();
+
+	m.bank = -1;
+	/* Fake a memory read error with unknown channel */
+	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV |
+		   MCI_STATUS_MISCV | 0x9f;
+	m.misc = (MCI_MISC_ADDR_PHYS << 6);
+
+	for (i = 0; i < len; i++) {
+		m.addr = phys_addr++;
+		mce_log(&m);
+	}
+}
+
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
-- 
2.34.1

