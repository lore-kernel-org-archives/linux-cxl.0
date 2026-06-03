Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC1481257
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jun 2026 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513075; cv=none; b=qCtKMi/UYX5hUuuHv2KARWfTdEkuHVlxEcIannckuqTWg4WZoxaHWjBp2dW3n3WsMl6ExUZENEdzaeaWzpkdf3DccDwG0u4gwp4V9MzxbfOA1uAFgzIX4FKGuczZYAAh21jX8wR6ekyGT20lWJHpt+RETrThZHcdORtxtbWM7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513075; c=relaxed/simple;
	bh=X1/PcwGr8ZhHNpPfUoFTpkQsq+B7Ho5YxmMjjKWU3/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qlLyH4NFvKcdyHM8YKotIaHHL27fiUybTTYn9k5iEo87QfzJ4UmIjvbssCVAhQsTxUUJSk+Tnhli7cw5v+y33cW6pepDBkU1zrizCgVabFfuZdJ5f6NJqNYba9DmkGf+Ehdat9rhBjOh9/j1vaZHdPe1Fju12RIeE9RvFbwCZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4701F00893;
	Wed,  3 Jun 2026 18:57:53 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	djbw@kernel.org
Subject: [PATCH 0/2] cxl/pci: Fix the incorrect check of pci_config_read/write*() returns
Date: Wed,  3 Jun 2026 11:57:50 -0700
Message-ID: <20260603185752.4149725-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patches are inspired by comments from Richard Cheng WRT pci config
accessors return PCIBIOS errors that are positive integers rather than
negative errnos. I went and audited the cxl PCI code and found a few
locations that need to be fixed. There are other locations that may
trigger issues, but at this point we'll fix them as they happen.


Dave Jiang (2):
  cxl/pci: Fix the incorrect check of pci_read_config_word() return
  cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses

 drivers/cxl/core/pci.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.54.0

