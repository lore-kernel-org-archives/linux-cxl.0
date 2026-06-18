Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF2259C82
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jun 2026 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781748310; cv=pass; b=BqHKC5mcmAS8HDqeOLZPxhvDGEHJ+2s8BZMm2DZwLihWEa9X+4ZAgMEnaNzHolGwGg7Ib9IjpsJ/LVTGnkvXVbSYiWY/WU5MFgJ210WEscIJqflykiKhDvtOFqV1Ini5UHOVxHU5MztmDhfNKUf6yPRDCPCt0uj+uReSdbJcK7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781748310; c=relaxed/simple;
	bh=Uh7eZP8JDYxXDuPFo9zlO/GeRgtPSOu/j7Z8w6X4Mzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmJrJYHteltosh9LYMfV/piQQvQXoCURez9i/PkC8tIy3Lzz5jl4q/ZQ+ojYqYmcZTZwTOSnEweZnDODfRWzYRTrSPNDUVty/6qs1JhqzG2R4XT1xgrmptyL8QMHR/Y1ZkuUjFlAhWenuQ0MpalOA2wnJF2Xep67BvdwCcssM68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KySmqt2x; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KySmqt2x"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso954282a12.0
        for <linux-cxl@vger.kernel.org>; Wed, 17 Jun 2026 19:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781748307; cv=none;
        d=google.com; s=arc-20240605;
        b=g0dsnUgE1e56ayDmUJaXYTljk/1TkZFwHrOFUw/Ejxj64ZeR8Q3JiSYjECoiS7OVdt
         HmnfzRbfFP3ayofM2X2gn3wc57+g7uBl1mkCPzlFUgeiTiPEkRVun+JflJNxHtvrib7A
         TM79uVPaJ2gnK/FckDTfztrx0bgyJLVVa8cPWJf4gpr5Y7sSB5eRIhKtepMDFUzqhoyA
         9K2eqApAmjnzowStoVc8hb8Y1U8ZGYxhI94GWFQTrnMVEdNk0ezO4nj9MzoYhiRr5PX7
         g/xKaFFsbd2zzTMKiA/tHXQN2ma62bvlFVLjZjzEeIzEvycWTEZn7zTSAC+UomSFeTze
         f/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uh7eZP8JDYxXDuPFo9zlO/GeRgtPSOu/j7Z8w6X4Mzg=;
        fh=emivPJ9qqVQ5ehOE5Ngha+vjUK4utdYT5bcIvLVzLQ0=;
        b=LzLYFp8CXebahBRYzS/J3c1V6Y3nJF+troQwN2SDZgEZuOFJRkLsqO3WY0CaGO7dBA
         HjaXNIWcVneB/IuOza8zHfdfm17/Wvp+4IrLw42DbcbRoSXKJpul8AkUVRMLnFZtNpPu
         VYNaf2HCYstvy0WYwGc0ihSD80snYybliKVQz/5jOrd/q46Pu2JjnFiim3vdf9cio3Ct
         5ewxagu62j5ML+sbWKg7mstS82XYH199kzfiXnmOyAGQEMYYCWsp7Tl22DUkEUrZ3LWz
         7uVtDWkWBvnBF8XWuADauyCwUhOwU0ngTdA+viPG9u92B6i4anEogso27dS3oXJCykuN
         FZpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781748307; x=1782353107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh7eZP8JDYxXDuPFo9zlO/GeRgtPSOu/j7Z8w6X4Mzg=;
        b=KySmqt2xehvM2eUoj4Pp1KPKSt1XxIo+WP3pl27yRzCdpQiEtAQwlrJyjOLwzUoeCs
         rqMHgEFe4AcAFXnsgQ+DNzKB9fLnUNeebpN2WFIKrGWgVnsYm9feRz9qGpLU0ZOXngil
         LWnJSOD686K/qVeJ1ps2gcM5efCQsdRE4iKo4C290llAjD/zxhGD4fKL8doWXmOQOw5h
         n36kOE9n5qmGYbQ6OW032sCU4aprf61X9QNCnCk/wiLuqfznpXUeQpX5gw0vxZuV0Cex
         L7oXOWW2COqKY2wyiv/9uR52RGZeadMz7SxeNupOO6ovf1L4LewwNzavOkFFmxdd+dfo
         9xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781748307; x=1782353107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uh7eZP8JDYxXDuPFo9zlO/GeRgtPSOu/j7Z8w6X4Mzg=;
        b=Dcr5W8pjb94dqAM1lfdfWufAHGnOiZ2mwZlqB4pyKDJ80kD8kfB6zuYBeZc5YSj4PU
         cd4gDfeIA2plXrIY+Hyy0MxSOp9nqtxDpNJbpP4OhEPbqVbH3xZQSxFauT6eVz0iQXO1
         Qx/XXv9wFl6UXASBvGire5z6F4MOGVESZOEjS9+EmQy88DR8Fs3GI0fTED982JaY4AuV
         S7HwpMF9HRbEfHmTjczVqTkn4MS4+UOBN2a6Dtis6myF80jj8GHOWE6aGM+GoDqrCnF4
         le29oK7XYOEX3CIx0C+iXknMVUSqs8N8hV0l+KqhQFDGKqpbZ7uZHnAFi8+PYat6FfNH
         N1jQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UdHqLTIvmpFbXJs0uoMYUm4ENEAU5xXSR5ke3Bn9lob2aWTXWgcGPu3n2DKkxOS4zImZ9VJAqF0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4NXhHiE7B53xMMwDq1LLVdqg8MfTMqHLzBnGQ6Q/7dD94SZqp
	vswXh9xLcdXV2HgQovRJM6yLjkyilunRzf5R4DYCAbX++Gbz9dSY97hXHDgJnm2tqMS76ZQJ8my
	J35gWpznyBFtdvE//6gtdN+WFPfMOXlU=
X-Gm-Gg: AfdE7cmmCkZ0Oef0hxyAgKDs127sUlPmCc31BXLq7c1P7CKb5TDzePnTPO2aloh9sPO
	Z3gflyCto7SGiwVJ4yHymDmSZ2/xQ6IcM7X0J3NVv0Us36l7CGBYc/JROJXS6Rb9z8oXGe2ljYo
	t8+JN11WE+C5eLMy7Ve0X3ec/qQFkWzMnHt6nBIS21ReFJJv+59lNgKtMqEDJ8sy97sJOIfV9Sx
	nFE5dm7/ou7DtV5EvrAF0cNnBMIAclXspw9bESVSBqMynf35K+yPW2z8h7qabBd5DTZtiiWY0EL
	2PsbNQESECl4R0N/uUyMAs/Fbcs=
X-Received: by 2002:a05:6402:528a:b0:689:b30c:421a with SMTP id
 4fb4d7f45d1cf-695ba1b22cbmr1043888a12.0.1781748306691; Wed, 17 Jun 2026
 19:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508031710.514574-1-alistair.francis@wdc.com>
 <20260508031710.514574-9-alistair.francis@wdc.com> <CAKmqyKO1L+sCHWMDJ-tH1WVc+=oMVidnVSMttr6ft0-ewSjMVA@mail.gmail.com>
In-Reply-To: <CAKmqyKO1L+sCHWMDJ-tH1WVc+=oMVidnVSMttr6ft0-ewSjMVA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 18 Jun 2026 12:04:40 +1000
X-Gm-Features: AVVi8CcEcPCPlTkWNTLD3VXO0gTKy5uNbpMM9S8kJ68bCzeLwWNcsIIDADOjRnk
Message-ID: <CAKmqyKPc4hMYg5ARw3RH8KJwWfk-1CMT5zqnVrbhtdT1X3Z0aA@mail.gmail.com>
Subject: Re: [PATCH 08/18] PCI/TSM: Support connecting to PCIe CMA devices
To: alistair@alistair23.me, linux-kernel@vger.kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-cxl@vger.kernel.org, djbw@kernel.org, 
	linux-pci@vger.kernel.org, jic23@kernel.org
Cc: alex.gaynor@gmail.com, wilfred.mallawa@wdc.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, tmgross@umich.edu, 
	ojeda@kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 3:56=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Fri, May 8, 2026 at 1:18=E2=80=AFPM <alistair23@gmail.com> wrote:
> >
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > In the next patch we are going to add a PCIe CMA TSM driver, as such we
> > need to ensure that is_pci_tsm_pf0() will allow us to connect to CMA
> > capable devices. These devices don't necessarily has DEVCAP_TEE or IDE
> > support.
> >
> > As such for Root Complex Integrated Endpoint (PCI_EXP_TYPE_RC_END) we
> > also check for the CMA DOE feature.
>
> @Dan Williams this is the patch I really need your thoughts on.
>
> The current upstream pci_tsm code only works if IDE or TDISP is
> supported, which isn't true for CMA support.
>
> This patch works around that, but the more I think about it the
> hackier it is. I have a local change that reverts this and
> updates`tsm.c` to work with a DSM (`->dsm_dev` is NULL), but that
> doesn't feel right either. Do you have a better idea or how to enable
> a CMA TSM driver?

Gentle ping on this. Any thoughts here?

Alistair

>
> Alistair
