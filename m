Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160103AFB1C
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503525; cv=none; b=RxZK8N6ZlNpaap8efwAQ8sztnFKdyR/X0NWWq0QM7o0ZPFjowX+aBJHVEEq/x0Ko0H8iI44UzL9phLCu5RM3peVFan+7ogpYwK8cySzJTAYdk+Gl/DzSpKcpulauQw9t4IJvB7dur0lJJhYUx84r8qhfe+7XP3S5eKOUk//NuoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503525; c=relaxed/simple;
	bh=zriIRq2vJy1ysgxcDuxY8pCvpt55v5hWB6MGQlh7J+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnmQe94/VlLmmmaSjrABfspYZ9mQd6wF7mnV+DQpNMKa6UufntA3LAZVvdXduB0fnLRrsJ9khLtQ+5+8LAiHnx5W52JFanXhWApClygBiLcQKkZLO1xAWRlPtrD/ik4okAHctDWeM1Ji/Gd5myI+14Y6YG4AoX2DPoPHaEsBZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOafIrE4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOafIrE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788503524; x=1820039524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zriIRq2vJy1ysgxcDuxY8pCvpt55v5hWB6MGQlh7J+Y=;
  b=aOafIrE4KpuamSc349LfTcVdvKSNOfJByJuD32XKhvVqAe7PSsqggpQq
   vD6xE4PifanZDYu3h4vE/fHgE2jtS330Gg/6nH2HkhbdLSfyrDSmkLjAN
   1We+ygRbDa0+NhqBwM8THAFFT5GP4olby2D06gV5zj+uT0aQ1xyKXZMn+
   zLpEFRzyaf3KniJfO4fOj1oD9qoluSh2qO9/eCU5qu8gKkzVYH2YdAOr/
   i51xOsi9Zfz3lsd64ZcIk9OXOOq45qJ83HBjkgeYWrbJhfsLWeCY2fPJs
   WmobzdHhIRhe3dpwPoAsTDxYhyY1pA1THTs5yUlawA3Fu7HoN3bmRcoor
   Q==;
X-CSE-ConnectionGUID: RsULxHY3QHGNpreLXQsUvg==
X-CSE-MsgGUID: A7r19YgtQ0KpumSwjPiSyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="114543314"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="114543314"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:32:03 -0700
X-CSE-ConnectionGUID: q7hXIhmZTi+Wbj7PJ5BQwQ==
X-CSE-MsgGUID: H9QoENy7RQ63x66Oh08aQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="263755527"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:31:59 -0700
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
Subject: Re: [PATCH v5 6/6] tests/qtest: Update RISC-V CXL ACPI golden master binaries
Date: Fri,  4 Sep 2026 14:31:51 +0800
Message-ID: <20260904063152.452367-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831132340.5345-7-cp0613@linux.alibaba.com>
References: <20260831132340.5345-7-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Mon, 31 Aug 2026 21:23:37 +0800, Chen Pei wrote:
>         QWordMemory (... 0x400100000 .. 0x40010FFFF ...) // 64-bit MMIO

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>

Golden matches on 99e54ab5e7 with the in-tree edk2-stable202608 blob
(5/6 paths renamed) and on riscv-to-apply.next 392d659bfb, still on
the edk2-stable202408 blob (1/6 rebased over the gpex_pcie_init() move
to device-common.c).

Many thanks,
Junjie
