Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E202C12FB27
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013501; cv=none; b=hD6Z3mucTlWzAi70XpqVBr2ohOxuSs/j2c+n32ZkKBguz+9eq0pV7+1YA40MPk8J5TZmwy52cBthg6Mqh3BpeIqHzIc1nuoA7lZhgorDL32PlKdm2Q7biQ1XPfEgfwxIgL/2i7gcRuc/+9odlblkKrCt61VSQDG6SE5/R9su9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013501; c=relaxed/simple;
	bh=2aVL7KdrebStU5GocAdZMC/r0NJJ2hCiGnGVAFBq9NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgOt0HtaYLxiDktI1FtG3NV/KG1/24cwVkwPKmhILYaM1oAdPuL8rU3YrXCYWUMtZn+AQIpfttIle4UJdllXFkVES8FnCiCd7GEp34OwfjlPqL/NC05RPgzwf1ZCEuoOFq2a7eIMMTyPLd1lzhp5Pje0s/fPoI3kznLxLs8WBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LC0CKLh9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LC0CKLh9"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5118290fcd8so1232819e87.3
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 08:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708013498; x=1708618298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Fn5ZQ9hR3dFuJ1cIpjAX6afBOd6OOkdtrAk/5JKrWU=;
        b=LC0CKLh9Q5iWZ+gLFpQK207ql8aShsxBXCdPVuwSRqVbMc2k5qN697tCwzkdKwHo77
         pS0T13D794eWJAL+eoEJ3HAvlXZPlTMdhEhoNGCnd3KtOWwwv2JM/ynJzf+Uo97CWXS1
         nPD5QYbkhp9ORaqekh+LHz1N0Dg4+D3nza81GSq+RAp8DWLhght2rHktVOezXznk49HB
         9DGxZChYwJ1OO8IvFUEOJHbTzjm6TYg0hi/RoyKPyRAb8ZWr7ipJ+jnT772bgfsB00fD
         jHoy41vjJ6XmHTmX9vyBdkg4rcG2pSfwoLrcVv3QZfYJhnfbvTdW61USXwRp1qgb+uDB
         cJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708013498; x=1708618298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Fn5ZQ9hR3dFuJ1cIpjAX6afBOd6OOkdtrAk/5JKrWU=;
        b=t9kzPmaCIDwc22mssk0WQTBzhuBiRwjDjJhh4W14IXjTCcdXJ/sl4mLf9ktz/ZJUgO
         ieftV/8qqrAsU+aK6/q/tfMCkB9SukB6Wm5U4rwrP2tkX+xmWFnbYrHhNiqccakt7DG6
         y8+WN7U5H3MTtkqNuoOK2HcFz3YWFiuYlbD2D1wIucFjWyhnuJziCJY6bxVmn56nTy99
         qh0rWLef+fF6lwuMlRPL+Fiw4/uVKjUaHrFHrNO78Wy6/jd/7CNULj4zVRnszSlcFw86
         FB9BlDO+TqmUpdNRMmGwgg0+vU7fCuYEhOqb52MF7OOCvA1R5g68OvEXrloD0tFiU9Vi
         DjPA==
X-Forwarded-Encrypted: i=1; AJvYcCUm5+FBtCRjikstZVZu7yCptJoxhQNrbY0/b7vyELZ1PXB4I46X7Q9k4IFi29FLs+ZZ949FfjVDaKwtOuAAntTn0rWBgNxDnZAv
X-Gm-Message-State: AOJu0YyGPZ9q/uzA7CaximyeJANd6GM4LZNujWnU1vg93sYTJHN7ov8h
	/qM4zhLY0mJFCM+A7oNDiD/XfMMDZa3n9nymwpZreEQm0G560advldqCCXKHtkGKd9Pfp896oWL
	vxTzKl+9OQ204cHYsGLJGndSWbiJYE8gRiVk8jw==
X-Google-Smtp-Source: AGHT+IERr5I7htGEr8UA+gNpG/sTntWC/BQBg8IPHN9wPHsWxZlTST5LEK+8EVHLVOydJ68IJXjdhTnh+DIPcb/nmdY=
X-Received: by 2002:a19:7618:0:b0:512:44c9:fb76 with SMTP id
 c24-20020a197618000000b0051244c9fb76mr1394958lff.22.1708013497871; Thu, 15
 Feb 2024 08:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com> <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 16:11:26 +0000
Message-ID: <CAFEAcA-rHZe2xF9anKxYFm0zHYc6gV=g9JiXxeZ4E_LoQ7DhSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] tcg: Avoid double lock if page tables happen to be in
 mmio memory.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Gregory Price <gregory.price@memverge.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, 
	richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Eduardo Habkost <eduardo@habkost.net>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 15:03, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On i386, after fixing the page walking code to work with pages in
> MMIO memory (specifically CXL emulated interleaved memory),
> a crash was seen in an interrupt handling path.
>
> Useful part of bt

Did you intend to put in a backtrace here?

>
> Peter identified this as being due to the BQL already being
> held when the page table walker encounters MMIO memory and attempts
> to take the lock again.  There are other examples of similar paths
> TCG, so this follows the approach taken in those of simply checking
> if the lock is already held and if it is, don't take it again.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  accel/tcg/cputlb.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 047cd2cc0a..3b8d178707 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2019,6 +2019,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>                                 int mmu_idx, MMUAccessType type, uintptr_t ra)
>  {
>      MemoryRegionSection *section;
> +    bool locked = bql_locked();
>      MemoryRegion *mr;
>      hwaddr mr_offset;
>      MemTxAttrs attrs;
> @@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>      section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
>      mr = section->mr;
>
> -    bql_lock();
> +    if (!locked) {
> +        bql_lock();
> +    }
>      ret = int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
>                            type, ra, mr, mr_offset);
> -    bql_unlock();
> +    if (!locked) {
> +        bql_unlock();
> +    }
>
>      return ret;
>  }

Can we do this consistently across all four functions
do_ld_mmio_beN, do_ld16_mmio_beN, do_st_mmio_leN,
do_st16_mmio_leN, please ? It happens that your workload
only needs to do an 8-byte load but conceptually the same
thing applies in all these cases.

thanks
-- PMM
