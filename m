Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A529B3E1D08
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503505; cv=none; b=AjaKNKURS3FS1iocAR+dOlbeFz0v0ip5oGZB+X+S610DwmUl9nkBuxtZN3B3uBqTQ2IG55BHRTi+YtOavG5sqXT3/F4s341QULVyrrMNdPuTiZOCmnPQoZZVWJGrr/YWXNx7laOyTpaqM6mBtZBrmhr6tkmVXHDglLzOc9uf+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503505; c=relaxed/simple;
	bh=yJz0hmZ3jXnW+3e70x7bossu4Qz0K/22Q4P/UCuWfMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqxzdcKjS3ruz+jedsw02jBIOWWWZOo7w3N/ajotMS8UToVUx0V7P20M1fwJQImykvc2UCU8qnZQtTdUTrxH89+2Sr3bdjt0e9KrGeAnfR6kz29aGZxUhkPbAW/TLpE/pq1lKClpJG7wMUE64cOw7PvBWQFSld/9W8GEweBm40Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y489OVsl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y489OVsl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788503505; x=1820039505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yJz0hmZ3jXnW+3e70x7bossu4Qz0K/22Q4P/UCuWfMU=;
  b=Y489OVslgiqoaEfo4nq5hQ6i/5ktf5Qw0sxiy5qICXXaBaDq5OvL30Q6
   vz+Qmtl9ZPSrLfYsl3ta8PewcqiFLJC4qVb+dES74zuA3iAB+t2eKn4fs
   pRumWI4qfo8323YIebVM5gNQYr09fBz+jry3LDNkhhO3PFgXUHuVwOby/
   F+gGavbMDIo1R77iSeXOtygOFcx+7VJFIuXq5E9ZFakHBChkJrQ8Jnlyk
   U2JKOwuXh1PoHvp70QYgRoFeiDGEY5ZAVsjv42Aj1DQbf6XGD74dHnJ9y
   mSHUKoWfR/3fiV1+P43ZflEK6HXvHizdDPu4yIpLNIJBg6r4dyPp2R+05
   Q==;
X-CSE-ConnectionGUID: So06jjZNQ3a54YUDR9Omcg==
X-CSE-MsgGUID: +Uhd4Tp9T6OyI/zn9QBlhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89053538"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="89053538"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:31:44 -0700
X-CSE-ConnectionGUID: nYq0w4UjT6CUQyNTv8GS3w==
X-CSE-MsgGUID: UZGknod0QUmMZu+qNK6HxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="263755465"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:31:39 -0700
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
Subject: Re: [PATCH v5 5/6] tests/qtest: Add RISC-V ACPI bios tables test for CXL
Date: Fri,  4 Sep 2026 14:31:30 +0800
Message-ID: <20260904063131.452351-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831132340.5345-6-cp0613@linux.alibaba.com>
References: <20260831132340.5345-6-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Mon, 31 Aug 2026 21:23:36 +0800, Chen Pei wrote:
> +        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",

master renamed these to edk2-riscv64-{code,vars}.fd since v4
(2e0eeac953, in the 1 Sep firmware pull), so on 99e54ab5e7 this case
does not get QEMU up: "Could not open 'pc-bios/edk2-riscv-code.fd'".
riscv-to-apply.next has not picked up the rename yet; v6 still wants
the new names.

Many thanks,
Junjie
