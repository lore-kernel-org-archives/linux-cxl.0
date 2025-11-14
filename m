Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BE533C535;
	Fri, 14 Nov 2025 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144308; cv=none; b=XNVzvrseYjG9HQo4QGl8A0kamk5wjUmfgtZbWP88IJq5AWjXO4x6zr1D0A/Ge//7rz4lVk3hgmArqr5s1JXwKk4es+4h+XZzzVPs+ywwgY1osWLa+Oh8R5U/83KpkVJ2iVpSBVUY4j1pn6hwehqgmgqdo0D+Cr2BvRte2pH1rtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144308; c=relaxed/simple;
	bh=SNZhmdxqFfQwXPd87GdrrQnc+RJQIYrhT1lbVO8ZHkU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AAEJ/qFlgKWkFPB3d41SpC6h12S1pBUof91uPVvwesgosSQ/v8VFG79qIwMaW+nyUZ+tQ4I/NeO/byAobz8KcIgEXpF6sonfebepaKeaDL7f268fuEFjVRNMYS078Vz7MDHOquvWT/zgk87J74rWnowHDDT+RkFEg0mhBDnbKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9unQ48b; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9unQ48b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763144307; x=1794680307;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=SNZhmdxqFfQwXPd87GdrrQnc+RJQIYrhT1lbVO8ZHkU=;
  b=h9unQ48bvCv/dk+JogSO7iL8VLJKypX3nFJCKpiMqJxyZfw1EYgs5d5U
   sSRbg+IpJQ1D4fti/Zdpn1RjcMz7K1v6I5kH2wZNvf99ZgYjUvWVTGURV
   RzUmMH1Jt7dXIeUy+vaP33zcQdhR0G39W0aZMkbUyHZS9wrLh6n43tk4N
   4j/SILolj/gJCF/NHBm3tZcB9LS4Mf73pecRCzqKVRAdmgaAchh5XEg7M
   hBZZCWPssezVOkNq9d7ILBkyxM7oart5Yt9qqY9X8o8q7siQa5BONNV5s
   33oqi9nBKDvnVhLMvHyiqnSH61WpkSXHijAEVcPTDhTnP0LGPoo05w9eU
   A==;
X-CSE-ConnectionGUID: okWQDacPT7C/L5uSoCOB2Q==
X-CSE-MsgGUID: l6xlkCNRQCuoXeqepE88wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="69092654"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="69092654"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 10:18:26 -0800
X-CSE-ConnectionGUID: RA/iUD8MRQC7ralilWXeSw==
X-CSE-MsgGUID: M2xjy2z6QnSRTvldYQbUFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="194143302"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 10:18:25 -0800
Message-ID: <a1bcdffb-c03b-4d87-831f-9c58415af5db@intel.com>
Date: Fri, 14 Nov 2025 11:18:23 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] CXL updates for v6.19
From: Dave Jiang <dave.jiang@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
 <aRW6h127k5Tzns8R@rric.localdomain>
 <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
 <aRYLJmjBsggjzA99@rric.localdomain>
 <a0881237-60e8-4bd9-b990-b72ad29c57aa@intel.com>
 <aRZBOmQH_pVs93T4@rric.localdomain> <aRbx1EbsGqUDY3Rd@rric.localdomain>
 <0e473cd6-12ab-425a-a5d9-b94226bed8ae@intel.com>
 <aRdXAVPp2jHwfJ8q@rric.localdomain>
 <81bb1561-5d97-45d4-b18c-0568d359d763@intel.com>
Content-Language: en-US
In-Reply-To: <81bb1561-5d97-45d4-b18c-0568d359d763@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/25 9:28 AM, Dave Jiang wrote:
> 
> 
> On 11/14/25 9:21 AM, Robert Richter wrote:
>> On 14.11.25 08:32:00, Dave Jiang wrote:
>>>
>>>
>>> On 11/14/25 2:09 AM, Robert Richter wrote:
>>>> On 13.11.25 21:36:16, Robert Richter wrote:
>>>>> On 13.11.25 13:10:56, Dave Jiang wrote:
>>>>>> On 11/13/25 9:45 AM, Robert Richter wrote:
>>>>
>>>>>> So currently we want to apply the 3 patches ahead of time right? Can
>>>>>> you 1. post the series against 6.18-rc5, 2. provide a public branch
>>>>>> (github or kernel.org) that merged this branch with cxl/next (given
>>>>>> there are expected complications) that I can reference? That's
>>>>>> really my preference.
>>>>>
>>>>> Ok, thanks.
>>>>
>>>> I sent you a delta patch as I don't have a public git tree at hand
>>>> right now.
>>
>>> That works. Have you sent it yet? I don't think I've received it. Or
>>> I can give you push permission to my github repo if you can give me
>>> your github user name.
>>
>> See here:
>>
>>  https://patchwork.kernel.org/project/cxl/patch/20251114090532.1323361-1-rrichter@amd.com/
>>
>> -Robert
> 
> Oh this is merge patch for the entire series. I thought it's just the 3 patches since we are merging those ahead of time while waiting for the rest of the series to be ready?
> 
> 
Robert,
Can you please verify that this merge looks correct to you? Thanks!
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=next-6.19-merge-prm-prep

