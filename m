Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CAE4218AA;
	Thu,  9 Jul 2026 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614490; cv=none; b=WMTWXYFpVrAfUgeRN3nYKMOrK0f5KR80HQXPjOdUVjegd046Av85VXDYv2OW+AyjOtiapZ/tFJuXyY7DnwuPG4OaItttPKnftjkXp+nZSla48S0YoRcZGjJZ7IJII7qDHITbscUqyuf3YuLJO8h3zF//meLcWMHYUW1bQ0ivhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614490; c=relaxed/simple;
	bh=3SK+MJLtBwSW7G/kswawUwR14/LNcV6W2KS6qJj1UqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hw3RyXpM5Ko/4mNKKWtlnQzb+P/vYO2P6retst4oeaSBZwexfvyIgoogBZhO8D9oEac7t2pOJhwhJiBavD9Z7tBesnShytkf39pCqWSIawErJzvowhYW0R84mu3SV/OtQvJrkqFUrgOWlxKV4HaD2kIp0+xlyt50jllcaR/a8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841FB1F000E9;
	Thu,  9 Jul 2026 16:28:08 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com
Subject: [PATCH 0/4] ACPI: APEI: GHES: Collection of fixes for issues reported by sashiko
Date: Thu,  9 Jul 2026 09:28:03 -0700
Message-ID: <20260709162807.1957783-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A collection of fixes for pre-existing issues reported by sashiko-bot while
reviewing patches.

1/4: Use spin_lock_irqsave() instead of spin_lock() for register/unregister
     of CXL CPER work.
2/4: Bound CXL check the firmware section length before copy.
3/4: Fix CONFIG_ACPI_APEI_PCIEAER guard typo in extlog.c.
4/4: Validate CXL protocol error section length before RAS capability copy


Dave Jiang (4):
  ACPI: APEI: GHES: Use spin_lock_irqsave() for CXL CPER work locks
  ACPI: APEI: GHES: Bound CXL event record copy to the firmware section
    length
  ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
  ACPI: APEI: GHES: Validate CXL protocol error section length before
    RAS cap copy

 drivers/acpi/acpi_extlog.c       | 11 +++++-----
 drivers/acpi/apei/ghes.c         | 37 ++++++++++++++++++++++----------
 drivers/acpi/apei/ghes_helpers.c | 15 ++++++++++++-
 include/cxl/event.h              |  4 ++--
 4 files changed, 48 insertions(+), 19 deletions(-)


base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.54.0

