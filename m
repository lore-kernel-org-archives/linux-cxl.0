Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79575038F6
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636624; cv=none; b=AbBPR6hUL4CCZv508EPz9NIrWl16dg3tDDzVRJqqrcOAXC4ZYvnzgoJeoP6/LuOq/KS44/UrkKIHAV/X0kOUwHpmL1DiN3FNQPalE0rtrbo5vkqZBHuN+q7Z4A5qjNRovO3mh2723nWdQQAZBupTkaa9xj8lcv0ghuCZRURhE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636624; c=relaxed/simple;
	bh=dqTUNpc2w8fDeQA6ahD0+Yflh8yS8J7fWMzU3sH9a8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uc5IyIy2mFUajQA8c0Fz4wFPZ/LpX+RU9em+pSk/v4r5ePk7VfO+OqnwAnIHA525q08EtEyLfwKZ9deO/GnIzDxrM/pD+4gJmrdZcHJ3ru6PkLfKXRp4jF/YsiOJ7i+fBmyySM+43fBrh/Z2l+W1yKUFBWhShnRv1v2XTcvhRmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0201F000FF;
	Mon, 28 Sep 2026 23:03:42 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com
Subject: [PATCH v2 0/2] cxl: dport fixes from sashiko reports
Date: Mon, 28 Sep 2026 16:03:39 -0700
Message-ID: <20260928230341.2315153-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Couple dport fixes resulted from sashiko pre-existing issue reports.
There are no depedencies between the two patches.

v2:
- Addressed couple things from Jonathan. See patch for revlog.

Dave Jiang (2):
  cxl/port: Clear cached dport pointers when a dport is removed
  cxl/core: Hold the dport host lock across dport lookup and use

 drivers/cxl/core/core.h    |  6 +---
 drivers/cxl/core/pci.c     |  8 ++++-
 drivers/cxl/core/port.c    | 65 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/ras_rch.c | 12 ++++++-
 drivers/cxl/cxl.h          | 16 ++++++++++
 drivers/cxl/mem.c          | 14 +++++---
 drivers/cxl/pci.c          | 11 ++++---
 7 files changed, 115 insertions(+), 17 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.54.0

