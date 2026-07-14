Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82167423E8F;
	Tue, 14 Jul 2026 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071129; cv=none; b=MgNOVk7JSeE+X7g5FBOFtPhBHRvebB23hGDJF2rUc2+JgypsJpE2FOHm1yN3JaQ8WirHAIveztBNeIC4eA7aet/1pb0RB46/SXKZDWXSo7zs0Th0N0PuDh9X2V0gyhlvR8ZCjiw4HWOuVRH6kMH7ApUyc6qvKmxbUbZKOJKj6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071129; c=relaxed/simple;
	bh=NuSi7QGAjGX4QsfcR6RUnoXa01j2x6wSUpxiCRCDZXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFYy0huFQjxG6HYoeOokhU9OZqCYQu1Md/Cq9RZuASvzGJgeWWcOgPyFNmb1xyvW9DiJQome9/tF3JdwsQLdnK5w7CWQx6AvaTyxL9X/MpMpqOC/6PlYdgfj04bC7RBO8Ur0Q41g2r7N0X98fmAA+sSU2XIcESjioxpkANIvmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E671F000E9;
	Tue, 14 Jul 2026 23:18:47 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	terry.bowman@amd.com,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v2 0/7] ACPI: APEI: GHES: Collection of fixes for issues reported by sashiko
Date: Tue, 14 Jul 2026 16:18:28 -0700
Message-ID: <20260714231835.303081-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A collection of fixes for pre-existing issues reported by sashiko-bot while
reviewing patches.

1/7: Bound the CXL event record copy to the firmware section length.
2/7: Validate the CXL protocol error section length before the RAS cap copy.
3/7: Avoid populating software AER metadata from the raw hardware buffer.
4/7: Validate the PCIe error section length before payload access.
5/7: Fix the CONFIG_ACPI_APEI_PCIEAER guard typo in extlog.c.
6/7: Defer CXL protocol error handling to avoid a lock inversion.
7/7: Validate the memory error section length before payload access.

v1: https://lore.kernel.org/linux-cxl/20260709162807.1957783-1-dave.jiang@intel.com/

Changes since v1:
- Dropped v1 1/4 "ACPI: APEI: GHES: Use spin_lock_irqsave() for CXL CPER
  work locks". Terry Bowman has a more comprehensive version of this that
  he will post.
- Reordered the series so the two patches that harden extlog_print_pcie()
  land before the CONFIG_ACPI_APEI_PCIEAER typo fix that activates that
  code path, avoiding a bisection window where the path is live but
  unhardened.
- Grew the series from 4 to 7 patches, adding four fixes for the
  additional pre-existing issues Sashiko flagged on the v1 posting.

Dave Jiang (7):
  ACPI: APEI: GHES: Bound CXL event record copy to the firmware section
    length
  ACPI: APEI: GHES: Validate CXL protocol error section length before
    RAS cap copy
  ACPI: extlog: Avoid populating software AER metadata from raw hardware
    buffer
  ACPI: extlog: Validate PCIe error section length before payload access
  ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
  ACPI: extlog: Defer CXL protocol error handling to avoid lock
    inversion
  ACPI: APEI: GHES: Validate memory error section length before payload
    access

 drivers/acpi/acpi_extlog.c       | 40 ++++++++++++++------------------
 drivers/acpi/apei/ghes.c         | 35 +++++++++++++++++++++-------
 drivers/acpi/apei/ghes_helpers.c | 22 +++++++++++++++++-
 include/acpi/ghes.h              |  4 ++++
 include/cxl/event.h              |  4 ++--
 5 files changed, 71 insertions(+), 34 deletions(-)


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.55.0

