Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671419459
	for <linux-cxl@vger.kernel.org>; Wed, 18 Oct 2023 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beFOoi2R"
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621F7B0
	for <linux-cxl@vger.kernel.org>; Wed, 18 Oct 2023 03:30:27 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so81180581fa.1
        for <linux-cxl@vger.kernel.org>; Wed, 18 Oct 2023 03:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697625025; x=1698229825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=813LA3Zh3/8JSgh8C5708wf661JJ66/TR5BwIOeVCSM=;
        b=beFOoi2RF7kKlxCsd0ccJ/KPuI7dkIVZOLsuKe6IUWeD08+8Tjj4pFgQIr4aSJcZDE
         x92VqKE3DSIWG0BNSDirwO6J7xDdLJnD/a9Jbxc7e/EJkNvrj1TlDjDB+U+366N32GjC
         8FUqSac7Ffra2JFVG4l4mrXLXddb8HQTaaFDQAAPJIpfAnfVv0LQaiNur2IgC3M838ft
         uSTi7H8ZN9KqKR5HFybjFGxYfNy0e1BacUWVa3HiCGncpzQ36E6ge//l9wMxpxK9h4SK
         G+uLumlP0FJ9H1hQf3l/5i9hEdjPXRlOkP3nYCO9WQ2yYuF2wvXJC/mco0ZobCTXVyX5
         1fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625025; x=1698229825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=813LA3Zh3/8JSgh8C5708wf661JJ66/TR5BwIOeVCSM=;
        b=EwbU/EVcBkCsAw5QnX5Txs58la+0tipTxzpGLXcV+6cQ+gjL6dOMrZSCb4xR1Hgss+
         8FDhBwrYkWrvi/gCXmUlHdwNgqUh4RosYbhLdM90e7Gra0hAoTZI90ZJgY9ctvJJ5s0s
         l8jla0rg0NLVey2CHsvnt/eUpg34mSYP6eDm5yPzj5F+uI0BS/4whHTkmeaTRpFM8N8i
         9R0PvNR5eWOiRNcv2i5nCUg3PemD4epQYw/QR0Gf7zdfKDZXCKTkcQmFx3UmImVBXdYa
         Pp/dv4BOvVS+r0smD8yJVmti/bBmCh6mwQJyJNWZztyYeHTg2kP1FyootCQROBYyvjhV
         EFBg==
X-Gm-Message-State: AOJu0Yy2zh9lANmyLOszzoLZf0WX1lMwGpvfz0Elni1eOuWVzzRFLMb3
	iiR+Ub3oL14Bt1oVY0gMiHjD7mhTtTcOkkFmoWbQBfPX
X-Google-Smtp-Source: AGHT+IEFHQrLqKPv2cVIuS0LiKf6V/NZMnO2vRNrC3Ce50efiaY6KycOP64oyv0bhVbH9vu8t0+kctCEcSLhliYffig=
X-Received: by 2002:a05:651c:314:b0:2bc:f252:6cc4 with SMTP id
 a20-20020a05651c031400b002bcf2526cc4mr3297338ljp.10.1697625025330; Wed, 18
 Oct 2023 03:30:25 -0700 (PDT)
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
 <CAEvOrRwOWT5HuoUsjkUyt6HpXQhWVR2Hv6cxJPP+4+0xNQpM8g@mail.gmail.com>
In-Reply-To: <CAEvOrRwOWT5HuoUsjkUyt6HpXQhWVR2Hv6cxJPP+4+0xNQpM8g@mail.gmail.com>
From: Ravi Kanth <mvrravikanth@gmail.com>
Date: Wed, 18 Oct 2023 16:00:14 +0530
Message-ID: <CAEvOrRzrAu-2o9xZC+YBG_7R9hLSm_kZFuUZ98tA23NjFyAupw@mail.gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
To: Gregory Price <gregory.price@memverge.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Sajjan Rao <sajjanr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jonathan / Gregory,

1. Do we have the support in CXL driver to read the "Device status
registers" and specifically "Event status register" section 8.2.8.3
and 8.2.8.3.1?
2. If an interrupt is posted by the device firmware, how will user
space applications be notified ? Do we have an interface for the same
in CXL driver?

If the above features are already supported in CXL driver, Can you
please point us to the sample code snippets to achieve the same?

Also does the switch cci function change part of the mainline?

Thanks for your help in advance.

Thanks
Ravi

On Sat, Sep 2, 2023 at 8:28=E2=80=AFPM Ravi Kanth <mvrravikanth@gmail.com> =
wrote:
>
> Ok. Got it. Thanks Gregory.
>
> Ravi
>
> On Fri, Sep 1, 2023 at 10:07=E2=80=AFPM Gregory Price
> <gregory.price@memverge.com> wrote:
> >
> >
> > > However we saw the below crash when we sent the command for the first=
 time.
> >
> > That's expected, there's an explicit warning the first time a raw comma=
nd is sent.   This is intended behavior, no crash has occurred.
>
>
>
> --
> Ravi



--=20
Ravi
