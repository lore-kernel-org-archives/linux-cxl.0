Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215F41DA62E;
	Sat, 14 Mar 2026 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773472035; cv=pass; b=fa7Bu78aS3C82FAJEMCeJJWSuJxd3O80b5EEGQBVDL5ikvBKUBNv/j2PYW39TlDBP+0qduE6e4U6UFfnGdBYis5EyzV6BnDtFC4tngsnVgGdZ3IQQ7S1rt+4fG5nMzhRbsI8sGJRnbaf4zG5Nt48BGaiGw9VlfhBoKir/MsbcfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773472035; c=relaxed/simple;
	bh=LM5WcCieTLhH0TEIswIpN57JOk/kFxHOBIgkTJocK44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gBCBfxVsyd/sHFBWtimYJxKU47qF1a5fFz1ocSgyW0+fgvuqebAHzNMINDrZ9o2xPBiiHmKjXzTT4gNYN+4HkYKMNixH/6zHWLyfzIstn8UebMCwn3fFnEXBhaQdhk0azZKQjy19vWTJmr8Mlmi8RE38b1E5dPtji5QdPnbAXQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Q/pFbjnd; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Q/pFbjnd"
ARC-Seal: i=1; a=rsa-sha256; t=1773472009; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=daV4Vi4B3VH58vwBcb/VsX7H1l7fDmSIM+HqP4eic9Uy2XOQ8eLpSbvGaHR7Mrz34wi97sHVGKwZ/Qhj5tl0QCl6R1+XZn5GHNfTDlQGSiyBF34NuAYMmWir6GihDLi9ls/KJ8zUh08+/uT/iTn4WY73twtPdtGfkxpwXwBkDDY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773472009; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c/OHp0Ngv8xXbhR0JS1kJtkXp9wsANYlUk+ZHfRCG8I=; 
	b=b1XHZN01jxCBXZku7Tt4SeIbJPJWmhD6RS8ROtIwMNpo9qOZHSbnDT992vIJrK5tlje9qqDyhoMgKkeorIcLwPubwrdifEVLw1Ul+Z/M08RzTmy8FNYkATsS8BJF/FsjYFPfo/Uxbit2yxm0sIFpDuQuLbtH+ZwoAJGmi+ouPi8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773472009;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=c/OHp0Ngv8xXbhR0JS1kJtkXp9wsANYlUk+ZHfRCG8I=;
	b=Q/pFbjndDUadoCrxuSsjR5tAvhuuxyExc6aNECN9YQRE6bMRqdidBFKkimLA4/lU
	3pBK2WuxGsjmDG5dYb5lKVwD/YuoXnl8VsVSItDANf2skakFO0gvYWrNen7AJ1uJiVe
	lL7V0LU4Znao+sqlgKqvCwev/b45autFM+xP4PFg=
Received: by mx.zohomail.com with SMTPS id 1773472006621580.5118989729009;
	Sat, 14 Mar 2026 00:06:46 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Subject: [PATCH v2 0/4] cxl: Consolidate cxlmd->endpoint accessing
Date: Sat, 14 Mar 2026 15:06:29 +0800
Message-Id: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPUItWkC/43NTQ7CIBCG4asY1mIAm9q68h6mIS0MMtFCA4g/T
 e8uNh7A5TvJfM9MIgSESI6bmQTIGNG7EmK7Icr27gIUdWkimKjZnjXU4FP2SkGMEpyePLokH5i
 svyepQ5bKgrpSI6A2phq0qhpStqYA5XF1zl1pizH58FrZzL/Xn8DZn0LmlNG2MtDytmdDczi9v
 fVjj7ed8iPplmX5AKtpEUPdAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773472001; l=3284;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=LM5WcCieTLhH0TEIswIpN57JOk/kFxHOBIgkTJocK44=;
 b=nBqFwYNfOOIbrOg+pvTcQ3ir4ba7H9ceT9jfxim2fBrOjIkyVJE0aWifEtMMmz2N+wyVQwBD0
 eCkv7sttwTGBvGGndRuQizz4/4dcptqRcVuvKtxWAe2Sxey4gCf/c/w
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228864c7777d08f20962a8ca66d0000d2e3d15adc06350083c92d7dceac35addd2b09fc71e151380e53:zu080112277dd481d1e904073e53b8aef9000084363ce744017b1d2f5e52c9252aa5eae328f47d7b4766aad4:rf0801122d08eb1621847f1d823b063d160000cc65f86971a7a323bf33a9c1a6f91367425cf0beb76b787803481a3aa35ed4:ZohoMail
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
   cxlmd->endpoint is valid. (PATCH #1-#3)

2. cxl_reset_done() callback in cxl_pci module.
   cxl_reset_done() callback also accesses cxlmd->endpoint without any
   checking. If CXL memdev probing fails, then cxl_reset_done() is
   called by PCI subsystem, it will access an invalid endpoint. The
   solution is adding a CXL memdev driver binding status inside
   cxl_reset_done(). (PATCH #4)

---
Changes in v2:
- Move hoding CXL memdev lock to cxl_debugfs_poison_inject/clear(). (Alison)
- Drop device_lock_assert() in cxl_inject/clear_poison_locked(). (Alison)
- Remove device_lock_assert() in cxl_dpa_to_region() to remove patch
  "cxl/region: Hold memdev lock during region poison injection/clear". (Alison)
- Squash patch "cxl/pci: Hold memdev lock in cxl_event_trace_record()"
  and patch "cxl/region: Ensure endpoint is valid in cxl_dpa_to_region()". (Dan & Dave)
- Remove patch "cxl/port: Reset cxlmd->endpoint to -ENXIO by default".
- Link to v1: https://lore.kernel.org/r/20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com

---
Li Ming (4):
      driver core: Add conditional guard support for device_lock()
      cxl/memdev: Hold memdev lock during memdev poison injection/clear
      cxl/pci: Hold memdev lock in cxl_event_trace_record()
      cxl/pci: Check memdev driver binding status in cxl_reset_done()

 drivers/cxl/core/mbox.c   |  5 +++--
 drivers/cxl/core/region.c |  8 +++++---
 drivers/cxl/cxlmem.h      |  2 +-
 drivers/cxl/mem.c         | 10 ++++++++++
 drivers/cxl/pci.c         |  3 +++
 include/linux/device.h    |  1 +
 6 files changed, 23 insertions(+), 6 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260308-fix_access_endpoint_without_drv_check-f2e6ff4bdc48

Best regards,
-- 
Li Ming <ming.li@zohomail.com>

