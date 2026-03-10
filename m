Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB322D948D;
	Tue, 10 Mar 2026 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158329; cv=pass; b=OOxVozoEdTCJIWSjp7B18a30gB3ydjwW1gNqfHuoKix6dwvWEDvea5IcGTfNCBAZbnBTxM18bzkiNJq1RNaHShEE9hu+CiV0E4+0zRsPlL0LYIQFrAdOGN3G+kVwofe2qczwluHm/Rw1H9tgttTimuqYjL3+CEsUvUfWgkDkzpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158329; c=relaxed/simple;
	bh=1u0eE1HGEX8rL7RMeKE1N6ZnnYKoX6mxYsQwair4CFU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WdG00nYWXKUyNtDEYJp7qIOT+RjXchkQA4BiqoXhnrKn4VjMredg7nkpysD9SFDciJCJRXmygut0pWYy3TGa6NyY5xcolWBHouqxsStpfX1AQWDQlQYsxAfz6Q7NLqxx8IxUO2hxH4P9YkJc6wHUZQ96D5c/3YIPKkm1BarxNR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Cpibf9Fr; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Cpibf9Fr"
ARC-Seal: i=1; a=rsa-sha256; t=1773158303; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=diZ+7ITQLxdvNTRRCBqX4RKEQBf6Bbp1nS4Y9HjmYtyoJBH4crEVV+7/DBLHzACAn0WTHm/S+OzkBmgH3TMHh685lBp8t06u2lMTUxEeJikZ18OnYicNDEvCi1zjJPg2L9lRtPInTyoHfzKn8l89jZPrMRuo0yPD4Cl/DCLjWG4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773158303; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xGspoZOHH3LvH7VpBWRKoZDOYne2lQ3PLoBGP7O8X14=; 
	b=NQyg5JWq/iXpFdVw5eYqQEqUDIjMf6gj+EDRh0iL/QDj6lhMZZNnpH4y+SgWz/ke9SLcFSgi6EC5TWVIu94ZNLO+KgP6becWi2wV9u4SiwCPDF/Zav1RGOZFI7eM8FElcQADn9Rykv0KXQVw8IaYKK2NvDLmyB3Rf9ZSTEvwrLI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773158303;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=xGspoZOHH3LvH7VpBWRKoZDOYne2lQ3PLoBGP7O8X14=;
	b=Cpibf9Frc2u4y28rx4G8oFyo74H7fz9zF9wqjfnQ8vDm1IP8EziahEHFOiNjcEw+
	FMtZMP+bxmVCe5Sc5l8QalUR0sCn3TOYP58+EutBI02u/TBXVp2QU5CdRiZRjo5RnjZ
	g1BCDZbifaormZtAuxW1iOo5lRHIdLd9XjiGXUvA=
Received: by mx.zohomail.com with SMTPS id 1773158301759441.28375377099576;
	Tue, 10 Mar 2026 08:58:21 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Subject: [PATCH 0/7] cxl: Consolidate cxlmd->endpoint accessing
Date: Tue, 10 Mar 2026 23:57:52 +0800
Message-Id: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIA/sGkC/x2NQQqDMBAAvyJ7NpCmIuJXiix2s2kWIZFsagvi3
 xt6nMPMnKBchBXm7oTCh6jk1ODWd0BxTS824huDs260dzuZIF9ciVgVOfk9S6r4kRrzu6IvB1J
 k2kxwPIYwPD0NE7TWXriJ/89jua4f6ixVi3cAAAA=
X-Change-ID: 20260308-fix_access_endpoint_without_drv_check-f2e6ff4bdc48
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773158297; l=3228;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=1u0eE1HGEX8rL7RMeKE1N6ZnnYKoX6mxYsQwair4CFU=;
 b=HtZxpBt7UomiiaWL9CsvjVC94Lig4Y4YJYZQVkBCvM4P92VJn95hed2bNxqb4honDokzIU7PW
 z5zEg2IKJG9Arb2hnV8p2a74PprbkGrp7g/ST6WZ070WZjoy7ikz8to
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228e431d94d970ebe39a651079600009f4c934caf4511bb5b6ad106e703596bab72d449f226c023064f:zu0801122734182b289544285d3bcbcc9d0000010d6ce73a2f4bf443aaee0019040ed587ba63cb741cad1e5c:rf0801122d96a5337e4bd3bde8ce507dce00000d4747a8608096d4faf3d550d9ace287645ac5f6d78e98ae93cead64f9650d:ZohoMail
X-ZohoMailClient: External

Currently, CXL subsystem implementation has some functions that may
access CXL memdev's endpoint before the endpoint initialization
completed or without checking the CXL memdev endpoint validity. 
This patchset fixes three scenarios as above description.

1. cxl_dpa_to_region() is possible to access an invalid CXL memdev
   endpoint.
   there are two scenarios that can trigger this issue:
   a. memdev poison injection/clearing debugfs interfaces:
      devm_cxl_add_endpoint() is used to register CXL memdev endpoint
      and update cxlmd->endpoint from -ENXIO to the endpoint structure.
      memdev poison injection/clearing debugfs interfaces are registered
      before devm_cxl_add_endpoint() is invoked in cxl_mem_probe().
      There is a small window where user can use the debugfs interfaces
      to access an invalid endpoint.
   b. cxl_event_config() in the end of cxl_pci_probe():
      cxl_event_config() invokes cxl_mem_get_event_record() to get
      remain event logs from CXL device during cxl_pci_probe(). If CXL
      memdev probing failed before that, it is also possible to access
      an invalid endpoint.
   To fix these two cases, cxl_dpa_to_region() requires callers holding
   CXL memdev lock to access it and check if CXL memdev driver bingding
   status. Holding CXL memdev lock ensures that CXL memdev probing has
   completed, and if CXL memdev driver is bound, it will mean
   cxlmd->endpoint is valid. (PATCH #1-#5)

2. cxl_reset_done() callback in cxl_pci module.
   cxl_reset_done() callback also accesses cxlmd->endpoint without any
   checking. If CXL memdev probing fails, then cxl_reset_done() is
   called by PCI subsystem, it will access an invalid endpoint. The
   solution is adding a CXL memdev driver binding status inside
   cxl_reset_done(). (PATCH #6)

Besides, the patchset also includes a fix for cxlmd->endpoint reset,
cxlmd->endpoint is set to -ENXIO by default during cxlmd allocation. It
will be updated when endpoint is allocated and added to the bus.
However, the CXL driver does not reset it to -ENXIO when the endpoint is
released. (PATCH #7)

---
Li Ming (7):
      driver core: Add conditional guard support for device_lock()
      cxl/memdev: Hold memdev lock during memdev poison injection/clear
      cxl/region: Hold memdev lock during region poison injection/clear
      cxl/pci: Hold memdev lock in cxl_event_trace_record()
      cxl/region: Ensure endpoint is valid in cxl_dpa_to_region()
      cxl/pci: Check memdev driver binding status in cxl_reset_done()
      cxl/port: Reset cxlmd->endpoint to -ENXIO by default

 drivers/cxl/core/core.h   |   4 +-
 drivers/cxl/core/mbox.c   |   5 ++-
 drivers/cxl/core/memdev.c |  10 +++++
 drivers/cxl/core/port.c   |  14 ++++--
 drivers/cxl/core/region.c | 112 ++++++++++++++++++++++++++++++++++------------
 drivers/cxl/cxlmem.h      |   2 +-
 drivers/cxl/pci.c         |   3 ++
 include/linux/device.h    |   1 +
 8 files changed, 114 insertions(+), 37 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260308-fix_access_endpoint_without_drv_check-f2e6ff4bdc48

Best regards,
-- 
Li Ming <ming.li@zohomail.com>

