Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D96C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Dec 2022 23:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiLNXAI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLNXAH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Dec 2022 18:00:07 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7257942F46
        for <linux-cxl@vger.kernel.org>; Wed, 14 Dec 2022 15:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671058806; x=1702594806;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0278nRIXo9U9M4GSauX94FYSiMai+oSBlJJ6n0THq6U=;
  b=YTM0v+q9vx1is7Y3HEAt/wwv514N8G6yd7OBQDCvlXPmkiVqT9VOQ4S6
   K+SH7yuamhTbkqFnAVLRnYG+Na8rJ12VauLELWsLAlAfF+WDl4i8j5ZSH
   Dgy3kbLfuHSB/GWVwYOzEeFm5yVb+D6e31Vf5gP3oRCc54XiPwGW9mFBW
   TARIdJbvbxP0Dee9bSPJ+AEtGszZgYkUWFm2RAkuP7/dN8sCyJKS8xiNd
   +3XAwopmtBIXhbMYSoDG/V+HDf4FR/vFa2g8Ab4ISH5FP39dI9osmzB5G
   i1RX0UU4tst0fq5rXwYgOaKMDFmle+xOxbGUbluGXQd9XuTEs2KPftDQl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="382835155"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="382835155"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 15:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="791414443"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="791414443"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2022 15:00:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 15:00:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 14 Dec 2022 15:00:04 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 14 Dec 2022 15:00:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+Qlamaw+6lJXyDp7uPn+dpVCtd7HEPiO1y8nUQ/4tyyaRhuOtsl2k7CMGsZdvFanNK7MvzPlo3DX+j3QcgOLTKRE5++5HvnBPVoh28lE/zhLY4LWJVq+prV58ZPaWMMy9FOHO2J8fwaIcicm79HpzutNXiZ4qLjRph0+DikU5Z7p3DrQPQG35LDPnUvJ36R3m/p5pmKmB7s/I4KotgHSpk1A0hoXztL17QfbHCU4QCvQKdedq8hmtdMjPl0jZE/qsiOCsn4/VDLc3PTbI2s4qxPMjqwrsjbzZEmhlhP1gClDD5FWHSqQdboP9HA4bTr/ia62FCtUvYKJJKjb4GyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xub9INNOPN1Ch8dYXi3JwGNFyoNCz6XStvUBFmNHouk=;
 b=GGmd2kq278dfIwxIWvGto3a+b9tvFrVHIuk0gWeADxv+UXU6tPZuMnOldtL86CFUFsgksnkQOmqVvOC50WfAUyxICer1yE5JPSDqEeMUqqxX4eI5H/vOGzEIBsn97ZQ+g8YhuLHrIWym3Mzsu7y1IZZlHTwf23sj4IRqxOJXxj3N4hPyFp3c4kU8VPXHNmCUPKpKxJxTOXdT6zLCWfjFOrtQ6VA4q4pqcusxGlmjby2jMliLC0HYPO1Ae1Dp1+NnyyjIlRe1Y8Cj+Swc1E4/IemnIHln29Rv8IEvOC4aiY13rf33eGRUIMnS1W/H4VX90GVH5kyJuOCF+s9/8TowbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB6455.namprd11.prod.outlook.com
 (2603:10b6:8:ba::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 14 Dec
 2022 23:00:01 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5924.011; Wed, 14 Dec 2022
 23:00:01 +0000
Date:   Wed, 14 Dec 2022 14:59:58 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2] cxl: add RAS status unmasking for CXL
Message-ID: <639a556ee86fc_b41e329438@dwillia2-xfh.jf.intel.com.notmuch>
References: <167096738875.2861540.11815053323626849940.stgit@djiang5-desk3.ch.intel.com>
 <20221214122816.00006404@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221214122816.00006404@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM4PR11MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e0f95f-71ee-42bd-9205-08dade26ee61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVvFs1v0P5kxsYPLn3AgvCVKfjzoIAUug6y6BV7+dAI2pINabYK4uf1CAr2DB24kJOcojOQcmGXeZfHOijmxrO2yz8OsIuCZoAqdPS3/dHWgpiOb6ahSM0M1QI7ZnXtG0eq42Aeh7IGBuDRW5pA8rJFs2p6ipqwitxR8mrhWhCwA5DlJFUgsHMTLVcrH1aKgj+D05BoD/S0d069kB//+DpCWBWdJ8ez1X4ijsp39HGi8p7RbelOXgiSJ2Ho4eZj/CKOiwX75X1IHyk7gPmT82BDhT+fjm46fzHyz79BKeBpPtb3KbMAFZyZLCu0jUlcotVjmmzAWyuEkVxOezitfb7fpVmCwIwv9/8XdR/ADXr6n4iBnuroVk/jmihpkzruABGB9TUouub3RDs7gGC7VJzSso0k93Ume1HMnFMhDTGgd2DIBhfp4V65FJeObyvO/fLbEfQg8PqJM5+NoooOuOQCpEBT1MrW3AIihfAvXJNrOXF8WBrpinmzMvt44KBSAos2gzNj2il5vivI5SPifl/rbMGwdm/DxhPxsr0ttxQroO63q80A5byrQ0A9P+SIrK5QNxU4TDMIxRC747nWzJgpkNzy+lRn+j2+yYOxl9lYJA7j2qcWy3bLqCZPFMvQDmQ0iX3LNciKGyHZashfmolp14FRESgcc7wg2Ja6jCv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(41300700001)(82960400001)(8936002)(2906002)(8676002)(86362001)(66556008)(4326008)(6486002)(966005)(38100700002)(110136005)(5660300002)(6636002)(66476007)(66946007)(6512007)(26005)(186003)(478600001)(316002)(9686003)(107886003)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EWgWlwgg3tls9G9Kh+g2PI+5wZDFdb+okWQgwyYlBxe8xYTUvOJnb2uON1q7?=
 =?us-ascii?Q?AoJSZeMABk2F3ZpNT9RIVe3nOQACickKH2QO4RXDXuFsk40splMmoo99NeCX?=
 =?us-ascii?Q?9GuimHheIwu17pmsB+tG131wyBrPa/ilG2S6sooomwsuxf1WArRYxq0oz1nA?=
 =?us-ascii?Q?N1y7R/U9bt6qbwKB+UWrFnq/LOlW6BKiKd2KdEWsu9vez1kB8S69xFZOLdst?=
 =?us-ascii?Q?g0inNQGXlhzthHifZ3VwX56MEIA+qU4p72mQ7n+jnoVm0JjlvBbKoyLiyqfN?=
 =?us-ascii?Q?V6eL14xz+llKHJ9zd68O0ymNOu12w+juD5vWlCFL4o1GyZmlvUb4Fr7XpA+6?=
 =?us-ascii?Q?459MGdg4r885sM+ts1YHdy5huo22W41gNsXsdgIHejc8if34qPRT4xEGcLfP?=
 =?us-ascii?Q?lBOcttx8vvsmsgcm3QcVJamcSMVYa7V//pVt3NK2SvZIPhmZXLopfU0g59hM?=
 =?us-ascii?Q?PoShzgUKXsO0lyQ7g4h9uCzp8wdxrkth6nW2wYofOVTBlcT/jFpWE0gmyBPc?=
 =?us-ascii?Q?HKcJHCbbOvVqknzxda7UoyC1yscdY9hrKNqNtoX+73GDd6ixkqil4vR86K9u?=
 =?us-ascii?Q?Mrxg1a+cTkJzM6+Gt05AmrH8k0YfZJ/HGssUFIotYxfy9o1VGJaB0EK8eqn2?=
 =?us-ascii?Q?6MQekdyhbC66Xf4tT3XmEvgmeN+4u5Cl1BCCeiF+9PU8p+Vv102vbwVZPLXm?=
 =?us-ascii?Q?mux5WRIAARO0QX32Z2ABVZPUY2/yuYTiI+H7ZvQjPZaN0QcImpazBapvx9RV?=
 =?us-ascii?Q?87/JbvDnniV2BRw28j1ZnSnjOzswy46SkRF4Y61pK8WG5TALFbxJy3nyMXfk?=
 =?us-ascii?Q?BZtk37CNxGhk97wsWGm5atNWlhGMXTtMWhCeidOnoZ4noPffHuS5ApNaCxKX?=
 =?us-ascii?Q?c1l8eR/Z+D539LmGp921n7L9EHME5mkoo+EFyWKMrTaiGK+6QcGXIuGtP/ZC?=
 =?us-ascii?Q?4lQ6FZscKm+dBUGWZuxcC87boIL/6ASriFgN7QVKN9TyXdxuT1VDobSAyDsA?=
 =?us-ascii?Q?5SC+h0Vg8FPW1/KCBMOFlbtIjT3ddzRI7ZARw5XBgbqvlMaXQ5yZfhxpWfIY?=
 =?us-ascii?Q?ZKBjsX3ktoT0Y73e1Z1fWWM///yjLsbGVRkd7TXSrKI7bjYS++oA75DvyTdF?=
 =?us-ascii?Q?zTma5JVZX5On5IDMI4ShL/SciPfMmdEaRMkL0v/QTWb0GwRWHUKAs5yhgb+N?=
 =?us-ascii?Q?Xv4MYYvrt7MMH+XXJ4BKXcYVKtvxpCQa9VwohSIJjMGAXAs3PPKNe2NoOOeB?=
 =?us-ascii?Q?YKOo51F9VhNKsInzkffAlW8O7y+7XOE9G9i8Ij2eYhV29eXFLGoa6vqwG/yy?=
 =?us-ascii?Q?+eoorg2eLkzBM+Mbhu2uN0AdYtvv9pTxknCa6IfnQUY0qEwM/3ZQzLxAJKGC?=
 =?us-ascii?Q?OZ1dzXIFddkInRUrt9F3f9VZXAhN5p8OE2AoBBXx8lsFa4H0BDxgq6xB5KU8?=
 =?us-ascii?Q?J3kX7LKkLHbi1sRhvNCyO+0zurOzRtoC2BSadjdv271swxOjkGallTb/WkKP?=
 =?us-ascii?Q?uRXEtBSw6/akIIIFrjO5VR/YvSqPdyDTIUJaQ3iewpvoV9WSLGHjDnsZ0OMu?=
 =?us-ascii?Q?Fh+dlgWI6Did+0umfVz+UcbbYocydWrXiYA6R22O2X38qDkHGkXE0iNNcKAY?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e0f95f-71ee-42bd-9205-08dade26ee61
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 23:00:01.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSlnP3AeN9no1tWH9Yd1/IdymmEOsG5U2mbqYj9tATDFLXZ2nW4rck9bAjurEFKP4FQa5LdvBHNYGKl2//NTC+Ud6cUoaRZDw98hooVDqJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6455
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Tue, 13 Dec 2022 14:36:28 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > By default the CXL RAS mask registers bits are defaulted to 1's and
> > suppress all error reporting. If the kernel has negotiated ownership
> > of error handling for CXL then unmask the mask registers by writing 0s.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> A big oopsy from me.  As you've indirectly identified, the QEMU code completely
> ignores the mask register.  I'll fix that up.
> 
> > 
> > ---
> > 
> > Based on patch posted by Ira [1] to export CXL native error reporting control.
> > 
> > [1]: https://lore.kernel.org/linux-cxl/20221212070627.1372402-2-ira.weiny@intel.com/
> > 
> > v2:
> > - Add definition of PCI_EXP_LNKSTA2_FLIT. (Dan)
> > - Return error for cxl_pci_ras_unmask(). (Dan)
> > - Add dev_dbg() for register bits to be cleared. (Dan)
> > - Check Flex Port DVSEC status. (Dan)
> > ---
> >  drivers/cxl/cxl.h             |    1 +
> >  drivers/cxl/cxlpci.h          |    4 +++
> >  drivers/cxl/pci.c             |   61 +++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/pci_regs.h |    1 +
> >  4 files changed, 67 insertions(+)
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 1b1cf459ac77..31e795c6d537 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -130,6 +130,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
> >  #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
> >  #define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
> >  #define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
> > +#define   CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK BIT(8)
> >  #define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
> >  #define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
> >  #define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index 920909791bb9..d138d9cd8e33 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -45,6 +45,10 @@
> >  
> >  /* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
> >  #define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> > +#define    CXL_DVSEC_PORT_STATUS_OFFSET			0xE
> > +#define      CXL_DVSEC_PORT_STATUS_CACHE_ENABLED	BIT(0)
> > +#define      CXL_DVSEC_PORT_STATUS_IO_ENABLED		BIT(1)
> > +#define      CXL_DVSEC_PORT_STATUS_MEM_ENABLED		BIT(2)
> >  
> >  /* CXL 2.0 8.1.9: Register Locator DVSEC */
> >  #define CXL_DVSEC_REG_LOCATOR					8
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 33083a522fd1..03691570649d 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -419,6 +419,66 @@ static void disable_aer(void *pdev)
> >  	pci_disable_pcie_error_reporting(pdev);
> >  }
> >  
> > +/*
> > + * CXL v3.0 6.2.3 Table 6-4
> > + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> > + * mode, otherwise it's 68B flits mode.
> > + */
> > +static bool cxl_pci_flit_256(struct pci_dev *pdev)
> > +{
> > +	u32 lnksta2;
> > +
> > +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
> > +	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
> > +}
> > +
> > +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> > +{
> > +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> > +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > +	void __iomem *addr;
> > +	int dvsec, rc;
> > +	u16 port_sta;
> > +	u32 val;
> > +
> > +	if (!cxlds->regs.ras)
> > +		return -ENODEV;
> > +
> > +	/* BIOS has CXL error control */
> > +	if (!host_bridge->native_cxl_error)
> > +		return -EOPNOTSUPP;
> > +
> > +	dvsec = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> > +					  CXL_DVSEC_PCIE_FLEXBUS_PORT);
> > +	if (!dvsec)
> > +		return -ENODEV;
> > +
> > +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_PORT_STATUS_OFFSET,
> > +				  &port_sta);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (!(port_sta & (CXL_DVSEC_PORT_STATUS_CACHE_ENABLED |
> > +			  CXL_DVSEC_PORT_STATUS_IO_ENABLED |
> > +			  CXL_DVSEC_PORT_STATUS_MEM_ENABLED)))
> > +		return -EOPNOTSUPP;
> 
> confused. Why do we care about these?  If there is a spec reference
> to say don't turn on RAS reporting unless these are true, fair enough,
> but if we are in this state then far worse things are going on than
> just not having RAS. 

Oh, this is likely from an offline side comment I made about how the
driver currently ignores the flex bus port status register and just
assumes that "Mem Active" and "Media Ready" are sufficient for
determining that the device is actually operating in CXL mode. So yes,
this need not be here, but it does have me wondering if a separate patch
should move it into the cxl_port_probe() flow.

This also dovetails with the question of what do about AER handling in
the RCH case. In that scenario it is not until after the cxl_mem driver
successfully attaches the endpoint port that the driver even know where
the RAS capability registers are located. So I am wondering if AER and
RAS setup work should move out of cxl_pci and into cxl_port and all be
gated upon these bits being set to identify that the CXL link has been
negotiated.
