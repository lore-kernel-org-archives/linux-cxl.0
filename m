Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60C3B6378
	for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549235; cv=pass; b=Xu9w2AVEMNlsuCIRINAHFQ3slCnd3xU1YmbVMynAr8JBNDKfLa2p7L4LghfsCydFZg0WqZ6iOGTO8B6K8/+RZ5c4kt195fG3xDAFIIBy3q5fEAxaaTcgGtMPkn4YuGbzjVuvKnQDBn9Mkn9FfZJo5wxPCObB/PAtBH7OIUA2jTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549235; c=relaxed/simple;
	bh=13e/yABJLuq5e3xhn1IcZZe5oBwPbnwbTkVGh4XSUbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By6dzoQCBhWSnmP+N503YcX9YZKqZ9+E5tYrYnpMp4bRsAcjtS+yYUSmznhBCrUgnvwYq5abLm+8ybLPt5gfPtdINNBhCwPGWqZuJucvc5LrykaFjjfF5WQE3SIMEq/mwtgEbu3eIS+5nbQzVVlTkSVH1ZOa/62qG/M5hZ9f63o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puL1Zdvz; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puL1Zdvz"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aae90f528fso3421436a12.1
        for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 15:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790549232; cv=none;
        d=google.com; s=arc-20260327;
        b=PO1XK+pnqIlIcLLUxXF2w9YwRe3xoFNEBC7ovG/GEp2X2ZT27j32mwEVKPHXFiJ2ga
         QhM33lD8U2q7r1/CNHGogm+QMpCPj3RUV66cg453Z+6vJekP8IY9ZB5z2SY1e4Eew5Bw
         gctDai8k5c/qVdsXre7n2AtvjrXnW0TF5mOSpD8eBedWbpvixO5ZPcAJvbTmByd3FiHR
         W5duEGTyqmXtsUiN5nObRC50Hhd/4pAnKqtVM5jxsh8ZFpVd2ImOCCrIHV2RiwwXWdi1
         Hp1XcL1n3FTT0zaHaq8GULtTEHu6WrwZMmrftCNBS0ARcbkXCoyTgXXrnouE2hRYcLaK
         fCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QIJ+NAQNwQQ8hmxlSZFAjXknCZBUfMJn51nkt5PbrzA=;
        fh=CugdTDtauM+wDkHEZWjoky5Kpxg+kDUni0mVgX/YmIM=;
        b=E6QovCkh0oJCvJRVtDHMKlDacxwoEB0pr9nTr3gIGg5Mv7aeHUBjmgbNQtuEVrdSWP
         powgjp6zElCG+Krzm+8Miq/eZWiLiM86HaUEfm4dszPGZIiOMy8oqJ/RY08BnFcmS8Zu
         QsMTEblSwzir4xPLLH3QoJdQ7hnu3ZHtUWmJWFWbeLebDrwvRSu+qevEOFnslKoQgWbM
         bKXcrQ9bv8ghbTS930xVcryJA2BCX2h0ONL5g6Hpv3JVW45mZFVWmnTnxiaJxSFP7N1s
         jKPt97kHZ+OVuA3U9GBCmgDWbylchHN5w0ynrvxX5txj3uAm0gBBW56c45aDWtb/9o8P
         74CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790549232; x=1791154032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QIJ+NAQNwQQ8hmxlSZFAjXknCZBUfMJn51nkt5PbrzA=;
        b=puL1ZdvzDYmudKZIuFOaYnWzG342b+nzJQNuuZY82V8jaL+oJ1dKweO+f2avwCLxtL
         YA92OIzOPmYat7HWruZTV0XxaAsjtHCrnZkiFShFO5BpgrkWycNT7vhOYH8wbPuIz7/J
         vbk/Olp/IloFqZq1LIhdYI3dEg5sD+SaY7jb7W7X34GCWRpjOLBmIEW6zN7UxCHh3hJO
         0kDTNEhcBCUq5v3odU0s8+uyGA+kL7KA64fHltP1VCmUl8zrrDQLp1OrX6wP73Yrfry9
         SJBj7Qsl3HPLmf/GAECXK0fziXMq1nb4nEVC4/Bawv8V3FxA6hauMrzfWaWp0s0BeRS3
         TCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790549232; x=1791154032;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIJ+NAQNwQQ8hmxlSZFAjXknCZBUfMJn51nkt5PbrzA=;
        b=LPdVT9sdHOwSvPmtkPqJ97VdeQ6goUfM4hmE5Z44iasgVc39o1xMeVgoj+TKSZKBAF
         qxujPbgiLeFvXXQsknBZbvS8HGOBKtksDhj4yolTyuQV1E6qluIkf9fAqST/xgY6Df6q
         5Se0PI452EHx0qfiIRkIS9znB+G9UknwkOu+wQ/Rb4bczFSnHEg0IlUjRnjcOvOYbfeJ
         UKuwjgMEBrj0PhVhwfalXDF3MN8mOLJjPQ6eQveNYzcWvkKtxAGRfwQt46Ggm5YWSaZa
         47gktp73OhbM/5PX89dO+oMbjW0lCaae+s6fGj66un4ynnp1F5CB+TDY9sXzSUzEZCdg
         255g==
X-Forwarded-Encrypted: i=1; AKwUvBwCNpkay+6puUl7JvR0m79JcGR7HYJ0MWdMb91y4csJjvQLsN+EzcJ8qtj8vSbRV4c20mkSUUkDLLI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyfa9GMhEcbj3OC3S3YG9htPn39uV7+c1hdU0iQPZsaCtvY7TW
	W5p7UtDF26aARo3EIJsqua4cCeDOQr7lNZMEj1D24ciCshkNro+YnJJm2FxKBbOf+tdsrb3kSxk
	Qh73GoQYdImAd3J/4rKQYApz21sumRPY=
X-Gm-Gg: AYBFou2fLGnQPXozy7czCh7WmvOiA+0e1e9prYtaJ8O6Oz/nXFRLii+WbY6GSR/hx2y
	Xkb6pzvPHJTrbDMNWZiDHeVRyZxFSGb/ZxQuVjlaE25LqHvFftfJBvPwgW/pMTbSAF6GPaQpKsl
	4i/2MrA+dM8ANVBCOGaRDq8VllqFaOmRkI/DCoFNuEeNyKyxmbgNxUGgU1Fcj53xcg41vFVZbqB
	AsSM1eJ/2+s+dS0ICuZwqR0i9m91TQsWnh9IuQYnRMSrwO/EFa64PTueP+bk5amyd1j5Jvs7REb
	FZsg/LXwI1KN8o/lWs8HBNVZmHxdDAQFugLa5/mOM21oafxfeQWhN9mS+1y/R7KUN1J/5v+E6jN
	Zm7o/099+CA==
X-Received: by 2002:a05:6402:23d9:b0:6ac:8dce:5a8a with SMTP id
 4fb4d7f45d1cf-6ac8dce626dmr16296a12.9.1790549231274; Sun, 27 Sep 2026
 15:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-18-alistair.francis@wdc.com> <20260901012040.554EE1F000E9@smtp.kernel.org>
 <20260909013616.13993627@jic23-huawei>
In-Reply-To: <20260909013616.13993627@jic23-huawei>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 28 Sep 2026 08:46:45 +1000
X-Gm-Features: AclHuK80qnvQONQBTNAnvCROC7Xx41gEGXL0iR9jU1dQigho_4UbMx7DCECDSXU
Message-ID: <CAKmqyKN3ik5nHvRVEdAb96+CjXO8x53bFNsKMdOUWCWw-4Z2kA@mail.gmail.com>
Subject: Re: [PATCH v3 17/21] lib: rspdm: Support SPDM get_digests
To: Jonathan Cameron <jic23@kernel.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, 
	linux-pci@vger.kernel.org, ojeda@kernel.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 10:36=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 01 Sep 2026 01:20:39 +0000
> sashiko-bot@kernel.org wrote:
>
> > Thank you for your contribution! Sashiko AI review found 3 potential is=
sue(s) to consider:
> > - [High] Buffer under-allocation for SPDM 1.3+ GET_DIGESTS responses le=
ading to transport failure, transcript truncation, and EIO crashes.
> > - [Medium] The GET_DIGESTS implementation validates the payload length =
but completely discards the returned certificate digests.
> > - [Low] An undersized/truncated GET_DIGESTS response incorrectly logs a=
n 'Overflow' error.
> > --
> >
> > commit 7b16689f564246befd0f0c43fa0d4515876746e6
> > Author: Alistair Francis <alistair@alistair23.me>
> >
> > lib: rspdm: Support SPDM get_digests
> >
> > This commit adds support for the GET_DIGESTS SPDM command.
> >
> > > diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> > > index b78086c753702..131c22319b262 100644
> > > --- a/lib/rspdm/state.rs
> > > +++ b/lib/rspdm/state.rs
> > [ ... ]
> > > @@ -612,4 +630,64 @@ pub(crate) fn negotiate_algs(&mut self) -> Resul=
t<(), Error> {
> > >
> > >          Ok(())
> > >      }
> > > +
> > > +    pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
> > > +        let mut request =3D GetDigestsReq::default();
> > > +        request.version =3D self.version;
> > > +
> > > +        let req_sz =3D core::mem::size_of::<GetDigestsReq>();
> > > +        let rsp_sz =3D core::mem::size_of::<GetDigestsRsp>() + SPDM_=
SLOTS * self.hash_len;
> >
> > [Severity: High]
> > Does this calculation fail to account for SPDM 1.3+ fields like KeyPair=
ID,
> > CertificateInfo, and KeyUsageMask?
> >
> > For SPDM 1.3+ compliant responders, up to 32 bytes of additional fields
> > can be returned. Because param2 is a bitmask of provisioned slots rathe=
r
> > than a count, any device using slots >=3D 4 will produce a response siz=
e far
> > larger than the allocated buffer, which could trigger an EIO crash.
> >
> > Even for lower slots, this calculation omits the 1.3 fields from the
> > transcript, which could cause a permanent signature verification failur=
e
> > in challenge authentication due to transcript desynchronization.
>
> Nope. Feature turned off by requester not asking for it (yet!)
>
> >
> > > +
> > > +        // SAFETY: `request` is repr(C) and packed, so we can conver=
t it to a slice
> > > +        let request_buf =3D unsafe { from_raw_parts_mut(&mut request=
 as *mut _ as *mut u8, req_sz) };
> > > +
> > > +        let mut response_vec: KVec<u8> =3D KVec::from_elem(0u8, rsp_=
sz, GFP_KERNEL)?;
> > > +
> > > +        let len =3D self.spdm_exchange(request_buf, response_vec.as_=
mut_slice())? as usize;
> > > +
> > > +        // The transport must report a length within the buffer we p=
rovided.
> > > +        if len > response_vec.len() {
> > > +            pr_err!("Overflowed digests response\n");
> > > +            return Err(EIO);
> > > +        }
> > > +        response_vec.truncate(len);
> > > +
> > > +        let response: &GetDigestsRsp =3D Untrusted::new(response_vec=
.as_slice()).validate()?;
> >
> > [Severity: Medium]
> > Does this completely discard the returned certificate digests?
> >
> > The SPDM specification mandates that requesters compare the hash of the
> > certificate chain with the digest returned in get_digests. There doesn'=
t
> > seem to be any storage for these digests in SpdmState, meaning this
> > cryptographic binding between the get_digests response and the certific=
ate
> > chain downloaded in get_certificate might never be verified.
>
> This one is curious. I can't find a reference to the spec requiring that.
> Digests are a short cut, I think you can always ignore them and just use =
the certs
> themselves.  I couldn't find any text requiring the certs if we ignore th=
e digests
> but maybe it is hiding in there somewhere.

It's not in the spec, it's just a hallucination

Alistair
