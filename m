Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B94313267
	for <linux-cxl@vger.kernel.org>; Thu, 15 Oct 2026 04:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037862; cv=pass; b=SdQz6QQs2VbHV8GgARAeQK6ewA76+D/n2Zn3pyxJwVb+YINbX+rZ2jRueAmyCvCL5YzvjXVy/xzNO58j4Vu2Ptt8Fp2CDCxdifk80sBtNZmP2OJ7Ici+1/yNyp/NkiqqjqPvKC5MhHyuHaY/rO4IALm6NBt/Xe/h/HnsljNqqIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037862; c=relaxed/simple;
	bh=l5wBNlemWX0p2srbr2KMc8Dqy6ZbOGjvLXeG4h1En8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KP3AtUCZ7kTeWgcADnvy4hHfaSuWoJ9GbzQ9VCp0qYHGX6fe+S+eG1lDKAsVCmO1n5WlyovxSjOI6e3Cjqb4NIb8wInhK8DfnCVownk743RP0/Mz7tAod5arMKLpUFU9OcSLk9LKEFB5m4aurOhkBFbIkn2zyMbs+SVbCK45dQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuSP2V8L; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuSP2V8L"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6af9a90e4bbso5158305a12.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 21:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792037859; cv=none;
        d=google.com; s=arc-20260327;
        b=QPor2T6uHdI4YxrxeSuCnqKyQv27PDuOGqfbbUBibCFl+COA9xSXt8IVXJf3tRxYSH
         emONVoEj9Yc46S/XPiqMISLpp0G566ubT2SmWR2xQvljCiphpQHK6Ia5KKS+T45PtCMc
         9iUeEvkQ3nSXPdCXOHRBu2qVDl3wFwpZSagovMETYz5aZHMXvhFu8IwbMz6tDKwUwS5Z
         SDYC2DvGl5locdcnPKforeCTEIaI8Uo3PZi12fRrxz5P/CYiVsvfPuSXWqr/sinTSony
         1Uwpk42CFJ2Nl4nZbJl2Q/HN6vmJeHr1grfvGW8dVpD5x/W3Mg5QFLGjofaxAdmNMI8b
         vOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Mif+7jW3EO1r6NAyd48pdX/YR6ScEx4Ic6vaTYMoxc=;
        fh=T1mflmEfL3tedYcPtNwZIervKvah3b1AIt4sn+2hFis=;
        b=HZBS1ErHAedJGeJv9vrkVmyPLgoYIDjTCjBIteeaCn/iDPnzXxdLL0+kWxbzwF+Jdh
         /BlvhKeQd5o+75rwGJ3Nzc4EljLivhZaZv479HXaBEO5iTQV0yaRB6M5fYnlFgEWIoa8
         1uqaT3zdv9hDdqxyt+zyA9wXI42DrdCNYMo++Mw+I7w+TmnXEHJcu3P37i7l4GiCc7dO
         dp2MHHrWQJ2pf9ioHETzkS975oCooTMyxQmF8BrB+UpcKS+IIxiHemrMqraP8fhS8mVq
         4tJWUivYYQiZWan6CigCLyi8HGW3pTxoOnTnfKVHsPaUv1wSZUIQSse7f6zcQymNrh1N
         7/HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792037859; x=1792642659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Mif+7jW3EO1r6NAyd48pdX/YR6ScEx4Ic6vaTYMoxc=;
        b=FuSP2V8LUPiltHl9fyH5JNOgbMQ1RghzkgASnrgj5aSLy/AX3ATqblSIaOwzICvhOS
         XH6b0fCgEdrj3yhgCkHvrRNgT2S3T7IkGF6okBE2xgeRdVk4C+OoWdHiBwVbncNQBbdg
         KNrplc1KMHINi9/RCGK+h5QEEMeboFm+nuhndYO3+4pi2koLMZRZqwG+aXUI2wbxyBkX
         k33o5cmKQKQpnRA4DMVOmt+xzlg9WcvmuCaNNisd/pgIrLHltDKYpmRmLPo6vAZ+yPjn
         nEYKbxd5ktnd4VyM4dTQ4OaPArQQau7JLLGqJX5psKMIPzhCGT8POKmJ8r8Q4EQ2bZZq
         6DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792037859; x=1792642659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Mif+7jW3EO1r6NAyd48pdX/YR6ScEx4Ic6vaTYMoxc=;
        b=yYUV07xPgjM78zwdnep3Czix5GBSvlWuW9PmBr1gxLq+aXtfwU/IuXMbgjk4F4kC8X
         92AWyuvoeFoi0Iw8LLOQceYY3rL0R802LlXYA5FmSK7qrK7z+M29lzltLvOUyh6j0J0g
         IuBhD44Y36YkGRvICsPGy82GOo8LnLiZwopxxiMmBDGdKXI4lLYc4Lgc2U4PdRBrGrVB
         Ahf6pKudMkFgjfh18LB8CFT+3VcgXO1fHvvJj8GLEyrgNSO5RWTyRH7fu703zigc771f
         TapnFz1FOOxAUgKPlU8XNfF8sKHyL9ynD931i03ECPmJ1wxTDVb0j7k7oiEqOiqVPzhw
         szGg==
X-Forwarded-Encrypted: i=1; AKwUvBwIKUmtc7yTCt81cjfSXOb0i9UL/Uw2JNGXwAjJ+W978FfppV6n1GHR+v6o/bbJWXEmrlU5VRf58Lw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIm9BFGB3pS6jqwgAxapK9Jm512W0fpcOf3Qn0Mv4rxFQiSN+RH
	rMzYieBv+72pNjyTQaVAnm9ATfiJjSQxMcmW35Mplo9Rqg/SPQl2wxPO82PGc2FHtRuDSWEJtns
	jHmBdSRGXOPZegoch4IBINh4aF2e2Uz4=
X-Gm-Gg: AYBFou3vXqnxG/Ya3TCFAK0yXiswM9p0RpKmvbVTB88igw89i+DmT3+CGTHo4mApH6J
	tcfwjBEYFLk2wtlXnOmx0bvjEfdI0R/rRuN2e+XoT9lY6TcA0v5k/oPMzhAM2ROyiU8FF3DkMjh
	n//rB0jOXdosdJ1U5ACvW38CWVCzYLcGHszgqHYf7bwwbDcgJANcsuUlznrYC61/+FOv4n+i5wb
	bccn8tjZnAbN3XBEfoXZE6qGBLkC1Xwsf5kgc8nwQm2U39HHhcu9fWnxeeUcsS47Tas1+ngubtn
	9tG00hzWACuDBHhdeRY3zFPmfyu+uGeEuN/c8PIjM3O3SZHFvzU7+AuirfP7HS4+4ttNUwZs5tz
	MNQ/dvGIWdAMs3fD8dUmP
X-Received: by 2002:a05:6402:4028:b0:6b1:c2ff:89f5 with SMTP id
 4fb4d7f45d1cf-6b1c2ffc1aemr8407700a12.42.1792037859176; Wed, 14 Oct 2026
 21:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928011123.450800-1-alistair.francis@wdc.com> <DM4NSAYZG3EW.27L8GX0Q9CV0P@nvidia.com>
In-Reply-To: <DM4NSAYZG3EW.27L8GX0Q9CV0P@nvidia.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Oct 2026 14:17:11 +1000
X-Gm-Features: AclHuK92TTyKf2sa6xlCV_vbhTCWcDi-jWO21qAlHEyvl88OFTnb9FdoPdKhY64
Message-ID: <CAKmqyKMZw5MJ=NMvNOP4=_FkV8QSKN1+FRz1zgCdfjtdZY+N2w@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] lib: Rust implementation of SPDM
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: lukas@wunner.de, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, bhelgaas@google.com, 
	alistair@alistair23.me, djbw@kernel.org, linux-pci@vger.kernel.org, 
	wilfred.mallawa@wdc.com, a.hindborg@kernel.org, gregkh@linuxfoundation.org, 
	alex.gaynor@gmail.com, aliceryhl@google.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, tmgross@umich.edu, 
	gary@garyguo.net, ojeda@kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:16=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Hi Alistair,
>
> On Mon Sep 28, 2026 at 10:11 AM JST, alistair23 wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Security Protocols and Data Models (SPDM) [1] is used for authenticatio=
n,
> > attestation and key exchange. SPDM is generally used over a range of
> > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> >
> > From the kernels perspective SPDM is used to authenticate and attest de=
vices.
> > In this threat model a device is considered untrusted until it can be v=
erified
> > by the kernel and userspace using SPDM. As such SPDM data is untrusted =
data
> > that can be mallicious.
> >
> > The SPDM specification is also complex, with the 1.2.1 spec being almos=
t 200
> > pages and the 1.3.0 spec being almost 250 pages long.
> >
> > As such we have the kernel parsing untrusted responses from a complex
> > specification, which sounds like a possible exploit vector. This is the=
 type
> > of place where Rust excels!
> >
> > This series implements a SPDM requester in Rust.
>
> A few high-level comments/questions about this series:

Thanks for the review!

>
> - Have you tried building it with `CLIPPY=3D1` as per the checklist [1]? =
I
>   am getting dozen of Clippy warnings about unused imports, unused
>   constants, missing safety comments, and style issues. Series are
>   expected to be Clippy-clean when submitted.

I have been, but apparently running

```
CLIPPY=3D1 LLVM=3D1 make  -j32
```
doesn't trigger clippy while

```
LLVM=3D1 make CLIPPY=3D1 -j32
```

does. I have fixed the clippy issues

> - Most of the C parts have received more attention than the Rust ones so
>   far, if they are meaningful on their own can they be merged separately
>   so this series can focus on the Rust bits and the C FFI?

Not really unfortunately. A few could be pulled out and merged today,
but there isn't much movement there

> - I see many unsafe calls to C crypto functions in e.g. patch 17, these
>   will need to have their own Rust wrapper so they can be called safely.

Yeah, the crypto calls all use unsafe as there aren't bindings written.

This came up at Kangrejos and I thought the takeaway that this was ok
as a starting point. My next step is to work on PQC and crypto
bindings, but I was hoping to split it out of this series, as it's
already long and touching a few subsystems.

>
> I am not familiar with SPDM yet so I cannot comment on the
> protocol-specific parts, but I'll try to perform a review on the Rust
> bits. For this revision it won't be exhaustive as there are a few
> critical things to fix before considering the rest.

Thanks. I have fixed up your comments and have a few fixes I have
found. I'll get a v5 out soon

Alistair

>
> [1] https://rust-for-linux.com/contributing#submit-checklist-addendum
