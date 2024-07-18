Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AAE75808
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jul 2024 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338493; cv=none; b=n22/edc0dTLZvzqhatcGiv9+j8UdRMxePukTZ1cqrwD3rOeE4JYpTUd5jSKsB1gsEkWm6CZrTA4V/sc50SeVGUpFGBplE1iBzSeeZ7U8UhXpehmSfTd0K735tLzmjwa4j4o7mvvY0pYrkS5mn7GwasI50fGM/NJF57xE8JyplPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338493; c=relaxed/simple;
	bh=HXbv5uF0ShaKaD9/MeONM3gu/hFXMsNVRnLb7uwT9Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRpEu4hN76BrMOnHc/uU0cQkCk7Hp0EWbbscEG3bBt7YCServ62Cc9kp68WBXG7ZHIf/VzCbRE9L+nlcWRD3UQrc4YMRy29A90mh06L9gGaFmllwCV7DCQz2RZwpf4t4yxvp/fcZrRtcIYVXCdQ3R+TwJDFUQ3He7FE0kf/WTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEC0C116B1;
	Thu, 18 Jul 2024 21:34:53 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	jgg@nvidia.com,
	shiju.jose@huawei.com
Subject: [RFC PATCH 02/13] cxl: Fix comment regarding cxl_query_cmd() return data
Date: Thu, 18 Jul 2024 14:32:20 -0700
Message-ID: <20240718213446.1750135-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718213446.1750135-1-dave.jiang@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
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
index 783cb5ed823f..433819ac36b7 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -547,7 +547,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 		return put_user(ARRAY_SIZE(cxl_mem_commands), &q->n_commands);
 
 	/*
-	 * otherwise, return max(n_commands, total commands) cxl_command_info
+	 * otherwise, return min(n_commands, total commands) cxl_command_info
 	 * structures.
 	 */
 	cxl_for_each_cmd(cmd) {
-- 
2.45.2

