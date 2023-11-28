Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077E5F5
	for <linux-cxl@vger.kernel.org>; Tue, 28 Nov 2023 09:28:17 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SfqBV0gcWz6K9Fl;
	Wed, 29 Nov 2023 01:26:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D5EEC1408FF;
	Wed, 29 Nov 2023 01:28:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:56 +0000
Date: Tue, 28 Nov 2023 17:26:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, "Ira
 Weiny" <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH 1/4] cxl: mbox: Preparatory move of functions to
 core/mbox.c and cxlmbox.h
Message-ID: <20231128172655.00004569@Huawei.com>
In-Reply-To: <CADbZ7FptPTeW5yiGxkQhUUMjUsk7PhjO=V3gBL5UZVGPdfdECA@mail.gmail.com>
References: <20231016125323.18318-1-Jonathan.Cameron@huawei.com>
	<20231016125323.18318-2-Jonathan.Cameron@huawei.com>
	<6551693f988f1_46f02942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<CADbZ7FptPTeW5yiGxkQhUUMjUsk7PhjO=V3gBL5UZVGPdfdECA@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 13 Nov 2023 12:39:15 -0700
Sumanesh Samanta <sumanesh.samanta@broadcom.com> wrote:

> >>Given that the CXL mailbox format is being adopted by other standards
> >>efforts in PCIe and OCP I would expect that this functionality is better
> >>served moving out of cxl_core.ko into its own compilation unit. =20

Makes sense to break it out to a separate module. I was kind of assuming th=
at
would happen later and the fact it isn't is more about history of this patch
set than anything else (predates MMPT surfacing)

>=20
> Hi Dan, Jonathan,
>=20
> Agree with the statement above, and in fact, I think that there should
> be a way applications can send CCI commands even from hosts without
> CXL root port.
> Consider a CXL switch that is connected to two hosts, one with CXL
> root port, and other having a pure PCIe root port.
> Ideally applications on either host should be able to communicate
> with/configure the switch in the same way from both the hosts (CXL
> capable or not).


Absolutely agree, but I think this should just work with the current code.
It's using stuff from the library module, not stuff that is loaded just
when the ACPI tables say it's a CXL system. We can reduce what is pulled
in by doing what Dan suggests but that's a software modularity question
rather than anything about the hardware supported.

>=20
> If the CCI mailbox driver is completely dependent on the CXL root
> port, then it will not even load on a PCIe root port, even if we
> implement the 0x0c0b00 class code in a CXL switch.
> In this respect, a CXL switch can implement the PCIe MMPT interface
> too, so that PCIe based drivers can access that interface to send
> mailbox commands.
> The idea is, even if the CCI mailbox driver does not load in a non-CXL
> root port, an application can use the MMPT interface to manage the
> driver.
> Please let me know if you think that will work?
>=20
> One potential problem I see is that in CXL root port, both CCI and
> MMPT mailbox will be available, which might lead to conflict if two
> applications use the two interfaces at the same time.
> Ultimately I think having a root port independent mailbox driver (that
> works in both CXL and PCIe root port) would be helpful for switches
> that can connect to both CXL and PCIe root ports.

'Watch this space' as interaction of MMPT and CXL is not
something the CXL spec speaks about and there are some corners
that need to be resolved.  Take questions about this to appropriate
standards orgs as we can't resolve this here.

However, the switch CCI is not associated with the root port it's associated
with a PCIe function that can be on a PCIe bus.  Whether we end up with
PCIe software support MMPT without needing to be part of a driver binding
to the class code (which inherently here means it understands the CXL mailb=
ox)
is an interesting question.  I find it unlikely that Linux will support such
'bare' MMPT instances but maybe...

Jonathan


>=20
> Would appreciate any insight on this.
>=20
> sincerely,
> Sumanesh
>=20
>=20
>=20
>=20
> On Sun, Nov 12, 2023 at 5:10=E2=80=AFPM Dan Williams <dan.j.williams@inte=
l.com> wrote:
> >
> > Jonathan Cameron wrote: =20
> > > A later patch will modify this code to separate out the mbox
> > > functionality from the memdev.  This patch is intended to make
> > > that a little more readable.  Related move of cxl_err(), cxl_cmd_err()
> > > to make them accessible from other parts of the cxl core code.
> > >
> > > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/cxl/core/mbox.c | 261 ++++++++++++++++++++++++++++++++++++++-
> > >  drivers/cxl/cxlmbox.h   | 146 ++++++++++++++++++++++
> > >  drivers/cxl/cxlmem.h    | 148 ++--------------------
> > >  drivers/cxl/pci.c       | 265 +-------------------------------------=
--
> > >  4 files changed, 418 insertions(+), 402 deletions(-) =20
> >
> > Given that the CXL mailbox format is being adopted by other standards
> > efforts in PCIe and OCP I would expect that this functionality is better
> > served moving out of cxl_core.ko into its own compilation unit.
> >
> > Something like drivers/cxl/cci/, that CXL can select. The s/mbox/cci/
> > rename is a proposal to both drop a letter out of the acronym and
> > perhaps make the code a bit more discoverable / palatable for folks
> > coming from those non-CXL specs to find the Linux code. However, if
> > folks think that's too much thrash I am ok with drivers/cxl/mbox/.
> >
> > As for the policy for raw commands. I would still like for there to be
> > some discipline of registratants to this facility to classify production
> > vs debug commands to give Linux distributors a single place to set poli=
cy.
> > I.e. keep up the need for consumers of this to define "Linux" commands
> > to avoid the "raw" warning.
> >
> > That said, how much of what switch CCI wants to do should be an ioctl()
> > ABI vs sysfs / configfs? The raw commands are really only there for
> > prototyping until production flows are established.
> > =20
>=20

