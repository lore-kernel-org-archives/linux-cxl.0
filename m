Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF021A444
	for <linux-cxl@vger.kernel.org>; Mon, 19 May 2025 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691266; cv=none; b=YqCK8Xtvgqfs7E/uQQsCT4p6JFwafEdn1WUbGAu0o3pD1m+I+98Czqfo/a9CK36CI8U01SI9d4ankBJxNM573nulF0Jvbj77HXU72QM1P0epb91L/rom7TGKO9Ec2mvPKSwHYCBL7IfPPF8n2T+2S8S8d5WXjdHLFam4TTSw64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691266; c=relaxed/simple;
	bh=w1xJGVhpynvQpLAnXndbNlTsbg9LROoen7zvwy0nBuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZC0Rn2x5yeuCrZh3lxLwacd4yUp1oODmxL857/E3GJyN/930HWlzFaFkSnCkmHUBubrclHUYvlLpmdz3FH6zTduVHD12WdeP6Yq2t9F5kHeJ8H7U6LFF3fdAyWRD4bV9oxIPQMQFoBdaoMuNeH9v7LtnCu2d2dh9nf7fc5lH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/jOH0Bu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/jOH0Bu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747691265; x=1779227265;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w1xJGVhpynvQpLAnXndbNlTsbg9LROoen7zvwy0nBuI=;
  b=L/jOH0Bu3PQhCVh7tswoLBjkd7vYfmx/YG1nDSah37Gy2bGwyU43k0Jz
   x5DXms0gIj5Xi5T0BQhKXYTiDsgK0Kzanh/atfTPzuwTobk5DFg9Hn+8p
   Zc0DYZYG68JJbykMFEJwI5S786YTLMok6nmOXNw07q/xildAI3UQUxwRc
   bOzOKKl+db6uEHRWeoENp7wzoFwvJvR2d1k2SsA60LZ68POkkxu0dJGaY
   CY4EqnH0gBO0D9FGBqxvf8QTL1/+s3irzJ9yPI9KjHZqy75f4/6Hxye9x
   r+gFAIxwVfFy4N/Pec1f37zIX9ZvoxeGlN2ElKpWJbtMCtKv2JLw1+Jtb
   w==;
X-CSE-ConnectionGUID: VJHFF97JSkiNFVAekppP4w==
X-CSE-MsgGUID: G35x3D9lR466ojfZt1Fsfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="67018183"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="67018183"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 14:47:45 -0700
X-CSE-ConnectionGUID: XJT7PDY3QruTzeBBwIBNCQ==
X-CSE-MsgGUID: 0xmIyxVjTKKJ4L1ZfYKROw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="139381174"
Received: from agrisant-mobl2.amr.corp.intel.com (HELO [10.125.1.252]) ([10.125.1.252])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 14:47:44 -0700
Message-ID: <3f7bd5b0-4c1b-4a55-bc9b-2b6e75ab9a39@linux.intel.com>
Date: Mon, 19 May 2025 14:47:36 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/cxl-xor-region.sh: remove redundant waitting
To: dan.j.williams@intel.com, "ruansy.fnst" <ruansy.fnst@fujitsu.com>,
 linux-cxl@vger.kernel.org
Cc: vishal.l.verma@intel.com, sunfishho12@gmail.com
References: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
 <6827d6e591443_4ba8f100f1@dwillia2-mobl4.notmuch>
Content-Language: en-GB
From: Marc Herbert <Marc.Herbert@linux.intel.com>
In-Reply-To: <6827d6e591443_4ba8f100f1@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-05-16 17:23, dan.j.williams@intel.com wrote:

> 
> So the assumption is that interfactive invocation of cxl commands should
> arrange for a stablized snaphshot of the topology state.
> 
>> Now I am facing a problem that cxl command takes a long time to complete
>> when I run it in a udev rule(do some configuration when CXL memdev is
>> added).  I found it is caused by this function: waitting for udev
>> queue's endding but itself is in the queue.  The cxl_wait_probe()
>> function does not seem to allow me to do that.
> 
> Yes, that is a problem.
> 
>> So, the 2nd question is: is it against the spec to run cxl command in
>> a udev rule?
> 
> No we need to find a way to make that work, so I consider this a bug
> report. My initial reaction is that when called from a udev rule cxl-cli
> should honor a new environment variable, perhaps "UDEV_CXL", that
> disables this waiting that is only meant for human interactive mode.
> 

If the distinction between two such "modes" is indeed desired, I don't
think the name should point at the first known use case (UDEV) for
it. For instance, you could also imagine that while some parts of test
code want the current, blocking and "stabilized" behavior, other parts
of some (other) test code want the currently missing), "fast" and
unstable information without waiting. There could be other use cases, so
in general the user interface (if any) should describe what it does, not
who it is for.

Also, why not just a new command line option like cxl --no-wait?
Environment variables are convenient to cut through layers but they are
also invisible which tends to cause debugging nightmares.  Bonus point
when racing against something like else - which is exactly the case
here! I can already feel for the poor soul copying commands from the
logs of some test failure and missing the magic environment
variable(s)... been there, done that.

PS: while... waiting for such a fast/no-wait/unstable option, I see no
reason why systemd would not work.
