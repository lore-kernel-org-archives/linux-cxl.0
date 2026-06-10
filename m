Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F33451A6
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 04:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065277; cv=none; b=TLK9tH1K2mrvDU+gz2mREGhlXgg9BX+1ooywXUcb4lCTe/DapjNuo4jiGuCGO8Bjc89wTP/uKuPx60n9T7Q7BS4Is2vJllhWV7TTulsv+UOiD9A3ix7Na3V7C5n3T/6M0L2pyNcNc+dQZur3us0Qo7Ft8Q6IvrYmol8Flmney7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065277; c=relaxed/simple;
	bh=8r4IK37HfTnW+h0WmN13+JbL3R2Yj/HqfLGqIDnudRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N49YqThHVPFoqyN2NTUftEAPZnODtNIs8ilR9p/SSwS3T5EIFl0dOUj2LsTUHZhQkdKGXsduoYxMlYYWGGA9liEVaVtwu2Q8ixKivVG++oktayRXnX6aeUUtW1vYhsIJCtUi5JEW6CXIcO3aXHnf4DopWHieVv+OEmvBsvXS1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV3iJPjw; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV3iJPjw"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-304cf518c9dso7801928eec.1
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jun 2026 21:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781065276; x=1781670076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cV/zwDUa6XpXA/PPeSsXcvCj6iORyMvQtIqVFHrp2rU=;
        b=GV3iJPjw/FgHVWn2iA0NS7mbigDSYH6iYk3+wM90gdw1xH1fxMdla1JH24EIpb10R7
         YU3cD2g2zrI5wuYgDd1jIH7HTCrI+c1dR/QBj0d3gY1FCJ04Fc3uipbTlVvNeak5RVjI
         nQhr7m64Pvso3XgwqGT4V1bThOnyds36o3W9GyIJkRfxMssBd6wutLOH/xLYvXQ8l+Pf
         KUWFbezg71KuHxWpAOXPZ6pAhXT1NubtsDogfhkaIajk75tWbxwWGk6l8nlphWcuUImZ
         U2wnUqta9SEpkX/gHUDOas1pOIDnGYTGXLaSkrm3dimNAqQu7Wj3jLBaOYc0x+COv1D2
         CPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781065276; x=1781670076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV/zwDUa6XpXA/PPeSsXcvCj6iORyMvQtIqVFHrp2rU=;
        b=KlXEda1Jzvp3Q8YoAWYIteGsDcI8zFlj2FgYoCgfMRO9JveQ+HiYD0R/h+55w/Bhn9
         EZX7Z9roIxALk8ZJTo2SKLEYKYPhTpM2QRVBpAeb/KQKpSg1OWXsk4N4tHrV6BQb5kRQ
         Rf5ZoqlctA6ZJTjgTp/H0WOToCVcXwAPiQ0zcYC//WBqxWg/G+UPNMR+KC/v6kVeu6SE
         jncTT8cJ141FMhOmWjTHMo9u8KVgxcaOUY4VqXhFbqcvLxODeqbGD7t4bzBmSray5O1N
         //n84nGgO0qntgLQ4WSK1Aw1DzoUE32e9B1CeZxwj+wYifGejihS9eg7YqAR4+WTgz+e
         qp1Q==
X-Gm-Message-State: AOJu0Yx3f3Q3K5UdMkaNw7uvrFGVEGTjvIQiohA3Hy+aMeoZ5nhfFm5M
	g/KKaP5mI6gnI0QLwY5xSGxz/bbu1QammJbXWzspCcPrFwdPLfyS5rWI6T91NgzL
X-Gm-Gg: Acq92OE1Yq2F4GFYKtRfjgVF1NQaur3DgZTreG4ghZVAb8AQ3hRwzbqMqVpKcqiOKLs
	ZT2Gi+cnmHYIpLQahz5xpd6Q6Xyc0AkoEKDYOQ5ZYd8tWuGYBLqDeFGFlpanc7R8KDYEUXbx2hN
	kQuvWwsbHk/44CfynlzSvoXlHCc7jtW7/cMXgFkRve4oj9Qs9tcfBwrsPuVijZDQvGUaf+4wqPq
	SIituIXPNGE/5S3sC9D2iH6ezw1DDq38CQZRiRKNgzKIdZUCKrotFSE+jtGgJAf4FDmJasjX9Vj
	hbcV1TAEDZ8dKTsAi5d8bcCXr2AzE4k/6+oU4OAyfB5iL7UJ/BLkKFdT2eIlsYqHj2JlzuAFgrr
	MKanN6DJ5TAa/evBGEIvH48YZuwbMYTxhcPcBg/6tTsMRu3/YISt2Ks3FLTX+xw8mAhF3kD2KzT
	XNg2foL0aEZ4Zi/hQBCJ8n1cWyETJui1qi1uWZRrf54ZDxmFes0dNp6EboTGGgQiV1rW6uVzxQv
	LU1zLWA7PQffz0O64VIPqe3RooTJ/Z+ObNVtv/bjcpNfpqYumPaVWv+b8vP1NPGvWNsquLazNZZ
	r1gMneOlYD7krwWqb+g31EA572tNy2tUYngKydY=
X-Received: by 2002:a05:7300:7313:b0:307:26a3:75d2 with SMTP id 5a478bee46e88-3077ae86b6emr13439905eec.7.1781065275578;
        Tue, 09 Jun 2026 21:21:15 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm34322211eec.5.2026.06.09.21.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:21:15 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <djbw@kernel.org>
Subject: [PATCH] cxl/port: update reference to removed CONFIG_PROVE_CXL_LOCKING
Date: Tue,  9 Jun 2026 21:21:01 -0700
Message-ID: <20260610042101.222349-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment in drivers/cxl/port.c refers to CONFIG_PROVE_CXL_LOCKING,
which was removed in commit 38a34e10768c ("cxl: Drop
cxl_device_lock()"). That commit switched CXL subsystem locking to
custom lock classes, which can be validated via the standard
CONFIG_PROVE_LOCKING option. Update the comment to reflect this.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/cxl/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ada51948d52f..99cf77b6b699 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -18,7 +18,7 @@
  * firmware) are managed in this drivers context. Each driver instance
  * is responsible for tearing down the driver context of immediate
  * descendant ports. The locking for this is validated by
- * CONFIG_PROVE_CXL_LOCKING.
+ * CONFIG_PROVE_LOCKING.
  *
  * The primary service this driver provides is presenting APIs to other
  * drivers to utilize the decoders, and indicating to userspace (via bind
-- 
2.43.0

