Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE911DF26E
	for <linux-cxl@vger.kernel.org>; Thu,  9 Oct 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024403; cv=none; b=GdfZmIIOXpO+wByx6A9jIQT4SCwP0r5qM8Ir0ufmYbN5+c1EIMp7bVOHKGhUfsKJMI59tr/vJQYP3wf6pYfXqINnhgHV4Ue3jDcECRySJhs6MqUIL+T2TeOGBzddwFLzUEoTi1hIhjIZrwdR2AXt0lmK+LLsD7ChDBR0Vk7Q2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024403; c=relaxed/simple;
	bh=M6DeILRRtON+GLBIuGaMGNOjmU6L8HnjdPSlBbpwfGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNiPXYsQRycXOgZzjTifdXZkpwTSALaMFIid+fXj+GKC5HHGZaJieGk0W6lCTIaVlWZnHgbfc9Nz6e9vDJkLoNTiCMpnV+TAL/WORq4TIv5dLqwtdXSLJggJeJ5VrrLZ/lffwaUNKS6eFcRO0MRYn7W3xkxtQCKL95LzCo7Qn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8EDC4CEE7;
	Thu,  9 Oct 2025 15:40:02 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH] cxl/features: Add check for no entries in cxl_feature_info
Date: Thu,  9 Oct 2025 08:40:01 -0700
Message-ID: <20251009154001.2660917-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl EDAC calls cxl_feature_info() to get the feature information and
if the hardware has no Features support, cxlfs may be passed in as
NULL.

[   51.957498] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   51.965571] #PF: supervisor read access in kernel mode
[   51.971559] #PF: error_code(0x0000) - not-present page
[   51.977542] PGD 17e4f6067 P4D 0
[   51.981384] Oops: Oops: 0000 [#1] SMP NOPTI
[   51.986300] CPU: 49 UID: 0 PID: 3782 Comm: systemd-udevd Not tainted 6.17.0dj
test+ #64 PREEMPT(voluntary)
[   51.997355] Hardware name: <removed>
[   52.009790] RIP: 0010:cxl_feature_info+0xa/0x80 [cxl_core]

Add a check for cxlfs before dereferencing it and return -EOPNOTSUPP if
there is no cxlfs created due to no hardware support.

Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 7c750599ea69..4bc484b46f43 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -371,6 +371,9 @@ cxl_feature_info(struct cxl_features_state *cxlfs,
 {
 	struct cxl_feat_entry *feat;
 
+	if (!cxlfs || !cxlfs->entries)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	for (int i = 0; i < cxlfs->entries->num_features; i++) {
 		feat = &cxlfs->entries->ent[i];
 		if (uuid_equal(uuid, &feat->uuid))

base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
prerequisite-patch-id: e3c6c0e3b81959629a6ffecd3994f683d0d530e4
-- 
2.51.0

