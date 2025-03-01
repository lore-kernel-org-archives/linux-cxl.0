Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4C17BB6
	for <linux-cxl@vger.kernel.org>; Sat,  1 Mar 2025 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788870; cv=none; b=lG+nYyW4UYac6uSNxcPrefHqinjxO9WwL3xRM0bAOm6SMkaNJzBW3iJ4Inc3hVx9rGkFuZTIaK091lMT8A4Q9LM4NL2rOTzHw/ImHQY2aYBWzzCIkB32seXCRfvvkr4MxuZkw1m9uQnSBKrMN4ZFfAxxbkV0TJ76fRB+zMG9sfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788870; c=relaxed/simple;
	bh=VE3/DN8Klku1WEW3zHuaF16mFkREDppPhGYxO/eDQtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJC5IyZFvAm6zC0QFcEUz+o0enLIyZOS7G2rh1gdq27bDMcz//aGnqm/jdvbkrNPl/lxtpo1Sh+9UjM+2HqGui1DR119D2DWaeDhZEMFYkiPIPd/N3HuD0X3W3qjtZiwY+eVsEFk0mjONzZej1xgmUQz1oOcUb1smvSMPo07BXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjzQLW8A; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjzQLW8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740788868; x=1772324868;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VE3/DN8Klku1WEW3zHuaF16mFkREDppPhGYxO/eDQtM=;
  b=RjzQLW8A4IO2CYHfR+WJtESUSt9l8vMQjTjG3IwopfRBReOZVKcuU8B+
   psXICwsaO57w6kSq77Wyi2SeOVbU8vHTA2JPD/Wv3wu7ti8LiN/5YFsH6
   1KguHUSsLseIv71H+LK5toMYmNPThCbwwXir/4ES/k8i+mYWI2vH3QKp8
   Oc5gvDOHMBay8oKuaoQyBHCMD5RZx4s9zsPvqr70az+jm96LSvRSaqxCq
   8bi7XB8zbKbIH6dd3FSEk6oHKNrzN9xgp8PG+7SzOCNaXAnh01fRX4R5y
   iXOfLkDvxU87iKJZ2i+D2Pc+dIi/kWsSJJyZUXux+yPwMYFER253Lkb6E
   w==;
X-CSE-ConnectionGUID: ECQENDAdRl6DxM/JIEouMQ==
X-CSE-MsgGUID: 78lApdcgT6W+FV5GnmV0Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45649739"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="45649739"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 16:27:47 -0800
X-CSE-ConnectionGUID: Y9JcdqOOQaa7PWPXyP3+AQ==
X-CSE-MsgGUID: MUjodcM7Q3W7hnKeMnQrVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122616319"
Received: from unknown (HELO [10.24.8.144]) ([10.24.8.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 16:27:48 -0800
Message-ID: <6c3c85c1-7bf1-4039-aa72-2a0086c22865@linux.intel.com>
Date: Fri, 28 Feb 2025 16:27:36 -0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
To: Itaru Kitayama <itaru.kitayama@linux.dev>,
 Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
 <9b1492d7-ffa8-4d61-a101-4fa9c2d71ae3@linux.intel.com>
 <AD05AE2B-9AA4-4E60-AEF7-705281368838@linux.dev>
 <8b538927-6825-4e01-a24b-f58b93631829@intel.com>
 <98DAF41D-01E0-4594-B8C9-D8FF046FA19C@linux.dev>
Content-Language: en-US
From: Marc Herbert <Marc.Herbert@linux.intel.com>
In-Reply-To: <98DAF41D-01E0-4594-B8C9-D8FF046FA19C@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-02-26 14:04, Itaru Kitayama wrote:

>> There's a known lockdep false positive that can trigger and cause cxl_test to fail. Does the kernel OOPS go away once you disable lockdep?
> 
> Instead of disabling lockdep, pulling cxl next this morning, so far made the spurious error go away.

I think that's just luck. I've also seen this lockdep test failure
coming and going (in QEMU) depending on configuration changes, kernel
commit, phase of the moon and weather of the day. There's clearly a race
somewhere (whether it's a false or true positive) and in my experience
the only reliable way to silence this message has been to turn off
lockdep etc.  in .config.

Maybe the fancy new concurrency-fuzz-scheduler could help reproduce?
https://lwn.net/Articles/1007689/ It sounds really cool. It could also
wake up too many zombie races and meltdown the whole system :-D
