Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5DD502
	for <linux-cxl@vger.kernel.org>; Fri, 13 Sep 2024 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726266738; cv=none; b=T5K/x65ky2fc6tdCU2A142q/uYFJ/JIsyLP41qld0sK4Iw306GhshOSy9Q8Xsc8mP/LL26Ls5EKzzFJfeutR48FlOLaRwdQ/aC/tYwvIOc4rYTLmMv9AQoA1uda8HEGS2ZB/ZlhoWwd/kckdWTG9SqMAIeCMFhaiyCB1b+p3BLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726266738; c=relaxed/simple;
	bh=hFLFBsBpyKd9BSG0RqGPO5yvGpzokGNayidUoccuPlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GE/W6xUSELnmwTytPZs+oJiRxj4KKRkLbJV+RYj/KBsn3pU70RnHEzwFkEKlkkp7ujngeCt3Rrm5R7KzKA4OV5gDYmqJncdvezbTj9dcMQu/2wHnfTFlgqnRLph3PPxohpbl5sdCLE8lT5bhGU7/UFnS3aKfVoyCgK7lcKtG/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983AEC4CEC0;
	Fri, 13 Sep 2024 22:32:17 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH] cxl: Fix comment regarding cxl_query_cmd() return data
Date: Fri, 13 Sep 2024 15:32:16 -0700
Message-ID: <20240913223216.3234173-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code indicates that the min of n_commands and total commands
is returned. The comment incorrectly says it's the max(). Correct
comment to min().

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2626f3fff201..8598199efa09 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -542,7 +542,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 		return put_user(ARRAY_SIZE(cxl_mem_commands), &q->n_commands);
 
 	/*
-	 * otherwise, return max(n_commands, total commands) cxl_command_info
+	 * otherwise, return min(n_commands, total commands) cxl_command_info
 	 * structures.
 	 */
 	cxl_for_each_cmd(cmd) {
-- 
2.46.0

