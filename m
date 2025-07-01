Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F41C3306;
	Tue,  1 Jul 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380431; cv=none; b=GXlbM+d9ruZqJ6QRzDh4P9XuPdS66eCmiHuVWaKUf12S0KOjDqSa9y5D7p7QurHbs0ia4l2nOZ5WVoyLDWVPL0tSG6tNKtzX+/V6oDIDbicttz9cXglO/401zj7sxm4FhiuYXAIfmU+/14xiVkKC228ciGRASft2xURrgu+2Y+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380431; c=relaxed/simple;
	bh=Pbx/EKD9++JlxPP6paHBkhHJcaCHEyRFBjtniob5ydQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=le0MBM61O3RCJq7ft8tq2xIVRHMqL5XdUosRSotRQQ4CVJmkhbJT48y1mdBLMwqa34Ni4rwfs5ita5KB8lcTBMo3nhDb1pZxpGGGYwuUBXRCQFfSaqlTZkZLG7RkOGNNFNPl2/7RJe4oslwXQXpB4MjjrSv5tmgLiEG31aWwVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw8KxcJT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw8KxcJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05790C4CEEB;
	Tue,  1 Jul 2025 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751380431;
	bh=Pbx/EKD9++JlxPP6paHBkhHJcaCHEyRFBjtniob5ydQ=;
	h=From:Date:Subject:To:Cc:From;
	b=mw8KxcJTWTUsceAHB41Ph04FCThUEAvv8JJfobCGUJpfdOHexVZU5VhfM0AQnsp20
	 n6K4nUXA6xM9YSx0Jo5qYcEKO73f/mafczWDm3KgIPw21wKI13z7E5rfIAthYOTPO6
	 d4jKAmrXrjucmKTq+705JJvOmmOT/C1Obbr4B+VR4g+NNi/rmeSiDxnCjTcUp2ypa0
	 bipUN5pi2gIskcAcxOihLjwxtAmZSUldVpgqnfCyb/14nA7hti+tYstfvJgIwbE054
	 mhcowXpHC1/tAuZcZwblXCM5NTw5+DBbikZJmwEm4sXQ7/7Nzte6IUkSRaUOW8PduY
	 Tm0TyT2nLV8NQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 01 Jul 2025 07:33:31 -0700
Subject: [PATCH] cxl: Include range.h in cxl.h
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-cxl-fix-struct-range-error-v1-1-1f199bddc7c9@kernel.org>
X-B4-Tracking: v=1; b=H4sIALrxY2gC/x3MQQqAIBBA0avErBswTYquEi3KphqIirEiEO+eu
 Pzw+AE8CZOHrggg9LLn80hRlQW4bTxWQp5Tg1baqkZV6L4dF/7Q3/K4GyUbEjkF27qxbpoWY2w
 LaXAJJZnn/RDjDyS3htxsAAAA
X-Change-ID: 20250701-cxl-fix-struct-range-error-8475cbbf3358
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Pbx/EKD9++JlxPP6paHBkhHJcaCHEyRFBjtniob5ydQ=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnJH89ssC/NjDy2xJ5Rp8N3ldwOj46q367HJ5U+faNrL
 GDw/3FPRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZhIWwfD/7pLQuKXw5Qf22iY
 LDlil60smlC4YIZ9Ub9Rl8Kbq4s9TjL80z3THnL99fXYTf0pMzZYbpy6Y6kM35mDfrsUPQMOMJk
 58AEA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit aefeb286b960 ("libnvdimm: Don't use "proxy" headers"),
range.h may not be implicitly included, resulting in a build error:

  In file included from drivers/cxl/core/features.c:8:
  drivers/cxl/cxl.h:365:22: error: field 'hpa_range' has incomplete type
    365 |         struct range hpa_range;
        |                      ^~~~~~~~~
  drivers/cxl/cxl.h:562:22: error: field 'hpa_range' has incomplete type
    562 |         struct range hpa_range;
        |                      ^~~~~~~~~
  drivers/cxl/cxl.h:570:22: error: field 'hpa_range' has incomplete type
    570 |         struct range hpa_range;
        |                      ^~~~~~~~~
  drivers/cxl/cxl.h:803:22: error: array type has incomplete element type 'struct range'
    803 |         struct range dvsec_range[2];
        |                      ^~~~~~~~~~~

Include range.h in cxl.h explicitly to clear up the errors.

Fixes: aefeb286b960 ("libnvdimm: Don't use "proxy" headers")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/cxl/cxl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3f1695c96abc..b941ff94fe0a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -11,6 +11,7 @@
 #include <linux/log2.h>
 #include <linux/node.h>
 #include <linux/io.h>
+#include <linux/range.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 

---
base-commit: aefeb286b960a0629273d1dc809ea36754f42d98
change-id: 20250701-cxl-fix-struct-range-error-8475cbbf3358

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>

