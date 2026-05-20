Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711FD2C11CB
	for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256617; cv=pass; b=Txce3+/vDTKAOudKKyaKlVOU7u8t7MHxDVcBSnkpz7Por6NWwi6y1yC8JYyRaQKxC7Nzpc2vt3QhDYTcN7O3eVCuGKN36KTDiA+XWcs0k6bpQcIR32Dj9v3tRBgbOM5ov+0GmEkhfX7hBY95URO8ICTaNaECY9nW0vATR9URgAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256617; c=relaxed/simple;
	bh=AVRlE0G99BC+L7y0nye1ZxQzkDfQkyMJSbR7r+WemrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKhGIU87C282eyQ6+AQ0jha9hApwDz6J2HxtnufzUp9v4NpdWWNoZZ0ogLVZamBkWSlhpokc9iemBsuOQ1x2zPvmoOfWZIIIvlFXQGiEa7clzK6mYsyZazD7NDvhZkIphmyc7y5nZDIT6pJgJUXbCl3tgNz+9hyEnIwhe2ZCIqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC3cpC6b; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC3cpC6b"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd373f83042so926536966b.1
        for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 22:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779256614; cv=none;
        d=google.com; s=arc-20240605;
        b=judTbRs1qHOEw7BzBRSTxSWeCsIuGQDPvfuZmotwWdBxkABsFtl2S3nIWlx9criqWZ
         DHYHpK5P1HFMy1MXcDQS/Z62GDGVotnl5z57IqlI9RTMh3KL1nwZR6q1miHqDENmAe0h
         H1GFD720e0hdVLFLt6qlswJpa8zZGHDskhSbYEMqbijnHvuPw71xjJPDBHlyHA+/nSXM
         d6ajJactEP+TOIhLtXkJl+q3halHchfk/hWqUe333y97uXgE41fIExN4pbzvR7yLKo0f
         yEM8aQRP6vRfi/ftcqgafK/r0CmdLS+tPvg/yaT77z3Z3t9ZGH2K9CLbOV5lVGlssIxZ
         sUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=etsMGOIVq2kJS1rwImtVQ8IDqskkHwe2NYV85OoKq3M=;
        fh=jCB5upi5Zpar7AsTnqDGKBvyo0PgHxguofCUbt3t190=;
        b=bYQD1BLBvrmabYeChY9Kg4T34hBS6bxIIz82e4hWsJ1SfxWigRbLfsNXvv6oKCj5Xc
         2bWUo1gWkMtXYUirzrE9rjATG9IXtct7WGBvNXnLKGUDFceJqBjTpsJ0qyDIfIO4dTco
         ULCPpFp3T7eSocjMImp+bQIvwqJxdT56elSq47lzEghBUGk8ifvSfnuqWl1TrQ5702yC
         WLOV0B3oxIMtd0AyWsdBC2N+8r22W3BFfiuRssQOIFlNRvCh0qAZQvWzHEuYwiys6aAO
         zt0QrrlTQxqSa4aSEYlPyu7bG8DYeP3qki9sbD07+o7iNb7N5Vm1L0hXnjP2d5v1uHx2
         eh5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779256614; x=1779861414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etsMGOIVq2kJS1rwImtVQ8IDqskkHwe2NYV85OoKq3M=;
        b=PC3cpC6bLm5EWnctfQW1snECzgyoJjl5STmtJ8D6JiCz/UzJRAUALv0ho6Wu6HKRBw
         VZNuXMT4gZArwE+Q61ckzLgIrlyumrXcE5H9J0HyG7cZKCwn9L5L8S6kKz3ileYERbsc
         2euVZuYp9h6SAn3J19A6G0YrfQjAO8Est0EZRKVXNEv+B+Qk9iKH0+WEK0t9fZ4GtnAZ
         li0F2d2/nXPNQpXRLma/8ERnNuWm8cgT40vFNftYf3JEjSxH3Wzw/zeaat6e5xug83Hj
         KwdlhN7yvB4tvaSmpdvcBdprrhUrUZEYOpV0v3ozt8FeQw8EX9Rjbc91+uvilotbdBHX
         JfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779256614; x=1779861414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etsMGOIVq2kJS1rwImtVQ8IDqskkHwe2NYV85OoKq3M=;
        b=JEM1xBH4z6KL/K6Vr45l7BXMIUe0chqrAjsnfwYwDyYA/ECQ/ruIiZmAuP0Bcy5n3A
         leafULcGfbFjAev4+m3bg7nhzGRPMdE2KZVDUhEBXx6Ix5s12/iNNPAqtPgEdAZDPbrY
         +VMZB8X3zCl+YrfZB6z+EKDbFl4Y8mWFXDjpJ9Q/qTyql2c4Dzbfh4nHWNfSkMWqH521
         HkaAPxEltKvM1nfk4k2vqtyHOrLg7wV/df9Oz80zR5iA8siRky7QV/kZgSaEBRImbAZJ
         7e8MuCnRGHe4BEAMv3z26ns5xMiprj89ult76cOIGNWkFL/o+kfKvGWD2ZkA0XwbySiu
         XKpA==
X-Forwarded-Encrypted: i=1; AFNElJ/FgTAfky07FFJGEX4+GdfyXyyeq12n2iyetrC9yC2ZIu95VIGHR6bnjxcLbR2Ck2EcCK9Zxzj3hJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgeCV/uT+R7M5/S2gLmdDp06v4JbPvaeMzBiaoN+7yBuqa9tL
	NqngLsrLm5WdPl5OlfgKubGMBgRTQ3et+3R0WdphA0Glo0nMqmHOvulYmm83uhTdsEifMwHHDs7
	QhwUKmaigepLeNyucWHttBiWrmqptfw8=
X-Gm-Gg: Acq92OECIbLj2sgWQkeYS/GidxlKi+H1RYhgYguiz/JcWoF4nr0Oc1Ymr8z6RBPiyp7
	Gm1LSyxZO8MvVbqJNJfF0tlLM95rTDc0GIvzXZKkI6fgSbLgn9VqENrwgSUG9/l1MLu9ndisUit
	cZCRFCpwp6RyZ2JUjVJYIMLyKNpCVAisIQK8W1/L18uhJw0XsoQcBMGSSMxNhV2yD7Daf8Aq4J/
	nnkO/k5fu4vTvf8+PkFtk2AnnohO1PzIizr+SFA3NP6b2IPQhbF7/vZEY55fexpb35F8X+dZOUv
	I2KL+lf4kdX0psGFaoBvsfKaWKLvgnEoa3P1Fw==
X-Received: by 2002:a17:907:c206:b0:bd8:f7f1:d31e with SMTP id
 a640c23a62f3a-bd8f7f1d8acmr470179866b.49.1779256613629; Tue, 19 May 2026
 22:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508031710.514574-1-alistair.francis@wdc.com> <20260508031710.514574-9-alistair.francis@wdc.com>
In-Reply-To: <20260508031710.514574-9-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 20 May 2026 15:56:27 +1000
X-Gm-Features: AVHnY4KniR3r_N3kxaUwuJ2NdVV3JVmbSqiPSHds9-OenhdEMA5je4KUw5NkTj4
Message-ID: <CAKmqyKO1L+sCHWMDJ-tH1WVc+=oMVidnVSMttr6ft0-ewSjMVA@mail.gmail.com>
Subject: Re: [PATCH 08/18] PCI/TSM: Support connecting to PCIe CMA devices
To: alistair@alistair23.me, linux-kernel@vger.kernel.org, lukas@wunner.de, 
	Jonathan.Cameron@huawei.com, bhelgaas@google.com, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-cxl@vger.kernel.org, djbw@kernel.org, linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com, wilfred.mallawa@wdc.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, tmgross@umich.edu, 
	ojeda@kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 1:18=E2=80=AFPM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> In the next patch we are going to add a PCIe CMA TSM driver, as such we
> need to ensure that is_pci_tsm_pf0() will allow us to connect to CMA
> capable devices. These devices don't necessarily has DEVCAP_TEE or IDE
> support.
>
> As such for Root Complex Integrated Endpoint (PCI_EXP_TYPE_RC_END) we
> also check for the CMA DOE feature.

@Dan Williams this is the patch I really need your thoughts on.

The current upstream pci_tsm code only works if IDE or TDISP is
supported, which isn't true for CMA support.

This patch works around that, but the more I think about it the
hackier it is. I have a local change that reverts this and
updates`tsm.c` to work with a DSM (`->dsm_dev` is NULL), but that
doesn't feel right either. Do you have a better idea or how to enable
a CMA TSM driver?

Alistair

>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/linux/pci-tsm.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index a6435aba03f9..5059954e4853 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -3,6 +3,7 @@
>  #define __PCI_TSM_H
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <linux/sockptr.h>
>
>  struct pci_tsm;
> @@ -129,6 +130,8 @@ struct pci_tsm_pf0 {
>  /* physical function0 and capable of 'connect' */
>  static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
>  {
> +       struct pci_doe_mb *doe;
> +
>         if (!pdev)
>                 return false;
>
> @@ -146,9 +149,15 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pd=
ev)
>          * switch.
>          */
>         switch (pci_pcie_type(pdev)) {
> +       case PCI_EXP_TYPE_RC_END:
> +               doe =3D pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +                                          PCI_DOE_FEATURE_CMA);
> +
> +               if (doe)
> +                       break;
> +               fallthrough;
>         case PCI_EXP_TYPE_ENDPOINT:
>         case PCI_EXP_TYPE_UPSTREAM:
> -       case PCI_EXP_TYPE_RC_END:
>                 if (pdev->ide_cap || (pdev->devcap & PCI_EXP_DEVCAP_TEE))
>                         break;
>                 fallthrough;
> --
> 2.52.0
>
