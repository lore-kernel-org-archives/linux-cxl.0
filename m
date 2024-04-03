Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F814A0A2
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159331; cv=none; b=V58+P90UfK27eo3Obx/9u9hEpDXz+xAV+1Cnr+50KStSD0x9AyrX+9ZwVJE44Y2qWNCCEvA1WrvtDhklWa4v7QsijLAJEnvxAzdlZdnf8c25RnShBPlzrZA9iIWerM7WDmN1bq2ao7aR0MslCytpZ3zSwCSLiv3iVzQjS4213f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159331; c=relaxed/simple;
	bh=865GdIasFcJGLv/iz39pSxK5UVpeZQtZy5PmzJTuQ8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcpjsV4FGMi79QG5EEdO+WkZeRQ0JWxXwWwuKrKDA3AhrEF/6+FRtK6c98TQl6AE45hKzc4GQL5ohUSl497WNnnhWfXKUrqgjTxHJZszdQPuzD8HYLnbP5yG8FbSJ/TvmlXxIwk83CbH+Zx07/Z7oZP/OB5EQ/zheY7qCSKl38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4E7C433F1;
	Wed,  3 Apr 2024 15:48:50 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v7 0/5] cxl: access_coordinate validity fixes for 6.9
Date: Wed,  3 Apr 2024 08:47:11 -0700
Message-ID: <20240403154844.3403859-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7:
- Add bug fix for not skipping RP coords that don't exist. (Jonathan)
- Remove min_not_zero() as it doesn't apply here. DIV_ROUNDUP() is sufficient. (Jonathan)
- Reflowed patch ordering for easier backport.

A group of fixes to make CXL access_coordinate calculation function
properly.

[1/5] cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
[2/5] cxl: Fix retrieving of access_coordinates in PCIe path
[3/5] cxl: Fix incorrect region perf data calculation
[4/5] cxl: Consolidate dport access_coordinate ->hb_coord and ->sw_coord into ->coord
[5/5] cxl: Add checks to access_coordinate calculation to fail missing data
