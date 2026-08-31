Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436034FF41
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179433; cv=none; b=aj+aSfQLAmjfEUj7Aw5SzjHdVmuPL5XhUOouDoTM7wNKSqbgVXJ7lx3wRCKUgOgmZUFTYFZMKQIuJMcKjdmLoaGlZ13oCLx2k7SAeRtwXrH+5aeJsOVOnOcizaRgZO1hiPMM6C8DnNOtSxvVHNhJJvI25gTzdh16FcXzX8V7JKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179433; c=relaxed/simple;
	bh=i4zlhiSUeqvaCAR9y62PHsaAGUXzpKfZ/Y2Hjp/1pak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khGsqp2D/OGnrhBshsyzG7lIqFcq12km4rKoyexK5XBzyoMOaM/ejOoKmVng08MCGRhBlxaGlZwP50ul4qtIHe6kmgKVtHE4zRB5EuryTzl4BJOd8QBZqppwjEt81RGK3LxN3UoLis1DA0cNNppr0cb9RU0a8tJEwrCEvkV3kBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BwjYLiWm; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BwjYLiWm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788179422; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=rP0u+r1sBvXL9q/dJ/o6Igg9T9W93ERYox9RGe9wdsA=;
	b=BwjYLiWmzC+tzicD8GD86ZhwuM39/SMiDtrvOfEM9uSKhs55ZiF5cf+yoYJp+1XhmvNiIWmAR7RWyWtTE9jJpe3QDBkd/mY3btYAasucATbLRQQ7R5ymkFYk8WV/PTClO7ELbGj1MGC2nuXA0Xh0gFRYLMCoU1/N8CCRfxJdilE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9yvDeI_1788179416;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9yvDeI_1788179416 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 20:30:20 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: palmer@dabbelt.com,
	alistair.francis@wdc.com,
	mst@redhat.com,
	imammedo@redhat.com,
	sunilvl@ventanamicro.com,
	sunilvl@oss.qualcomm.com,
	jic23@kernel.org,
	pbonzini@redhat.com,
	liwei1518@gmail.com,
	daniel.barboza@oss.qualcomm.com,
	zhiwei_liu@linux.alibaba.com,
	chao.liu@processmission.com,
	anisinha@redhat.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	guoren@kernel.org,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 3/6] hw/riscv/virt: Advertise the CXL host bridge to firmware via extra-pci-roots
Date: Mon, 31 Aug 2026 20:30:13 +0800
Message-ID: <20260831115000.610002-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831063723.409036-1-junjie.cao@intel.com>
References: <20260828151317.815-1-cp0613@linux.alibaba.com> <20260828151317.815-4-cp0613@linux.alibaba.com> <20260831063723.409036-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junjie,

Thanks a lot for the review and for testing this end to end!

> One optional thing about placement: select PXB in 1/6 also brings
> plain pxb-pcie to riscv virt, and that one needs the same fw_cfg file
> with cxl=off -- as posted, a pxb-pcie with cxl=off is never populated
> by the firmware. arm/virt, pc and hppa make the call unconditionally,
> and the generator returns nothing without an expander root bus, so it
> can sit outside the cxl block. Moved here: the pxb-pcie case
> enumerates with cxl=off and the four riscv64 ACPI cases still pass.
> Here or as a follow-up, your call.

Good catch -- thanks for the heads-up.  Since 1/6 selects PXB, plain
pxb-pcie is indeed left unadvertised to firmware with cxl=off as
posted.  I will move pci_bus_add_fw_cfg_extra_pci_roots() out of the
cxl block in v5, in line with arm/virt, pc and hppa.

Thanks again,
Pei
