Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18C469D
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMKp/oDS"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F838BD
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 18:52:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507bd19eac8so510456e87.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 18:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698285147; x=1698889947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIRg2K2N7KfGems3pOwOeGJ4SeuNK1NSMvNmzZbhXZE=;
        b=cMKp/oDS47Qv3rN1tbKWV4uM1HNWZ1YcvRRm8I5bDF6vYdF7elxLen5CM6olWDGndL
         dgrhfEdb9j0EpKXv+Zv5YsLLM1zdE71wLzblfp/4KmJc2IFWlTNrYQEPOOQ21esPg/Ie
         gysJ0sKDZ2lNOw5r1yy82L/kLyJwWoZ0Pg1/ILfu8uKRja7wneyAkgQfKd588h28dW2N
         MVdcEUI6o2Zkj8tvsma+6kYaZNuVATjHCWVblf8YAPvExjz7fFThaxZRXSNiYc+ERW3Z
         OIvDRIf2o9ctGu4hxyut5qsrJ9myse2u5lzMFgPyWIOK78XblWqRY4w7Wjws3Le6x2R4
         TY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698285147; x=1698889947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIRg2K2N7KfGems3pOwOeGJ4SeuNK1NSMvNmzZbhXZE=;
        b=bR9Xxoe9q2tiHoRnM8pE7+g08Uy1yo2A7kvD7X2d4OV7ny+cpAvEDZFFZI6r5CZJbj
         LaUUR5BklkdH/83XH10H1x7EnfjPuJmdjsbgDr/D968dO1WSsuVj9Ng5sIWLvSS1ef89
         2x0G+tsBF6ty/nivXzfAJI7Ca+s7Y+0NBjYa2R3d5sLI5eILuU8kLzaCSS0awz9ACpEr
         CVTyF9jZi/jUfM00WGdGRUFX/Z5lzWCsgT5j+YZSlhM/UEmwVRNiu/ujIOtMIOj4UqBG
         N64A+pE8vafh97Zks9DMok06JxCZXRpsrluRbn0i3eYFUYPMiMhNkgGiwOe00+X+OKGA
         xeMA==
X-Gm-Message-State: AOJu0YxoZIkPpjZIM+0aHkRBxgkIrzxskD0HDNbdMJDI9VGAt/0UO5Dm
	N3q99Sqmou/WI1jwx+hnqG+oyfg4yFZmvFmpxWns8Dh9cz0=
X-Google-Smtp-Source: AGHT+IGvTw0GNiE/K4M592ysoDOO841+3ga5A3azRvny8dQj5K5Jj9o8KYyA9lgO/mtZxES9QgnKFXJCll/SPT2jgLM=
X-Received: by 2002:a05:651c:204:b0:2c5:22c0:582c with SMTP id
 y4-20020a05651c020400b002c522c0582cmr11704486ljn.11.1698285146487; Wed, 25
 Oct 2023 18:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEvOrRzE76U2g_8=V3F-4fqwosRz3n9kO+40E_iG74EcbQBxtw@mail.gmail.com>
 <20230823180323.000052d5@Huawei.com> <CAEvOrRyquLL6-d=vOyB9NNOPVE370qjV0zu8XBsTJmpOBx2UNw@mail.gmail.com>
 <ZPHyoJsZDnzpU7C4@memverge.com> <CAEvOrRw2e3cn=2fNXO8_iX0kg09an-OSx1fnjx7ciGGhZo9f9A@mail.gmail.com>
 <CAEvOrRy9qoydCqxq7xv1QNM+z+YQZyQORtqdDU2VcVKP42CJhA@mail.gmail.com>
 <SJ0PR17MB5512449C5FFD76AD50B3D3AF83E4A@SJ0PR17MB5512.namprd17.prod.outlook.com>
 <CAEvOrRwOWT5HuoUsjkUyt6HpXQhWVR2Hv6cxJPP+4+0xNQpM8g@mail.gmail.com>
 <CAEvOrRzrAu-2o9xZC+YBG_7R9hLSm_kZFuUZ98tA23NjFyAupw@mail.gmail.com>
 <CAEvOrRyMqBcv+6RseVS0x_6a3aJU82tjLJagmqCrgRebx5JaZg@mail.gmail.com>
 <6532e53ed63b0_21a97294d@iweiny-mobl.notmuch> <CAEvOrRxLs8qLjpWM4J16xnuDQfBozYUEW7cLpbr1oHv3Zxzdow@mail.gmail.com>
 <20231023145016.00005190@Huawei.com>
In-Reply-To: <20231023145016.00005190@Huawei.com>
From: Ravi Kanth <mvrravikanth@gmail.com>
Date: Thu, 26 Oct 2023 07:22:16 +0530
Message-ID: <CAEvOrRyfn2uEPSbD1x07pzJQNVtotNut6XTD1-FZFK5Pa05gEQ@mail.gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Sajjan Rao <sajjanr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jonathan. For switch devices via IOCTL, Do you mean that CXL
driver will not have functionality to support or notify host
applications about async events / interrupts via IOCTL or this has not
yet been discussed?

Is it possible to provide an interface to read "Device status
registers" and specifically "Event status register" section 8.2.8.3
and 8.2.8.3.1 via IOCTL interface from the switch CCI endpoint via
IOCTL using CXL driver?

Ravi

On Mon, Oct 23, 2023 at 7:20=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sun, 22 Oct 2023 12:15:13 +0530
> Ravi Kanth <mvrravikanth@gmail.com> wrote:
>
> > Thanks Ira for providing the references.
> >
> > I am specifically looking for event support for the switch CCI
> > endpoint(/dev/cxl/switch) via the IOCTL interface. I could see
> > cxl_swmb_setup_mailbox() in the switchdev.c file. However I am not
> > able to understand how user space applications could make use of it.
>
> If you have all the moving parts (i.e. recent qemu + the kernel patches
> I just linked to in another branch of this thread) then the example at:
> https://gitlab.com/jic23/cxl-fmapi-tests
>
> will let you interact with the emulated switch mailbox CCI
> via the raw ioctl command.  So far it does basic crawl out and enumerate
> what what it finds.
>
> >
> > The ndctl project does not also have references on how we could make
> > use of the switch CCI endpoint to get the interrupts nor on how we can
> > read "Device status registers" and specifically "Event status
> > register" section 8.2.8.3 and 8.2.8.3.1 via IOCTL interface from the
> > switch CCI endpoint.
>
> Whilst we haven't really discussed it yet, I'd not expect ndctl (which
> is focused on host interaction) will support much in the way of specific
> features for fabric management.
>
> The cxl-fmapi-tests are not intended to be used for production use cases
> either. My expectation is that one of the projects more generally looking
> at CXL fabric management will provide that functionality. I've not really
> been keeping track of these but I gather there is work in various standar=
ds
> orgs (outside of the CXL consortium) to define how it will be done at a
> higher level.
>
> Jonathan
>
> >
> > - Ravi
> >
> >
> >
> > On Sat, Oct 21, 2023 at 2:08=E2=80=AFAM Ira Weiny <ira.weiny@intel.com>=
 wrote:
> > >
> > > Ravi Kanth wrote:
> > > > Hi Jonathan / Gregory,
> > > > Just wanted to touch base on below questions and if you have any
> > > > inputs on the same. Thanks for your help.
> > > >
> > > > Thanks
> > > > Ravi
> > > >
> > > > On Wed, Oct 18, 2023 at 4:00=E2=80=AFPM Ravi Kanth <mvrravikanth@gm=
ail.com> wrote:
> > > > >
> > > > > Hi Jonathan / Gregory,
> > > > >
> > > > > 1. Do we have the support in CXL driver to read the "Device statu=
s
> > > > > registers" and specifically "Event status register" section 8.2.8=
.3
> > > > > and 8.2.8.3.1?
> > >
> > > Yes the upstream driver reads this when processing the Event interrup=
t
> > > from the device.  Then it uses the value to chose which logs to read.
> > >
> > > See cxl_event_thread() in the kernel source.
> > >
> > > > > 2. If an interrupt is posted by the device firmware, how will use=
r
> > > > > space applications be notified ? Do we have an interface for the =
same
> > > > > in CXL driver?
> > >
> > > All events are reported through the trace infrastructure.
> > >
> > > > >
> > > > > If the above features are already supported in CXL driver, Can yo=
u
> > > > > please point us to the sample code snippets to achieve the same?
> > >
> > > ndctl has the ability to monitor these events and example C code in t=
here.
> > >
> > > See .../cxl/event_trace.c in the ndctl project.[1]
> > >
> > > [1] https://github.com/pmem/ndctl
> > >
> > > > >
> > > > > Also does the switch cci function change part of the mainline?
> > >
> > > I'm not sure I parse this question but I'm also not super familiar wi=
th
> > > switch cci.  So I'll let Jonathan answer this.
> > >
> > > Ira
> > >
> > > > >
> > > > > Thanks for your help in advance.
> > > > >
> > > > > Thanks
> > > > > Ravi
> > > > >
> > >
> > > [snip]
> >
> >
> >
>


--=20
Ravi
