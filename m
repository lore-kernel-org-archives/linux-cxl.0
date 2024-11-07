Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8E212F0E;
	Thu,  7 Nov 2024 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993012; cv=none; b=mAg8SBZ1S1rzVoiOjIA4ixmBgybrgQnxp6u00eJHVi6gK2WbcBride+zfxsbUiOvj0AXqvbM5S2XlVlR18S7aUTZjJqhpaQ5+ibItjIs4hCsbmA0AFetZJKRKYqaipCbikS7OxZcm1//N8iVWxmmwxsvLRVsDAcZU864eBYbxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993012; c=relaxed/simple;
	bh=a6YO6KBaqcu7LFhMRbW9fAMjs8PEYS9W1YAnHz1KhxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9DV2CE/GNSE5LX2DaW1eHv1RBtb16XNGlR4fdjLKXW5ddlMjARzvQEFzJ4Xh7UFk3xgxfLGOB8zaOwBgsK99rU4LI7yquDsikvW7i4AUXu70jH8uL3jblwO17DJIxk9i36dxAahUYMQ76wXgcjAPrmf3lOC4x7Vxdk6euksR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6uVHInw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6uVHInw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730993010; x=1762529010;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a6YO6KBaqcu7LFhMRbW9fAMjs8PEYS9W1YAnHz1KhxQ=;
  b=A6uVHInwOBUTpOl1IKsw1ao328HpdB5vGeQS91Xn2OoNCuDsp0vkrNTA
   +imdkIZSgTWozVWUUfdDrY5AnKLjrnBMYhG/wSpi+1YAmmKlBkEESvwLK
   Z69nIZo59WgfkMehKEY7jyfb/01Czliy8uT+HqdUEJO5wnsnuQb/iMOJQ
   eynOeTsS9Jd9Dam7McFQY8frUHDSZF1Xxr/0DQae32+3sfZBzqv241gTA
   Db3P6TQ4yKLBNZUe4LSgudcQ72VQ1UKtIuJ7Q+An9OH+ZFk4d55+Fl9/E
   PP+54rMeOrVxve65ub6yafBtK64OUvx5MjYV1NJ2qDZzabk4mFQT4sJ8t
   Q==;
X-CSE-ConnectionGUID: q1PHWFV6S22optL58g07Ng==
X-CSE-MsgGUID: AxRs3/Y6TLGk0FmUxoxT+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30945950"
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="30945950"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 07:23:29 -0800
X-CSE-ConnectionGUID: Sq9ASEhSSCu24nQM+IXOwA==
X-CSE-MsgGUID: ZjhDXQfkR5+08ObUA85/jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="85213249"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.165]) ([10.125.110.165])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 07:23:29 -0800
Message-ID: <1f05ccef-5b45-4eac-b3ca-588b1e5ec6f5@intel.com>
Date: Thu, 7 Nov 2024 08:23:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] cxl/region: Fix region creation for greater than x2
 switches
To: Dan Williams <dan.j.williams@intel.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Huaisheng Ye <huaisheng.ye@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pei.p.jia@intel.com" <pei.p.jia@intel.com>
References: <20241027075717.3714821-1-huaisheng.ye@intel.com>
 <80415a29-14dd-4108-aa02-4b0b5e1f2baf@fujitsu.com>
 <672c13b19a530_10bc6294bd@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <672c13b19a530_10bc6294bd@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/24 6:11 PM, Dan Williams wrote:
> [ add Dave so you 
> 
> Zhijian Li (Fujitsu) wrote:
>>
>>
>> On 27/10/2024 15:57, Huaisheng Ye wrote:
>>> The cxl_port_setup_targets() algorithm fails to identify valid target list
>>> ordering in the presence of 4-way and above switches resulting in
>>> 'cxl create-region' failures of the form:
>>>
>>>    # cxl create-region -d decoder0.0 -g 1024 -s 2G -t ram -w 8 -m mem4 mem1 mem6 mem3 mem2 mem5 mem7 mem0
>>>    cxl region: create_region: region0: failed to set target7 to mem0
>>>    cxl region: cmd_create_region: created 0 regions
>>>
>>>    [kernel debug message]
>>>    check_last_peer:1213: cxl region0: pci0000:0c:port1: cannot host mem6:decoder7.0 at 2
>>>    bus_remove_device:574: bus: 'cxl': remove device region0
>>>
>>> QEMU can create this failing topology:
>>>
>>>                         ACPI0017:00 [root0]
>>>                             |
>>>                           HB_0 [port1]
>>>                          /             \
>>>                       RP_0             RP_1
>>>                        |                 |
>>>                  USP [port2]           USP [port3]
>>>              /    /    \    \        /   /    \    \
>>>            DSP   DSP   DSP   DSP   DSP  DSP   DSP  DSP
>>>             |     |     |     |     |    |     |    |
>>>            mem4  mem6  mem2  mem7  mem1 mem3  mem5  mem0
>>>   Pos:      0     2     4     6     1    3     5    7
>>
>> Yeah, I tried this topology long long ago, it didn't work. At that time, I thought it
>> might be just like that. Until recently that I saw this [1] in section
>> 2.13.15.1 Region Spanning 2 HB Root Ports Example Configuration Checks
>>
>> I once tried to understand why the code used "distance" to determine the order of the target,
>> but in the end, I still couldn't figure it out (and I still don't understand it now).
>> IIRC, neither the CXL spec nor this document mentioned the keyword "distance" at all.
> 
> Oh, that means this needs a comment or a better variable name.
> 
> In this patch discussion [1] Jim came up with the term "ancestral_ways"
> to describe the same concept of what is the offset ("distance") between
> consecutive indices in the target list.
> 
> [1]: http://lore.kernel.org/ZUHeTLZb+od8q4EE@ubuntu
> 
> Does "ancestral_ways" more clearly convey the math that is being
> performed at each level of the hierarchy?
> 
> Now, "ancestral_ways" also does not show up in the CXL specification,
> but that is because the CXL specification leaves at as an exercise for
> software to figure out an algorithm to validate that a proposed ordering
> of memory-device-decoders in a region can be supported by the given CXL
> topology.
> 
> In the meantime I have flagged this patch to Dave for consideration in
> the next cxl-fixes pull request, but I suspect it will need to be
> updated with a comment and/or rename to resovle the "distance"
> confusion.
> 
> https://patchwork.kernel.org/bundle/cxllinux/cxl-fixes/

If we can get it respin and tagged by next week, there's time to get it into the 6.13 merge window. Otherwise it can wait until 6.13-rc fixes.
> 

