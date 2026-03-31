Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC0F2877F7
	for <linux-cxl@vger.kernel.org>; Tue, 31 Mar 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774927810; cv=pass; b=Jl3tzSlLGZJPjdFRKynMaIrvVvEYGVXXpAS6yBcSGEUiyTgymucYounXndTm/GnagBY8bwkwF3g0UK4HDUQgTjS8ECuboaB87kzkAwOWZ8h6qoLNSdVcRQFK1JNw89qEmItjNVsaU+G7NJCp4opuN4endQXAfpNhzIWnGCfIfSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774927810; c=relaxed/simple;
	bh=Vqz0wbjll/hAJPEOie6RM4KJSz7Fs7lEo3U/R+kG3UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOv4yLlI8Yfdl6npiqFMwLttwt9WfhRWH9WSRBAClkreDb361GTlInpq7uTCRl3H2CAFEZRmvRsKUbpCI4enGTCfP1QzM0vH5aYmA49+QyllBqR+YLAKp/Ug7FUNK0AoEoCfbMzmXZ/VXzISQs/DDCkdVfco/8iuWjzl7Y0PL7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qL3DKFk+; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL3DKFk+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b936331786dso565275166b.3
        for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 20:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774927807; cv=none;
        d=google.com; s=arc-20240605;
        b=YhDeo08GRltruOGFPYgw2fu5N9pLbvaRy7kFBECX6TyRovKdRroTRE+uI1D3G+dOZY
         11t97lD89ZTvjLlNWEo3qh9kTVZm8obAqlWg/d2cJe6n91z8vJPUzFCr6fPWnmxgzJUb
         15cHyiWOjS44wp0woGXXA7Dz7vnLVvrTXnDHNQR1zMxXtOw+4p81Aqa3aAWr+zBYOIs9
         aWSw990Hwjd53jBEGOcvdJm/T97bpWbFpuNHRMatzxz9j/ZXuCf5moDtD0OtdjP/ZvQJ
         Lq6BtdG/dT6qfDu938uOVdnggm+zE6GLVhGPAYGejUUI9PsXPoktFPUjhUU0UIIGHv9h
         47sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fbhm8CzZ4y2XM5LEjJUdYiChU7X46Cm6Ehudfb4QOfU=;
        fh=GWPMj7QqODQw14X8FXCXaNm0/lX5t4Nyv8z/h086v9E=;
        b=XRFat3VvY+MAzl4TlAT6uGleyDL6qM1kE0ZOe43cD5A/ZJF6v+ZrAEuboGSTfzXIYI
         a5ouOyNGPR/MheT141sBgTPyo/P4x90fuGQIC8EjJN6MDrCufc00uAqAX5Lo5Uc1HDqw
         SMMLHBrCoNS5RfkXuc8lRamHDyd5QOC/OxPBM5WR6xbuAOHRVt60BSOCpOUrh3mx1qMf
         0hih+23ZveoWiT5ArCPwjsN5BNUcg4hSqPiAOLoUcL5QCZh4aCRnBlbsyR7clUHc3jQy
         5g/9wQfdLYk7HvCSo3p/21zMWcJN/kwt9GRNBCmbo7eSoX1Njv1Xvy5UR137s7LWSFW5
         6bgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774927807; x=1775532607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fbhm8CzZ4y2XM5LEjJUdYiChU7X46Cm6Ehudfb4QOfU=;
        b=qL3DKFk+AhxNLVrweVLdebsnnRL9yHRQeoFEHbsvv1taablyE0qarKkxBnvyyTohil
         FPUvBCQhQGD038uilYe2wdk8ltY0bLN24EHzpAD7lt2E+BGM4BSnyr1OV0oZxmIM9hzu
         ieIwmT0HCSSt4efkdPce+/r3JoIcPr7Ge4Vx2oIuj1sYidoJPOcZa1Py1B0vbQNgqJCV
         36b+0pp7T7bZcBYWPRxeylvpvThyzgfyEp/gQNCBILusQyVwBzumnwSXCojJLHCw1BEk
         fYP53d3nwguQ72eQZe/dYgX/7ByXbfVfFIxT/USqvJWU6hFt63Ny3gjiefeIQ72VmlGT
         GGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774927807; x=1775532607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fbhm8CzZ4y2XM5LEjJUdYiChU7X46Cm6Ehudfb4QOfU=;
        b=dMixk0ZwUdq2I6ei8RFCThcouTPat1sMGTRhSUpwF9WXnemv8aK4KlQzjl8CGO1/cZ
         5VzxgP/UQ/UiKJlp4azVnfA8SelkAzXwHTeWK1kLfqacscYat0ZtvhYQVZAmhqtHM+7z
         g+oPuHuGfncyMwE99x2fk1IxU0niVeZ18Svem7ZPjQtCoz+5kLz8L+LmqmOiO8qiFg7s
         T8ITJ1fYvHtGhXJTw3dVYvlECPvkyPk7aZ+a8kK/49neZJ+UyzaaTwBGg872n11IyZ4p
         auUowfh9J0+bemUb/oiIDeBa7/nURyVbBvhfYEKzXhUeFpqPPNrfSmeJv3U/xFVXY58F
         /TBg==
X-Forwarded-Encrypted: i=1; AJvYcCWvepuea37PLLAUT3Pt1thVeRSC+0dJT13ovpMkWJvckrR2sRCmo4a5/hxxyCZ/CDvI2rm+UtQ/AFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyH5jrpjhc5p3Xo85w2d8i2MpPOodbxRSr2UOKdXLH1UlZQLD9
	O1R3N4y64l9Mt00UEZXRt2LDZ/TLComtsj69wXSlCTDlwlmId6lVpMlgEatzEMmxcFI7T2tbd2o
	wEa/CoYzwKqs5+q8jrBOXoOUcMMihp9w=
X-Gm-Gg: ATEYQzzlX15h+3qnOGmi/WkywBcTnFMblAianXvbYeSRV8WPuqfQIQ+778mlrilla3V
	Gzi94a4Krl5h09WyKbUeNAJP808pRVCSWiI38y6ybM1dVA42ZjYr/4FshdoT+e83SR7NcJGJNVE
	W+ZtorjorBvKRVGZlHghxhlNrPyDqx/E9B+/G8JBkM0wnNhaK/2x9peYPWmrVLonTdCToPkAqWi
	7i6G08KnMkPBd/pC51hM8b5RIgeSSvKsPa+lvkhxecf53p89qvZs78tduJRXrT3EqrlkVFziEYK
	5wSKxCpWhilDH6GEhpmcUVrSNUpygAZNNfUsjQ==
X-Received: by 2002:a17:906:208f:b0:b98:132e:ca97 with SMTP id
 a640c23a62f3a-b9b5094c6femr664652066b.47.1774927806887; Mon, 30 Mar 2026
 20:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-23-alistair.francis@wdc.com> <20260303150040.00007458@huawei.com>
In-Reply-To: <20260303150040.00007458@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 31 Mar 2026 13:29:40 +1000
X-Gm-Features: AQROBzBc83sivh6UcNOP_l8RUTr7K-DmfbPtqXOhOGreZW7lZXTka_jt4qB4WZ8
Message-ID: <CAKmqyKM6CBucDEo0aKZVWrKtozbT_ddk0PaZFtHyEMMMx558JA@mail.gmail.com>
Subject: Re: [RFC v3 22/27] lib: rspdm: Support SPDM certificate validation
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-pci@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com, 
	a.hindborg@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, wilfred.mallawa@wdc.com, 
	aliceryhl@google.com, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 1:00=E2=80=AFAM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 11 Feb 2026 13:29:29 +1000
> alistair23@gmail.com wrote:
>
> > From: Alistair Francis <alistair@alistair23.me>
> >
> > Support validating the SPDM certificate chain.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
>
> Only minor thing inline + observation on the code that I think we want to=
 remove
> for now wrt to checking the root cert.
>
> > diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> > index 1e5656144611..728b920beace 100644
> > --- a/lib/rspdm/state.rs
> > +++ b/lib/rspdm/state.rs
>
> > @@ -743,4 +746,92 @@ pub(crate) fn get_certificate(&mut self, slot: u8)=
 -> Result<(), Error> {
> >
> >          Ok(())
> >      }
> > +
> > +    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(=
), Error> {
> > +        let cert_chain_buf =3D &self.certs[slot as usize];
> > +        let cert_chain_len =3D cert_chain_buf.len();
> > +        let header_len =3D 4 + self.hash_len;
> > +
> > +        let mut offset =3D header_len;
> > +        let mut prev_cert: Option<*mut bindings::x509_certificate> =3D=
 None;
> > +
> > +        while offset < cert_chain_len {
> > +            let cert_len =3D unsafe {
> > +                bindings::x509_get_certificate_length(
> > +                    &cert_chain_buf[offset..] as *const _ as *const u8=
,
> > +                    cert_chain_len - offset,
> > +                )
> > +            };
> > +
> > +            if cert_len < 0 {
> > +                pr_err!("Invalid certificate length\n");
> > +                to_result(cert_len as i32)?;
> > +            }
> > +
> > +            let _is_leaf_cert =3D if offset + cert_len as usize =3D=3D=
 cert_chain_len {
> > +                true
> > +            } else {
> > +                false
> > +            };
> Same as the following?
>                let _is_leaf_cert =3D offset + cert_len as usize =3D=3D ce=
rt_chain_len;

Yep, same thing. My way is the Rust-y way to do it

Although _is_leaf_cert is unused, so I'll just remove it

>
>
> > +
> > +            let cert_ptr =3D unsafe {
> > +                from_err_ptr(bindings::x509_cert_parse(
> > +                    &cert_chain_buf[offset..] as *const _ as *const c_=
void,
> > +                    cert_len as usize,
> > +                ))?
> > +            };
> > +            let cert =3D unsafe { *cert_ptr };
> > +
> > +            if cert.unsupported_sig || cert.blacklisted {
> > +                to_result(-(bindings::EKEYREJECTED as i32))?;
> > +            }
> > +
> > +            if let Some(prev) =3D prev_cert {
> > +                // Check against previous certificate
> > +                let rc =3D unsafe { bindings::public_key_verify_signat=
ure((*prev).pub_, cert.sig) };
> > +
> > +                if rc < 0 {
> > +                    pr_err!("Signature validation error\n");
> > +                    to_result(rc)?;
> > +                }
> > +            } else {
> > +                // Check aginst root keyring
> So this is the check that Dan and Jason are proposing we drop (for now).
>
> Works for me as easy to bring back later and lets us move forward
> in the meantime. As long as userspace gets nothing to indicate
> that we have in any way checked this root cert we are making no false cla=
ims.

Will do!

Alistair

>
> > +                let key =3D unsafe {
> > +                    from_err_ptr(bindings::find_asymmetric_key(
> > +                        self.keyring,
> > +                        (*cert.sig).auth_ids[0],
> > +                        (*cert.sig).auth_ids[1],
> > +                        (*cert.sig).auth_ids[2],
> > +                        false,
> > +                    ))?
> > +                };
> > +
> > +                let rc =3D unsafe { bindings::verify_signature(key, ce=
rt.sig) };
> > +                unsafe { bindings::key_put(key) };
> > +
> > +                if rc < 0 {
> > +                    pr_err!("Root signature validation error\n");
> > +                    to_result(rc)?;
> > +                }
> > +            }
> > +
> > +            if let Some(prev) =3D prev_cert {
> > +                unsafe { bindings::x509_free_certificate(prev) };
> > +            }
> > +
> > +            prev_cert =3D Some(cert_ptr);
> > +            offset +=3D cert_len as usize;
> > +        }
> > +
> > +        if let Some(prev) =3D prev_cert {
> > +            if let Some(validate) =3D self.validate {
> > +                let rc =3D unsafe { validate(self.dev, slot, prev) };
> > +                to_result(rc)?;
> > +            }
> > +
> > +            self.leaf_key =3D unsafe { Some((*prev).pub_) };
> > +        }
> > +
> > +        Ok(())
> > +    }
> >  }
>
>
