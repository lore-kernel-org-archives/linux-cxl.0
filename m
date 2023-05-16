Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11751C77B7A
	for <linux-cxl@archiver.kernel.org>; Tue, 16 May 2023 14:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjEPOj1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEPOj0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 10:39:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C53131
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684247963; x=1715783963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nWu3Ox8VOdN3RmYdX+3yl69Ipyh4ZSTmT9UuTFd98rA=;
  b=MWR33z4zZi2dGhj/TGHrOtCxaFO1pzSTkBbBCWPjB7551ZW1Pc+bDr2r
   HefkvzTSuBaDYYHu1mnl0bXTqpkrU7MYAAl+98A3LK6MUJH1Ef+L77uCn
   Ig2x7xaBcXAlyyS6XsIteGK//8PFXCo539s8kZAiRybd6COPLf8jm95aI
   37u29CYYufN3OY1zmvjaR2hWrBD1hXVFrHUXsnGuO50H98eie9YPx5tgY
   8cWvPme/H/2+9+1MhS4fVD9XZkFKht6opBBXiasObYzH2fhmFsbW/nkc8
   YbJCYjaTTdUSir3cNkTGhAzYXDhePf2niq//rKbBl+ljoVDdleZGXqlXz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="331111299"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="331111299"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 07:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="875646341"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="875646341"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2023 07:39:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 07:39:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 07:39:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 07:39:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 07:39:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehYw0HEd9AkzfjRe4RCHG6pWXhlf3uP19VipyObpjwKCXfcM5Nj/gIwWVeJ5f9cE+wxlF/rctdaTTRzqUWxuER31ZPgGd11CA6SVVhn7Fh7Hn44OszllX7R2UegjyPVFvc5rISg0KE+/29C8CEnstkGAPFmBYynQmTKcChhaOWpgQsFdLxTWlPiWt5akH7aeu9lJcgXpVBRvla6saPX4TsWbQOhLmv4y7x68xhBCeykRWYc57DFBbO9+VMMMC63/DZuhbMC2MX0QUvdlsdsGXKIeKhfzech7JeQBnbxmClf6TpB5ZclHinvP5RE/dtVqb1Hh1mHBK4r6njOlnnAxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4evhmvRKrkE968Q3ujCgpI3pWJ6mbAAwbpDojMb+RQc=;
 b=bI/aUNwHV8di+eQ8sMkzqgDuG/yg+S59YUn4l5gv52NXnAaoo8bf0avUcTUAFNAntd2F2nTbOB0L+JfCXp1PKZpdKbMDlLOAHU4blTmlgvn23Q0u2Q7dlFMtK3+CdjvmO5dnaZPSQzDMPemJQ9wldijct+BIZOGj9N8RXzFkX1x1SMyle98QbuqNNWrK/HObHK6/US8bqAVR6HnpsRYfeDfC2sG9H3EKycKGIXZWi3McZW5RQx4TaqL3Ga6s8Xw1k9YeAWPsVzxUt3ZMiXGPh/596H2CKFefinGFm7h61N1mQ6r4QQsM3Sju/cImLkp/ciY7K+hqbA2Q8M1K2feqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 14:39:16 +0000
Received: from BN9PR11MB5322.namprd11.prod.outlook.com
 ([fe80::f598:71b7:8869:2eae]) by BN9PR11MB5322.namprd11.prod.outlook.com
 ([fe80::f598:71b7:8869:2eae%5]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 14:39:16 +0000
From:   "Singh, Navneet" <navneet.singh@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "Browy, Christopher" <cbrowy@avery-design.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: RE: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Topic: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Index: AQHZhDHwBF2t8l6CHEO7jqFQqFgBOK9bUhcAgAGsJJA=
Date:   Tue, 16 May 2023 14:39:16 +0000
Message-ID: <BN9PR11MB5322075F544ED276667F0C1FF9799@BN9PR11MB5322.namprd11.prod.outlook.com>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
        <20230511175609.2091136-1-fan.ni@samsung.com>
 <20230515140036.00003301@Huawei.com>
In-Reply-To: <20230515140036.00003301@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5322:EE_|DM4PR11MB5309:EE_
x-ms-office365-filtering-correlation-id: b354db51-7a16-4642-19b2-08db561b534a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s0/ltCdB1viySH6sinvpUTuTgktcbtJetAl1aPRAly+IusEoc7RlCPBaXQrpuRrI/OcMda+1DZRgZj2w5ucrQNy5Aa+Rwv18yU02Iwskp98JQ4XIAXHvWPFkXhYYRkPlXQ5kAQu7HEgjMdG58iMvNMUxKagjEI9Ct6nLGFeFtZJZpo4wvzoCi8sWbZq0V96/AXSf5p30Jtdtuh0rejMDyAK7BcNEWXFCip3nR5a8lNIH+PxfQVcexHQB4RI4fMrMmEswTCd05DtHxtc2DrrGTCM8nwTacICfRvUSitHInuz4ac2uVW1Cyl/OhvCD9CHmoayOoVJr3PASQ8wg3162WeycpL0afcSs6Um643DQWUmDlC+rIZL7YmeJZOTgCcclChwb7EDGk8TMj2wesqm8eGavjtZhkumHblfv8H1AzOq1cfCDrNNHj0MasnZIfalXfkB3sFxPQ1DE2NevDkjfgGX1RJXTD405V/sB7hZtYiTfpKoorTLsIF+Lg2gqcgBpwEnh8bd4cPY6qeHyJyjK7zn8sKuYsbZsMH0RnpIoM6lY08pAVqXCgiuxOYokVx7gePkHhH8Jmt52Cb3l8EalLc/TFf0NX1pp80C1/dYhrDQ0yK1WBXRQ7aou8WWxMSPDD9xPymkzGDnUzK2t1UglPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(33656002)(64756008)(54906003)(45080400002)(110136005)(316002)(478600001)(66476007)(66946007)(66556008)(966005)(4326008)(66446008)(86362001)(7696005)(76116006)(55016003)(5660300002)(8676002)(52536014)(7416002)(8936002)(82960400001)(2906002)(122000001)(38070700005)(41300700001)(38100700002)(26005)(186003)(53546011)(9686003)(6506007)(55236004)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uKQwfzNTXNslZu4QgydbsmYtKGSUmgLIygM8LXB+RDEumH2lTLNxrt2D6gih?=
 =?us-ascii?Q?BO39pCUx2Qj1ANG7dwTFo7HktAyWoXbR3Kckn+4hDr00TF0M3sOgW+a3FG/r?=
 =?us-ascii?Q?0Ht82PQDNZex26R9TEg7QBmMxr8fXL0GXcxM+ys9rswAJZo3DIzm1Jv6Uozi?=
 =?us-ascii?Q?gKr3MKlBn3bLb8C3fTNIIqCg7KF4AbFaf/bVnweYeVZ12U6XwGpY2gTq/wN2?=
 =?us-ascii?Q?NqmrAwBJvz+PYpjjUiXuJdxcqcZzuOm0E0c/SngS3GfwBQD7ijf+bBdaSJ2o?=
 =?us-ascii?Q?Zl/4EtfKRMIoxYZclIvdNC7ywqMtpKUxbgdAiKTD4Gj+9bXTcqKWlqlHcbVU?=
 =?us-ascii?Q?EKn0I4QDH1z/GAuHM2Rva7Gn1JepevqYTAoo+KEUOfjbi0pzT5xHoKzctZLD?=
 =?us-ascii?Q?DF/HXO2VV0vm5yRSzUJlP+KpY9kEPb48S/7E0DFkWamrQ4eS+HCuCAmlujQ6?=
 =?us-ascii?Q?MvspRdN516F60ajRQoad4kWk0RvOvPscbbH+wUHjJA4daHMNQnqkUJEqnbRK?=
 =?us-ascii?Q?0p8tZZzpOv6gVwUaY/MUgOYPWXLWYNvZooC57V7ZAZ/RRP009NMVKib0ZYWF?=
 =?us-ascii?Q?oZgmMzIeem+bVMx7LxHff15EyylI2VoO3myaX6IIWTkecVViQbklOoPlVmum?=
 =?us-ascii?Q?7HnriQM03xCOlKl8gGK17MFvbQjAxmEhA6Q9698vwLAUmWdnAOP7z/JwEtuq?=
 =?us-ascii?Q?JND/BRDUT/LMHcCIsoFkJBOicfQ0MbCYgD7yrGyx3HQiERLHUzQPAlYVEFXe?=
 =?us-ascii?Q?uPr+LKIX/SIhOpYYmwGFqLXNlFbrwIXjdRgsHXaH3B4s0uBe+HKovaD/+ptP?=
 =?us-ascii?Q?NU0hOs42CJ8RmNrQYYcmwb8TWMn/2YX3nosEgnZZb+J8KZV+9CpkeusLuq0T?=
 =?us-ascii?Q?dhhWLMrygSffyFAG2X3MgilrFbrRYF+tKeeHiEUH/lEiNlnkfVGFSJ6xuyvu?=
 =?us-ascii?Q?OJHKKfCb3kUJR+51lslHe35YkTjsZjavT7a3zzLe0QresvDKqf7O8XfvH+hw?=
 =?us-ascii?Q?dz7WQdD5WiQOqtKdEpC1BiM3eKppFIU8RS3bzghKMo4zfXCHz4qt/MbO+tlk?=
 =?us-ascii?Q?gVTy6akgAFfGJIdvYZ58aLORjnu2q3J/mBYG2tvee6uquVE9OIOhGw7qmUQe?=
 =?us-ascii?Q?XivtNh3liGs3qXfSHdmTo00v+Kv9zaiYMU6b0huvt/LWdyl1E3rSbsI02J6Y?=
 =?us-ascii?Q?xWJA/N6yJaGNbvB7OVtv+8j2sbE7br993QFekQACP+sNfoZ06EPk1yo2n+gk?=
 =?us-ascii?Q?edKDyq8lQ2Z2/hekt/LnTcgNTueBJkR6h74LHA+NLbaer2K8Tl4WKz4ibzOT?=
 =?us-ascii?Q?L/dKqNS2YQjofDJZafGQiIzgz5NYb8FxJP1wR+iatlkKhF3MEDnqi3XV6zOL?=
 =?us-ascii?Q?1JBgoZ576DoEMCn5YD1AliC2WUM5Sxbhr1vOhyQKAoAAYQ3xoaiMpzfk6RKt?=
 =?us-ascii?Q?g8Jc1w8ow2PfNp/7Fgau5mt+46+/uDV7fHJBV93nVCOkKeWeqzVYcqZCi98F?=
 =?us-ascii?Q?LWcgMiaQw5g2v+kmdIbYn6/FIOpRBEyxgp1tE/UH51/ojuy4DGcGycpKqaRC?=
 =?us-ascii?Q?k72YXZBTlDdkNCprLBGzkGRpzMDWUKL69pIzgrR7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b354db51-7a16-4642-19b2-08db561b534a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 14:39:16.4449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGZy/HURcDQwMsOPiz6skV2ILILB3cioqxDli+nD+8UR+tcW4OJab3W34DcChtASbBSzGq4vg8pB1QRosqlm+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



-----Original Message-----
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=20
Sent: Monday, May 15, 2023 6:31 PM
To: Fan Ni <fan.ni@samsung.com>
Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; gregory.price@memverg=
e.com; hchkuo@avery-design.com.tw; Browy, Christopher <cbrowy@avery-design.=
com>; Weiny, Ira <ira.weiny@intel.com>; Williams, Dan J <dan.j.williams@int=
el.com>; Adam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net; nmt=
adam.samsung@gmail.com; nifan@outlook.com; Singh, Navneet <navneet.singh@in=
tel.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu

On Thu, 11 May 2023 17:56:40 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> Since the early draft of DCD support in kernel is out=20
> (https://lore.kernel.org/linux-cxl/20230417164126.GA1904906@bgt-140510
> -bm03/T/#t), this patch series provide dcd emulation in qemu so people=20
> who are interested can have an early try. It is noted that the patch=20
> series may need to be updated accordingly if the kernel side=20
> implementation changes.
>=20
> To support DCD emulation, the patch series add DCD related mailbox=20
> command support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3=20
> memory device with dynamic capacity extent and region representative.
> To support read/write to the dynamic capacity of the device, a host=20
> backend is provided and necessary check mechnism is added to ensure=20
> the dynamic capacity accessed is backed with active dc extents.
> Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is not=20
> supported , but we add two qmp interfaces for adding/releasing dynamic ca=
pacity extents.
> Also, the support for multiple hosts sharing the same DCD case is missing=
.
>=20
> Things we can try with the patch series together with kernel dcd code:
> 1. Create DC regions to cover the address range of the dynamic=20
> capacity regions.
> 2. Add/release dynamic capacity extents to the device and notify the=20
> kernel.
> 3. Test kernel side code to accept added dc extents and create dax=20
> devices, and release dc extents and notify the device 4. Online the=20
> memory range backed with dc extents and let application use them.
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
> echo 0x10000000 > /sys/bus/cxl/devices/$region/size echo  "decoder2.0"=20
> > /sys/bus/cxl/devices/$region/target0
> echo 1 > /sys/bus/cxl/devices/$region/commit
> echo $region > /sys/bus/cxl/drivers/cxl_region/bind
>=20
> /home/fan/cxl/tools-and-scripts# cxl list [
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
> 4.Online the momory with 'daxctl online-memory dax0.0' to online the=20
> memory
>=20
> /home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0 [ =20
> 230.730553] Fallback order for Node 0: 0 1 [  230.730825] Fallback=20
> order for Node 1: 1 0 [  230.730953] Built 2 zonelists, mobility=20
> grouping on.  Total pages: 2042541 [  230.731110] Policy zone: Normal=20
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
> RP1=3D"-object=20
> memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/tmp/cxltest.raw,=
siz
> e=3D512M \ -object=20
> memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tmp/cxltest2.raw=
,si
> ze=3D512M \ -object=20
> memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/lsa.raw,size=
=3D51
> 2M \ -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \ -device=20
> cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=3D2 \ -devi=
ce=20
> cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,dc-memdev=3D=
cxl-m
> em2,id=3Dcxl-pmem0,num-dc-regions=3D1\
> -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interleave-g=
ranularity=3D8k"
>=20
>=20
> Kernel DCD support used to test the changes
>=20
> The code is tested with the posted kernel dcd support:
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=3Dfor
> -6.5/dcd-preview
>=20

Very nice!  +CC Navneet who may want to comment on the below (and the emula=
tion as well)

I've not had a chance to look at the code on the kernel side yet.


> commit: f425bc34c600e2a3721d6560202962ec41622815
>=20
> To make the test work, we have made the following changes to the above ke=
rnel commit:
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index=20
> 5f04bbc18af5..5f421d3c5cef 100644
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
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c=20
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

Some race condition that means we need to enable the DCD event earlier?
Navneet - I have been working on the DCD feature last few weeks and this ha=
s been removed and will be handled like other Events.
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

No idea on this one as it's in the code I haven't looked at yet!
Navneet - This is also fixed , in last moment changes this bug got introduc=
ed.

>  	}
> =20
>  	rc =3D xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax, GFP_KERNEL);=20
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c index=20
> 9e45b1056022..653bec203838 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_state=20
> *cxlds)
> =20
>  	/* Driver enables DCD interrupt after creating the dc cxl_region */
>  	rc =3D cxl_event_req_irq(cxlds, policy.dyncap_settings, CXL_EVENT_TYPE_=
DCD,
> -					IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_AUTOEN);
> +					IRQF_SHARED | IRQF_ONESHOT);

This will be otherside of the removal of the enable above.

>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event dc log\n");
>  		return rc;
> diff --git a/include/uapi/linux/cxl_mem.h=20
> b/include/uapi/linux/cxl_mem.h index 6ca85861750c..910a48259239 100644
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
>  include/hw/cxl/cxl_device.h |  50 +++-  include/hw/cxl/cxl_events.h | =20
> 16 ++
>  qapi/cxl.json               |  44 ++++
>  5 files changed, 924 insertions(+), 67 deletions(-)
>=20

