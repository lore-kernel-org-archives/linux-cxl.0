Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B59175A75;
	Tue, 19 May 2026 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155422; cv=none; b=todOqUa38Y8OJl11wB1GaiU5xHvqUJijKbzaVO7Y3etuS4WfAvYPQ9tDmtHR0CD2z6WP218w1GMtsCy2HE1iLugGkyA7MlaXw/EqSE9B4JacNOCxaZo71LwFDpmoNiegm5UD3PPO4Qc0O7OcSKCPeFEWfKXhDOMHvDVnWHlRSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155422; c=relaxed/simple;
	bh=I/cMNwBEIDy4PLWIshjQmY9M7X1fjKtUolTHD6Eeq5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrlFwJpXEYqfHyEnOHA1B6iEdnKTFBQmx3U1tsQ+0KiV6dO0HH+XIfRVtei0w0YSIWae8azES1DUAz/89Xh664idOL4XFzL0vhxynMK5sxi6SpDiI9OxAS7c5YdITrj/hVoFGl02uu7hrJuIiCV9lOYdELZtDUvEdGEMTrBwaBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wAIeFoVH; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wAIeFoVH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779155417; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SkY5m0zky7iF/22mCBa3fiAF8zX6wgRiaVE0furbD5Y=;
	b=wAIeFoVHFgG/jjbRO6FusnihzbsyS7s0XmeZzsfdf9M9YsfkYzUjexZnHmrmbOSSNmVi3AdRXWjHodzRkpu7jNPmkocULSoEO4pqjdpJ28yakerZC4it22N6CJGdsc2e77Aa/T1k0MIGAuG7CokJQPz1+dgISdO675ZInYJflNY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X3DrsDH_1779155408;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X3DrsDH_1779155408 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 09:50:16 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: dave.jiang@intel.com
Cc: alison.schofield@intel.com,
	cp0613@linux.alibaba.com,
	dave@stgolabs.net,
	djbw@kernel.org,
	guoren@kernel.org,
	ira.weiny@intel.com,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] cxl/acpi: Defer probe when ACPI0016 PCI root bridge is not ready
Date: Tue, 19 May 2026 09:50:09 +0800
Message-ID: <20260519015009.3430-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4ad8feae-6fc7-4e9d-8509-c9cc365d1c53@intel.com>
References: <4ad8feae-6fc7-4e9d-8509-c9cc365d1c53@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 08:38:01 -0700, Dave Jiang wrote:

> I would leave the assignment of 'hb' as is above and just what's below
> after looking at to_cxl_host_bridge() function.
> 
> if (!hb) {
> 	if (!acpi_pci_find_root(adev->handle)) {
> 		...
> 		return -EPROBE_DEFER;
> 	}
> 	return 0;
> }

Hi Dave,

Thanks for the review and the code structure suggestion. I agree that
nesting the check under `if (!hb)` is cleaner.

> I am concerned of other failure cases that causes acpi_pci_find_root()
> to fail beyond the driver not being attached. Will cxl_acpi probe() be
> stuck permanently in the defer probe queue when that happens? This is
> also something that Sashiko raised. Is there no way to adjust the
> RISCV ACPI setup to go around subsys_initcall()? That would be
> preferred solution.

You raise a valid concern. The EPROBE_DEFER approach indeed risks
infinite deferral if acpi_pci_find_root() fails for reasons other
than the driver not being attached yet. This is a fundamental
limitation of this approach.

After considering the feedback from you, Sashiko, and Dan Williams,
I plan to abandon the EPROBE_DEFER approach and instead use the
ACPI _DEP mechanism as Dan suggested. This is the proper ACPI
standard way to declare device dependencies:

1. Firmware side (DSDT): Add a _DEP package to the ACPI0017 device
   pointing to all ACPI0016 host bridges it depends on.

2. Kernel side: Add acpi_dev_clear_dependencies() in acpi_pci_root_add()
   so that ACPI0017 will naturally wait for all ACPI0016 devices to
   be ready before probing.

This eliminates the permanent defer risk since the dependency is
explicitly declared by firmware and resolved by the ACPI core,
rather than relying on runtime probing heuristics.

I'll send a new patch series for this approach.

Thanks,
Pei
