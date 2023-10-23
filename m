Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122FE23DE
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C6510A
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 06:50:21 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDc1G0Fm9z6JB8t;
	Mon, 23 Oct 2023 21:46:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 23 Oct
 2023 14:50:17 +0100
Date: Mon, 23 Oct 2023 14:50:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ravi Kanth <mvrravikanth@gmail.com>
CC: Ira Weiny <ira.weiny@intel.com>, Gregory Price
	<gregory.price@memverge.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Sajjan Rao <sajjanr@gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
Message-ID: <20231023145016.00005190@Huawei.com>
In-Reply-To: <CAEvOrRxLs8qLjpWM4J16xnuDQfBozYUEW7cLpbr1oHv3Zxzdow@mail.gmail.com>
References: <CAEvOrRzE76U2g_8=V3F-4fqwosRz3n9kO+40E_iG74EcbQBxtw@mail.gmail.com>
	<20230823180323.000052d5@Huawei.com>
	<CAEvOrRyquLL6-d=vOyB9NNOPVE370qjV0zu8XBsTJmpOBx2UNw@mail.gmail.com>
	<ZPHyoJsZDnzpU7C4@memverge.com>
	<CAEvOrRw2e3cn=2fNXO8_iX0kg09an-OSx1fnjx7ciGGhZo9f9A@mail.gmail.com>
	<CAEvOrRy9qoydCqxq7xv1QNM+z+YQZyQORtqdDU2VcVKP42CJhA@mail.gmail.com>
	<SJ0PR17MB5512449C5FFD76AD50B3D3AF83E4A@SJ0PR17MB5512.namprd17.prod.outlook.com>
	<CAEvOrRwOWT5HuoUsjkUyt6HpXQhWVR2Hv6cxJPP+4+0xNQpM8g@mail.gmail.com>
	<CAEvOrRzrAu-2o9xZC+YBG_7R9hLSm_kZFuUZ98tA23NjFyAupw@mail.gmail.com>
	<CAEvOrRyMqBcv+6RseVS0x_6a3aJU82tjLJagmqCrgRebx5JaZg@mail.gmail.com>
	<6532e53ed63b0_21a97294d@iweiny-mobl.notmuch>
	<CAEvOrRxLs8qLjpWM4J16xnuDQfBozYUEW7cLpbr1oHv3Zxzdow@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Sun, 22 Oct 2023 12:15:13 +0530
Ravi Kanth <mvrravikanth@gmail.com> wrote:

> Thanks Ira for providing the references.
>=20
> I am specifically looking for event support for the switch CCI
> endpoint(/dev/cxl/switch) via the IOCTL interface. I could see
> cxl_swmb_setup_mailbox() in the switchdev.c file. However I am not
> able to understand how user space applications could make use of it.

If you have all the moving parts (i.e. recent qemu + the kernel patches
I just linked to in another branch of this thread) then the example at:
https://gitlab.com/jic23/cxl-fmapi-tests

will let you interact with the emulated switch mailbox CCI
via the raw ioctl command.  So far it does basic crawl out and enumerate
what what it finds.

>=20
> The ndctl project does not also have references on how we could make
> use of the switch CCI endpoint to get the interrupts nor on how we can
> read "Device status registers" and specifically "Event status
> register" section 8.2.8.3 and 8.2.8.3.1 via IOCTL interface from the
> switch CCI endpoint.

Whilst we haven't really discussed it yet, I'd not expect ndctl (which
is focused on host interaction) will support much in the way of specific
features for fabric management.

The cxl-fmapi-tests are not intended to be used for production use cases
either. My expectation is that one of the projects more generally looking
at CXL fabric management will provide that functionality. I've not really
been keeping track of these but I gather there is work in various standards
orgs (outside of the CXL consortium) to define how it will be done at a
higher level.

Jonathan

>=20
> - Ravi
>=20
>=20
>=20
> On Sat, Oct 21, 2023 at 2:08=E2=80=AFAM Ira Weiny <ira.weiny@intel.com> w=
rote:
> >
> > Ravi Kanth wrote: =20
> > > Hi Jonathan / Gregory,
> > > Just wanted to touch base on below questions and if you have any
> > > inputs on the same. Thanks for your help.
> > >
> > > Thanks
> > > Ravi
> > >
> > > On Wed, Oct 18, 2023 at 4:00=E2=80=AFPM Ravi Kanth <mvrravikanth@gmai=
l.com> wrote: =20
> > > >
> > > > Hi Jonathan / Gregory,
> > > >
> > > > 1. Do we have the support in CXL driver to read the "Device status
> > > > registers" and specifically "Event status register" section 8.2.8.3
> > > > and 8.2.8.3.1? =20
> >
> > Yes the upstream driver reads this when processing the Event interrupt
> > from the device.  Then it uses the value to chose which logs to read.
> >
> > See cxl_event_thread() in the kernel source.
> > =20
> > > > 2. If an interrupt is posted by the device firmware, how will user
> > > > space applications be notified ? Do we have an interface for the sa=
me
> > > > in CXL driver? =20
> >
> > All events are reported through the trace infrastructure.
> > =20
> > > >
> > > > If the above features are already supported in CXL driver, Can you
> > > > please point us to the sample code snippets to achieve the same? =20
> >
> > ndctl has the ability to monitor these events and example C code in the=
re.
> >
> > See .../cxl/event_trace.c in the ndctl project.[1]
> >
> > [1] https://github.com/pmem/ndctl
> > =20
> > > >
> > > > Also does the switch cci function change part of the mainline? =20
> >
> > I'm not sure I parse this question but I'm also not super familiar with
> > switch cci.  So I'll let Jonathan answer this.
> >
> > Ira
> > =20
> > > >
> > > > Thanks for your help in advance.
> > > >
> > > > Thanks
> > > > Ravi
> > > > =20
> >
> > [snip] =20
>=20
>=20
>=20

