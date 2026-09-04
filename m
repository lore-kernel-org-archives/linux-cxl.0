Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA06357CFE
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503487; cv=none; b=OUjIkN3/0baNLWpHQZfvmXNf6bXbOxxDOlEVevJoN6ifplTIlKepUdc4tuDmrNza4arERu9ley7kyLksuKUG6uPcXcFC1XfcuP35WNaDIIjkMmXCpWOLD10drt1yaRR70o9l4McC2JDP2NC6HxgQ75WGJAMXKiwGIc+mFPt+kqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503487; c=relaxed/simple;
	bh=11jAH+UdxIuvAgNHcn0v9by3IYDSKRv4sbKpNUWVv5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMNnRSVz73GE6cYx83VjSDTQOYYe3ZtZ5/Bkr2et+Q0bCRwdnZcAGs2WuTU+eyxzkYNNQAA35E/GKbniUirn928AjXfdpqlL2WlAR80mjhZJY1smtTPPkUMpVOvTGMxbWPztkGsJXxgUOiUH//lYHPfPHRxFTQppCVbLzLC5CpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWculsSY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWculsSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788503485; x=1820039485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=11jAH+UdxIuvAgNHcn0v9by3IYDSKRv4sbKpNUWVv5Y=;
  b=DWculsSY2Yy02mv84rYTfKKdaV+0R5mJPxuT5MXJIZqbWrXxka1y+cTC
   mF7knivMhF9UWe7Nvc5v2ZwhTsnXOni5sI9IVu4PKHXqoMMmFP/74QjpX
   aO0WXw68iZ0MDFuKzWzGf9kzmy9bD1oGRTkYBTwlpFAqbiLIGvc3xb17B
   ihoiYp1f6lUp8abt8f2DjUB5auNRPhTHB6Nh7yiWVZV5HbFtdRfgBoCeI
   X6gZ90LlObmPaRlmN+hiKZdoDDB9S0aRPMBUuNpDsR805Eu2A5jsYjiO3
   O1hcU8tinTzNlddbR0avBFYm3ejMxM3CX52O6+40xxSBDoQQEcypVznhN
   w==;
X-CSE-ConnectionGUID: ONkJ32ZERYWdOavkzAqC8w==
X-CSE-MsgGUID: a3PKXW4TSKG1FFNGgaTGgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106520166"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="106520166"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:31:24 -0700
X-CSE-ConnectionGUID: dcRThzp1Q8W9ihozM0WyPQ==
X-CSE-MsgGUID: 7fveJ5ZzSt6vup/xczTW+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="266697877"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:31:20 -0700
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
Subject: Re: [PATCH v5 2/6] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL host bridge dependency
Date: Fri,  4 Sep 2026 14:31:11 +0800
Message-ID: <20260904063112.452333-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831132340.5345-3-cp0613@linux.alibaba.com>
References: <20260831132340.5345-3-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Mon, 31 Aug 2026 21:23:33 +0800, Chen Pei wrote:
> This pairs with kernel commit 3a59c3b772e5 ("ACPI: PCI: Clear _DEP
> dependencies after PCI root bridge attach"), which calls
> acpi_dev_clear_dependencies() in acpi_pci_root_add().

One comment on the commit message: the kernel side is really the
pair 3a59c3b772e5 + bf5418a5fe63 (both in v7.2). Without the second
the _DEP is simply ignored, so the deferred case never happens. Worth
citing both.

Reviewed-by: Junjie Cao <junjie.cao@intel.com>

Many thanks,
Junjie
