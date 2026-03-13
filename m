Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B534FF5A
	for <linux-cxl@vger.kernel.org>; Fri, 13 Mar 2026 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773373474; cv=pass; b=c9ZyrpddeXd0TQKt0Zlt3grWAPu3jJT78BwG53sC0eTtC3ETYJGrszaz+pWfE/TObTMGKmw0jIQrdTDoKdycez5PTB8nrpkW1iHyzOcL56fQGQxD/2k1O03DYGzUz977lrLyZ0mCHRC/Q7GVhTwYvQtPrdtfxTfTCX04nXHv2+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773373474; c=relaxed/simple;
	bh=z/SZmd63NAsIgkleYYPkULZwmMuC37+dqhe/h6A+kkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slfzhWXuWhBYQAC4kWtUrRekJaETkFiShtDSpojs2W2Re+tK+GAMgPzzWRs5QpJnPyDxvHgmL5y9rR+3F8WNbwKXdmyAduPipv/hUpRLWyQA5roK02QqEwCNr2dygZ7lLz7fWIpiUUsEYE3Iq8ICZIu7FDtRp4UX/ZqCJnAKGMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiZO9xGI; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiZO9xGI"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so2758545a12.1
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 20:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773373471; cv=none;
        d=google.com; s=arc-20240605;
        b=JE2JBqqNmsLbl9tEcvzHkdOM011IamWO1RjRZQvfZCzmZyQFpVZwCrTwftrDKH2ZU+
         9dU4ivqVaw8Hs6UntZGt4kKPxCCVKticeF71RVcSVGNRnSi3YADTCCnK677Xua/4OUTr
         5edmthosuJD/J3fMmNjXrQ5uqbCdvRO1M4yIPUsD/JFn2Sug2YgtS+xAp/CaO2ZzeuVM
         qiV/OhA/HtNE8PuA1KlI9b0SaUUU561XKdAYZai5F/c+k5kUnuJ8ptyMy4XBbX8ea8vM
         fJ+Ghx/C2Dq2TW6WKkFZDCqjEoXwb0ssr1+os8OBMWzwZhUx8E+tpgTlo6O0TRPDxxDv
         cvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IeBB2tGWQC/AiZ/UQlcRvgZ/p7KtlMw7yTpNtqSURXM=;
        fh=J1m6fzP5m7FLRaw2tc+58co8X1z63ecF2lve4hmn5Og=;
        b=Jvq1Aimlyg3YWjlJzVs2DcKOq28KMK6hZsm4cOUd1UPYYCf3J5XkVsqFdySbDx5kqt
         r2SC+J2GrWdG0enZrIvdDr1F37DEuAadFvaLD4MkltGZ7AcEWarUQGNqFy13GhX/rRvC
         zphlvufi4BqYHIG/RwDilAJVmbYzxhShyST/Z1zVZXFfR2YHdh1KZUYl+8OwsSYD5YO6
         iolWwD/KXeTU1wV00N/L/QjU1vyfYxQeiuWT8gSJkYvdmNh1o6YM4dFs5Jahh9pQime6
         eij4EXY0/Vhm81ar5eM/r9tJSij7E8AOCa2Cyx9bzaynbaxkHulR7ERYjv9E0wmnjE45
         Gwtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773373471; x=1773978271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeBB2tGWQC/AiZ/UQlcRvgZ/p7KtlMw7yTpNtqSURXM=;
        b=OiZO9xGIImA6DWroK5dCBEzAhxdoXOxJkr7GWc5pmdZJ1Q9BeKWo0ax30JYI5ZUBA1
         T8qFMaKSzK2NNC4AtQw+Gtr7kdo4cr9CUm5lJgtqgsOeIkwAtYIdD4gWHI/5TVNmimTi
         BIe262jXtMFBVu6AlMGllagJzIzXKAZvgz7sXIzMbkPG9o+Ey+oCIVJvYdI/zsiEuLW1
         lIZp1QtYvE/9Ur/mY4YqIJA1TnckTC2IKbK7Y+9OxOlCm7X3vJuTwxDHKAwZKeD1tlyH
         G+q1VFoOUtzm3L16GQoE1BkEqtBsiD86o2DEMCCwoeJSQfWGdZmEgYp02wCDH0GD9V1L
         8hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773373471; x=1773978271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IeBB2tGWQC/AiZ/UQlcRvgZ/p7KtlMw7yTpNtqSURXM=;
        b=VnLckh8juBCh4uMU/VvS6Tah2T5rg8FdA9MlnIL9CLXPfr5BNNgsJwS9ellvg+UJPC
         6TfZLpC2/dZwTczzb3fYNfX1oyz41Et3Me6NveMzwdWLLVMhhrJhKMNMBHirulM5QigS
         IYWnMNbBuNAbdTBMSv2D/FrTDw52AvaGg3vBd7rB/rIIFWGjG4Ts+yZTYUnoFHGjlq5J
         rEdH8GxOaMHQ38HydVcluIBWHJ0rWAQFuer5XKvjcytCmKbplH+XCRPnmdXbiHKZbtOg
         rTrw4EQgFj8xsHPdHGnk40ltPIqljvFgRH9aGHzg+yqjwk6jb/JKDjgrZpTkRmrbJs6m
         5Vxw==
X-Forwarded-Encrypted: i=1; AJvYcCXA6mY/MO/qf8EEFWbipqNyMHjEpyhLo+pmgBk2OEhVWI2Lm6Xjg+e8my4m+EcbrUn1SyC8bxKR8eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNRRxnBxFHFAjgophhvUohRvnb2WJcN5DAvVKbwhTj7LpY1zLP
	1AStJRwTncAb4+GDR2mkojjT0dDPJRdUVXlUoZ89TXOfrLgn1cYciQAueQALd0f/IMzy1F1vdOe
	N6lAB+IjQz2wR1DWIfd7kzBNgr+uW2vU=
X-Gm-Gg: ATEYQzyB+WadNmXuQFywd014m0cNgKbP4LucnGuEW+rBEUYaY8aC2QK6+NxIszjlMGp
	kKGgf2pII891uWouq/qfVtlnx+WIeluZnxHW+pdpseBcdbAJMy0s3q+He5BQm8PreBltJxCnsZU
	UofBio+M3pvDUKz0eOxnZb567qj4f7yVzkQGqCnPGQugOFXZbERYhwCS/WgirzjYVjwPNI85g71
	ru6llCpTBrDXcqHz2H9wgtved1KsC/4ifQdI5Ipw/m+JpLJVsgFzn5Iv5S9UOD51vfMeULX8kun
	7ktMjYxq+LXvsClX6BnwLKvUOnKrBd5wPBwmCw==
X-Received: by 2002:a05:6402:1466:b0:662:ac7e:aacc with SMTP id
 4fb4d7f45d1cf-663babf0a4dmr1046571a12.20.1773373470679; Thu, 12 Mar 2026
 20:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-9-alistair.francis@wdc.com> <20260302170933.000016ad@huawei.com>
In-Reply-To: <20260302170933.000016ad@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 13:44:04 +1000
X-Gm-Features: AaiRm52V7auffLkdXYKOjGopVCkKllA1QNfNyH63N0AXbxKVq3RcyocdmcxgyMA
Message-ID: <CAKmqyKMznD4RiHe5w2s5RDasG3XMdMwU=L6xDS=70d84FVodUQ@mail.gmail.com>
Subject: Re: [RFC v3 08/27] lib: rspdm: Initial commit of Rust SPDM
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

On Tue, Mar 3, 2026 at 3:09=E2=80=AFAM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 11 Feb 2026 13:29:15 +1000
> alistair23@gmail.com wrote:
>
> > From: Alistair Francis <alistair@alistair23.me>
> >
> > This is the initial commit of the Rust SPDM library. It is based on and
> > compatible with the C SPDM library in the kernel (lib/spdm).
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> The comments that follow are based on my very limited rust knowledge.
> Hence may be garbage.
>
> > ---
> >  MAINTAINERS                     |  12 ++
> >  include/linux/spdm.h            |  39 ++++++
> >  lib/Kconfig                     |  17 +++
> >  lib/Makefile                    |   2 +
> >  lib/rspdm/Makefile              |  10 ++
> >  lib/rspdm/consts.rs             | 117 +++++++++++++++++
> >  lib/rspdm/lib.rs                | 119 +++++++++++++++++
> >  lib/rspdm/state.rs              | 220 ++++++++++++++++++++++++++++++++
> >  lib/rspdm/validator.rs          |  66 ++++++++++
> >  rust/bindings/bindings_helper.h |   2 +
> >  rust/kernel/error.rs            |   3 +
> >  11 files changed, 607 insertions(+)
> >  create mode 100644 include/linux/spdm.h
> >  create mode 100644 lib/rspdm/Makefile
> >  create mode 100644 lib/rspdm/consts.rs
> >  create mode 100644 lib/rspdm/lib.rs
> >  create mode 100644 lib/rspdm/state.rs
> >  create mode 100644 lib/rspdm/validator.rs
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 149deedafe2c..a5c4ec16081c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -23693,6 +23693,18 @@ M:   Security Officers <security@kernel.org>
> >  S:   Supported
> >  F:   Documentation/process/security-bugs.rst
> >
> > +SECURITY PROTOCOL AND DATA MODEL (SPDM)
> > +M:   Jonathan Cameron <jic23@kernel.org>
>
> Evil way to get me to learn rust. Ah well, I guess I can't put it
> off for ever.

It's a great excuse!

>
> > +M:   Lukas Wunner <lukas@wunner.de>
> > +M:   Alistair Francis <alistair@alistair23.me>
> > +L:   linux-coco@lists.linux.dev
> > +L:   linux-cxl@vger.kernel.org
> > +L:   linux-pci@vger.kernel.org
> > +S:   Maintained
> > +T:   git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
> > +F:   include/linux/spdm.h
> > +F:   lib/rspdm/
>
>
> > diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
> > new file mode 100644
> > index 000000000000..40ce60eba2f3
> > --- /dev/null
> > +++ b/lib/rspdm/consts.rs
> > @@ -0,0 +1,117 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Western Digital
> > +
> > +//! Constants used by the library
> > +//!
> > +//! Rust implementation of the DMTF Security Protocol and Data Model (=
SPDM)
> > +//! <https://www.dmtf.org/dsp/DSP0274>
> > +
> > +pub(crate) const SPDM_REQ: u8 =3D 0x80;
> > +pub(crate) const SPDM_ERROR: u8 =3D 0x7f;
> > +
> > +#[expect(dead_code)]
> > +#[derive(Clone, Copy)]
> > +pub(crate) enum SpdmErrorCode {
> > +    InvalidRequest =3D 0x01,
> > +    InvalidSession =3D 0x02,
>
> This is reserved by the time we reach 1.2.1 and disappeared somewhere
> in the middle of 1.1.0 (present) and 1.1.2 (reserved)
> Probably good to leave some breadcrumbs for what spec versions could use
> this error code.  That will reduce confusion for future readers.
> You have this info in the parsing code, but I'd like it here as well.
>
> > +    Busy =3D 0x03,
> > +    UnexpectedRequest =3D 0x04,
> > +    Unspecified =3D 0x05,
> > +    DecryptError =3D 0x06,
> > +    UnsupportedRequest =3D 0x07,
> > +    RequestInFlight =3D 0x08,
> > +    InvalidResponseCode =3D 0x09,
> > +    SessionLimitExceeded =3D 0x0a,
> > +    SessionRequired =3D 0x0b,
> > +    ResetRequired =3D 0x0c,
> > +    ResponseTooLarge =3D 0x0d,
> > +    RequestTooLarge =3D 0x0e,
> > +    LargeResponse =3D 0x0f,
> > +    MessageLost =3D 0x10,
> > +    InvalidPolicy =3D 0x11,
> > +    VersionMismatch =3D 0x41,
> > +    ResponseNotReady =3D 0x42,
> > +    RequestResynch =3D 0x43,
> > +    OperationFailed =3D 0x44,
> > +    NoPendingRequests =3D 0x45,
> > +    VendorDefinedError =3D 0xff,
> > +}
> > +
> > +impl core::fmt::LowerHex for SpdmErrorCode {
> > +    /// A debug print format for the SpdmSessionInfo struct
> > +    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Resu=
lt {
> > +        match self {
> > +            SpdmErrorCode::InvalidRequest =3D> {
> > +                writeln!(f, "0x01")?;
>
> No way to get a string from an enum value in rust?

There is actually, this is unnecessary

> Having to check these against the enum above is a bit tedious.
>
> > +            }
>
> > +        }
> > +        Ok(())
> > +    }
> > +}
> > diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> > new file mode 100644
> > index 000000000000..2bb716140e0a
> > --- /dev/null
> > +++ b/lib/rspdm/lib.rs
> > @@ -0,0 +1,119 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Western Digital
> > +
> > +//! Top level library for SPDM
> > +//!
> > +//! Rust implementation of the DMTF Security Protocol and Data Model (=
SPDM)
> > +//! <https://www.dmtf.org/dsp/DSP0274>
> > +//!
> > +//! Top level library, including C compatible public functions to be c=
alled
> > +//! from other subsytems.
> > +//!
> > +//! This mimics the C SPDM implementation in the kernel
>
> The one that never gets merged if this goes according to plan ;)
>
>
>
> > diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> > new file mode 100644
> > index 000000000000..68861f30e3fa
> > --- /dev/null
> > +++ b/lib/rspdm/state.rs
> > @@ -0,0 +1,220 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Western Digital
> > +
> > +//! The `SpdmState` struct and implementation.
> > +//!
> > +//! Rust implementation of the DMTF Security Protocol and Data Model (=
SPDM)
> > +//! <https://www.dmtf.org/dsp/DSP0274>
> > +
> > +use core::ffi::c_void;
> > +use kernel::prelude::*;
> > +use kernel::{
> > +    bindings,
> > +    error::{code::EINVAL, to_result, Error},
> > +    validate::Untrusted,
> > +};
> > +
> > +use crate::consts::{SpdmErrorCode, SPDM_ERROR, SPDM_REQ};
> > +use crate::validator::{SpdmErrorRsp, SpdmHeader};
> > +
> > +/// The current SPDM session state for a device. Based on the
> > +/// C `struct spdm_state`.
> > +///
> > +/// `dev`: Responder device.  Used for error reporting and passed to @=
transport.
> > +/// `transport`: Transport function to perform one message exchange.
> > +/// `transport_priv`: Transport private data.
> > +/// `transport_sz`: Maximum message size the transport is capable of (=
in bytes).
> > +///  Used as DataTransferSize in GET_CAPABILITIES exchange.
> > +/// `keyring`: Keyring against which to check the first certificate in
> > +///  responder's certificate chain.
>
> Given the discussions, seems this will go away (for now anyway).
>
> > +/// `validate`: Function to validate additional leaf certificate requi=
rements.
> > +///
> > +/// `version`: Maximum common supported version of requester and respo=
nder.
> > +///  Negotiated during GET_VERSION exchange.
> > +#[expect(dead_code)]
> > +pub struct SpdmState {
> > +    pub(crate) dev: *mut bindings::device,
> > +    pub(crate) transport: bindings::spdm_transport,
> > +    pub(crate) transport_priv: *mut c_void,
> > +    pub(crate) transport_sz: u32,
> > +    pub(crate) keyring: *mut bindings::key,
> > +    pub(crate) validate: bindings::spdm_validate,
> > +
> > +    // Negotiated state
> > +    pub(crate) version: u8,
> > +}
> > +
> > +impl SpdmState {
> > +    pub(crate) fn new(
> > +        dev: *mut bindings::device,
> > +        transport: bindings::spdm_transport,
> > +        transport_priv: *mut c_void,
> > +        transport_sz: u32,
> > +        keyring: *mut bindings::key,
> > +        validate: bindings::spdm_validate,
> > +    ) -> Self {
> > +        SpdmState {
> > +            dev,
> > +            transport,
> > +            transport_priv,
> > +            transport_sz,
> > +            keyring,
> > +            validate,
> > +            version: 0x10,
> > +        }
> > +    }
>
> > +
> > +    /// Start a SPDM exchange
> > +    ///
> > +    /// The data in `request_buf` is sent to the device and the respon=
se is
> > +    /// stored in `response_buf`.
> > +    pub(crate) fn spdm_exchange(
> > +        &self,
> > +        request_buf: &mut [u8],
> > +        response_buf: &mut [u8],
> > +    ) -> Result<i32, Error> {
> > +        let header_size =3D core::mem::size_of::<SpdmHeader>();
> > +        let request: &mut SpdmHeader =3D Untrusted::new_mut(request_bu=
f).validate_mut()?;
>
> Why are we treating the request, which doesn't come from the device as un=
trusted?
> Just for convenience on checking we formatted it right at the upper level=
s or is
> the idea that might ultimately be coming from userspace?

Just for convenience, it's just a easy way to convert it to a
`SpdmHeader` and perform some simple sanity checks. Your right it's
not actually untrusted

Alistair

>
> > +        let response: &SpdmHeader =3D Untrusted::new_ref(response_buf)=
.validate()?;
> > +
> > +        let transport_function =3D self.transport.ok_or(EINVAL)?;
> > +        // SAFETY: `transport_function` is provided by the new(), we a=
re
> > +        // calling the function.
> > +        let length =3D unsafe {
> > +            transport_function(
> > +                self.transport_priv,
> > +                self.dev,
> > +                request_buf.as_ptr() as *const c_void,
> > +                request_buf.len(),
> > +                response_buf.as_mut_ptr() as *mut c_void,
> > +                response_buf.len(),
> > +            ) as i32
> > +        };
> > +        to_result(length)?;
> > +
> > +        if (length as usize) < header_size {
> > +            return Ok(length); // Truncated response is handled by cal=
lers
> > +        }
> > +        if response.code =3D=3D SPDM_ERROR {
> > +            if length as usize >=3D core::mem::size_of::<SpdmErrorRsp>=
() {
> > +                // SAFETY: The response buffer will be at least as lar=
ge as
> > +                // `SpdmErrorRsp` so we can cast the buffer to `SpdmEr=
rorRsp` which
> > +                // is a packed struct.
> > +                self.spdm_err(unsafe { &*(response_buf.as_ptr() as *co=
nst SpdmErrorRsp) })?;
> > +            } else {
> > +                return Err(EINVAL);
> > +            }
> > +        }
> > +
> > +        if response.code !=3D request.code & !SPDM_REQ {
> > +            pr_err!(
> > +                "Response code {:#x} does not match request code {:#x}=
\n",
> > +                response.code,
> > +                request.code
> > +            );
> > +            to_result(-(bindings::EPROTO as i32))?;
> > +        }
> > +
> > +        Ok(length)
> > +    }
> > +}
> > diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> > new file mode 100644
> > index 000000000000..a0a3a2f46952
> > --- /dev/null
> > +++ b/lib/rspdm/validator.rs
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Western Digital
> > +
> > +//! Related structs and their Validate implementations.
> > +//!
> > +//! Rust implementation of the DMTF Security Protocol and Data Model (=
SPDM)
> > +//! <https://www.dmtf.org/dsp/DSP0274>
> > +
> > +use crate::consts::SpdmErrorCode;
> > +use core::mem;
> > +use kernel::prelude::*;
> > +use kernel::{
> > +    error::{code::EINVAL, Error},
> > +    validate::{Unvalidated, Validate},
> > +};
> > +
> > +#[repr(C, packed)]
> > +pub(crate) struct SpdmHeader {
> > +    pub(crate) version: u8,
> > +    pub(crate) code: u8, /* RequestResponseCode */
> > +    pub(crate) param1: u8,
> > +    pub(crate) param2: u8,
> > +}
> > +
> > +impl Validate<&Unvalidated<[u8]>> for &SpdmHeader {
> > +    type Err =3D Error;
> > +
> > +    fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self:=
:Err> {
> > +        let raw =3D unvalidated.raw();
> > +        if raw.len() < mem::size_of::<SpdmHeader>() {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        let ptr =3D raw.as_ptr();
> > +        // CAST: `SpdmHeader` only contains integers and has `repr(C)`=
.
> > +        let ptr =3D ptr.cast::<SpdmHeader>();
> > +        // SAFETY: `ptr` came from a reference and the cast above is v=
alid.
> > +        Ok(unsafe { &*ptr })
> > +    }
> > +}
> > +
> > +impl Validate<&mut Unvalidated<[u8]>> for &mut SpdmHeader {
> > +    type Err =3D Error;
> > +
> > +    fn validate(unvalidated: &mut Unvalidated<[u8]>) -> Result<Self, S=
elf::Err> {
> > +        let raw =3D unvalidated.raw_mut();
> > +        if raw.len() < mem::size_of::<SpdmHeader>() {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        let ptr =3D raw.as_mut_ptr();
> > +        // CAST: `SpdmHeader` only contains integers and has `repr(C)`=
.
> > +        let ptr =3D ptr.cast::<SpdmHeader>();
> > +        // SAFETY: `ptr` came from a reference and the cast above is v=
alid.
> > +        Ok(unsafe { &mut *ptr })
> > +    }
> > +}
> > +
> > +#[repr(C, packed)]
> > +pub(crate) struct SpdmErrorRsp {
> > +    pub(crate) version: u8,
> > +    pub(crate) code: u8,
>
> Maybe document here that this will always be SPDM_ERROR 0x7F
>
>
> > +    pub(crate) error_code: SpdmErrorCode,
> > +    pub(crate) error_data: u8,
> > +}
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index 0075c4b62c29..5043eee2a8d6 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -84,7 +84,9 @@
> >  #include <linux/slab.h>
> >  #include <linux/task_work.h>
> >  #include <linux/tracepoint.h>
> > +#include <linux/spdm.h>
>
> Smells like this is alphabetical order. So move it up a bit?
>
> >  #include <linux/usb.h>
> > +#include <linux/uaccess.h>
> >  #include <linux/wait.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/xarray.h>
>
