Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AC2FE2B
	for <linux-cxl@vger.kernel.org>; Thu, 19 Oct 2023 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrKw0RR8"
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C70131
	for <linux-cxl@vger.kernel.org>; Thu, 19 Oct 2023 10:08:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c50906f941so99352131fa.2
        for <linux-cxl@vger.kernel.org>; Thu, 19 Oct 2023 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697735317; x=1698340117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5fU3atj84aVIxZ2hD5gUSw3xD4ONtl5C2S0UZC3mws=;
        b=TrKw0RR8coIwYSVNUoviG+VqBffciiBhOHxXXorK1iR5jwQrZ+IHa0lUOnI33XxdcX
         blzt5r4b1mp5SFzElRdzwxcfhE1e2c840UkQpZuuU/BwqTVEB2EmObLEnH8cAYmdN7kC
         Bc9yfAgooyCX469l639Y6PB3AUdJvGBDqy2CXbPeLm47iwW16r5K3ZETCYjIMJKh8A2k
         lI0n8MKcawHaazdfyYjon/WKSGmfoCNZCmbQ6LrRCIscTYYaDEBQrXTgOZsyp8RNsILT
         iQPnUTw8168E2jnzVrScfGCQOwe8tbCZ0MNzxeZp2d/C3B20MfLZqinHPBLk+2Z5C6VK
         EtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697735317; x=1698340117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5fU3atj84aVIxZ2hD5gUSw3xD4ONtl5C2S0UZC3mws=;
        b=CSQ1et38+RrBtzgvc+9QytojmePj4TkwgYNTN7RB/FcFd/9vhhgoo3Esxx3RR6y1tz
         fqwOQ58FYL4jMBWcHh8pUiSMAOhd5v6g+YOYdJM1xiyY11MVM1QiMu04v62DxVGVB9Ag
         pfQhX61D/5GhSvuWK/WWeSxbLtOVr2XnmvcDpNmhuv5Gnnj71J2Expxn4fAARPcwOHgP
         U5RQgqQ1casOr/uHIBuyTyClhX1Fh8VW+ThHSMe11NOIcxZgtcMvvd15ZiEMC97YZB0a
         OKESKOGKiRxmOKid9+sq0tgfxv7agLe6AFU8/ohcCO8YAjR24gMX9E7wihKiyv99Zs+x
         TgTA==
X-Gm-Message-State: AOJu0Yxvb5DuwroCyx5iLILlwLNc+8kPvc/LxU9MhHiIR4BlYRVBu3HH
	+MhdjZP1AbxpEUOfYzdO27JYDGYIyh6yH3Ws6L4=
X-Google-Smtp-Source: AGHT+IFJAUXNspXomBcG4xIdq/z793aCzdvQsFBR+boEneZXjgD0lRVUBguPB+JyJioqtwMWNL4el7fyUSB6c97x9zA=
X-Received: by 2002:a2e:9241:0:b0:2c5:ffa:375d with SMTP id
 v1-20020a2e9241000000b002c50ffa375dmr1906137ljg.11.1697735317144; Thu, 19 Oct
 2023 10:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
 <20230810173322.0000543c@Huawei.com> <CAEvOrRyvaFBzhzP7kxWeCpYY-u5wjwAo6076FGhN_k-+NadUDA@mail.gmail.com>
 <CAEvOrRzPNwNFrg4Brw7axzgxv6WFeYr0rnsDGmSSNpn9hca-3Q@mail.gmail.com>
 <20230811145223.000040de@Huawei.com> <CAEvOrRzE76U2g_8=V3F-4fqwosRz3n9kO+40E_iG74EcbQBxtw@mail.gmail.com>
 <20230823180323.000052d5@Huawei.com> <CAEvOrRyquLL6-d=vOyB9NNOPVE370qjV0zu8XBsTJmpOBx2UNw@mail.gmail.com>
 <ZPHyoJsZDnzpU7C4@memverge.com> <CAEvOrRw2e3cn=2fNXO8_iX0kg09an-OSx1fnjx7ciGGhZo9f9A@mail.gmail.com>
 <CAEvOrRy9qoydCqxq7xv1QNM+z+YQZyQORtqdDU2VcVKP42CJhA@mail.gmail.com>
 <SJ0PR17MB5512449C5FFD76AD50B3D3AF83E4A@SJ0PR17MB5512.namprd17.prod.outlook.com>
 <CAEvOrRwOWT5HuoUsjkUyt6HpXQhWVR2Hv6cxJPP+4+0xNQpM8g@mail.gmail.com> <CAEvOrRzrAu-2o9xZC+YBG_7R9hLSm_kZFuUZ98tA23NjFyAupw@mail.gmail.com>
In-Reply-To: <CAEvOrRzrAu-2o9xZC+YBG_7R9hLSm_kZFuUZ98tA23NjFyAupw@mail.gmail.com>
From: Ravi Kanth <mvrravikanth@gmail.com>
Date: Thu, 19 Oct 2023 22:38:26 +0530
Message-ID: <CAEvOrRyMqBcv+6RseVS0x_6a3aJU82tjLJagmqCrgRebx5JaZg@mail.gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
To: Gregory Price <gregory.price@memverge.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Sajjan Rao <sajjanr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan / Gregory,
Just wanted to touch base on below questions and if you have any
inputs on the same. Thanks for your help.

Thanks
Ravi

On Wed, Oct 18, 2023 at 4:00=E2=80=AFPM Ravi Kanth <mvrravikanth@gmail.com>=
 wrote:
>
> Hi Jonathan / Gregory,
>
> 1. Do we have the support in CXL driver to read the "Device status
> registers" and specifically "Event status register" section 8.2.8.3
> and 8.2.8.3.1?
> 2. If an interrupt is posted by the device firmware, how will user
> space applications be notified ? Do we have an interface for the same
> in CXL driver?
>
> If the above features are already supported in CXL driver, Can you
> please point us to the sample code snippets to achieve the same?
>
> Also does the switch cci function change part of the mainline?
>
> Thanks for your help in advance.
>
> Thanks
> Ravi
>
> On Sat, Sep 2, 2023 at 8:28=E2=80=AFPM Ravi Kanth <mvrravikanth@gmail.com=
> wrote:
> >
> > Ok. Got it. Thanks Gregory.
> >
> > Ravi
> >
> > On Fri, Sep 1, 2023 at 10:07=E2=80=AFPM Gregory Price
> > <gregory.price@memverge.com> wrote:
> > >
> > >
> > > > However we saw the below crash when we sent the command for the fir=
st time.
> > >
> > > That's expected, there's an explicit warning the first time a raw com=
mand is sent.   This is intended behavior, no crash has occurred.
> >
> >
> >
> > --
> > Ravi
>
>
>
> --
> Ravi



--=20
Ravi
