Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993353BED55;
	Mon, 20 Jul 2026 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578993; cv=none; b=ZPQckmLkhin7bQQx43kbtL0qe68uZXPg44KAhdk1zaT5GHqi6Rt0MQQgUK5lBxfLb0sU4jHwJHUYm9P4yfpSeoUWltQ8IOYLBzSO3o/7siTBIlaxJc27FhHm8kiN8QAFU031DJ3eB60bRV6mceW6keZ8IafQkHDRxqenqtk3C2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578993; c=relaxed/simple;
	bh=/Gx8t/faRma7pnFwR9lbiK6gL0Aq8Cw9pcem4VkMm5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmflbHy9KeiW3cqej1kdBit2voP+1LTlLBbJQ09KFxNX5vQ9HYY4st524pfBRvLPhLlfDALQuINZE+PHgcXNXujcH34ag42q3CL2v1+p74dwOXbhm1MhlKs1hlrg6fW5/MNskwgdmXlV2lpFOqNDTRFXnjYyv7KNdVMDoFCGVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRrj/xa+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRrj/xa+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434B51F000E9;
	Mon, 20 Jul 2026 20:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784578992;
	bh=YsqnHj4FyimjgtMv7CmV+usAxupMfWT9SKb2CMqETk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MRrj/xa+nulFVu8CP3Y32amun/1OABrisq9piQuKX76H6aR2GpXfrTlLPLCqey6nm
	 Mw9r9QIeRmwSJ+im7EphxjZRJOEyBrJ+XzAS42XZgjqfOu7u1FsOImgKawuVEYzuCA
	 A0gcMboPGVaVMrl0hw3vVKZcLe5Z4ArPpw337Jahl8y8pJmpsNUsrLUh9gEyagwK5e
	 mjGHOpzBSp9/JGyJdWB93AhX2gsv6AgPVw/ccKUyZ+8hPpoo+ziiOavoar2iZz3qon
	 vsYgJR2v1uX9UxOoiN0XK1WsumlL4z9au9Oe13Xbf/0ikfELUNKWzVHeuQqR5Godor
	 UuHpwBOR96p0A==
Date: Mon, 20 Jul 2026 21:23:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
 ardb@kernel.org, kevin.brodsky@arm.com, anshuman.khandual@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 mochs@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH] arm64/mm: Check the requested PFN range during memoroy
 removal
Message-ID: <20260720212306.674bd0d1@jic23-huawei>
In-Reply-To: <20260720020655.9607-1-icheng@nvidia.com>
References: <20260720020655.9607-1-icheng@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 10:06:55 +0800
Richard Cheng <icheng@nvidia.com> wrote:

Hi Richard, 

Please run a spell checker over your commit messages. 
"memory" in the patch description for example.

Fix itself looks correct to me.


> prevent_memory_remove_notifier() advances pfn while checking whether the
> range contains early memory. After the loop, pfn points to end_pfn, but
> it is passed to can_unmap_without_split(). This checks the range
> immediately after the requested memory instead of the range being
> offlined.
> 
> Consequently, valid requests can be rejected with shifted address range,
> while an unsafe request can be accepted when the following range is
> unmapped. This was observed with CXL DAX memory, where the final memory
> block was incorrectly allowed offline.
> 
> Pass arg->start_pfn so the leaf-split check examines the requested
> range.
> 
> Fixes: 95a58852b0e5 ("arm64/mm: Reject memory removal that splits a kernel leaf mapping")
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

