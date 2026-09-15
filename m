Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB573D47CE
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512258; cv=pass; b=CywMlCeKV1BaZnBLzIeppWeaJwvtWoarGUFL7NiHSOp3tjbFxi57j48/LPscqblKx0CjUAD5nTmGauEgVe28Ki6e6n7gGNIehqQvLqCWrT1qnL6T6gzCOaQiZqQ14BIs7xHmhL3I951m0D6rAweLt5KbhW+Rl48PHo4jFxZKvtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512258; c=relaxed/simple;
	bh=hiN8gmMir/W9bNffZY+EIZwn0mCZcrb0qGVAzbZqNQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKP/Wnf+x6I1CWAvJb3Q41J20ULjfbk3glFyU/+4gAseZwHDfDfwlK2Rcrbw54voxMJ9mmlvNBwM97G8bKvT7X1mkK4EsWIATOBg/3tM3rdbHv4lUubuxSgVFs0y4ljr44/cFOR8ShsXhI+0bo2o6ARBedGPKdHKyHTyjY1LR3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLOfJnkN; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLOfJnkN"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so50961cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 15:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789512256; cv=none;
        d=google.com; s=arc-20260327;
        b=g7Q9eSrxytJk6dUZ7sN/O9JZ4FE71qW0UZUj9EwxgJ4nUp19U5TzAG1sk/NCe81LEp
         4r0M9a+3XVlgjMB+nPa71XvCOWwTvynBHFRj4zzIV8q4qiJatct2frQshNva6xtQHjYx
         XFehgIXbiGTFeqW/hIjL9jaBe0earcdDrTySvD1wjKYptNXoyvUb6GBoKR3DeUO/yJ0R
         d/n2NHUBNhwiJWdCtG564y0ryFzMCXoH3IjNSEfKYK6mfSmTrLJLKN66IFd6aAV6gKbx
         cr5/cAZtTasKvfJyn645N4FPY9GaKeU9tx59QaYbhFXbS6ErTdOUWLSFhy4rdOdEJDbn
         KGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EaIQehfbhcZxllYG58s/kgtKRpkkLc8kmZQmGY/AurE=;
        fh=WVp9Pe1bZ6ORgx+2ZZeKlrwZKxL9OB9eJH9u0W4P29I=;
        b=X/1K8CT6soiEVzQx+WdaauByEOj3J7gn/KfDeZojaUPI+zwF85vwH36D1XX5JeNrtx
         rt2rFH6CIvwf9CqZ9z6z0dgmNkrXACMqtaRFMnnXgcCkrgEdR0+D+j6dMqAkC0YW5kPY
         BDkCHub9jO+KRCPCeWzRoocCNaE8qc1NSt9G5IQFHNdf3Pji5eFs1nK8zRR6V8CFU174
         yNQ+VVQUqN2DnxH7zamNObqTWSmKhEmHNTibZVDnvjWYAvlwDpQvcvMUd+XvWAtz7cTY
         HLK9POfWcIFvh+sCj4T+gUUPh/WYuWTuXZlfjJBts5TYuWOk4LMLdjWGVi52Js0SKNTP
         iZcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789512256; x=1790117056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EaIQehfbhcZxllYG58s/kgtKRpkkLc8kmZQmGY/AurE=;
        b=bLOfJnkNLSiKb/hBphoeOXi+A/0YaomF9rjPXFAO3IKOOhmG3BM1QR+IeZs7YkjNO5
         45sf3hjh9neVRwT5nbNQ+i2jBBLODhPEhSY7CuO+UD47WflhCasBD/INolQcvhFefU73
         7HlhZPLLI3e3grQnFlmNveEf68htuZnSAR6ao6km8DqOqQFzI0jJayAmGKLEzXf5CcN2
         yKYvkOiYhueP9+PW2qLj2rLwUU84lU/4myrMlG+xTII/Z/epDNVZogDg0wgNkYJiiZqG
         QZN6XLJ/SdTQRWHCh5EhQh9/S2M/LiqpM94dZQrFBnoJYOSkamgJ5QmqRatXLy7j1YB1
         Clkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512256; x=1790117056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EaIQehfbhcZxllYG58s/kgtKRpkkLc8kmZQmGY/AurE=;
        b=xkS8mejwgpZWFhTTPzJX5GMnj/fCLpd1PHxRz04Np4TzFkXXCDGko+wjU2Lm36lz03
         Yn6umObKSIoc1+aqmRLIdAeVh61ZFTD9+xVAv0MXvYBHSS4ZB998N35UXkaT24nbhgsV
         CuKKClRAz+RNM0IpiLpMqsPlmQCW2Snqh6bOTuGZDKBlUVCag1sZNExHeN0IK6WmkltC
         /ePSaLHZrWPdGSGxiCn4wvHF3/a3qb5hoaTokAH03NStQ6wnaeBXzg0cIinfmNTJYQOO
         MpmImgFE+gD/yUKLcKQrzZJObKOVAot35I4KCy4dyKEPxUvS6b/dNEAsut7CG31uQrWL
         lTfA==
X-Gm-Message-State: AFuF++nNRCrm6SX3RnixSdtpjvu4rtOJ2GpuMdzAHFnbDl6yNHTkMiiF
	m4FLNQm1z4lyt6/ZsmOfO7nPTxky5bGSu+BnptFaMz3SuuarV+c1Lt3ANLPyFZ8XW08jIbLZX/0
	wJ5/fv+lm78BOSAwX5iT+09KjkKlMmhAzVSuXSx9u
X-Gm-Gg: AYBFou23c4+UDsg1/mYgTpQ1q+PhO2ZtJFsLn2JqHkNybkw9LyqT4zoV670bremrEtY
	fUvBfmMBYckRUF7jjBowO8a0VbvJ13ixmXlygvKr9qSCj3PYFdSHW9F533479i4UzKUKFgIjGUw
	FymPsJijwHmh86XlORnoLEBQVgAnsfblrbphqOIdVGqRPj2IH2GQveM+BCYYYP+qfoqyINS3jXI
	UmrTOu5KbAj1zZON+43dVNlU/o9G/OJXVqBoMzZC/wYvXsjAYOUsLtJgnLXJbwYFxvgP3vQ/0JS
	qOi26SK66h+n2KR6qhd8eX2Z5hIxcC7oQp3i6P+2MkBUriJsybHg+wckhOs6KWsswrQDSJt0T01
	tf6hCdDuKgDg5DqRUpvap
X-Received: by 2002:ac8:610c:0:b0:531:129b:2dba with SMTP id
 d75a77b69052e-5327e5ee122mr3172021cf.3.1789512250983; Tue, 15 Sep 2026
 15:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805155911.1304807-1-dave.jiang@intel.com>
In-Reply-To: <20260805155911.1304807-1-dave.jiang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 15:43:59 -0700
X-Gm-Features: AcwNN1WGAjRzYjZLg6n5XYokgIbJhj5NtoS_8u9irGMa66FsXE2_a3JLfQkEHLY
Message-ID: <CAP-5=fXoVf5dGua_TJ5CMWFMRwtegiO3v2S96X28vRCfqO+N8Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 00/11] perf/cxlpmu: Misc sashiko raised issues fixes
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net, 
	robin.murphy@arm.com, icheng@nvidia.com, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 9:02=E2=80=AFAM Dave Jiang <dave.jiang@intel.com> wr=
ote:
>
> [resend, mangled linux-cxl mailing addr]
>
> Teed off of Davidlohr's misc cxlpmu series [1]. I had Claude pick up all
> the sashiko raised issues and then continued multiple internal review
> iterations to pick up a number of fixes. I'm no CXL PMU or perf expert,
> but the fixes look reasonable to me AFAICT.
>
> Since v3:
> - 4/11 and 5/11 swapped, so the one-line MSI vector 0 fix comes before th=
e
>   info->msi_vec rename and backports on its own (Robin).
> - 6/11: new patch, add the PMUs after configuring events.
> - 7/11: no code change; the commit message no longer overstates what
>   dropping IRQF_SHARED costs a device that shares a vector.
> - 8/11: quote the spec sentence that makes the freeze sticky, and correct
>   the claim about what the migration window leaves enabled (Richard,
>   sashiko-bot).
> - 10/11: split the probe-time overflow clear out, so this is back to the
>   single hunk Jonathan acked.
> - 11/11: new patch. Clear a counter's stale overflow status when starting
>   an event, which is where the reuse case bites; the probe clear moved
>   here from 10/11 (Richard).
>
> Since v2:
> - 1/11: check event_idx alongside counter_idx (Jonathan).
> - 2/11: use FIELD_MODIFY() rather than mask-then-OR (Jonathan).
> - 3/11: rewrite the rationale, no code change (Jonathan).
> - 5/11: new patch, split the MSI vector out of info->irq (Robin, Jonathan=
).
> - 7/11: drop IRQF_SHARED as well as adding IRQF_NOBALANCING, and retitle
>   (Jonathan, Robin).
> - 8/11: don't unfreeze if the PMU has been disabled meanwhile (Robin,
>   Jonathan).
> - 10/11: retitle, and drop the cxl_pmu_offline_cpu() hunk since that
>   dev_err() cannot be reached (Robin).
> - Dropped the old 9/9 that guarded cpumask_show() against cpumask_of(-1).
>   The init case was a false positive and neither reviewer liked the shape
>   of it (Jonathan, Robin).
>
> Since v1:
> - Updated 3/9 to address sashiko issue.
> - No other changes as sashiko only raised issue with pre-existing.
>
> Three follow-ups this series does not attempt:
>
> cxl_pmu_read() relies on local64_t being same-CPU, which is the only reas=
on
> the interrupt has to be pinned at all. Moving prev_count and event->count
> off local64_t would make the affinity question moot, and Robin may have a
> view on whether that is worth doing.
>
> cxl_pmu_offline_cpu() still leaves on_cpu at -1 across a sleeping
> perf_pmu_migrate_context(), and still has an unreachable no-target branch=
.
> Both want removing, possibly on top of the generic PMU hotplug rework
> Jonathan pointed at [2].
>
> Firmware can leave a counter enabled with Global Freeze on Overflow but n=
ot
> Interrupt on Overflow, which stalls the whole CPMU with no interrupt to s=
ay
> so. Quiescing the block at probe needs two writes per counter to stay
> within the spec's rule about changing an enabled counter, so it belongs i=
n
> its own patch.
>
> [1]: https://lore.kernel.org/linux-cxl/20260715191454.459673-1-dave@stgol=
abs.net/
> [2]: https://lore.kernel.org/linux-arm-kernel/cover.1784911757.git.robin.=
murphy@arm.com/


Thanks Dave, I notice that everything seems ready to land for this
series. Is there anything pending? Sashiko mentioned pre-existing
issues.

Thanks,
Ian

> Dave Jiang (11):
>   perf/cxl: Program the requested event group on configurable counters
>   perf/cxl: Clear stale event fields before reprogramming a counter
>   perf/cxl: Fix the counter overflow delta fixup
>   perf/cxl: Accept an overflow interrupt on MSI message number 0
>   perf/cxl: Split the MSI vector out of info->irq
>   cxl/pci: Add the PMUs after configuring events
>   perf/cxl: Don't share the overflow interrupt, and keep it pinned
>   perf/cxl: Unfreeze counters after handling an overflow interrupt
>   perf/cxl: Validate the hardware-reported counter width
>   perf/cxl: Don't log through pmu.dev in the overflow interrupt handler
>   perf/cxl: Clear stale overflow status before using a counter
>
>  drivers/cxl/pci.c      |  11 +++--
>  drivers/perf/cxl_pmu.c | 107 ++++++++++++++++++++++++++++++++---------
>  2 files changed, 90 insertions(+), 28 deletions(-)
>
>
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> --
> 2.54.0
>
>
