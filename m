Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F452DC789;
	Fri, 14 Nov 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145355; cv=none; b=Yc+43s7pK11+349xev/BxzoNcYnnWnIJmZZH/OM1foq09t6Jv+I/c7Pv9QSucSTykaAJYa3UPPsxhTrcpz3Y4h61i2OlJ+Yx7vSrd9G3K9DLxjTzxygWBf7zro9w+qBu8jFSjCVGFicfSrDz4ML9r0R23kJC2P0OAuKPDQew8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145355; c=relaxed/simple;
	bh=Hyn3L6LuEyd4Dcm06hfDUoovcxJXk0zVFSlSRnyzSBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQvkMaotWREuyTiagTMqC7UK0NyImyLmxYP6H6DXoKinO3td8xo+UvnAbU4LdovTMqJ0/2DaReWXxeZW6pVWcSdL5jcFLeP/UZaUgo52XB1P2mGqYjS2tjo9d3CECvTPQ++UxZqXkz122rCULRgO7DMvPg3YWz4ULyVo4/fAXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCEX540Y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCEX540Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763145355; x=1794681355;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hyn3L6LuEyd4Dcm06hfDUoovcxJXk0zVFSlSRnyzSBY=;
  b=KCEX540YyRq3knYhO4OO9tEKQr9xnMW67GfA0nM8EGX6CVWRXvy6FXD/
   p34W5Hdmt9vNZIy3tgMHJD9qiMx4EMNYgkpDykbd84IrOWPiXRwihVKIB
   LBVJVOa8wHJkdDfzcDmKJJeymz3ljaa0b+FSgns4YMno0ymBNUFvlkbFk
   gycvqfCJHbUabrh24XqG8qerdnhkdT2ER3To9f+Rm+YQcs7+vbppJbYgt
   l9uiEZB9akW5/r+bv17NPn31AWrnP5i62JSdfumca95zIILD4iDXM1nLL
   +8PqJi4PAb73aYvnumn34nVlmb6af68yvSXrV5LcqSiWFxfJoF7GvjT5i
   w==;
X-CSE-ConnectionGUID: gwAE6/T4TqSeiz0tAj+lfg==
X-CSE-MsgGUID: SqMpi6GaQSSBXm51OhJHWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65181282"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65181282"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 10:35:54 -0800
X-CSE-ConnectionGUID: fdchwRA/TjKFP3d+JpqygA==
X-CSE-MsgGUID: A+U45qmrQzOQS3s/6AJnvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="189104642"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 10:35:53 -0800
Message-ID: <be005f26-3514-4870-a203-73813290f93d@intel.com>
Date: Fri, 14 Nov 2025 11:35:51 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] CXL updates for v6.19
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <aRW6h127k5Tzns8R@rric.localdomain>
 <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
 <aRYLJmjBsggjzA99@rric.localdomain>
 <a0881237-60e8-4bd9-b990-b72ad29c57aa@intel.com>
 <aRZBOmQH_pVs93T4@rric.localdomain> <aRbx1EbsGqUDY3Rd@rric.localdomain>
 <0e473cd6-12ab-425a-a5d9-b94226bed8ae@intel.com>
 <aRdXAVPp2jHwfJ8q@rric.localdomain>
 <81bb1561-5d97-45d4-b18c-0568d359d763@intel.com>
 <a1bcdffb-c03b-4d87-831f-9c58415af5db@intel.com>
 <aRd0K1MGNGUduYBC@rric.localdomain>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aRd0K1MGNGUduYBC@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/25 11:25 AM, Robert Richter wrote:
> On 14.11.25 11:18:23, Dave Jiang wrote:
>>
>>
>> On 11/14/25 9:28 AM, Dave Jiang wrote:
>>>
>>>
>>> On 11/14/25 9:21 AM, Robert Richter wrote:
>>>> On 14.11.25 08:32:00, Dave Jiang wrote:
>>>>>
>>>>>
>>>>> On 11/14/25 2:09 AM, Robert Richter wrote:
>>>>>> On 13.11.25 21:36:16, Robert Richter wrote:
>>>>>>> On 13.11.25 13:10:56, Dave Jiang wrote:
>>>>>>>> On 11/13/25 9:45 AM, Robert Richter wrote:
>>>>>>
>>>>>>>> So currently we want to apply the 3 patches ahead of time right? Can
>>>>>>>> you 1. post the series against 6.18-rc5, 2. provide a public branch
>>>>>>>> (github or kernel.org) that merged this branch with cxl/next (given
>>>>>>>> there are expected complications) that I can reference? That's
>>>>>>>> really my preference.
>>>>>>>
>>>>>>> Ok, thanks.
>>>>>>
>>>>>> I sent you a delta patch as I don't have a public git tree at hand
>>>>>> right now.
>>>>
>>>>> That works. Have you sent it yet? I don't think I've received it. Or
>>>>> I can give you push permission to my github repo if you can give me
>>>>> your github user name.
>>>>
>>>> See here:
>>>>
>>>>  https://patchwork.kernel.org/project/cxl/patch/20251114090532.1323361-1-rrichter@amd.com/
>>>>
>>>> -Robert
>>>
>>> Oh this is merge patch for the entire series. I thought it's just the 3 patches since we are merging those ahead of time while waiting for the rest of the series to be ready?
>>>
>>>
>> Robert,
>> Can you please verify that this merge looks correct to you? Thanks!
>> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=next-6.19-merge-prm-prep
>>
> 
> Yes, same what I have. Thanks.
> 
> I am going to send v7 with an update of the comment of patch 11/11
> (decoder lock).

You can use for-6.19/cxl-prm as base. I have pushed it to the cxl git.> 
> -Robert

