Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37524DA9B8
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071253; cv=none; b=P8sZgafexHQrDMecOIA/LKKxGxEu+twoD1lalwyy3a/SL/YhZnPYqfWzpXs0zRQNE4hevN+PnYJUJXlKmN9nTT3ou+1dhAWX6hz6iYcPJDRJEj/4Z6ciLvcvmRCe4fA16CyiPc2IDFUHHiwUMTJU3Ew0VguInW/TVoXNKR9Z1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071253; c=relaxed/simple;
	bh=gA5bIlqQzL6LM5cz5GQ7S8XMYWTeGH+T0oX/EugC/jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kic8JBzgyCCOqFwpiIftFkbDL8JdugeWGB/s7PaaZophKpDql6ntLz+uXBO7Bh6ImUAJUlCjvvEtp29CvcQW3hE1jDeLVhbHrNN7/ZNVkx/trQStqt4QrJbmpyiyb8XIH0C7LFS5MGV1YNU+bajqbsP4k/R5I2hHvhApbGzQsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I5F9LPue; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I5F9LPue"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790071242; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3AWZMeJw9FhciQFdq2KU+X+QiG1zgQ4V9oopE3PWPdE=;
	b=I5F9LPuergN8N7EgVhH0FY8lAfb64fZ0COwu6docCEwAdm6uWQLyHha1cUWN3LqS41n/+lEryx7zMahM/GbdMtCpbWka8jzhLPltssJ6hG4KBuOUUG80HndDx8rgh6C53uAaeY5WJHXnVK/ioI+fM8dh0J1oY0HQeHXNubpwdkg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBTOdmH_1790071241;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBTOdmH_1790071241 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 18:00:42 +0800
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
Subject: [PATCH 3/3] cxl/pci: Update only the Port GPF timeout fields
Date: Tue, 22 Sep 2026 18:00:13 +0800
Message-ID: <20260922100026.3742401-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260922100026.3742401-1-kanie@linux.alibaba.com>
References: <20260922100026.3742401-1-kanie@linux.alibaba.com>
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
 drivers/cxl/core/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 1f470ab0df3b..72e54facafe8 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -846,8 +846,9 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
 		return 0;
 
-	ctrl = FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX);
-	ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
+	ctrl &= ~(base | scale);
+	ctrl |= FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX) |
+		FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
 
 	rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
 	if (rc) {
-- 
2.43.7

