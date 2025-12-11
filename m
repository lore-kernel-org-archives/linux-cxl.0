Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5B23ABAA
	for <linux-cxl@vger.kernel.org>; Thu, 11 Dec 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765487145; cv=none; b=kFp/mEHRJf0kdd749u0ljcg3gX5XvblCxLQoGa9+cjz9GHH4oKtC2UGNP6YxHxFtSX7O3RwpHQhELmXH2TGXMdUauAJ5W6DZ8ITIw5uTjQNDEqRLou722FAEQ62IDsUiWvEyMEuB+os7WSf/5/RTfvujqMnd9bD2JdxQuB7jfwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765487145; c=relaxed/simple;
	bh=lITbdE8cb54/J0lDS1kwcRTfLQ27mCtRNnCJ9ZAyZNo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5sBdi3GqjmFeTLFW3e2N1PTAdW2zYJbDe1kHdn+wfAGTOrmHeUucxilnIxB5Je8M+utFdO94zMJbCK8XXo7vT5Hata1rWTGsDcNVdvHRG7s4dcs1/+1oYBEWKttpVHkRl6zGe8lXxsmavNLwiqq/qDrYHM4P9B6U1AQ5nXzkR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaZmOlWy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaZmOlWy"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-349b711d106so447597a91.1
        for <linux-cxl@vger.kernel.org>; Thu, 11 Dec 2025 13:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765487143; x=1766091943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SgMW90J4mKuEDhlUBQ0Hy5IIPrgsLrPSYoyBD9umt0=;
        b=GaZmOlWyI1AlUaqqCRXxxINziPnqnmKJSlNsvB6mBbeykQFNL7Qu3DnZ/i4os+DPAM
         24Aul9j8UTJI9zR050SmprqWFsVy5sscn9JlAYpsffdtkRnh9IF5Y7aGDMSX02JcPBY7
         1gDWh6Kd/e8PQFB94E9Zd8Wkzet7vD8Y0hQ1sWOsCv3OeyPMW/gY2q4B9q7aqPrPTwCW
         EVH3Y07bmnUbrXpcNWLUvwxna9sVj+XMY3adaOyi5fX7cKMHyF7WRSZmm8tkxI7xq4LE
         1H1wvRui0iPNzxknS/Qxgly4kdLApIdv3yJ2S4fqXPG4CjUBrQnmwaZWnUxUcKatnf8W
         FyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765487143; x=1766091943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SgMW90J4mKuEDhlUBQ0Hy5IIPrgsLrPSYoyBD9umt0=;
        b=qC15BV6WOyYuYojPIoaIYgt8y4ZD54QhwVzEFgH1/gDzkTUHEZovOU8HHhi3b0Gv+D
         gtATQbOmq+taTIArZ9IyzPE9v1VoH75u13nDrKAeJ2p+a2RruAy9LdyYki6zhWFnrft9
         Womb6cUPr73K0ptBRCWegmvRudi1Fw5FD5g4aInuMVjRBhG6q+9sVzMe3oEoCEhatIul
         3aI5sA2yqt0hmgO/rDxCfx73LABW0E+KEYqCuqgqNwaCdvx5vuxC+6jFSs7OhbpB04VB
         ox6twAY2jKow8WNUGJjM0OQlnKJI1/dJMQt+Vy3AX8xclK96/xLN+zKQDoPEtYZkl2Dg
         8qRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtmyhWIxFlr1iWpcAdCUwtdAuAXWk7v3uQyS9qwFoCSOY6vOCcO3K7sbBK3W//sM58kmBjuIvQ1Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlwIJNGz0GqT/A1mtvCz51F8GEEmrHDx56Wnu8n8RZloMoXbi4
	f2SMCES0+mh/MDX9fw7feMUfD+VlFVEhSt8GBR2bMAlTm6wh4O4imV2L
X-Gm-Gg: AY/fxX43K+BBHfvHxiTCKKmM74UG6BUl1Hh02u9SFOAZMyzlljy88Vwug6vnUgRzuZg
	SKRBoIqCCbtUT8CKKEixHHP1u2Abt0m7PHf+ISzDuIB88YDDGXM97PHy/dbbRW1d9bPvLzksm5z
	sqchlcmIxG7Cf7lR0+4PSMGSLWxeB8Uxg4MCXChCfcfuSbBLL5G/EO/HFrd3GX/zQA0c8fGoEM0
	CJgrP/Lm7zxrgWtFLFzWmWjLFPQlrtldc9+lKdFzblFX+3Yj1I2Qwma26Z+hYN530HaClQ//Rrf
	xY9RT73ZDbOUsg0lTTSp7/MNBmQI2xAOxRz345ZuVaizbZNCPKM4J97NwhoTXIldlreTRS2HKqQ
	uoOTsuhDd6Y3tFrqtpH/MNGp0bgzod8NKteAxxVPrjZcdJFkwtBlSqwA3g/5+mF5rshUfOW0tCp
	t0oEOWuaMtkuqhjZIRShkiqS71p6FYiO8Xa6vljw==
X-Google-Smtp-Source: AGHT+IEaXG2rmjEDb0uflxiiiFq/ebCatCAbD0Oh/+pDbBk0eOkmHJ+Xrbvf5CUWfmcsTRIfdDH/5Q==
X-Received: by 2002:a17:90b:2e10:b0:341:315:f4ed with SMTP id 98e67ed59e1d1-34a7281c8b7mr5706954a91.10.1765487143410;
        Thu, 11 Dec 2025 13:05:43 -0800 (PST)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a92881179sm2711792a91.13.2025.12.11.13.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 13:05:43 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 11 Dec 2025 21:05:41 +0000
To: Ira Weiny <ira.weiny@intel.com>
Cc: anisa.su887@gmail.com, dan.j.williams@intel.com, dave@stgolabs.net,
	linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com
Subject: Re: [RFC PATCH 0/3] Add Support for Multiple DC Regions
Message-ID: <aTsyJXKnL0SA1hl-@deb-101020-bm01.eng.stellus.in>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
 <6931c4c85a526_43de3100bb@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6931c4c85a526_43de3100bb@iweiny-mobl.notmuch>

On Thu, Dec 04, 2025 at 11:28:40AM -0600, Ira Weiny wrote:
> anisa.su887@ wrote:
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > This patchset introduces support for multiple DC regions. It is rebased on top
> > of the latest branch published to Ira's repository:
> > https://github.com/weiny2/linux-kernel/tree/dcd-v6-2025-09-23.
> > We hope it will be useful in the meantime for others and restart some
> > discussion around how to move DCD forward.
> 
> FWIW it seems patch 1/3 and this patch are both bug fixes to the DCD
> series I last posted.  If so they should be tacked onto that series.
> 
> So, you are more that welcome to take over DCD development.
> 
> However, I had multiple DC partitions (Regions) supported in previous
> versions of that series and the community decided that there was no use
> case for such a device.  Based on this submission it seems that me ripping
> out the multiple partitions was incorrect.
>
> > 
> > The corresponding NDCTL support can be found on this branch:
> > https://github.com/anisa-su993/anisa-ndctl/tree/multiple-dc-region-support.
> > I will reply to this thread with a reference to the thread for the
> > NDCTL patches once published.
> > 
> > Testing:
> > This patchset was tested on a QEMU VM with the following topology:
> 
> Unfortunately none of the details presented in this cover letter really
> show why the kernel needs this additional complexity.
> 
> Can you go into more details on the use cases of multiple partitions?
> 
From what I understand, the motivation for DCD as a whole has always been a
blocker for the entire series. However, this year we've seen multiple vendors
demo memory pooling/sharing at SC,25[1], as well as the development of a 
controller that supports "memory pooling and sharing across 
multiple hosts" from Montage[2].

The flexibility and control provided by multiple partitions is
an important capability of DCD for enabling composable memory 
infrastructures. IMO, adding multi-partition support back in from v8 or
picking up this patchset would strengthen the series.

Let me know if this proposal sounds fair? Otherwise I can
separate out the 2 patches that are bug fixes.

Also, apologies if these points have already been discussed. I've not been
following this series for very long, so forgive the ignorance as I try to
catch up. If you can think of any materials/documentation outside of the
mailing list or open collab sync notes that would help fill in the gaps,
please let me know :)

Thanks for the feedback,
Anisa

[1] https://computeexpresslink.org/event/supercomputing-2025/
[2] https://www.montage-tech.com/MXC

> Also, did you consider to use previous versions of my series?  Perhaps v8?
> 
> 	https://lore.kernel.org/all/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com/#r
> 
> Thanks,
> Ira
> 
> [snip]
