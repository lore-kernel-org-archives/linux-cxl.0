Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090993C9EE0
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751464; cv=none; b=uIsmNtXcXsHL4uegST591/KbRQbbigVYLwoODDRBkZT8m8RgGaQAXs3edS/KhkfyGCZ+hIwdXvpyta5OUl0E6tQJcWZi+7qDbGuFcIVkcHtEyG+yC/LZCX+aTdwwJzj7JRDvYciTNiJBYLXhR18JrRds23qvo8v1RTxizfc76c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751464; c=relaxed/simple;
	bh=N/ewH1XUjCFXF1ttKhEJj8Pkw0zsvEYKLlERLNbB4Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQyoqQ88DOh+nnD3wkuS3IoAcD0GmvxazTfF4lWwMcTvNqRPoFluQOS6/lv53IK2U+k9i1PM+21ny9OydV+pWmrswUQrSdbNUaJ88buSfjNxOMEO+J7djsppkFhnEcabj5uBCawF+qiy0NY0Ghf0YDthftr5pFQmpZO4gfN4aeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANe9qPfK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANe9qPfK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787751462; x=1819287462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N/ewH1XUjCFXF1ttKhEJj8Pkw0zsvEYKLlERLNbB4Is=;
  b=ANe9qPfKOwhdzLL4UJq2+yzI8QV8RWcLLuys2V9P2vk/M58QRFlxG15+
   HhTs7son5Em1SW+yaTO+lC8q5rtRpNz5r4zomOCsdoWwaoIYnWNYt7H5f
   VuAk+l9nRVAMcvSk547wvkPWd3iBu/MMbFdPkIdQXqUCLWr3nRTzPuyi7
   FPWr2l+/47TbriLuQ+tq4H6OWWhLG6E2cG3GNvKTkRFEvA3f+vK1j+BSf
   699D6js5Yi9QxTiyt+6uW39d7wTIJPUslb8NUtFWYy//75c+ky50Tli4l
   d/E+h3UUlaAw1w59jK7DqZyDAv+0up4QSNXt6umIutLWeUWx/OXaHJToP
   Q==;
X-CSE-ConnectionGUID: rzIl/MoOTdeuoQJJlcCk4w==
X-CSE-MsgGUID: 2BPMIio4RWC/VS8oduABMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88249824"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88249824"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:37:41 -0700
X-CSE-ConnectionGUID: 8Bi5SUYJTHWTAzEIU7h1wA==
X-CSE-MsgGUID: KGVcK7WGQfy5sjzSoFgxnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="269529694"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:37:37 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
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
Subject: Re: [PATCH 0/4] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Wed, 26 Aug 2026 21:37:24 +0800
Message-ID: <20260826133725.355433-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081954.1171-1-cp0613@linux.alibaba.com>
References: <20260821081954.1171-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Fri, 21 Aug 2026 16:19:50 +0800, Chen Pei wrote:
>   - hw/riscv/virt: The MMIO-window patch no longer touches the common
>     gpex code (Igor).  The gpex_cfg.cxl_mmio32 field and the is_cxl
>     static _CRS branch are dropped; the ACPI0016 _CRS now comes from the
>     generic build_crs() path.  Since EDK2 does not enumerate the pxb-cxl
>     expander bridge, riscv simulates the firmware PCI initialization
>     (reserved window + depth-first bridge bus numbers) and re-applies it
>     via a reset handler.

Ran this on master eea8fe61b8 (it still applies clean on bde2492aac).
riscv64 bios-tables-test passes. In the generated DSDT the PC0C _CRS
now comes out of build_crs() with the reserved window
0x70000000-0x7FFFFFFF and a bus range [0x0C,0x0D] taken from the real
subordinate, PCI0 shrunk to 0x40000000-0x6FFFFFFF, and the CEDT CHBS
and CFMWS matching the machine memmap. The machine-global window
synthesis and the +15 bus range from v2 are gone.

system_reset from the monitor leaves the root port with the same
window and secondary/subordinate numbers, so the reset handler does
what it says.

One larger question on 3/4 about where that enumeration should come
from, and a note on 4/4.

Tested-by: Junjie Cao <junjie.cao@intel.com>

Many thanks,
Junjie
