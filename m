Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0D25B085
	for <linux-cxl@vger.kernel.org>; Sun, 20 Sep 2026 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789895684; cv=none; b=fVFqcNPYNy3/s7EW/v6Z7YfTG0nr6bilSOBhXrTPbMi0sXnNrQCt3NzCIpwKI2MhAjr1LZ4VnhaomSuXADZjavBbxdbIqrqagLc7aUhd0iSWqY4W7Hi+WB/tm5ZH1eu1K64BSz/6Iy6ipCEnlJBwdynyeeGg1Q8RGzqVIG2VYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789895684; c=relaxed/simple;
	bh=wQEzCUSivGHJ8c3rd7iLCcihTRKZrEeJA/Gr+Ea5/sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIPGSRRb4ZVcGwYAZnYZK9tiqnSBRCSHEsY4MTsUDMEJFyaDC0Mvmjb/tZ34tEaw68N3MaJfSWMmsfouwwB33LVHzmd+UzxKKj174J0+5/Z3TSmmonOlXoNRe5A4TgqCwyJa4h2U2Tucp8Gkx7/c+kQc3U3eul/oZ/OFmWq+3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZHBy0+b; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZHBy0+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789895683; x=1821431683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wQEzCUSivGHJ8c3rd7iLCcihTRKZrEeJA/Gr+Ea5/sI=;
  b=kZHBy0+b1gPGwkMZACLD3tmaF6CUaNXS/HfnItbc0wL391NVWiTSqleH
   Ejm67BzWMHVonjV0dPUa9l2NcPUhctuFY1tLBW/J4wCV7JFDDMSvz6ve0
   Yn0tgp8391FP68Ti7Uz3mV/C65cFXbJ2o2G72ocjZCft0OIUZmPkxW7TL
   vo2qvL8APZq1P9hULRyDO9I5NZL5HVaoDNi3a618UGq+PaGdtQ+KqTLHr
   mcx/B+C5WX0BiZ9CdZIaRKpiPQJAJH6OV6bPpDPW1JAS7aEVdmrA9ZP4C
   9j0SSCggqH2jhOWV6rkZBtN/ThDpWFIU1EvCY+lSiqHBfT0VatSOov2Jd
   Q==;
X-CSE-ConnectionGUID: d+MSlQbLQmGeXF4ezxXojw==
X-CSE-MsgGUID: VKmdeTNJQq+XjV28iUzGRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="905967"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="905967"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 02:14:42 -0700
X-CSE-ConnectionGUID: 86mLZJSiR/W+KT04aN9mQA==
X-CSE-MsgGUID: Zmx9090hSaSO9by6HGQ/Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="271357757"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 02:14:36 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Manish Honap <mhonap@nvidia.com>
Cc: alex@shazbot.org,
	ankita@nvidia.com,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alejandro.lucero-palau@amd.com,
	smadhavan@nvidia.com,
	pierrick.bouvier@oss.qualcomm.com,
	mst@redhat.com,
	imammedo@redhat.com,
	anisinha@redhat.com,
	pbonzini@redhat.com,
	eric.auger@redhat.com,
	peter.maydell@linaro.org,
	richard.henderson@linaro.org,
	clg@redhat.com,
	cohuck@redhat.com,
	kjaju@nvidia.com,
	vsethi@nvidia.com,
	zhiw@nvidia.com,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	linux-cxl@vger.kernel.org,
	skolothumtho@nvidia.com
Subject: Re: [PATCH v2 10/10] hw/pci-host: Emit a _DSM on pxb-cxl to preserve firmware PCI config
Date: Sun, 20 Sep 2026 17:14:29 +0800
Message-ID: <20260920091429.717003-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916184412.3825713-11-mhonap@nvidia.com>
References: <20260916184412.3825713-11-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 00:14:12 +0530, Manish Honap wrote:
> under preserve_config, the _DSM. Gate the _DSM on preserve_config: x86 q35
> passes false as it does not use the accelerated SMMU, so it emits no _DSM
> and its ACPI tables stay byte for byte what they were.

Confirmed: on 28e7aad522 plus the series bios-tables-test passes on
x86_64 (q35/cxl and q35/acpihmat-genericx, the v1 failures, included),
aarch64, riscv64 and loongarch64.

accel=on is out of reach under TCG, so I forced preserve_config on virt
locally and booted an arm64 guest (7.3-rc1 based, defconfig) with a
cxl-type3 behind a cxl-rp.  With this patch Linux keeps the firmware
BARs and bridge window under the pxb-cxl; on 09/10 with the same hack
it releases and reassigns them.  No ACPI errors either way.

Tested-by: Junjie Cao <junjie.cao@intel.com>

08/10 still says the x86 bridge "still emits the ``_DSM`` method, but
its function 0 returns an empty support mask"; that was v1.

Junjie
