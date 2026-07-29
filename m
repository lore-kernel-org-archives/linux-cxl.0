Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E5B43DA38
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328595; cv=none; b=vB+Bjg3dlq6otTp/H56JUECcRfDL6BcLlPv3TGeZjrJQjMyE6QHljCQi/iiMIuE0PhB8+bEG/KYu9+Ash7XURtSvp/pizdTXM2iC7QkYlCHWNJj8UcPZzPdTOfNq7hzwD5mtxL1LPZhJ0IJH2SCgxmFqTBP5ZDTYqan9TF+x0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328595; c=relaxed/simple;
	bh=E3rwI/5wM1IDVNZKPWfWI4i7v9W0T2H8IUqxe5ACwk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJJ4NXC7fdcg8WYBBSqaCasXeM9jZoT54L4uJ1Gba2FMfGySN3XB0c7oE10Ju3W6vKKb7ju9SAdRHX4togn+CDnYh0WAws2zTY+2+VqofImAg2bztAexU5mdM4nOgqR0oi1h6Thdy+t4AIhzcqjIAKQ8DYXqCQV9CENWgrGmCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CAChZPwy; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CAChZPwy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785328578; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=jKlcdBnFuHgRxrT49QtoTVmYgMs7rTqDYQgsQRVgtko=;
	b=CAChZPwyngiL7HvqoQqTpuUacbAIqtv3KgQeRehrAy6ARwVU5H3gGGt35nNoUqs7dFbVvnDPTXuPRw8fDZQiaqhoZ6mjXzzrA45e1hGUVlpRvKhSUAK4p9k/dfokYkSDSNt2N+es8pXrAN3PkfOBc+wzTiYGCWOyjJDUIoGwfaQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X82AQ0a_1785328573;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X82AQ0a_1785328573 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 20:36:17 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Igor Mammedov <imammedo@redhat.com>
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
	mst@redhat.com,
	guoren@kernel.org,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hw/riscv/virt,gpex: Provide 32-bit MMIO window for CXL host bridges
Date: Wed, 29 Jul 2026 20:36:10 +0800
Message-ID: <20260729122505.200000-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727110615.3e523125@imammedo>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com> <20260618093827.3507-4-cp0613@linux.alibaba.com> <20260727110615.3e523125@imammedo>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Igor,

Thanks for the review.

On Mon, 27 Jul 2026 11:06:15 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> I kind of dislike (basically riscv specific hack) in generic code.
> well, correct way to tackle this is
>  1: fix UEFI to perform required initialization.

I agree this is not a clean solution, and I acknowledge the concern
about putting riscv-specific behavior into the shared gpex code.

I did try the "fix UEFI" direction first. With the current EDK2
(edk2-stable202602, the same FdtPciHostBridgeLib/PciBusDxe used by
both aarch64 and riscv virt), I booted a riscv virt machine with
pxb-cxl and dumped the ECAM config space after the firmware finished
enumeration:

  - pxb-cxl (1b36:000b) on bus 0: class 0x0600 (host bridge),
    header type 0, memory/prefetchable window registers all zero;
  - cxl-rp on bus 12: memory window base > limit (empty, reset value);
  - cxl-type3 on bus 13: entire config space reads 0xffffffff,
    i.e. the firmware never enumerated behind the CXL host bridge.

The root cause is that PciBusDxe only recurses into devices for which
IS_PCI_BRIDGE() is true (header layout 1), while pxb-cxl presents
header type 0 and class 0x0600, so the firmware neither assigns it a
secondary bus number nor any MMIO window. FdtPciHostBridgeLib likewise
only consumes the single "pci-host-ecam-generic" node describing PCI0
and has no knowledge of the expander bridge. As a result build_crs()
genuinely returns an empty set on riscv today - this is not a timing
artifact.

> if you have to put a hack into QEMU, make it work with current build_crs()
> and localize 'proper simulated initialization' in riscv codebase
> (i.e. do not spread it to common codebase). But before doing it see (#1 not=
e).

Understood. Since #1 (a UEFI that performs the initialization) is not
available on riscv at the moment, the static window is currently the
only path that makes CXL host bridge _CRS usable here.

For what it is worth, this is consistent with how CXL is being handled
on the ARM side. The sbsa-ref enablement (Yuquan Wang, RFC up to v7,
"hw/arm/sbsa-ref: Support CXL Host Bridge & CFMW" [1], plus the
matching edk2-platforms RFC [2]) deliberately carves out exclusive
static MMIO32/MMIO64 and bus-number ranges for the CXL host bridge and
builds static ACPI tables, explicitly noting that it "doesn't need to
communicate CXL contents via DT to edk2". Jonathan Cameron's arm/virt
approach instead relies on EDK2 performing the enumeration and QEMU
reading the result back via build_crs(), but that depends on a recent
EDK2 with expander-bridge support that we do not have on riscv yet;
his earlier DT-binding RFC for expander bridges [3] also notes that on
the DT path QEMU has to allocate the windows itself.

[1] https://lore.kernel.org/all/20250807111037.241118-1-wangyuquan1236@phytium.com.cn/
[2] https://op-lists.linaro.org/archives/list/asa-dev@op-lists.linaro.org/thread/EPPN4R6KLGKYLWPOZUBWJG5HCXAAO3SQ/
[3] https://lore.kernel.org/all/20230421165037.2506-1-Jonathan.Cameron@huawei.com/

Given that, my tentative plan for v3 is to keep the static-window
approach for now but address your objection by localizing it: drop the
cxl_mmio32 field and the is_cxl branch from the common gpex code, and
instead simulate the initialization in riscv virt code so that the
existing build_crs() path produces the correct _CRS (i.e. have riscv
pre-populate the bridge window registers / range set the way a
firmware would), keeping the common codebase untouched.

Before I rework it that way, I would appreciate any suggestions you
may have on this approach.

Thanks,
Pei
