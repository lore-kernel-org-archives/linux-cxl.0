Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6423535E
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595524; cv=none; b=LqYNWwxW1BAKtcmn+uXiM//q3Yrz+YqhJGnzqQOYfqTH2DlmhODHoFeHhumTChhtO78ROuFQX6tkOt7Wf1/n5xWeuO9J2T8rxf1znwtndkvzFWQDf7L7iMj0wOjgcqg04RX5iz6ER/kLRN355YXUEncW56q/SK0fo+zRbf6rV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595524; c=relaxed/simple;
	bh=xd1kR86lNoWEHTADpo7Rjt5QhotkgA1nx33n8LMTZcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHb7Ty/aV90Uye6N6jb3eWvGmJV4rKIhrYBJiOWecHQP5w9HmZfpOh/q4ZKLaJvgHkBjoLv92elkodGOGxD8QjBEjjQBfRy4m+vDAasqr09Cwtrq28/lyHJnRq5yBkKJqoVgd9Qn3knNh0ZDm9z4ImNS0x+wey5geYI0/MOxcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzCXpF7s; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzCXpF7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740595522; x=1772131522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xd1kR86lNoWEHTADpo7Rjt5QhotkgA1nx33n8LMTZcQ=;
  b=LzCXpF7sZi6ieHhPmHaCEYX8IzXAZWBEg8GvqnrhabrWxIHj67MEE4x2
   /aWOMLLKAoENI6+D43oI8UlH4nWbxUYm4VfvTocdLfycb2ghoagpQpaTD
   Jf2PWSpgJqC5gKAnQDtgmG5+pNlibcRJAiB3YY0FmeJq4NoFw54YLWI1w
   X6ASpiznnqX6E8bTDPXdL+0TnGUKITVlbidinqqLZ2RI5u2Mz9UarFolD
   XwpOG75phefswmUJAq9V2P+shSG4NdbveWEGj1TIHa/bAtCwudTQDkLvh
   L5J5EO5vEoOXXM+qM06lqaNyxHlcPAlSzLRBtFRniiK1ki1sgIH8yw6ja
   w==;
X-CSE-ConnectionGUID: b0oWkqbcSoOjdSmCNFf02A==
X-CSE-MsgGUID: X5pU/jiST6axxhv79ZwErQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52099237"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="52099237"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 10:45:21 -0800
X-CSE-ConnectionGUID: tcrdPUQRSxGYTagr7+W55Q==
X-CSE-MsgGUID: rSfTR/uzRhSNAlaFwvvZ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="121792116"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.13])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 10:45:20 -0800
Date: Wed, 26 Feb 2025 10:45:19 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Marc Herbert <Marc.Herbert@linux.intel.com>, linux-cxl@vger.kernel.org
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
Message-ID: <Z79hPyNMymvM9Hlp@aschofie-mobl2.lan>
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
 <9b1492d7-ffa8-4d61-a101-4fa9c2d71ae3@linux.intel.com>
 <AD05AE2B-9AA4-4E60-AEF7-705281368838@linux.dev>
 <Z75IpiYqA1sylXYx@aschofie-mobl2.lan>
 <CE9B21EB-B7D5-4E40-901C-306689C4B4FA@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CE9B21EB-B7D5-4E40-901C-306689C4B4FA@linux.dev>

On Wed, Feb 26, 2025 at 08:53:12AM +0900, Itaru Kitayama wrote:
> Hi Alison,
> 
> > On Feb 26, 2025, at 7:48, Alison Schofield <alison.schofield@intel.com> wrote:
> > 
> > On Wed, Feb 26, 2025 at 07:37:58AM +0900, Itaru Kitayama wrote:
> >> Hi Marc,
> >> 
> >>> On Feb 26, 2025, at 2:08, Marc Herbert <Marc.Herbert@linux.intel.com> wrote:
> >>> 
> >>> On 2025-02-24 20:09, Itaru Kitayama wrote:
> >>>> 
> >>>> Has anyone noticed the ndctl cxl test suite failures I reported below on arm64, QEMU emulation?
> >>>> 
> >>>> https://github.com/pmem/ndctl/issues/278
> >>>> 
> >>>> I’m using Jonathan’s latest CXL capable QEMU [1], and the latest CXL kernel [2].
> >>>> 
> >>> 
> >>> 
> >>> Hi,
> >>> 
> >>> Sorry I wanted to spend more time and share a more detailed answer and
> >>> of course I got side-tracked.
> >>> 
> >>> Do you have CONFIG_RANDOMIZE_MEMORY on?
> >>> 
> >>> If yes then please try this either this:
> >>> 
> >>> cd kernel
> >>> ./scripts/config -d CONFIG_RANDOMIZE_MEMORY
> >>> 
> >>> ... or this:
> >>> 
> >>> --- a/run_qemu.sh
> >>> +++ b/run_qemu.sh
> >>> @@ -681,6 +681,7 @@ build_kernel_cmdline()
> >>> "initcall_debug"
> >>> "log_buf_len=20M"
> >>> "memory_hotplug.memmap_on_memory=force"
> >>> + "nokaslr"
> >>> )
> >>> if [[ $_arg_gdb == "on" ]]; then
> >>> kcmd+=(
> >> 
> >> I chose the kernel configuration change and rebuilt the kernel, modules installed, then finally cxl_test kernel module installed on the emulated system, but I got worth results (occasionally, the kernel OOPS as well):
> > 
> > Yikes.
> > 
> > What is your ndctl --version
> 
> I’m using GitHub’s latest.
> 
> >  
> > What is your run_qemu cmdline?
> 
> Unfortunately, it is x86 centric, at this moment it’s hard to use.
>  
> > I think you said kernel is cxl/next ?
> 
> Yes, I did.
> 
> > 
> > The simplest one when I intend to use cxl-test is:
> > run_qemu.sh --git-qemu --cxl-test --cxl-debug -r kmod
> 
> Instead, here are the options I use when emulating on arm64:
> 
> /home/itaru/projects/qemu/build/qemu-system-aarch64 \
>          -M virt,virtualization=off,pflash0=rom,pflash1=efivars,gic-version=3,cxl=on,acpi=on -m 16384 \
>          -cpu max \
>          -smp 2 \
>          -accel tcg \
>          -nographic \
>          -display none \
>          -kernel $HOME/projects/linux/arch/arm64/boot/Image \
>          -append "root=/dev/vda rw acpi=force" \
>          -drive format=raw,if=none,file=/home/itaru/ubuntu24.img,id=hd0 \
>          -device virtio-blk-pci,drive=hd0,serial="dummyserial" \
>          -nodefaults \
>          -device virtio-net-pci,netdev=net0 \
>          -netdev user,id=net0,hostfwd=tcp::8024-:22 \
>          -blockdev node-name=rom,driver=file,filename=edk2-aarch64-code.fd,read-only=true \
>          -blockdev node-name=efivars,driver=file,filename=qemu-arm64-efivars.test \
>          -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M \
>          -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
>          -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>          -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
>          -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
>          -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
>          -serial mon:stdio \
>          -device virtio-9p-device,fsdev=shr0,mount_tag=shr0 \
>          -fsdev local,security_model=none,path=/home/itaru,id=shr0
> 
> Thanks,
> Itaru.

Hi Itaru,

I am able to reproduce your original issue on x86. It occurs, like Marc
suggested, when RANDOMIZE_MEMORY is enabled. (The nokaslr kernel param
disables both RANDOMIZE_BASE and RANDOMIZE_MEMORY in x86.)

Poking around arm64 related configs, it doesn't have a direct equivalent
to RANDOMIZE_MEMORY. Maybe ARM64_MODULE_PLTS or RANDOMIZE_MODULE_REGION_FULL,
both of which seem to affect how modules are loaded into memory are 
causing the problem.

Are you familiar with those, able to try those out?

--Alison

> 
> > 
> >> 
> >> Log of Meson test suite run on 2025-02-26T07:32:24.101461
> >> 
> >> Inherited environment: LANG=C.UTF-8 LS_COLORS='' TERM=xterm-256color PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin MAIL=/var/mail/root LOGNAME=root USER=root HOME=/root SHELL=/bin/bash SUDO_COMMAND='/usr/bin/meson test cxl-region-sysfs.sh' SUDO_USER=realm SUDO_UID=1000 SUDO_GID=1000 
> >> 
> >> ==================================== 1/1 =====================================
> >> test:         ndctl:cxl / cxl-region-sysfs.sh
> >> start time:   22:32:24
> >> duration:     0.71s
> >> result:       exit status 1
> >> command:      NDCTL=/home/realm/projects/ndctl/build/ndctl/ndctl DAXCTL=/home/realm/projects/ndctl/build/daxctl/daxctl TEST_PATH=/home/realm/projects/ndctl/build/test UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MALLOC_PERTURB_=29 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 DATA_PATH=/home/realm/projects/ndctl/test MESON_TEST_ITERATION=1 LD_LIBRARY_PATH=/home/realm/projects/ndctl/build/daxctl/lib:/home/realm/projects/ndctl/build/ndctl/lib:/home/realm/projects/ndctl/build/cxl/lib /bin/bash /home/realm/projects/ndctl/test/cxl-region-sysfs.sh
> >> ----------------------------------- stdout -----------------------------------
> >> test/cxl-region-sysfs.sh: failed at line 40
> >> ----------------------------------- stderr -----------------------------------
> >> + trap 'err $LINENO' ERR
> >> + check_prereq jq
> >> + command -v jq
> >> + modprobe -r cxl_test
> >> + modprobe cxl_test
> >> + rc=1
> >> ++ ./cxl/cxl list -b cxl_test -D -d root
> >> ++ jq -r '.[] |
> >>  select(.pmem_capable == true) |
> >>  select(.nr_targets == 2) |
> >>  .decoder'
> >>  Warning: no matching devices found
> >> 
> >> + decoder=
> >> + readarray -t mem
> >> ++ ./cxl/cxl list -M -d
> >> ++ jq -r '.[].memdev'
> >>  Error: switch `d' requires a value
> >> 
> >> usage: cxl list [<options>]
> >> 
> >>    -d, --decoder <decoder device name>
> >>                          filter by CXL decoder device name(s) / class
> >> + readarray -t endpoint
> >> ++ ./cxl/cxl reserve-dpa -t pmem -s 268435456
> >> ++ jq -r '.[] | .decoder.decoder'
> >> 
> >> usage: cxl reserve-dpa <mem0> [<mem1>..<memn>] [<options>]
> >> 
> >>    -b, --bus <bus name>  Limit operation to the specified bus
> >>    -v, --verbose         turn on debug
> >>    -S, --serial          use serial numbers to id memdevs
> >>    -s, --size <size>     size in bytes (Default: all available capacity)
> >>    -d, --decoder <decoder instance id>
> >>                          override the automatic decoder selection
> >>    -t, --type <type>     'pmem' or 'ram' (volatile) (Default: 'pmem')
> >>    -f, --force           Attempt 'expected to fail' operations
> >> 
> >> ++ cat /sys/bus/cxl/devices//create_pmem_region
> >> cat: /sys/bus/cxl/devices//create_pmem_region: No such file or directory
> >> + region=
> >> ++ err 40
> >> +++ basename /home/realm/projects/ndctl/test/cxl-region-sysfs.sh
> >> ++ echo test/cxl-region-sysfs.sh: failed at line 40
> >> ++ '[' -n '' ']'
> >> ++ exit 1
> >> ==============================================================================
> >> 
> >> 
> >> Summary of Failures:
> >> 
> >> 1/1 ndctl:cxl / cxl-region-sysfs.sh FAIL             0.71s   exit status 1
> >> 
> >> Ok:                 0   
> >> Expected Fail:      0   
> >> Fail:               1   
> >> Unexpected Pass:    0   
> >> Skipped:            0   
> >> Timeout:            0   
> 
> 
