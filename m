Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794459063;
	b=HBBmVa2E9XElMAbk33dfUZCP5wj0hoRpsZRp2aTd9Iy+ZWnjqK09Hqf/91AFfyQJqFdH
	 JY36qVYLfwFilPDF1RFrrHwsEiiygnpaqtUBdUkV9l09znfMZkLu6HC9Aiutmk94MHwDg
	 q7OubF07Lg5+jAaZEaTHKsYKxeeMJ7n57zOVtDM+Td1gAaLNMZPVGSZCmO53WCTJUpWqF
	 KNI9IgXETePa/ykhORC/Omioiy7hb1PtH86W7kfuZp1RBs+fG8pUl5/8tL6nIa90BHm0b
	 uqngCjznWQfj0csQ4oRPm1TSbELAiLImu2lhdYUz6UlWV0yw4soLutQo7cvol8LKviw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aCR4+4F4D0AC9cGsRZ13mMFu9/arHyThIEzuRiyV5r8=;
	b=Jnc8pVWULilTU8OriRNhRcPf5hK1YnruJLGfcixWu9p+DXw9Qz6MHNLfupexH4eOp1IJ
	 s2SprH55YeyCvPuj6hQ+oL0JndG7/YDveMp+QbNmE4vd0IG4stvgG6R7zZFqvryilYLwu
	 AnlbMtTy/NuBft8+1o1xaN5yg/HtiBj20jK3Bvq0avtAND6tK30xK+JZwoeEqNUfkTfVg
	 7EdwqN5I2SHwf+GhA48yictOclP24riWT4p9ATSPBXkh94iPmWH2pXeQ2/X3Gd/Yww/9+
	 HwJIlAMhR8DVWP+zpcgMeyUVKbzUm/HgdY2F73km+DhvFkmrny2+pfvATmwxIHHdesg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bQzfD5Ca;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5374606A323
	for <linux-cxl@vger.kernel.org>; Thu, 12 Nov 2026 04:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5374606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bQzfD5Ca
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso568764966b.2
        for <linux-cxl@vger.kernel.org>; Wed, 11 Nov 2026 20:51:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794459061; cv=none;
        d=google.com; s=arc-20260327;
        b=Un8Ct1TgeTDMaj8A+AsO6Yd5OfXVqMXLMwBPbcFcHLWrGFRjzdOQcMnDpvzxQLPRvN
         EcMhv+BZrpfV+dhENxftVZ/QHAocUuoJdqtjGh+vdOIzsJZBsZe3UdJHFblchWjhm2MH
         nAH5wwA5Xow9bKxVfdubLOq14ZT4eQmwmRYlf0leKceRHtkj6bBZHUDVce/6Qkd7vrpT
         us3CPgarjLTiktkyrEDaO9ZGsi1Ea38dTsCgABW9kjEXYbCIji0T7RPj2PjIbqVgzJ9V
         ShgQ0wxyeAP1QDg8v7U8xXaK2g+w1WmE/Mxmjwz2f7rj1Aq+p0GhRS7nI16vLD9bWRd3
         jT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aCR4+4F4D0AC9cGsRZ13mMFu9/arHyThIEzuRiyV5r8=;
        fh=ukmL1bdwlwEQE7DWc7HA6aybcI1fhH9XdUTjWN9FSTg=;
        b=UQdC67nUXBOmDvv2BwW8uiE1jZhj+HkQnerdiLTjVmUdj7lW1K6ApjbD20a7deoTDL
         ZiqoJu42vvAx9k9p66Xh0Km9br8dEpKRrdDnlOwe9ZcWfnhwuwMsgwgGgvuYGvyRQCIc
         xL8Qb2gBPY2zaBr3tQbO9o9n5amokXDKQExUzumC1WeGHfCfdCHIcrtEgb1yzd1NpGRo
         XAWjsQ4tDsa4wyx4gpQG2Iv7p8Fenr3IQrkxMDQjVuuywY/wi/zgX00gpubVg90E/1og
         UVlbXSBN/l9/43l3aKjSOjXv65j0VAU+VNGEVTM7f+mPI1daQjbfZ5pIJf9Xb1d73zch
         kCvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459061; x=1795063861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aCR4+4F4D0AC9cGsRZ13mMFu9/arHyThIEzuRiyV5r8=;
        b=bQzfD5CaK4WDR4MvMf7uIsGcfYpEw8h0GGuppnzS3K4+WGGepsz6qr3low/gWj6uBX
         8VtyTqZhYX9T/mybPe3ku9DYSjBQ3fjy14B/jxQOA4ZnUPuPUTpcTSUeaSOetSSJCSBL
         KAHlJ3mf0wU0XwShXVWqfPggPYu1Ba8ijIhCehqkw0Xf3ddanEEv2TMVsOrLhSbdnYL6
         FNcFwKdOqFfi8k78KwxPZZlynCzpRyVyNtausrtKn0sk8GmYU1pvnbQmq40+YtuXn5D+
         C+e4Mv0fP080HUtfLHO+Wy0pIeMLFHHKepUyp0RPTjF8t7sdoUZyMASNlMUA3phrqxp4
         279g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459061; x=1795063861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCR4+4F4D0AC9cGsRZ13mMFu9/arHyThIEzuRiyV5r8=;
        b=E+Avij7K+QREyLovhU2HbBqqxuG00D9G8ucR14pgmCC3fCrtcdrIag/A3edpu+u7GH
         Q+FFSKfZIf9DwOex+DUQ1BuKNW8yl113P/7FPNElDDVdmCbTjoS8IQLxBzl8+s6qsoX1
         mVt7CjrFq1VONBgNUiwMZ7MXzsX3cKz5pkpDXb7TeEfKM/Y1AG22F8felS6qhA2gnYnQ
         9x0SSiYpAajb//X+KocFUV4OyilHGjNGsSRWdEB8rmu+W0Ca0ZAVFZaERErqdLcUKr61
         d4fcr3Da6vzZMhArat2d334pbpcqd3YbS3HZi4bSKPXYFT4FSF2EqoNjm1EAzVANtGm9
         Yu5Q==
X-Forwarded-Encrypted: i=1; AL+hErHJ6ovrinhAWyUrF5QKGLQBlG4ipvuv7FYDCpjfpj0ro5D7of1LII9gmen5mTEfIhd6VkTBWaKmJc4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SmfDnASaEoUB4JwMi/H8kfYULOiWmU8t6PHjdyxFCA6kFBeRU
	OmZIan6/INl3sk+Ey7HL1lxBtUQb/ftmLt9zQtjLLWnxNr1GKmPfDea6XJElu9AK+SFU1xI7dWI
	sGFwxXeqTy9RGgUBLxodohH6csfUCj70=
X-Gm-Gg: AYBFou1JHePG8jatIr3UGLhlSEESm7CU83Glmrn0qwKx3NUqvUYg0ODDf4MYhlDMyil
	4JXTdI6sPGsrSh+bQV6Y/LHIUXaMeOOqoBcnRJfBoZ96WwkxXT3NGqcRZNsy8wb3AVSXrex1BRd
	C3bgg3Vxa8CBehLWQNnzS6o8rXV4y7k6RnpCO9u+yer9G+0Xm0HOtgwUCEGnDI1cdtRCg1LjpxC
	Iszr0mKCfkDjG5qIjGOfmEQBe7PBqEy0jvoJmZ7dtvWolhFZyAwLUwh6PdFkEEkjw2LQjpODKnG
	opx8fKVDLu5pLQDTOw2sduAYruTUUXkeZ2MxPOyXzjXTFAbd2a+cShQSEyzgwmAul+VXlojBIEC
	AXwZ62svjIZQ8iJieHroKRQmTasZLCJg7NAvF8XvNHjavA4YlZKYHX8pJYKubuFeRqmmm
X-Received: by 2002:a17:907:6c17:b0:c29:4915:83cb with SMTP id
 a640c23a62f3a-c5066d6947dmr397522366b.39.1794459060886; Wed, 11 Nov 2026
 20:51:00 -0800 (PST)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-18-alistair.francis@wdc.com> <sashiko-outbox-206231@kernel.org>
In-Reply-To: <sashiko-outbox-206231@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Nov 2026 14:50:34 +1000
X-Gm-Features: AclHuK-9VHicJV1Vi_F_TXRxI13n5FCeFli60f1unwNFJ7VY-Njj1MkgHyWgv9E
Message-ID: <CAKmqyKMa7p6hkD1_NrABuaxxv3c=MQ0cDMUcAcYbPjtfOmJ4gQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/25] lib: rspdm: Support SPDM negotiate_algorithms
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org, 
	gary@garyguo.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:42=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] lib: rspdm: build failure in update_response_algs() without
>   crypto Kconfigs
> - [Low] lib: rspdm: unreachable extended algorithm loops in
>   NegotiateAlgsRsp::validate()
> --
>
> commit 69781025c793b90efaa465da8436c6f48e861229
> Author: Alistair Francis <alistair.francis@wdc.com>
>
> lib: rspdm: Support SPDM negotiate_algorithms
>
> This commit adds support for the SPDM NEGOTIATE_ALGORITHMS command,
> including request construction, response validation, and algorithm state
> selection.
>
> > diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> > index cb6a351fe6085..169d0d3fee9bd 100644
> > --- a/lib/rspdm/state.rs
> > +++ b/lib/rspdm/state.rs
> [ ... ]
> > @@ -265,4 +323,113 @@ pub(crate) fn get_capabilities(&mut self) -> Resu=
lt<(), Error> {
> >
> >          Ok(())
> >      }
> > +
> > +    fn update_response_algs(&mut self) -> Result<(), Error> {
> > +        match self.base_asym_alg {
> > +            #[cfg(CONFIG_CRYPTO_RSA)]
> > +            SPDM_ASYM_RSASSA_2048 =3D> {
> > +                self.sig_len =3D 256;
> > +                self.base_asym_enc =3D c"pkcs1";
> > +            }
> > +            #[cfg(CONFIG_CRYPTO_RSA)]
> > +            SPDM_ASYM_RSASSA_3072 =3D> {
> > +                self.sig_len =3D 384;
> > +                self.base_asym_enc =3D c"pkcs1";
> > +            }
> > +            #[cfg(CONFIG_CRYPTO_RSA)]
> > +            SPDM_ASYM_RSASSA_4096 =3D> {
> > +                self.sig_len =3D 512;
> > +                self.base_asym_enc =3D c"pkcs1";
> > +            }
> > +            #[cfg(CONFIG_CRYPTO_ECDSA)]
> > +            SPDM_ASYM_ECDSA_ECC_NIST_P256 =3D> {
> > +                self.sig_len =3D 64;
> > +                self.base_asym_enc =3D c"p1363";
> > +            }
> > +            #[cfg(CONFIG_CRYPTO_ECDSA)]
> > +            SPDM_ASYM_ECDSA_ECC_NIST_P384 =3D> {
> > +                self.sig_len =3D 96;
> > +                self.base_asym_enc =3D c"p1363";
> > +            }
> > +            #[cfg(CONFIG_CRYPTO_ECDSA)]
> > +            SPDM_ASYM_ECDSA_ECC_NIST_P521 =3D> {
> > +                self.sig_len =3D 132;
> > +                self.base_asym_enc =3D c"p1363";
> > +            }
> > +            _ =3D> {
> > +                dev_err!(&self.dev, "Unknown asym algorithm\n");
> > +                return Err(EPROTO);
> > +            }
> > +        }
> > +
> > +        let hash_name =3D match self.base_hash_alg {
> > +            #[cfg(CONFIG_CRYPTO_SHA256)]
> > +            SPDM_HASH_SHA_256 =3D> c"sha256",
> > +            #[cfg(CONFIG_CRYPTO_SHA512)]
> > +            SPDM_HASH_SHA_384 =3D> c"sha384",
> > +            #[cfg(CONFIG_CRYPTO_SHA512)]
> > +            SPDM_HASH_SHA_512 =3D> c"sha512",
> > +            _ =3D> {
> > +                dev_err!(&self.dev, "Unknown hash algorithm\n");
> > +                return Err(EPROTO);
> > +            }
> > +        };
> > +
> > +        self.crypto =3D Some(Shash::new(hash_name)?);
> > +
> > +        Ok(())
> > +    }
> > +
> > +    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
> [ ... ]
> > +        self.base_asym_alg =3D response.base_asym_sel;
> > +        self.base_hash_alg =3D response.base_hash_sel;
> > +        self.meas_hash_alg =3D response.measurement_hash_algo;
> > +
> > +        if self.base_asym_alg & SPDM_ASYM_ALGOS =3D=3D 0 || self.base_=
hash_alg & SPDM_HASH_ALGOS =3D=3D 0 {
> > +            dev_err!(&self.dev, "No common supported algorithms\n");
> > +            return Err(EPROTO);
> > +        }
>
> [Severity: Medium]
> Does this fail to build when CONFIG_RSPDM=3Dy is enabled without any asym=
metric
> crypto option (CONFIG_CRYPTO_RSA and CONFIG_CRYPTO_ECDSA both disabled) o=
r
> without any hash option (CONFIG_CRYPTO_SHA256 and CONFIG_CRYPTO_SHA512 bo=
th
> disabled)?

Probably, but that would be an invalid option and probably should fail to b=
uild

Alistair

>
> When both options in either pair are disabled, the corresponding match in
> update_response_algs() collapses to the diverging wildcard arm alone, whi=
ch
> triggers rustc unreachable_code and unused_variables errors as well as
> clippy::match_single_binding.  In addition, SPDM_ASYM_ALGOS or
> SPDM_HASH_ALGOS evaluates to 0, so the bitmask check in negotiate_algs()
> triggers clippy::bad_bit_mask.
>
> > diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> > index 66212f0faf5f1..335f2f43dc07c 100644
> > --- a/lib/rspdm/validator.rs
> > +++ b/lib/rspdm/validator.rs
> [ ... ]
> > +        // We currently never request extended algorithms or algorithm=
 structures
> > +        if header.param1 !=3D 0 || ext_asym_sel_count !=3D 0 || ext_ha=
sh_sel_count !=3D 0 {
> > +            dev_err!(
> > +                &context.dev,
> > +                "Responder selected unsupported extended algorithms\n"
> > +            );
> > +            return Err(EPROTO);
> > +        }
> > +
> > +        let mut offset =3D NEGOTIATE_ALGS_RSP_SZ;
> > +
> > +        let mut ext_asym =3D KVec::new();
> > +        for _ in 0..ext_asym_sel_count {
> > +            ext_asym.push(read_le32(offset)?, GFP_KERNEL)?;
> > +            offset +=3D mem::size_of::<u32>();
> > +        }
> > +
> > +        let mut ext_hash =3D KVec::new();
> > +        for _ in 0..ext_hash_sel_count {
> > +            ext_hash.push(read_le32(offset)?, GFP_KERNEL)?;
> > +            offset +=3D mem::size_of::<u32>();
> > +        }
> > +
> > +        let mut resp_alg_struct =3D KVec::new();
> > +        for _ in 0..header.param1 {
> > +            let alg_type =3D *unvalidated.get(offset).ok_or(EPROTO)?;
> > +            let alg_count =3D *unvalidated.get(offset + 1).ok_or(EPROT=
O)?;
> > +            let fixed_alg_count =3D (alg_count >> 4) as usize;
> > +            let ext_alg_count =3D (alg_count & 0xf) as usize;
> > +            offset +=3D 2;
> > +
> > +            let mut alg_supported =3D KVec::new();
> > +            alg_supported.extend_from_slice(
> > +                unvalidated
> > +                    .get(offset..offset + fixed_alg_count)
> > +                    .ok_or(EPROTO)?,
> > +                GFP_KERNEL,
> > +            )?;
> > +            offset +=3D fixed_alg_count;
> > +
> > +            let mut alg_external =3D KVec::new();
> > +            for _ in 0..ext_alg_count {
> > +                alg_external.push(read_le32(offset)?, GFP_KERNEL)?;
> > +                offset +=3D mem::size_of::<u32>();
> > +            }
> > +
> > +            resp_alg_struct.push(
> > +                RespAlgStruct {
> > +                    alg_type,
> > +                    alg_count,
> > +                    alg_supported,
> > +                    alg_external,
> > +                },
> > +                GFP_KERNEL,
> > +            )?;
> > +        }
>
> [Severity: Low]
> This isn't a bug, but since NegotiateAlgsRsp::validate() returns Err(EPRO=
TO)
> above whenever header.param1, ext_asym_sel_count, or ext_hash_sel_count i=
s
> non-zero, the three loops that follow can never execute (and duplicate th=
e
> parsing in SupportedAlgorithms::from_bytes()).
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.17=
30924-1-alistair.francis@wdc.com?part=3D17
