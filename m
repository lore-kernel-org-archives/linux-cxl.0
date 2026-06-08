Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F638E8DA
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947042; cv=none; b=bDmHDaTpuN9K0KkKILFjXrHkvRNl/KEBbkHB3p0Y6iw2t7yHJusR01URVbTcGhDRZhjszarefkWjiQ8S5l6Kou7Ik82tjPmvO4UHuM/iWwJ0hnRs3rqUMF2ro4hAK7ZNUd5wSowuAuCSDZw6JPLqQsBwcECLmtUJUlBeRF6NMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947042; c=relaxed/simple;
	bh=UwkorsgL/dBgzBfcUvvduaHKkcv2Jy1K0MKp0Hy2s+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWTE8Vsm/T/UxzMvcY96YO0lwG9PhuijuVPHQ7DMM29kKKjuVaYyCaaOI2GnBCiJ7/z1OvcU5A8wm67MYHNWRaV7IDkj3yMBvkMKh7rt+eVoiMAhwnzbw7ZjtmCY3xVh6EImyCgmCB60HW/+AjI/9PsOFAH6zP81YopRHLB35ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjiOh+NY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjiOh+NY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780947040; x=1812483040;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UwkorsgL/dBgzBfcUvvduaHKkcv2Jy1K0MKp0Hy2s+g=;
  b=NjiOh+NYGbXlkjqM6g5KVM++Un9WdDV6TolrCHj79MLDoHPGhqeaLhsd
   1EkZe5x82rwqdBahjcfQqvf8DwD69NQPmd+cW2E43PZ6pVhDbDZYhiF1E
   8TMF2mD6SrrithRsmDZUo0PgwTBaBUA2QgSlYeClKYBEOZUV3lHywcwdw
   ehwLa1HMzCq0JKNqkI0CC0dQMTyVJseWi1MxCO5NTxvnw/+TqFuHfwg+a
   iTi/SvkBGMmh87sNWsvsZgCMoxphF7o5Z7wCNpdB4Q6b+9q2NsojcTEfT
   B0e3+vyt2xNtOFm0/h0ru1t0VB8dmxbjAAjMKuHJNOxMoWBT5wjbBFGOn
   g==;
X-CSE-ConnectionGUID: 7Pp3ZQULTf22u/zKSRkoeA==
X-CSE-MsgGUID: /Ei23OySQC+Cam/Jr7Ajbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81443228"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81443228"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 12:30:40 -0700
X-CSE-ConnectionGUID: wCdAFCHWRfmXc//6mpKCLA==
X-CSE-MsgGUID: vD1R1AV/T2ar8naEZMAMQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="249555648"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.162]) ([10.125.109.162])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 12:30:40 -0700
Message-ID: <48834616-6e75-4936-89be-9224a6dedefa@intel.com>
Date: Mon, 8 Jun 2026 12:30:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cxl: Introduce devm_cxl_probe_mem() and fix region
 deletion
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
 <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, jic23@kernel.org,
 Sungwoo Kim <iam@sung-woo.kim>
References: <20260519210158.1499795-1-djbw@kernel.org>
 <9e85d980-4a44-4f27-aa18-8d01630a05e6@amd.com>
 <2a9791d4-e091-4452-af92-3601253bc748@amd.com>
 <5f399564-7efe-444d-a6cf-2c6176e57ad9@intel.com>
 <138239a6-8392-4a47-807b-ec0334d24b0b@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <138239a6-8392-4a47-807b-ec0334d24b0b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/5/26 11:48 PM, Alejandro Lucero Palau wrote:
> 
> On 6/5/26 16:20, Dave Jiang wrote:
>>
>> On 6/5/26 12:56 AM, Alejandro Lucero Palau wrote:
>>> On 5/21/26 15:31, Alejandro Lucero Palau wrote:
>>>> Hi Dan,
>>>>
>>>> On 5/19/26 22:01, Dan Williams wrote:
>>>>> The devm_cxl_probe_mem() helper creates a memdev and retrieves a mapped
>>>>> HPA range for the device. At present the retrieved region information is
>>>>> expected to be established by platform firmware. A future update will
>>>>> auto-establish a region if one is not already present. This arranges for a
>>>>> simple CXL topology detach == Accelerator driver detach scheme.
>>>>
>>>> I have successfully  tested this with sfc and it indeed simplifies the accelerator driver. Removing cxl_acpi or unbinding the related memdev works as expected removing the sfc driver as well.
>>>>
>>>>
>>>> I'm quite happy with this approach and I hope this is the last building block for the simplified (only with autodiscovered regions) type2 series.
>>>>
>>>>
>>> No updates or comment for two weeks. I wonder if this is being superseded somehow and I did not notice.
>> Are you not integrating this series with yours? At least that's my understanding given you are happy with the approach.
>>
>> DJ
> 
> 
> Hi Dave,
> 
> 
> This series got your review tags plus my tested and review ones. It has not been merged and and not received further comments either.
> 
> 
> If Dan wants me to integrate this with type2, fine, but I think it should go first. The final type2 bits along sfc using this new type2 support should keep simple and they will be even simpler after this patchset from Dan.
> 
> 
> After 26 versions, I do not want to send new versions as soon as there exists a new possibility ... As I said, this series are promising and I hope they are the final step setting the way for my type2, but I guess you understand my precautions approach ...
> 
> 
> In any case, if Dan or you want me to integrate this with my type2 series, please tell me.

I pushed the series from Dan to a branch [1]. Rebase your current type2 enabling code on top of that and post and we'll go from there.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.3/cxl-type2-enabling

> 
> 
> Thank you,
> 
> Alejandro
> 
> 
> 
>>>
>>>> Just a minor comment in patch 5 and a suggestion for maybe changing the devm_cxl_probe_mem interface call.
>>>>
>>>>
>>>> Cheers
>>>>
>>>>
>>>>
>>>>
>>>>> Now, automatic region establishment on behalf of an accelerator driver
>>>>> also requires automatic region teardown. The existing scheme of
>>>>> triggering devm_release_action() of a cxl root device to destroy a
>>>>> region is racy [1].  There is no path to coordinate multiple devres
>>>>> actions, or conflicting devres actions, without using the
>>>>> devm_remove_action_nowarn() workaround.
>>>>>
>>>>> Instead, move final region cleanup responsibility to the root decoder
>>>>> teardown path (devres action cxld_unregister()). Expand the root decoder
>>>>> @range_lock, renamed @regions_lock, to coordinate region creation, sysfs
>>>>> manageability, and deletion. The @regions_lock also prevents regions
>>>>> from disappearing mid-auto-assembly.
>>>>>
>>>>> Changes from the initial RFC [2]:
>>>>> * tested with Dave's type2 cxl_test
>>>>> * fix region remove by endpoints (Dave, Alejandro)
>>>>> * fix user triggered region remove (Sungwoo)
>>>>> * fix lifetime of the @attach ops (Alison, sashiko)
>>>>> * hide @attach details inside the CXL core
>>>>>
>>>>> [1]: http://lore.kernel.org/20260427032010.916681-2-iam@sung-woo.kim
>>>>> [2]: http://lore.kernel.org/20260403210050.1058650-1-dan.j.williams@intel.com
>>>>>
>>>>> Dan Williams (5):
>>>>>     cxl/region: Block region delete during region creation
>>>>>     cxl/region: Resolve region deletion races
>>>>>     cxl/memdev: Pin parents for entire memdev lifetime
>>>>>     cxl/memdev: Introduce cxl_class_memdev_type
>>>>>     cxl/region: Introduce devm_cxl_probe_mem()
>>>>>
>>>>>    drivers/cxl/core/core.h      |   2 +
>>>>>    drivers/cxl/cxl.h            |   8 +-
>>>>>    drivers/cxl/cxlmem.h         |  27 +++--
>>>>>    include/cxl/cxl.h            |   3 +
>>>>>    drivers/cxl/core/memdev.c    |  20 +++-
>>>>>    drivers/cxl/core/port.c      |   7 +-
>>>>>    drivers/cxl/core/region.c    | 194 ++++++++++++++++++++++++++++++-----
>>>>>    drivers/cxl/mem.c            |  95 +++++++++++++----
>>>>>    drivers/cxl/pci.c            |   2 +-
>>>>>    tools/testing/cxl/test/mem.c |   2 +-
>>>>>    10 files changed, 297 insertions(+), 63 deletions(-)
>>>>>
>>>>>
>>>>> base-commit: 5d6919055dec134de3c40167a490f33c74c12581

