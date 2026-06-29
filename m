Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04EF282F3B
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756015; cv=none; b=LpT8Yqo/u6KcQG1MhK6CHFvpY9LKzY5vEVgP2FhNddHcg+IwWl45kjnNtuXKhortvKFIK7hmHvJIHIpsY1vpYRLfSYZRt8X1dDs+RjQkgQXLctJJGeOmZ7aePv/tAKGPj7bsY5SOTyQZ1rkT1bf5UUiRKpnuOwJ3MyfXNL6HSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756015; c=relaxed/simple;
	bh=GgjoCr0XZew2P+fEafCKkHSU/t8kvwCinu0GLqk4O9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FccJ0aBz/aFeIHFo5ixYHj2bIXgNBZhtmfencUeTG9l20HigqAcfnWUVhRWc+1bGe8Fe/7Na7sJYAjKnYvTp0W33UJD2THQKgQnal5Zuf/s+CcSpsdY6g34YYaTaTfYB62KtnCAuavoZyha370jVz1jY9EyiS1438wztDD6v2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdM0v+Gi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdM0v+Gi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782756013; x=1814292013;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GgjoCr0XZew2P+fEafCKkHSU/t8kvwCinu0GLqk4O9M=;
  b=IdM0v+GiJ4r8b5xwNdgwFcjZq3KHqqVxFIiRkz7krfMbg7lQpixVUe/k
   IbYq/5eoceZngChMhwnacq0saAb7hk2QeedzqWe0LX9qlQUqEzeJ9k+oh
   qoYV6DYFFoTuoL4KosvJY89n9uaC8uYsKYUV3K3IhQ+d/PDsXOO6QKZu8
   1K+7EaI2JC4tX9C8olA+raGYzDuWCN7+uIuJOlk9IfzN48OKbNwjpDT+x
   GjxuCsea84PpFca8q6jCxxPq7qqDrHLoXHMCAWWNt+dlJSekO7bGyaxM/
   L0pABB/ncBNfDao3IjV2wPF2vb1Z8nANebQrvHSxg/jmn66zN0pzH7fc6
   g==;
X-CSE-ConnectionGUID: E2YB/kSjSKKNpAK9QGuC9w==
X-CSE-MsgGUID: lNMRnaE7SfWWvSm930fVBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94607907"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="94607907"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 11:00:12 -0700
X-CSE-ConnectionGUID: ukhMGeh4QTanLUa8dXEaLA==
X-CSE-MsgGUID: tmD2zBYjQEajZaf6AGntMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="245674192"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.194]) ([10.125.109.194])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 11:00:11 -0700
Message-ID: <b36448e7-134f-4dce-ba00-e7d3e97792be@intel.com>
Date: Mon, 29 Jun 2026 11:00:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 0/2] Type2 device basic support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, djbw@kernel.org
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260629183727.51502-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260629183727.51502-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/29/26 11:37 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> This series adds the last bits for allowing a CXL Type2 driver to obtain
> a CXL region linked to the device HDM decoders committed by the BIOS.
> 
> For the sake of merging those changes and the driver using them, this
> version only adds the changes without a client. A later series will
> include sfc netdev driver as the client.
> 
> Changes from v29:
> 
>  - Only cxl core changes.
> 
> Changes from v28:
> 
>  - patch 1:
>         fix doc (Ed Cree)
>         fix error path (Sashiko)
> 
>  - patch 3:
>         removing extra + char (sashiko)
> 
>  - path5:
>         remove stray change (Ed Cree)
> 
> Changes from v27:
> 
>  - patch 1: make driver probe failing if error in efx_cxl_init (Dan)
>  - patch 4: add unmapping if error after efx_cxl_init (Dave)
>  - patch 4/5: move cxl_pio_initialised from patch 4 to patch 5 (Dave)
> 
> Tested in the cxl_for_7.3 branch.
> 
> 
> Alejandro Lucero (2):
>   cxl: Support Type2 cxl regs mapping
>   cxl: Support dpa without a mailbox
> 
>  drivers/cxl/core/core.h   |  2 ++
>  drivers/cxl/core/mbox.c   | 51 +----------------------------
>  drivers/cxl/core/memdev.c | 67 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c    |  1 +
>  drivers/cxl/core/port.c   |  1 +
>  drivers/cxl/core/regs.c   |  1 +
>  drivers/cxl/cxlpci.h      | 12 -------
>  drivers/cxl/pci.c         |  1 +
>  include/cxl/cxl.h         |  2 ++
>  include/cxl/pci.h         | 22 +++++++++++++
>  10 files changed, 98 insertions(+), 62 deletions(-)
>  create mode 100644 include/cxl/pci.h
> 
> 
> base-commit: 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686

Immutable branch created:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.3/cxl-type2-support

96ddf1af34f5 cxl: Support dpa without a mailbox
2c599da8231f cxl: Support Type2 cxl regs mapping

