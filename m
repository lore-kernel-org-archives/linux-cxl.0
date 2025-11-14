Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C073271E2;
	Fri, 14 Nov 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137738; cv=none; b=cCVqaBi6kXJA3PdzlDtuPQSr/aWCx86SuqBUbt/lzM2QoT/uYlvRfvR0w00f6+H7byV9b4WzaYFzqFB3tUIKG/ViPDuFpSLmJ5ZOqnxeVHBhkHK5ieBcn6av3F36AKGrbWeTnBvsKK8hWBwJQ6vf6JdiLtqBvziEPwBEp+LIQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137738; c=relaxed/simple;
	bh=wLnBAsJo/OcIB8kMWLMdIJ9ad1MJKS/iQwwdG37bFqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4888VKqvLeWRGjHwCbgRx8FlaXfoVjVln4th9OozSoONKlq4Dirk4UKCbbYSFc0dg6N/7Ty9G/t+VQe9GWpEEoZ08fL+w0kNNQtXcgfbAsfG6W6K62N/fBiyh+DLN6KG9Xaw8VTqZzoFqHbWnnvnqG1xnOcdECsem3mXOAYxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5tyrCQI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5tyrCQI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763137737; x=1794673737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wLnBAsJo/OcIB8kMWLMdIJ9ad1MJKS/iQwwdG37bFqo=;
  b=j5tyrCQIhX/uDIfQit1Efh4JLgKIh0kRUkr1EI7r8hQge3fLGOwGSUQt
   DolSzDPXEUMfEkiugIlEH5t32imj/hlCrF/RXbYCFIb/9VeoXN/u76PJG
   or2Rt5lsj/CWzCKQtrVnX4K2v+PEyM5m/0nsrK5UN0/huPyPD/wPOPVW9
   2VYHc9U6m5Ir1sK5Qf7JFSsaxNpqcLj1SPR4l3WMjXkH6B5d5s4hJhET7
   a7EgPrFtgT3HmTY+n/Xx1KCBTGfOiEOcLkBjLGVCDELRqvO5Ak2v68a3U
   r/wMMgJ0FecVxMi1dAbBvNOTR7uxktKLzP7oU7IXH8nHDVML1vlyw6yXO
   w==;
X-CSE-ConnectionGUID: HDXMcuT0S0u1KZL6X/mo1g==
X-CSE-MsgGUID: S4xjnhUCTziRuFrCjgTb0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="76337101"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="76337101"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 08:28:56 -0800
X-CSE-ConnectionGUID: GLx9xN2LSvWKvdOatfnSsw==
X-CSE-MsgGUID: J6jkppSJQvqx+L6QU6MQHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="193924767"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 08:28:55 -0800
Message-ID: <81bb1561-5d97-45d4-b18c-0568d359d763@intel.com>
Date: Fri, 14 Nov 2025 09:28:54 -0700
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
References: <20251112205105.1271726-1-rrichter@amd.com>
 <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
 <aRW6h127k5Tzns8R@rric.localdomain>
 <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
 <aRYLJmjBsggjzA99@rric.localdomain>
 <a0881237-60e8-4bd9-b990-b72ad29c57aa@intel.com>
 <aRZBOmQH_pVs93T4@rric.localdomain> <aRbx1EbsGqUDY3Rd@rric.localdomain>
 <0e473cd6-12ab-425a-a5d9-b94226bed8ae@intel.com>
 <aRdXAVPp2jHwfJ8q@rric.localdomain>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aRdXAVPp2jHwfJ8q@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/25 9:21 AM, Robert Richter wrote:
> On 14.11.25 08:32:00, Dave Jiang wrote:
>>
>>
>> On 11/14/25 2:09 AM, Robert Richter wrote:
>>> On 13.11.25 21:36:16, Robert Richter wrote:
>>>> On 13.11.25 13:10:56, Dave Jiang wrote:
>>>>> On 11/13/25 9:45 AM, Robert Richter wrote:
>>>
>>>>> So currently we want to apply the 3 patches ahead of time right? Can
>>>>> you 1. post the series against 6.18-rc5, 2. provide a public branch
>>>>> (github or kernel.org) that merged this branch with cxl/next (given
>>>>> there are expected complications) that I can reference? That's
>>>>> really my preference.
>>>>
>>>> Ok, thanks.
>>>
>>> I sent you a delta patch as I don't have a public git tree at hand
>>> right now.
> 
>> That works. Have you sent it yet? I don't think I've received it. Or
>> I can give you push permission to my github repo if you can give me
>> your github user name.
> 
> See here:
> 
>  https://patchwork.kernel.org/project/cxl/patch/20251114090532.1323361-1-rrichter@amd.com/
> 
> -Robert

Oh this is merge patch for the entire series. I thought it's just the 3 patches since we are merging those ahead of time while waiting for the rest of the series to be ready?

