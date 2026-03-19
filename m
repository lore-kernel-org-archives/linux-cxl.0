Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159332A3DE
	for <linux-cxl@vger.kernel.org>; Thu, 19 Mar 2026 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932624; cv=none; b=oEnI3iW+axqe4GfkBjmcNoq08f5co1Y52HgMGWNjVtEQikGyEgbdUGijUtf7Pz4gBAg6F5PzMoY7fhFe3mMb9Tlq+zwFTW8B2VGUZNIw3sdF03WvDv4l2Xrf+bfpNKtFw1RsPjdAqpjvj8T+Qb8kZc7WNTOpGDeZO/LjqrlmYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932624; c=relaxed/simple;
	bh=bTvGo5sYA6tfZLiXczoOEyidUEIaahUectBfNE2Wt64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwcJS/miBLfg0xqypqpU24h3aSJUHp38xwfHG/o6RdCbX1V5dTz5M8fApsBoVkRdDnEi985yaRoXqiV/FmZEQwHZJF6gTgWxhGzSWWMuL51RaHGQjwL/monLTygrj0oCoElIGRj1svRBPZERYFTXhRrthvk61ctwP5dx+ZxNU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zf+m2PU3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zf+m2PU3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773932621; x=1805468621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bTvGo5sYA6tfZLiXczoOEyidUEIaahUectBfNE2Wt64=;
  b=Zf+m2PU3+xJx5U+BfW6gcIjidOXTpmuo+VmQZC/2j6C3ArlOElXHsIOK
   IpVL5XLLm4G153/0AKjyXjNI8sBO/cqrCS58yuwiThLvxaO0jDTnVC0S8
   crz7BpKAyVPbindiEn7ojM64LLx6w6IJjMoDjD9La/AumxedpOqh5Qq8B
   oYrcsb56YHpSaVBh1xYmwmGJsK7llQaqNBH25j68FX2AfjkBd520Ho8xv
   /L14JA6DlPM4rasHnMw17jNPIAVOgtaZ2CEJAvWxDs61nBZXCHCOgKvSP
   4WJ8r60TjUNoqcLEs9WmOEi9ctFSU7YYaAU1hirP2VgvKEl6FnmfiFg47
   Q==;
X-CSE-ConnectionGUID: SkFAlXaUSSy8oz0YI6uJGg==
X-CSE-MsgGUID: K+uBV/0MSPSChSr45JiM5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85709532"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85709532"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:03:40 -0700
X-CSE-ConnectionGUID: dainlGtUQGu4yrSvXYggCw==
X-CSE-MsgGUID: pdGiRnHWS4K1VU18nd8AAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227684257"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.49]) ([10.125.109.49])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:03:39 -0700
Message-ID: <9d5f4c71-19ce-4cfa-8933-bf13db64c03c@intel.com>
Date: Thu, 19 Mar 2026 08:03:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Add endpoint decoder flags clear when PCI reset
 happens
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 alison.schofield@intel.com
References: <20260317234926.3545119-1-dave.jiang@intel.com>
 <20260319144613.00003ea6@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260319144613.00003ea6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/26 7:46 AM, Jonathan Cameron wrote:
> On Tue, 17 Mar 2026 16:49:26 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> When a PCI reset happens, the lock and enable flags of the CXL device
>> should be cleared to avoid stale state flags after reset. Add flag
>> clearing during cxl_reset_done() to clear the relevant endpoint
>> decoder flags for all decoders of the endpoint device.
>>
>> Reported-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v2:
>> - Rename CLEAR_MASK to RESET_MASK (Alison)
>> - Make the helper function take a mask argument to specify which flags
>>   to clear (Alison)
> Unless we know of another use for this helper, I'd have gone with
> Alison's other alternative of just giving it a more specific name
> and not passing in a flags parameter.  Feels like a bit of premature
> generalization!
> 
Ok will do. 
