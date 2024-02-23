Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99929D08
	for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682583; cv=none; b=dNhuzgBhoWsiDhL+23+c1T6dAd1Uu4q93u8+fxJrMtXSFxnZi6ZpcLRLmAGNAxP0wyhWcYJJjxvmPW1mz+cwXGDzqVgKSuCVdyDMRL/c5EFWrboVtMEMu8FPbQA/weww+tMRNhvYF3Damj/PcA3L2Jw1j5hH3y5aaQtDbCjKcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682583; c=relaxed/simple;
	bh=gaBiF46pCWSRMtdz7FNyz7vCALtB4XDnwwkSeTDq5/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnmAY+AF0UeBcu0g5psbOF/OrFTc1NXsGxjQHKORMj2sw/dyGmZX3S8I8wmWCpdwdaZTdnzhKX4ntCiiP3ovqyjhmlmtkHRF3oTclfS6VOlb+DIV1qAtbwWbwTMy8RgliLIxQJlkV1bZeB51hDZNAOZXrMD+XQasotkXi1up43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mwnXCCL4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwnXCCL4"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512bce554a5so156834e87.3
        for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 02:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708682580; x=1709287380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u/ZEHHQQJ7TneXWz9Z91knv44YPnLKbvGbn+UTLm+fA=;
        b=mwnXCCL4acdrSRedrlxX7blgrkTHpTxXJDIb0A4KCSdTGMzJ0GEIvWhL1d2rXyr4nM
         S24FlcXUvknK7WKP53w3Y+Gn+XTkFz7usYCV839hOuVEZar+USq/IL44B94f83POfA6W
         OoL3k2TfQJsFRFuIcKU1ldZAR2UwBJc3qCfE6wwDFQ5HLFBTvRfrbZdluSgUf2Oef2Pw
         2+SIYiHzMXoWmipttSlZLEkCQTDhUkFG3yF3upjcl6gGlxh9OgMhFzS9P/fHxtcU97Si
         Q6MFaXHd3mSmSD/bg+85dizILAnsMC2TF1YU4t1shC9vkClbr7VwXX5HdCy0dGpBC3VB
         qATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708682580; x=1709287380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/ZEHHQQJ7TneXWz9Z91knv44YPnLKbvGbn+UTLm+fA=;
        b=LKcQFmoJnVIssFaH7bNYPPdBRHDJ2gvhpyEALM9tR2yfSCGpAGgnjTqMUdCwItNt6K
         Y3xm1gYMjqLD2dt/FbDtu72w79SGU8MUCyiX69ctHLSlFYf5+m8vcEpvpLMJcAk0pW5Z
         q6XlaEOGhDf9nn/l/1O8om+efs4PhH7w76/oGxrll6wdAZtJeDWoX2eRhYrsYB4qIrvF
         yGeeslFCQSi1IM0Z1o7+Yv8rB3e34VPr4lbTO+/FN2rhsPQ6OJ+yLFjHvt/ahjFYEEUi
         uyWmECmy8H7g8CpoBgaTWojsHgw6Q8WlKenjPpZdUvzzeZ484chDY3cbDTiGFrP8cmEg
         Ll3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVGnOd+Eoc1txaQoJY1E7V3k2P+pu8Beq4F3rvnVD2iONI7ukLxWZjlhTBGpCWo8LKWN8xipnpQO0eTX+1A7c0nDlKQKRNzL1Q
X-Gm-Message-State: AOJu0Yz5yiAyzfvJVU3IWvDclNuQBCBVGh4+ZK6FAOB7G5+5h4MP+Fyw
	VHWitzhtHEGLnQ4dh99g6EimGjzm5IIYRNchn8jU49B7ahvJ82vPTKhf5Er70y0ci2XTQOJEB7j
	BEcujHByJ6FE90UlcNRTOdp0nG6eygMCg7GwOEg==
X-Google-Smtp-Source: AGHT+IGpTQcrZ/TLTvw8DWN+u0imyHimS8sPPc+GEzTF9iID+v37fJu9yS18AJbResR+Z92UzHJomAiBb8KAqgJbf/E=
X-Received: by 2002:ac2:5b0c:0:b0:512:cbae:4e05 with SMTP id
 v12-20020ac25b0c000000b00512cbae4e05mr1087260lfn.60.1708682579822; Fri, 23
 Feb 2024 02:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219161229.11776-1-Jonathan.Cameron@huawei.com> <cfa50d25-3a82-48f5-b715-1daf16932fc2@linaro.org>
In-Reply-To: <cfa50d25-3a82-48f5-b715-1daf16932fc2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 10:02:48 +0000
Message-ID: <CAFEAcA9g5dSDj1tQmk8og6DG+wQc14W5XvftZY0Y2XRd96PNWg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] arm/ptw: Handle atomic updates of page tables
 entries in MMIO during PTW.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org, 
	Gregory Price <gregory.price@memverge.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	linux-cxl@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 21:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/19/24 06:12, Jonathan Cameron wrote:
> > I'm far from confident this handling here is correct. Hence
> > RFC.  In particular not sure on what locks I should hold for this
> > to be even moderately safe.
> >
> > The function already appears to be inconsistent in what it returns
> > as the CONFIG_ATOMIC64 block returns the endian converted 'eventual'
> > value of the cmpxchg whereas the TCG_OVERSIZED_GUEST case returns
> > the previous value.

I think this is a bug in the TCG_OVERSIZED_GUEST handling,
which we've never noticed because you only see that case
on a 32-bit host.

> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v2: Thanks Peter for reviewing.
> >   - Handle the address space as in arm_ldq_ptw() - I should have looked
> >     at the code immediately above :(
> >     The result ends up a little more convoluted than I'd like. Could factor
> >     this block of code out perhaps. I'm also not sure on the fault type
> >     that is appropriate here.
> >   - Switch to 'need_lock' as per Philippe's feedback on the x86 fixes.
> >     likely() doesn't seem appropriate here though.
> >
> > target/arm/ptw.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 62 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> > index 5eb3577bcd..ba1a27ca2b 100644
> > --- a/target/arm/ptw.c
> > +++ b/target/arm/ptw.c
> > @@ -711,8 +711,68 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
> >       void *host = ptw->out_host;
> >
> >       if (unlikely(!host)) {
> > -        fi->type = ARMFault_UnsuppAtomicUpdate;
> > -        return 0;
> > +        /* Page table in MMIO Memory Region */
> > +        CPUState *cs = env_cpu(env);
> > +        MemTxAttrs attrs = {
> > +            .space = ptw->out_space,
> > +            .secure = arm_space_is_secure(ptw->out_space),
> > +        };
> > +        AddressSpace *as = arm_addressspace(cs, attrs);
> > +        MemTxResult result = MEMTX_OK;
> > +        bool need_lock = !bql_locked();
> > +
> > +        if (need_lock) {
> > +            bql_lock();
> > +        }
> > +        if (ptw->out_be) {
> > +            cur_val = address_space_ldq_be(as, ptw->out_phys, attrs, &result);
> > +            if (unlikely(result != MEMTX_OK)) {
> > +                fi->type = ARMFault_SyncExternalOnWalk;
> > +                fi->ea = arm_extabort_type(result);
> > +                if (need_lock) {
> > +                    bql_unlock();
> > +                }
> > +                return old_val;
> > +            }
>
> Use BQL_LOCK_GUARD() and avoid all of the repeated unlocks at each return point.

Is the BQL definitely sufficient to ensure atomicity here?
I guess that given that we know it's not backed by host
memory, any other vCPU trying to access the MMIO region
at the same time will have to take the BQL first, so it
seems like it ought to be good enough.

-- PMM
