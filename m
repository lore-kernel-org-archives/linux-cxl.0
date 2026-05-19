Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31BC1A316E;
	Tue, 19 May 2026 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155723; cv=none; b=KlibO5KXoPAeirOYl4pJ4m97Z7b3mPiC4OzzW3pYaEqoHTqPmJ7pBKUd91ohthIokl0vB6jxphTEkwFe3pzWwC1TIEAvahxqBCQCV/KfEcKnnv7lHtFxcxtYTLgOcAFqNdOpcl8o7zLe5OvIKoMBVvFJ0UgQGHWRGRDbE4pJ6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155723; c=relaxed/simple;
	bh=RAymXeKU5Z0zpRr8xspEfpXYkFHTpWACFm2tZSsga3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0ChmgF/3i20d9saGZeole7tYemGkmlLp0aOWA843Sd2NgNZBA0sTtomFibM4OcAofH3RSyOPxYGuwsV+ix2ctJYnD/qPsu4Cjxj5qLk6NAJp8+fRu5OBLDwzLCKMiFgOrLu0S/pI6FW17HK7YCxMoSO2oN0auUrm50G0Cyg4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JJqQS18N; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JJqQS18N"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779155713; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oAqRPPQULRogVXAfTFLdYKrqv8BiB6dRDQ4TIjSB0Xw=;
	b=JJqQS18N/0lQ72tyPy51SbEh8ZRmnPKJ/eNx2DJ3n/VVLbdzkcR9vy52ZxOKdL2GQZc3N9dch3fnz6dUIYr7IltWss//hlOkB/CLZWGWcMZ53AHCZlhYGrtXXSuhGZKoisjT6XFQcAe/e3m2x2iZhVmpR2aL4I33v964bJt9tbk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X3DqODE_1779155708;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X3DqODE_1779155708 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 09:55:12 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: djbw@kernel.org
Cc: alison.schofield@intel.com,
	cp0613@linux.alibaba.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	guoren@kernel.org,
	icheng@nvidia.com,
	ira.weiny@intel.com,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] cxl/acpi: Defer probe when ACPI0016 PCI root bridge is not ready
Date: Tue, 19 May 2026 09:55:08 +0800
Message-ID: <20260519015509.4699-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a07730211b81_a6174100c8@djbw-dev.notmuch>
References: <6a07730211b81_a6174100c8@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 12:24:50 -0700, Dan Williams wrote:

> If the platform is defined to defer PCI root scans then this dependency
> must be declared. Specifically firmware needs to tell Linux about the
> dependency given it does not order PCI enumeration before ACPI0017
> enumeration by default. Something like: 
> 
>   Device (CXLM) { // ACPI0017
>       Name (_HID, "ACPI0017")
>       Name (_DEP, Package () {
>           \_SB.CXL0, // ACPI0016 host bridge
>           \_SB.CXL1,
>       })
>   }
> 
> ...in the firmware, and then:
> 
> acpi_dev_clear_dependencies()
> 
> ...for each acpi_pci_root_add().
> 
> Then ACPI0017 will naturally await all of the ACPI0016 devices that the
> firmware knows about.

Hi Dan,

Thanks for the guidance. The _DEP approach is clearly the right way
to handle this - it's the proper ACPI standard mechanism for declaring
device dependencies and avoids the permanent defer risk that Dave and
others raised with the EPROBE_DEFER approach.

I plan to abandon this patch and implement the _DEP solution instead.
Let me confirm my understanding of the two changes needed:

1. Firmware (QEMU DSDT): Add a _DEP package to the ACPI0017 device
   that references all ACPI0016 CXL host bridge devices in the system.

2. Kernel (drivers/acpi/pci_root.c): Add acpi_dev_clear_dependencies()
   at the end of acpi_pci_root_add() so that once an ACPI0016 device
   is bound, its consumers (ACPI0017) are notified and can proceed
   with probing.

Is my understanding correct? Any other changes or considerations
I might be missing?

Thanks,
Pei
