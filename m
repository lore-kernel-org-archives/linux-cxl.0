Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CB71FBEA6
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403236; cv=pass; b=aoiCaKTGn6Cf68nuzXDYpRHqxNAHUaINr11aaXfqyDOOQdEWsxOuCXFhGSBPyFnbCUo67loxRpy8vC2tAHGrZpNJGzTfHzHvipwnzLkFHNo96g6cRZ78buJSAh1PdHteVvsFLz/HPcE6HAm3o30ZchD/F/F1N6RcA7ksxknoGLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403236; c=relaxed/simple;
	bh=NjLFoPnv6IxbEHzHsHXAXNpdL+P4lW5tZwXEzwHN8PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gl46AgRjpgd7CiJjtp2PaeGxbUycHjxfXuXN7hfCXeEBjhd3Rq8Pbxr2TR8LXnCL4DjjcXSgrNlmarczKsUv8x7f4Uby6H8UAJZHycovB+DCeMKv3S65rXdk98ZEJqlJnvkxkdAoCURt8I9krj1bDYRYtE7IBkr1aeZcjFhb6Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJilzvtE; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJilzvtE"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba25fd27571so46813966b.0
        for <linux-cxl@vger.kernel.org>; Thu, 16 Apr 2026 22:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776403233; cv=none;
        d=google.com; s=arc-20240605;
        b=ano0V1+TCX5SDyXky9HAU8T2Pbz36EbDIcsduomy32rk+VT9QLi5PR7y38oxkMvRuc
         HwNxIrmqKiYtxfG12Vs4ln3VmVMUB6/nNPlMDl1/cztWRNY/+E67zU1pfys1+rNFplKU
         pkUa/6QFigFoHJmqMtZAf/iwbveobza4khhv9ek8fdMxqixFJ12OsbP0mhCxycxUBnlY
         CzPpmi1sJWnajSlBBtQf+58nXeFzIjymc8aIHNZp0gIpu1OrfkBApvBoTB0Ck4Hobb7r
         6dJ5++6PSYFaCu7GmsXQHKp7YXIs0nqzhAUtV5hM2+DCicRmUI/hR8Z44Km0YhcadPL2
         cJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5dDFG+okIhe8PYZxq7+NDc2a4MEwFZQZfmQFdzqFGjE=;
        fh=N0ndgwoTUtAc6IeM08RCCzpJM7eFeVpPJjFzpdP6wqk=;
        b=hYcPCaIU9sJWnTBBy6wzujOLhVsVjphNLSMaByCWO5V9h22z4Wv7OMhuGy7MwaEaoL
         /Zog3bPWXH1PmTB9MSnXj8GdqEq9Gyw+YPeME5UJ5bbHuwMMfyt+/tXjZFFUN0czdNEd
         zgPIfSdPJ4Foc9ejncwn0nCCf1IFGVV1a0f4SzMamTQa71G06KJvpTrgfe0/Ib9XqwdH
         BzYoZp09In52PNQoKDmdvGFPp4X/YR2kVRTjVC1cj9G0fCorepg3gLM5s4+LJztcBszE
         6Cdeh0cP3GGnx93/sXtvxbMaD/rOtKdyuJTMa1EtVKdP4xPOFoWg5fpffvedPqF5kGip
         i93g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776403233; x=1777008033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dDFG+okIhe8PYZxq7+NDc2a4MEwFZQZfmQFdzqFGjE=;
        b=JJilzvtEH42Cgbggtv8GFG4JwYK6BzgtJWNV1eTOtEtJagXiT+l5ZXIOodGLTBPMN8
         Rnx3eMCBIIyE/XkyUZw+YR4GnTdYGrt1X86QVwWxI/2j2lxQoPOfiQg6dGR9/1l+BtXq
         xyXyeZ/zEUR5UMYNyMQ+/Q3QqzLzD+DWYkjkgDz849BBQFN9ZBzcmbpMgr6SQ8w9HAH5
         rciwvnNu1P6HjQXtwtSXSR2un7oPbXjTQaooiqQvPlEtUtmWuY1P2aip/9kC0+ynRV7J
         wKKKdYovtcK/paxhypL8NCqkAi/YFGDxTHvaOwkmFLJ5flunZ/czLdZ49RpNb37vdZPa
         6SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776403233; x=1777008033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dDFG+okIhe8PYZxq7+NDc2a4MEwFZQZfmQFdzqFGjE=;
        b=rnrW/ytd7Amy14xsP6aAZ5u7evwlPUI+HZqMME9AiGP2+774LGkTMP22AwLUMBKImS
         +w7R8L3G12oep7g2n/gbxnxqq31g6DYgVtljkgcxCh8OdjBbjM11uDTRcTgISlt3fDGi
         EVXfBfyInZ81XUsDQG8Ck0YiVmpo1+sxSTLJyjmIcymuka4tvGY32bBbmZcnqK4peCBb
         H20iH8GSaa3xWhJSfOPf6gLtij4GTiGfJYk4xKeZdjg6wC312Mkls7V0qTSuhCdTV8BA
         9QC3YexMRb3j12sqQ85zK/xTUD3k02P72fh1gGjUTuPOsNvwT33e5yTY8pW4IJnH1aGq
         XY4A==
X-Forwarded-Encrypted: i=1; AFNElJ9WcVm0sSm5KD+GdGIjqRnJvcRv3E0fYXlpFVGXKK6ucdt0nYyLKnEXGsgLxrsmcsjxqWvqDbu6848=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4bKYTBwd0XQYnS7xNizAXZnTbFxxkyl8ntH9bA2YRaWa2jDQL
	oBWCNiuwUAKOtbOOgJ6bgtLe+iqhOwapk4wQrfAqNAsEwTKpVHQh7tZHO8VBUhu9TGEDtHuGj1g
	JJF8KDpded3YJsKWjxj+RuA/Ml1HOt6w=
X-Gm-Gg: AeBDiesiwSrbBDvD47J39ykV/RXSOH2jRVrBEUXwpk9KRD543lmvkwnlYXklWWmfGMY
	V2nJAFa88bhn/mOLMi48UXEC8sGFh2ztD4Zdy6sCMvqR+bJ0gnnK5CjKFz5xbNTKwvImGUOtOW+
	snG5LZLrDJf+Hsa7DK+++hx6b6gimwkPB50Rvm9H34Fdj6lxWGbz+4KYo6TKolJ4mwM7FMQRhlS
	glabwDLK4G2VZGtXXSi7n861fRPJwWafJyzIHTJ4dMMiNrVi0YXB7Isdfu2rl/ew6sCO2AyMgC5
	0IHDBxsU/kGUl9xtYh8LS/7/l9SER7mFqiyYVaviKadKMPcu
X-Received: by 2002:a17:906:5182:20b0:b9d:1adb:fcbf with SMTP id
 a640c23a62f3a-ba41afe61a1mr47564466b.33.1776403233210; Thu, 16 Apr 2026
 22:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch> <CAKmqyKPyR165rACXRMJXgyUOp6OUdQqSsym-gfYVFnKLZ4ednQ@mail.gmail.com>
 <69e19c80b892b_fe0831000@djbw-dev.notmuch> <aeG4UnyYd1FKdt1D@wunner.de>
In-Reply-To: <aeG4UnyYd1FKdt1D@wunner.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2026 15:20:06 +1000
X-Gm-Features: AQROBzBVB0P_lXZKhnqIa7d0_vKgMy0kgTihznkkobGfKMkBxqIBrZfKSba9-FM
Message-ID: <CAKmqyKN3nuA_uH+1o9XPrFoi7TnBY_R92SiP1srhXFdhnngd3A@mail.gmail.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
To: Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <djbw@kernel.org>, bhelgaas@google.com, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 2:34=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Thu, Apr 16, 2026 at 07:35:44PM -0700, Dan Williams wrote:
> > Later in the thread I proposed an alternative that instead of supportin=
g
> > 2 flavors of uapi through "authenticated", instead implement CMA as
> > another TSM driver [1].
> >
> > [1]: http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmu=
ch
>
> Please keep in mind though that CMA is just the PCIe adaption of SPDM,
> SPDM is not only needed for PCIe but also SCSI, ATA and possibly others
> and so implementing CMA as a TSM driver must not preclude use of SPDM
> in other subsystems.

That should be fine as the current SPDM implementation is
self-contained, but thanks for raising that.

Just to make sure I'm not going in the wrong direction, the idea would
be to build on

https://lore.kernel.org/all/20260303000207.1836586-9-dan.j.williams@intel.c=
om/

and add something like this?

```
static const struct pci_tsm_ops pci_cma_tsm_ops =3D {
    .link_ops =3D {
        .probe        =3D pci_cma_tsm_probe,
        .remove        =3D pci_cma_tsm_remove,
        .connect    =3D pci_cma_tsm_connect,
        .disconnect    =3D pci_cma_tsm_disconnect,
    },
    .refresh_evidence    =3D pci_cma_tsm_refresh,
};
```

The docs for `struct pci_tsm_ops` seem pretty TSM specific, so I just
wanted to double check before going ahead.

That means all of the netlink stuff in this series can be dropped and
we just use the TSM netlink (which might need some adjustments then,
I'll have to double check)

Alistair

>
> Thanks,
>
> Lukas
