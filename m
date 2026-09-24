Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9E42047A
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284922; cv=none; b=HUgsSNTu2FB0XKFmvsRreJ9N37OyA4N2RpcD6QGA0n8UuwCdxxKXR+aHx4bRsCLrJcnW6tAOVCmAYHKZHxmoqhtR1mv++TMUpyqIzLB4YSL6YcukQGCMz42GeMjvOA00z93e/iCydZfqXsry1EC2jeTfXhBlqcpkcfHxHxEgq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284922; c=relaxed/simple;
	bh=c2/6GksIqnOlgbCTBnsI45aU1WtvG/5sfcLKoej5J4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y78g2+yiWX1s2FbQjM6DUwIPPK49y6Y/eA552prBEDHb4zSMuVm5GwkEjSUjzrpLP+gvGP3JnVsnmkhRVLjfDKQcZoDJnokjuDbJzqk7t2pZ5kn8y+trKgJ58oBWHjry2Vk26dh4pFbkluGy7Kn41xT516QqyQIK9W759Lkcan8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859061F000FF;
	Thu, 24 Sep 2026 21:22:00 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com
Subject: [PATCH 0/2] cxl: dport fixes from sashiko reports
Date: Thu, 24 Sep 2026 14:21:57 -0700
Message-ID: <20260924212159.52920-1-dave.jiang@intel.com>
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

