Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26215256C84;
	Sat,  7 Feb 2026 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770471342; cv=pass; b=MxG2nkhQuqD88TWHJzbx733L7I9fNRPtfhRLOqEIiUMchN1uuYyTP3pEuSGM6LAtJgBHVPEDUyYh45U/qj2YHppGAeF98zDtRzxN8HQwufpr16rTJTj4MMTX1eMfKOfJD4fbQQ44E02FxLs/tJw+XE6hVQHaVLdPD1hBBd22vNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770471342; c=relaxed/simple;
	bh=t0c5Ci/ys0Ag+Xaoiwif2Ub32QXoyCpnsQEmn5ymMeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpIPEZkCma0VsOghly9BJ0254kAejF6jy4vXdQ5ia/IY0F1maAce/b8wFkXnz99vlis3Bu7Xsx3DF+/zbMHptu39DCy7v1wc6ZbF/gxYp0GwpPLRjMYBzRd6KJPBA5oFfr2OGP3DtBncfax68zA1AOWi6Pw8GQM9IvGx7xHeKqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=HRU2TLdJ; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="HRU2TLdJ"
ARC-Seal: i=1; a=rsa-sha256; t=1770471323; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kJGn4pnr9WijK7afeTzigaim2MR9JBsQ8fGMH4YP1v3G9gMPPpDn0JJ6vgg4riXKXkPHDNHapdc1r72fBGqJbNB2lvxpvUolugcs+ItOfGN0f1En/3YPqQzRYQXy5fKEphmLqN3SPvk3R16J7HKMakRfcJ4NLD9oqWvWgf+bhcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770471323; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mXvUl3f3Z/VgCCkTh7nfnSI+91lFQA5kSQ4q44w86dw=; 
	b=ENR6tBJHjX8uGmgeVVgkZfJpS+3PcBl5KnleiZZ4Rlp1fVAd24VQ0LuJRVmpbeBS7Fkw/UjJXy11qTWr9mD8KHgphvTSPVfvtaIPYcjCwA1qqIdtd6/+OqVA53HvqB9PlD2/EAnh43XHDmXoVvOLyUWuekOO7/0z4a65AMmSCJI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770471322;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=mXvUl3f3Z/VgCCkTh7nfnSI+91lFQA5kSQ4q44w86dw=;
	b=HRU2TLdJ0WsOyQl2FP8k6pCNaRqVCBjBxLsmq0BuVhwHBs7ld8QF5dvnQ7o2XMh3
	wlkcKDswuxM6n3msMjYBa1nPno3YZdhPmVPunf/NlMLpcZjW75pTx1Zyp9CJjwbAo4N
	SKTiunHtCjpSD85l8CqQBshNffw/WIMFHDddjUfM=
Received: by mx.zohomail.com with SMTPS id 1770471319775149.56130381161086;
	Sat, 7 Feb 2026 05:35:19 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix port enumeration failure
Date: Sat,  7 Feb 2026 21:35:10 +0800
Message-ID: <20260207133512.306128-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122c2923813afb2c9ec786a684cf0000e8ce0d0bb4e3680edff6af54f303836e738b819a5dce1460e0929654bae9:zu08011227d76460f6ae5540ce384c32cb0000feff6030798eadacf07828752f85dd6afa73385d68f152e72d:rf08011232f1c8bc3cbcb698d6caf259fe0000085f0c97ff9ca2362166453c2308b80cf6240831dc3c846a8f24dd163ffb59ebda14c9af:ZohoMail
X-ZohoMailClient: External

I ran CXL mock testing with next branch, I usually hit the following
call trace.

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000092: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000490-0x0000000000000497]
 CPU: 3 UID: 0 PID: 42 Comm: kworker/u16:1 Tainted: G           O      J 6.19.0-rc5-cxl+ #4 PREEMPT(voluntary)
 Tainted: [O]=OOT_MODULE, [J]=FWCTL
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
 Workqueue: async async_run_entry_fn
 RIP: 0010:cxl_dpa_to_region+0x105/0x1f0 [cxl_core]
 Call Trace:
  <TASK>
  cxl_event_trace_record+0xd1/0xa70 [cxl_core]
  __cxl_event_trace_record+0x12f/0x1e0 [cxl_core]
  cxl_mem_get_records_log+0x261/0x500 [cxl_core]
  cxl_mem_get_event_records+0x7c/0xc0 [cxl_core]
  cxl_mock_mem_probe+0xd38/0x1c60 [cxl_mock_mem]
  platform_probe+0x9d/0x130
  really_probe+0x1c8/0x960
  driver_probe_device+0x45/0x120
  __device_attach_driver+0x15d/0x280
  bus_for_each_drv+0x100/0x180
  __device_attach_async_helper+0x199/0x250
  async_run_entry_fn+0x95/0x430
  process_one_work+0x7db/0x1940

After detailed debugging, I identified adding dport failure leads to the
problem.
What I observed is when two memdev were trying to enumerate a same port,
the first memdev was responsible for port creation and bind it to the
cxl port driver. However, there is a small window between the point
where the new port becomes visible(after being added to the device list
of cxl bus) and when it is bound to the port driver. During this window,
the second memdev may discover the port and acquire its lock while
attempting to add its dport, which blocks bus_probe_device() inside
device_add(). As a result, the second memdev observes the port as
unbound and fails to add its dport. The second memdev->endpoint would
not be updated because of that, then trigger above trace.

The solution is to fix this race by holding the host lock of the target
port during dport addition, preventing premature access before driver
binding completed.

base-commit: 63fbf275fa9f18f7020fb8acf54fa107e51d0f23 cxl/next

Changes from V1:
- Remove the patch of initializing memdev->endpoint to NULL. (Dan)
- Fixes typo errors. (Jonathan)
- Introduce a helper called to_port_host().
- unregister_port() cleanup.

Li Ming (2):
  cxl/port: Hold port host lock while dport adding.
  cxl/port: unregister_port() cleanup

 drivers/cxl/core/port.c | 47 +++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

-- 
2.43.0

