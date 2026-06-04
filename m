Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC13BBFC2
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780614646; cv=none; b=c3I8yTBSYCh1Kn1wpgpSKW7E2qCPkDOS+ufIr3sTUcGd0X3xRINr7hA7CHSV4YUBlXwQ9iEvL+fzdgVe/mTR2nhzZem7r5cNzPOsT14rpnrR9pqDBgmFAkYE6mAuEClBHCdzj4P61TezKDjdmvGU5n/vWfn/AvebfFIav0sR+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780614646; c=relaxed/simple;
	bh=BvACMkkm9xLHTU9jZuzazwbp2PVjJm5sa9CfnVSUNCE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mAWmJDjxKDgR8fiQdoATDB89Ql3lvJqpGPKCRHRxIO1AJ3ih1DPmGWuP+pS2+gjmgcekRKVQz8j0jrknn9OualrA4SijhWXVMhweIjAsE5WTEJJXauFntU/3b5AJMUIB0INm9B9jB3BcllpPs/UFhZd0HdTDaN+YJaHRnKUC+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8ZH4Z+E; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8ZH4Z+E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780614645; x=1812150645;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=BvACMkkm9xLHTU9jZuzazwbp2PVjJm5sa9CfnVSUNCE=;
  b=T8ZH4Z+E/Il2hjuhG61w/Tr/m+iTf5am05U1EfT5gP35Z6JwT+CeiF8X
   KKqYrwfyuSrqH19aK/D4wm/1OOimLwDGP3Xu0Y19hS6xp1ltk3n9MBqPY
   1Zv8CYGrEVeGez5X3P3bzQ2e6IzUVDmmbBSFoX5kmWMFl1UnsjIXrB3EX
   A0MGjVkASyrU7DtqQIApvhPfQm080jHfRj9wu84+HTedBLyVwLP5VVc7t
   7DEsewKljfg3zYy52kjBtfRq7zt5yo5kEGHpIoG/qTj0KolOrn1b3vBfY
   zxpad5koCGa2LerkCkNoN2YihRjU8gvSFUd+lxreNjB5V8NQTaWzSqenx
   g==;
X-CSE-ConnectionGUID: NuuVbspeQv6T9VgHnrCFvA==
X-CSE-MsgGUID: +en+/5o8TC+t6YtW/6UfaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92934408"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="92934408"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 16:10:45 -0700
X-CSE-ConnectionGUID: ITOHcaSzS4O5eUVBTlxxJw==
X-CSE-MsgGUID: CEkUnAy0Q12IigQbZAy55Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="274932280"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.108.206]) ([10.125.108.206])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 16:10:43 -0700
Message-ID: <f70b45b9-1ff0-4cee-baa5-ad72fed4d944@intel.com>
Date: Thu, 4 Jun 2026 16:10:42 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] cxl/pci: Fix the incorrect check of
 pci_config_read/write*() returns
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 djbw@kernel.org, icheng@nvidia.com
References: <20260604180154.1925149-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260604180154.1925149-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/26 11:01 AM, Dave Jiang wrote:
> v2:
> - Fixed up additional bits (Alison)
> - Fix up fixes tag (Alison)
> 
> The patches are inspired by comments from Richard Cheng WRT pci config
> accessors return PCIBIOS errors that are positive integers rather than
> negative errnos. I went and audited the cxl PCI code and found a few
> locations that need to be fixed. There are other locations that may
> trigger issues, but at this point we'll fix them as they happen.
> 
> 
> Dave Jiang (2):
>   cxl/pci: Fix the incorrect check of pci_read_config_word() return
>   cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses
> 
>  drivers/cxl/core/pci.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> 
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8

merged to cxl/next

66782cfa0085
26aa60e02762
