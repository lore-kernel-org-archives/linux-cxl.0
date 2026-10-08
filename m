Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46B768EA
	for <linux-cxl@vger.kernel.org>; Thu,  8 Oct 2026 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431198; cv=none; b=rEe3BxMqv7rynEIGuARuPyrb5HWWv9F2FsZpLypW1unwQlHVQ1Gx7QM5YyRvNbJ5LPMbHci5zO3X/fViVcAeGEObHdy1jLtI1ZGNTFTFedcn21LYe3a7bANOPGMfMTo3cytk9l1MBcPbZYnUEJ1sP28x/MvyADZ2xfYfaqoZyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431198; c=relaxed/simple;
	bh=rA21tEZMnGKlbsmOy/A2bTCHN0CfxvlJS3Sjq72XZAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VksUp9FYasVcMW4d6NfWalMUDRM1PvUgqEF4A8EusuU1sGYRc1COZQALSl7PkRUJfG0pCYbmTAZ4njZvvPhYipfd5r25bbLuvMYhKWLDi3JfpIGr5xK+KfHQYcthdR1qURK6W0JDjBvQ6mZAFLUZd1MEGuUwHuRFmgbw9A2iL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W8EVQA9l; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W8EVQA9l"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791431191; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=L1yalKePa0gBohNgAqBKxX0Y7guTQQL1c8c3vGdm2Fk=;
	b=W8EVQA9lREDqCfixJsJLjpJOabL7a9JujGvs1/HH0YATahe5iUT7d3MDpjnHuxwjkCw0GSoGNE1l5XXfyoQBR4vEkiAlJsywHlex9s/G3JW9vpIJcwK/WFVMWa+c0lUbG2x0oa8sDAzp6XRaC0Uyh+aa8s9kSghodaF+3AYYnR4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCJd7nc_1791431190;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCJd7nc_1791431190 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 11:46:30 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 3/3] cxl/pci: Update only the Port GPF timeout fields
Date: Thu,  8 Oct 2026 11:46:14 +0800
Message-ID: <20261008034619.28059-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261008034619.28059-1-kanie@linux.alibaba.com>
References: <20261008034619.28059-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_gpf_port_dvsec() rebuilds the phase control register from just
the timeout base and scale, so the rest of the register is cleared by
the write. The other bits are reserved today and nothing is lost, but
the full-register rewrite would clobber any field the spec defines
there later.

Read-modify-write the register and change only the two timeout
fields.

Fixes: a52b6a2c1c99 ("cxl/pci: Support Global Persistent Flush (GPF)")
Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 1f470ab0df3b..edf0b47f39db 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -846,8 +846,8 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
 		return 0;
 
-	ctrl = FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX);
-	ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
+	FIELD_MODIFY(base, &ctrl, GPF_TIMEOUT_BASE_MAX);
+	FIELD_MODIFY(scale, &ctrl, GPF_TIMEOUT_SCALE_MAX);
 
 	rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
 	if (rc) {
-- 
2.43.7

