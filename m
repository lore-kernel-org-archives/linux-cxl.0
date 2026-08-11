Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4653B71C5
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448179; cv=none; b=WoHdCbJcsEXZEOSCw8+qEhP7Cub/lj0pyFOsicSIaJ2Qsn8v+8xV8P2wXJJ6GGkrpRV63gMdyDbFEWzvJyRSN1vV1oKDTaJY5DHllveu7d5j0ON3TsohOfpiBPVPklhMknM7JjWgDcGLCq2a+go9cPT3qAoI6ViSAOas6ydLPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448179; c=relaxed/simple;
	bh=pqPry6ge5d2E1qqfWwwsQMWy6vuPhEhCN39JVBdHUhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QTAM4u1vtJeUMiSGGkJv14EN+jny76HScZV+bgY7bUdTdEVEOpeoDm0SRgMtAhPG6paHEHFHwgkrfMIwIes0veUOwBrR3JU5mV3PSnfU5zlNr+gCPS73zvWYInaaMduEzQoROonhdRJXZebwd5VJPJNvnc1wGow7cmXKL8vARAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hkW2PsZ7; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hkW2PsZ7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786448175; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=waJkvAFwEXj+Ge4KO+KcqceZJgD0P+W3IEbtq0repI8=;
	b=hkW2PsZ7S+eONgsFmxPdoqLFsGiUWREo7SV8SQ4xSdRHhZdrDSXsgZYYDV0i9aJ2wJCNJc0VLSKjaZ/W71rKtwWoT7q9B6pr94mw8iVK0GO392/Yh8OIL7sOWkuWQzQFEJLjhSKJQ2lBS/CDlZ2IhzKGdLKyjOT5oo0QmzfOS/E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8oNeXb_1786448174;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8oNeXb_1786448174 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 19:36:14 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH 0/8] cxl: Assorted fixes
Date: Tue, 11 Aug 2026 19:36:00 +0800
Message-ID: <20260811113608.2815625-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a batch of fixes found while auditing drivers/cxl. They are
independent of each other and can be applied individually or dropped in
any combination; they are only sent together because they came out of the
same pass over the code.

Guixin Liu (8):
  cxl/features: Validate the fwctl RPC input length
  cxl/features: Bound the Get Feature output by the user output buffer
  cxl/core: Fix dport use-after-free via the einj_inject debugfs file
  cxl/pci: Fix NULL pointer dereference in reset detection
  cxl/hdm: Fix out of bounds read of the decoder target list
  cxl/cdat: Fix uninitialized stack use in endpoint bandwidth gathering
  cxl/mce: Validate the memdev and endpoint before use
  cxl/region: Unregister the pmem region bridge on setup failure

 drivers/cxl/core/cdat.c        |  6 +++---
 drivers/cxl/core/features.c    | 15 ++++++++++++++-
 drivers/cxl/core/hdm.c         | 12 ++++++++++++
 drivers/cxl/core/mce.c         |  8 ++++++--
 drivers/cxl/core/pci.c         |  8 ++++++++
 drivers/cxl/core/port.c        | 18 ++++++++++++++----
 drivers/cxl/core/region_pmem.c |  6 ++++--
 7 files changed, 61 insertions(+), 12 deletions(-)


base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
-- 
2.43.7

