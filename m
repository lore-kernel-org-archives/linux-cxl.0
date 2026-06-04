Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F5E45000
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596121; cv=none; b=e61dpaUKIbyb5jzKLT6+bPEEwj772RHANjV4UMlatu98mf64e7+p7YRUPfe08b7Yoa5KsvQm3o9AMKTEMj/tbHb0SHE7OhNdcc8k+5m2OCk1ez+WvsqjSXQP4PfmXgXww+3zgu9wnHV3oatZnjYvED3xnWpP89Kl/MaVgKJobCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596121; c=relaxed/simple;
	bh=jLMgoMkA/RgrNvgKyfLCMEe6/tKXJXutfT+3xFwP+ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxTTNN4MNmXm1J6OkpZSGBFhj28/2Zu6xupgZ6has/uSmhzBmXzJFA9mCzt7TJN6NcCOJWne0zUsmIPTnjOXT6YB9KvN8ZpuO2XWe6CUFSQ5CPclSH7gSaAVZ9+rINDuOIwStmpvHrb9axb4MB6B4vQX+B5YrysyrCFNQmHwCkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BD81F00893;
	Thu,  4 Jun 2026 18:01:59 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	djbw@kernel.org,
	icheng@nvidia.com
Subject: [PATCH v2 0/2] cxl/pci: Fix the incorrect check of pci_config_read/write*() returns
Date: Thu,  4 Jun 2026 11:01:52 -0700
Message-ID: <20260604180154.1925149-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Fixed up additional bits (Alison)
- Fix up fixes tag (Alison)

The patches are inspired by comments from Richard Cheng WRT pci config
accessors return PCIBIOS errors that are positive integers rather than
negative errnos. I went and audited the cxl PCI code and found a few
locations that need to be fixed. There are other locations that may
trigger issues, but at this point we'll fix them as they happen.


Dave Jiang (2):
  cxl/pci: Fix the incorrect check of pci_read_config_word() return
  cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses

 drivers/cxl/core/pci.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.54.0

