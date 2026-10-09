Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9F3630BA
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582491; cv=none; b=RXDDMDw5JmE5646bvkg1JfESgxnBDISzpvIgewIafwrC+Vm3aF7LOvzruLXnADZcV0RiU3nlXWl0aVfqEEuQ4aDwvk0P5bWKOD6UY6RvY/gNdQJe9bA5b1opfldqE/+VNcjoftzXfzALlQ1FyMaMPigtcAS9X3JX+ZfuQEeRuEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582491; c=relaxed/simple;
	bh=M6Yo4YjupPFFGkNgRoo0qhpS7nKkMvig0vyUPvYls8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtISPRriGLphj5t+NLFhev4JLUnkArmMGIiU4qXgsBWnRj4Hmed08Ig6zDWtZ4ksawbASYJ1iTQd5jTEr4A+Pzt2UfTWBdsghIMKZeHvrIDhlojUa/7p5olYIpEa7o0jcdhWeoqcXVcPYZikJq2lP4mel/YgW69ugKWvoPIAUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCPrDhJz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCPrDhJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791582490; x=1823118490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M6Yo4YjupPFFGkNgRoo0qhpS7nKkMvig0vyUPvYls8U=;
  b=oCPrDhJzETEOUtPYJfc0KmCJD4RM8bpLftiqcwkFDabbreex7qK5sB+V
   V0Zp5M3fCOjDz4qAcRllaDY119bly9qqW8YQXtnwHgS9Enk+EUwVFDEI+
   WGl9sY/Dtlz+HOCl7WzpAgU8Vx2VHzUu0ZwAurEmKseMCUSq5wQ35nR5U
   SpHOC7FeHQ7k0ACiuco+zg2PtmHS+aMnpejm7C/wUS5B2Zustg63ob3OW
   nTM6zIyDs3DMQLPWX5X+vRYGjY67MPdUK7kfejC5Hmn0SCxa32yH4nuih
   4ppzJ/l5/MDqbnvqCkbfLuQbRchGgPuRXiCYScBa6dNAEEc7AKkojR+cP
   A==;
X-CSE-ConnectionGUID: aEMIYF6uRdu2GkYLszkQRQ==
X-CSE-MsgGUID: 6JdTZx2/R2qPEkfklgHP1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="275118"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="275118"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 14:48:09 -0700
X-CSE-ConnectionGUID: Od40VP8eQnO2wAxg2ParVQ==
X-CSE-MsgGUID: S5eFfTB6RnuNO+1a+xPajQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="341694"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 14:48:08 -0700
Message-ID: <9ee576b5-c719-4e10-b4ea-b90f9f99529e@intel.com>
Date: Fri, 9 Oct 2026 14:48:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] cxl/pci: Fix the GPF DVSEC setup path
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20261008034619.28059-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261008034619.28059-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/7/26 8:46 PM, Guixin Liu wrote:
> Three small fixes for the GPF setup path in cxl/core/pci.c, found
> while reworking the same area for a downstream backport.
> 
> Patch 1 is the one with user-visible impact: on an RCD the GPF DVSEC
> lookup takes the port path, so dirty shutdown tracking never arms and
> the count stays invalid. The other two deal with error handling and
> a full-register rewrite of the phase control register.
> 
> Testing on a QEMU CXL topology, with the patched cxl_core hot-swapped
> in and the topology re-enumerated. With the phase 1/2 timeout
> registers of all four dports (two root ports, two switch downstream
> ports) zeroed beforehand, every dport came back at 0x0702 — base 2,
> scale 7, the same value the unpatched code writes. So the timeout
> write ran on each of them: the read-modify-write of patch 3, through
> the error-checked setup of patch 2. With the registers left at their
> programmed value instead, the setup takes the "already at max" early
> return and writes nothing. Re-enumeration comes up clean, all three
> memdevs back.
> 
> What QEMU cannot exercise: the topology has no RCD, so the RC_END
> branch of patch 1 never ran — though the emulated type-3 devices do
> expose the Device GPF DVSEC that the fix selects for a restricted
> endpoint. A config write to a live DVSEC does not fail, so the error
> paths of patch 2 stayed cold. And the phase control register defines
> no non-timeout bits today, so patch 3 lands on the same value the old
> full rewrite did.
> 
> Changes since v1 [1]:
> 
> - Collect the Reviewed-by tags from Jonathan Cameron and Dave Jiang
>   for patches 1 and 2 (code unchanged).
> 
> - Rework patch 3 to use a pair of FIELD_MODIFY() calls instead of
>   clearing and setting the timeout masks by hand, as suggested by
>   Jonathan Cameron. The generated code for update_gpf_port_dvsec()
>   is identical to the manual version.
> 
> [1] https://lore.kernel.org/all/20260922100026.3742401-1-kanie@linux.alibaba.com/
> 
> Guixin Liu (3):
>   cxl/pci: Use the Device GPF DVSEC for restricted endpoints
>   cxl/pci: Program the Port GPF timeouts before caching the DVSEC
>   cxl/pci: Update only the Port GPF timeout fields
> 
>  drivers/cxl/core/pci.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 

Applied to cxl/next:
b5d14009bdb1
ec2e30a68294
d2654fa0d841
