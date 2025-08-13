Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ABD2E62BF;
	Wed, 13 Aug 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090402; cv=none; b=PF8iEzSlQv0q59Ba+Ct+ygA5TCyq1X4y2mLfuVuSfoz12+3GdC5qd7oWaaKyzWQcZw0sl/p9nTAtsMWm1cB+a5fH5w9NzrKTFXELVDSXG8yEbJrZ8q2j0dF/sWUK5UynKHXUER+K5OCtufS05Fhire0fEDZnAv/Ypvcp6Bu5W5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090402; c=relaxed/simple;
	bh=VWd2S2prEkL2aVQlStVAQNcAvAT9tfZws9gk3IQpWsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqnsFIkYsaLhvacBE4Vvdu/tvWPsMW1SH53uJqJ9CIjdXlWxVCDloGHULRS2L7sNDD3Gz8D4mTmRNUbolZzIM2Q6lDKb24MaCu/EHIiSx/TEod290upIQD0h9agzpBd05iDY/U8wlxguTPsVFfpFSDbru+uf4jQaGqIJM7O8Ngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpZvv/vq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpZvv/vq"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b390136ed88so5162756a12.2;
        Wed, 13 Aug 2025 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090400; x=1755695200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhSgCwCLYDF8NtIrqrmz9yi74ePLTH8sXf7P9Mo58ZA=;
        b=IpZvv/vq49KkFAx07pWlNIAW8qDBjxc2Bm28XUbdqbm1TOeR5EMUskjP9eWEk+78Kg
         Lpxfazp3DpqInaU+tZm2mJfazcBnlOKuuTxblqRZz5myLN18XOF+mMQzRVrFPlbXS12u
         rVjv8rv4Oxm30xxYofF5UVuDEpz8nQB9UFDd52722IzI+ImnbGamUBFZHa7zEaYSg1N8
         zTEqsxYXeiZxN4M8xeKp/riZwiYIAOxng9/dg4vLZBk6Gyf6I94+VflLYygJlOFVrG/W
         xFWdqohfDe5LpSJYR7yEEXD8TYksFgOD5Pn16PzpY4n4crRwtvD71SWnfDVCQoeBgwtz
         MPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090400; x=1755695200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhSgCwCLYDF8NtIrqrmz9yi74ePLTH8sXf7P9Mo58ZA=;
        b=KVgO7kE+zKgyLGNeKMMgV2scKwHyIMDiZX2NHlUrXJLjXajv3tVEOTC962nRdo1mDD
         yaInBYslDF9f6kLy4WhGYsnO5cz59orldId9SVsiIHQNJ3JfGq1k/K8hkjcHHssQtHel
         Q9/e/1SbybCxxrHECTwks3rDhZ9OqMNfyWVOXpmPjaLEWS/S6bpYrw//Sk/HimgLImsP
         uIdvGHJ4erTy18WVuGejYCeOQskUTt1/MFqX+BVaALdwlQjgrIJDlfpVPCxHoZL0p4nl
         hTVBrPMllH5gp4TYqEts9gAIkStOuOsEVNoquOnDvkfuOXYULPQpqGxCJ8kWwV1R//6t
         06hw==
X-Forwarded-Encrypted: i=1; AJvYcCUX6AaWfr4u2kCugqfRIxxZJQoY61XTJF/8GUxDhFsQgGXFL8GpReK1JOD7uZj9pfpHsl0S3sFzgv2CWHNo@vger.kernel.org, AJvYcCVC3/YoBn2R3rABt/WhyvnUfAdrx/AytoinaQhWheIv9bC3Q0v2eNbzH+Ht4klJW54OywTJurcBhbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh8TQ3Z8NTnQiMxKTp5HyjMCMOnPnVAe62Od0TeITd2OjNCEw9
	XXi06wB1E4z4AhXirTl9TKCyIinTOUpXULM/dPHwMqSxYzkFTiaObzVIlEvGOghvX+PSjkaD6m2
	5L3WtulAbr94G4oHPzrBe3Q5osMQZ9ck=
X-Gm-Gg: ASbGnct6mHglzabyrOX8w1InPJu7PnR9nhYO2GTacSElsly93n8SLVJpjpqlbV+Wnq+
	JQAOhbeZu+jVpBSlSvdLzZslgPT/OIorcU1JPYQElXGkeSEDOSx30jD99V+J+VmrOyQZbumZrDC
	yH/lBJOCWxQGPSGsY2WPoQEQINYPnSaEcjin9qvPrSLYEjxfRYCcEbNIyYPIu+CfWazsFICP5xp
	mxGylANZFMh9DuCZXjdy4SyP7DyCPfWbxPwKwtUsw==
X-Google-Smtp-Source: AGHT+IFO37S+5pwAAUG7+l3lURdzOcKIE25XHWdJBHNW8aXkW8BPx7RXLv6XjhDraDibtPShSDcq9VSPuJ0UYIsYVWw=
X-Received: by 2002:a17:902:ec83:b0:240:2efe:c384 with SMTP id
 d9443c01a7336-2430d150b19mr43007315ad.19.1755090399998; Wed, 13 Aug 2025
 06:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813115554.388368-1-darshanrathod475@gmail.com> <20250813135207.00000727@huawei.com>
In-Reply-To: <20250813135207.00000727@huawei.com>
From: Darshan Rathod <darshanrathod475@gmail.com>
Date: Wed, 13 Aug 2025 18:37:30 +0530
X-Gm-Features: Ac12FXx6CJ73x0ZTNl9PDla1NJac7qQ2SuQHo6MZiNF22-wJssSIriubuWuN4V4
Message-ID: <CA+db+r5nCFmk1Jugx+afED-EZdzS2w9HOa7-jrPRAo2mDzm9-w@mail.gmail.com>
Subject: Re: [PATCH] cxl: remove assignment from if condition in cxl_mem_get_poison
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	shiju.jose@huawei.com, ming.li@zohomail.com, peterz@infradead.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thanks for pointing that out.
I=E2=80=99ll hold off on this change and wait for the outcome of Alison=E2=
=80=99s
patch discussion before proceeding further.

Regards,
Darshan

On Wed, Aug 13, 2025 at 6:22=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 13 Aug 2025 17:25:54 +0530
> darshanrathod475@gmail.com wrote:
>
> > From: Darshan Rathod <darshanrathod475@gmail.com>
> >
> > Refactor cxl_mem_get_poison() to assign the return value of
> > ACQUIRE_ERR() before the conditional check, instead of performing the
> > assignment inside the if condition. This resolves a checkpatch.pl
> > warning ("do not use assignment in if condition") and improves
> > readability.
> >
> > Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
> See:
> https://lore.kernel.org/all/20250813003821.2891532-1-alison.schofield@int=
el.com/
>
> Which stops checkpatch complaining about this.
> Let's see where that discussion ends up before considering 'fixing' this.
>
> Jonathan
>
> > ---
> >  drivers/cxl/core/mbox.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index fa6dd0c94656..9c5066631896 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1426,7 +1426,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, =
u64 offset, u64 len,
> >       int rc;
> >
> >       ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
> > -     if ((rc =3D ACQUIRE_ERR(mutex_intr, &lock)))
> > +
> > +     rc =3D ACQUIRE_ERR(mutex_intr, &lock);
> > +     if (rc)
> >               return rc;
> >
> >       po =3D mds->poison.list_out;
>
