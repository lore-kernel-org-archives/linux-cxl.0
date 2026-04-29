Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294573FFAD3
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490042; cv=none; b=ud9GUTo0I65y3RuaX4vbcUYYz2n6BKHC430b67VoKNPfYe2kJRr9jXdoQlNBG+9gBAtyploSXLDALMu6/gH3QnOMkWWllHSvNH2X+UVdifczkC7FulAdw4w6c4i5gsn/6TcBE08CuJXnO+cnAF2AWynDltV0nBRub9JlueIHYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490042; c=relaxed/simple;
	bh=qyLpkDv6w7T+iKDG1NCKgxJr5jNr96IUb+5b7RDdg/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l90T6byPtsIfvUi9RkgSQsznhc84wGC1nDl7F3if9nQAtuNwYi1VwadNAogUFT9kZ6c8R/vr6gVGlt6wQHPeYQS9JCloRd1CkaA5ouj4FZo9e1S5UdFlfMtxshV4nTnPha25nJ2iDz2wQcjbzzkhVuSvQ48Gc/SRCO+lqdMyYlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGn9r22h; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGn9r22h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777490041; x=1809026041;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qyLpkDv6w7T+iKDG1NCKgxJr5jNr96IUb+5b7RDdg/w=;
  b=dGn9r22hRXJEHQlnW5K5OE5ycT1bJnrabMMFyyb7xsVfzR0J5Y12FcYs
   r75th/mEOfTHhkXAyKoC2PJauEftpG8wi0ms4B+4eEIyHjg0xH/LCijVo
   PeMhOS+J4+0C+pZLNVAMF5HT/r5EBw7KjcwzuMoZDjNxeXBp5caZ8vl6x
   Rt3oXW35clW6oH03DU1+FydGfNR4aOZs+hfyKl6Q4hL1Regr+ljZoscRd
   3h3a5bR/LvIr9Ax0EXS7cZCXWVujB7dBxCAiWZSt8HFl7Oh0SwQvCIkWZ
   9Zvb/gYEzsKU172biuM/d2YAaWR7MT3pxkFsufqoVNFyhrr+yafhVSRff
   A==;
X-CSE-ConnectionGUID: uKTrP30fS1iULldoKrGb2w==
X-CSE-MsgGUID: DVqC/dItSTO7oImW87LFHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78537894"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78537894"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:14:00 -0700
X-CSE-ConnectionGUID: ppAs5IWnRDWpkJ8axEGwIw==
X-CSE-MsgGUID: FQTFs0zFSe+CNhBM3I0MfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="238329685"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.38]) ([10.125.109.38])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:14:00 -0700
Message-ID: <bec89bd5-c1b1-4fd4-8864-42beeaf88b62@intel.com>
Date: Wed, 29 Apr 2026 12:13:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/mbox: Support Media Operation
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, dongjoo.seo1@samsung.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org
References: <20260428200410.705675-1-dave@stgolabs.net>
 <1999de6e-7f14-41d2-ace2-db00faede674@intel.com>
 <20260429190654.mhu6bh2ni2o5g7bp@offworld>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260429190654.mhu6bh2ni2o5g7bp@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/29/26 12:06 PM, Davidlohr Bueso wrote:
> On Tue, 28 Apr 2026, Dave Jiang wrote:
> 
>> On 4/28/26 1:04 PM, Davidlohr Bueso wrote:
>>> Add support for the Media Operation command (opcode 4402h) which
>>> enables targeted sanitize and zero operations on specific DPA ranges,
>>> as defined in CXL 4.0 Section 8.2.10.9.5.3.
>>>
>>> Operations are only allowed on DPA ranges that do not overlap any
>>> hardware-committed endpoint decoder to ensure not corrupting active
>>> mappings.
>>>
>>> Following the path that we currently impose for background cmds, where
>>> users are left with the responsibility of breaking up work sanely, this
>>> implementation imposes an arbitrary limit of 1Gb range to avoid hogging
>>> locks (ie: region/dpa cannot change while media op is on going) and resource
>>> monopolization such as mbox. As such, background commands are processed
>>> synchronously, with a 30s timeout, and currently, per spec, there is no
>>> optional abort it either, nor a way for the device to inform how long the
>>> op could take, ala Scan Media. The observation is that this differs in
>>> semantics regarding the sanitize case, which for whole-device continues
>>> to be handled asynchronously, as a special case.
>>>
>>> Run Discovery during probe to get the device's DPA range granularity
>>> and which operations are supported, and expose to sysfs accordingly:
>>>
>>>   o 'security/sanitize' is multiplexed to allow single ranged input.
>>
>> Maybe just introduce a new sysfs attrib instead of multiplexing?
>> security/sanitize_range
> 
> I am torn between the two options - I do like just a single file.
> But I also like that its own file eliminates that strange async/sync
> handling, which might be a more important factor to consider. If we did
> this, I would rename zero to zero_range as well, for consistency.

The sysfs kdoc [1] says single value is preferred and if not, multiple of the same value type as an array can be considered. We may be pushing the boundary of same value type with range and length. Either way, probably should split out so it's not multiplexing 'sanitize'.

[1] https://docs.kernel.org/filesystems/sysfs.html

DJ

> 
>>
>>>   o 'security/zero' is added, also with single ranged input.
>>>   o 'security/range_limit' is added so users can see the max range supported.
>>
>> media_op_range_limit?
> 
> Ok
>>
>> Can you split this into 3 patches: discover, sanitize_range enabling, and sanitize_zero?
> 
> Ok
>>
>> Would be great to get some cxl_test coverage on the new added ops.
> 
> Right, so far I have used qemu's support to test, I will add cxl_test coverage
> as a follow up to this work.
> 
> Thanks,
> Davidlohr

