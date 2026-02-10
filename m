Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2476F319877;
	Tue, 10 Feb 2026 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724190; cv=pass; b=S/A4XYKLVb0U7Z3a23g6JVFOLAOlKxOhUt/AiiJCYmzJ/LgLyGyq/MjZvJ4S6NEc1BufUT+Klhytys0z4nI4tbcJ97vIpmWWiEUSy5dvRhPoZWo4RaZTxcroJFvd6OQIETZplepHbXI1NEnpE0RjYvMxe43gn3i+WQajrNMrUMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724190; c=relaxed/simple;
	bh=9O0/2mnt4ZhkE/Pn5IDCq+BUmYZ2Byj54KzfJhD+cI0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kUL6oA6gbzl/1Smjj0kx5MGV+gca/OVaVViWeswtswFsp4DxoFkX3CTyP91Kh/9yimhy+DDVcIaxTeCl6xLOcat81H7q/cKB3eQAfkLQPVHEOQPMkeoakjjdrSeklDY5hTVq4sUP9hJSwftemRQKHAWDWVnLyctXyt4DAGGQ8y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=VKk7bpU9; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="VKk7bpU9"
ARC-Seal: i=1; a=rsa-sha256; t=1770724057; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gqsDPrUaxYaZuKQtl5/YBhO/n6vuYahjSkwGAx2B81CTYqfP848ISD/JJl7KdOx5cXwSXmJzEY/mAddu/qHrGOi5tTvHwbuxVLExfycqo53vgQN6k51spUyxSjTe86OGa8US3Z+ZxlwY2EjWwf5Z590hGZC7l/8YhFY/2xb2q38=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770724057; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xsJdtqoRKNtEbUmN8+2agMyi9/LjCdXogqmUI5bifkw=; 
	b=XSDRUqG59yWWdMLF4aXn8jN5pZM4ZL/FL+ckxbQ5E0ALecAauBOm9gJF6towDtBhThpWFSsZbe8bHfHiLtKcRqWixAZIPynhUfdBaS/TU4n9COtoyFfJOi4J8clCjBJHL0jW6ls2PUa1leJ/KtOjyjBtCOTjWwqXaLh7eOIq3lI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770724057;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=xsJdtqoRKNtEbUmN8+2agMyi9/LjCdXogqmUI5bifkw=;
	b=VKk7bpU9MEDvPZvgWJahmHQ0OF6V4exhZSxTekG5wTnY89ZU4ESE/vr4p+P3gjHQ
	7rCtlWabzxfI7aaUF2eFw0/UukRiQ8NlWA6sobHX9PpsnyzZe5YcbWRChmvyabAtJ7p
	/jgKIfHQBkEWn4ClsAFD8kBGugHqeB+7lj61jbAs=
Received: by mx.zohomail.com with SMTPS id 1770724053950919.8961843037861;
	Tue, 10 Feb 2026 03:47:33 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
Subject: [PATCH v3 0/3] Fix port enumeration failure
Date: Tue, 10 Feb 2026 19:46:55 +0800
Message-Id: <20260210-fix-port-enumeration-failure-v3-0-06acce0b9ead@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK8ai2kC/x2MwQqDMBAFf0X27EJMtLT+ingI9cUutFE2Wgriv
 3fxODAzBxWooFBfHaT4SpElG4S6oucr5hkskzF552/Ouzsn+fG66MbI+wcaNws4RXnvCg4tmtQ
 +upCcJ1usCvOv/TCe5x8wsUWLbgAAAA==
X-Change-ID: 20260208-fix-port-enumeration-failure-34e1f4953f02
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770724039; l=3181;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=9O0/2mnt4ZhkE/Pn5IDCq+BUmYZ2Byj54KzfJhD+cI0=;
 b=iewXwxbfYWO6VCsBWO9OGyOEeD9hPit/UoGHXG5/CIk7IN8JPp3EdCImhjAqMewSBlu6nrCd5
 +hZu48ewDP9DHmjUVWmyzbEdPXOzrKFDu6q7+rQrIYrwkmbwFS1Zv9b
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228febb1e2152e974578cab44f60000e8a1b620504acc8e8b62abc95eeaa3efb8b37d73a24f606e7f0a:zu080112275d7fbe1b238fb7249e3af8780000b70377c2cda7a67ee21d6ecf44830fe97c0e18f6cc99197670:rf0801122dab6cd0995a0f01a597658ed700004fad3d936d5da666e484fcae61e20e4b086f207492ef7e3efc7362bd96108a:ZohoMail
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

Changes from V2:
- Split to_port_host() implementation to a lead-in patch. (Dan)
- Use to_port_host() instead of open coded. (Dan)
- Rename to_port_host() to port_to_host() to align with dport_to_host().

Changes from V1:
- Remove the patch of initializing memdev->endpoint to NULL. (Dan)
- Fixes typo errors. (Jonathan)
- Introduce a helper called to_port_host().
- unregister_port() cleanup.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
Li Ming (3):
      cxl/port: Introduce port_to_host() helper
      cxl/port: Hold port host lock during dport adding.
      cxl/port: Use port_to_host() to get port host

 drivers/cxl/core/core.h | 18 +++++++++++++++++
 drivers/cxl/core/port.c | 52 +++++++++++++++++--------------------------------
 2 files changed, 36 insertions(+), 34 deletions(-)
---
base-commit: 63fbf275fa9f18f7020fb8acf54fa107e51d0f23
change-id: 20260208-fix-port-enumeration-failure-34e1f4953f02

Best regards,
-- 
Li Ming <ming.li@zohomail.com>

