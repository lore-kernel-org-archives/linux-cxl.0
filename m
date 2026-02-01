Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8542A96;
	Sun,  1 Feb 2026 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769938268; cv=pass; b=WJG5Xer0wsUz8MhafegcygtJC69hBazf3R74/tcPqTrvnI+gJ1qfXEDXL8MyvxmIEfeaBno9oiXYIvS7W/gAYGuS2PIgyd4BlSg+QJl+IaLSHd4rUS2pwUl6yBnzlRjjNXu1mYC/iSS1HQHKrrTGHxRvNKgx1LVsfVLaDeJu9k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769938268; c=relaxed/simple;
	bh=NhLr32hX3L2uUlQ5n9aRosqttmkbYsTbkzI3lAr4D0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQ7hB6DlgKViL4xvfD7Ce4R+2QkkZJfWpgllOc0OI2NpBjtGm7iFVth89J1XpZqGjePX6160l2eWzrkcWe5pJsqBXs5LaVraS43rWppVFuKzPONMt3cYWb3V/aknsWaZSTCvNniWx0YBVus2vr5i0lxX6wlfTh2kyG8w5czMhQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=C5gkD3Ka; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="C5gkD3Ka"
ARC-Seal: i=1; a=rsa-sha256; t=1769938253; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kGRF75a1swnqtkm/Z6J9cCJJa4OKO63pHD+dcrQrZ2jvjaZm6ssc6RxO5xUZx9mqXNpv19TLT8eLg+whH6NVD9aa187fgVE38ntG/6DnREu8c+vUa4Imw9T9vmq26c9yiE40GNXJ8jORcYKncfwj9nlZTN10w1blXFc1vnGW7WM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769938253; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mjfAjFMMBXz2zHNwg2Tsi66wHudi7CzmRy1Y/zVKZM0=; 
	b=RgvTSX5NGY/0WDSY5BJzhn/mOF17NL47gOaZAtSZ9Zpvx6nVsprg8bkaKslRiPmWwpTAlUjY8CFF5WIAd/TcreY4EgjsxRUschifairBu2BWh7GiGKU84KICzWUp7LBzutCXStkR7AayP9HAs8jWfNGXTPWFHiRymwGNTcf/2l4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769938253;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=mjfAjFMMBXz2zHNwg2Tsi66wHudi7CzmRy1Y/zVKZM0=;
	b=C5gkD3KaU/IOHDmdxfJQ790eGEXzds0IP6Q2BFK6HMcUSS0Z0pjA3zyppFayEXHL
	GNftMbkxlgPOMnkTszSulRCu12d6lGOxewdPH3XBbVI9e48BgOuPIi8agr/n7+T+Un7
	TKjpFGbUFpQ8A2+KzMw29nkH38F4FLRKDzrW+ZQ4=
Received: by mx.zohomail.com with SMTPS id 1769938250832826.2215305264092;
	Sun, 1 Feb 2026 01:30:50 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 0/2] Fix port enumeration failure and NULL endpoint issue
Date: Sun,  1 Feb 2026 17:30:00 +0800
Message-ID: <20260201093002.1281858-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122c586d6077cda4e12d99624fc10000e4fc3bfd6807928eed555efe68d6bd0e10996ecbca1553c1bd6bf2e845f4:zu0801122797e650e13af913b4e6d1cd76000096f133e681833e1b8d15d0375e07262769bf3513400c269931:rf080112324775ed7f2f665361f8f5b23e0000d8137605a4dbb61994c03c1fc5f5d96fe4b80ab1b44941eb4ab472baebd78f11b0afb508:ZohoMail

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

After detailed debugging, I identified two independent issues that
together leads to the problem.

Issue 1:
cxlmd->endpoint is initialized to ERR_PTR(-ENXIO) during cxlmd creation,
but cxl subsystem usually checks endpoint availability by checking
whether it is NULL. As a result, if endpoint port creation fails, some
code paths may incorrectly treat the endpoint as available. In the
call trace above, endpoint port creation fails but cxl_dpa_to_region()
still considers that is available.
Patch #1 is used to fix it, the solution is initializing cxlmd->endpoint
to NULL by default.

Issue 2:
The second issue is why CXL port enumeration could be failure. What I
observed is when two memdev were trying to enumerate a same port, the
first memdev was responsible for port creation and attaching. However,
there is a small window between the point where the new port becomes
visible(after being added to the device list of cxl bus) and when it is
bound to the port driver. During this window, the second memdev may
discover the port and acquire its lock while attempting to add its
dport, which blocks bus_probe_device() inside device_add(). As a result,
the second memdev observes the port as unbound and fails to add its
dport.
Patch #2 fixes this race by holding the grandparent port lock during
dport addition, preventing premature access before driver binding
completed.

base-commit: 63050be0bfe0b280cce5d701b31940fd84858609 cxl/next

Li Ming (2):
  cxl/core: Set cxlmd->endpoint to NULL by default
  cxl/core: Hold grandparent port lock for dport adding.

 drivers/cxl/core/memdev.c | 2 +-
 drivers/cxl/core/port.c   | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0

