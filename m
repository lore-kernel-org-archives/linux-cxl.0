Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71DA48
	for <linux-cxl@vger.kernel.org>; Sun, 22 Oct 2023 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCx1AQnO"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB3DF7
	for <linux-cxl@vger.kernel.org>; Sat, 21 Oct 2023 23:45:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c5056059e0so33486041fa.3
        for <linux-cxl@vger.kernel.org>; Sat, 21 Oct 2023 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697957126; x=1698561926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ptw826QSjW8MqX4AvipixQgQqyfj6IjrYIlsKSoPH8k=;
        b=JCx1AQnOg+12C3d6549ktrNwS1jD3TZc1o5Fn7WTByql0U2q8NT/96WqRZLX3+EJd1
         X7uOBaGxt8ee/YYqpyWnFBC6JB2/e6QCGprurvWYFeatul5MOcEKhoUEPZw4DlPTP9A8
         kMikIrHMrQSB9RO/gHZhoUkm6BuHmKEQIQUQ8EuAy245ZIUDOBuRhAJWU8OXtyDWgJyc
         YtDxO1IdP6Oyb/BEkzmm/uNMjssqp/uTrJQ/YTDmKNmIi5bArjp+R/jQmz8HDUmC/81w
         gYS/fgTs+cqRBuztATPFUpt6m5xPqmwfCi1jPeWZtkdl8B/87R1xSvgdsNsCxmAdZBi3
         Rqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697957126; x=1698561926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ptw826QSjW8MqX4AvipixQgQqyfj6IjrYIlsKSoPH8k=;
        b=bykxBgiv+VcT/mH92LP98sEGrhdErhDNdrY/OC4VfPbLgQMipJi6rY5LUVPRnEckAd
         fRAvheae57ANJDMNVm+h6OfUsBKU1ljP8l0OyErCXs8BOVbbVdCNafxhVUtJY+ZR4epD
         l3ZIalc8zhHiS3hyeTmBeDLzh5QU0LlVBMnv0SLsKTZ8nVp53IBdBwNCIrBFbcE1RvJ4
         bvzhPtKjEqxdQlHfNdk26I3vw/1c56JHDlvGq21j+Nv64B+4AFl7YFRQrkyviyLzeXib
         hex5SPmnDaS2jbHAUOTXjLkciPERJCMR6QPhyLE6cI1utwYNWVWbl1eqGz7qBlA4tSJf
         0Iuw==
X-Gm-Message-State: AOJu0YwXLNMZM8KggVBnaStChQW9JKVhYQ28994TgwI5df/j4zrMTKg3
	RTsYOhypQES1YZpLjpt59pgu4Rrt9aj7MB3876Q=
X-Google-Smtp-Source: AGHT+IEYq/B7cqgE9gjHSg8YlhiEEWgVh+S+OJQzTFk8oJfOnjuzxAOgwzxMWaaKRemepN5xv2rWKJUHnGbLsqnVl6I=
X-Received: by 2002:a2e:9cd6:0:b0:2c5:16d4:32ef with SMTP id
 g22-20020a2e9cd6000000b002c516d432efmr3951431ljj.46.1697957125527; Sat, 21
 Oct 2023 23:45:25 -0700 (PDT)
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
 <CAEvOrRyMqBcv+6RseVS0x_6a3aJU82tjLJagmqCrgRebx5JaZg@mail.gmail.com> <6532e53ed63b0_21a97294d@iweiny-mobl.notmuch>
In-Reply-To: <6532e53ed63b0_21a97294d@iweiny-mobl.notmuch>
From: Ravi Kanth <mvrravikanth@gmail.com>
Date: Sun, 22 Oct 2023 12:15:13 +0530
Message-ID: <CAEvOrRxLs8qLjpWM4J16xnuDQfBozYUEW7cLpbr1oHv3Zxzdow@mail.gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
To: Ira Weiny <ira.weiny@intel.com>
Cc: Gregory Price <gregory.price@memverge.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Sajjan Rao <sajjanr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Ira for providing the references.

I am specifically looking for event support for the switch CCI
endpoint(/dev/cxl/switch) via the IOCTL interface. I could see
cxl_swmb_setup_mailbox() in the switchdev.c file. However I am not
able to understand how user space applications could make use of it.

The ndctl project does not also have references on how we could make
use of the switch CCI endpoint to get the interrupts nor on how we can
read "Device status registers" and specifically "Event status
register" section 8.2.8.3 and 8.2.8.3.1 via IOCTL interface from the
switch CCI endpoint.

- Ravi



On Sat, Oct 21, 2023 at 2:08=E2=80=AFAM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Ravi Kanth wrote:
> > Hi Jonathan / Gregory,
> > Just wanted to touch base on below questions and if you have any
> > inputs on the same. Thanks for your help.
> >
> > Thanks
> > Ravi
> >
> > On Wed, Oct 18, 2023 at 4:00=E2=80=AFPM Ravi Kanth <mvrravikanth@gmail.=
com> wrote:
> > >
> > > Hi Jonathan / Gregory,
> > >
> > > 1. Do we have the support in CXL driver to read the "Device status
> > > registers" and specifically "Event status register" section 8.2.8.3
> > > and 8.2.8.3.1?
>
> Yes the upstream driver reads this when processing the Event interrupt
> from the device.  Then it uses the value to chose which logs to read.
>
> See cxl_event_thread() in the kernel source.
>
> > > 2. If an interrupt is posted by the device firmware, how will user
> > > space applications be notified ? Do we have an interface for the same
> > > in CXL driver?
>
> All events are reported through the trace infrastructure.
>
> > >
> > > If the above features are already supported in CXL driver, Can you
> > > please point us to the sample code snippets to achieve the same?
>
> ndctl has the ability to monitor these events and example C code in there=
.
>
> See .../cxl/event_trace.c in the ndctl project.[1]
>
> [1] https://github.com/pmem/ndctl
>
> > >
> > > Also does the switch cci function change part of the mainline?
>
> I'm not sure I parse this question but I'm also not super familiar with
> switch cci.  So I'll let Jonathan answer this.
>
> Ira
>
> > >
> > > Thanks for your help in advance.
> > >
> > > Thanks
> > > Ravi
> > >
>
> [snip]



--=20
Ravi
