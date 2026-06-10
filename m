Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3631540D598
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095758; cv=none; b=hf5yYz9yp1Xd2mTKda3GQpYithBZZryZ+st4W3QPdIcNG+gK2eXvGVzRlZxrnqefHizRVPAUU8+z6y5zLqet1j+2X9H2njWV6p7St244+VOSXcfwOgCahVN3BitHEBwq0R1kW+xSkdtbaCOsPZXb7RMZgUaWP5IvAnbOWz4l31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095758; c=relaxed/simple;
	bh=gHh1v96fQMFdC550ynP6dgV5A1VaG0SSjvQDDFfUI4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J518n6Y82p6DQNpPZkxnl1DEpJQGGLBu2Xn5xxOdEA8yxOyc/BuveTtFXWSyCrpO6KUGZxYEDg9sMz+vX8rSUw8DFumu1qrDDUL1WN7bojBEBZThXqfh3DtvlZsmhXqkwbQOjknas3+FnL3DK8QhWsURLBKiStCa2HGL0rAcacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jaWmKsUv; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jaWmKsUv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781095751; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VgwXepwFFsri2bY3lEgyRhohnclkVYpV0ZEn+hkeglA=;
	b=jaWmKsUv8vNemmUypiebC5pTslXZJ05Qk23OBW6joyqOlyAMYLiv2eO7RlMtv8FiXYu3UyCiqJByj+uUFwWNaToetdnmmv3zzxUBtxsMPYhfzTpeqNq2uHzS7GHXF0CpspsDM1BCV9SLWKRD2aYqbMVICNGBx3u6m5uw6eA8RpY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X4ahYAK_1781095746;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X4ahYAK_1781095746 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Jun 2026 20:49:10 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: jic23@kernel.org
Cc: alistair.francis@wdc.com,
	chao.liu.zevorn@gmail.com,
	cp0613@linux.alibaba.com,
	daniel.barboza@oss.qualcomm.com,
	fan.ni@samsung.com,
	guoren@kernel.org,
	jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	liwei1518@gmail.com,
	palmer@dabbelt.com,
	pbonzini@redhat.com,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	sunilvl@ventanamicro.com,
	zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 2/4] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL host bridge dependency
Date: Wed, 10 Jun 2026 20:49:06 +0800
Message-ID: <20260610124906.131956-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609134659.3dc89b40@jic23-huawei>
References: <20260609134659.3dc89b40@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 9 Jun 2026 13:47:09 +0100, Jonathan Cameron <jic23@kernel.org> wrote:

Hi Jonathan,

Thanks for the detailed review!

> It may be a good idea to add a bios tables test as well.

Okay. I'll add a RISC-V ACPI bios tables test in v2 to cover
the _DEP additions and prevent regressions.

> Please also include an iasl -d dump of the relevant additions to DSDT
> in the patch description. Much easier to review than the code that
> generates it!

Will do. I'll include the iasl -d decompiled output of the ACPI0017
device (with _DEP) in the v2 commit message.

> In general looks fine to me and great that you are clearing this up.
> Seems it's luck that x86 and ARM64 worked without this (or strictly
> speaking other things enforcing the ordering). Ultimately we probably
> want to add this to those two architectures as well.

Agreed. I can send a follow-up series to add _DEP for x86/ARM64
once this lands on RISC-V.

> > +        if (s->bus) {
> > +            PCIBus *bus;
> > +            uint32_t num_cxl_hbs = 0;
> > +
> > +            QLIST_FOREACH(bus, &s->bus->child, sibling) {
> > +                if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> > +                    num_cxl_hbs++;
> 
> I think you only care if there is at least one. Instead of counting, just set
> a bool and break out early if you find one.

As Peter pointed out, the count is actually needed for
aml_package(num_cxl_hbs) to set the correct number of elements.
We'd need two loops regardless (one to count, one to populate), so
I'll keep the current structure.

Best,
Pei
