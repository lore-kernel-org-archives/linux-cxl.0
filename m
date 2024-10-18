Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710242010F7
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246628; cv=none; b=CRIoz+42bmFraneExA/LnD5/jbQQH9qsMvyro4ib2e5uLNeAMFtD0c6bb8XbTXP3rsvCJ5IGtxG+MfVI33blX5azy5kniVMZ6GI7YfGM8DeNdnpjphdl0qLiB6RIniLXE5KLWHpaq2GHYVWAGaLu6jmgxLueaf9w7PJRdP9wEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246628; c=relaxed/simple;
	bh=KYPweUfsbM8NtC3lzybB2Rhd9hvukec4VKBIUGnWSCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnL/6ZjK8lCwOrKjMGEImdxq7+sC9ekHiX4ibMtFhSFvg1h+SJyz7rMAQWyqHeOAddQzqndV3Yontok0ZA7DO9IvbmD8FgS8NOBjgYwKo3GTBZGAhvgGw3Pcc/RgFTFpjAf77fE6lD/KHcKb2DNq7TzOoxBYWhITjEtCSh5Kohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52209FEC;
	Fri, 18 Oct 2024 03:17:35 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 769ED3F58B;
	Fri, 18 Oct 2024 03:17:04 -0700 (PDT)
Message-ID: <4e1621f7-599e-47a8-bc83-0f28f9bccd42@arm.com>
Date: Fri, 18 Oct 2024 11:17:01 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cxl: Update Soft Reserved resources upon region creation
Content-Language: en-GB
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 "Fontenot, Nathan" <nafonten@amd.com>
Cc: Nathan Fontenot <nathan.fontenot@amd.com>, alison.schofield@intel.com,
 dan.j.williams@intel.com, linux-cxl@vger.kernel.org
References: <20241004181754.8960-1-nathan.fontenot@amd.com>
 <20241016164324.000037b9@Huawei.com>
 <45f3d3e7-4145-4bc9-96bb-98d7c10c35e0@amd.com>
 <20241017175320.000023e5@Huawei.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <20241017175320.000023e5@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi guys,

On 17/10/2024 17:53, Jonathan Cameron wrote:
> On Thu, 17 Oct 2024 09:49:01 -0500
> "Fontenot, Nathan" <nafonten@amd.com> wrote:
>> On 10/16/2024 10:43 AM, Jonathan Cameron wrote:
>>> On Fri, 4 Oct 2024 13:17:54 -0500
>>> Nathan Fontenot <nathan.fontenot@amd.com> wrote:
>>>   
>>>> Update handling of SOFT RESERVE iomem resources that intersect with
>>>> CXL region resources to remove the intersections from the SOFT RESERVE
>>>> resources. The current approach of leaving the SOFT RESERVE
>>>> resource as is can cause failures during hotplug replace of CXL
>>>> devices because the resource is not available for reuse after
>>>> teardown.  

>>>> The approach sought is to trim out any pieces of SOFT RESERVE
>>>> resources that intersect with CXL regions. To do this, first set
>>>> aside any SOFT RESERVE resources that intersect with a CFMWS
>>>> into a separate resource tree during e820__reserve_resources_late()
>>>> that would have been otherwise added to the iomem resource tree.
>>>>
>>>> As CXL regions are created the cxl resource created for the new
>>>> region is used to trim intersections from the SOFT RESERVE
>>>> resources that were previously set aside.
>>>>
>>>> The next steps are to add any SOFT RESERVE resources remaining to the
>>>> iomem resource tree after CXL device probe completes and to notify
>>>> the dax driver so it may consume the added SOFT RESERVE resources.
>>>>
>>>> This patch includes the use of a delayed work queue to wait
>>>> for CXL device probe completion and then have a worker thread add
>>>> any remaining SOFT RESERVE resources to the iomem resource tree.
>>>>
>>>> Not in this patch is notification of the dax driver so it may consume
>>>> the SOFT RESERVE resources.
>>>>
>>>> The goal of presenting this RFC is to drive discussion of the
>>>> current approach for trimming SOFT RESERVE resources, the use of
>>>> a delayed work queue to add remaining SOFT RESERVE resources to
>>>> the iomem resource tree, and methods for notifying the dax driver
>>>> of any newly added SOFT RESERVE resources.


>>> Whilst I appreciate this is an RFC, the arch specific bleed
>>> into CXL code needs to go.  + we need some info here on whether this
>>> is an x86 specific issue.  I'm fairly sure it's not and that should
>>> be called out as future work.  
>>
>> As far as I know this is an x86 issue for handling the SOFT RESERVE
>> resources, if other arches are seeing this than we need to update the approach.
> 
> Hmm. I've not fully understood where it is tripping up in the x86 code.
> Any EFI table using arch (arm64 etc) has soft reserved handling so
> a bios doing CXL enumeration might have chosen to mark the CXL memory
> with that.  
> 
> The rest of us just don't bounce through the ancient history of e820,
> 
> It's more than possible that other architectures don't care that
> it was previously soft reserved on hotplug paths. I'm not sure.
> I guess I could hack a test but it will be a while...

arm64 will try to block removal of memory that was described in the UEFI memory map.

The reason is we can't modify the UEFI tables when they have bits we don't understand.
(Should we preserve those bits if the memory comes back?)
On a UEFI platform, the memory map is the only information about where memory is that we
have, we can't fix it up with other things we know like x86 does, (or stir in another
memory map we found near the ISA hole)
These tables are treated as the static properties of the system that cannot be changed and
is just handed over during kexec. (This also means we don't have to work around the
lovecraftian matrix of bugs that could be introduced by kexecing via older kernels)

To remove memory on arm64, it should have been detected via one of the hotplug mechanisms.

I think this removal of early boot memory is going to be specific to x86.


Thanks,

James
