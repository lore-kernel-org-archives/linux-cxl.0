Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29547ECD2
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589456; cv=none; b=dAY0XqWySN1s5lnXppIcoOdLStZo5Y7T8YxwNJNimasqmMU+qDeuhz3sxNFUGOMPekbTFqf1Vor9z77eG1pQdHm3quQhxtDc9Q5yvA0QGoI02PFahs0NYlLpT5hhFq+1by5DPL6B6ASsnDoJCNcUIPx2Mr/PeMr2MSD5EzolcYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589456; c=relaxed/simple;
	bh=DJnaINPXGCirJBK3jv5HWQSflHIsEnbCj76xkv9UpIM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OHXkXIyDM2XibnJU5SOzzGS5GBd1FgIeQrMJU28NNF+N2W0Tma5KyDXL3i6DncctgfVuMNBeOhvT/ANzvx6DqRvzCsd6kV9NZvpJpGvOI33Lo5DSWWhcp8INEZe/d3L0xngVmFHYoUtz0z1ZzmIrM3oV9PtLB86Bg93bNU6rCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmpmI/IX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmpmI/IX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780589454; x=1812125454;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=DJnaINPXGCirJBK3jv5HWQSflHIsEnbCj76xkv9UpIM=;
  b=CmpmI/IXA1do3VzVabmPvXp2XBpt5lrcDBGdl0Tf3xLb6/K9bYsl6Gfa
   81HYvf/qP/DuHnouCofAunvlRFaIFQ4sEq2iMtbnDtWRP4MVTNJwR8lBH
   vrHyyfzVzHffwGWVwRsgmICDBb+qjukC8pB3QQXCFOaIndV21HNdMWcMV
   12sMqAUwpi1Kj2+19FVCXOT5SYIWlHqYHXT082iLTxNddDBTAqli2k8Xe
   b5uXLgoagftkP++rfYQ007cZiuQkaWWjaMHZWHOkOPLwcqJFKatwS6ao/
   n/0lih5PBq0BrFURnvhWFPowZKVXZyq8o79f469u2T+lnaK6Xkt61CGC3
   g==;
X-CSE-ConnectionGUID: uA/jQYVNQPCoEJWeh2tlow==
X-CSE-MsgGUID: 5z4972/oQxiDMO8tv6zyWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81602716"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81602716"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 09:10:54 -0700
X-CSE-ConnectionGUID: QKmbxBCcQRmk4Usxof8eUQ==
X-CSE-MsgGUID: FjwH76ZFRT+M+yOoL0xDlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="242102475"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.108.206]) ([10.125.108.206])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 09:10:53 -0700
Message-ID: <b3130f10-217a-4614-86a1-ad4dce656c38@intel.com>
Date: Thu, 4 Jun 2026 09:10:52 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cxl/pci: Fix the incorrect check of
 pci_config_read/write*() returns
From: Dave Jiang <dave.jiang@intel.com>
To: Richard Cheng <icheng@nvidia.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, alison.schofield@intel.com,
 djbw@kernel.org
References: <20260603185752.4149725-1-dave.jiang@intel.com>
 <20260604111744.74cfc2bb@jic23-huawei> <aiFTbzlUZEr4UT6F@MWDK4CY14F>
 <aiFXjmEsg1-_6EtP@MWDK4CY14F>
 <7e72a70e-2f59-40b7-a3c1-9a9b5ac62b30@intel.com>
Content-Language: en-US
In-Reply-To: <7e72a70e-2f59-40b7-a3c1-9a9b5ac62b30@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/26 8:58 AM, Dave Jiang wrote:
> 
> 
> On 6/4/26 3:51 AM, Richard Cheng wrote:
>> On Thu, Jun 04, 2026 at 06:30:48PM +0800, Richard Cheng wrote:
>>> On Thu, Jun 04, 2026 at 11:17:44AM +0800, Jonathan Cameron wrote:
>>>> On Wed,  3 Jun 2026 11:57:50 -0700
>>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>>
>>>>> The patches are inspired by comments from Richard Cheng WRT pci config
>>>>> accessors return PCIBIOS errors that are positive integers rather than
>>>>> negative errnos. I went and audited the cxl PCI code and found a few
>>>>> locations that need to be fixed. There are other locations that may
>>>>> trigger issues, but at this point we'll fix them as they happen.
>>>
>>> Hi Dave,
>>>
>>> Thanks for this, sorry I miss the email somehow
>>> I'll look into details later, seems reasonable to me from
>>> a glimpse.
>>>
>>> Best regards,
>>> Richard Cheng.
>>>
>>>>>
>>>> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
>>>>
>>
>>
>> The series looks good to me. There is still some minor cleanup left — 
>> for example, cxl_dvsec_mem_range_active() still has the same problem.
>> I plan to send follow-up patches for the remaining sites unless you
>> prefer to fold them into this series.
>> Let me know what you think.
> 
> Go ahead and send your follow on patches since you know which sites you want to fix. I'll create a branch that you can apply on top of with these two.

Here's the branch:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.2/cxl-pci-fixes


