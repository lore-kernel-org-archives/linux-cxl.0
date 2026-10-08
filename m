Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE76018E025
	for <linux-cxl@vger.kernel.org>; Thu,  8 Oct 2026 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431201; cv=none; b=GETAwgqV3hTObUoyDGJMGDjXkwDq3z+rfAEwrGBMyi/3qUzVGKQoUwqRzRV07WIgrFuMEBJgQ4cCFsBIbpDcuDaRQ/bN6qRjfUMMsvb+B4OLCfZOJ5x1LUag04VLJ9ICX3qAWGPH7ysdqh7GfSJxCOP+gcicXiRy9rIkbSpiFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431201; c=relaxed/simple;
	bh=HkkjaDMiv+JZSfgr2xsH2w10a4Uuo3Hpdb2AKe0Xvu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WCGonV6YTOOBR5HamElX2W+gvu/qMN5DyvLxwUmr2w9fXqEldcTR+iZz7IkBjPdg+sShOYWhdyNk/O1zUf5+o2j1XxQs6Va/g1O3+9ox0v60rXzrAzx+eBv3dYdIFcVTZ6p9lMIybZqSAKHomZJ1FAFk+MP3hk4WloEOWtiFJ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hTmGGAty; arc=none smtp.client-ip=47.90.199.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hTmGGAty"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791431188; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=41y/AJDaWY7zqDMdYCn0mU95Fzq4dd5iKKP8uoGxva4=;
	b=hTmGGAtyj619jDQL1BTeMyCzYSq9O+J+yDnNZ/sfVCKqJ/n1UQrgHWVOAVT2xp+IuZm1BOU+y9BmyqAvSlpQRXAphwbVL1wmMPsS3KQ3awNaigSkF0jiKcCUIaMOnIw/QH3l0gfYWpeqI86xpfcc2IfcT0RSbUoTvOLbXcLs/aU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCJd7mC_1791431187;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCJd7mC_1791431187 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 11:46:27 +0800
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
Subject: [PATCH v2 0/3] cxl/pci: Fix the GPF DVSEC setup path
Date: Thu,  8 Oct 2026 11:46:11 +0800
Message-ID: <20261008034619.28059-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Three small fixes for the GPF setup path in cxl/core/pci.c, found
while reworking the same area for a downstream backport.

Patch 1 is the one with user-visible impact: on an RCD the GPF DVSEC
lookup takes the port path, so dirty shutdown tracking never arms and
the count stays invalid. The other two deal with error handling and
a full-register rewrite of the phase control register.

Testing on a QEMU CXL topology, with the patched cxl_core hot-swapped
in and the topology re-enumerated. With the phase 1/2 timeout
registers of all four dports (two root ports, two switch downstream
ports) zeroed beforehand, every dport came back at 0x0702 — base 2,
scale 7, the same value the unpatched code writes. So the timeout
write ran on each of them: the read-modify-write of patch 3, through
the error-checked setup of patch 2. With the registers left at their
programmed value instead, the setup takes the "already at max" early
return and writes nothing. Re-enumeration comes up clean, all three
memdevs back.

What QEMU cannot exercise: the topology has no RCD, so the RC_END
branch of patch 1 never ran — though the emulated type-3 devices do
expose the Device GPF DVSEC that the fix selects for a restricted
endpoint. A config write to a live DVSEC does not fail, so the error
paths of patch 2 stayed cold. And the phase control register defines
no non-timeout bits today, so patch 3 lands on the same value the old
full rewrite did.

Changes since v1 [1]:

- Collect the Reviewed-by tags from Jonathan Cameron and Dave Jiang
  for patches 1 and 2 (code unchanged).

- Rework patch 3 to use a pair of FIELD_MODIFY() calls instead of
  clearing and setting the timeout masks by hand, as suggested by
  Jonathan Cameron. The generated code for update_gpf_port_dvsec()
  is identical to the manual version.

[1] https://lore.kernel.org/all/20260922100026.3742401-1-kanie@linux.alibaba.com/

Guixin Liu (3):
  cxl/pci: Use the Device GPF DVSEC for restricted endpoints
  cxl/pci: Program the Port GPF timeouts before caching the DVSEC
  cxl/pci: Update only the Port GPF timeout fields

 drivers/cxl/core/pci.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

-- 
2.43.7

