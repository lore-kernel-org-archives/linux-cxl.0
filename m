Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795218898;
	b=vLq0DFpakxarUCEx+h0kRFKiW1S26SNpRkd4fyz4lVEhKFNFSmmuUbo9f4F+jgeAtI3v
	 FHuL8Iu1/iFxM4hxRoxdVgzKhNozlPzqLDmSGpp1BG1dOnTlGAMf82+21x8Vy8SRNFWfa
	 WEy0sWqN9wbq4PFi04YD41GA56OXwEijQXnFMSWwOtIrdVPMJh9hvfpZs/d+MiAeOZ39P
	 Tb8SEe0o0PZoIITWmDGoQ0qL+qNk50sufjuP2VIk05306jbHOD360jLss0l921XdCIQOU
	 QNEeD5TRh7rjZ8ZNyPNozD2gvUKsXRivGVW3m88l2BU9nnbh1mE08xCwGXdIarUE9bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795218898;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:From:Content-Language:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MqLFSAa59jcR/c+OLLsjnNmvu6ZWhmuyZrmTk8e+MIA=;
	b=CsPvDwKGudlIvWlwQ1n+bhcln4tKa1ekQFUsieCgB1jzEV8AXLFyadOJ23LKhrWKhFvz
	 khUeWSPSYsBvZb9NwhYc+KEx1XwuHHOeiIK5euThl6w1yrjzhd5ShV+zNCNZZgEGMNriu
	 pM4MED57jVPkdT3HojnDeuIMckCnULIaecFgQpePrPZ1rFkB/RVmFqYLkTNDgAvzp4QWJ
	 Gfzgsf/YTWrKfxWUTn7Tlz6SI9v+1NXNJtILVtP/T827ae2wpcHhXV2tvuc0T3mk75QyP
	 77kAUKdw28KOd/ZshVnEgHpjcDGAOes5M8kHBnyonlmMgj2WDL1mUO4uJa853SLReyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DDHNin3W;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED12606A6A3
	for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 23:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CED12606A6A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DDHNin3W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795218895; x=1826754895;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=WZxsL3qJRxejupA5Q8Mc66GR1ic8ne2YxPiGYsRn/bg=;
  b=DDHNin3Ww4UXXNaQ5TSj0FkQ5T8iOHMoxkiI/Yl1rPg8eu4DeEb+VVio
   shKgr6VW/vDGDkRF/bqinSgRuFXeBEDVfGgLk1+9bdzFGDSE29+lgEfkZ
   SWpdeuCgnd6Phd1fbOVvzJSkVpWf0cPAbtAzExgUMj5LgNuuVDH1/ChFV
   hhi4+15+4YmWUvjcB2k/aaCTAG6Z6AxpZ8VDEHjD+CGsoOYVT/LwNoD9R
   299A0IBYWIMHmjTc+AbsLLoZSUPD2ErlFN6an5chy6UY3q+xjOHZX6Mv8
   ZEO62HXsWPYfXEj40S1cbJrJsvZ58x62YrTyVYRg0+MnjsogqBg3a7onS
   A==;
X-CSE-ConnectionGUID: /FZtNzYPQFW/IaDLjzkvfQ==
X-CSE-MsgGUID: I+51IbEBSc+sDvLd8rDSMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3989588"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3989588"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 15:54:55 -0800
X-CSE-ConnectionGUID: MTEGWS/ETp20JP1OsytNWg==
X-CSE-MsgGUID: exl5afsGRRSMsA7h3zssYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10718863"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.138]) ([10.125.109.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 15:54:54 -0800
Message-ID: <ce29f556-6e04-4041-a9d4-255fd54c3389@intel.com>
Date: Fri, 20 Nov 2026 16:54:52 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Type2 unwinding ordering change
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
 alucerop@amd.com, linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jic23@kernel.org, alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20261118191431.21781-1-alucerop@amd.com>
 <58fdf73a-a33a-44fa-bd35-a9610624d3b3@intel.com>
 <c887f9e4-7636-49fa-86cf-152bdf76c13a@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <c887f9e4-7636-49fa-86cf-152bdf76c13a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/26 1:13 AM, Lucero Palau, Alejandro wrote:
> 
> On 18/11/2026 23:39, Dave Jiang wrote:
>>
>> On 11/18/26 12:14 PM, alucerop@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> This RFC requires more work mainly with the tracepoints and surely with
>>> documentation which, I hope, will get better with help from reviewers.
>>>
>>> Regarding the solution proposed for the described problem, I know there could
>>> be other solutions, so I'll be happy if someone comes with a better one, but
>>> my feeling is the current design based strongly on devm actions is adding
>>> complexity which would be desirable to reduce somehow.
>>>
>>>
>>> The summary
>>> ===========
>>> Current Type2 support is safe but semantically wrong: a Type2 driver could not
>>> be (temporarily) aware about the CXL region (the one creating the Host physical
>>> range to work with) is not there anymore. It could because it depends on the
>>> unwinding triggering point which changes the ordering of CXL objects unwinding.
>>> It is safe because for current Type2 expectations the physical mapping will
>>> remain: those HDM decoders building up the path and programmed by the BIOS will
>>> not be reset.
>> Hi Alejandro,
>> I ran the series under cxl_test with type2_test=1 and KASAN. A plain unbind of
>> the accel driver oopses. delete_endpoint() unregisters the endpoint decoder,
>> then the devm action from add_hdm_decoder() unregisters it again. Binding the
>> accel with no CXL topology also oopses, on an ERR_PTR endpoint.
>>
>> There's also a Type3 regression. detach_scheduled is never cleared, so after
>> one cxl_mem unbind/bind a Type3 memdev no longer detaches when its endpoint
>> is unbound.
>>
>> With the crash fixed locally, the endpoint is never released after a Type2
>> teardown. detach_memdev() puts cxlmd->endpoint after delete_endpoint() has
>> set it to NULL.
>>
>> The ordering isn't fixed either. schedule_detach() is async. On endpoint or
>> cxl_acpi unbind the decoders are torn down while the detach work runs the
>> driver teardown in parallel. A trace shows the two interleaved. The detach
>> can't run synchronously from the endpoint unbind. The PCI unbind takes the
>> PCI device lock and then needs the endpoint lock to remove the endpoint.
>>
>> I don't think the driver needs to be unbound first. It needs to stop using
>> the HPA before the region goes away. Every region removal goes through
>> unregister_region(), so how about telling the driver there?
> 
> 
> Hi Dave,
> 
> 
> I'm looking at those problems you report above. I did not see them but I was pretty sure something was going to appear ... what makes my point about the current complexity stronger, or at least, the need for adding tracepoints to visualize this easily. I wanted to send the RFC for starting the discussion after this preliminary work studying and proposing a solution what was not so trivial as I thought.
> 
> 
> But I wanted to quickly reply to this specific comment and the idea proposed below. Interestingly, this was something I tried in the past:
> 
> 
> https://lore.kernel.org/linux-cxl/20250624141355.269056-19-alejandro.lucero-palau@amd.com/
> 
> 
> Look at the cxl_create_region interface where the Type2 driver could add a callback action linked to cxl region removal. You can also look at the discussion there with Dan. He did not like it and wanted to always remove the driver in this case.
> 
> 
> I disagreed then but I know think it is the right thing to do. It is possible to have Type2 drivers aware of such disruption and they changing to a degraded mode where CXL is not used, but from sfc perspective, after internal discussion, it does not make sense.

That conversation between you and Dan seem to have escaped my memory. Thanks for the remind. 

> 
> 
> Moreover, multipf support implies to signal all PFs using CXL and it will need to deal with these concurrency problems originating this work. One could argue those concurrency issues need to be addressed but my point is to reduce that complexity where other PFs can not find device CXL in some intermediate state requiring to be aware of all those possibilities and add protections. I'm not saying it is not doable just I prefer to avoid it, always presenting the device CXL state in a all-right-state or no state at all. Relying on unwinding with Type2 driver removal first, this is/should be possible.

I don't think removing the driver first can be made to work for every trigger. I ran your RFC with both fixes on QEMU, with the cxl-type2
device from Manish's RFC and a small test driver. With accel, memdev, endpoint and port unbind, region unbind and PCI removal, the driver's
remove() still finds its HPA under the region. With region deletion and with cxl_acpi unbind or rmmod, it finds the HPA no longer reserved by a region.

Region deletion holds regions_lock and calls unregister_region() with the driver still bound. The driver's teardown needs regions_lock too, so it can't run first there. Dan made the same point in the v17 thread [1]: "The difficult part about that is that the remove path for regions and CXL ports hold locks that prevent the accelerator remove path from running."

On cxl_acpi unbind, the CXL window is already gone when remove() runs. endpoint_unregister_region() then drops the last root decoder reference while holding its regions_lock, and the mutex debug code warns in mutex_destroy().

Skipping autoremove for every DEVMEM decoder also leaks the ones the driver doesn't own. The committed host bridge decoder was never
unregistered on any trigger I ran, and its port was never released.

I'm trying a different approach based on Dan's guidance. It doesn't try to order the teardown. It works whichever runs first, the region
teardown or the driver's remove().

When a region goes away while its Type2 driver is still bound, the region goes defunct. The region device and its targets go away as
before, but the HPA stays reserved and the driver detach is scheduled. The HPA is released when the last user detaches. Dan's reply [1] expects this: "a region can go into a defunct state if someone triggers removal actions in the wrong order".

The decoders stay programmed, since attach regions are CXL_REGION_F_LOCK. So the HPA keeps decoding to the device at least until the driver's remove() returns. It needs no driver callback.

On "all-right-state or no state", the driver uses the HPA after probe, and it stays valid until remove() returns. While the region is defunct, a new user gets -EPROBE_DEFER. While a Type2 driver owns the region, writes to targetN and size return -EBUSY.

For multi-PF I dropped the device link. With the other functions as consumers of the region, deleting the region unbinds them from
device_del(). If a function is still probing, device_links_unbind_consumers() calls wait_for_device_probe(), which waits for every probe in flight. Region deletion runs with regions_lock and port locks held, or from PF0's own failing probe.

I hit three hangs under cxl_test. With your v2, cxl_get_range_and_link() takes PF0's device lock, and region deletion during PF0's unbind waits for that function's probe.

With the lookup fixed, PF0's probe can fail after devm_cxl_probe_mem() while another function is still probing, and the teardown ends up
waiting on PF0's own probe. A memdev unbind can also wait while holding the host bridge port lock, while a second accelerator probing on the same host bridge needs that lock.

Working around them inside the link scheme got worse. A trylock on PF0 avoided the first hang, but left functions stuck in deferred probe in 2 of 6 loads. Linking while the region was unbinding hit WARNs in device_links_driver_bound() and device_links_driver_cleanup(). Avoiding those meant checking the region's dev->links.status from CXL code.

Instead, devm_cxl_add_region_user() registers the function as a user of PF0's region and returns the HPA. I renamed it from
cxl_get_range_and_link() since there's no link anymore. On success, the only CXL lock it takes is the memdev's attach_lock. When the region goes away, each function gets its own async detach.

It returns -EPROBE_DEFER while PF0 is still probing or its region is going away, and -ENODEV if PF0 is bound without CXL. PF0 still reads as bound while it unbinds, so a function probing then gets -ENODEV too.

I think this is better than the link. Nothing waits for a probe while CXL locks are held, and all three hang tests pass. PF0 and the other
functions follow the same rule. The HPA stays reserved until the last of them detaches, in any order. It also needs nothing from the driver core.

I tested everything with cxl_test and on QEMU with Manish's type2 RFC and a small type2 test driver. On QEMU, dummy PCI devices at functions 1 and 2 of the Type2's slot act as the other functions, and a Type3 bound to the test driver stands in for a second accelerator on the same host bridge. The sfc patches are build tested only.

The branch is at [2]. Please take a look and let me know what you think.

[1]: https://lore.kernel.org/linux-cxl/6892325deccdb_55f09100fb@dwillia2-xfh.jf.intel.com.notmuch/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=type2-revoke2

DJ
