Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A253AE185
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168150; cv=none; b=YPWh2M1esb61QY5CPxAIp4D9TBrjnn1oTRVddu178ykskE0Gwd0qxuUU2lE5ZSzUtjjfNfx+Jy1RU/Yrtt+BknZV0YBF0AgA9yng7cMS/nOYxVqO/1yp5cwwMlaw1HWKk/9BgSKT3Oof+TVjM62XPmC3ojwNjzqfa3MUqjszZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168150; c=relaxed/simple;
	bh=3tVT3ODbWpgiuR+RhG9oqsvHrDrIkZGHzZcmLVnOkoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pb+xmBgcaAV3ZU5lREwkAKeZbFbBZRn98cZ2Loq+zToPenLjEbTj/+DjU123HgInp08J9eSZMbdg9BTZ+B55rFmd8yw/P1/+TNlszQRpwEUDUdTW3YvpwvKVsuRqb/ibnqAUMSqDu3Y/NoW+s8tPQ8TRNA9S1EKvKwwIdyy+lJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LQxNrgnr; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LQxNrgnr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788168145; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pnDvNK3Z/xZ1JEAfWzwtvLE1+ohya5LgktXedoLy3hE=;
	b=LQxNrgnrfqtesC/2gGr5POeXXw4sfj+33P3NHYLcZkpbLShEZrJhKY36okJaI4ZxA2zszzF5T5GZJb2WP1ndNMokyMIgVsm7pjaETW5VKGH5t4yXzn/DHFVDLNnFwNMFRMvoE2H9MzsQS027GtMZzaDwt4o6acvHyt3IrcgH9j4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X9wFB96_1788168143;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9wFB96_1788168143 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 17:22:24 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/2] cxl: Fix uninitialized access coordinates
Date: Mon, 31 Aug 2026 17:22:14 +0800
Message-ID: <20260831092216.540644-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes for uninitialized access_coordinate reads found by inspecting
the CXL bandwidth calculation paths.

Patch 1 zeroes the coordinate arrays that cxl_endpoint_gather_bandwidth()
and cxl_switch_gather_bandwidth() declare on the stack. Patch 2 zeroes
the output array of cxl_endpoint_get_perf_coordinates() when it returns
early for a Restricted CXL Device.

Testing:

Patch 1 was tested on a QEMU CXL topology with a switch and two volatile
endpoints sharing the switch upstream link. The kernel needs HMAT
generic-port coordinates for the host bridge to run the calculation at
all: without them the host bridge dport coordinates stay empty,
cxl_endpoint_get_perf_coordinates() returns -EINVAL, the endpoint DPA
perf is never populated, and cxled_get_dpa_perf() fails before either
gather function touches its arrays.

  -machine q35,accel=kvm,cxl=on,hmat=on
  -object acpi-generic-port,id=gp0,pci-bus=cxl.0,node=1
  -numa hmat-lb,initiator=0,target=1,hierarchy=memory,\
data-type=access-latency,latency=100
  -numa hmat-lb,initiator=0,target=1,hierarchy=memory,\
data-type=access-bandwidth,bandwidth=1G

  cxl create-region -d decoder0.1 -m mem0 mem1 -t ram -s 2G -w 2 -g 256

With a temporary printk added after cxl_pci_get_bandwidth() and after
cxl_coordinates_combine(), an unpatched kernel
(CONFIG_INIT_STACK_ALL_PATTERN) printed:

  REPRO ep_gather 0000:35:00.0: after cxl_pci_get_bandwidth
      pci_coord[LOCAL] rd_lat=0xfefefefe wr_lat=0xfefefefe
  REPRO ep_gather 0000:35:00.0: after combine
      ep_coord[LOCAL] rd_lat=0xfefeff94 wr_lat=0xfefefff8
  REPRO sw_gather 0000:36:00.0: after cxl_pci_get_bandwidth
      coords[LOCAL] rd_lat=0xfefefefe

The latency members read back as the pattern-init stack filler, and the
combine step sums that residue into ep_coord. With the patch the same
probes read 0x00000000 before the combine and the CDAT latency values
(0x96 / 0xfa, the 150/250 ns QEMU puts in DSLBIS) after it.

Not covered: the bandwidth members keeping residue into the region sysfs
attributes requires an endpoint whose CDAT reports zero bandwidth for an
access class. QEMU synthesizes non-zero DSLBIS values by default, and
supplying a custom CDAT with a zero entry was not done.

Patch 2 is not tested: reaching the path requires an RCD, which needs a
CEDT CHBS of the CXL 1.1 version, and QEMU only emits CXL 2.0 CHBS
entries and has no RCD device model.

v3 -> v4:
- rework the changelogs to state the failing condition, the consequence
  and the fix rather than narrate the walk through CDAT parsing,
  __cxl_coordinates_combine(), QoS class selection, cxl_dpa_perf and
  sysfs (Alison Schofield)
- say how each issue was found and how each patch was tested
  (Alison Schofield)
- drop the -EEXIST claim and the rest of the v2 framing that assumed
  cxl_pmem could be unloaded or unbound

v3:
https://lore.kernel.org/linux-cxl/\
20260812083035.372308-1-kanie@linux.alibaba.com/

Guixin Liu (2):
  cxl/cdat: Fix uninitialized stack use in bandwidth gathering
  cxl/port: Fix uninitialized coordinates reported for RCDs

 drivers/cxl/core/cdat.c | 8 ++++----
 drivers/cxl/core/port.c | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)


base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.7
