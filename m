Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258C3E7621
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523447; cv=none; b=Ch+9ghwJmcSous4Nz1xn9iaAj35N4jJhB2IKnfmoO2iuXRreNBmX97nHmDqDYM3lAtMWNC4TUVI8lt56Vg5AOx82qn+cw6UTW4hyQF29CfLep5X4oZ2NOZnicsHwMfmXHl1c8pyLOrW5qzkod0w5xNpaMk/yjv0f4Ecn9eWRBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523447; c=relaxed/simple;
	bh=bvj+SGUrfLhWvDqozQ9kg+LRbjGm1VmpEUaMjdRBLok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNRoOdgH+2tnY//wdn51aLTGBpeLCZ8uTHaAMyZTtaXQVDN0Poxn6wNxkl5tLxSPt7LL5j67YpPmzZfmyE9u+sNGo7oyxK4EwvWrt3WzfCh19sJXIEQNSbS8XKxqu+SeDUwtDteYLAFGYgXsuuMbdi1FrO9OQh5UtGTzmSci364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n59jqa+G; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n59jqa+G"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786523440; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VCZIpexgliT7UPZ9woTgpUDzXnlP/E6BJKL41D30MUg=;
	b=n59jqa+Gfl1YYv8UEFwH+3j2PjjXYa6NGhUL/ELkreLhM09/xUWXhpzc5HwClHrltxUSF8eQ40eT7r+KIPc4jC5zooBEkT8i5frYHZ036lcIMFmEUfM2ifJ5vkxIgF97Pq1rEull3IbO/bHDVCuqo5bUv/krhLZScYlaEE+ITOo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8r409q_1786523439;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8r409q_1786523439 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 16:30:39 +0800
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
Subject: [PATCH v3 0/2] cxl: Fix uninitialized access coordinates
Date: Wed, 12 Aug 2026 16:30:33 +0800
Message-ID: <20260812083035.372308-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two related fixes for stack access_coordinate arrays that are read before
anything writes them, both reachable on real topologies and both ending up
in userspace through the access coordinate sysfs attributes.

Patch 1 is the v2 cdat fix [1] with one more site covered: the coords array
in cxl_switch_gather_bandwidth() has the same defect as the three arrays in
cxl_endpoint_gather_bandwidth().

Patch 2 is new. cxl_endpoint_get_perf_coordinates() returns 0 for an RCD
without writing the caller's array at all, so cxl_port_perf_data_calculate()
combines stack residue with the values parsed from the RCD's CDAT.

Both were pointed out by the Sashiko review bot on the v2 posting of patch 1.
The third finding in that review - cxl_coordinates_combine() aliasing its
output onto an input and leaving a member alone when an input bandwidth is
zero - is the intended "not reported" behaviour and is not addressed here.

[1] https://lore.kernel.org/linux-cxl/20260812060912.54932-1-kanie@linux.alibaba.com/

v2->v3:
- also zero initialize coords in cxl_switch_gather_bandwidth(), same defect
  in the sibling gather path (Sashiko bot)
- new patch 2: clear the output coordinates on the RCD path of
  cxl_endpoint_get_perf_coordinates(), which currently returns success
  without writing them (Sashiko bot)
- drop "endpoint" from the patch 1 subject, it now covers both gather paths

v1->v2:
- rebase onto cxl/next
- rewrite the commit message to describe the behaviour rather than narrate
  the code change (Alison Schofield)

Guixin Liu (2):
  cxl/cdat: Fix uninitialized stack use in bandwidth gathering
  cxl/port: Fix uninitialized coordinates reported for RCDs

 drivers/cxl/core/cdat.c | 8 ++++----
 drivers/cxl/core/port.c | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)


base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.7

