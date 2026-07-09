Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAD1A6805
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612637; cv=none; b=uVbzyq2lwNZbVbtGPvGxRhb+cbWL09kfHWwK6wcv5F6WQT6tDkzb/Rz9bV+boziPDBL4N/NhCh0B4oakRoqWkOWe6gUnf3Urx7t0j+h71FbJhPuot4EP/vswgFAc6l7rR3WAZ4g+tk0CXECSs/B1vZve7QJ8PRHDiMto3+28lc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612637; c=relaxed/simple;
	bh=r7oetR+Vdnpfu+1XyhOBjAqnCyfxw892/qEjt6ZZT3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9Ph81oSmqtKC482krEHNnBkXyHjM5bninM1A6viTfxrKklUghhxuQqN372FRCnL/uwoiL570lZ7lSfLwjBGF88hR7bW7fWrFV94cprwHIDk4hbfg0xKxFi8z7ut+sBnI4x4+LYprK2J8+TuoVSDnJayR/8BPsCp/ADCHJRvXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CC81F000E9;
	Thu,  9 Jul 2026 15:57:15 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH] cxl/mbox: Break poison list loop on an empty payload
Date: Thu,  9 Jul 2026 08:57:14 -0700
Message-ID: <20260709155714.1893280-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A device that returns count == 0 with CXL_POISON_FLAG_MORE set on every
iteration never advances nr_records, so the max_errors guard never
trips and the do/while loops forever while holding poison.mutex. That
hangs the sysfs-triggered scan thread and blocks all subsequent poison
operations on the device. The existing "Protect against an uncleared
_FLAG_MORE" guard was intended to bound a misbehaving device but does
not cover the count == 0 case.

Stop the loop on an empty payload so a malfunctioning or malicious
device cannot wedge the poison scan.

Link: https://sashiko.dev/#/patchset/20260702090849.47501-1-icheng@nvidia.com?part=3
Fixes: ed83f7ca398b ("cxl/mbox: Add GET_POISON_LIST mailbox command")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..c09fae2cae9f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1455,6 +1455,11 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		if (rc)
 			break;
 
+		if (!le16_to_cpu(po->count)) {
+			dev_dbg(&cxlmd->dev, "Poison empty payload!\n");
+			break;
+		}
+
 		for (int i = 0; i < le16_to_cpu(po->count); i++)
 			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
 					 po->flags, po->overflow_ts,

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.54.0

