Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7F514E2F2;
	Mon, 13 Jul 2026 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923359; cv=pass; b=D4mDCdmFc+OA8dOu6Bot52Tm50gOK5I5OhCbpWDrD9D6k+mcpwRacjUlhiNKi/r2GgMrSOd9HOCky0kpTdl0RTQFGNp9SNPxZ7R2lRWPZ7M4R2g0HzndUpG3IaZL6d1mRpn+cL7XaWg3kNpmctF1YfDDz/VxR1VAeQqw69PXnMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923359; c=relaxed/simple;
	bh=Vbyd95kZLOEv2aIjuLtpU+kJvnX4zA2Ndn+Usqo4udE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4tqEH8ZrSLfqlxETDDdne9v/gsNb2Ygt0D6baxOiLwNtkdsqyghkJa0+j8QZ47CYkBkGp0W5zocqzyrlEk9HJet71iOxn3hJcBytMVJ3I5loiy2jieu71TuKXSII4EptEC8lpvLILlCvWXbXNJ06v763H1PZtdpHoQNYc1Jnxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=WYCxDjx3; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="WYCxDjx3"
ARC-Seal: i=1; a=rsa-sha256; t=1783923347; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HBy0tj+/Z01mohoxVgnMrE0EuYafa365ZwC6bBZDhpJ1XwBajELs9JJYpJRYMBao6uEZ7BFSIAL0FWTbW1SHlhgedmW9a0Oix0at/lFBg4LOP81btaK8qL5jaRQ+7wBpjBezgYEiXXXsTXEoPv2CJHdM3t729Ugw+SPGZCQ0yk0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783923347; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QpCSsoavZ0UueUnObkW494oxKimqh7RVMl4ptKEpXwY=; 
	b=gPJbqIwXyS98era6DxeAvIgbp3vwSLdi1/GXZGGf9Xba0Mc7KlRuuZDqvXaBvE4UP4cY+zh/TOXKJhqcReTAaMpjNdUUBH1eOJrr+GXal4GJZADH3lpEhc0nnvcWA3DGnfJrHWAC68tAgSu5BeiDDTEcIRbdQ2PMAVE6Y8BPlSg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783923347;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=QpCSsoavZ0UueUnObkW494oxKimqh7RVMl4ptKEpXwY=;
	b=WYCxDjx3YtBBaUB6nogQz1SZ8nhj4mYMTd3mvHTHtc7G5C9q/I6EHnY3u9cNpOYa
	/TL9N4PiTRM6qcgbxyN/QnDeAqcocmQHZ+ApY02FZFg9heWFMXiyyA/BcbVsHTD4VKY
	UT3URdow9VDrqCs9HZsIs7yXgZlV/qveIj6sCYfo=
Received: by mx.zohomail.com with SMTPS id 1783923343352621.0510622818688;
	Sun, 12 Jul 2026 23:15:43 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	iweiny@kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] cxl/test: Rework cxl_type2_mem_init() to use cxl_mock_platform_device_add()
Date: Mon, 13 Jul 2026 14:15:31 +0800
Message-ID: <20260713061531.56322-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227582a9214c82924b5ebbc85d00000a4287aaa1747ad47c7aed49ccac2eca6ae4b564fe580577ad6:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

cxl_type2_mem_init() is used to set up mock CXL type2 memory device for
cxl testing, it introduces a known bug fixed by the following commit:

commit d90f236f8b9e ("cxl/test: Update mock dev array before calling platform_device_add()")

Mock CXL devices require updating the mock device array prior to
platform_device_add(), otherwise, the CXL subsystem could fail to
recognize the newly added mock device. Switch to
cxl_mock_platform_device_add() helper to resolve this ordering issue.

Besides, this patch also includes two minor changes.
1. Preserve the original error code returned by
   cxl_mock_platform_device_add(), rather than unconditionally
   overriding it with -ENOMEM.
2. Drop redundant NULL check before platform_device_unregister(), as the
   function internally handles NULL pointer.

Fixes: 6b2e585142e6 ("cxl/test: Add hierarchy enumeration support for type2 device")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
base-commit: 31adec5c3dc489966e6061cbe427dddb81d2e6b5 cxl/next
---
 tools/testing/cxl/test/cxl.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 8ab2ce1262f3..62bd92b3be45 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1947,25 +1947,16 @@ static int cxl_type2_mem_init(void)
 		pdev->dev.parent = &dport->dev;
 		set_dev_node(&pdev->dev, i % 2);
 
-		rc = platform_device_add(pdev);
-		if (rc) {
-			rc = -ENOMEM;
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
+		if (rc)
 			goto err_mem;
-		}
-		cxl_mem[i] = pdev;
 	}
 
 	return 0;
 
 err_mem:
-	for (i = NR_CXL_TYPE2_ACCEL - 1; i >= 0; i--) {
-		struct platform_device *pdev = cxl_mem[i];
-
-		if (!pdev)
-			continue;
-		platform_device_unregister(pdev);
-	}
+	for (i = NR_CXL_TYPE2_ACCEL - 1; i >= 0; i--)
+		platform_device_unregister(cxl_mem[i]);
 	return rc;
 }
 
-- 
2.43.0

