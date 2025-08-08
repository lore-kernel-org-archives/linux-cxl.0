Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205517FD
	for <linux-cxl@vger.kernel.org>; Fri,  8 Aug 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668083; cv=none; b=Lfb1S00T5D7+fe3HeEmQS3TJWCrMvu3/HIdinIV5C7a11eCfQSZzNPKRwuYJVIw7+/n6H0JpQL8EnthjyPPuu+GwrT8M6UuYAQtjs2cRZ+P1w3nA7QeXee0nCvJP05IrQuwNzi0tDlhvmyzXBBIqA8XPoIYKZR0Tr/esLe4cU6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668083; c=relaxed/simple;
	bh=Qn90fQzqZl2HQIUSb2XMubTzS9vbd2g1tCaaJSJpZI4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiVJrapKAPOpbH6RI0aRhP4dXXGaGi1r/MdPU2Z3U25w6ye2RB9zZVkpvN8rjJedDUG4nWfHoWNbRIiNxhLg+elmiyOzxOqNZXaGPHV18tK3MRGVR+CYksc0ceonGjOzSwtdMKTbVTgsIfkWa5dW2mqMujHwinxA3yDtZvSKgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz7fk43Y3z6M4XV;
	Fri,  8 Aug 2025 23:46:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C152F140279;
	Fri,  8 Aug 2025 23:47:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 17:47:56 +0200
Date: Fri, 8 Aug 2025 16:47:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ira.weiny@intel.com>, <alucerop@amd.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/4] hw/cxl: Allow BI by default in Window restrictions
Message-ID: <20250808164755.0000339c@huawei.com>
In-Reply-To: <20250806055708.196851-4-dave@stgolabs.net>
References: <20250806055708.196851-1-dave@stgolabs.net>
	<20250806055708.196851-4-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue,  5 Aug 2025 22:57:07 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Update the CFMW restrictions to also permit Back-Invalidate
> flows by default, which is aligned with the no-restrictions
> policy.
> 
> While at it, document the 'restrictions=' option.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

I sat on this the original restrictions patch without trying to
upstream it on the basis that it's a horrible interface. 
Time to clean my mess up I guess then I'll fix this up on top.
We probably want it to enable everything by default (other
than the fixed device config one and then provide boolean
properties to turn things off.  For now I can't see a reason
to have the fixed device config as a possibility.

Jonathan


> ---
>  hw/cxl/cxl-host.c | 2 +-
>  qapi/machine.json | 3 ++-
>  qemu-options.hx   | 4 +++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index def2cf75be61..0d17ea3e4c26 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
>      if (object->has_restrictions) {
>          fw->restrictions = object->restrictions;
>      } else {
> -        fw->restrictions = 0xf; /* No restrictions */
> +        fw->restrictions = 0x2f; /* No restrictions */
>      }
>  
>      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ac258578e4ab..ea8ba71305b0 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -589,7 +589,8 @@
>  #     BIT(2) - Volatile
>  #     BIT(3) - Persistent
>  #     BIT(4) - Fixed Device Config
> -#     Default is 0xF
> +#     BIT(5) - BI
> +#     Default is 0x2F
>  #
>  # @targets: Target root bridge IDs from -device ...,id=<ID> for each
>  #     root bridge.
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 1f862b19a676..ef6072bd8b59 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -142,7 +142,7 @@ SRST
>              -machine memory-backend=pc.ram
>              -m 512M
>  
> -    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]``
> +    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity,restrictions=restrictions]``
>          Define a CXL Fixed Memory Window (CFMW).
>  
>          Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
> @@ -168,6 +168,8 @@ SRST
>          interleave. Default 256 (bytes). Only 256, 512, 1k, 2k,
>          4k, 8k and 16k granularities supported.
>  
> +	``restrictions=restrictions`` bitmask of restrictions of the CFMW.
> +
>          Example:
>  
>          ::

