Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F574267B07
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570411; cv=none; b=O3pTI2A1ghFGYMKerc6U4Xl4OXDW0MYPIGuwK61PpjAIreXj7uaGif5dv6OibiDyQVaXEcs84pETVmigOwSRuJu1ttglb8Gy/FlQ/LrUJa18uNeLQKrDRLdVOoYfNVKfOU3LF3KIHLHxp1Zyr3/GZrC1rXyfyUtMeUBQ9b6JYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570411; c=relaxed/simple;
	bh=4sH+4FgNTyaZLfOwxtBM7Y0BRYfPXEu77AbMjKIhUC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9+IuQqDk3Us2cFLtqoZUNkTMyBQd06HyubhigvyigIThq3dHfD7h7nzIJgyCAnw3P8bdKMVj0LIlRhONAUfpOZyGsj/9InDr1aNK6AmS/gP8KJAz8ff+C7L/ApAzE1ozCNnpewJSKGRvQMYg1o9tPiQk2eBw+2R0eGq1NObmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013831F000E9;
	Tue, 16 Jun 2026 00:40:09 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	flavien@nus.edu.sg
Subject: [PATCH 0/2] cxl: Fix endpoint access issues with CXL MCE notifier handler
Date: Mon, 15 Jun 2026 17:40:05 -0700
Message-ID: <20260616004007.4186004-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the issues reported by Flavien to the Linux security mailing list.

First patch addresses accessing possible invalid pointers for cxlmd and
cxmd->endpoint.

The second patch adddresses the endpoint lifetime that is shorter than
mds and needs appropriate guardrails to access.


Dave Jiang (2):
  cxl/mce: Validate memdev and endpoint before dereference in
    cxl_handle_mce()
  cxl/mce: Serialize the MCE handler against endpoint teardown

 drivers/cxl/core/mce.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.54.0

