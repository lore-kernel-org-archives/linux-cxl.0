Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F374D2EE0
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071245; cv=none; b=RKepl7HaMiXgAdLSi0PkLYvA1tzD7yzYs43XPY/Ts7u+D3vKoC6t57zZk/2kgfgGrZ28NgmPwO4hKatTAyhJt3eabY6ojaqwd6Glx4E768ZMqP63n+z+UAJD0GQ2kfyvGY1CkCOewXWpf4FMG2CXiZk/VbfiHzdfyUD53vescgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071245; c=relaxed/simple;
	bh=hLeOaGRKwShyWnP3nrQLerTbei87kG0uq39h/M5hSkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GUowGHX3Hpg8WWJ/IURcXEhIpvEXC4Skb4h2OPcD8tkPuz8/Bz4Bfo4yvBwHI+fgqyUcJq+tst5f/fxeptEe7oK4b8eWB8qygBFNq8VAJtDcDBh3EFs8O1UGLvVoxDE0ZKR8E8xb1e1XnCd5kFmjHJNbhnOFaF69cluFErB7Zh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eBOt1xWv; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eBOt1xWv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790071239; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=JsIiRZNkpyBe+/dH8L1IcL2VzLkCQXHvkxHWejvDxZQ=;
	b=eBOt1xWvcgMsNECqtTiw9QU2/f3LFcP7M/cfVUVJ9bJ1T+UpoTyiYMw42yYrJ9YLqABtcClKYRtlxij56/T4Qx83dzAraAGeVJMvfcElqD0QwYBy6udmfC8RE0IcncUMvEm6C6jJBcx5xvAux1PeIPe2RzBRoWFYhlhwc4EvOjs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBTWPKy_1790071238;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBTWPKy_1790071238 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 18:00:39 +0800
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
Subject: [PATCH 0/3] cxl/pci: Fix the GPF DVSEC setup path
Date: Tue, 22 Sep 2026 18:00:10 +0800
Message-ID: <20260922100026.3742401-1-kanie@linux.alibaba.com>
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

Guixin Liu (3):
  cxl/pci: Use the Device GPF DVSEC for restricted endpoints
  cxl/pci: Program the Port GPF timeouts before caching the DVSEC
  cxl/pci: Update only the Port GPF timeout fields

 drivers/cxl/core/pci.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

-- 
2.43.7

