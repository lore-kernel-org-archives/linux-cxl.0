Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A441778
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7tZ13CtSz6K9Tm;
	Mon,  8 Jan 2024 20:25:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FBC6140A86;
	Mon,  8 Jan 2024 20:28:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 12:28:01 +0000
Date: Mon, 8 Jan 2024 12:28:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dongsheng Yang <dongsheng.yang@easystack.cn>, <dave@stgolabs.net>,
	<ave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] cxl: introduce CXL Virtualization module
Message-ID: <20240108122801.00000e47@Huawei.com>
In-Reply-To: <659597dc1fb49_16f746294a1@iweiny-mobl.notmuch>
References: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
	<659597dc1fb49_16f746294a1@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 3 Jan 2024 09:22:36 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Dongsheng Yang wrote:
> > Hi all:
> > 	This patchset introduce cxlv module to allow user to
> > create virtual cxl device. it's based linux6.7-rc5, you can
> > get the code from https://github.com/DataTravelGuide/linux
> >=20
> > 	As the real CXL device is not widely available now, we need
> > some virtual cxl device to do uplayer software developing or
> > testing. Qemu is good for functional testing, but not good
> > for some performance testing. =20
>=20
> Do you have more details on what performance is missing from Qemu and why
> this solution is better than a solution to fix Qemu?
>=20
> Long term it seems better to fix Qemu for this type of work.

I plan to look at this sometime soon, but note that the fix will be special
cases only (no interleave!) in the short term.  Emulating interleave
is always going to be costly - can probably be better than we have it today
for large granularity (pages) but I'm not sure we will ever care enough
to implement that.

For virtualization usecases, if we go with CXL emulation as the path for
DCD then we'll just emulate direct connected devices and patch up the
perf characteristics to cover interleave, switches etc.

With such limitations we can get QEMU to perform well. I'm not keen on
separating QEMU for functional testing from QEMU for workload testing
but meh, we can at least make it automatic to use a higher perf root
if the interleave config allows it.

>=20
> Are their other advantages to having this additional test infrastructure
> in the kernel?  We already have cxl_test.
>=20
> Ira
>=20
> >=20
> > 	The new CXLV module allow user to use the reserved RAM[1], to
> > create virtual cxl device. When the cxlv module load, it will
> > create a directory named as "cxl_virt" under /sys/devices/virtual:
> >=20
> > 	"/sys/devices/virtual/cxl_virt/"
> >=20
> > that's the top level device for all cxlv devices.
> > At the same time, cxlv module will create a debugfs directory:
> >=20
> > /sys/kernel/debug/cxl/cxlv
> > =E2=94=9C=E2=94=80=E2=94=80 create
> > =E2=94=94=E2=94=80=E2=94=80 remove
> >=20
> > the create and remove debugfs file is the cxlv entry to create or remove
> > a cxlv device.
> >=20
> > 	Each cxlv device have its owned virtual pci related bridge and bus, cx=
lv
> > will create a new root_port for the new cxlv device, setup cxl ports for
> > dport and nvdimm-bridge. After that, we will add the virtual pci device,
> > that will go into the cxl_pci_probe to setup new memdev.
> >=20
> > 	Then we can see the cxl device with cxl list and use it as a real cxl
> > device.
> >=20
> >  $ echo "memstart=3D$((8*1024*1024*1024)),cxltype=3D3,pmem=3D1,memsize=
=3D$((2*1024*1024*1024))" > /sys/kernel/debug/cxl/cxlv/create
> >  $ cxl list
> > [
> >   {
> >     "memdev":"mem0",
> >     "pmem_size":1879048192,
> >     "serial":0,
> >     "numa_node":0,
> >     "host":"0010:01:00.0"
> >   }
> > ]
> >  $ cxl create-region -m mem0 -d decoder0.0 -t pmem
> > {
> >   "region":"region0",
> >   "resource":"0x210000000",
> >   "size":"1792.00 MiB (1879.05 MB)",
> >   "type":"pmem",
> >   "interleave_ways":1,
> >   "interleave_granularity":256,
> >   "decode_state":"commit",
> >   "mappings":[
> >     {
> >       "position":0,
> >       "memdev":"mem0",
> >       "decoder":"decoder2.0"
> >     }
> >   ]
> > }
> > cxl region: cmd_create_region: created 1 region
> >=20
> >  $ ndctl create-namespace -r region0 -m fsdax --map dev -t pmem -b 0
> > {
> >   "dev":"namespace0.0",
> >   "mode":"fsdax",
> >   "map":"dev",
> >   "size":"1762.00 MiB (1847.59 MB)",
> >   "uuid":"686fd289-a252-42cf-a3a5-95a39ed5c9d5",
> >   "sector_size":512,
> >   "align":2097152,
> >   "blockdev":"pmem0"
> > }
> >=20
> >  $ mkfs.xfs -f /dev/pmem0=20
> > meta-data=3D/dev/pmem0             isize=3D512    agcount=3D4, agsize=
=3D112768
> > blks
> >          =3D                       sectsz=3D4096  attr=3D2, projid32bit=
=3D1
> >          =3D                       crc=3D1        finobt=3D1, sparse=3D=
1,
> > rmapbt=3D0
> >          =3D                       reflink=3D1    bigtime=3D0 inobtcoun=
t=3D0
> > data     =3D                       bsize=3D4096   blocks=3D451072, imax=
pct=3D25
> >          =3D                       sunit=3D0      swidth=3D0 blks
> > naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0, ftype=
=3D1
> > log      =3Dinternal log           bsize=3D4096   blocks=3D2560, versio=
n=3D2
> >          =3D                       sectsz=3D4096  sunit=3D1 blks, lazy-=
count=3D1
> > realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=
=3D0
> >=20
> > Any comment is welcome!
> >=20
> > TODO: implement cxlv command in ndctl to do cxlv device management.
> >=20
> > [1]: Add argument in kernel command line: "memmap=3Dnn[KMG]$ss[KMG]",
> > detail in Documentation/driver-api/cxl/memory-devices.rst
> >=20
> > Thanx
> >=20
> > Dongsheng Yang (4):
> >   cxl: move some function from acpi module to core module
> >   cxl/port: allow dport host to be driver-less device
> >   cxl/port: introduce cxl_disable_port() function
> >   cxl: introduce CXL Virtualization module
> >=20
> >  MAINTAINERS                         |   6 +
> >  drivers/cxl/Kconfig                 |  11 +
> >  drivers/cxl/Makefile                |   1 +
> >  drivers/cxl/acpi.c                  | 143 +-----
> >  drivers/cxl/core/port.c             | 231 ++++++++-
> >  drivers/cxl/cxl.h                   |   6 +
> >  drivers/cxl/cxl_virt/Makefile       |   5 +
> >  drivers/cxl/cxl_virt/cxlv.h         |  87 ++++
> >  drivers/cxl/cxl_virt/cxlv_debugfs.c | 260 ++++++++++
> >  drivers/cxl/cxl_virt/cxlv_device.c  | 311 ++++++++++++
> >  drivers/cxl/cxl_virt/cxlv_main.c    |  67 +++
> >  drivers/cxl/cxl_virt/cxlv_pci.c     | 710 ++++++++++++++++++++++++++++
> >  drivers/cxl/cxl_virt/cxlv_pci.h     | 549 +++++++++++++++++++++
> >  drivers/cxl/cxl_virt/cxlv_port.c    | 149 ++++++
> >  14 files changed, 2388 insertions(+), 148 deletions(-)
> >  create mode 100644 drivers/cxl/cxl_virt/Makefile
> >  create mode 100644 drivers/cxl/cxl_virt/cxlv.h
> >  create mode 100644 drivers/cxl/cxl_virt/cxlv_debugfs.c
> >  create mode 100644 drivers/cxl/cxl_virt/cxlv_device.c
> >  create mode 100644 drivers/cxl/cxl_virt/cxlv_main.c
> >  create mode 100644 drivers/cxl/cxl_virt/cxlv_pci.c
> >  create mode 100644 drivers/cxl/cxl_virt/cxlv_pci.h
> >  create mode 100644 drivers/cxl/cxl_virt/cxlv_port.c
> >=20
> > --=20
> > 2.34.1
> >  =20
>=20
>=20
>=20

