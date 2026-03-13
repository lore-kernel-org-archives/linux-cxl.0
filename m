Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AFD261B71
	for <linux-cxl@vger.kernel.org>; Fri, 13 Mar 2026 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773380171; cv=pass; b=ZDBdnPNqYmL2eNezYq0a25w7Og4blwttAssp1jt3QQN8hwICl91eGatiKnbElZe7Xw5VLrym03vfmH9H8F5JD04EPgVzDZLQU6opZLN/PXqCJJsIkv7tAE9a33e6VMSDnu8CobGm45LoI4fZA19A8bcOPk1M+0ysyG9PiYDNOU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773380171; c=relaxed/simple;
	bh=pUFInfE4ngkOiIq7A9ROEzatsPZM5Nujb7Th/pV73HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2oC/CmCFLeTYnOkYzmNOvDgwaHM5Wbd+b+xZMGAEUlAkKlK8UCZaykJp+WLWo6cM/imnsY74m1w233LQmHw4x9F+R3VjJTMvDWBDjxGD9Wyv27PaevJ5P34GuVorFP8htPNSJ3+eJ3baDPTIKod2+J2IJjr51Bna6B6WY/Re1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsTxnTdo; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsTxnTdo"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6611d20c026so2678057a12.1
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 22:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773380167; cv=none;
        d=google.com; s=arc-20240605;
        b=fW9ncwj82EJw0eh0mdA5RT/F1lF1bgYzlyqjhbG/+BWDuMBBrsIl4gDAHW+ladB0Ui
         1x47jM12G8J0O4LiYx2yrWJxVudOfP0g1G79/edsiVGX5SKT5gZhceqjHQ1MxF+ZxEeF
         S675O9RTV808W3oFSU/RL1GTQx3mXJAy332BK71vSAnk5XMAUwQLlrgdRmSTbcFO/tbh
         zKNBR3aSMCfJEmXWO7gd5MYJGCkpGwi4KBX2kfzrcjupviTlXaETGB3kFmLJF+j1QE64
         LgfZ4hRCUeqJeqlBVX8gfrJ4/M63wXOCB+tmv8m2/kiyDb1qOro89DvxjrnIBmYkm5uT
         5zyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aQDPRle9auiI589+HEKa3AVFHfQ0L3XutZyywJyeO2c=;
        fh=Sc/YGtL1Fz4fPxcJp52oo51n+xlwNkIk4fCx3EOntHc=;
        b=gY/TxsaloM/mxHPL7M2AEka1o/OOSAdOahIBwNpYot1xUxtR8IaIZ26NKH9fQWkC/S
         mkflRLpavLI+CUGVO5Z/hS6Cdd0xJes8SdW1VoynTNznhmkmM7hptZxLofIeXRSFgBI9
         buno95qlHC401lMaKUAgtEpHepKiuo+29VIYiWuhfhkBiLttp56FkXqdWTSVXMA8Lnrp
         qnwRw1+YW8c4Uk0Z1H9387dtuMx7s/2+W3+tHC49+uplmrVlhEZsOKMG66Z9ipRQWFtL
         lXOb9Q6LNg4yphy6+rOqnf7LgP4v5EZr3IhGx5bZ9Xai3PJxgpHAwQwkEacw6p8uVGgQ
         aPGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773380167; x=1773984967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQDPRle9auiI589+HEKa3AVFHfQ0L3XutZyywJyeO2c=;
        b=SsTxnTdo45v/pINSSqnFfa7YFQmi6VB+yb3Yh9augwtEZh5yq2nn+4EQQUF0fstwpY
         gg6ntltpF0oHa1X+m2dJZKH/K0Nnz7GU1VKwYi0LLeFy/ZXE+pP4sc3ASaIfZbSr0XXR
         2ki9OpvhYXL9PZA2w31zGVb71Yt3ffaufuoO+rdshnFYn1dltuKmCholDn9/OHvPh/5P
         9g5H7z1wrePlMXN0AwCmvlCYqLccfLmb0wx3aa+fzUq+ZaLtW/rdgR4gJyIwltiUqV91
         y/JUNY1TssbwcqLOQo/ltEavDhtIVJX8PO+qYLymXOx/JIKmLRuwYw5pzGCnNMxf5Dsz
         6hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773380167; x=1773984967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aQDPRle9auiI589+HEKa3AVFHfQ0L3XutZyywJyeO2c=;
        b=HMSVtzuGw22lBKuu+ZIGymKmgzZWxkAIVJcCRBU3DSemW1d/qQ8ymHvGb18jl9tGYk
         v6z1i6Kogg/F1ZjskW/HLwhX5A2L/3PWx+ouYj+g3PGJLzt7UudLAvNNa5IYXW7/Y+2W
         LWvcXBOws2UN3UpdMH81GUU7mjsUXXREONFuj4539FotJrj5hqrSc+CNV6v6Bm86Vd2b
         NczFEPxT1kkHWTE5QcORiCen66YH2OkLOnFb1fmgoXi2G58IQX3DsdCa+YDcrKTIv61w
         kHXrfZ1JPpoMhUntF76E2YF/zb+FAIwVEwqxWkXZEu7KXiDyB87XHdBYUeq73+RLzMHe
         Z4wA==
X-Forwarded-Encrypted: i=1; AJvYcCUxMw4CIZHZjT1kzpFZGHHhG2NE3YjG0G1NpCMCW+0A+UbStA3YTf88+hxX0OK0JlCFu0C7K0KWvyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwILkZ0arUVVpL/Rtq8QBRVxU2D+ruRgFdcthRJDFBNTbhM5JZQ
	WYS7a1hdGfkM1i+Rb9mJlnqi3sG0GjdkZ5tqA7ZN4eaArkqKztoK2oGbbRbpDnsK7vhjh222mc7
	CNKoFSxYubX/eqaax7kTRc3tLkWYROUA=
X-Gm-Gg: ATEYQzxklYJlrhBxn+CQsfbWSmNyppXNOyxnH3XSgjvnBvgFvPmRX3yLFTfzZRfZqJp
	gRYEQ5M2c37ylQ8gAJ3iSUnhkaSPpaaHuchwQCVfTYrTaRAbeQs9CqhVLbjw8vu7xnmFP639CA5
	DW4i4UffB3kVjWpR2X/kJ/PIgC7TaTaRVxKQ1v1A+ooFIVdSQ2ruGlf3kCpmz+xsCnzeJYtUgAA
	IgUmo7ZF9D58jCmk6E5IAltsXuSxRXNO6tOrSAWNw/hw5mmP9xabBEKgzUPs7LHE2289bpfVKH7
	dYrw7APDRFjKiQe40/Xa0mUSTVh9U6HqMDRVdw==
X-Received: by 2002:a05:6402:2805:b0:662:dc7e:b186 with SMTP id
 4fb4d7f45d1cf-663ba0fbe97mr1067010a12.11.1773380167124; Thu, 12 Mar 2026
 22:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-13-alistair.francis@wdc.com> <20260303113642.00005774@huawei.com>
In-Reply-To: <20260303113642.00005774@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 15:35:40 +1000
X-Gm-Features: AaiRm51ujclaTlYhyqJznEW2TcmQhKu6KtQRn4y8IbzebLrYInO3G-JLbzUdduo
Message-ID: <CAKmqyKMUT__C=4Lo5BhjB_QoaGHHNHQvxLmL4xuB54U=Rm0nzg@mail.gmail.com>
Subject: Re: [RFC v3 12/27] lib: rspdm: Support SPDM get_version
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

On Tue, Mar 3, 2026 at 9:36=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 11 Feb 2026 13:29:19 +1000
> alistair23@gmail.com wrote:
>
> > From: Alistair Francis <alistair@alistair23.me>
> >
> > Support the GET_VERSION SPDM command.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Hi Alistair,
>
> Various minor comments inline. Biggest one is what I think
> is some confusing le16 handling that to me is in the wrong place.
>
> Jonathan
>
> > ---
> >  lib/rspdm/consts.rs    | 17 +++++++++++
> >  lib/rspdm/lib.rs       |  6 +++-
> >  lib/rspdm/state.rs     | 58 ++++++++++++++++++++++++++++++++++--
> >  lib/rspdm/validator.rs | 67 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 144 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
> > index 40ce60eba2f3..38f48f0863e2 100644
> > --- a/lib/rspdm/consts.rs
> > +++ b/lib/rspdm/consts.rs
>
> > @@ -115,3 +129,6 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> =
core::fmt::Result {
> >          Ok(())
> >      }
> >  }
> > +
> > +pub(crate) const SPDM_GET_VERSION: u8 =3D 0x84;
> > +pub(crate) const SPDM_GET_VERSION_LEN: usize =3D mem::size_of::<SpdmHe=
ader>() + 255;
>
> I'd either add a comment on where the 255 comes from. Also do we have a U=
8_MAX definition
> we can use?  Or some way to get it from code?

Fixed, can just use `u8::MAX`

>
> > diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> > index 2bb716140e0a..08abcbb21247 100644
> > --- a/lib/rspdm/lib.rs
> > +++ b/lib/rspdm/lib.rs
> > @@ -108,7 +108,11 @@
> >  /// Return 0 on success or a negative errno.  In particular, -EPROTONO=
SUPPORT
> >  /// indicates authentication is not supported by the device.
> >  #[no_mangle]
> > -pub unsafe extern "C" fn spdm_authenticate(_state: &'static mut SpdmSt=
ate) -> c_int {
> > +pub unsafe extern "C" fn spdm_authenticate(state: &'static mut SpdmSta=
te) -> c_int {
>
> Is there more to this rename than it appears?  Can it get pushed back to =
earlier patch?

Rust will complain about `state` being unused, by adding a `_` to the
front we don't get the warning in the previous patch. So in this patch
I rename it back to `state` as it's now used.

This is a public function that matches the C implementation, hence the
arguments being fixed in the previous patch.

>
> > +    if let Err(e) =3D state.get_version() {
> > +        return e.to_errno() as c_int;
> > +    }
> > +
> >      0
> >  }
> >
> > diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> > index 68861f30e3fa..3ad53ec05044 100644
> > --- a/lib/rspdm/state.rs
> > +++ b/lib/rspdm/state.rs
> > @@ -8,6 +8,7 @@
> >  //! <https://www.dmtf.org/dsp/DSP0274>
> >
> >  use core::ffi::c_void;
> > +use core::slice::from_raw_parts_mut;
> >  use kernel::prelude::*;
> >  use kernel::{
> >      bindings,
> > @@ -15,8 +16,10 @@
> >      validate::Untrusted,
> >  };
> >
> > -use crate::consts::{SpdmErrorCode, SPDM_ERROR, SPDM_REQ};
> > -use crate::validator::{SpdmErrorRsp, SpdmHeader};
> > +use crate::consts::{
> > +    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPD=
M_MIN_VER, SPDM_REQ,
>
> Is the Rust linter fussy about these being on one line? Feels like we'd
> get less churn over time if we formatted this as one per line.

This is just how the linter formats it when I run ` LLVM=3D1 make
rustfmt`. I don't really want to be manually formatting things

>
> > +};
> > +use crate::validator::{GetVersionReq, GetVersionRsp, SpdmErrorRsp, Spd=
mHeader};
> >
> >  /// The current SPDM session state for a device. Based on the
> >  /// C `struct spdm_state`.
> > @@ -61,7 +64,7 @@ pub(crate) fn new(
> >              transport_sz,
> >              keyring,
> >              validate,
> > -            version: 0x10,
> > +            version: SPDM_MIN_VER,
>
> Pull that def back to earlier patch to keep the churn confined.

Fixed

>
> >          }
> >      }
> >
> > @@ -217,4 +220,53 @@ pub(crate) fn spdm_exchange(
> >
> >          Ok(length)
> >      }
> > +
> > +    /// Negoiate a supported SPDM version and store the information
> > +    /// in the `SpdmState`.
> > +    pub(crate) fn get_version(&mut self) -> Result<(), Error> {
> > +        let mut request =3D GetVersionReq::default();
> > +        request.version =3D self.version;
> > +
> > +        // SAFETY: `request` is repr(C) and packed, so we can convert =
it to a slice
> > +        let request_buf =3D unsafe {
> > +            from_raw_parts_mut(
> > +                &mut request as *mut _ as *mut u8,
> > +                core::mem::size_of::<GetVersionReq>(),
> > +            )
> > +        };
> > +
> > +        let mut response_vec: KVec<u8> =3D KVec::with_capacity(SPDM_GE=
T_VERSION_LEN, GFP_KERNEL)?;
> > +        // SAFETY: `request` is repr(C) and packed, so we can convert =
it to a slice
> > +        let response_buf =3D
> > +            unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), SPD=
M_GET_VERSION_LEN) };
> > +
> > +        let rc =3D self.spdm_exchange(request_buf, response_buf)?;
> > +
> > +        // SAFETY: `rc` is the length of data read, which will be smal=
ler
> > +        // then the capacity of the vector
>
> than?

Fixed

>
> > +        unsafe { response_vec.inc_len(rc as usize) };
> > +
> > +        let response: &mut GetVersionRsp =3D Untrusted::new_mut(&mut r=
esponse_vec).validate_mut()?;
> > +
> > +        let mut foundver =3D false;
> > +        for i in 0..response.version_number_entry_count {
> > +            // Creating a reference on a packed struct will result in
> > +            // undefined behaviour, so we operate on the raw data dire=
ctly
> > +            let unaligned =3D core::ptr::addr_of_mut!(response.version=
_number_entries) as *mut u16;
>
> Maybe pull that out of the loop like you do below?

Fixed

>
> > +            let addr =3D unaligned.wrapping_add(i as usize);
> > +            let version =3D (unsafe { core::ptr::read_unaligned::<u16>=
(addr) } >> 8) as u8;
> Given the endian conversion below, this is correct, but I think leaving i=
t as the __le16 until
> here is better.  We could also just pull out the correct byte and ignore =
the other one.

Hmm... I'm not sure I follow.

The SPDM spec describes this as a u16, so I'm reading the entire value
and just taking the upper bits for the Major/Minor version

So I'm not sure what you think I should do differently?

> It's a spec quirk that they decided to have it defined as a __le16 rather=
 than u8[2] as
> the fields are confined one byte or the other.
>
> I wonder if we should also reject any alpha versions? I.e. check the bott=
om 4 bits
> are 0.

Hmmm... That seems a bit unnecessary. Maybe a warning though?

>
> > +
> > +            if version >=3D self.version && version <=3D SPDM_MAX_VER =
{
> > +                self.version =3D version;
> > +                foundver =3D true;
> > +            }
> > +        }
> > +
> > +        if !foundver {
> > +            pr_err!("No common supported version\n");
> > +            to_result(-(bindings::EPROTO as i32))?;
> > +        }
> > +
> > +        Ok(())
> > +    }
> >  }
> > diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> > index a0a3a2f46952..f69be6aa6280 100644
> > --- a/lib/rspdm/validator.rs
> > +++ b/lib/rspdm/validator.rs
> > @@ -7,6 +7,7 @@
> >  //! Rust implementation of the DMTF Security Protocol and Data Model (=
SPDM)
> >  //! <https://www.dmtf.org/dsp/DSP0274>
> >
> > +use crate::bindings::{__IncompleteArrayField, __le16};
> >  use crate::consts::SpdmErrorCode;
> >  use core::mem;
> >  use kernel::prelude::*;
> > @@ -15,6 +16,8 @@
> >      validate::{Unvalidated, Validate},
> >  };
> >
> > +use crate::consts::SPDM_GET_VERSION;
> > +
> >  #[repr(C, packed)]
> >  pub(crate) struct SpdmHeader {
> >      pub(crate) version: u8,
> > @@ -64,3 +67,67 @@ pub(crate) struct SpdmErrorRsp {
> >      pub(crate) error_code: SpdmErrorCode,
> >      pub(crate) error_data: u8,
> >  }
> > +
> > +#[repr(C, packed)]
>
> Why packed?

We cast it from a struct to a slice (array), so we need it to be
packed to avoid gaps in the slice (array)

>
> > +pub(crate) struct GetVersionReq {
> > +    pub(crate) version: u8,
> > +    pub(crate) code: u8,
> > +    pub(crate) param1: u8,
> > +    pub(crate) param2: u8,
> > +}
> > +
> > +impl Default for GetVersionReq {
> > +    fn default() -> Self {
> > +        GetVersionReq {
> > +            version: 0,
>
> Given this only takes one value we could default it to 0x10
> (even though it's written above to keep the state machine in sync).

We could, I do find that less clear though. Explicit writing it as
part of `get_version()` to me is really clear what is happening

>
> > +            code: SPDM_GET_VERSION,
> > +            param1: 0,
> > +            param2: 0,
> > +        }
> > +    }
> > +}
> > +
> > +#[repr(C, packed)]
> > +pub(crate) struct GetVersionRsp {
> > +    pub(crate) version: u8,
> > +    pub(crate) code: u8,
> > +    param1: u8,
> > +    param2: u8,
> > +    reserved: u8,
> > +    pub(crate) version_number_entry_count: u8,
> > +    pub(crate) version_number_entries: __IncompleteArrayField<__le16>,
> > +}
> > +
> > +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetVersionRsp {
> > +    type Err =3D Error;
> > +
> > +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Sel=
f, Self::Err> {
> > +        let raw =3D unvalidated.raw_mut();
> > +        if raw.len() < mem::size_of::<GetVersionRsp>() {
> > +            return Err(EINVAL);
> > +        }
>
> I guess it probably belongs at the header validation point rather that he=
re,
> but can we also check the version matches what was requested. Possibly an
> additional check here that it is 0x10 (as this one is a special case wher=
e
> only that value is correct).

Good point, I have added a check here

>
> > +
> > +        let version_number_entries =3D *(raw.get(5).ok_or(ENOMEM))? as=
 usize;
> > +        let total_expected_size =3D version_number_entries * 2 + 6;
>
> Instead of 6 can we use mem::size_of::<GetVersionRsp>()?

Yep! Good idea

> Ideally something similar for the 2 as well even if it's a bit verbose.
> (if I was lazy in the C code you get to make it better here :)

let total_expected_size =3D version_number_entries *
mem::size_of::<__le16>() + mem::size_of::<GetVersionRsp>();

>
>
> > +        if raw.len() < total_expected_size {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        let ptr =3D raw.as_mut_ptr();
> > +        // CAST: `GetVersionRsp` only contains integers and has `repr(=
C)`.
> > +        let ptr =3D ptr.cast::<GetVersionRsp>();
> > +        // SAFETY: `ptr` came from a reference and the cast above is v=
alid.
> > +        let rsp: &mut GetVersionRsp =3D unsafe { &mut *ptr };
> > +
> > +        // Creating a reference on a packed struct will result in
>
> Silly question, but why is it packed?  We might need to do this for some
> structures in SPDM but do we have transports that mess up the alignment e=
nough
> that where the messages themselves don't need to be packed we have to mar=
k
> the structures so anyway? Probably good to document this somewhere.

Like above, the Rust structs contain the information which we cast to
the slice (u8 array). So we want it to be packed to avoid gaps in the
buffer.

>
> > +        // undefined behaviour, so we operate on the raw data directly
> > +        let unaligned =3D core::ptr::addr_of_mut!(rsp.version_number_e=
ntries) as *mut u16;
> > +        for version_offset in 0..version_number_entries {
> > +            let addr =3D unaligned.wrapping_add(version_offset);
> > +            let version =3D unsafe { core::ptr::read_unaligned::<u16>(=
addr) };
> > +            unsafe { core::ptr::write_unaligned::<u16>(addr, version.t=
o_le()) }
>
> I'd like to see a comment on why this seems to be doing an endian swap if=
 we
> are on big endian. Looking back at the c code, it has an endian swap but
> only as part of the search for a version to use (finding the largest both
> device and and kernel support).
>
> Maybe I'm reading it wrong but isn't this putting cpu endian data into a =
structure
> element that is of type __le16?

On second thought I don't think this is required at all. It's
converting the LE data from the SPDM response to LE. Which is just
unnecessary no-op (LE) or a bug (BE) depending on the CPU endianness.

Alistair

>
> > +        }
> > +
> > +        Ok(rsp)
> > +    }
> > +}
>
