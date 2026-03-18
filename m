Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D973E558D
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851735; cv=none; b=ITx3m+Aoz6xXoL0266OLBYKQABw9Y7r0Ju6EoKacQO6d8ZvCPNtZFMsslnjq/J9DeYdBROekxJI53RrLLIANhRV6RJvScaqp0FFhSX83t2kgDQrjE1ZTS91GcLVaxgiBUTp85owVk45aYO4K5qzIBDcSezjPkgGnbzsk1qLbj00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851735; c=relaxed/simple;
	bh=ap7zKJiiul3BemBQUBWg86idpa9dhRPPaoHV5glgM/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CFjR5UU7/7n3JtG0bbvZ+/4BEGjhf4IqqYqk8ZuwaArFD85IiCiioivcPl4WWq2Z4qpBhZbQFFJoq3+sS7ng9ZtZ5whJ25ssE7n+zmoenHo4tKntvOogt7ZhzqJ4d3uP8FZD8JvILbTHns2ka2d2uRzrR42RhjZTP0NreRbiHyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9uE47mp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9uE47mp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773851733; x=1805387733;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ap7zKJiiul3BemBQUBWg86idpa9dhRPPaoHV5glgM/4=;
  b=h9uE47mpr9qt/P2vKKdkkRmtTKbKwvi5DZMM+yhZj871b2iC/1gsAuXJ
   13EXXU+mgViQbrxYJaFHiqz+Rd7lDHftiP7uf9FcQkYIwY3JqYW+mtluO
   HwoEiDi2SqTtBMfBlFojCXjtQOgOfmORKfijtXH+w3n9/iiTzLgT+2IVi
   wxaI5rLGhE/q+lHJ34jcOHqSCwphtTpXzqvI/uZdrL79vOUIIwunZwYmy
   ZYZ3LKjLseslk+grNpwXYxANvxwf/FQWVGPHPNVTBgKJDtZ+ewckceZTc
   QDJjGnMn1crt4Vo8TYGR5wit2pBKNTGK9L3/cX29Vf4L1lAU1XWX5y29E
   w==;
X-CSE-ConnectionGUID: pPMXLd06SQW5XWoepUMu8g==
X-CSE-MsgGUID: Z78VqCbvSMWdNcImxgcB8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="92485697"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="92485697"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:35:32 -0700
X-CSE-ConnectionGUID: yhP3j2qIRFC/KJ2l5xp52Q==
X-CSE-MsgGUID: vHS2CeP+RoK/pJxOH1sPHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="221761732"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.242]) ([10.125.108.242])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:35:32 -0700
Message-ID: <ce2df8e5-e1b9-4522-b84b-b721ceb09b26@intel.com>
Date: Wed, 18 Mar 2026 09:35:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 00/22] Type2 device basic support
To: Alejandro Lucero Palau <alucerop@amd.com>,
 dan Williams <dan.j.williams@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <177370560728.3363103.17662978404400921244.git-patchwork-notify@kernel.org>
 <652bacbf-6985-4bec-b973-684f2702765f@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <652bacbf-6985-4bec-b973-684f2702765f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/18/26 12:42 AM, Alejandro Lucero Palau wrote:
> Hi Dave,
> 
> On 3/17/26 00:00, patchwork-bot+cxl@kernel.org wrote:
>> [You don't often get email from patchwork-bot+cxl@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hello:
>>
>> This series was applied to cxl/cxl.git (next)
>> by Dave Jiang <dave.jiang@intel.com>:
>>
> 
> I'm confused with how you did the merge. It seems you applied first the new patches which deprecated some from v23.

Hi Alejandro,
I would ignore patchwork bot emails. It gets a bit weird at times. I only applied the patches you split out. These are the patches I have right now. I will push a 7.1 type2 branch for you so you can rebase the rest of your stuff on it.

64584273dfb8 cxl/region: Factor out interleave granularity setup
29f0724c4592 cxl/region: Factor out interleave ways setup
09d065d256b1 cxl: Make region type based on endpoint type
d537d953c478 cxl/pci: Remove redundant cxl_pci_find_port() call
58f28930c7fb cxl: Move pci generic code from cxl_pci to core/cxl_pci
005869886d1d cxl: export internal structs for external Type2 drivers
9a775c07bb04 cxl: support Type2 when initializing cxl_dev_state

DJ

> 
> 
> I'm afraid it does not work when trying to compile the sfc driver and some files are missing like include/cxl/pci.h
> 
> 
> I will try to give you more information about what I think is wrong. On another note, sfc changes are not included, what I guess is fine, but did you discuss this with the netdev guys? I remember someone asking about how to applied the type2 series as it crosses subsystems, but it was time ago, after the first versions.
> 
> 
> Thank you
> 

