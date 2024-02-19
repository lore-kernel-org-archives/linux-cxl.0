Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3783445956
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363919; cv=none; b=daMjwHvhmkSfOdcgSHgOwgbo4rc4Mei2x9+oIrCUtHYn8hxnjmqveWEz6GSgHJmYi92M9+SSA11OxIUDhxswU2p5F2pVCSOYBp6Ta/WtVN9/+FqA4IfBOvwSDzVooJWHmCj+8Z95CiRYpVzkQYGHozSu66H4fPxdVUF+gHsgApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363919; c=relaxed/simple;
	bh=g85QRfqjmi4GiCk9esQPLvz9kDvUKiwJ9KPvXZRgqg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GPqgZPvppzblydJZIdM8U39YXZUlcw1bOr99z4AY7auwgY5uPz0pjDP5dbnXG5rvK8pWkBdZDtTGvrwDnFg9/ypPAQWTEy7rSMNKWwUjJ5K7eFIXvX7hAh380b2kDz2vrMx9z39yKXfUZ4fSfhrdFVLc55oM5ACSdRT+l3eiEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdqHF6rcXz67D3k;
	Tue, 20 Feb 2024 01:27:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 97786140B54;
	Tue, 20 Feb 2024 01:31:52 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 17:31:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
	<alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
	<dimitrios.palyvos@zptcorp.com>, <richard.henderson@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH v2 0/3 qemu] tcg/i386: Page tables in MMIO memory fixes (CXL)
Date: Mon, 19 Feb 2024 17:31:50 +0000
Message-ID: <20240219173153.12114-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

v2: Changes documented in patch 3.
   - I have not addressed Richard's comment on recursive locks as that
     seems to be a more general issue not specific to this patch set.

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


Gregory Price (1):
  target/i386: Enable page walking from MMIO memory

Jonathan Cameron (1):
  tcg: Avoid double lock if page tables happen to be in mmio memory.

Peter Maydell (1):
  accel/tcg: Set can_do_io at at start of lookup_tb_ptr helper

 accel/tcg/cpu-exec.c                 |  8 ++++
 accel/tcg/cputlb.c                   | 36 ++++++++++++++----
 target/i386/tcg/sysemu/excp_helper.c | 57 +++++++++++++++-------------
 3 files changed, 66 insertions(+), 35 deletions(-)

-- 
2.39.2

