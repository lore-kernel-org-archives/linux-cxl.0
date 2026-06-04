Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEB22083
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588636; cv=none; b=Y0EMdxC4y9j+QsxvIgEORos/utp/iJM+QN22XuDR0QgRA4WptI14vVrRPgzG+NRAojO9AROPg39mXgMq0Ua+5At+/OABC0YEhTsTzVr9v73Lt+NV5xwLIsXgc1CnWSiuNhTlD7eWDCiiAEqgdrMH8v6O3z/K16cMLWi4oNyWbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588636; c=relaxed/simple;
	bh=n2k90DlD8o/Ce8txLFUyS2MK18MUocHEdP/K9A8xekQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCocQluasmAOiELigXL3Rj+OziwPvJODiKMWnS8AIdwuQUk9QODstv7U15/aUFgAAKnN4igY80mm2GFu8Za9NK6hj5Wm+CfO/tC6PMgn7qU5jG7Yfg4Piz0DfiN7DtmnC9TXYn38L+iaA+KsaHLpCndzAvmn/cpM4EHoXmrf0bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akCoqhRL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akCoqhRL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780588635; x=1812124635;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n2k90DlD8o/Ce8txLFUyS2MK18MUocHEdP/K9A8xekQ=;
  b=akCoqhRLP6LInw7fskoGY+HP5UD/dvTSNUGCfMf4FCzV3nfPTd4GYY6P
   DXgyNI1p0g4SOi4pTNRjfu70VIO1f/AipeFDeFa5T2ViiYza04O3/XJeV
   98u/yrBTTimpQTj1jdMAGpMfAphPybcW8hu/QtgnGaAWL4yJw1H42AIn+
   8Mp+zTx0Z+96ZFmxYXZI/Ps738kZNda9aDM1jIyzjkIFyF5OzUWRUfPRS
   mpx/b7qT/TVGqBbH6fsbu9IKUoMVZ74qfK10Ob+E4Ve2Q9bL8NbME7RVr
   qrNfO6y+bnnA7yu5xOcpwHerQfIT3VwYcrDaB5SoKLnn+EuEkOrYtkmzS
   w==;
X-CSE-ConnectionGUID: QUDS3PuCTd2LrOwjGpGrVA==
X-CSE-MsgGUID: RWVNMK1TSYqokkv3T817gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="83994672"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="83994672"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:57:14 -0700
X-CSE-ConnectionGUID: vJs0MaGtRvC747iQELng9Q==
X-CSE-MsgGUID: 2g+u0TYaTt+Yr/SqO+YvqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="248926086"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.108.206]) ([10.125.108.206])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:57:14 -0700
Message-ID: <2eaa4608-d9b6-4b92-b3be-645c9b379469@intel.com>
Date: Thu, 4 Jun 2026 08:57:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cxl/pci: Fix the incorrect check of
 pci_config_read/write*() returns
To: Richard Cheng <icheng@nvidia.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, alison.schofield@intel.com,
 djbw@kernel.org
References: <20260603185752.4149725-1-dave.jiang@intel.com>
 <20260604111744.74cfc2bb@jic23-huawei> <aiFTbzlUZEr4UT6F@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aiFTbzlUZEr4UT6F@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/26 3:30 AM, Richard Cheng wrote:
> On Thu, Jun 04, 2026 at 11:17:44AM +0800, Jonathan Cameron wrote:
>> On Wed,  3 Jun 2026 11:57:50 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> The patches are inspired by comments from Richard Cheng WRT pci config
>>> accessors return PCIBIOS errors that are positive integers rather than
>>> negative errnos. I went and audited the cxl PCI code and found a few
>>> locations that need to be fixed. There are other locations that may
>>> trigger issues, but at this point we'll fix them as they happen.
> 
> Hi Dave,
> 
> Thanks for this, sorry I miss the email somehow
> I'll look into details later, seems reasonable to me from
> a glimpse.

Thanks for the review. Totally my fault. I think my brain said cc Richard when I was sending, but somehow I missed it.

DJ

> 
> Best regards,
> Richard Cheng.
> 
>>>
>> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
>>
>>>
>>> Dave Jiang (2):
>>>   cxl/pci: Fix the incorrect check of pci_read_config_word() return
>>>   cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses
>>>
>>>  drivers/cxl/core/pci.c | 22 +++++++++++-----------
>>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>>
>>> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
>>
>>

