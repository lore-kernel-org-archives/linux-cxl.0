Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72054F93C3
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781800; cv=none; b=KjEgPi/ZiCr7lr8kp65HDUC2Od+nI1fOpOwZ36ln9OiYRp+i8EagzYPJYef2xgJvvl3K3lWNqgNHG6Y68oB+zqTxg8rWCjD/6h7rA0Wr6FIDdZx4ttFlFpZ2YMoG6t1vL/ArgR9Mq65y4fApHWqS58YtG7zGPLjr9kpoFh7eLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781800; c=relaxed/simple;
	bh=hAMU8t4cbl8JSXJnALPIfcJ5WCASwUqclHPdJFmJIBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWY1OGQo+y7L4GRxBK5H7a/Q0X1XBKPDBKjIXDpcWn4pi67fW7KAU52s/VONcTIDNEOokFQ+V2/rkdWqvKgSTcSUhjqk05ao80EBgWWXJfK9blkyMH1Tt3No3bxVQHlSDWwiZjp9OsT+RkSQm2eaIbxzMxnPGQXU33ptHahMqP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7681F000FF;
	Wed, 30 Sep 2026 15:23:12 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com
Subject: [PATCH v3 0/3] cxl: dport fixes from sashiko reports
Date: Wed, 30 Sep 2026 08:23:08 -0700
Message-ID: <20260930152311.4164036-1-dave.jiang@intel.com>
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

v3:
- Add patch 3 to attach endpoints under the dport's port lock. (Ming)
- Add review tags from Ming and Gregory to patch 1.

v2:
- Addressed couple things from Jonathan. See patch for revlog.

Dave Jiang (3):
  cxl/port: Clear cached dport pointers when a dport is removed
  cxl/core: Hold the dport host lock across dport lookup and use
  cxl/port: Attach endpoints to a dport under the lock that pins it

 drivers/cxl/core/core.h    |   6 +-
 drivers/cxl/core/pci.c     |   8 +-
 drivers/cxl/core/port.c    | 180 ++++++++++++++++++++++++++-----------
 drivers/cxl/core/ras_rch.c |  12 ++-
 drivers/cxl/cxl.h          |  16 ++++
 drivers/cxl/mem.c          |  14 +--
 drivers/cxl/pci.c          |  11 +--
 7 files changed, 177 insertions(+), 70 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.54.0

