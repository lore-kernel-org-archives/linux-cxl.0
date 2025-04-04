Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD315990C
	for <linux-cxl@vger.kernel.org>; Fri,  4 Apr 2025 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743807653; cv=none; b=goU1pdgQgb93yhMU/+2/PyvjXgVSktUtew0dVUPZ9uIF8YWV3OA1Y+HfCZGq9mxXxslIlPiZkM3Sj7kAVDCe80+5UMHSzLDWOF49QokU6VOvqKvi9VqhjIBgmSzksbVc8uLDSthBppPpgZs0g96meI+Fqt2DHg8ivj9xz+fdts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743807653; c=relaxed/simple;
	bh=GI59LZegtvwSqN3M+0pzhWuZAS/U4kPx6bumC6R68c4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwB2ae3NSL3WpTTiUV+PFr0ZiPd8SqEgCUSgVQqOk0UQVm29/ypw3kkJZDNBbZR1JBKfD+bT4PJzmgIdjgjV+KYSE3Y0Y9Cg/CsRMN7dupsr8NXDzzF1hfeIzrT2Yvxzp+Tm+ARmgH/ne4K9/t1e6BlycJPhOQSoY6hOcIu4sC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6FAC4CEDD;
	Fri,  4 Apr 2025 23:00:52 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com
Subject: [PATCH 0/4] cxl: Delay HB port and switch dport probing until endpoint dev probe 
Date: Fri,  4 Apr 2025 15:57:32 -0700
Message-ID: <20250404230049.3578835-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series attempts to delay the setup of dports and Host Bridge (HB) register
probing until when the endpoint device (memdev) is being probed. At this point,
the CXL link is established and all the devices along the CXL link path up to
the Root Port (RP) should be active.

And hopefully this help a bit with Robert's issue raised in the "Inactive
downstream port handling" series [1]. Testing would be appreicated. Thank you!

[1]: https://lore.kernel.org/linux-cxl/67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch/

---
Dave Jiang (4):
      cxl: Saperate out CXL dport->id vs actual dport hardware id
      cxl: Defer hardware dport->port_id assignment and registers probing
      cxl: Add late host bridge uport mapping update
      cxl/test: Add workaround for cxl_test for cxl_core calling mocked functions

 drivers/cxl/acpi.c            |  17 +++++-
 drivers/cxl/core/core.h       |   4 ++
 drivers/cxl/core/hdm.c        |  51 ++++++++++++++---
 drivers/cxl/core/pci.c        |  74 +++++++++++++++++++++----
 drivers/cxl/core/port.c       | 186 ++++++++++++++++++++++++++++++++++++++++++++++----------------
 drivers/cxl/cxl.h             |  25 +++++++++
 drivers/cxl/port.c            |  21 +------
 tools/testing/cxl/Kbuild      |   3 -
 tools/testing/cxl/test/mock.c |  34 ++++++++----
 9 files changed, 315 insertions(+), 100 deletions(-)      

base-commit: a0ba0d4ec5e79ce96317a057ce4a60d8aaf0af6e

