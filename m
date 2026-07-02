Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BF23EA84
	for <linux-cxl@vger.kernel.org>; Thu,  2 Jul 2026 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952751; cv=pass; b=UayeE1it05poAyF/6XKWeoXtuJjeSntDhThOn7IAdErycHMmE7Rn5xDSJkUYi7j7BqE5/ae/635wvdD9Z7zDV4aqXK8znRCEpqoCuXnDLWhagW6QJmG4yyrd06G1ReHp5TGOSP4dxtGdXZc0PP1peJSGVSFJ6/l1z4AIo+nZ1bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952751; c=relaxed/simple;
	bh=Zi1kQghazxxzAeyyFKUltMlvXrnk+hpCu/LTw4C9hls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0TWcPHI3h8kqF9ezu/0Gp7QD38UAIXRbVhe29cFakbMRKKNi/ktEoE4epvVKQ1oVJWBkxkD8qZ/cjeaQ2/6K9t6QsOSQp1fnOMeqM/tcfj9HaNd9YQs3wEODuNZAmet3qR2cD5+2on76bl83uMJ2eHPUx6EKIzOfQ7MX/joHyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=G60kj55A; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="G60kj55A"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aebbeba529so1179552e87.0
        for <linux-cxl@vger.kernel.org>; Wed, 01 Jul 2026 17:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782952747; cv=none;
        d=google.com; s=arc-20260327;
        b=J/521+3gCDHGR05xrsJYINtSApdfCPsEMPtMe3Sh0B95cOVy76rJVBPm0orPLREIgM
         O1aBoOOnVCEyQhWEZMeX5VLuEuv8o+01YhAi+HUjYCiaSysVTuL+QE9bEX5FXK7eXLg9
         hKx6pRRMRK0kXhyGvWxNY9Tnbdl8Fj5BN9eUHnetCKLhpmsCMQYp6cm1AMFt52sfS26A
         V/RDNDn+wV5h3IpfReqgXoJ55Ycvr0jSfll1KyyUqlzKv6o25R4ISYVciqfMNyJDXvJC
         0VR4PY+Ze34TSxRZ+ZH/1HifFt/+ZA23012AW0gQeh4WSuBjTgqj0CH12CrftoeZ7f+l
         RMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4nDJeF6RYimeoTxMvzC/hALCiJY7hlSNDd3stxB3hPU=;
        fh=LGu+GSIPBUSrdtERbg+0Uqg9KPeSz6unqWLwsmHwsH0=;
        b=Jnem+gjROPMlfKazXKDnSBPkGJpLxIE9gnS8d/qCUog74AGEb9GqS00XEeCccUQWK4
         rc0ALD+IZUSIdgbovG7+pBaGZGnBtT9relW7/NZrD13td+qIPyszzve72kK/84fjNKpL
         54qUovAn31fEHFECDwjZWfgxyLCB1j5kJ1jmgoD2RcRPMycInQhcrmMLmiGEuYc/Wpa+
         qmVdiXlghNSj8sn9P8n/sumXOyS6FqQ4UvuDOPjBzraEQKHz2JK3P8jby+3uhYUG7P7e
         425MN/nKByBmNbljTrg3gbwjeV/GDQ7eSmOI033ul/TyzbViKjJcOzcwQPdNU4fsBXts
         3fVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782952747; x=1783557547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nDJeF6RYimeoTxMvzC/hALCiJY7hlSNDd3stxB3hPU=;
        b=G60kj55AHQiBh1+R63OFmDGqsQndTSU0VkxV0K7t1D054O7TyE4AdoFQvw23DnXeGO
         x5xGN0C0LT14/fgyZCYhMCKE3opshgiZXwqdGoyMMYCm2IfRAf79hUe3yDiAVwRLqnDs
         wckhf0J3nn66T6Kju/F7h0HArCjR0AIPmdDadlCUnfp8T35+aJew4Ga37c/MNesCd5Xr
         LK7WNXk8xYH7yHG0shPKKoID0o0UM06rcRf2lpQjWiv8lMnHd8dPO8ZDorLtJJWUBMVU
         VIij1IZEfpVaUtOQigTMgiplC8ZbdJN3RrhTIgIUkw/7KWJLJWJr6LT4ngcd1eJbmPh/
         Pb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782952747; x=1783557547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4nDJeF6RYimeoTxMvzC/hALCiJY7hlSNDd3stxB3hPU=;
        b=NBo8wIAKmUeyUnbRN8O9io4kXu4ZWKh+CZ9f7yOv0Si4SEZxoDSo0QXC0YR176wmOQ
         klEDQzMLCwfhMFJsNGTHGtm8nWdHAG01541dOBn+jIWSGGmXoueR367l9CUJcHDh5Oku
         CdKamBQ/PBdVf/Fp/qrmY3DhXggIusDLqfgDhDmd93R2J6DopvI/JS14Ec67ltZXM2ca
         VM3La+rgecz009/PFDdh8stF7uuNazEneZF6l9lCsewhX2JPvtxgdRAx9PUKEhkamkRJ
         0KelP7mBz9AEbx5OkGwNmpGsMrY+BuqbcKJYRSCdH797tdP/24utnTmLRchV0QaWNVPo
         dwrg==
X-Forwarded-Encrypted: i=1; AHgh+RqhH5G4vSjqLveI7+dnfK8jE+5SCt2qJwJI9/41nRzoyC+7vO18En+NqWX1GOt6Mr8t15MUKnSHra0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHR69hNWCJbD6K+yjE7XGQlEUYG944EG03ru0j8HL0ke4G6bD
	eEUDbPuwQ71+Y4F+riAC23dBTT+Hx+lDso6bajA+phQPzbdfBqMbIwbCJqnQpYanN0a4gu31Q14
	aH1VyNCTEc13Vd6UqQ7velyqitXXddR3dItTrBrPb5Q==
X-Gm-Gg: AfdE7cmdm58YGvsfWhfWLMoc52iT8H2krZvvb2H6uper3bUa9Jw5mk2jVz42G0RtvXg
	4hO5k0Yk0ti0Unbohl+/FYamfJ1r7N8lP8SooWWlHnv0ScQJayqn9tYpLSIfniitWMrbZo13YYB
	wCCrjicL+TTGTOVg27oHXwvD/iP24nWzCpqoZC9oiNw43tDT0EVb0pDJdimPHeJN2O7hqCdhYat
	rSwhqHngHNcMsHYRC1nyHQ+RuRMyThmUADePwO7QWYRgFa4W0zqwhSsBRERQ7JBHdfvw2W5bAHP
	GtfhHw==
X-Received: by 2002:a05:6512:6382:b0:5ae:b185:1f8d with SMTP id
 2adb3069b0e04-5aec68b3c25mr791941e87.41.1782952746079; Wed, 01 Jul 2026
 17:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605142036.2062347-1-sam.moelius@trailofbits.com>
 <aimmfgWS6IPtwLVA@aschofie-mobl2.lan> <CAE+C+DYnidq7ZFoyxeL54YCT=JF5-Q-NkGFTgoAaW9EztwwaGQ@mail.gmail.com>
 <akOLH861twsGqEFM@MWDK4CY14F>
In-Reply-To: <akOLH861twsGqEFM@MWDK4CY14F>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Wed, 1 Jul 2026 20:38:54 -0400
X-Gm-Features: AVVi8CfEhZEmMV4kGJVuf8ispa2C34HfrxCUiy_lhZhKqcIcGJ1wx3NQBm-VNN8
Message-ID: <CAE+C+DZhgBRYPctfMO8m7uBVRmqTVs3YD0GSpOGQZ535+eOAwQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/test: reject wrapped GET_LOG offsets
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <djbw@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Alejandro Lucero <alucerop@amd.com>, 
	"open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:27=E2=80=AFAM Richard Cheng <icheng@nvidia.com> w=
rote:
>
> On Sun, Jun 28, 2026 at 11:45:29AM +0800, Samuel Moelius wrote:
> > On Wed, Jun 10, 2026 at 2:01=E2=80=AFPM Alison Schofield
> > <alison.schofield@intel.com> wrote:
> > >
> > > On Fri, Jun 05, 2026 at 02:20:31PM +0000, Samuel Moelius wrote:
> > > > The CXL mock mailbox GET_LOG handler validates the requested CEL sl=
ice
> > > > with `offset + length > sizeof(mock_cel)`.  Both fields come from t=
he
> > > > userspace CXL_MEM_SEND_COMMAND payload and are 32-bit values, so an
> > > > offset near U32_MAX can wrap the addition to a small value and pass=
 the
> > > > bounds check.
> > > >
> > > > The wrapped request then uses the original large offset as the sour=
ce
> > > > address for memcpy(), reading far outside the mock CEL array.
> > > >
> > > > Validate the offset first and compare the length against the remain=
ing
> > > > CEL size so the check cannot wrap.
> > > >
> > > > Assisted-by: Codex:gpt-5.5-cyber-preview
> > > > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > >
> > > Hi Samuel,
> > >
> > > I'd suggest keeping the commit log focused on the broken property and
> > > how the fix restores it, rather than tracing the individual arithmeti=
c
> > > operations and later accesses, which are already evident from the cod=
e.
> > >
> > > The GET_LOG handler is intended to reject requests that describe a CE=
L
> > > range extending beyond the available data. The current validation can
> > > incorrectly accept some malformed requests because of arithmetic
> > > wraparound, and the fix restores that property by validating the
> > > requested range in a way that cannot overflow.
> > >
> > > The discussion of the subsequent memcpy() access leaves me wondering
> > > what the observable effect actually is. Does this return bogus CEL
> > > data, trigger KASAN, crash the test module, or something else? If the=
re
> > > is a demonstrated failure, please describe it. Otherwise, I think the
> > > property being restored is the more important aspect to capture in th=
e
> > > commit log.
> >
> > A longer explanation appears below, but the bug can cause the kernel
> > to panic with an out-of-bounds copy. So highlight that fact in the
> > commit message?
> >
> > ---
> >
> > The bug was validated with a PoC that deliberately invalidates the CXL
> > mailbox GET_LOG command to the mock CXL memory device.
> >
> > The vulnerable code checked the requested log slice like this:
> >
> >   if (offset + length > sizeof(mock_cel))
> >   return -EINVAL;
> >
> > Both offset and length are 32-bit fields supplied by userspace. The PoC=
 sets:
> >
> >   in.offset =3D UINT32_MAX;
> >   in.length =3D 1;
> >
> > So the vulnerable expression wraps:
> >
> >   UINT32_MAX + 1 =3D=3D 0
> >
> > That makes the range check pass, because 0 > sizeof(mock_cel) is false.
> >
> > After that, the mock GET_LOG handler still uses the original huge offse=
t:
> >
> >   memcpy(cmd->payload_out, data + offset, length);
> >
> > So it tries to copy 1 byte from far past the mock CEL buffer. In QEMU
> > pre-fix, that caused a kernel page fault in memcpy_orig, through
> > cxl_mock_mbox_send, and then a panic because the test kernel used
> > oops=3Dpanic.
> >
>
> Hi Samuel,
>
> The substrction range check looks right to me, it also matches the existi=
ng mock
> LSA checks.
>
> I would suggest a small regression test if you have time for it.
> Now in-mind only a pseudo-code version, maybe something like that followi=
ng
>
> """
> /* Use a cxl_test memdev and the valid CEL UUID/advertised CEL size. */
> ASSERT_EQ(send_get_log(fd, cel_uuid, UINT32_MAX, 1, out, 1), -EINVAL);
>
> /* Preserve valid boundaries. */
> ASSERT_EQ(send_get_log(fd, cel_uuid, cel_size - 1, 1, out, 1), 0);
> ASSERT_EQ(send_get_log(fd, cel_uuid, cel_size, 0, NULL, 0), 0);
> """
>
> The first case captures the overflow regression, the latter 2 document th=
e
> intended inclusive end-of-buffer behavior.
>
> What do you think ?

Could you please give me some more specifics of the type of test you
imagine? For example, should it be a completely new test? Or should it
build on some existing CXL test?
