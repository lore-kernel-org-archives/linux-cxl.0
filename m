Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B8250AC11
	for <linux-cxl@vger.kernel.org>; Fri, 25 Sep 2026 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790380372; cv=none; b=lgkdkD/7rCVjpIWvAgNLtuv35aiE1V0HJGfqAnQFUrVHeQSZ7PAPtZwZs8JG2j41eG3ShZYxY0hcYY89++/8UltP/+kyl25t3CjxjKOeVhyEhpAZFBY7tXndsVEHOaFSY+rodwQL7HTR0G7Ajcdb76ScI+He2o8XJuxsd61xcwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790380372; c=relaxed/simple;
	bh=bU1UDkUXxubI1odZgL6pJNGXVTnNuOq5lvgHez8KpAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncLaI0o4t/BTSroImHOwIAkH23Mdk/1j9rwVu55pl29V8zhmpv4etbc8EB/kZNIRrgFqpzAdD4OLUl3RREwc2Fmvzvq86cRzZtGpSKrPZXzIrEaOMHfccAAuSbaUOK64gOyfm02SYPyc+EGMxexFWpnDFW2eHAlZlRBn/M79hDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1R0jU96; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1R0jU96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790380371; x=1821916371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bU1UDkUXxubI1odZgL6pJNGXVTnNuOq5lvgHez8KpAw=;
  b=S1R0jU960xZ7EbpWHnkb2G0Zf1w5L7pHspewV4+w7Ftg0rQP5805Kb+B
   VTHgGxY160OiX4fbS2dJ8FVQd84u1ny05B9xeWeVU93X4g2xOlPUtzBvo
   Szn+BRBtWZk94QFtG8si+NHbHH0AYPIYcGluYAf4ZDdHL4wnsySNOP7Hl
   mZuIHO1O7YlN7/z1u2cGsAwbxM8ktm7bn0erjE/FxnzX/ddYQjToJJEfJ
   cvcolivKPt7Npq0RT5rEVssW/557vvJe+SNxWMrUW5A9Vs+2edTz/tvNY
   fR36CjNoj06Ygd6BjY0uEBsQGV0rGThFXJGHuR/tpflrS39cr8P4SbSb2
   w==;
X-CSE-ConnectionGUID: BRglnkfORv+1KPTDA20q2Q==
X-CSE-MsgGUID: 9sCN/mB1TJGO1GrlKnH1Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="94053004"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; 
   d="scan'208";a="94053004"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 16:52:50 -0700
X-CSE-ConnectionGUID: i4itnZOxSDS9eAWfqdQV7g==
X-CSE-MsgGUID: RDj48lFLR2CcH7gOuwgPuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; 
   d="scan'208";a="302394031"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.110.251]) ([10.125.110.251])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 16:52:49 -0700
Message-ID: <0f3b2ed5-d797-4914-b4bc-e0e83475ee42@intel.com>
Date: Fri, 25 Sep 2026 16:52:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/mbox: Store event records for EDAC repair regardless
 of tracing
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, alison.schofield@intel.com,
 ming.li@zohomail.com, icheng@nvidia.com
References: <20260924212320.56573-1-dave.jiang@intel.com>
 <20260925234425.67be0e2e@jic23-hlaptop>
 <a266e6db-eb28-4ca9-9214-de62df8b10b0@intel.com>
 <20260926005053.4c823321@jic23-hlaptop>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260926005053.4c823321@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/26 4:50 PM, Jonathan Cameron wrote:
> On Fri, 25 Sep 2026 15:53:23 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 9/25/26 3:44 PM, Jonathan Cameron wrote:
>>> On Thu, 24 Sep 2026 14:23:20 -0700
>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>   
>>>> The driver throws away media error records unless a tracepoint is enabled.
>>>>
>>>> cxl_event_trace_record() stores general media and DRAM records for EDAC
>>>> repair, but both calls sit inside a block gated on the cxl_general_media
>>>> and cxl_dram tracepoints. That gate only exists to skip the DPA-to-HPA
>>>> lookup used to annotate those tracepoints. Storing a record does not need
>>>> the lookup.
>>>>
>>>> With both tracepoints off, two things break. The kernel clears the device
>>>> event log either way, so the records are destroyed in hardware and kept
>>>> nowhere else. And live repair stops working altogether: sPPR and memory
>>>> sparing require the target DPA to have reported an error, no DPA ever has
>>>> a record, so every request fails with -EINVAL.  
>>>
>>> Hi Dave,
>>>
>>> Given userspace is always in that path (I think), without the
>>> tracepoints being enabled it will be one impressive guess to
>>> successfully make repair happen - you'll have to magically know
>>> what address will see a hit in the stored error records.
>>>
>>> Maybe that happens in some test case, but it doesn't feel real
>>> to me.  
>>
>> If you don't think that's possible then I'll drop the patch.
>>
> 
> It is possible if you injected the error and so know where it is.
> We may also get other paths by which people obtain that info such
> as anyone who is reporting via fabric management paths.  I just
> don't think it is a fix and perhaps we should wait for a user
> to come along who needs it.

Sure we can just wait.
