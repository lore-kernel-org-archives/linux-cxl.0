Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB42C77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 18:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbjEKSFW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 14:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbjEKSFU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 14:05:20 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA68C1BF8
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 11:04:50 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230511175641usoutp0272e0e37d55a27172c52c276d6005d446~eKHbdH2uV2433724337usoutp02T;
        Thu, 11 May 2023 17:56:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230511175641usoutp0272e0e37d55a27172c52c276d6005d446~eKHbdH2uV2433724337usoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683827801;
        bh=oqlYCvn41HPxLDqiATSn+WDpTfWwMYBrNJiG5XMLHV4=;
        h=From:To:CC:Subject:Date:References:From;
        b=lF2J8dJvakD5KpBdxpIq2b7lKU4b6FXAXCMxV2FKCJff17UM5BtvqYWBEh6Q+ck6B
         SW6sZ2j+PRoaRYV6po6uV1JpGrSn8JC0OmMYZILU0JbxsJsVVyU1YiIOWaPvlphRTR
         Y1DRrxgkivK+qKv5QBxCjvY2dJTgcKIdT/wvCimI=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230511175641uscas1p203375f8025adf3dbbc7ba067098f3c31~eKHbSxuJv1429314293uscas1p2f;
        Thu, 11 May 2023 17:56:41 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id AD.8A.19925.95C2D546; Thu,
        11 May 2023 13:56:41 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c~eKHa4Lush2038820388uscas1p2f;
        Thu, 11 May 2023 17:56:41 +0000 (GMT)
X-AuditID: cbfec36d-975ff70000004dd5-82-645d2c59067d
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 19.48.64580.85C2D546; Thu,
        11 May 2023 13:56:40 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 11 May 2023 10:56:40 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        11 May 2023 10:56:40 -0700
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
        "nifan@outlook.com" <nifan@outlook.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Topic: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Index: AQHZhDHwBF2t8l6CHEO7jqFQqFgBOA==
Date:   Thu, 11 May 2023 17:56:40 +0000
Message-ID: <20230511175609.2091136-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djX87qROrEpBstXS1p0n9/AaDF96gVG
        i9U31zBaNDQ9YrFo2f2eyWL/0+csFqsWXmOzOD/rFIvF84nPmSyWLnnEbHG8dweLA7fHhckT
        WD0WN7h67Jx1l92j5chbIG/PSyaPjR//s3s8ubaZyWPz6xfMHlNn13t83iQXwBXFZZOSmpNZ
        llqkb5fAlXFi/l6WghWeFb8/djE1MM627mLk5JAQMJFYdXM9O4gtJLCSUaJ9dy2E3cok0XIo
        AKbm25L1rBDxtYwST594dzFyAdmfGCWuzdrDDuEsY5T4u/AuG0gVm4CixL6u7WC2iICxxLHD
        S5hBipgF3rJIfFzzhgUkISxgLzF5yjnGLkYOoCIXiUvP/CBMPYlznzxBKlgEVCXO3djBCGLz
        ClhKbH7zDWwko4CYxPdTa5hAbGYBcYlbT+YzQRwqKLFo9h5mCFtM4t+uh2wQtrzE5B8zoGxF
        ifvfX7JD9OpJ3Jg6hQ3C1pZYtvA1M8QuQYmTM5+wQNRLShxccYMF5HwJgS8cEnOmtrBCJFwk
        vq3+C7VYWmL6msssIPdLCCRLrPrIBRHOkZi/ZAvUHGuJhX/WQ93MJ/H31yPGCYzKs5C8MAvJ
        SbOQnDQLyUkLGFlWMYqXFhfnpqcWG+allusVJ+YWl+al6yXn525iBKa10/8O5+5g3HHro94h
        RiYOxkOMEhzMSiK8b5dEpwjxpiRWVqUW5ccXleakFh9ilOZgURLnNbQ9mSwkkJ5YkpqdmlqQ
        WgSTZeLglGpgck+R4XixiyuyrkxFX2+Zf4D35udrjn/W9FbhnvB3oWk3i5+ieUkln6PBx1Kn
        dSf+cQXO+1RRv613Ofu2nqaTXVcv7jlbPsfouXV96+dZLYUtbLYROpfffH1memjnA9ufFiXr
        dF2FLGd+XpZTsXib+m1TBmP/987RM2OWno4r9X2f+E7SWD725bHn4dNDp5ca9Ykf0y3wfvm4
        ss1UcY60VcH6+vdPxV/wMdyUTKjb9uHYdv95uYv1pTbnHj3qITantVrzY90p+X8NXlbZsz5d
        avz44/FJd8OOu037G0784Xkta7ut1mFBXNeSCW+/KJbP57kULGPz/83jJlFXucvrfj6c7jP7
        3e1/9fmVDSenKLEUZyQaajEXFScCAP8F+U3aAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWS2cA0STdCJzbFYHKrhUX3+Q2MFtOnXmC0
        WH1zDaNFQ9MjFouW3e+ZLPY/fc5isWrhNTaL87NOsVg8n/icyWLpkkfMFsd7d7A4cHtcmDyB
        1WNxg6vHzll32T1ajrwF8va8ZPLY+PE/u8eTa5uZPDa/fsHsMXV2vcfnTXIBXFFcNimpOZll
        qUX6dglcGSfm72UpWOFZ8ftjF1MD42zrLkZODgkBE4lvS9azdjFycQgJrGaU+PXmIBOE84lR
        4uP982wQzjJGic2TuxhBWtgEFCX2dW1nA7FFBIwljh1ewgxiMwu8ZpH4dpEbxBYWsJeYPOUc
        UD0HUI2LxKVnfhCmnsS5T54gFSwCqhLnbuwAm8grYCmx+c03sImMAmIS30+tYYKYKC5x68l8
        JohDBSSW7DnPDGGLSrx8/I8VwpaXmPxjBhuErShx//tLdohePYkbU6ewQdjaEssWvmaG2CUo
        cXLmExaIekmJgytusExgFJuFZN0sJO2zkLTPQtK+gJFlFaN4aXFxbnpFsXFearlecWJucWle
        ul5yfu4mRmCcn/53OGYH471bH/UOMTJxMB5ilOBgVhLhfbskOkWINyWxsiq1KD++qDQntfgQ
        ozQHi5I4r0fsxHghgfTEktTs1NSC1CKYLBMHp1QDk+DF4GL+tN5m+aObc/T2LBFPEd3qpmHy
        7uJ9FwdLFV+X4zv+dTzhCryeoOleKSP24TrzgsPH5U9HdFw7f6B0zZWwFTkezlw9auLm+m+i
        zLiiTGd7TJjGFXjtsoO83uHGqLf2bxktzicZlv9KXWdvMmn7TLGr371WtnFpZ5bxzJvT8GXV
        8tTb7HO17vyueLpl7ZFFbqu+iBtw2TtdPtmekeb5qHid2LtcOe+spnmntEx7kmb/aTwiGV/+
        tOSK6ecjObs5Hi2Kny1rtyT7WXeVmqSVmpTgM884t3XV3pZ8vSJlGctvngnTvMgf8MVEs2zO
        Zps3hpk3Xp0tK5Xf8cc89szPv9ePLjo66Z/juqUcSizFGYmGWsxFxYkAXZQDvGIDAAA=
X-CMS-MailID: 20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Since the early draft of DCD support in kernel is out
(https://lore.kernel.org/linux-cxl/20230417164126.GA1904906@bgt-140510-bm03=
/T/#t),
this patch series provide dcd emulation in qemu so people who are intereste=
d
can have an early try. It is noted that the patch series may need to be upd=
ated
accordingly if the kernel side implementation changes.

To support DCD emulation, the patch series add DCD related mailbox command
support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3 memory device
with dynamic capacity extent and region representative.
To support read/write to the dynamic capacity of the device, a host backend
is provided and necessary check mechnism is added to ensure the dynamic
capacity accessed is backed with active dc extents.
Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is not suppor=
ted
, but we add two qmp interfaces for adding/releasing dynamic capacity exten=
ts.
Also, the support for multiple hosts sharing the same DCD case is missing.

Things we can try with the patch series together with kernel dcd code:
1. Create DC regions to cover the address range of the dynamic capacity
regions.
2. Add/release dynamic capacity extents to the device and notify the
kernel.
3. Test kernel side code to accept added dc extents and create dax devices,
and release dc extents and notify the device
4. Online the memory range backed with dc extents and let application use
them.

The patch series is based on Jonathan's local qemu branch:
https://gitlab.com/jic23/qemu/-/tree/cxl-2023-02-28

Simple tests peformed with the patch series:
1 Install cxl modules:

modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem

2 Create dc regions:

region=3D$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode
echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
echo 0x10000000 > /sys/bus/cxl/devices/$region/size
echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
echo 1 > /sys/bus/cxl/devices/$region/commit
echo $region > /sys/bus/cxl/drivers/cxl_region/bind

/home/fan/cxl/tools-and-scripts# cxl list
[
  {
    "memdevs":[
      {
        "memdev":"mem0",
        "pmem_size":536870912,
        "ram_size":0,
        "serial":0,
        "host":"0000:0d:00.0"
      }
    ]
  },
  {
    "regions":[
      {
        "region":"region0",
        "resource":45365592064,
        "size":268435456,
        "interleave_ways":1,
        "interleave_granularity":256,
        "decode_state":"commit"
      }
    ]
  }
]

3 Add two dc extents (128MB each) through qmp interface

{ "execute": "qmp_capabilities" }

{ "execute": "cxl-add-dynamic-capacity-event",
	"arguments": {
		 "path": "/machine/peripheral/cxl-pmem0",
		"region-id" : 0,
		 "num-extent": 2,
		"dpa":0,
		"extent-len": 128
	}
}

/home/fan/cxl/tools-and-scripts# lsmem
RANGE                                  SIZE   STATE REMOVABLE   BLOCK
0x0000000000000000-0x000000007fffffff    2G  online       yes    0-15
0x0000000100000000-0x000000027fffffff    6G  online       yes   32-79
0x0000000a90000000-0x0000000a9fffffff  256M offline           338-339

Memory block size:       128M
Total online memory:       8G
Total offline memory:    256M


4.Online the momory with 'daxctl online-memory dax0.0' to online the memory

/home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0
[  230.730553] Fallback order for Node 0: 0 1
[  230.730825] Fallback order for Node 1: 1 0
[  230.730953] Built 2 zonelists, mobility grouping on.  Total pages: 20425=
41
[  230.731110] Policy zone: Normal
onlined memory for 1 device

root@bgt-140510-bm03:/home/fan/cxl/ndctl# lsmem
RANGE                                  SIZE   STATE REMOVABLE BLOCK
0x0000000000000000-0x000000007fffffff    2G  online       yes  0-15
0x0000000100000000-0x000000027fffffff    6G  online       yes 32-79
0x0000000a90000000-0x0000000a97ffffff  128M  online       yes   338
0x0000000a98000000-0x0000000a9fffffff  128M offline             339

Memory block size:       128M
Total online memory:     8.1G
Total offline memory:    128M

5 using dc extents as regular memory

/home/fan/cxl/ndctl# numactl --membind=3D1 ls
CONTRIBUTING.md  README.md  clean_config.sh  cscope.out   git-version-gen
ndctl	       scripts	test.h      version.h.in COPYING		 acpi.h
config.h.meson   cxl	  make-git-snapshot.sh	ndctl.spec.in  sles	tools
Documentation	 build	    contrib	     daxctl	  meson.build		rhel
tags	topology.png LICENSES	 ccan	    cscope.files
git-version  meson_options.txt	rpmbuild.sh    test	util


QEMU command line cxl configuration:

RP1=3D"-object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/tmp=
/cxltest.raw,size=3D512M \
-object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tmp/cxltes=
t2.raw,size=3D512M \
-object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/lsa.ra=
w,size=3D512M \
-device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
-device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=3D2 \
-device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,dc-mem=
dev=3Dcxl-mem2,id=3Dcxl-pmem0,num-dc-regions=3D1\
-M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interleave-gra=
nularity=3D8k"


Kernel DCD support used to test the changes

The code is tested with the posted kernel dcd support:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=3Dfor-6.=
5/dcd-preview

commit: f425bc34c600e2a3721d6560202962ec41622815

To make the test work, we have made the following changes to the above kern=
el commit:

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5f04bbc18af5..5f421d3c5cef 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_CO=
MMAND_ID_MAX] =3D {
 	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),
 };
=20
 /*
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 291c716abd49..ae10e3cf43a1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_region *cxlr=
)
 		}
 		cxlds->dc_list_gen_num =3D extent_gen_num;
 		dev_dbg(cxlds->dev, "No of preallocated extents :%d\n", rc);
-		enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);
+		/*enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);*/
 	}
 	return 0;
 err:
@@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *cxlds, st=
ruct resource *alloc_dpa_re
 				dev_dax->align, memremap_compat_align()))) {
 		rc =3D alloc_dev_dax_range(dev_dax, hpa,
 					resource_size(alloc_dpa_res));
-		return rc;
+		if (rc)
+			return rc;
 	}
=20
 	rc =3D xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax, GFP_KERNEL);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9e45b1056022..653bec203838 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_state *cxl=
ds)
=20
 	/* Driver enables DCD interrupt after creating the dc cxl_region */
 	rc =3D cxl_event_req_irq(cxlds, policy.dyncap_settings, CXL_EVENT_TYPE_DC=
D,
-					IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_AUTOEN);
+					IRQF_SHARED | IRQF_ONESHOT);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event dc log\n");
 		return rc;
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 6ca85861750c..910a48259239 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -47,6 +47,7 @@
 	___C(SCAN_MEDIA, "Scan Media"),                                   \
 	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
 	___C(GET_DC_EXTENT_LIST, "Get dynamic capacity extents"),         \
+	___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),         \
 	___C(MAX, "invalid / last command")
=20
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a



Fan Ni (7):
  hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
    payload of identify memory device command
  hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
    and mailbox command support
  hw/mem/cxl_type3: Add a parameter to pass number of DC regions the
    device supports in qemu command line
  hw/mem/cxl_type3: Add DC extent representative to cxl type3 device
  hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
    dynamic capacity response
  Add qmp interfaces to add/release dynamic capacity extents
  hw/mem/cxl_type3: add read/write support to dynamic capacity

 hw/cxl/cxl-mailbox-utils.c  | 389 +++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 492 +++++++++++++++++++++++++++++++-----
 include/hw/cxl/cxl_device.h |  50 +++-
 include/hw/cxl/cxl_events.h |  16 ++
 qapi/cxl.json               |  44 ++++
 5 files changed, 924 insertions(+), 67 deletions(-)

--=20
2.25.1
