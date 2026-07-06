Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658AE36C9EC
	for <linux-cxl@vger.kernel.org>; Mon,  6 Jul 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350664; cv=pass; b=AvQg6vq8AWeuKxYZJJxaWun44bm4L5SrlxxRHgvh/JVQFz30JLSFKDhp5//AEKWJyD8Rf9v0r/yIbNf1SM/hsODFqYKAr1oWsFepc+iQvNQ9kCyHcqQA9EJpl1ulCNhnO+xChVSuCR0oWpI3vd1CE6YBgctBf8/XUajXsqjB/Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350664; c=relaxed/simple;
	bh=g3zDwQyyvrkiosIPc02U6eHxd2w3raoxsw7zBQtD7co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGsY3+eFy+yV0w6sSkC1cMwnrbTXfT9jkNdwYljPahrJauQXfDb9DXn/DmES6TtZHfSffKmaBTalSyT1c14YTfQJv+71VEDCzYX5475WQFYzAJaimYsXXXSkFHHruZFibVSt9LXkJAWXcSRb3qX2Ke5uR/Vj7Q3Pwk8tORn9Mns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=STaIBxIL; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="STaIBxIL"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aec5675c46so3085480e87.1
        for <linux-cxl@vger.kernel.org>; Mon, 06 Jul 2026 08:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783350661; cv=none;
        d=google.com; s=arc-20260327;
        b=CqC8Nt8wOVHfBJRfdcsHBanv4BPPLCWSg76coF66bhynTMFaUeSKIV0SNrAjJCPKCU
         pGUQmZMFJRlNhdc4KfRPpu/5uK6OUhmybitpfupNnJ0bTBFViQCsMQ3hE+oTDPt7CJIO
         G+raipikASj0ft2S+fM+zTr76sXa7HaxxheOhpIrfistdfmKj48ZGMU8dAY2se7GGVz0
         KjCQuCa92kIIBbvW8Qvs8bMHZFl0wn3Hq0WzDlF2oUxI/qfXvGAzvALYr6Et12tIotH1
         dy2EVmLCnKaccBolLLniafbW3npuu4UHCwR7qm/Uhm3T7YtZhvtKRuyz7hFl+ePOtpRx
         oxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uYypPRWcDIRF+zsBxXeeX6Os7r0uPmZ3JcIoTuF2bf8=;
        fh=Q+3EyXQDjexIDDj2Mh1DiPfXh8vp2bUa6uL3nPhQQ1Q=;
        b=aOTGYvnxcMGYDRkC7OwoOegnDTKpUvtILt4dyR6JvZTvaYYhqdFVpiKQxrv1ozU0Gm
         zv8qN89nPgRDzvj/I5TCVJbnpfbQvc5pDJL1x3rlm0gvHzuNpBUEh14SVA92tV26t5ph
         xZaLf5KYG1UvVnTDrW2n2/9AdIXohvhAEoSIpVY/J3QsyWPKhnkTTVMlKML4RXy94Q9H
         45JHs63348j0g2kakkRP4Nq1J7/Bx1g3SuwdhvwXw4VKI0WmrsZw6590UCTfFiJa3eVJ
         c/8eP6E6JAwzdzWNk0JY+0gwAh5xaqzQNW+9gEueED+3HndF2uwGo0QLmm0QOFuAHwkM
         tzzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1783350661; x=1783955461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYypPRWcDIRF+zsBxXeeX6Os7r0uPmZ3JcIoTuF2bf8=;
        b=STaIBxILkSLx4cO34ftJFz2afSaOhk6B0tZzwhOc1vIwQGSddB8hCcBI8TQj+N+9Hn
         F/9J3vfq+3kk0qR+up+2qPyX8TnZ7rsaKy5TUGVVLEs6o0SLC0C0KuPu8DhW7PNnUvRA
         uDhvn/yeMpZMmXHYOQbOiwoh1BvcuoaTBTb6gQcEWooOAg+lXJxh4jlGWPMWcLV6b14T
         n+ckAioyakPWxZYKuMF0BG0U4V38aGVi/TDbI+PG79vv6/mA6jQ8ydeRNeNg7LYVPasP
         uLvnju5nC29Ttp9BKhcUa8NyeDDQimX++v4q2ielzxAc7snHTdbr5fp8zgxW250gh6Xx
         s4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350661; x=1783955461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uYypPRWcDIRF+zsBxXeeX6Os7r0uPmZ3JcIoTuF2bf8=;
        b=mqPA12T7/h+ZF0oMm83RMUMsGUhWzBRWKFBxs91ga9FMjJz81TO6urpmzP6NLbVUXN
         BNyCy8eY6WX0VKYa2LnfHIA4/jh/QDYNrP+qPBavRdqRFvnC425J2hQE5RkQVT9Oe2Gy
         APbm0lyq7K66M+JOjte2TEwLZjKD9oVD0XYWD3EMKJ0KA4l9vNjBygcRxHSx6LAjpHhT
         HV7UcyfOUV/p76G4NmzTOZl/S/2UK/KSIpGP/NGh7YdRWMwLqGhTe1qklvZXkVs+zMOf
         1Gt0LY2QRRdOrKW4ukmwzu+YypQBI5iNr3j+kLpzX0OT5liaTBmxO3CVRfeNgV2RPq/9
         nOeA==
X-Forwarded-Encrypted: i=1; AHgh+RqydynCa1E7HzYrMTNlM9/XJb78dxp7VfNmqXdox4MFmkJM4OcPWtHlBDV1zg0nXiQAxSD9BwkLYno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRk4etH/R7NfA1jshafeMhEyVK1kymbKztN39YNL97azBSwEPk
	nmatFg8lx9IQTkgnQ2SHxjlb6WX9S+bSFAcCBv8+di2LPn7eNL8xIUoXS7RXlX0kRQJ/l2g16st
	dweT0WxBalH0vbnsyPRHt+pUVwgyS5611Oc95dDzx6w==
X-Gm-Gg: AfdE7ckE9lyeJ4euvOvI32rsDZhWToDCm+JGnKhgZ5bwIKHr2THgQdHNPIw5ZMOcTs7
	MJ+wxWk5Szb9siqtG8te7lknhu3AJTpJSUs5tQ5hYjsYSsvYs1RsiKtPMIzFO3QoEXdFJcBveQ5
	21EJSyAYX9mxuYks7z0JNEwH1w2NFjySnQKMgthZDT0+UrUD2AElfnPqnLUndW+ClO6y7UijwS7
	BTuerpIg7Tk88+BOo6NWvub8csbfpapJPyB5t8fATs8xG/73tKbXMjYWQs/LwzLStuxiSg=
X-Received: by 2002:ac2:5082:0:b0:5ae:bf95:38e4 with SMTP id
 2adb3069b0e04-5b007c1f0femr129068e87.3.1783350660512; Mon, 06 Jul 2026
 08:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605142036.2062347-1-sam.moelius@trailofbits.com>
 <aimmfgWS6IPtwLVA@aschofie-mobl2.lan> <CAE+C+DYnidq7ZFoyxeL54YCT=JF5-Q-NkGFTgoAaW9EztwwaGQ@mail.gmail.com>
 <akOLH861twsGqEFM@MWDK4CY14F> <CAE+C+DZhgBRYPctfMO8m7uBVRmqTVs3YD0GSpOGQZ535+eOAwQ@mail.gmail.com>
 <akd0QZYk9zy4d7T6@MWDK4CY14F>
In-Reply-To: <akd0QZYk9zy4d7T6@MWDK4CY14F>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Mon, 6 Jul 2026 11:10:49 -0400
X-Gm-Features: AVVi8Cf_tIZdgBvFGlDCqz9hNQ9ItKufUDm5GNTvz9FTLfZEXgz7ZTNuvMwsfpQ
Message-ID: <CAE+C+DbdYX5a4JRJUQkvSCbx5bpYh4e=7CgUTPnfzFbSvp8heg@mail.gmail.com>
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

On Fri, Jul 3, 2026 at 4:39=E2=80=AFAM Richard Cheng <icheng@nvidia.com> wr=
ote:
>
> On Wed, Jul 01, 2026 at 08:38:54PM +0800, Samuel Moelius wrote:
> > On Tue, Jun 30, 2026 at 5:27=E2=80=AFAM Richard Cheng <icheng@nvidia.co=
m> wrote:
> > >
> > > On Sun, Jun 28, 2026 at 11:45:29AM +0800, Samuel Moelius wrote:
> > > > On Wed, Jun 10, 2026 at 2:01=E2=80=AFPM Alison Schofield
> > > > <alison.schofield@intel.com> wrote:
> > > > >
> > > > > On Fri, Jun 05, 2026 at 02:20:31PM +0000, Samuel Moelius wrote:
> > > > > > The CXL mock mailbox GET_LOG handler validates the requested CE=
L slice
> > > > > > with `offset + length > sizeof(mock_cel)`.  Both fields come fr=
om the
> > > > > > userspace CXL_MEM_SEND_COMMAND payload and are 32-bit values, s=
o an
> > > > > > offset near U32_MAX can wrap the addition to a small value and =
pass the
> > > > > > bounds check.
> > > > > >
> > > > > > The wrapped request then uses the original large offset as the =
source
> > > > > > address for memcpy(), reading far outside the mock CEL array.
> > > > > >
> > > > > > Validate the offset first and compare the length against the re=
maining
> > > > > > CEL size so the check cannot wrap.
> > > > > >
> > > > > > Assisted-by: Codex:gpt-5.5-cyber-preview
> > > > > > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > > > >
> > > > > Hi Samuel,
> > > > >
> > > > > I'd suggest keeping the commit log focused on the broken property=
 and
> > > > > how the fix restores it, rather than tracing the individual arith=
metic
> > > > > operations and later accesses, which are already evident from the=
 code.
> > > > >
> > > > > The GET_LOG handler is intended to reject requests that describe =
a CEL
> > > > > range extending beyond the available data. The current validation=
 can
> > > > > incorrectly accept some malformed requests because of arithmetic
> > > > > wraparound, and the fix restores that property by validating the
> > > > > requested range in a way that cannot overflow.
> > > > >
> > > > > The discussion of the subsequent memcpy() access leaves me wonder=
ing
> > > > > what the observable effect actually is. Does this return bogus CE=
L
> > > > > data, trigger KASAN, crash the test module, or something else? If=
 there
> > > > > is a demonstrated failure, please describe it. Otherwise, I think=
 the
> > > > > property being restored is the more important aspect to capture i=
n the
> > > > > commit log.
> > > >
> > > > A longer explanation appears below, but the bug can cause the kerne=
l
> > > > to panic with an out-of-bounds copy. So highlight that fact in the
> > > > commit message?
> > > >
> > > > ---
> > > >
> > > > The bug was validated with a PoC that deliberately invalidates the =
CXL
> > > > mailbox GET_LOG command to the mock CXL memory device.
> > > >
> > > > The vulnerable code checked the requested log slice like this:
> > > >
> > > >   if (offset + length > sizeof(mock_cel))
> > > >   return -EINVAL;
> > > >
> > > > Both offset and length are 32-bit fields supplied by userspace. The=
 PoC sets:
> > > >
> > > >   in.offset =3D UINT32_MAX;
> > > >   in.length =3D 1;
> > > >
> > > > So the vulnerable expression wraps:
> > > >
> > > >   UINT32_MAX + 1 =3D=3D 0
> > > >
> > > > That makes the range check pass, because 0 > sizeof(mock_cel) is fa=
lse.
> > > >
> > > > After that, the mock GET_LOG handler still uses the original huge o=
ffset:
> > > >
> > > >   memcpy(cmd->payload_out, data + offset, length);
> > > >
> > > > So it tries to copy 1 byte from far past the mock CEL buffer. In QE=
MU
> > > > pre-fix, that caused a kernel page fault in memcpy_orig, through
> > > > cxl_mock_mbox_send, and then a panic because the test kernel used
> > > > oops=3Dpanic.
> > > >
> > >
> > > Hi Samuel,
> > >
> > > The substrction range check looks right to me, it also matches the ex=
isting mock
> > > LSA checks.
> > >
> > > I would suggest a small regression test if you have time for it.
> > > Now in-mind only a pseudo-code version, maybe something like that fol=
lowing
> > >
> > > """
> > > /* Use a cxl_test memdev and the valid CEL UUID/advertised CEL size. =
*/
> > > ASSERT_EQ(send_get_log(fd, cel_uuid, UINT32_MAX, 1, out, 1), -EINVAL)=
;
> > >
> > > /* Preserve valid boundaries. */
> > > ASSERT_EQ(send_get_log(fd, cel_uuid, cel_size - 1, 1, out, 1), 0);
> > > ASSERT_EQ(send_get_log(fd, cel_uuid, cel_size, 0, NULL, 0), 0);
> > > """
> > >
> > > The first case captures the overflow regression, the latter 2 documen=
t the
> > > intended inclusive end-of-buffer behavior.
> > >
> > > What do you think ?
> >
> > Could you please give me some more specifics of the type of test you
> > imagine? For example, should it be a completely new test? Or should it
> > build on some existing CXL test?
>
> Hi Samuel,
>
> I'm thinking about adding it on ndctl's test/cxl-mbox.c . It already open=
s
> /dev/cxl/<memdev> and issues raw CXL_MEM_SEND_COMMAND against the cxl_tes=
t.
>
> Something like the following
>
> """
>     /* struct cxl_mbox_get_log: uuid[16] + __le32 offset + __le32 length =
*/
>     struct get_log_in {
>             __u8  uuid[16];
>             __le32 offset;
>             __le32 length;
>     } __attribute__((packed));
>
>     /* CEL UUID da9c0b5-bf41-4b78-8f79-96b1623b3f17, GUID byte order */
>     static const __u8 cel_uuid[16] =3D {
>             0xb5,0xc0,0xa9,0x0d, 0x41,0xbf, 0x78,0x4b,
>             0x8f,0x79, 0x96,0xb1,0x62,0x3b,0x3f,0x17,
>     };
>
>     struct get_log_in in =3D { .offset =3D cpu_to_le32(0xffffffffU),
>                              .length =3D cpu_to_le32(1) };
>     memcpy(in.uuid, cel_uuid, sizeof(in.uuid));
>
>     struct cxl_send_command c =3D {
>             .id =3D CXL_MEM_COMMAND_ID_GET_LOG,
>             .in  =3D { .size =3D sizeof(in), .payload =3D (__u64)(uintptr=
_t)&in },
>             .out =3D { .size =3D 1,          .payload =3D (__u64)(uintptr=
_t)out },
>     };
>     rc =3D ioctl(fd, CXL_MEM_SEND_COMMAND, &c);
>     /* Pre-fix: offset+length wraps to 0, passes the bounds check, and th=
e
>      * mock memcpy()s from data + 0xffffffff -> OOB read / panic.
>      * Post-fix: reject. Assert the request is refused. */
>     ASSERT(rc < 0 || c.retval !=3D 0);   /* mock returns -EINVAL -> retva=
l set */
> """
>
> This is draft by my claude-code, I haven't test it yet, but the idea seem=
s
> correct.
> Note that the UUID has to be the valid CEL UUID.
>
> I'm happy to send thest test as a follow-up ndctl patch on top of your fi=
x, or
> you would prefer to fold it in, whichever you like.

I would like to please take you up on the follow-up patch to ndctl, if
you don't mind.

Thank you.
