Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335CB3128CF;
	Tue, 10 Feb 2026 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770765639; cv=none; b=QZ/hogXPL07DgWCHMAjunhqOO/3c3Fjhwi79ZtlPn6qDBmoFrfFrw7zqjaPtxMVo/bl0fkbXMiTlys7L8Bb1GBJ8wZE3QQCmA2WPi8FGpKoSDgsNv+/NWFgqpTIxdwnvFgghKPfApyLJP5bs8yLGKfrmMQnxRllzD3UNrH/+5E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770765639; c=relaxed/simple;
	bh=8LfvwQRnZ/ETbI0hG9oPjMU5Kba6vxLb5uPL/fVy9fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hB2+ZUUZIf79LYDjOAVuUdAikSJWn6PPHv/yjVKNMaAiXjwzo2rK1HKFQsHgf+ihhDaOeqbctM4M4NLNSbBDzbzSZIqiHhR/QQyoYl360KpWZdWyvCsi6qzu/5apiU951QDh1uGT3bIp8OinkhsLGmENvynm2OJdh54AWwZw8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFCXROvf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFCXROvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770765638; x=1802301638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8LfvwQRnZ/ETbI0hG9oPjMU5Kba6vxLb5uPL/fVy9fM=;
  b=HFCXROvfb/54lI07iMSbkgZcGuTXm3mKRqwItGB7wd85mPc0m/ny/sUn
   MF81eJ8Kb2ZjDq/ttKNQszi8CjRgm2eGevp0tQSyEEEWjkFQZ4Fq25WmJ
   urpnS+PAzjtNVcylU12OXEucgSTeC3a9kYkRo/P8OyXhGyEfD8sTZqO5K
   SC98iSZi/9qJXBTIkQvRBpjrTLvizvNhEAvZ7qnB5E+7ota3nF2Uh3S9G
   rAFH3Awq/+XsN+Wz23/LKrBQk2cq0oOujbA/WpoeyL7TH4xaebT7OOoiE
   JwSy55fENMmlJz/c+CUSmpRFTuqPStMVuoOIQAMqaP+ziyP+FVaTCsJs6
   Q==;
X-CSE-ConnectionGUID: eo/rW8QGQ6SR7mevlJRjRg==
X-CSE-MsgGUID: 2ODdqZuAQqyDWRdzfHHxqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71801287"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71801287"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 15:20:37 -0800
X-CSE-ConnectionGUID: WvIa/QzbTBmlVOV9i0fIgA==
X-CSE-MsgGUID: nVW1eOAGS5SI/NMCgsEEmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216229125"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.80]) ([10.125.108.80])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 15:20:37 -0800
Message-ID: <c8623ed8-04ac-4921-adb0-14cf630a063e@intel.com>
Date: Tue, 10 Feb 2026 16:20:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/memdev: fix deadlock in cxl_memdev_autoremove() on
 attach failure
To: Gregory Price <gourry@gourry.net>, Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com
References: <20260210154320.1748223-1-gourry@gourry.net>
 <698b8a8620f2a_dce1110074@iweiny-mobl.notmuch>
 <aYu1M75-tV8-TLAC@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aYu1M75-tV8-TLAC@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/10/26 3:46 PM, Gregory Price wrote:
> On Tue, Feb 10, 2026 at 01:44:06PM -0600, Ira Weiny wrote:
>> Gregory Price wrote:
>>>
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index af3d0cc65138..c0de767b24fb 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -1098,19 +1098,22 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
>>>  	 * return. Note that failure here could be the result of a race to
>>>  	 * teardown the CXL port topology. I.e. cxl_mem_probe() could have
>>>  	 * succeeded and then cxl_mem unbound before the lock is acquired.
>>> +	 *
>>> +	 * Check under device_lock but unregister outside of it, as
>>> +	 * cxl_memdev_unregister() will also take the device lock.
>>>  	 */
>>> -	guard(device)(&cxlmd->dev);
>>> -	if (cxlmd->attach && !cxlmd->dev.driver) {
>>> -		cxl_memdev_unregister(cxlmd);
>>> -		return ERR_PTR(-ENXIO);
>>> +	scoped_guard(device, &cxlmd->dev) {
>>> +		if (cxlmd->attach && !cxlmd->dev.driver)
>>> +			break;
>>> +
>>> +		rc = devm_add_action_or_reset(cxlmd->cxlds->dev,
>>> +					      cxl_memdev_unregister, cxlmd);
>>
>> This kind of threw me...  Won't this deadlock if
>> devm_add_action_or_reset() fails as well?
>>
>> Need to use devm_add_action() and drop out of the guard on failure.
>>
> 
> lol i pointed out that this patch was a claude recommendation on the
> initial report - didn't look to hard because it fixed this specific
> deadlock with:
> 
> 	if (cxlmd->attach && !cxlmd->dev.driver)
> 		break;
> 
> so yeah, easy enough to fixup.
> 
> I can either v2 or Dave if you want to just make the oneline change
> before pull let me know

With Dan's comments, may as we spin v2. We have time until rc1 releases.

> 
> ~Gregory

