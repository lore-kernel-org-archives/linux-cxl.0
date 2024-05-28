Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E113EFE1
	for <linux-cxl@vger.kernel.org>; Tue, 28 May 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936953; cv=none; b=hqqSslrgf+ZRqRLzPM/zPM1eH932p1Q9ADjsXKPGv8d7rvd8uDExl8UhP6XG2z1H2/SiBOiqfT4v0SrF8sN2UXIPJ3NXLpWwnSV5veUq4kwLU/xu0QXVpopT74bGY5Xx1JNwCx+lhyN32RCMDl83QqANQpDHx3gnrqrZm4Tz/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936953; c=relaxed/simple;
	bh=sx9VWnbMiamEruhp4h2H8JSVWFcqS+zJAZaye3lpHcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eCoYhAxnnIVoTlUrNTcS2GhQ8q1ddqK8un7AIGyZwsBc87GVnMytsD/XzVJmgFt8HihMqor+/KYA3GdwIbid4budwMMeUUAuqDrRMTEULL1agDaFO/M+h9fS662/GZOPetplkyo/3AY51SFW0IPNSlGvGcfHgN+rGJpL9SJeynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63202C3277B;
	Tue, 28 May 2024 22:55:52 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH] cxl/test: Add missing vmalloc.h for tools/testing/cxl/test/mem.c
Date: Tue, 28 May 2024 15:55:51 -0700
Message-ID: <20240528225551.1025977-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

tools/testing/cxl/test/mem.c uses vmalloc() and vfree() but does not
include linux/vmalloc.h. Kernel v6.10 made changes that causes the
currently included headers not depend on vmalloc.h and therefore
mem.c can no longer compile. Add linus/vmalloc.h to fix compile
issue.

  CC [M]  tools/testing/cxl/test/mem.o
tools/testing/cxl/test/mem.c: In function ‘label_area_release’:
tools/testing/cxl/test/mem.c:1428:9: error: implicit declaration of function ‘vfree’; did you mean ‘kvfree’? [-Werror=implicit-function-declaration]
 1428 |         vfree(lsa);
      |         ^~~~~
      |         kvfree
tools/testing/cxl/test/mem.c: In function ‘cxl_mock_mem_probe’:
tools/testing/cxl/test/mem.c:1466:22: error: implicit declaration of function ‘vmalloc’; did you mean ‘kmalloc’? [-Werror=implicit-function-declaration]
 1466 |         mdata->lsa = vmalloc(LSA_SIZE);
      |                      ^~~~~~~
      |                      kmalloc

Fixes: 7d3eb23c4ccf ("tools/testing/cxl: Introduce a mock memory device + driver")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 6584443144de..eaf091a3d331 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -3,6 +3,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
-- 
2.45.0

