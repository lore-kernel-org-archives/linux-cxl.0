Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531664;
	b=Bb3zNcFIXKrMWloRQNERwTRCFg9zWKuAKmIuHPBhGMrjXgTqsJmF47nUCHi3qTBYYshP
	 M/oaWEtRT9PnvtgEM/kG3Wbcx2ao3uUp82ehsExyeOZm+Th+4BB1d45nUvcSl9ZBygFaG
	 Yy+KVB48bMA/aqxGaRbJA7dauXXj9QRDpXqFChaIWR5tNKdCdQMlp+0hM0F4v/lOiwfxw
	 QBnBeSHjeTY7z2qcrcecZ/3K0fpfpmP57N5HQfJ80O52eFd7/eQUVjN6446UZyd/CVif4
	 4zoV/T3DKni8+9ryb78xTZMovE3Vd/ErXY9a7ToqQhNxaud9LUz2WMTqmxvF1QJ73aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531664;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MxupQuLrjTmidyr+71XgcptZJ4StthJ+f8ITbIGGDw4=;
	b=rt60s0Zd0oKyESpUkBDtC40SNj4uLF+HgUYzfn34z8h+ug4AU2yA39jnZayZblbWlV84
	 1WU4mpBCn2oY7aNL+yG6mrHQ1HqgH+S94vaMB2Q0iUjbwVakpGBjClLKHjpseLyhOFME+
	 09VIIKOOpCEfFvszNu2ODLjPQA4ql6Xo+HJyctQ18PyGao/o/Z4cXDbdz1f8kznKuQiqy
	 luguyavRG8lwKeMwIX932gnSi23VXEhd5tPKwXN5Qpyz/G1RywT01JL2+FbsJLQBuI1u6
	 GZAxckWcZqc5n6Him+QjAJSDxzjmdRio4fQfLUdRwWt8OwZOfc2sAAsjjYJ8xsbznzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnJkrwqZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10026606A31A;
	Tue, 20 Oct 2026 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnJkrwqZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C071F000C9;
	Tue, 20 Oct 2026 21:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792531663;
	bh=MxupQuLrjTmidyr+71XgcptZJ4StthJ+f8ITbIGGDw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DnJkrwqZND59uB1P3BIS3g9oYMyms9aM1dHhA8wKri1z2IMGEE45HbOK3CO/VapY9
	 nFPATHSvDItkzqnCcjnTvTHZ8IeggBxveinn1ZYKLtjty3P7Af1NTh9ImhBzEr8Rso
	 mpntA0jwUNPtlkBHueN4xcbS8N23dnwuKfA8JPn2W7nNDhk1Qs0FfjzbGJxHkOoYeT
	 ZiJxUz27HQzwaopyBAYaigFLWUtviRAwIjsAAyWemP0Srg25pe3QNx30Gfj33fQRMj
	 Dbs0r1bFBU/foUPiz9cycXvTeNcPotRUUYMms3oatF/E2JHsWUePFAPca2uJ2Munhh
	 /2Y2auQ17BGjw==
Date: Tue, 20 Oct 2026 22:27:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yili Zhang <zhangyili01@baidu.com>
Cc: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>,
 <alison.schofield@intel.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
 <linux-kernel@vger.kernel.org>, shijujose2008@gmail.com,
 <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2] cxl/edac: Fail ECS threshold read for reserved
 encodings
Message-ID: <20261020222739.72a07093@jic23-hlaptop>
In-Reply-To: <20260930095627.32616-1-zhangyili01@baidu.com>
References: <20260928073553.85669-1-zhangyili01@baidu.com>
	<20260930095627.32616-1-zhangyili01@baidu.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 17:56:27 +0800
Yili Zhang <zhangyili01@baidu.com> wrote:

This just called out in the CXL upstream sync call as lacking
review!  Sorry about that - I missed it entirely :(


> cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
> device-supplied ECS config word and uses it to index
> ecs_supp_threshold[], which only has 6 elements.

So this bit suggests this is hardening against bad device.
Definitely a good thing to do given it is fairly simple but
not a fix as such (so no rush to land it!)

> A device reporting
> index 6 or 7 causes an out-of-bounds read of adjacent .rodata, whose
> value is then returned to userspace via the EDAC 'threshold' sysfs
> attribute (small info leak and wrong reported threshold).
> 
> The threshold count field also has reserved encodings 0-2, which
> currently read as 0 from the sparse lookup table. That behavior is
> not intentional; it is just an artifact of the array's implicit
> zero-fill. The ABI documentation only lists 256, 1024 and 4096 as
> supported values, so rather than documenting 0 as well, make the
> read fail for all reserved encodings and only ever report the
> documented values.

For this one, can we trigger these values by writing a threshold of 0?
I think that is blocked by cxl_set_ecs_threshold() so I think this
one is also hardening against a bad device?

> 
> Convert the cxl_get_ecs_*() helpers to return an int and write the
> attribute value through an output parameter (u32 * to match the
> macro), so that errors propagate through the shared
> CXL_ECS_GET_ATTR() macro to the sysfs read.
> 
> Fixes: 85fb6a16ad14 ("cxl/edac: Add CXL memory device ECS control feature")

My overall suggestion is drop the fixes tag and state that this
is hardening against devices returning values not currently in the spec.

It might actually evolve to become a real fix with future hardware
changes using those reserved values but we have no reason to think
that will happen yet. 

We had a small discussion on the call about fixes for bad hardware
and I expressed my view that if they are cheap (like here) in
maintenance burden by all means take them, but I'll push back on
anything that needs very complex solutions.

With this minor tweak to the commit description this patch looks
good to me.


> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Yili Zhang <zhangyili01@baidu.com>

Updated Shiju's email address in the +CC.


> ---
> v2: Per review feedback, fail the read with -EINVAL for all reserved
> encodings instead of returning 0, converting the cxl_get_ecs_*()
> getters to an int return with an output parameter so the error
> reaches the sysfs read.
> ---
>  drivers/cxl/core/edac.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index b321971fef58..fd6612dde7f1 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -624,21 +624,31 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
>  			       0, NULL);
>  }
>  
> -static u8 cxl_get_ecs_log_entry_type(u8 log_cap, u16 config)
> +static int cxl_get_ecs_log_entry_type(u8 log_cap, u16 config, u32 *val)
>  {
> -	return FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK, log_cap);
> +	*val = FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK, log_cap);
> +
> +	return 0;
>  }
>  
> -static u16 cxl_get_ecs_threshold(u8 log_cap, u16 config)
> +static int cxl_get_ecs_threshold(u8 log_cap, u16 config, u32 *val)
>  {
>  	u8 index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK, config);
>  
> -	return ecs_supp_threshold[index];
> +	if (index >= ARRAY_SIZE(ecs_supp_threshold) ||
> +	    !ecs_supp_threshold[index])
> +		return -EINVAL;
> +
> +	*val = ecs_supp_threshold[index];
> +
> +	return 0;
>  }

