Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000502309AD
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523691; cv=none; b=NfacMDWS0x88glcPbYb9n2AgwMYNVMjHlsJEYA9KSOPBSUNTCpyxmf6qexc/8WJw0zhXD8zMPoOwjW2SWoEdK2oEezKyBPTV52JE1M3hzqJVFw5vCSSx0TpmnuDIOW3HU2+6VI/8Syp0fhpWv2XEbk/5zpqmBskkYeoM1W4q3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523691; c=relaxed/simple;
	bh=rMJFRsnojb23leByNEaVh/je0imshUBG9QO1T1cVrjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH7AnKsuZwugVu7Lsj3bAzfaOsYX4T+PkmOeGoZ0OyJdHyQPAsA3dH2PCZLQNmepJo6Va76GarA2up27+6cAol9DPottIjPosJKDjTRjIAw/C31Fh1w11IEX0OUJjoE6iCmld+TKwY1i+zrW7qNQlAUscA0vZd58bGETS2vGkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpK3tkvE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpK3tkvE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740523689; x=1772059689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rMJFRsnojb23leByNEaVh/je0imshUBG9QO1T1cVrjA=;
  b=FpK3tkvES5D9Izhyu91EyuvQGIerWTzr9XLAIloSJV31uU51Pda2Kvue
   cI7wWcqQjF7lzobYoDhQyZgzhAAeA2F3Je/t8HSB/t+feHHQuy14FjN9C
   l9KNchlXrd0CHL4GNc4iU2hxLyMzRLqnWQpjUzTY+GTuCS7tpVmv8kIjl
   mk2lPRRqCAl26OpGJ9zaInbIR5nPf/r/D9sVPtq0S2aFkSVjZM+lWB/mD
   XT4xHa7QKqHupGjC4JnoeXWB5f3k66kxJoo0WiUbhYQeXoc9+TBQ990aw
   iK3QsqgRwFfRSx+NsHYQWTQ87+q3AUWL/qmA3zA/c4Gb+S4lZ2mbWoWVE
   w==;
X-CSE-ConnectionGUID: Ain89TD3RLqke9T8aMcmxw==
X-CSE-MsgGUID: wfYCd3EqSBCnwVtvt7fV8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41373088"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41373088"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 14:48:09 -0800
X-CSE-ConnectionGUID: bVWWSKYxQsiL4U4xy9DSwQ==
X-CSE-MsgGUID: vhH2DPyISeqA/zCPZbE59A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="117145584"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.175])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 14:48:08 -0800
Date: Tue, 25 Feb 2025 14:48:06 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Marc Herbert <Marc.Herbert@linux.intel.com>, linux-cxl@vger.kernel.org
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
Message-ID: <Z75IpiYqA1sylXYx@aschofie-mobl2.lan>
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
 <9b1492d7-ffa8-4d61-a101-4fa9c2d71ae3@linux.intel.com>
 <AD05AE2B-9AA4-4E60-AEF7-705281368838@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AD05AE2B-9AA4-4E60-AEF7-705281368838@linux.dev>

On Wed, Feb 26, 2025 at 07:37:58AM +0900, Itaru Kitayama wrote:
> Hi Marc,
> 
> > On Feb 26, 2025, at 2:08, Marc Herbert <Marc.Herbert@linux.intel.com> wrote:
> > 
> > On 2025-02-24 20:09, Itaru Kitayama wrote:
> >> 
> >> Has anyone noticed the ndctl cxl test suite failures I reported below on arm64, QEMU emulation?
> >> 
> >> https://github.com/pmem/ndctl/issues/278
> >> 
> >> I’m using Jonathan’s latest CXL capable QEMU [1], and the latest CXL kernel [2].
> >> 
> > 
> > 
> > Hi,
> > 
> > Sorry I wanted to spend more time and share a more detailed answer and
> > of course I got side-tracked.
> > 
> > Do you have CONFIG_RANDOMIZE_MEMORY on?
> > 
> > If yes then please try this either this:
> > 
> >  cd kernel
> >  ./scripts/config -d CONFIG_RANDOMIZE_MEMORY
> > 
> > ... or this:
> > 
> > --- a/run_qemu.sh
> > +++ b/run_qemu.sh
> > @@ -681,6 +681,7 @@ build_kernel_cmdline()
> > "initcall_debug"
> > "log_buf_len=20M"
> > "memory_hotplug.memmap_on_memory=force"
> > + "nokaslr"
> > )
> > if [[ $_arg_gdb == "on" ]]; then
> > kcmd+=(
> 
> I chose the kernel configuration change and rebuilt the kernel, modules installed, then finally cxl_test kernel module installed on the emulated system, but I got worth results (occasionally, the kernel OOPS as well):

Yikes.

What is your ndctl --version 
What is your run_qemu cmdline?
I think you said kernel is cxl/next ?

The simplest one when I intend to use cxl-test is:
run_qemu.sh --git-qemu --cxl-test --cxl-debug -r kmod

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
