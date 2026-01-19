Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE09352C4A;
	Mon, 19 Jan 2026 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835711; cv=none; b=sR9Bh1XQ3xdn9ZMaat5C35w8S4NEpcZeKjwrqD5jB9wjkiqt4sOxQLHjXPk+Xlz/iFmSsizldhse+u7nf/BdnKNP4gED3QH5pO4cv5RnPGU1I8K/GyPXF8Y2EpM4MWxUiVSF3RdpsvQAZAN4vdpneJxNxrjQ3UadsMY8SMjd1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835711; c=relaxed/simple;
	bh=NyXQWYi6V+gHwcBTcbpZwoy+f9uzyfJyUXetPGaWiNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTvpD2ucmAU/OL285DGRBV+3r+e26sPY+vmAWAbLRgtXo29GzDYUjo4SVsEFJVZ0u41pjFksIsWCZBQaiM6iE/7vt9RE17qStP2rdpmI0bO12Wbjv8oahE76bOdjyl9YUaGC3z3AD66MLL+FPlylf0JR0jRrgZpTU9Yp/vw09mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwzBsEJz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwzBsEJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768835709; x=1800371709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NyXQWYi6V+gHwcBTcbpZwoy+f9uzyfJyUXetPGaWiNo=;
  b=LwzBsEJzRZ+HMymnYsQqCQEXZuHQnjEa28mXk/iemAiTvZyMFLy64cpF
   0NpjlRDZn7WAgaFs9B7fJXXZChebw+CQvA0R9O+J3rxEC+Bog79xccfMq
   gkNA3CGi/XqBq/wCqpiofnBwMG7kjridEGHl5L94uc9bfF1MGRKDLLXBu
   ozqFhPF8mbqcSZjsKuvVsE+ngseUL2AsZ878nRbQftx7sRfmArW+8ztME
   EGf+kgOXG2lJlmMprET1LI4xF8WrQ1qu/B1hqbJyhgzcKUtbLtA0+3tGt
   jItQQdLCykx88rGqe3ia/Q1wHkmBcFeJPaOC4KP33DCBO4mf3KUILtLpY
   A==;
X-CSE-ConnectionGUID: Faw8KaCjQmiOj0nTRuvj/w==
X-CSE-MsgGUID: 69UahEuhReKp7yFKBarZkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73908224"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="73908224"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 07:15:08 -0800
X-CSE-ConnectionGUID: DbT+bpi7TViCIlRmomsBGA==
X-CSE-MsgGUID: K9AROE4kRXm5FV9BBEwBhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="237163710"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.111.244]) ([10.125.111.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 07:15:06 -0800
Message-ID: <86dc2c33-6a75-4c02-9354-4732fb38361a@intel.com>
Date: Mon, 19 Jan 2026 08:15:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
To: Robert Richter <rrichter@amd.com>, Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 John Allen <john.allen@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-11-rrichter@amd.com>
 <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
 <aWehZwXsK1IXRNU2@rric.localdomain>
 <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
 <20260115080444.GD830755@noisy.programming.kicks-ass.net>
 <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
 <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
 <aW5AvfcjLkSP2j42@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aW5AvfcjLkSP2j42@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/19/26 7:33 AM, Robert Richter wrote:
> (+Rafael and some AMD folks)
> 
> Hi Peter,
> 
> On Fri, Jan 16, 2026 at 03:38:38PM +0100, Peter Zijlstra wrote:
>> On Thu, Jan 15, 2026 at 09:30:10AM +0100, Ard Biesheuvel wrote:
>>> On Thu, 15 Jan 2026 at 09:04, Peter Zijlstra <peterz@infradead.org> wrote:
>>>>
>>>> On Wed, Jan 14, 2026 at 06:08:59PM +0000, Jonathan Cameron wrote:
>>>>
>>>>> Do we have a potential issue wrt to merging this as it stands and improving
>>>>> on it later?  i.e. Is this a blocking issue for this patch set?
>>>>
>>>> Well, why do you *have* to use PRMT at all? And this is a serious
>>>> question; PRMT is basically injecting unaudited magic code into the
>>>> kernel, and that is a security risk.
>>>>
>>>> Worse, in order to run this shit, we have to lower or disable various
>>>> security measures.
>>>>
>>>
>>> Only if we decide to keep running it privileged, which the PRM spec no
>>> longer requires (as you have confirmed yourself when we last discussed
>>> this, right?)
>>
>> Indeed. But those very constraints also make me wonder why we would ever
>> bother with PRM at all, and not simply require a native driver. Then you
>> actually *know* what the thing does and can debug/fix it without having
>> to rely on BIOS updates and whatnot.
> 
> an address translation driver needs the configuration data from the
> Data Fabric, which is only known to firmware but not to the kernel.
> Other ways would be necessary to expose and calculate that data, if it
> is even feasible to make this information available.
> 
> So using PRM looks reasonable to me as this abstracts the logic and
> data behind a method, same as doing a library call. Of course, you
> don't want to trust that, but that could be addressed running it
> unprivileged.
> 
>> Worse, you might have to deal with various incompatible buggy PRM
>> versions because BIOS :/
> 
> The address translation functions are straight forward. I haven't
> experienced any issues here. If there would be any, this will be
> solvable, e.g. by requiring a specific minimum version or uuid to run
> PRM.
> 
>>
>>>> If I had my way, we would WARN and TAINT the kernel whenever such
>>>> garbage got used.
>>>
>>> These are things that used to live in SMM, requiring all CPUs to
>>> disappear into SMM mode in a way that was completely opaque to the OS.
>>>
>>> PRM runs under the control of the OS, does not require privileges and
>>> only needs MMIO access to the regions it describes in its manifest
>>> (which the OS can inspect, if desired). So if there are security
>>> concerns with PRM today, it is because we were lazy and did not
>>> implement PRM securely from the beginning.
>>>
>>> In my defense, I wasn't aware of the unprivileged requirement until
>>> you spotted it recently: it was something I had asked for when the PRM
>>> spec was put up for "review" by the Intel and MS authors, and they
>>> told me they couldn't possibly make any changes at that point, because
>>> it had already gone into production. But as it turns out, the change
>>> was made after all.
>>>
>>> I am a total noob when it comes to how x86 does its ring0/ring3
>>> switching, but with some help, I should be able to prototype something
>>> to call into the PRM service unprivileged, running under the efi_mm.
>>
>> The ring transition itself is done using IRET; create a iret frame with
>> userspace CS and the right IP (and flag etc.) and off you go. The
>> problem is getting back in the kernel I suppose. All the 'normal' kernel
>> entry points assume the kernel stack is empty and all that.
>>
>> The whole usermodehelper stuff creates a whole extra thread, sets
>> everything up and drops into userspace. Perhaps that is the easiest
>> solution. Basically you set the thread's mm to efi_mm, populate
>> task_pt_regs() with the right bits and simply drop into 'userspace'.
>>
>> Then it can complete by terminating itself (sys_exit()) and the calling
>> context reaps the thing and continues.
> 
> I can help with testing and also work on securing the PRM calls.
> Thanks Ard for also looking into this.
> 
>>
>>> Would that allay your concerns?
>>
>> Yeah, running it as userspace would be fine; we don't trust that.
>>
>> But again; a native driver is ever so much better than relying on PRM.
>>
>> In this case it is AMD doing a driver for their own chips, they know how
>> they work, they should be able to write this natively.
> 
> Since a native driver introduces additional issues, as explained
> above, I would prefer to use PRM for address translation and instead
> ensure the PRM call is secure.
> 
> Dan, Dave, regarding this series, the cxl driver just uses existing
> PRM kernel code and does not implement anything new here. Is there
> anything that would prevent this series from being accepted? We are
> already at v10 and review is complete:
> 
> https://patchwork.kernel.org/project/cxl/list/?series=1042412
> 
> I will follow up with working on unprivileged PRM calls. I think, that
> will be the best solution here.

I have no objections with the promise of work on unprivileged PRM call. Please rev the convention doc with Dan's request and we can get this merged.

> 
> Thanks,
> 
> -Robert

