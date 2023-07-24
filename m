Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D4FC001DF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 17:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjGXRTL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 13:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGXRTL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 13:19:11 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEC810D3
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 10:19:06 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230724171905usoutp029528fc3c6d183896a8edf808d5d4cf04~03VuqSLFX3140831408usoutp02X;
        Mon, 24 Jul 2023 17:19:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230724171905usoutp029528fc3c6d183896a8edf808d5d4cf04~03VuqSLFX3140831408usoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690219145;
        bh=lZyVShsjPJVPM/4YGJCxVmKNwI7mtfbiTtJ5Qj2zoU0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=BKKZdTj3eqy4LjGs6bDSJK0NzbMNQjXyE/ykIVtyj87Ezkeo2geaCFN4ahXi+QioG
         ea0d1La++UNFX4YptRDxlAeipF4f/24T8kO3DI1vf3P2qraWhSOnvHoJ88zMtwl10F
         0al5rRLNrBYPmscPMjhXLnSpSSj7rS8ZoSCshv3o=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230724171905uscas1p11a44fee7787624d948caaa8f7191105e~03VugyMHp0195801958uscas1p1F;
        Mon, 24 Jul 2023 17:19:05 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 7E.8D.51475.982BEB46; Mon,
        24 Jul 2023 13:19:05 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230724171905uscas1p13205f49a68ec261a7d8872ccbff873aa~03VuLrqbb1467114671uscas1p1J;
        Mon, 24 Jul 2023 17:19:05 +0000 (GMT)
X-AuditID: cbfec36d-635ff7000001c913-61-64beb289ac75
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 72.F2.64580.982BEB46; Mon,
        24 Jul 2023 13:19:05 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 24 Jul 2023 10:19:04 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        24 Jul 2023 10:19:04 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Topic: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Index: AQHZhDHwBF2t8l6CHEO7jqFQqFgBOK/KEtMA
Date:   Mon, 24 Jul 2023 17:19:04 +0000
Message-ID: <20230724171857.GA329893@bgt-140510-bm03>
In-Reply-To: <20230511175609.2091136-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B8894DAF8EF9E43AD05BC3EE7BA4FCB@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djX87qdm/alGDTP1rToPr+B0WL61AuM
        FqtvrmG0aGh6xGLRsvs9k8X+p89ZLFYtvMZmcX7WKRaL5xOfM1ksXfKI2eJ47w4WB26PC5Mn
        sHosbnD12DnrLrtHy5G3QN6el0weGz/+Z/d4cm0zk8fm1y+YPabOrvf4vEkugCuKyyYlNSez
        LLVI3y6BK2P+6inMBXsCK/6ftm1g/O3QxcjJISFgIrFlzVemLkYuDiGBlYwSWycsYYZwWpkk
        7j6YxtLFyAFW1dLoDxFfyyjR2nKTFcL5xCjx8t98RpBRQgLLGCU2TbUGsdkEFCX2dW1nA7FF
        BIwljh2GmMoscI5F4szTD6wgCWEBZ4nJy08wgmwQEXCRuPTMD6LeSGLXzsssIDaLgKrEo2tT
        mUFsXgFTiRmT1oHt4hSwktjQfIIJxGYUEJP4fmoNmM0sIC5x68l8JojXBCUWzd7DDGGLSfzb
        9ZANwlaUuP/9JTtEvY7Egt2f2EBOYBawk5j/tRYirC2xbOFrqLWCEidnPmGBaJWUOLjiBgvI
        KxIC8zklru9fBg0gF4n2I9oQNdIS09dchgonS6z6yAURzpGYv2QL1BhriYV/1jNNYFSZheTo
        WUgOmoVw0CwkB81CctACRtZVjOKlxcW56anFhnmp5XrFibnFpXnpesn5uZsYganu9L/DuTsY
        d9z6qHeIkYmD8RCjBAezkgivYcy+FCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8hrYnk4UE0hNL
        UrNTUwtSi2CyTBycUg1MGc//3rTeaFSi/Efa8qjVllmv/e5G3lm6WNHk6j7JJFY5O32FV3Yq
        /5ZNCny6d/Gy4szlq57KLg8qPN4XdGGLms33g+KnqyK1LdZ43PH4M/WL3tarqzsLM2ZtPvhh
        4wcfrTirJhvpDxN4JY9ekhY/t2vthSOeDzxzfUIu9LYVq+1hcprLyHrix6blS67PSO/evqFw
        8eoAPwVFYeGZ2ZUJVuwrrv07vMjT62RvwNt5xoUnLumt/edlte6F5cqQ+/YTvJbwubQvrjqR
        eTtDQNqMufuf8LYelX2VileO/9UwND467RGLQPBBu5LpDVs3urk0Bc+fxSPFKnLs4I3lW37M
        e+L485lKupK0odz/8v3ntJVYijMSDbWYi4oTAfhNw2nkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWS2cA0Ubdz074Ug4NNQhbd5zcwWkyfeoHR
        YvXNNYwWDU2PWCxadr9nstj/9DmLxaqF19gszs86xWLxfOJzJoulSx4xWxzv3cHiwO1xYfIE
        Vo/FDa4eO2fdZfdoOfIWyNvzkslj48f/7B5Prm1m8tj8+gWzx9TZ9R6fN8kFcEVx2aSk5mSW
        pRbp2yVwZcxfPYW5YE9gxf/Ttg2Mvx26GDk4JARMJFoa/bsYuTiEBFYzSvSt7WaBcD4xStw9
        vZsNwlnGKPH8/BWmLkZODjYBRYl9XdvZQGwRAWOJY4eXMIMUMQucY5E4P7kDLCEs4CwxefkJ
        RpAVIgIuEpee+UHUG0ns2nmZBcRmEVCVeHRtKjOIzStgKjFj0jpGiGW9jBL/l3YxgiQ4Bawk
        NjSfAFvMKCAm8f3UGjCbWUBc4taT+WC2hICAxJI955khbFGJl4//sULYihL3v79kh6jXkViw
        +xMbyD3MAnYS87/WQoS1JZYtfA11g6DEyZlPWCBaJSUOrrjBMoFRYhaSbbOQTJqFMGkWkkmz
        kExawMi6ilG8tLg4N72i2DgvtVyvODG3uDQvXS85P3cTIzBZnP53OGYH471bH/UOMTJxMB5i
        lOBgVhLhNYzZlyLEm5JYWZValB9fVJqTWnyIUZqDRUmc1yN2YryQQHpiSWp2ampBahFMlomD
        U6qB6dyc+xW5oc6v131dcdjJ71WA1tfulx9uOGb+2dK0q27TrOddJffuzOWZuDpc+0/eAe5/
        J8weLhPUNN/hExieVnKzvyfyh2Jn0cfFa+4pH2iRM+CRsU1ctvnm6TXiLyTe7sx8w214QvqU
        a4/mrrsbTwa5hwrwZosZxTwyMp8+cea7ExcN5+/tP2i2Q+vdxhs9bcmJfN9Unzxep8OsftP9
        7+kdn0Kn/024EvjAL/S+Vbiczh9lVv1nurJtXUuuVTh+fzVr0ue/r3unmv+PWXLu4/6+TXcX
        6+9ZI6mY/czvVsbrFzLbn/7lq2U8V3/d/dv2k7e25J4t3rJayvYJUxhrQvz6SMPQqQ8E2r+U
        FCS8/rBYiaU4I9FQi7moOBEAX3UwEoUDAAA=
X-CMS-MailID: 20230724171905uscas1p13205f49a68ec261a7d8872ccbff873aa
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
        <20230511175609.2091136-1-fan.ni@samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, May 11, 2023 at 05:56:40PM +0000, Fan Ni wrote:

FYI.

I have updated the patch series and sent out again.

I suggested anyone who are interested in DCD and using this patch series to
use the new series. Quite a few things has been fixed.

https://lore.kernel.org/linux-cxl/20230724162313.34196-1-fan.ni@samsung.com=
/T/#t

Also, if you want to use the code repo directly, you can try

https://github.com/moking/qemu-dcd-preview-latest/tree/dcd-dev

Fan


> Since the early draft of DCD support in kernel is out
> (https://lore.kernel.org/linux-cxl/20230417164126.GA1904906@bgt-140510-bm=
03/T/#t),
> this patch series provide dcd emulation in qemu so people who are interes=
ted
> can have an early try. It is noted that the patch series may need to be u=
pdated
> accordingly if the kernel side implementation changes.
>=20
> To support DCD emulation, the patch series add DCD related mailbox comman=
d
> support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3 memory device
> with dynamic capacity extent and region representative.
> To support read/write to the dynamic capacity of the device, a host backe=
nd
> is provided and necessary check mechnism is added to ensure the dynamic
> capacity accessed is backed with active dc extents.
> Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is not supp=
orted
> , but we add two qmp interfaces for adding/releasing dynamic capacity ext=
ents.
> Also, the support for multiple hosts sharing the same DCD case is missing=
.
>=20
> Things we can try with the patch series together with kernel dcd code:
> 1. Create DC regions to cover the address range of the dynamic capacity
> regions.
> 2. Add/release dynamic capacity extents to the device and notify the
> kernel.
> 3. Test kernel side code to accept added dc extents and create dax device=
s,
> and release dc extents and notify the device
> 4. Online the memory range backed with dc extents and let application use
> them.
>=20
> The patch series is based on Jonathan's local qemu branch:
> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-02-28
>=20
> Simple tests peformed with the patch series:
> 1 Install cxl modules:
>=20
> modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
>=20
> 2 Create dc regions:
>=20
> region=3D$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode
> echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> echo 0x10000000 > /sys/bus/cxl/devices/$region/size
> echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> echo 1 > /sys/bus/cxl/devices/$region/commit
> echo $region > /sys/bus/cxl/drivers/cxl_region/bind
>=20
> /home/fan/cxl/tools-and-scripts# cxl list
> [
>   {
>     "memdevs":[
>       {
>         "memdev":"mem0",
>         "pmem_size":536870912,
>         "ram_size":0,
>         "serial":0,
>         "host":"0000:0d:00.0"
>       }
>     ]
>   },
>   {
>     "regions":[
>       {
>         "region":"region0",
>         "resource":45365592064,
>         "size":268435456,
>         "interleave_ways":1,
>         "interleave_granularity":256,
>         "decode_state":"commit"
>       }
>     ]
>   }
> ]
>=20
> 3 Add two dc extents (128MB each) through qmp interface
>=20
> { "execute": "qmp_capabilities" }
>=20
> { "execute": "cxl-add-dynamic-capacity-event",
> 	"arguments": {
> 		 "path": "/machine/peripheral/cxl-pmem0",
> 		"region-id" : 0,
> 		 "num-extent": 2,
> 		"dpa":0,
> 		"extent-len": 128
> 	}
> }
>=20
> /home/fan/cxl/tools-and-scripts# lsmem
> RANGE                                  SIZE   STATE REMOVABLE   BLOCK
> 0x0000000000000000-0x000000007fffffff    2G  online       yes    0-15
> 0x0000000100000000-0x000000027fffffff    6G  online       yes   32-79
> 0x0000000a90000000-0x0000000a9fffffff  256M offline           338-339
>=20
> Memory block size:       128M
> Total online memory:       8G
> Total offline memory:    256M
>=20
>=20
> 4.Online the momory with 'daxctl online-memory dax0.0' to online the memo=
ry
>=20
> /home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0
> [  230.730553] Fallback order for Node 0: 0 1
> [  230.730825] Fallback order for Node 1: 1 0
> [  230.730953] Built 2 zonelists, mobility grouping on.  Total pages: 204=
2541
> [  230.731110] Policy zone: Normal
> onlined memory for 1 device
>=20
> root@bgt-140510-bm03:/home/fan/cxl/ndctl# lsmem
> RANGE                                  SIZE   STATE REMOVABLE BLOCK
> 0x0000000000000000-0x000000007fffffff    2G  online       yes  0-15
> 0x0000000100000000-0x000000027fffffff    6G  online       yes 32-79
> 0x0000000a90000000-0x0000000a97ffffff  128M  online       yes   338
> 0x0000000a98000000-0x0000000a9fffffff  128M offline             339
>=20
> Memory block size:       128M
> Total online memory:     8.1G
> Total offline memory:    128M
>=20
> 5 using dc extents as regular memory
>=20
> /home/fan/cxl/ndctl# numactl --membind=3D1 ls
> CONTRIBUTING.md  README.md  clean_config.sh  cscope.out   git-version-gen
> ndctl	       scripts	test.h      version.h.in COPYING		 acpi.h
> config.h.meson   cxl	  make-git-snapshot.sh	ndctl.spec.in  sles	tools
> Documentation	 build	    contrib	     daxctl	  meson.build		rhel
> tags	topology.png LICENSES	 ccan	    cscope.files
> git-version  meson_options.txt	rpmbuild.sh    test	util
>=20
>=20
> QEMU command line cxl configuration:
>=20
> RP1=3D"-object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/t=
mp/cxltest.raw,size=3D512M \
> -object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tmp/cxlt=
est2.raw,size=3D512M \
> -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/lsa.=
raw,size=3D512M \
> -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=3D2=
 \
> -device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,dc-m=
emdev=3Dcxl-mem2,id=3Dcxl-pmem0,num-dc-regions=3D1\
> -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interleave-g=
ranularity=3D8k"
>=20
>=20
> Kernel DCD support used to test the changes
>=20
> The code is tested with the posted kernel dcd support:
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=3Dfor-=
6.5/dcd-preview
>=20
> commit: f425bc34c600e2a3721d6560202962ec41622815
>=20
> To make the test work, we have made the following changes to the above ke=
rnel commit:
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 5f04bbc18af5..5f421d3c5cef 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_=
COMMAND_ID_MAX] =3D {
>  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
>  	CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),
>  };
> =20
>  /*
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 291c716abd49..ae10e3cf43a1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_region *cx=
lr)
>  		}
>  		cxlds->dc_list_gen_num =3D extent_gen_num;
>  		dev_dbg(cxlds->dev, "No of preallocated extents :%d\n", rc);
> -		enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);
> +		/*enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);*/
>  	}
>  	return 0;
>  err:
> @@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *cxlds, =
struct resource *alloc_dpa_re
>  				dev_dax->align, memremap_compat_align()))) {
>  		rc =3D alloc_dev_dax_range(dev_dax, hpa,
>  					resource_size(alloc_dpa_res));
> -		return rc;
> +		if (rc)
> +			return rc;
>  	}
> =20
>  	rc =3D xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax, GFP_KERNEL);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 9e45b1056022..653bec203838 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_state *c=
xlds)
> =20
>  	/* Driver enables DCD interrupt after creating the dc cxl_region */
>  	rc =3D cxl_event_req_irq(cxlds, policy.dyncap_settings, CXL_EVENT_TYPE_=
DCD,
> -					IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_AUTOEN);
> +					IRQF_SHARED | IRQF_ONESHOT);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event dc log\n");
>  		return rc;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 6ca85861750c..910a48259239 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -47,6 +47,7 @@
>  	___C(SCAN_MEDIA, "Scan Media"),                                   \
>  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
>  	___C(GET_DC_EXTENT_LIST, "Get dynamic capacity extents"),         \
> +	___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),         \
>  	___C(MAX, "invalid / last command")
> =20
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
>=20
>=20
>=20
> Fan Ni (7):
>   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
>     payload of identify memory device command
>   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
>     and mailbox command support
>   hw/mem/cxl_type3: Add a parameter to pass number of DC regions the
>     device supports in qemu command line
>   hw/mem/cxl_type3: Add DC extent representative to cxl type3 device
>   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
>     dynamic capacity response
>   Add qmp interfaces to add/release dynamic capacity extents
>   hw/mem/cxl_type3: add read/write support to dynamic capacity
>=20
>  hw/cxl/cxl-mailbox-utils.c  | 389 +++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 492 +++++++++++++++++++++++++++++++-----
>  include/hw/cxl/cxl_device.h |  50 +++-
>  include/hw/cxl/cxl_events.h |  16 ++
>  qapi/cxl.json               |  44 ++++
>  5 files changed, 924 insertions(+), 67 deletions(-)
>=20
> --=20
> 2.25.1
> =
