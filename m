Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F240097F
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895056; cv=none; b=awQanl6Mvx6jiHP1RLK29EpWaTjS4GtQJnNNk7Zwf8zeCrzEvj2N8hnGTeu6b80fRDSMwDj1/cuY+Nrtg7xuC5x51/FQtQmtMtU950FrtmoiHpNwo9rxoKOnUWYfQ4lW+EvNXRv78LNnihuI4oBMQ5oX76pryy2TUDZWX0fcZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895056; c=relaxed/simple;
	bh=+K75ZKUUT9jKQO4Hm6LpjU8yweCppiGSUWmxtwjqqpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/jh3e5Yl89ShRYJNpPN7c6EmywqJzACjHky59RixSB5v8L3C9+TQsjzY6e6azw9sad3PIVHqFPMxNgbmxgE9hocDr7Zwj3egx65zmEx6TD7xL4YlBGv/UlOZm1nOfPJotsPgRHExrS4vqnHlIKQ+ZBjGNs5gtbVPaCwQtXgAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SkBvlUe0; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SkBvlUe0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784895048; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=AY2MUFtWa7qbEgOXmtH7fiAkQnXvuDoQ+rmq6ZDnlW0=;
	b=SkBvlUe0ez7y4ULN4wVzJvcuSgizuCJLT6sa8Miuc+RPxCN3x2U+xlnSErR1sRQXy6p3uNElTDs5WqxwRAEJKrWk9D3LPZT+TNIFoUW//LTZiAX/JvxQKvlKF1quG9xIHv6uwWRepv/sGiHQr2Bg179KjFEw/LikRVGJZH1EE+A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X7j4T27_1784895030;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X7j4T27_1784895030 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jul 2026 20:10:47 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org,
	pbonzini@redhat.com,
	palmer@dabbelt.com,
	alistair.francis@wdc.com,
	liwei1518@gmail.com,
	daniel.barboza@oss.qualcomm.com,
	zhiwei_liu@linux.alibaba.com,
	chao.liu.zevorn@gmail.com,
	sunilvl@ventanamicro.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	imammedo@redhat.com,
	mst@redhat.com,
	guoren@kernel.org,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hw/riscv/virt,gpex: Provide 32-bit MMIO window for CXL host bridges
Date: Fri, 24 Jul 2026 20:10:20 +0800
Message-ID: <20260724020000.100000-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722135240.763013-1-junjie.cao@intel.com>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com> <20260618093827.3507-4-cp0613@linux.alibaba.com> <20260722135240.763013-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junjie,

Thanks for the thorough review.

> cfg->cxl_mmio32 is a single range on the main GPEX host, but this block
> runs once per CXL host bridge in the QLIST_FOREACH(bus, &bus->child)
> loop, so with more than one pxb-cxl every ACPI0016 gets a _CRS that
> declares the *same* [cxl_base, cxl_base + 256 MiB) window.

You're right. The static path synthesises the bridge window from the
machine-global cfg->cxl_mmio32 rather than per-bridge state, so it
does not scale past one pxb-cxl.

> is supporting more than one pxb-cxl in scope for this series, or is a
> single CXL host bridge the intended target for now? If the latter, a
> note to that effect in the commit message would help.

For this series the intended target is a single CXL host bridge,
which matches the bios-tables test case (one pxb-cxl at bus_nr=12).
I'll add a note to the commit message in v3.

> One smaller thing about the hand-built template: the bus range is
> hard-coded to [bus_num, bus_num + 15], so with cxl.1 at bus_nr=12 and
> cxl.2 at bus_nr=16 the two _CRS come out as [0x0C,0x1B] and [0x10,0x1F],
> which overlap on buses 0x10-0x1B.

This is a related symptom of the same root cause: pxb-cxl only carries
a bus_nr and the actual subordinate bus count is not known at
ACPI-build time, so neither build_crs() nor a static constant can
produce a correct span for the multi-bridge case.  The +15 heuristic
is borrowed from the ARM virt machine's gpex handling where a single
pxb is the norm.

> Both really trace back to the same spot: the static branch synthesises
> the bridge's window and bus range from machine-global constants
> (cfg->cxl_mmio32 and the fixed +15) rather than anything per-bridge, so
> neither scales past one pxb-cxl.

Agreed.  I'll add a TODO comment at the static branch in gpex-acpi.c
to flag this for future work, and document the single-bridge limitation
in the commit message as noted above.

Thanks,
Pei
