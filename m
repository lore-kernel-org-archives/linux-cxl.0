Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4D1EC01C
	for <linux-cxl@vger.kernel.org>; Wed,  4 Sep 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725408023; cv=none; b=u69HApKtiPBKdw7jidAeCaRX3txcnV3qnbA6syLaV+TAAirGoRhl0U8CfMAbGDf0yPwl/Tiegp228D/ZXfBau4WfXDbvNwPfLIgWpJF3/O8KCji0nyRwm3ZYgET+J/5xnT93314c4AA7FjRzS8zZuw96uPc1kAY/9WfAFzKgWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725408023; c=relaxed/simple;
	bh=I9jPkHyqF43jXw11fPrcEuVRm5VMOCcgrY5l6AVN+dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGi2xUN3UH+FnSbwBJY92i6gG2WkRYZOdsUkBlilXWPNImsojKP7/piBOK3pChJpUOOTTV1lZYe2vBI27kgbWrXld1ir2sIkU+Mvc85Pbtf77s3Pb11xsUkD4go5t3qT9xwI5MGNs0tiIfjqqquRTGeFO9ZDPWEPkWnYxomouGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE3AC4CEC4;
	Wed,  4 Sep 2024 00:00:22 +0000 (UTC)
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
Subject: [PATCH 0/3 v3] cxl: Pull out mailbox bits to be independent of cxl_dev_state
Date: Tue,  3 Sep 2024 16:59:07 -0700
Message-ID: <20240904000020.1686611-1-dave.jiang@intel.com>
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
Although I may just pull these into the 6.12 merge window to make things easier
for you.

The patches pulls out the related mailbox bits and form a 'struct cxl_mailbox'. In
v2 Jonathan suggested that we keep cxl_mbox embedded. So I moved it back to be
embedded. For the type2 devices that does not use mailbox, it can just not have
the mailbox struct at all.

v3
- moved the other cxl headers into the linux/cxl directory.
- Moved rcuwait.h header into mailbox.h (Alison)

---

Dave Jiang (3):
      cxl: Move mailbox related bits to the same context
      cxl: Convert cxl_internal_send_cmd() to use 'struct cxl_mailbox' as input
      cxl: move cxl headers to new linux/cxl/ directory

 MAINTAINERS                                |  3 +-
 drivers/acpi/apei/einj-cxl.c               |  2 +-
 drivers/acpi/apei/ghes.c                   |  2 +-
 drivers/cxl/core/mbox.c                    | 91 ++++++++++++++++++++++++++++++++------------------
 drivers/cxl/core/memdev.c                  | 41 +++++++++++++----------
 drivers/cxl/core/port.c                    |  2 +-
 drivers/cxl/cxlmem.h                       | 25 ++++++--------
 drivers/cxl/pci.c                          | 82 ++++++++++++++++++++++++++++++---------------
 drivers/cxl/pmem.c                         | 10 ++++--
 drivers/cxl/security.c                     | 23 +++++++------
 include/linux/{einj-cxl.h => cxl/einj.h}   |  0
 include/linux/{cxl-event.h => cxl/event.h} |  0
 include/linux/cxl/mailbox.h                | 28 ++++++++++++++++
 tools/testing/cxl/test/mem.c               | 44 ++++++++++++++++++------
 14 files changed, 233 insertions(+), 120 deletions(-)

