Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955315532A
	for <linux-cxl@vger.kernel.org>; Thu,  5 Sep 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575834; cv=none; b=iwIvGSlJdTPSbWd1A9n6lpIiP0RFTPuRvpX+KewHrZOg3tRidSvz6A+cmYvnYOaOZjaOtjKB0K9Lvs7QlvDPOkWd4wQCaXIYZDhhD3rGFuTUXzaMN3dvsmbuRnAe6/b8hXJzo+/Ri/9uE+/WoNV88SJIQehU1Pq5NCUtnl8cQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575834; c=relaxed/simple;
	bh=dz0GpWzwFR88VmjCM6ZotPMpaqQWWDYSR+Zmwngft3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAR38jdf5KdCczoPFGazh+aI24TzAAIobdw/XdPgouVpDyczdoHpZKPxMw9YJsog8n8KGP+rrd9CS+9b0pZRHXpEFhVgaV3zm42B4n+YONFW1Zst0nsY/+PXxApg7gH7Xu2CtqjXLS+N769z2VlfI1brmyGkK+DyZKM+oyEtieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B95DC4CEC3;
	Thu,  5 Sep 2024 22:37:14 +0000 (UTC)
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
Subject: [PATCH v4 0/3] cxl: Pull out mailbox bits to be independent of cxl_dev_state
Date: Thu,  5 Sep 2024 15:35:44 -0700
Message-ID: <20240905223711.1990186-1-dave.jiang@intel.com>
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

v4
- Move headers to include/cxl (Dan)
- Move header moving patch to 1/3 (Dan)
- Fix cxl_mailbox_init input param check. (Alison)

---

Dave Jiang (3):
      cxl: move cxl headers to new linux/cxl/ directory
      cxl: Move mailbox related bits to the same context
      cxl: Convert cxl_internal_send_cmd() to use 'struct cxl_mailbox' as input

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
 include/{linux/einj-cxl.h => cxl/einj.h}   |  0
 include/{linux/cxl-event.h => cxl/event.h} |  0
 include/cxl/mailbox.h                      | 28 ++++++++++++++++
 tools/testing/cxl/test/mem.c               | 44 ++++++++++++++++++------
 14 files changed, 233 insertions(+), 120 deletions(-)
