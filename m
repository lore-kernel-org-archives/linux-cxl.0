Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E252F8EB0
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452109; cv=none; b=Q1mv0558Z5/Q17ubhlmTg6qnjD9ybiZFejoKxon+/CLEMs94OyT02JOO8uz4LkPI6Rh89e+TDavJO71gOoidbj9nWYk8RZHfT3/xRvhqvgMDB1KZDcqIA+lIoUgk4Dbw2ObiFrb+g+/5cbGimLBToEXZGQaHDIE6rq7gBBQGTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452109; c=relaxed/simple;
	bh=KwuF3YcN+vAqxIRXEFD56AcN1iqd2/ynk0A2gPYwSTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V6BKRTZo0PNneXTQerOPPuGVs3dNiaAWnVO/VY1HJA6bGiFeLEoU7J4vZAdz27WplcHk1vcoUfdEsFdThae32/9cP6Rwv+7NgOdJlaudGZc+UYv6zYjUkIU5GBoRaEKgrI3uPzH+y6wbws96G2azogVkQpdYekJlhQdeySwlqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZKjjkj0y; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZKjjkj0y"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789452103; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tXlm7O3DgcZxWERB2N7T+/rZbcp8XWDSXSdrrEVEb+M=;
	b=ZKjjkj0yI60OtaOk9u6SeceaE4bCWnoevKWkrDi0J+1ep8vxLLqvPZiWl7StoYqyMCV8rPzjOq9cq8cGMLC1zCPTTTFYt0hus+MH5S5QSmZEra7Nurefh2DIDjXt1lx0g9CCCNp+dofP+kQ9QVrlSMaeVxJjd4S350MUC3AbBsc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB0GgDS_1789452102;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB0GgDS_1789452102 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 14:01:43 +0800
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
Subject: [PATCH] cxl/core: Skip einj_inject creation when devm_add_action_or_reset() fails
Date: Tue, 15 Sep 2026 14:01:38 +0800
Message-ID: <20260915060138.2007974-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_debugfs_create_dport_dir() ignores the devm_add_action_or_reset()
result and creates the einj_inject file below @dir unconditionally.

When the devres allocation fails, remove_debugfs() has already run
before devm_add_action_or_reset() returns, i.e. debugfs_remove() has
released @dir. The subsequent debugfs_create_file() would then use
that dentry as its parent although its final reference was dropped in
the removal and its memory is subject to call_rcu() delayed freeing.

Skip the file creation in that case, consistent with how the rest of
the helper tolerates debugfs failures.

Fixes: 9185b1a3043c ("cxl/core: Fix dport use-after-free via the einj_inject debugfs file")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8d715739995b..95c0be57ed53 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -837,7 +837,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 
 	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
 
-	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);
+	if (devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir))
+		return;
 
 	debugfs_create_file("einj_inject", 0200, dir, dport,
 			    &cxl_einj_inject_fops);
-- 
2.43.7

