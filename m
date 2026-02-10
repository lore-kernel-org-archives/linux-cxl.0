Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B401A08A3;
	Tue, 10 Feb 2026 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735639; cv=none; b=MtcMzU81TkaX5BlX+T1Xv//JqPazXj7B4HSfFS2MG0CPBlrAo95ybZUfvb2+Xh7UbYyCEFnu7nsj5BI7dGrHBNdu//5CbUSGl5dOEBvq13EnJKlry3RbEaZkeDSifhrHlTX7PUaWyr4KIXZBbsNupcAtdmGQ3QwXJ9ToZNmhqCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735639; c=relaxed/simple;
	bh=VBWi6seDwTX2jJZl+/ncQg0eXAWARvIs+R/QW7n9bZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkZog0176NDYaOubZP8o4v1Vr4QJq0TL3fB4T0DRj0x+IUkYTfhF/M1+gV/OjUBp+omRUCGprtb5r9yTafxu3UytTD2phfZrIGca+h24ZUhWFdCkeOGFhDB5+IeDVhIsicDQEz9aosA241EhiOfl1LxtJT084im7hC/2Z+dTGNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g61OslKY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g61OslKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770735638; x=1802271638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VBWi6seDwTX2jJZl+/ncQg0eXAWARvIs+R/QW7n9bZ8=;
  b=g61OslKYBC0zEHAtsCyzIQm3UJ1EYSbnLuF1szyNA6iVhqhk0GXSOaEi
   sqT4KCm5y2SXia/Q+vcziH4XA3qTCqSz/voIHpx/T2pHIwfOJCNoDuCo8
   nxIxxeQqD8xh1+q16A7vOy71Ksc2PHxBHJa0hDg6aYLm5JlstYH1oPrWO
   zy4f2r2Nh6RnsqsqqOvTY7oM0CqgjR3QF5i2F0VQ8WWyOjqx6Pryk0Qoh
   GS8pz4DiVtJKc9sWqI4paIKC7tTjbFED94oQ4+iHG+Uivh+7DYVdqseBB
   2FM3JLYM2uKw90E7CFpB4iCbXq/fAJjB6iIUT8bgIhBvo7SVePCngRPT2
   g==;
X-CSE-ConnectionGUID: sxOaxHYFQZaWSm1dPeglqA==
X-CSE-MsgGUID: rHmw3LVSRdSGAa/2aMn99A==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="94507935"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="94507935"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 07:00:38 -0800
X-CSE-ConnectionGUID: mN+64WHcSpWyWH0zHNR7BA==
X-CSE-MsgGUID: T91y0c3FQYyLSuRCb8tMlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="249587423"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.49]) ([10.125.108.49])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 07:00:36 -0800
Message-ID: <6cc9d925-0aea-4104-b58c-984f455b157f@intel.com>
Date: Tue, 10 Feb 2026 08:00:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix port enumeration failure
To: Li Ming <ming.li@zohomail.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260207133512.306128-1-ming.li@zohomail.com>
 <aYqgQ3QgaedMhNny@aschofie-mobl2.lan>
 <4eefdae3-125e-4c80-9968-8d20648f33bd@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <4eefdae3-125e-4c80-9968-8d20648f33bd@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/10/26 4:56 AM, Li Ming wrote:
> 
> 在 2026/2/10 11:04, Alison Schofield 写道:
>> On Sat, Feb 07, 2026 at 09:35:10PM +0800, Li Ming wrote:
>>> I ran CXL mock testing with next branch, I usually hit the following
>>> call trace.
>> Hi Ming,
>> I started hitting this after you first posted, however it takes me a
>> long time to hit it. Do you have a method to reproduce that is better
>> than running on repeat as I do? Thanks!
>> -- Alison
>>
>> snip
> 
> Hi Alison,
> 
> My environment is a VM with 2 CPUs, maybe you can try it.
> 
> I use a script to run "meson test --suite=cxl" again and again in the VM.

The other day Alison showed me the --repeat=N parameter for meson test. You can use that instead of script unless it does something special. 

> 
> I can typically reproduce it within 30 minutes, I have also encountered cases where it fails to reproduce even after one or two hours.
> 
> 
> Ming
> 

