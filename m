Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754B37646E
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158258; cv=none; b=bHoXB1rBLT3/yv4fd7QBY594aXn/1Hd5E7eNPdhKUpHQFneg7n0oN7u6sXvphMM//xqNUuiFl20DYwJhjNKyx5CnSL+OlDWFF23tMkpBQQwAyVDgEsErWpK4rVKbnfmdaxEreIC5vQ5QZigKnCALlfwdZILVedykIkZweFGGvDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158258; c=relaxed/simple;
	bh=iSuHeRUKaoDL/U57MojllZSXRQszx6z8M4lOxElppBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx+X2Bue9ANHkKeZ7Ak3KCblftCnwtbn3KB6m7wmw8OrP/puMuqPBk9qNziDXhOjAknMpUyIdYXc8rB/GLeXT5uhdMA29It1SV3DdNd9rHw562MeiPPkOeuen4KipprbSEwosQoCWi2t/PBQ9UrffVmfHh9jTWdIcELeZolDr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myoz9KXs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myoz9KXs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788158257; x=1819694257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iSuHeRUKaoDL/U57MojllZSXRQszx6z8M4lOxElppBE=;
  b=myoz9KXsP5ZWFzzY9aVi5/8MLPYXBCIjP8dYvKfK1ZUjCYKIMGyLxLMW
   CVuxdskeJDlHlCm5Np1xoL33vyRtWzV0xBD/UAv/JzMM0HmCuaxW6MnN0
   xYxVZxCT6cxjxube/WfZpGpePStfRwJBfOscvBLBomorOceWiboPRuyBs
   igGavWopl1NI0v3KJhgXl7ZwlNlyThsBnHSzanEKQXsR/3fEm8kaZ+jD9
   PrvfzJvi9Jumnv6DjzTTqB40K2P5etpWFA7IiBcCJRdGCS1s5b6gsO3pI
   p+DES7qr/Q1zYGMDSHlkwxwaBgKvk/xIH/O6oog3FM8qcNlDYbn2B33ES
   A==;
X-CSE-ConnectionGUID: JMFt1y2BQ4yI0hGOeouW9g==
X-CSE-MsgGUID: gzVBkORmThSUm/pG8qhpLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88759398"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88759398"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:37:36 -0700
X-CSE-ConnectionGUID: 2AxHrilYR7+95DI6YHkiGg==
X-CSE-MsgGUID: WkrBKzV6RYCliPPLO2a4bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="298617335"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:37:32 -0700
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
Subject: Re: [PATCH v4 3/6] hw/riscv/virt: Advertise the CXL host bridge to firmware via extra-pci-roots
Date: Mon, 31 Aug 2026 14:37:22 +0800
Message-ID: <20260831063723.409036-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828151317.815-4-cp0613@linux.alibaba.com>
References: <20260828151317.815-4-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Fri, 28 Aug 2026 23:13:02 +0800, Chen Pei wrote:
> +        pci_bus_add_fw_cfg_extra_pci_roots(s->fw_cfg, s->pci_bus,
> +                                           &error_abort);
>      }

On the in-tree edk2 the qtest topology gets PC0C 0x40400000-0x405FFFFF
and bus [0x0C,0x0D] out of build_crs(), and two pxb-cxl (bus_nr 12 and
200) get 0x40000000 and 0x40200000 for their root ports' windows, so
the v3 TODO goes with it and the riscv side is down to this one call.
Your RVA22 run covers the guest side, the memory actually coming
online.

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>

One optional thing about placement: select PXB in 1/6 also brings
plain pxb-pcie to riscv virt, and that one needs the same fw_cfg file
with cxl=off -- as posted, a pxb-pcie with cxl=off is never populated
by the firmware. arm/virt, pc and hppa make the call unconditionally,
and the generator returns nothing without an expander root bus, so it
can sit outside the cxl block. Moved here: the pxb-pcie case
enumerates with cxl=off and the four riscv64 ACPI cases still pass.
Here or as a follow-up, your call.

Many thanks,
Junjie
