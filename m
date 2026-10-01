Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52D3BFAEB
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869667; cv=none; b=IpJC4itNtg8ccjsbuVywJSkcRgZE+eytwtoPX27xt+dt1cZdYPqf9agkyBQSQAqQWz1a7Mb8XRMTcehuTs0RK9NoZJr6CyWWmQ2NSB8F9WHiIhuWmvPz27rqxuAhNrIkJvxIVjDNJxyqPV5WIszKZIKIu5JoBqWbXahyC+QFByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869667; c=relaxed/simple;
	bh=nq18bTpPBE7hTEX2yMmmPQZAttVqkqvCbONbfNdTgto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EM66rvS0YPCUBYztHa2thgwJ/xui+2D5aVvUj+mDYEa9uhNXs7EA3/j0ogH34k1EW7xA/GImBjQDD3/E6v5DhPA+1DUf17Us4fklu71HNg8D1oNI4l2UrJ7N4JeFKI+J5KxdIjFu7H2TOomK2G1+jlt7f415Nb8r6ke7/04E+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558DC1F000FF;
	Thu,  1 Oct 2026 15:47:45 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com
Subject: [PATCH v4 0/3] cxl: dport fixes from sashiko reports
Date: Thu,  1 Oct 2026 08:47:41 -0700
Message-ID: <20261001154744.1095902-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Couple dport fixes resulted from sashiko pre-existing issue reports.
There are no depedencies between the two patches.

v4:
- Drop the unused dport output parameter in patch 2. (Sashiko, Alison)
- Add review tags from Alison and Ming.

v3:
- Add patch 3 to attach endpoints under the dport's port lock. (Ming)
- Add review tags from Ming and Gregory to patch 1.

v2:
- Addressed couple things from Jonathan. See patch for revlog.

Dave Jiang (3):
  cxl/port: Clear cached dport pointers when a dport is removed
  cxl/core: Hold the dport host lock across dport lookup and use
  cxl/port: Attach endpoints to a dport under the lock that pins it

 drivers/cxl/core/core.h    |   6 +-
 drivers/cxl/core/pci.c     |   8 +-
 drivers/cxl/core/port.c    | 206 ++++++++++++++++++++++++-------------
 drivers/cxl/core/ras_rch.c |  12 ++-
 drivers/cxl/cxl.h          |  22 +++-
 drivers/cxl/mem.c          |  14 ++-
 drivers/cxl/pci.c          |  11 +-
 7 files changed, 186 insertions(+), 93 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.54.0

