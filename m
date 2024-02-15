Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2182213248D
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009300; cv=none; b=ca9LGx1+X3Q00vp8azBvmtGE6uWDS7Ue4AUCVWqJSwTHBG9eGCgb5hNCVo2MBupS8b+NzUwD2/jRtXds2EHa8eyLTuY0EVQC8ntglVoKC9+eiEuCufGtZn3RLZ9vTtvZQ/1ql37MsGHos32osXfWCdXHBn2//0WWM+D/OF7bAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009300; c=relaxed/simple;
	bh=ZIRMLZwTlad5bPv4WkD9VO6H+xn7YzrCiZf2us+WAfQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lG6X4escNOPMwG9602MRN0xWy++UO/glu2U5kfXXjrIyYT2Ch8YgcXtDkGXjm0gHGcn9BdFU1JpzsuxCUokiFpjIkZp+mABloPbOaMsnkVjKoDniNPXncZOwSCVouMoxCZEJGr+O7pQFKdsuYvFSOxyzhZ2oYmz8uIz1BXa/9aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbJ7t5NSHz6J9fm;
	Thu, 15 Feb 2024 22:57:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E5D31416EA;
	Thu, 15 Feb 2024 23:01:33 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 15:01:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
	<alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
	<dimitrios.palyvos@zptcorp.com>, <richard.henderson@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
CC: <linux-cxl@vger.kernel.org>
Subject: [PATCH 0/3 qemu] tcg/i386: Page tables in MMIO memory fixes (CXL)
Date: Thu, 15 Feb 2024 15:01:30 +0000
Message-ID: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

CXL memory is interleaved at granularities as fine as 64 bytes.
To emulate this each read and write access undergoes address translation
similar to that used in physical hardware. This is done using
cfmws_ops for a memory region per CXL Fixed Memory Window (the PA address
range in the host that is interleaved across host bridges and beyond.
The OS programs interleaved decoders in the CXL Root Bridges, switch
upstream ports and the corresponding decoders CXL type 3 devices who
have to know the Host PA to Device PA mappings).

Unfortunately this CXL memory may be used as normal memory and anything
that can end up in RAM can be placed within it. As Linux has become
more capable of handling this memory we've started to get quite a few
bug reports for the QEMU support. However terrible the performance is
people seem to like running actual software stacks on it :(

This doesn't work for KVM - so for now CXL emulation remains TCG only.
(unless you are very careful on how it is used!)  I plan to add some
safety guards at a later date to make it slightly harder for people
to shoot themselves in the foot + a more limited set of CXL functionality
that is safe (no interleaving!)

Previously we had some issues with TCG reading instructions from CXL
memory but that is now all working. This time the issues are around
the Page Tables being in the CXL memory + DMA buffers being placed in it.

The test setup I've been using is simple 2 way interleave via 2 root
ports below a single CXL root complex.  After configuration in Linux
these are mapped to their own Numa Node and
numactl --membind=1 ls
followed by powering down the machine is sufficient to hit all the bugs
addressed in this series.

Thanks to Gregory, Peter and Alex for their help figuring this lot
out. Note that I've included one patch from Peter without a SoB
because so far it has only be posted in the discussion thread.

Whilst thread started back at:
https://lore.kernel.org/all/CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com/
The QEMU part is from.
https://lore.kernel.org/all/20240201130438.00001384@Huawei.com/

arm64 equivalent to follow.

Gregory Price (1):
  target/i386: Enable page walking from MMIO memory

Jonathan Cameron (1):
  tcg: Avoid double lock if page tables happen to be in mmio memory.

Peter Maydell (1):
  accel/tcg: Set can_do_io at at start of lookup_tb_ptr helper

 accel/tcg/cpu-exec.c                 |  8 ++++
 accel/tcg/cputlb.c                   |  9 ++++-
 target/i386/tcg/sysemu/excp_helper.c | 57 +++++++++++++++-------------
 3 files changed, 45 insertions(+), 29 deletions(-)

-- 
2.39.2

