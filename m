Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8F241C98
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598247; cv=none; b=UTFztQSTnomtQh+dZ6k6sxVH3N1VQ9whEIzquwbJNf6P49CiAisyKy9fBBkQYCsk3uOpj3DN2UAoX9QozU9r3COxMYC/1I2Y5ZIiDJ6uM1daclypr1MsvokW/B1zR4l+qgvb/ysaYmz8wuTwqFYI1L9uQ8Di9wGkxxFX09cB9vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598247; c=relaxed/simple;
	bh=wJ1OmMNJSpgNVpZI1TRbbQxE170WRVW3aCYos3vm6Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YE6jy03Z0pZu/+yohhKWxNqUjGkeY5igyFEv4SxxxECxIUPsKqofpQNhkrANPuGJK7BOk1giycMbR6MnXbh86AGYTfnJALo7bD3/k/A1skn9jECwZ/aVreuMfLnfpNGpS3enQoGmImCBdMEXfiyfkabPAZtKkA4B8Nuvs+c4INs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cby+D7N0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cby+D7N0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740598244; x=1772134244;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wJ1OmMNJSpgNVpZI1TRbbQxE170WRVW3aCYos3vm6Gs=;
  b=Cby+D7N0X2sT0DSxlmln3md6cRAl6N2QbApNPkZYUpM0oIqzktDSzluz
   EPI9sZFiBwvUCUaYwH8Y/bGEtu+/vGfCAqczeEBe3slfu1V2iJC3WrODH
   Bg8CWo9qSUNti3hy5tQpBktZ4QEAO8JrAtfw960mLRrpJnCQ8yJiJo2jf
   LOLcb7xWKHBXWSSpz8QDlKECXjzsL+tGLO9Ovdj+sFlzWm3MSkm/cX44R
   QtPxkJQTAckGfTXoRMFE4csXJHBmzBQpvLRbF0e8XUb3VlB/ZYHZYSVAq
   SGOlctJDMC+sxYrrr7rmphm6HgV30qnkKEiinaLF2vhRaJPSSeZuKEhIB
   A==;
X-CSE-ConnectionGUID: iJw+pQ2rTv+Y4DIl6zIKnQ==
X-CSE-MsgGUID: wXkaIuF3RAuZQDnh8vlbsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="63935413"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="63935413"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 11:30:42 -0800
X-CSE-ConnectionGUID: SmCwF9alSfepQtBTJgbkNg==
X-CSE-MsgGUID: CI0eBMIdQpOgqAle4S9o0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117308774"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.108.7]) ([10.125.108.7])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 11:30:43 -0800
Message-ID: <8b538927-6825-4e01-a24b-f58b93631829@intel.com>
Date: Wed, 26 Feb 2025 12:30:42 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
To: Itaru Kitayama <itaru.kitayama@linux.dev>,
 Marc Herbert <Marc.Herbert@linux.intel.com>
Cc: linux-cxl@vger.kernel.org
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
 <9b1492d7-ffa8-4d61-a101-4fa9c2d71ae3@linux.intel.com>
 <AD05AE2B-9AA4-4E60-AEF7-705281368838@linux.dev>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <AD05AE2B-9AA4-4E60-AEF7-705281368838@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/25/25 3:37 PM, Itaru Kitayama wrote:
> Hi Marc,
> 
>> On Feb 26, 2025, at 2:08, Marc Herbert <Marc.Herbert@linux.intel.com> wrote:
>>
>> On 2025-02-24 20:09, Itaru Kitayama wrote:
>>>
>>> Has anyone noticed the ndctl cxl test suite failures I reported below on arm64, QEMU emulation?
>>>
>>> https://github.com/pmem/ndctl/issues/278
>>>
>>> I’m using Jonathan’s latest CXL capable QEMU [1], and the latest CXL kernel [2].
>>>
>>
>>
>> Hi,
>>
>> Sorry I wanted to spend more time and share a more detailed answer and
>> of course I got side-tracked.
>>
>> Do you have CONFIG_RANDOMIZE_MEMORY on?
>>
>> If yes then please try this either this:
>>
>>  cd kernel
>>  ./scripts/config -d CONFIG_RANDOMIZE_MEMORY
>>
>> ... or this:
>>
>> --- a/run_qemu.sh
>> +++ b/run_qemu.sh
>> @@ -681,6 +681,7 @@ build_kernel_cmdline()
>> "initcall_debug"
>> "log_buf_len=20M"
>> "memory_hotplug.memmap_on_memory=force"
>> + "nokaslr"
>> )
>> if [[ $_arg_gdb == "on" ]]; then
>> kcmd+=(
> 
> I chose the kernel configuration change and rebuilt the kernel, modules installed, then finally cxl_test kernel module installed on the emulated system, but I got worth results (occasionally, the kernel OOPS as well):

There's a known lockdep false positive that can trigger and cause cxl_test to fail. Does the kernel OOPS go away once you disable lockdep?

DJ

> 
> Log of Meson test suite run on 2025-02-26T07:32:24.101461
> 
> Inherited environment: LANG=C.UTF-8 LS_COLORS='' TERM=xterm-256color PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin MAIL=/var/mail/root LOGNAME=root USER=root HOME=/root SHELL=/bin/bash SUDO_COMMAND='/usr/bin/meson test cxl-region-sysfs.sh' SUDO_USER=realm SUDO_UID=1000 SUDO_GID=1000 
> 
> ==================================== 1/1 =====================================
> test:         ndctl:cxl / cxl-region-sysfs.sh
> start time:   22:32:24
> duration:     0.71s
> result:       exit status 1
> command:      NDCTL=/home/realm/projects/ndctl/build/ndctl/ndctl DAXCTL=/home/realm/projects/ndctl/build/daxctl/daxctl TEST_PATH=/home/realm/projects/ndctl/build/test UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MALLOC_PERTURB_=29 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 DATA_PATH=/home/realm/projects/ndctl/test MESON_TEST_ITERATION=1 LD_LIBRARY_PATH=/home/realm/projects/ndctl/build/daxctl/lib:/home/realm/projects/ndctl/build/ndctl/lib:/home/realm/projects/ndctl/build/cxl/lib /bin/bash /home/realm/projects/ndctl/test/cxl-region-sysfs.sh
> ----------------------------------- stdout -----------------------------------
> test/cxl-region-sysfs.sh: failed at line 40
> ----------------------------------- stderr -----------------------------------
> + trap 'err $LINENO' ERR
> + check_prereq jq
> + command -v jq
> + modprobe -r cxl_test
> + modprobe cxl_test
> + rc=1
> ++ ./cxl/cxl list -b cxl_test -D -d root
> ++ jq -r '.[] |
>   select(.pmem_capable == true) |
>   select(.nr_targets == 2) |
>   .decoder'
>   Warning: no matching devices found
> 
> + decoder=
> + readarray -t mem
> ++ ./cxl/cxl list -M -d
> ++ jq -r '.[].memdev'
>   Error: switch `d' requires a value
> 
>  usage: cxl list [<options>]
> 
>     -d, --decoder <decoder device name>
>                           filter by CXL decoder device name(s) / class
> + readarray -t endpoint
> ++ ./cxl/cxl reserve-dpa -t pmem -s 268435456
> ++ jq -r '.[] | .decoder.decoder'
> 
>  usage: cxl reserve-dpa <mem0> [<mem1>..<memn>] [<options>]
> 
>     -b, --bus <bus name>  Limit operation to the specified bus
>     -v, --verbose         turn on debug
>     -S, --serial          use serial numbers to id memdevs
>     -s, --size <size>     size in bytes (Default: all available capacity)
>     -d, --decoder <decoder instance id>
>                           override the automatic decoder selection
>     -t, --type <type>     'pmem' or 'ram' (volatile) (Default: 'pmem')
>     -f, --force           Attempt 'expected to fail' operations
> 
> ++ cat /sys/bus/cxl/devices//create_pmem_region
> cat: /sys/bus/cxl/devices//create_pmem_region: No such file or directory
> + region=
> ++ err 40
> +++ basename /home/realm/projects/ndctl/test/cxl-region-sysfs.sh
> ++ echo test/cxl-region-sysfs.sh: failed at line 40
> ++ '[' -n '' ']'
> ++ exit 1
> ==============================================================================
> 
> 
> Summary of Failures:
> 
> 1/1 ndctl:cxl / cxl-region-sysfs.sh FAIL             0.71s   exit status 1
> 
> Ok:                 0   
> Expected Fail:      0   
> Fail:               1   
> Unexpected Pass:    0   
> Skipped:            0   
> Timeout:            0   
> 
> 

