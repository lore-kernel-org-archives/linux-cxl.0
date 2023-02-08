Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0FFC636CC
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 00:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBHAxM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 19:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHAxL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 19:53:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109F722DDE
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 16:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675817590; x=1707353590;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+u8BN6xxvjlxuiPTeGcuhV9LyKPHLfSrwETrdIXe+xY=;
  b=DASzBrhKbp+uh6ZRYoIJVSaE2oX+co3BQVLVoI5NnWD76wzKCR0kb55M
   HIyxM2wuSJDW6AX4Vh0F7CVBQutnqRGA/fiYD+xSRlY7ALt0WRPQYjgsW
   EpS1W5qFS5gc0MR8ETg2BmxMcwyoRrYXzIXC6UKtCIHfqoLPPCIaebPvX
   FsUMANjoX7pPwDjAwjmF+T6NajW/NsUYZHSJ1A3by/ZVGNFmJ6ZwfyiPe
   zzh0qf3qB3XP653JNVj8ptLMKbJa7jg7+jk+XfGC4YIr32ztcWwYFCbnm
   CsUQRvTs9brCVlpBIKzn+H8fjrYID2uynUGH3OrFekpJRTJbCfPi6nYFR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="309318839"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="309318839"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 16:53:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="735746624"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="735746624"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 07 Feb 2023 16:53:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 16:53:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 16:53:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 16:53:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFNwxzXBE7sREh85kZPUJ8kGKx9f7+tSHEgzY+BkRA3fQKQcsMIeT+8bMdoCM6YJc4IJU2NGhjPddaCtAEWj+X8j8bppHkXCXOjuiY5JEVfXunGuYxDd1pUm3OYD7Rqsy4fXZ8zBxwBni5+3BCUMBiBTcLAISvMvnZ9AxvDLmnSvi4FiWkTGZwQLtp0LeGzdAx+3frtA8LtMlcsBIC+CdESoC92VHmBRl+zVv2KnhTTTdEMY05/99BJChR5EEduzJTzGAHSS0qmCKgQe5Q+/OM0EBYn80t8EjB6jFPMAHhLG706H9LkYLvoYvnpdUj5Hoo/2Z1Ksm8D4Pu9CFxpF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5W1zZF2/2WHnwW8Dew1QOYVd5DKs4mHgsm/EuQomCw=;
 b=GF8AZEOrZOJDMt9GKXPlvkpp4LCA1Eqfm+7Xl9qo/u/I98o9hhdgz1/usM76Yf+K8I//lRTSwvOJsSqDEs3L3vko/wCH/I5mtShvHLSMbTd2GOMCkWloQDD9bBXZQkYgXpewXDXqooCEghz2NE5w61eCJ3vT64LfIsAVSubiBzWTqryE6+RVI1rTp8qywkamRaOORKiZBan4ziaCRgzdt/Djhq/8LteaKNoBcA8+FJdafCwjS9cv9aRre7C71DkUJDBWPv3bhmRldG7k2nfkQtSs2i1mBzvmIPzQbvzx4KvMFhAD/O2kNt9gdlMx8ZalXGzawYLzuswzxC9/bM5CUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 8 Feb
 2023 00:53:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 00:53:07 +0000
Date:   Tue, 7 Feb 2023 16:53:03 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v3 5/8] cxl: create emulated cxl_hdm for devices that do
 not have HDM decoders
Message-ID: <63e2f26f63be1_e3dae294a0@dwillia2-xfh.jf.intel.com.notmuch>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
 <167406534263.1455071.15469331778875048496.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167406534263.1455071.15469331778875048496.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: BYAPR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:a03:114::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: a9413ee6-2a28-406c-bf2f-08db096ed734
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeHS3T8guRhpw5VP+mCEbcbLG1neHDFGvqisq+qNax0D2TTqkNjiuWVBRaGxP0J89rPpoUKek2yl8tGUFQb0CnRD4P/OP2N3s05N5QP0OpVZdITQal9zALrhVlk2Py3zrP2gxzQEwrcbOza1UmffYGWWY1v3OMS+OaoRTC+tARTxyRiCtisAYHMbX+5wfzDf/o9Pi4UyOUv5fq60bWSnme1fh8jNhflv9eEYF6LGdpLqmU1lcQf3+Dal+nZb+IfKv9mcj4JbhCW16pOWT3m386iqIMgkGU4xjZaB9dvyuPi+6Q3fY3IKGC+xEmhURCBKBzGhrEZp3n5acVFB81I7E4B6RqcDqLqsojsSDYSdlB0mSZ60tJWb7rf437Da5sekdgI6k4UFTwxdq/XX/k/7dYNNbd9tzhMPH65DwcDiydumRTvjYdOEnvLRrkPZggrePZBeNzUW+qmbpeIaZUK0XyEsaJnek84POCVj1snEFbtlRg3OhQIXvRB9IRAbKDUECdFpOl2RgKkIgnMm4b07W2q1oNRHBX37wDWr60LB6B1g61n8KnQxs8DWdxqifUMdDxExgRZ/kDERmDpQ64gu6NnpG+yEw5bWEVuNen23KWZfLhVWoMEHu6AHufcLpiezWV0Hos8Jv45D2XHAhVMmbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199018)(83380400001)(8676002)(66946007)(2906002)(4326008)(66476007)(38100700002)(66556008)(6486002)(86362001)(82960400001)(316002)(186003)(9686003)(6666004)(26005)(6506007)(6512007)(478600001)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eESkb8JH0aQ3hj28VTK+j3MgbtndMS8km8FKkgmCyzFoau4E5q1GpONGTFIk?=
 =?us-ascii?Q?uZyPeh3SKpMEnFOreoj32tBuWEZ0R1TKabh3gV/XTcuRbkU+i98wvJ1UQCHA?=
 =?us-ascii?Q?HGrvq//tsG6Wk0xZ/lQZcODxa2R0RVtEDAEJ86i1pwpZLl3y6nj79l/zKHZ6?=
 =?us-ascii?Q?YGJxUb3/rKzf/aB5darEkft2GGIiJ6eowavSaVfJ8vc+FYCbn41IFQMJgyd2?=
 =?us-ascii?Q?kpExtF/F1oJJ8i/F53b2F37RDkuD67cYvQheRl72nvHBdvpGXyd7pOmsZ62e?=
 =?us-ascii?Q?sxiPCE1zBOyCszuXWrgV2Yp0H0IR94h+FsXa7Mhx6x9lNmEOxQwbQ/NVkYbr?=
 =?us-ascii?Q?V1bWy9sfSiiHtY5MY6ncMf2AeREaRY4hnK0cGbg2GcWXGodnO9gB3fC4s4wK?=
 =?us-ascii?Q?8G/gRGGVtIBit3ODilvuPfWJkhuufQBD/F3xC8vxiaQx3uP8PsVIk1yY9BQf?=
 =?us-ascii?Q?p5LZ/kHGivjoT6VUCgOejCvSxoxdjFeu2Ur3odeaLQ4vqhPWwFRFVXqPNzu3?=
 =?us-ascii?Q?D10h8Bwlsb6XsicQH/c1ehRFLEYtXbZT2c1zsjbt+RU+IELfdtbyrkyrh9ty?=
 =?us-ascii?Q?MVduA1BMWCTWTB9OFuZV86CBmq06lXGeFnykmEcrB1AFyfw4PcTsD62jrlZZ?=
 =?us-ascii?Q?mHkAI1zaoHKxLndO4BrmmdCNsxqw6SJPSgaK2Yg/qcPBUg/ULKKqCrgHbOKv?=
 =?us-ascii?Q?GtCXl60yuOFpw5ARB7d/EL8ZGTqM3mJ5G/rp1MXWzHyBPwmZ2xq8T+F97Xa0?=
 =?us-ascii?Q?OZMnp+PMApaibFFhkcXx3mgL5of8rYe1igFf+WbMxqQqy99mmj86LK31x/Gz?=
 =?us-ascii?Q?ztOEwvU4IzLFRxH5DsGyfJxRR1sdV2GrrIMDwbCVgkswjpO9OVBL9jbyltdG?=
 =?us-ascii?Q?953ZwKG3qFzPaZpdlMJpJOYJoOodmYuwwb3N+lO2qd2XqE9crB0FOE5J9CFb?=
 =?us-ascii?Q?kyPnXem8k0vXqFPgvtUiUO4kmDHxOhMNqmW+521T+3/NMA05lebOJGqTUNGl?=
 =?us-ascii?Q?W+fVt7ZbLYxEqecuXPO3tY41sW9x+mESvhC2kp1ss3Gv+SS8u81PIO8vea+T?=
 =?us-ascii?Q?RwdLedg17EbbR8eZsR41O7Z3opS3MJzNP1fv3xfoL9YkDLXkwy3/Vw+6pn/H?=
 =?us-ascii?Q?My0oXjHcLFdhplaMelb542pQDHnqvCmdPpKhcczI1Td9zaghuxZcm19BVUmL?=
 =?us-ascii?Q?Hy/eh0WoB2uoEEBVcT+XORL5MJpfzuUqnoHWs5gfRkGMYckilZmXv3AoANVi?=
 =?us-ascii?Q?LiaLPKt5j7SzZOG0+ER1+iFx5BfqvimSXYc4mDKDxRRk3my2/31eYElCRjIQ?=
 =?us-ascii?Q?njPGhZiMklLqwjjaDkJobZcy5zCVBTlK6s8C0ftjAt5jhyU59bp6ttky/Ui6?=
 =?us-ascii?Q?m9n1b4hObh4Wa8VMP7b9mwBcIw/tA708tW+TF+qR5JUeGotNQY1NyRiGHVUG?=
 =?us-ascii?Q?XbMed5vKg+2ArA1yTg0uRr+pmbhkrD4yUIxHaKI36QxTVd/TmJGwTxhJmkpe?=
 =?us-ascii?Q?d3irknBRwtHOtG1I4Ht3BA07v0705EFCYeVKbpbXP8pqf+acg+TYjR6GpDAg?=
 =?us-ascii?Q?NmRZ3ecEjWohcEhOPfm7CBy7zziatd/6bxpTHovtk0iOtDLLua6Cbs9xvDSs?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9413ee6-2a28-406c-bf2f-08db096ed734
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 00:53:06.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5DFnwy6vC/i83U9IuHfZisOLJfk3YzHdHQCYHV1Yrrrkzrvi5r2elNIBYnpHQEPIq/kjlfkFL0MMUSK3bgJdinPCcYHN4/i+QEaNHBct6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5861
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> CXL rev3 spec 8.1.3
> 
> RCDs may not have HDM register blocks. Create a fake HDM with information
> from the CXL PCIe DVSEC registers. The decoder count will be set to the
> HDM count retrieved from the DVSEC cap register.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v3:
> - Move relevant changes from next patch in series. (Jonathan)
> - Add kernel doc update. (Jonathan)
> v2:
> - Set target_count to same as number of ranges. (Jonathan)
> ---
>  drivers/cxl/core/hdm.c |   58 ++++++++++++++++++++++++++++++++++++++++--------
>  drivers/cxl/core/pci.c |    9 +++++--
>  drivers/cxl/cxl.h      |    3 ++
>  drivers/cxl/port.c     |    2 +-
>  4 files changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index af1f5f906f52..86fe1be2e961 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -101,11 +101,34 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>  				      BIT(CXL_CM_CAP_CAP_ID_HDM));
>  }
>  
> +static struct cxl_hdm *devm_cxl_setup_emulated_hdm(struct cxl_port *port,
> +						   struct cxl_endpoint_dvsec_info *info)
> +{
> +	struct device *dev = &port->dev;
> +	struct cxl_hdm *cxlhdm;
> +
> +	if (!info->mem_enabled)
> +		return ERR_PTR(-ENODEV);
> +
> +	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
> +	if (!cxlhdm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlhdm->port = port;
> +	cxlhdm->decoder_count = info->ranges;
> +	cxlhdm->target_count = info->ranges;
> +	dev_set_drvdata(&port->dev, cxlhdm);
> +
> +	return cxlhdm;
> +}
> +
>  /**
>   * devm_cxl_setup_hdm - map HDM decoder component registers
>   * @port: cxl_port to map
> + * @info: cached DVSEC range register info
>   */
> -struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
> +struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
> +				   struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct device *dev = &port->dev;
>  	struct cxl_hdm *cxlhdm;
> @@ -119,6 +142,9 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
>  	cxlhdm->port = port;
>  	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
>  	if (!crb) {
> +		if (info->mem_enabled)
> +			return devm_cxl_setup_emulated_hdm(port, info);
> +
>  		dev_err(dev, "No component registers mapped\n");
>  		return ERR_PTR(-ENXIO);
>  	}
> @@ -815,19 +841,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	return 0;
>  }
>  
> -/**
> - * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
> - * @cxlhdm: Structure to populate with HDM capabilities
> - */
> -int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> -				struct cxl_endpoint_dvsec_info *info)
> +static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
>  {
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> -	struct cxl_port *port = cxlhdm->port;
> -	int i, committed;
> -	u64 dpa_base = 0;
> +	int committed, i;
>  	u32 ctrl;
>  
> +	if (!hdm)
> +		return;

Nice, I like the semantic of a 'struct cxl_hdm' with NULL
regs.hdm_decoder == emulated.

This patch looks good to me.
