Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4197330FC34;
	Tue, 21 Apr 2026 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785378; cv=none; b=C2YUK8BcuswUAOfAEeUuc9n6iBHEEvs4XPROsiITyak6w+UWNp7oasMu8J1s8h58D65RMlz1CS4fuCT0iQqahT28EaId64oTl/mH0FXydtUKhw3qqVSmx1Q6vZBTZqmBdfPrDsAejg5CCpXAl5Ca3aUy5w3LNYg2kkRgOcgLT9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785378; c=relaxed/simple;
	bh=cCow88+KpwoaT+jjVfBphsGIAeg+It2AfwBtddoaiKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edZNfo34P1lIbjffiCmo22lUCk7SIibKc61IyIbuZES7d/6z/WNAIGMWcLwMgzrzsfaOGLFX02J4v5lEbyshWNysaZosdqpraLdWa08JsLTen9pUjHGYi2B478/Sm22VhCgOFo5MFSEVCklq96IL1/ukXBct5yS+sXyd3Z+fe7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJ7H723R; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJ7H723R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776785377; x=1808321377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cCow88+KpwoaT+jjVfBphsGIAeg+It2AfwBtddoaiKc=;
  b=hJ7H723RZwuwPk4eMds0fgmh7Vg7m0Kzi1J5GfLEKfLQb08yiFh9chn3
   fsJn+geDSDpa01r/a/czRnMov8que7WLgJdp88iWyd8qjtmAEOuLlh/Ma
   2zc57VmF+57doCdHsy8mCF3XM7UmPdOwnUthX+COtVXiQwTtUFCt+X3VP
   N8l9Ttjb1CXsP/em/ItNKbn/R2TrFH3zkesaPyAKrt79Bgn0ypy9SB8Jp
   2u5H6EhvFVMdROie17vViGToMsaSmf8JtnzSykUjW38pG4vN/+6OBRtnC
   3cFKe/tTAqMbCbei2A489L2WCHaFzYAxDKLnTf2pXBxMaw7jkiW7pszPQ
   Q==;
X-CSE-ConnectionGUID: SUZ2LRQvThudjvWFHaTqYg==
X-CSE-MsgGUID: pMSIICJNQXy1ICjroCu57A==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="65255667"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="65255667"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 08:29:36 -0700
X-CSE-ConnectionGUID: 5d4Jbz1RTgulzaJLRRff6Q==
X-CSE-MsgGUID: VFFvl/qRQ9i0y3gPsUufww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="233848885"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.122]) ([10.125.111.122])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 08:29:35 -0700
Message-ID: <92f138f9-b041-461d-b159-ff1bc265bbee@intel.com>
Date: Tue, 21 Apr 2026 08:29:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
To: Li Ming <ming.li@zohomail.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>, Dan Williams <djbw@kernel.org>
References: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
 <20260314-fix_access_endpoint_without_drv_check-v2-2-4c09edf2e1db@zohomail.com>
 <c784d84c-e8ac-4c87-abec-3d4e64f074a2@intel.com>
 <d2ed94ec-e5c7-4b6b-9fe8-68f22bd632ad@zohomail.com>
 <dfc0979a-b01a-4c90-8bc8-7a60fb795dc7@intel.com>
 <69da9fa696d0f_6c31a100e8@djbw-dev.notmuch>
 <778c8dc5-b65e-4b1f-be13-8bfb960cefc3@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <778c8dc5-b65e-4b1f-be13-8bfb960cefc3@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/21/26 3:48 AM, Li Ming wrote:
> 
> 在 2026/4/12 03:23, Dan Williams 写道:
>> Dave Jiang wrote:
>>>
>>> On 3/18/26 4:59 AM, Li Ming wrote:
>>>> 在 2026/3/17 23:00, Dave Jiang 写道:
>>>>> On 3/14/26 12:06 AM, Li Ming wrote:
>>>>>> CXL memdev poison injection/clearing debugfs interfaces are visible
>>>>>> before the CXL memdev endpoint initialization, If user accesses the
>>>>>> interfaces before cxlmd->endpoint updated, it is possible to access an
>>>>>> invalid endpoint in cxl_dpa_to_region().
>>>>>>
>>>>>> Hold CXL memdev lock at the beginning of the interfaces, this blocks the
>>>>>> interfaces until CXL memdev probing completed.
>>>>>>
>>>>>> The following patch will check the given endpoint validity in
>>>>>> cxl_dpa_to_region().
>>>>>>
>>>>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>>>>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>>>>> Hi Ming, I dropped this patch with Dan's comments [1] and updated cxl/next. Please check and make sure everything looks ok to you. Thanks!
>>>>>
>>>>> [1]: https://lore.kernel.org/linux-cxl/69b8b81621e16_452b100e@dwillia2-mobl4.notmuch/
>>>> Hi Dave,
>>>>
>>>> I think there is no change needed in this patch, just need a independent patch for holding memdev lock in cxl_region_debugfs_poison_inject/clear.
>>>>
>>>> Or you want to review this patch again?
>>> No. Maybe I misunderstood the comment from Dan. So we should keep this patch?
>> tl;dr: yes, this patch is *now* valid.
>>
>> As originally structured having patch2 before patch3 added no value.
>> Going forward I would say do not structure a series such that a new lock
>> taken in patch N starts being useful in patch N+1.
>>
>> I assume that is what:
>>
>> "The following patch will check the given endpoint validity in
>> cxl_dpa_to_region()."
>>
>> ...is trying to say, but when commits are applied to the tree it is
>> difficult to see that this commit was from a series.
>>
>> So do pick this one up, but the changelog needs adjusting. Something
>> like:
>>
>> "cxl_dpa_to_region() assumes that it is running a context where it is not
>> racing changes to "cxlmd->dev.driver". Acquire the memdev device lock in
>> the debugfs entry points to preclude debugfs usage racing cxl_mem driver
>> detach."
>>
>> With that you can add:
>>
>> Reviewed-by: Dan Williams <djbw@kernel.org>
> 
> Hi Dave,
> 
> Will you pick this patch with changes from Dan's comment? Or I need to send out a new version?

I believe it's merged into linus/master already. Can you check and see if everything looks correct?

> 
> 
> Ming
> 

