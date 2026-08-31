Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A243B9DA5
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158319; cv=none; b=P2MTAtWiwFAjQhdVWaSrZNYtPSu72Z2thP03IEo6rXzbSErlbYaSuVUStCniy37agJv034wMLb+bwhw0WuhVHf/BKaCRmE8Wr26/L9yJXyiJKot7Siz/ymyd7hXhWrpAmsOc2OOunse8lBKVGv+SLl3Sd4o5TNmWKeGgu10NOoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158319; c=relaxed/simple;
	bh=fzD85mNTmOhXLNv5Q6BGfESrnPdcRp0mrvjC7CGcgYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4Bw20s5nVCvOV9Xs9FOQlF+IWCr3uDQhOU+A6On3RsvdVywPNhTv/Ertr+vZ4Fmd/+814FX8PYAwkYUFacx8awAnm4mq1P+fv25JDHSddMs37VxOxWS5pXtihTJWHP/SWoCIO9TU3mltAlqsix05ECbUmVMI7vpQmJ76dZFfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSDCCurh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSDCCurh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788158318; x=1819694318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fzD85mNTmOhXLNv5Q6BGfESrnPdcRp0mrvjC7CGcgYc=;
  b=SSDCCurhQl8aKqZvKNOSdLXZdN0N6O9GhA0cWJPwzEjejtf2S1hjsElb
   0V1u6BKjlX2FR4Ono3m3WJb0xNrG5Z6EvyvISBRo+sQ6xDjRSrdkxFYrq
   Q+C/uA7j0K3u3IVJ9IP8irU1JN6Mpj1SVCMJekaorfmfubThooOfBvX06
   Tlf+IAjcltbgTqRtdYgiV5lFFNTo08IAJGrOEBChVyb4NGhGHy9Idk6C/
   b8yxsGHYYdHc8KAsRRP137RE3W/w3jWsBap6WMERRwjbPB3B96rdIZHOS
   wHhchlRvoUIEXOa9T8r1A5UTwtl3/I2llKRBuXeXe5WitBKAH7UGPCLiU
   Q==;
X-CSE-ConnectionGUID: edTaVwscSUC1gALcuT1qiQ==
X-CSE-MsgGUID: yD1ni+l0RdyxDNolGi/jIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88679792"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88679792"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:38:37 -0700
X-CSE-ConnectionGUID: SbHStBUYRdS4kFerkD7cDw==
X-CSE-MsgGUID: PlMtVdZJQBC2oPntlw5Hdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="292212170"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:38:32 -0700
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
Subject: Re: [PATCH v4 6/6] tests/qtest: Update RISC-V CXL ACPI golden master binaries
Date: Mon, 31 Aug 2026 14:38:24 +0800
Message-ID: <20260831063826.409086-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828151317.815-7-cp0613@linux.alibaba.com>
References: <20260828151317.815-7-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Fri, 28 Aug 2026 23:13:05 +0800, Chen Pei wrote:
>         QWordMemory (... 0x400100000 .. 0x40020FFFF ...) // 64-bit MMIO

This one fails for me on d2e570cc0f with the in-tree
pc-bios/edk2-riscv-code.fd (edk2-stable202408.01):

  not ok /riscv64/acpi/virt/cxl

Regenerated with TEST_ACPI_REBUILD_AML=y, the file differs from the
posted one only in the length of that window, 0x10000 here against
your 0x110000, plus the matching shift of PCI0's second 64-bit range.
The 64 KiB is the root port's own BAR0 -- this firmware degrades the
Type3's 64-bit BARs into the root port's 32-bit window. The extra
1 MiB in your file is one bridge prefetchable window, which fits the
edk2-stable202602 you mentioned on v2: that release carries f6489621
("PciBusDxe: Degrade MEM64 to PMEM64 when bridge lacks MEM64"),
reverted again in March (defbd14).

A golden carrying the firmware's allocation is the same situation as
the q35 CXL golden with SeaBIOS, it just has to come from the blob the
test boots. Regenerated here it is also 6331 bytes, sha1
20608434d5b8c7e06d24a59e3a366cb23d1b0238. CEDT.cxl matches.
Re-running this on v5 is no trouble.

Many thanks,
Junjie
