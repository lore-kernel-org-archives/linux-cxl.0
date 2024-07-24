Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9E1591F3
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jul 2024 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847412; cv=none; b=An25vDYnZkbhd3ErAQ5LINR0bVQwPbq/GoFMKBt+9CZNcc/x1lH/yJi7G7tYU2zh+S6fA9kqRd+9Rh79G+1BrA9rRGS/r/tJGeC0kne97B6UXNPdlIZiyAZyrE4av0Jl4KphIdDZz09qhk9y+IDiStlueSVkyXLUZPvy31ilkAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847412; c=relaxed/simple;
	bh=knZKYr+Gg9lpcQC6ibTFOX+1BsMJRCbRfpT50rioPZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYrI+Me1G+QakvReeIA01IF6dldjs5Wo2cckM5LPxTdql6Xl8pcdKXE9gZK1sRyMoRdbrvQvMvRKtAJgRpV/op1p3RWGMz9LAka2E+IEh3QJOJQmh9Q/9uWjRP4Dux4/EwqXHtbYrzVrzjSXE/hkgar41e61SzoQH+GlYxqbHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89BDC32781;
	Wed, 24 Jul 2024 18:56:51 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH 0/2] cxl: Pull out mailbox bits to be independent of cxl_dev_state.
Date: Wed, 24 Jul 2024 11:55:15 -0700
Message-ID: <20240724185649.2574627-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alejandro,
Please feel free to pull in the patches in this series into your type2 series.

The patches pulls out the related mailbox bits and form a 'struct cxl_mailbox'. A pointer
is created to point to that in 'struct cxl_dev_state'. The cxl_mailbox is independently
allocated if the mailbox register is discovered. This should separate the mailbox out
to be used by CXL type3 and type2 devices.

---

Dave Jiang (2):
      cxl: Move mailbox related bits to the same context
      cxl: Convert cxl_internal_send_cmd() to use 'struct cxl_mailbox' as input

 MAINTAINERS                  |   1 +
 drivers/cxl/core/mbox.c      | 139 ++++++++++++++++++++++++++++++++++++++++++++++++---------------
 drivers/cxl/core/memdev.c    |  55 ++++++++++++++++---------
 drivers/cxl/cxlmem.h         |  22 +++++-----
 drivers/cxl/pci.c            |  88 +++++++++++++++++++++++++++-------------
 drivers/cxl/pmem.c           |  13 ++++--
 drivers/cxl/security.c       |  23 ++++++-----
 include/linux/cxl/mailbox.h  |  28 +++++++++++++
 tools/testing/cxl/test/mem.c |  46 ++++++++++++++++-----
 9 files changed, 301 insertions(+), 114 deletions(-)
