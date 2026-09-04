Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EBC351C04
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503467; cv=none; b=qeqmkhiZG1WgBckB3wPHg6BQODGtpW1X2em7ja5WItbyx3173ssvZoGGKEYAmvPzxRHHH8ZQyIiowgmOcWaiwx+X4hHtconaFD29Xv/8Rw51c8fUbHLA8XJUWhxqcCkwU/X2cnwDYmp0HIfqhpKC7gL7kFR4L2RYXf3gLfwKo5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503467; c=relaxed/simple;
	bh=g2AjKxSiIsijcZ9uP88ts4IhbkRLkyXLcJ/QY4SUCRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seiETlykpyT6Qy5pzfT4yCjpGL/UT498FV8wji4SZGAC7GV75gxnVQ7PPEVQf6AajsZjih6UquGubnh9J5LWd40+MXeOcS43iYYNkwdF6WpN2LnK/Bh1cEZuN3xRStRxatlCcJaAB7RzeTD5Gfjbts2Ow43skIGFZkf6SIixSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d17I4kgt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d17I4kgt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788503466; x=1820039466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g2AjKxSiIsijcZ9uP88ts4IhbkRLkyXLcJ/QY4SUCRo=;
  b=d17I4kgtsn3N60ofcOoiEBmA0YguQxBuyxE0scfKhYtShyLYenAz+WF4
   gi94SLSE3YDbqPB9d+t/7yk2gdYsyr6H3DfED0avVWbuMRppjQ6hi+nMz
   aw/UNrxWn1XL8k2lXBXAyQVE5JMSsl85sQMjcqrD3VGrqWUPIKEwbtY7C
   DRmt1GXhbKuJLfk+9+FeOlHFVQ6KsCzb+vrvdx2YkCkSvHVXybebc4+81
   Y18tSpWmDxdVVZL/l6FtFZ7zlU4v7D3IHwhkUHG3s84iR3OVzjyXdwaiR
   FxpsnqJIEYbZAm3CZCRrcm3Q90b4Z4M6L+F2X4mbWdfvwceYB3g3qpNlt
   A==;
X-CSE-ConnectionGUID: lFX7TybmTASkF/5L3V4KzQ==
X-CSE-MsgGUID: Lz0nFPaZRRK47zlEEi++YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106520150"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="106520150"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:31:05 -0700
X-CSE-ConnectionGUID: 1lk6sE4JRyOhigu6dsCXow==
X-CSE-MsgGUID: vae/fAF+T9eWnJJPdFZ9KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="266697854"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:31:00 -0700
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
Subject: Re: [PATCH v5 1/6] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Fri,  4 Sep 2026 14:30:52 +0800
Message-ID: <20260904063054.452316-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831132340.5345-2-cp0613@linux.alibaba.com>
References: <20260831132340.5345-2-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Mon, 31 Aug 2026 21:23:32 +0800, Chen Pei wrote:
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>

Tested here means the generated CEDT/DSDT with one and two pxb-cxl
plus the riscv64 qtest suite, on 99e54ab5e7 with the 5/6 paths
renamed; not a CXL-aware guest.

Many thanks,
Junjie
