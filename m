Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B221D318A
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795479; cv=none; b=o8j+IIwKSxo0SHMqJJXp9JS4LCjI3xtb+Roe4SIL1dfvWRDpHpudJMQhFvQ2/UtFYQkiCJYioOa3VBjVWwoq4BwdSBXKJ2OB4dTrR0rSbq/5ZfFL/GWIJLg24R4wkBIlnymUbCxMQYg+l+2i+gP16+5gR32p9DbGcxa0utdN1qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795479; c=relaxed/simple;
	bh=r9a3B0NHMXYNWoSXgX8RQXx1GCboaQGzcvb/EOjqiDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HAlPPFnh2FvQsQ1Ze612czrmnjwMEDvVFADd44C3c17cAh7woVvBGd5Ssba6PP8ZY/rHY9j2IzDcXAFNgVG2FTXHXJN8+CUVdOHxdbQPFyD2WuFZk8s5Zf7oG46towO2QqIlXHyrjJHnmr9ODecvmLJWg1ToFcC2T2pzG6Rhf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9F2C4AF10;
	Tue, 27 Aug 2024 21:51:19 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	fan.ni@samsung.com
Subject: [PATCH 0/2 v2] cxl: Pull out mailbox bits to be independent of cxl_dev_state
Date: Tue, 27 Aug 2024 14:49:48 -0700
Message-ID: <20240827215116.536126-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alejandro,
Please feel free to pull in the patches in this series into your type2 series.

The patches pulls out the related mailbox bits and form a 'struct cxl_mailbox'. In
v2 Jonathan suggested that we keep cxl_mbox embedded. So I moved it back to be
embedded. For the type2 devices that does not use mailbox, it can just not have
the mailbox struct at all.

---

Dave Jiang (2):
      cxl: Move mailbox related bits to the same context
      cxl: Convert cxl_internal_send_cmd() to use 'struct cxl_mailbox' as input

 MAINTAINERS                  |  1 +
 drivers/cxl/core/mbox.c      | 91 +++++++++++++++++++++++++++++++++++++++++-----------------------
 drivers/cxl/core/memdev.c    | 41 +++++++++++++++++------------
 drivers/cxl/cxlmem.h         | 22 +++++++---------
 drivers/cxl/pci.c            | 82 ++++++++++++++++++++++++++++++++++++++-------------------
 drivers/cxl/pmem.c           | 10 ++++---
 drivers/cxl/security.c       | 23 ++++++++--------
 include/linux/cxl/mailbox.h  | 27 +++++++++++++++++++
 tools/testing/cxl/test/mem.c | 44 +++++++++++++++++++++++--------
 9 files changed, 228 insertions(+), 113 deletions(-)
