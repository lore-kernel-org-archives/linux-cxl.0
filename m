Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8662391838;
	Mon, 20 Jul 2026 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784519830; cv=none; b=TKuB3IhqFxPMfTechL3sHXhB8w+kk7U+O9s9QWwnkN2dOejqKCIXwBpIqc4g0FSwE4Dy4bXTKeonYRJMtcA9lYXv9HYrJUkEvuvaj0oPBIQmQgEGzMbFBQAMDZzNIXe5Z94xGFvkvKP/Su3i/+RqDyPnQeQP3XIb4BCTWkKSqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784519830; c=relaxed/simple;
	bh=FGNZk1B/g4lSat+TD26du1p5U+sjvBqH3Ks8aOh02zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDDrvXcw6O1yOwYYXjdhclSA0t19Lr+2mCLfK1tML3w6c/4L7N9OPYo1JYT4l1iDtjyyv7vNFnmGz0zDykutJ2aj8NOptyhbLJl27lhvagYLdzHzkRrl8d+2wqi4r9LeacFSZ0Sek4rJzjEJhRoVQ/GC+3/UiVc9u74RcrEombk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J0VSyJYM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J0VSyJYM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BDEF1476;
	Sun, 19 Jul 2026 20:57:02 -0700 (PDT)
Received: from [10.164.18.31] (unknown [10.164.18.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 704733F86F;
	Sun, 19 Jul 2026 20:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784519826; bh=FGNZk1B/g4lSat+TD26du1p5U+sjvBqH3Ks8aOh02zY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J0VSyJYMiKo7Ps1MrSM5R8ut41wweptSyPHSMZAEhYOtEB6Cs+vGlWMrR/jYAVHSj
	 6UyedudCsLMg6q3dfLnWV+ZqC8ohsH0H2iGS7C8qCUD77Tl5BL0tLY95j6VBl8nvVd
	 RGB1Lgqyp/kJkNIhIcKY6sLhZoLrGf6ypVdie34o=
Message-ID: <153f7a44-b995-4001-a2af-b576656963a1@arm.com>
Date: Mon, 20 Jul 2026 09:26:59 +0530
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Check the requested PFN range during memoroy
 removal
To: Richard Cheng <icheng@nvidia.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: ryan.roberts@arm.com, ardb@kernel.org, kevin.brodsky@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 mochs@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
References: <20260720020655.9607-1-icheng@nvidia.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260720020655.9607-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/07/26 7:36 AM, Richard Cheng wrote:
> prevent_memory_remove_notifier() advances pfn while checking whether the
> range contains early memory. After the loop, pfn points to end_pfn, but
> it is passed to can_unmap_without_split(). This checks the range
> immediately after the requested memory instead of the range being
> offlined.

can_unmap_without_split() ends up checking 'a memory range' after
the actual range being offlined, because pfn could have gone past
end_pfn by the time it exists the loop. This is wrong and was not
intended.

> 
> Consequently, valid requests can be rejected with shifted address range,
> while an unsafe request can be accepted when the following range is
> unmapped. This was observed with CXL DAX memory, where the final memory
> block was incorrectly allowed offline.

Agreed.
> 
> Pass arg->start_pfn so the leaf-split check examines the requested

Pass arg->start_pfn into can_unmap_without_split().
> range.

Although the explanations above are correct, the wording in the
commit message could have been better.
> 
> Fixes: 95a58852b0e5 ("arm64/mm: Reject memory removal that splits a kernel leaf mapping")

Correct commit ID for attribution.

> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> The bug occurred on a machine with CXL Type-3 device.
> Branch: cxl-next
> 
> Before 95a58852b0e5:
> 
> """
> $ sudo echo offline > memory557056/state
> write error: Operation not permitted
> $ sudo dmesg
> ---[snip]---
> [440008000000 440010000000] splits a leaf entry in linear map
> 
> $ sudo echo offline > memory558079/state
> $ cat memory558079/state
> offline
> """
> 
> After:
> """
> $ sudo echo offline > memory557056/state
> write error: Operation not permitted
> [440000000000 440008000000] splits a leaf entry in linear map
> 
> $ sudo echo offline > memory558079/state
> write error: Operation not permitted
> [441ff8000000 442000000000] splits a leaf entry in linear map

Seems exactly as would have been expected.
> 
> My fix corrects the checked range and prevents the false acceptance.

> 
> Best regards,
> Richard Cheng.
> ---
>  arch/arm64/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a25d8beacc83..18a8b0d3714e 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -2194,7 +2194,7 @@ static int prevent_memory_remove_notifier(struct notifier_block *nb,
>  		}
>  	}
>  
> -	if (!can_unmap_without_split(pfn, arg->nr_pages))
> +	if (!can_unmap_without_split(arg->start_pfn, arg->nr_pages))
>  		return NOTIFY_BAD;
>  
>  	return NOTIFY_OK;
> 
> base-commit: 5ca04f3ba91f1773bbd5da6d9c654ccc1ba7831d

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
