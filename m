Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB347F2F0
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962720; cv=none; b=Q7tUo7SUBtXNdw6YbBBnj5par06r5w0FYJHigaTX5fDzOlciTci6/RaKG/Jzu8bxPX/zsxYxs0XuVvfS4E+Cu7pMI+uNLKaLOOhB2iM1O54CbznHQVZhUqxDuyEcUHi451VT9UI2xuQ6qawtDAUYv5h/CAPSzFqksMVzcdbfeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962720; c=relaxed/simple;
	bh=HB2AeqY8zyGKCQXXYQCNs3hQpoOQdZEHzmmlU3xJ0aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FK1MimQxhWUG+D4hNDoPNympQmZ3cJot5MMrh0oBFwx7qbDgazPkSwvUn4SDwG+W9Kjwt+8dWxlWVpWWug4doe9mN0Xw/kmWLyHJrl1M8Y6Lu3Ae/mbWwA2tEEruPX0zlOZyJxS59JnDrySPcvE01RtIH0pAgOjCyVpTtu7S2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4zS4zYe; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4zS4zYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785962718; x=1817498718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HB2AeqY8zyGKCQXXYQCNs3hQpoOQdZEHzmmlU3xJ0aE=;
  b=S4zS4zYeLZ2e+LHJzskNI+iOF07h07Q91W0XUhdnq+e9mQ4O5PRkimmg
   dGxygMLzSKl/srifL4TCDC4Kxh8k8M2i6sTJzKzaX/dB+7+6PSbnwXqtd
   QunPwb3kXJlYnQQIRSnlyXYLeMmyfNMwo2mfpgZALpli64AvjtluBMPBV
   McVS9VShxWQKB4ftogbbWSKtpRoM85yciCFvnFHUfFRGOohgdJi2xcshv
   XHm9+LMML1s8QcbfsKAIPe0fuEYE9FDA3K3tL+xdb2T//2GOCcpa06SGM
   mp2dj8uimQyh386t3DwknzAsGBSt6Znzaix2FjMR6Dz/9HHpCkk1qiO0c
   A==;
X-CSE-ConnectionGUID: TIg0yM+LRJuzNPQAMJU78g==
X-CSE-MsgGUID: 9st+OLOhSpOyDnraup5vpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109337787"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109337787"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 13:45:18 -0700
X-CSE-ConnectionGUID: unp0uaIAThKCfS3CMoii0w==
X-CSE-MsgGUID: I8UGSxw/SsCCYgPXSQZmrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="261367175"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.42]) ([10.125.109.42])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 13:45:17 -0700
Message-ID: <49b31b40-b170-493b-9398-aee5de19c4a1@intel.com>
Date: Wed, 5 Aug 2026 13:45:16 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] cxl: Format the device serial number as unsigned
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1784924949.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1784924949.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/26 1:37 PM, Alison Schofield wrote:
> 
> Changes in v3:
> - PATCH 1 commit messaged updated with link to work-around direction
> - No other changes.
> 
> 
> This series supersedes the previously posted standalone fix:
>   cxl/pmem: Format nvdimm serial number as decimal
> 
> That patch addressed the immediate auto-unlock failure caused by the
> kernel formatting the nvdimm security key description differently than
> the decimal 'id' sysfs attribute used by ndctl.
> 
> Further review uncovered a second formatting issue affecting the same
> serial number. The CXL device serial number is a u64 PCIe Device Serial
> Number, yet several kernel interfaces format it with signed "%lld".
> Devices whose vendor OUI sets bit 63 therefore appear with negative
> decimal serial numbers.
> 
> Serials with bit 64 set are expected. The most significant byte of the
> PCIe Device Serial Number contains the vendor OUI, so vendors such as
> Montage naturally produce serial numbers with bit 63 set.
> 
> Rather than merge the decimal-format fix and immediately follow it with
> another patch changing the same code to "%llu", fold both fixes into a
> single series that consistently formats CXL serial numbers as unsigned
> where appropriate and adds cxl_test coverage for the large serial case.
> 
> 
> Alison Schofield (3):
>   cxl/pmem: Format the nvdimm serial number as unsigned decimal
>   cxl/core: Format the memdev serial number as unsigned in TP_printk
>   cxl/test: Assign one mock memdev a full-width serial number
> 
>  Documentation/ABI/testing/sysfs-bus-nvdimm |  3 ++-
>  drivers/cxl/core/pmem.c                    | 10 ++++++----
>  drivers/cxl/core/trace.h                   | 10 +++++-----
>  drivers/cxl/cxl.h                          |  3 ++-
>  drivers/cxl/pmem.c                         |  2 +-
>  tools/testing/cxl/test/mem.c               | 15 ++++++++++++++-
>  6 files changed, 30 insertions(+), 13 deletions(-)
> 
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

Applied to cxl/next
94d84e3d8959
95a84b7cb4bb
8a80d3d65cd0

