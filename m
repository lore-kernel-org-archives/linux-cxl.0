Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA0F326D55
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770852397; cv=none; b=HHlm6MQctAMTCpRJz6hZf79ygedl3liqlBj7hQMGnMS/xknfAdvbzLhzSAE9r/BmZCAx8CI+yIMf+sdCKct76yFPzMZCaEXBX97LIDPiQN7Kj9WZCRKO96TqrtTkaTLKtgo5dbO0dN7z5i3icHElW6PTUYUqD3cTde41VKgIdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770852397; c=relaxed/simple;
	bh=N5OxyQcSn/ZCJepcyJ0o5rJk9+YWZyyt7wtRG3Sa80E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qs3Dl/Y5EZUsHKQRTJFGvRiukvXVDHoMLJ/dJYpR7iGx9PBRWqcp/rGZ7X+JOQwb7ZznD1UouY2q9+iVGbMhovYHWS6evmaXNU8+EEHtikscja6kjkx+A1GL5QkwnMq+PKsZCYgiWncpbRab6qQZTQb1Gn8l7J/Y2mtEi0pm2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2E8C4CEF7;
	Wed, 11 Feb 2026 23:26:37 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v2 0/3] cxl: Fix nvdimm_bus race for nvdimm devices
Date: Wed, 11 Feb 2026 16:26:27 -0700
Message-ID: <20260211232630.480509-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Try a different approach

A small series to address a race for nvdimm_bus object when using the
nvdimm_bridge object.

Dave Jiang (3):
  cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko
  cxl: Fix race of nvdimm_bus object when creating nvdimm objects
  cxl: Clean up cxl_nvdimm devices when removing nvdimm_bus

 drivers/cxl/core/core.h |   1 -
 drivers/cxl/core/pmem.c | 105 ++++++++--------------------------------
 drivers/cxl/cxl.h       |   2 +
 drivers/cxl/pmem.c      | 102 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 85 deletions(-)


base-commit: 63fbf275fa9f18f7020fb8acf54fa107e51d0f23
-- 
2.52.0

