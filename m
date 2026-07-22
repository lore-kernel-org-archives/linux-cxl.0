Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D67353A85
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728430; cv=none; b=BwT83aaogwnsm8/H/66LpSIDY8vB82Wki83NiRGyde1Gnkl13CXuFIjhzFUz7ORBnYcHLgtVY1wwACPVYxJ88CbF8xsH8jSn7tRmQVudqhtjA0ovvQOUmrkKATBlbZkjHX/S9+F+Vu/dYUXFnDs/oWJh3itPqck2PUdR1J4z1+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728430; c=relaxed/simple;
	bh=WkQP+VLLIUcupmM/h8M3bLBbXU5+xR/+0pbsUwRlOyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubo5YxOcB/qaHU3ExhKfrKmlaIQUaSvw37dZPruvYwANqY2p/0H+lJjLLblTiUWsVE1dNPPBTbylyaBLcmy5PncPsMSWsDbuwwwRnFnd2yIU8BlYTT6SxWPwBUlmEwtg/+AyTstOMaKnac0ELMuBoU+iB8uO5uftJIDlEhjM06c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfSyb1bT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfSyb1bT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784728428; x=1816264428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WkQP+VLLIUcupmM/h8M3bLBbXU5+xR/+0pbsUwRlOyw=;
  b=DfSyb1bTfJIgDZamMB7fkWY5AqtrEEYjCXD2nPWbWtV9e81fAiuhicoa
   ZxgSatISL/8uFWEF7NBgVuPdOQlsXfqgxccTTYALvMNwa7Tv06gj8p0Ib
   +VzKMMm7885PDzFcbaqVjkq4CEf8zIK441S0XzdqvdAw0pGo5gjYivghI
   ix7ceXyVy+DlLq+2z75VYSu4WZKTsk3VdI75XkUgJyuwSK9m9fIxrBNgw
   2FhI5sbtVTZWnkK3uo4iEJlD1cRB6E5OAeylQ4ryRXx2+1XHsmiiJgEFG
   iM8Yj4KB5Ql2Iucbj//9qg2oE918w7+T1D9U6ujWuhq2PqkD78EWEfTsS
   g==;
X-CSE-ConnectionGUID: MRzZQgyJSrS/OVC3rvcH0g==
X-CSE-MsgGUID: 2yW7ErwURq2F/PQnQ/DLtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85455074"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="85455074"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 06:53:32 -0700
X-CSE-ConnectionGUID: cywj4bg0QqWWIhVHLsmINg==
X-CSE-MsgGUID: ARkzCj6xSN+AapMbVWmVdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="251796121"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 06:53:27 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
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
Date: Wed, 22 Jul 2026 21:52:38 +0800
Message-ID: <20260722135240.763013-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618093827.3507-4-cp0613@linux.alibaba.com>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com> <20260618093827.3507-4-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Thu, 18 Jun 2026 17:38:25 +0800, Chen Pei wrote:
> +            if (is_cxl && cfg->cxl_mmio32.size) {
> +                uint64_t cxl_base = cfg->cxl_mmio32.base;
> +                uint64_t cxl_size = cfg->cxl_mmio32.size;
> +                crs = aml_resource_template();
> +                /* 32-bit MMIO range for CXL devices */
> +                aml_append(crs,
> +                    aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> +                                     AML_MAX_FIXED, AML_NON_CACHEABLE,
> +                                     AML_READ_WRITE, 0,
> +                                     cxl_base, cxl_base + cxl_size - 1,
> +                                     0, cxl_size));

cfg->cxl_mmio32 is a single range on the main GPEX host, but this block
runs once per CXL host bridge in the QLIST_FOREACH(bus, &bus->child)
loop, so with more than one pxb-cxl every ACPI0016 gets a _CRS that
declares the *same* [cxl_base, cxl_base + 256 MiB) window.

I realise build_crs() returns nothing usable for these bridges at
ACPI-build time (the BARs aren't assigned yet, per your commit message),
which is why the static path exists -- but it hands that one shared
cfg->cxl_mmio32 to every CXL bridge.

I checked the generated DSDT for a two-pxb-cxl riscv64 config (cxl.1 at
bus_nr=12, cxl.2 at bus_nr=200): both ACPI0016 host bridges (PC0C and
PCC8) come up with the identical producer window

    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, ...)
        0x70000000,   // Range Minimum
        0x7FFFFFFF,   // Range Maximum
        0x10000000,   // Length

while PCI0 is correctly shrunk to 0x40000000-0x6FFFFFFF. That 256 MiB
window is the only memory range either ACPI0016 advertises, so every BAR
behind the two bridges has to come from it; and since two host bridges
can't both decode the same range, at most one of them can actually
claim it. Multiple pxb-cxl is a supported topology in QEMU generally.
Partitioning the window per bridge may be one way out, but whether
that's the right model is your call -- is supporting more than one
pxb-cxl in scope for this series, or is a single CXL host bridge the
intended target for now? If the latter, a note to that effect in the
commit message would help.

One smaller thing about the hand-built template: the bus range is
hard-coded to [bus_num, bus_num + 15], so with cxl.1 at bus_nr=12 and
cxl.2 at bus_nr=16 the two _CRS come out as [0x0C,0x1B] and [0x10,0x1F],
which overlap on buses 0x10-0x1B. The real width depends on how many
buses the pxb-cxl spans, which isn't known at ACPI-build time (pxb-cxl
only carries a bus_nr). build_crs() is no drop-in here either: with the
static path disabled I saw the range collapse to a single bus
[bus_num, bus_num], since no subordinate buses are enumerated yet -- so
it under-sizes rather than over-sizes.

Both really trace back to the same spot: the static branch synthesises
the bridge's window and bus range from machine-global constants
(cfg->cxl_mmio32 and the fixed +15) rather than anything per-bridge, so
neither scales past one pxb-cxl. Going static is fair enough given
build_crs() has nothing to offer at build time -- as above, it supplies
neither the window nor a usable bus range -- so the real question is
just where the per-bridge window size and bus span should come from.

Many thanks,
Junjie
