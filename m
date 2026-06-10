Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75E7332EBD
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118213; cv=pass; b=mIAVonEP6koBtIkt7MqEqVjD5Zu3p7JoB4/XRI2dO1YfGBQ+g3HgoLDhkvrtvzmvcuR1/P4hb5GHB9L3eBYcq4n8HNLMMARu+AkLo2pMTVPCzY7okj3DR/JDq0eM7ZZ6fGHEXRVJozsEzz8mKEBi5kPHehFG/i6U6OQ1rhtuZmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118213; c=relaxed/simple;
	bh=LO7t/wjSU7O6HRYKDpRj6Hj/NOOF78voR2+fWog0vVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elourNGAKo/YO35vJ+SL0L9dhyc4eKyvSMOKF4rWaiHZnKoXmdh4Zh9djE/mbwIR9jMgC7EkBy8HxU79ZqocIuy83pQkgXB/JltKC99oJhSpUFadCgkvI4qKrPM6i4WWiLfA32ffPTRol25KMXNww4LnolOhj6FuotYOGv5QIOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=BTd5fL98; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="BTd5fL98"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa68e66128so7379934e87.2
        for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 12:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781118210; cv=none;
        d=google.com; s=arc-20240605;
        b=Q0lumz2BoBU6v39vPKDPMcMhv7u1ZvKWq3nEg7lUiJ9efMlhLh1E3N1cX3/hpKav/z
         k0UiLwnwYDRj1noKzFbkHlsQlxNoQQJH0d+7Y2jPoUpWhBJWxC70GSioxfG0xZswuMeo
         IICN/qeNN2CTOhvFKjbNngWBu9ASHWF2bluX2l/rve/O5XGhhzVFBbZtC+k3ok19Xu8P
         uoxZqgCiiYTmkMUqmhyOm6nFYd9MMLtq9/kykUhY8yjuF6M1p/tlYCfJX0fKvoI5IBiY
         k0jdaGl28hdvflb5PZiG1pfc8f+AzjKyVayEmP6Bd35bL4EwL2pGCXbrDiAcr7+7wD+F
         EF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e2UWj4NIrhz8lEnKxNdNlV5lgdvKvoUQJrXqlp8wP50=;
        fh=rhxQSqV1bkCIo2pzJ8D56uRhrVyzd0OLZg4FLMEk3ds=;
        b=lBomRqhan1+XdVJK38tHM6nbwaRgL9GuFs83op2IdkYMl+srfN5dBei28di/y+PIHc
         DIgGbXobvysGqkc82ib7JcBWaRlOMUkBGsqVJ+haWyDa12ibt5enPuNIlz47//RvgtCn
         rpLfD2TmhoEKX4QkyWTYpk1J6Xbc6GfN9p870NphwNs2JR/jDMOZuj1mUlkESc2EhU0I
         tRXJVkOClzUsktE0Zgvr2z63AGTZqYWzRzwNLEDFboIb7vgALHMZoQeTSA8XZQ99Eid9
         H4vgNguub/XuGqzlCnJi9GRZWJ6cikvB7IfKFpS7MOQIG6KICWHWhz+r66zbTd8U3vID
         MvqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781118210; x=1781723010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2UWj4NIrhz8lEnKxNdNlV5lgdvKvoUQJrXqlp8wP50=;
        b=BTd5fL98rLMMq+OWAd0CvRgm2+xqjIvhc460QoTylTp3cJh/v72IFkPS5N6Sl5u1Rk
         UJPN+PaqJigQQ7nYecwjHdFn9BOq4d0Uj/WOe5nGq0D7n99mrZ+iCut6k22Ey4j9GHsF
         gEwyMROM20vn0vcCGB6bNKu6hnMwsUxX0vxmBhKdhkh3UE0h1F3Z3yI+zwEq8sjLXnPI
         ykPEOun2g8jlbd/O+TPKmdgzPPC6NTW3jUYKIatlblqPyPLp5goFNuf9Ca7GFxCa4ES4
         Cqh0nY2EzRAQspNi647weMIZRJQYMWXqG+bTxubiIaWHX6mIKQFR/cQQY26h+eEdbTzb
         dZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781118210; x=1781723010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e2UWj4NIrhz8lEnKxNdNlV5lgdvKvoUQJrXqlp8wP50=;
        b=SYHrrDlCho7IUqESS2Le1YJI5Oz4JKHpc5u7NsXAD2rAfgwwV+eh1ws2G/+IoKDm6/
         8js511huwv+qRiGVo8E+gKPtNebNN93PF6UEXksbzSf1f9luFYHgBVdo8C3nyZKX13ux
         aR3bat933MCc25A+R5rxohZt1fMDIMAc1r4pbKis2r24lZyuhnH2VOBwscktU0QLFR4V
         EjArztU8TyyqjtS0rL38XrFnMR310qFVzMHKa2ktznabngYthQZXjOlZ8wawUia6RqPr
         c33JxGYmrrfj/pEeombwBlyu31Jf414amx3skYqvDI4pArYxO75HGLkQoeKUc/Cj0oma
         LEag==
X-Forwarded-Encrypted: i=1; AFNElJ/X6Ay+QlP+N4zMGTy1WKEnUJ0u+gW9U7nt5KDU47YLBJeOwDjU2O0djUZvsBcaAtvSE9wz6VajRPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LeELeYYIb6noIbjkuLzrsqq49PWVfK125TDx5qmjQG5/QAsz
	RQ5tjFtJHGF3YEyiE8/Ssz8JnVbEU71g1Cv6FYV+5hMfFv/2GUug6BAivrVzyUbvGqEOBC4Dx6J
	1i0ITzHtdkAaP56qkIqqUbDRSeo6VE5fo0SxpgrbtFA==
X-Gm-Gg: Acq92OGw2bvVF8dI1EQ0RPsGdvwFOZiGhSC8F5oCL4jDvwQXLgkOUjbvAHFq2dQKLug
	a4UAT+5IFjtpN2X9OJv7KOlCguGzgjFyRTsiRkWuLFhMvgrNdlBzy6JI2B03T66dhhFzpXi2330
	KB4QLtJFWIu5hLs8DrqD5G1CJWhhhq9Pvjqpt2ei/sD8LdSDUtiY1buxYCfPUiZCuYjDtXlo0fo
	QCu8wTsXvwwxjTR/70KFZpzd2Gc/C+CDPCK5IM8DABfkh7UrCPVWATMuPMieQ1Zxb50xmotRRBz
	FOvQjQE8WfQ1zwD2
X-Received: by 2002:a05:6512:65d7:b0:5aa:6f0e:840a with SMTP id
 2adb3069b0e04-5aa87bdd09amr4707939e87.20.1781118209838; Wed, 10 Jun 2026
 12:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605142036.2062347-1-sam.moelius@trailofbits.com> <aimmfgWS6IPtwLVA@aschofie-mobl2.lan>
In-Reply-To: <aimmfgWS6IPtwLVA@aschofie-mobl2.lan>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Wed, 10 Jun 2026 15:03:17 -0400
X-Gm-Features: AVVi8Ce-MsGj5Iz-Tk6EJb7HpFAb6h43AtDQCIxh1FVII_xqJM2KE1KV7uQnL78
Message-ID: <CAE+C+DaTZ5fUfyymQWU506DqDLJo4Hcsx6yvp5eLswxLDa6LuA@mail.gmail.com>
Subject: Re: [PATCH] cxl/test: reject wrapped GET_LOG offsets
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Alejandro Lucero <alucerop@amd.com>, 
	"open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 2:01=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Fri, Jun 05, 2026 at 02:20:31PM +0000, Samuel Moelius wrote:
> > The CXL mock mailbox GET_LOG handler validates the requested CEL slice
> > with `offset + length > sizeof(mock_cel)`.  Both fields come from the
> > userspace CXL_MEM_SEND_COMMAND payload and are 32-bit values, so an
> > offset near U32_MAX can wrap the addition to a small value and pass the
> > bounds check.
> >
> > The wrapped request then uses the original large offset as the source
> > address for memcpy(), reading far outside the mock CEL array.
> >
> > Validate the offset first and compare the length against the remaining
> > CEL size so the check cannot wrap.
> >
> > Assisted-by: Codex:gpt-5.5-cyber-preview
> > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
>
> Hi Samuel,
>
> I'd suggest keeping the commit log focused on the broken property and
> how the fix restores it, rather than tracing the individual arithmetic
> operations and later accesses, which are already evident from the code.
>
> The GET_LOG handler is intended to reject requests that describe a CEL
> range extending beyond the available data. The current validation can
> incorrectly accept some malformed requests because of arithmetic
> wraparound, and the fix restores that property by validating the
> requested range in a way that cannot overflow.
>
> The discussion of the subsequent memcpy() access leaves me wondering
> what the observable effect actually is. Does this return bogus CEL
> data, trigger KASAN, crash the test module, or something else? If there
> is a demonstrated failure, please describe it. Otherwise, I think the
> property being restored is the more important aspect to capture in the
> commit log.

I am getting ready to travel and I will address this when I return in
about two weeks. Thank you for understanding.
