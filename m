Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010D46BF
	for <linux-cxl@vger.kernel.org>; Fri, 21 Nov 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742800; cv=none; b=OUNLb8j8wa2h6h+u4mxWWFJd/EGPq5urd08chn8+nCVE6qhjg8fCpRa8HLJ0afJ5WE2Q9EZrjZr+RiSQnTQ0F8YAvYnKx4xOxbyoC2YowI1enQ4bCctxUUsyyLknuLuN7/Dr9EtkU7ooLIqclxGjymUiapg++PZO/iXBaUHBDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742800; c=relaxed/simple;
	bh=i8lB6Xhq5qIw2LcR2aiuLwMvtK9l/CCFSlX/E7C3KfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzKl6hsFRib9ndIRIQJ+mn1A5zquusVrRTSnkFntRJb6L+BhjwZ3CC1pvZDQF9/pQAZ+5UC01TbESZRqNsrkLBwL8LGtJt2KGco/PKny+DHrjdZvdc6YPCEk73nh6l4drlitug1pifd/vXKpKKiPWMCT+LON52DLFoVk6yZKzzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GApQD58W; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GApQD58W"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-644fbd758b3so12609a12.0
        for <linux-cxl@vger.kernel.org>; Fri, 21 Nov 2025 08:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763742796; x=1764347596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JzPZ5dDJUXWF4qsjg1CzRRu4TDRFyC7Z3p5Tit9Rbc=;
        b=GApQD58WtPlmEbdVGxZPy7vH0/BVS6GEtREzi2BISpCHyKrpy5CkzDF6suseCx0D31
         iHwN8p6m4LDaU50iYWAoA1+5+qnTYYuNePf/wILP7hk3RDhqGbfFKnx55Q+EVoJ0Hl4M
         c9p3KSi0qyXjMX0cuk8kG3q7D/q6YmVZvAEmQEBcFm63YDoTR/hn1L/qri7OMNF9XClG
         aRLCb2XwHywu4X/2FjnSM4Z5q7qB92fASmfJU6hPcIyJ2mM3sZmhbUbQrXn4HrSynXaK
         dfaoedIWCp/g4xT+eZ93OnYrGivkjJlQwmX+MUECQ9pwaAaQtOb+/kkNAFLHUgvLtgTm
         u8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763742796; x=1764347596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7JzPZ5dDJUXWF4qsjg1CzRRu4TDRFyC7Z3p5Tit9Rbc=;
        b=qYnKBR9Qv1W/7WNnY8ynu7fysVvdyvIvSaDzrvobrT2MUpRe+BC9Z+nCdJmqxnLY7n
         rC2AWJXh/SyhRf6eoSs48DTCxsKZvxk/PAV4M9oSEtp+uiVHRYS1Qi1veiUcb1kjwLK/
         hdND+Ls3Eh46iNLc96RaxQ+TURNX0RFZsasgqetYRgQfLocxZlENNorkGyqqmEZYWS2l
         2BDgFveDRpxl1rFHOao3Mgci9FWUzTI1crDKFvs49pd2Hilt91U7iLYmdVfbn6Ssp/tH
         V2UJeLCWkZKhFRjWNBvXqLceIpHgH93/LaYXhB+dCVbHUCtTg6j/sbjCr/521kKxxT8E
         K2XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmEKwVwNlwFdSkyTWZWYHPtDWsY8Vb3uuS1BUeqdNkG6pXFxqZff4Bsdgg36mbUYnmf8K1gDgstPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMz+95jVdYE+XkL8QNBuzfHNClYeMb6V16WijiCx/Mw1ejz7Vc
	X8qpgdAPklVHMM1HxBlk0D0yfTS8D/clBK85mjg9Gy6GS16ACxSxtNvvf8VOoHVl/YM+DdM6US9
	bpHxmJk2pFnacHQfzJRf0vdsWli8h0PA9uB6UT0IVjM4lsdcFIRRSpEvS
X-Gm-Gg: ASbGncu8jmN6tKBeZXisVKRlgpY9lF2yasHmS8bcQJlcKwr1QUFyI1DCFx0JV//W1i1
	0N1gDmtb6n1FoPWUsUrecthQyJBw0bVyjnAYBMtbzJDRDXX71plmkG96+fVpFf+etKdoVzP/nhh
	XOlHEEs+rVCDRYH79W14YjprrlyRN8wCJ9/fgpRf7brhJ3UMabDkJDei55jge8kZ08SX3j3H1Fd
	OPDZeXHpMJ2nMRolrSWeveDJUvpf7y3zJeWn5bJLG8+rNFC/k+mH36SbInv9UnLNxAGCw==
X-Google-Smtp-Source: AGHT+IFpxSpkHvgiR26r1tEmf7VxOLY1UkCTmNLNhgG/6y5ncF7GrU9I7etp9Olb6Azm/mZLVSBUngvpmUYPrboW9KM=
X-Received: by 2002:a05:6402:1214:b0:634:90ba:2361 with SMTP id
 4fb4d7f45d1cf-645548332cbmr42770a12.7.1763742795987; Fri, 21 Nov 2025
 08:33:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024210518.2126504-1-mclapinski@google.com> <691fb94f7aee9_1eb85100cd@dwillia2-mobl4.notmuch>
In-Reply-To: <691fb94f7aee9_1eb85100cd@dwillia2-mobl4.notmuch>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Fri, 21 Nov 2025 17:33:05 +0100
X-Gm-Features: AWmQ_bmBax4LGJ2h84vcUCeMiOFbAjV3E_6Wqj0TFMrz__FQfZpYWYQp8nAZZRc
Message-ID: <CAAi7L5fMGANdMts8k4NGxJcWYsPmNwy4zJOXJ-t9T7h3h=mjOg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] dax: add PROBE_PREFER_ASYNCHRONOUS to all the dax drivers
To: dan.j.williams@intel.com
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 1:59=E2=80=AFAM <dan.j.williams@intel.com> wrote:
>
> Michal Clapinski wrote:
> > Comments in linux/device/driver.h say that the goal is to do async
> > probing on all devices. The current behavior unnecessarily slows down
> > the boot by synchronously probing dax devices, so let's change that.
> >
> > For thousands of devices, this change saves >1s of boot time.
> >
> > Michal Clapinski (5):
> >   dax: add PROBE_PREFER_ASYNCHRONOUS to the pmem driver
> >   dax: add PROBE_PREFER_ASYNCHRONOUS to the kmem driver
> >   dax: add PROBE_PREFER_ASYNCHRONOUS to the cxl driver
> >   dax: add PROBE_PREFER_ASYNCHRONOUS to the hmem drivers
> >   dax: add PROBE_PREFER_ASYNCHRONOUS to the dax device driver
>
> After seeing the trouble this causes with libdaxctl and failing to find
> a quick fix I wonder if you should just go through route of eating the
> potential regressions in your own environment.
>
> I.e. instead of making it a problem that the kernel needs to debug for
> all legacy users, how about you just boot with the command line option:
>
>    driver_async_probe=3Ddevice_dax
>
> ...or add the following to your mopdrobe configuration:
>
>    options device_dax async_probe
>
> I.e. do you really need to change this policy globally for everyone at
> this point?

I'll do that or I'll just cherry-pick this to our kernel. Thank you.

> I do want to improve this, but I think it will take time for libdaxctl
> to get ready for this flag day.
