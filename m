Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486F8C7EE24
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Jun 2023 17:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjFERv2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Jun 2023 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFERv1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Jun 2023 13:51:27 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D96A7
        for <linux-cxl@vger.kernel.org>; Mon,  5 Jun 2023 10:51:23 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230605175121usoutp019a8d87ed9c5cbf548bb87c1df9a03e95~l1K5udd1n0739407394usoutp01G;
        Mon,  5 Jun 2023 17:51:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230605175121usoutp019a8d87ed9c5cbf548bb87c1df9a03e95~l1K5udd1n0739407394usoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685987481;
        bh=anqBY59qGQhBDGVKDYJ1tnrIgHvtgPXK8unN9EWispg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=uuEVHH52S80MrLQ+UVgmRIpOhgr0x6hh8OThRxy1xGQbnHMW4xhQX+SniprlG119C
         J/RNDLXAsHwhK33qXPnGcIeqyy+3SMIO0t5JDIKYYX1t8u0GkWZOfGIJOiNTXZ3VDw
         rm6K0vmAKlCrE4r5p5Z31Dnc1oea8wpmaj34IsAA=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230605175120uscas1p2e0acaa807d13eac2c7ce6077bdc08ced~l1K5h3hcW0175801758uscas1p2Q;
        Mon,  5 Jun 2023 17:51:20 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 19.AF.51475.8902E746; Mon, 
        5 Jun 2023 13:51:20 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230605175120uscas1p133d49fa845805bda83677dd29cdf7c1e~l1K5Lfyyg2337423374uscas1p1b;
        Mon,  5 Jun 2023 17:51:20 +0000 (GMT)
X-AuditID: cbfec36d-8a3ff7000001c913-7c-647e20989a2d
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 91.9F.38326.8902E746; Mon, 
        5 Jun 2023 13:51:20 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 5 Jun 2023 10:51:19 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        5 Jun 2023 10:51:19 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Topic: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Index: AQHZhDHwBF2t8l6CHEO7jqFQqFgBOK99FUkAgAAEUYA=
Date:   Mon, 5 Jun 2023 17:51:19 +0000
Message-ID: <20230605175112.GA2290821@bgt-140510-bm03>
In-Reply-To: <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68A82B7ED06BE445AEEF7B0E3BBA5CE0@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djXc7ozFOpSDDb9NrboPr+B0WL61AuM
        FqtvrmG0aGh6xGLRsvs9k8X+p89ZLFYtvMZmcX7WKRaL5xOfM1ksXfKI2eJ47w4WB26PC5Mn
        sHosbnD12DnrLrtHy5G3QN6el0weGz/+Z/d4cm0zk8fm1y+YPabOrvf4vEkugCuKyyYlNSez
        LLVI3y6BK+NZE2vB2siKQyeWMjYwHnbrYuTkkBAwkbjX+Z+1i5GLQ0hgJaPEnWsHWCCcViaJ
        9mM32GCqDu5bwAaRWMso0bnnLlTVR0aJ27+7mSCcpYwSDa0nmEFa2AQUJfZ1bQdrFxFQljj9
        7ypYO7PAFRaJ61PXMYEkhAWcJSYvP8HYxcgBVOQicemZH4RpJbHmngRIBYuAisSOU53sIDav
        gJnEm6uXGEFsTgFriaezV7CC2IwCYhLfT60Bm8gsIC5x68l8JoirBSUWzd7DDGGLSfzb9RDq
        G0WJ+99fskPU60gs2P2JDWQts4CdxNUL0RBhbYllC18zQ6wVlDg58wkLRKukxMEVN6Ds6ZwS
        q05bQNguEhcfv4WKS0tcvT6VGWSkhECyxKqPXBDhHIn5S7ZAlVhLLPyznmkCo8osJEfPQnLQ
        LISDZiE5aBaSgxYwsq5iFC8tLs5NTy02zEst1ytOzC0uzUvXS87P3cQITHan/x3O3cG449ZH
        vUOMTByMhxglOJiVRHh3eVWnCPGmJFZWpRblxxeV5qQWH2KU5mBREuc1tD2ZLCSQnliSmp2a
        WpBaBJNl4uCUamBas6f4nXPFg6IczZCTM680v4o9ZOcpG/XaYpfof+V9founhRUfatFZbWce
        ymF0ReZHutQLbtOnq16khpfvnzbpZOsq2UDdFK9zawpjWcJufxa9OG3+U4l69f6Ef/kfOTZX
        2tsuDGpyc7nVtnybn3Rd4hy5DUz3nJRcPWXidb/fsIk4bmKx7vf20J/S2sXdMT0FNv7Xi4Im
        5632uCse8lf6uIGa+o2ow4dFJml2aPWvLxXMz9q58eisa8LbWb4e0bjz/1FFmODi661T/zRM
        /TbD7HGz8fnzUcvM4tq/qSmf4gs9dee50CrGdAemCczToppmth7gtXjXG1l0IiR1xoqGeIkp
        s6X6lC5tjFXQSFRiKc5INNRiLipOBABUSX1R5QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTURzu3Hu33W0NjkvzZA9qZomVZojdXmaYdU0Kg5TMwka7qeSrO62V
        YEOscMtQhj02q1mzRE1KozRN0/VSqYmkPWhJvtbQTIsamc2cl8j/vu98j9/vB4fEpd8ILzIp
        NYNhU+XJMr6ISFJjhasuLc5WrLZVz6e0ljuAuljUAaiKd5WAUuf0ElRu/VeMahqwEVR5STef
        sujbCMpWaMOoUlMvTj3PryVCxXSHroBH31CH03V6q4DOffJlijXYMfru2KSA7u+uweiaoc84
        XWQ4RX+vXhQl2ifaqGCSk44xbEDIQVHiYA4v/XasquVFKVAD8zYNEJIIBqHmRiNfA0SkFFYA
        1K3V4RwZA+hDsZbgSClAPy40464IHy5BjZoHfBd2h96o3dk1HcfhawK9KarCXMIcGIZ0t14A
        DSCnTFtR5+AuDq5HlR+Ry0HApai2LU/gwhIYjIa7OgE3qxGgX4/NPJcghBvQgKFsGgM4Fzna
        KqfrceiJ3vdfw7gTIDI1WHAOeyB7n5PH4SWox2EXcP6VyFj/je/aAYchqKsjjntegW6WDOHc
        Dm6o9XI/wUXnoeayt0QBQPoZ0/QzmvT/m/QzmvQzmoyAVw48M5XKlASVMjCVOe6vlKcoM1MT
        /A+lpVSDqW/R7jTH1oKn78f8WwBGghaASFzmLnm4I0shlSjkJ04ybFo8m5nMKFvAfJKQeUqk
        4YXxUpggz2COMEw6w/5TMVLopcaWB4h/aO1tm4f3ta6J04/sTBkd3HLPORITY3jp/sziMdKq
        smHlA+O8+ia6/2sTqxILzna6jeWLh65Eecfsl1izz2936I7b2yNMoUeEExeztpJRbmiyr9UP
        sLECM3gyvlunlk/8HM26GlmxLtC3d9aa34a0jHuJhbnL8keqTPY8RfdagbevldVFhx0tM/N6
        xiPn1JVt8Tr9GnvgzLKE1VmwT48uXYcLHMU3l0f/KVafEWmC9lpXG0d9hgvuIyMUa6rOhSwU
        ie+m7VIL3/mIiw4b8hq0nyJCw1Y4tLMTKoPDe4JvTG76cj9xT8ABNxhdn/0qRBdk0qpexVqF
        2etkhDJRHuiHs0r5X69TbJyFAwAA
X-CMS-MailID: 20230605175120uscas1p133d49fa845805bda83677dd29cdf7c1e
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
        <20230511175609.2091136-1-fan.ni@samsung.com>
        <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jun 05, 2023 at 10:35:48AM -0700, Ira Weiny wrote:
> Fan Ni wrote:
> > Since the early draft of DCD support in kernel is out
> > (https://urldefense.com/v3/__https://lore.kernel.org/linux-cxl/20230417=
164126.GA1904906@bgt-140510-bm03/T/*t__;Iw!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcSiG=
sqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21LzAGNOk$ =
),
> > this patch series provide dcd emulation in qemu so people who are inter=
ested
> > can have an early try. It is noted that the patch series may need to be=
 updated
> > accordingly if the kernel side implementation changes.
>=20
> Fan,
>=20
> Do you have a git tree we can pull this from which is updated to a more
> recent CXL branch from Jonathan?
>=20
> Thanks,
> Ira

Hi Ira,

I have a git tree of the patch series based on Jonathan's branch
cxl-2023-02-28: https://github.com/moking/qemu-dev/tree/dcd-rfe.

That may be not new enough to include some of the recent patches, but I can
rebase it to a newer branch if you can tell me which branch you want to use=
.

Thanks,
Fan

>=20
> >=20
> > To support DCD emulation, the patch series add DCD related mailbox comm=
and
> > support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3 memory devi=
ce
> > with dynamic capacity extent and region representative.
> > To support read/write to the dynamic capacity of the device, a host bac=
kend
> > is provided and necessary check mechnism is added to ensure the dynamic
> > capacity accessed is backed with active dc extents.
> > Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is not su=
pported
> > , but we add two qmp interfaces for adding/releasing dynamic capacity e=
xtents.
> > Also, the support for multiple hosts sharing the same DCD case is missi=
ng.
> >=20
> > Things we can try with the patch series together with kernel dcd code:
> > 1. Create DC regions to cover the address range of the dynamic capacity
> > regions.
> > 2. Add/release dynamic capacity extents to the device and notify the
> > kernel.
> > 3. Test kernel side code to accept added dc extents and create dax devi=
ces,
> > and release dc extents and notify the device
> > 4. Online the memory range backed with dc extents and let application u=
se
> > them.
> >=20
> > The patch series is based on Jonathan's local qemu branch:
> > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-20=
23-02-28__;!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFd=
wKFhAujXuFDxjymmpCdOu7SLr61rww7lr21OO3UHEM$=20
> >=20
> > Simple tests peformed with the patch series:
> > 1 Install cxl modules:
> >=20
> > modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
> >=20
> > 2 Create dc regions:
> >=20
> > region=3D$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> > echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> > echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> > echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode
> > echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> > echo 0x10000000 > /sys/bus/cxl/devices/$region/size
> > echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> > echo 1 > /sys/bus/cxl/devices/$region/commit
> > echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> >=20
> > /home/fan/cxl/tools-and-scripts# cxl list
> > [
> >   {
> >     "memdevs":[
> >       {
> >         "memdev":"mem0",
> >         "pmem_size":536870912,
> >         "ram_size":0,
> >         "serial":0,
> >         "host":"0000:0d:00.0"
> >       }
> >     ]
> >   },
> >   {
> >     "regions":[
> >       {
> >         "region":"region0",
> >         "resource":45365592064,
> >         "size":268435456,
> >         "interleave_ways":1,
> >         "interleave_granularity":256,
> >         "decode_state":"commit"
> >       }
> >     ]
> >   }
> > ]
> >=20
> > 3 Add two dc extents (128MB each) through qmp interface
> >=20
> > { "execute": "qmp_capabilities" }
> >=20
> > { "execute": "cxl-add-dynamic-capacity-event",
> > 	"arguments": {
> > 		 "path": "/machine/peripheral/cxl-pmem0",
> > 		"region-id" : 0,
> > 		 "num-extent": 2,
> > 		"dpa":0,
> > 		"extent-len": 128
> > 	}
> > }
> >=20
> > /home/fan/cxl/tools-and-scripts# lsmem
> > RANGE                                  SIZE   STATE REMOVABLE   BLOCK
> > 0x0000000000000000-0x000000007fffffff    2G  online       yes    0-15
> > 0x0000000100000000-0x000000027fffffff    6G  online       yes   32-79
> > 0x0000000a90000000-0x0000000a9fffffff  256M offline           338-339
> >=20
> > Memory block size:       128M
> > Total online memory:       8G
> > Total offline memory:    256M
> >=20
> >=20
> > 4.Online the momory with 'daxctl online-memory dax0.0' to online the me=
mory
> >=20
> > /home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0
> > [  230.730553] Fallback order for Node 0: 0 1
> > [  230.730825] Fallback order for Node 1: 1 0
> > [  230.730953] Built 2 zonelists, mobility grouping on.  Total pages: 2=
042541
> > [  230.731110] Policy zone: Normal
> > onlined memory for 1 device
> >=20
> > root@bgt-140510-bm03:/home/fan/cxl/ndctl# lsmem
> > RANGE                                  SIZE   STATE REMOVABLE BLOCK
> > 0x0000000000000000-0x000000007fffffff    2G  online       yes  0-15
> > 0x0000000100000000-0x000000027fffffff    6G  online       yes 32-79
> > 0x0000000a90000000-0x0000000a97ffffff  128M  online       yes   338
> > 0x0000000a98000000-0x0000000a9fffffff  128M offline             339
> >=20
> > Memory block size:       128M
> > Total online memory:     8.1G
> > Total offline memory:    128M
> >=20
> > 5 using dc extents as regular memory
> >=20
> > /home/fan/cxl/ndctl# numactl --membind=3D1 ls
> > CONTRIBUTING.md  README.md  clean_config.sh  cscope.out   git-version-g=
en
> > ndctl	       scripts	test.h      version.h.in COPYING		 acpi.h
> > config.h.meson   cxl	  make-git-snapshot.sh	ndctl.spec.in  sles	tools
> > Documentation	 build	    contrib	     daxctl	  meson.build		rhel
> > tags	topology.png LICENSES	 ccan	    cscope.files
> > git-version  meson_options.txt	rpmbuild.sh    test	util
> >=20
> >=20
> > QEMU command line cxl configuration:
> >=20
> > RP1=3D"-object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D=
/tmp/cxltest.raw,size=3D512M \
> > -object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tmp/cx=
ltest2.raw,size=3D512M \
> > -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/ls=
a.raw,size=3D512M \
> > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \
> > -device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,dc=
-memdev=3Dcxl-mem2,id=3Dcxl-pmem0,num-dc-regions=3D1\
> > -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interleave=
-granularity=3D8k"
> >=20
> >=20
> > Kernel DCD support used to test the changes
> >=20
> > The code is tested with the posted kernel dcd support:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel=
/git/cxl/cxl.git/log/?h=3Dfor-6.5*dcd-preview__;Lw!!EwVzqGoTKBqv-0DWAJBm!RH=
zXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21q=
5Iza3M$=20
> >=20
> > commit: f425bc34c600e2a3721d6560202962ec41622815
> >=20
> > To make the test work, we have made the following changes to the above =
kernel commit:
> >=20
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 5f04bbc18af5..5f421d3c5cef 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_ME=
M_COMMAND_ID_MAX] =3D {
> >  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> >  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> >  	CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> > +	CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),
> >  };
> > =20
> >  /*
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 291c716abd49..ae10e3cf43a1 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_region *=
cxlr)
> >  		}
> >  		cxlds->dc_list_gen_num =3D extent_gen_num;
> >  		dev_dbg(cxlds->dev, "No of preallocated extents :%d\n", rc);
> > -		enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);
> > +		/*enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);*/
> >  	}
> >  	return 0;
> >  err:
> > @@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *cxlds=
, struct resource *alloc_dpa_re
> >  				dev_dax->align, memremap_compat_align()))) {
> >  		rc =3D alloc_dev_dax_range(dev_dax, hpa,
> >  					resource_size(alloc_dpa_res));
> > -		return rc;
> > +		if (rc)
> > +			return rc;
> >  	}
> > =20
> >  	rc =3D xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax, GFP_KERNEL);
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 9e45b1056022..653bec203838 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_state =
*cxlds)
> > =20
> >  	/* Driver enables DCD interrupt after creating the dc cxl_region */
> >  	rc =3D cxl_event_req_irq(cxlds, policy.dyncap_settings, CXL_EVENT_TYP=
E_DCD,
> > -					IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_AUTOEN);
> > +					IRQF_SHARED | IRQF_ONESHOT);
> >  	if (rc) {
> >  		dev_err(cxlds->dev, "Failed to get interrupt for event dc log\n");
> >  		return rc;
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.=
h
> > index 6ca85861750c..910a48259239 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -47,6 +47,7 @@
> >  	___C(SCAN_MEDIA, "Scan Media"),                                   \
> >  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
> >  	___C(GET_DC_EXTENT_LIST, "Get dynamic capacity extents"),         \
> > +	___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),         \
> >  	___C(MAX, "invalid / last command")
> > =20
> >  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> >=20
> >=20
> >=20
> > Fan Ni (7):
> >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> >     payload of identify memory device command
> >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> >     and mailbox command support
> >   hw/mem/cxl_type3: Add a parameter to pass number of DC regions the
> >     device supports in qemu command line
> >   hw/mem/cxl_type3: Add DC extent representative to cxl type3 device
> >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> >     dynamic capacity response
> >   Add qmp interfaces to add/release dynamic capacity extents
> >   hw/mem/cxl_type3: add read/write support to dynamic capacity
> >=20
> >  hw/cxl/cxl-mailbox-utils.c  | 389 +++++++++++++++++++++++++++-
> >  hw/mem/cxl_type3.c          | 492 +++++++++++++++++++++++++++++++-----
> >  include/hw/cxl/cxl_device.h |  50 +++-
> >  include/hw/cxl/cxl_events.h |  16 ++
> >  qapi/cxl.json               |  44 ++++
> >  5 files changed, 924 insertions(+), 67 deletions(-)
> >=20
> > --=20
> > 2.25.1
>=20
> =
