Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B82F3F8247
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jul 2026 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783425080; cv=none; b=ZweasyHwGojGZULSBOOqevmnZ2zzcR1ZAeGQltGiWu0IsIqgt0R6LH1SeV9JcsQDpm29IjYbJN22hBBxNjLOSYGzAxL74gLsnx2SfZPZKnkQEG7fKwLmlgfkTLLkq9l2JEzJKBi6Ku/RExMobGcPBCUTI1OIhEqnFee0Gd6FAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783425080; c=relaxed/simple;
	bh=NeSTeVwWKTHsAj3apQimE1t6DXk7p5H0cyYXiwjnfVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7btnRF8f4qIoowaComgUEKzvJvHa5ntEiMPG1COijq+v/AFDdlmulL7yzMKFpKqDPF/hyF5yQRAyjLBgU9Oic5sp5Yum5cfY3apXUX/79KCuVaXBGDzdyoCvBsihZkOhoF45G8HHgy2Xty6oBSqAZuq2a1bIa+ZaY8Tnj8Pkv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aQkaHHF8; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aQkaHHF8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783425075; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=rpaF+3X5yVUY38lZ8E6VBAIqYBPrSyACSRp5xlfpDpE=;
	b=aQkaHHF8ZfPzMP+2mEoOEkOwHQoC2jvjphH5X3TR9xwn2QdUexD18rRSQA3+OOP0cjG3PqFr3QB0R3IUar7mvVVqFS+zSVaAdezS7IKcFGwG2zTaPfUq9DjtAdbnfq/3t6JC1Mpfr/EvzQlCgY0L+pXmPDs5eey/jNzF1/TbIxk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X6dPmaC_1783425031;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X6dPmaC_1783425031 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 19:51:14 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Alistair Francis <alistair23@gmail.com>
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
Subject: Re: [PATCH v2 2/4] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL host bridge dependency
Date: Tue,  7 Jul 2026 19:50:20 +0800
Message-ID: <20260707115030.5161-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAKmqyKNmFdJRUegowCGggk+4fOmY7vBxOH+_gnmTSpNhyqWqHg@mail.gmail.com>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com> <20260618093827.3507-3-cp0613@linux.alibaba.com> <CAKmqyKNmFdJRUegowCGggk+4fOmY7vBxOH+_gnmTSpNhyqWqHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi Alistair,

On Mon, 6 Jul 2026 14:08:45 +1000, Alistair Francis wrote:
> What happens to kernels that don't have this change?

Good question. The behavior depends on how old the kernel is:

- Kernels that support _DEP processing but lack the
  acpi_dev_clear_dependencies() call in acpi_pci_root_add(): the
  ACPI0017 (CXLM) device will remain deferred indefinitely because
  its declared dependency on ACPI0016 is never cleared. CXL memory
  would be unusable on such kernels with this QEMU.

- Very old kernels that ignore _DEP entirely: the behavior is the
  same as v1 — the probe-ordering race between acpi_pci_root and
  cxl_acpi remains, but nothing is worse than before.

The kernel-side fix has already merged:
  https://lore.kernel.org/linux-pci/20260526025118.38935-1-cp0613@linux.alibaba.com/

So this is effectively a "new QEMU requires a sufficiently new kernel
for CXL to work" situation, similar to other QEMU features that depend
on kernel support.

Thanks,
Pei
