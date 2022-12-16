Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EF7C4167B
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Dec 2022 00:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLPABa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Dec 2022 19:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPAB1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Dec 2022 19:01:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5614C319
        for <linux-cxl@vger.kernel.org>; Thu, 15 Dec 2022 16:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671148886; x=1702684886;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6+MZx/gK/xMFXHB6CRuPQzaKqiYXh5+L7H33pLZNn2c=;
  b=aT5ZN1MPRu1WMOu28YJNUpk8lb30KKC4CMGR2c7Vgk7kz9H2V8L4ZuaR
   +yC3NxL9cUkls92AQYaSK0wmjW5A8jur0i80N/QJdYfAxLI8DMYSNYWZh
   IAbZyotsDKa2Gg0ySQSIaGrLi1j2A9Ps2L4IMwh5fPEwtchFn60TqYesz
   Ts0Fm0Osbcy//ERdRFbd0cevEWeZNjY/Tje5sYk/J4HoJJmBMC0wugZku
   ua2oPYycqPjTuv+6vXawGuFdKhU/Hz2YSMepLzSZNzcEuTAnRNtPOJ4O9
   h39aB0n7Jbe4qhpY+fvnjEB4AeTjKeKQT0Xba2LMPnkRjlDss/Hn0iFWI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="306508693"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="306508693"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 16:01:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="718184875"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="718184875"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2022 16:01:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 16:01:24 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 16:01:23 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 16:01:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 16:01:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyZ1KeA7kZZMkxrqrYLAvNrxNFu/K5b62r0DChllv/4UVsL8ISCsg2OTDZektBamxsWY/VxAFpF6g2H+QfR07TPOEfVPI3tkGvvHqOvZQmsP4q8Zyhqq1rINJZRB2F4jJxbOqsuytLxV274ZTJfhtXyeIiNo2SKlTrLVaxpPpC+x6J0adjXRWLUqpBy/Ed1D1pNp8KA3nERQMAinAkMMaKEN197wiqanQxZk4SwxwNwPUsobUb5ONLwp8Ft7kyP+RbARAZnU0oketYRQW8FqCo5gKcQSozFQst+Cr6LPMY1gnwWvFSwhSLRfT6dNxT0TAbFhqjyTECXrNfeO+r6DFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILWjpt68keRY9F76m0xhF1MUpMetCl7XjXFyarTEW7c=;
 b=IIr+YPP6W+rVYDrnTTx5Hi/d2KCs6zpwUTK20aXiWkhiKq5nUcWs55FirFGHFfLYqaPFwMSBNlY2wFJIE/mfYGibw8Gj/Oe++kUS5mMOt1uRvJhbukJgM679OtgU/KhO/ygoT9nwhgVE2sg4XgyKKdwB0QZ7OGZDMBkgXByQSaYNy9dZeE3G6taS2pnG9iCQzJN7CNKtfy1obwA0IqvFI8Xz605c7tgd8XlATHpXF2jyZVYjmlneqYtyZPx4qoWgVp4i8yOwYk6Bf6CowpbWEp9WJy9xGnBupCrK1Ru5wDBNqIqYcwpnybeTqr+sgWeKld4AdfSXP3OhAIq1HpZxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH8PR11MB6997.namprd11.prod.outlook.com
 (2603:10b6:510:223::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 00:01:19 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 00:01:19 +0000
Date:   Thu, 15 Dec 2022 16:01:16 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v4] cxl: add RAS status unmasking for CXL
Message-ID: <639bb54c55098_b05d129471@dwillia2-xfh.jf.intel.com.notmuch>
References: <167112768345.3343090.11728168471813709343.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167112768345.3343090.11728168471813709343.stgit@djiang5-desk3.ch.intel.com>
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH8PR11MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a790475-0182-4177-b67d-08dadef8a8ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYt0Uybs7FFE/1YwUTYxVqAa//fHPVgKzh30PNiaTq2zty70YN6KK3e4UCrj9efBHbcknZxXF1cAGoHdBtEo/XYCSMLAJMo6zXKYS+NzOXg+zk5pBvVNep5eeJ3sFNVttLhmL2WsXsAt2iB2AkpMrmA4Z0zfzCCuTQhifXZU9EKMi03osxjG74sC/0deEwgQ8PAEvrIaJDq/yCvtiuZpGv3a8woVXE/tZKiAsaOzL3k3YWJkZIJs6bM9lWhGCFUkChleDOZNLHEffgnnv2A667nyTIU4Jyq2h7WIznicaMQWUN5tDA+ff9jOB0+wPWDvDoCZzCjmoHaCguZYLEx++BVny+IDsURzGhUT8JJuAkEDogbu3lQNoY3Jq6JpdF0xo9MtH/CIPVrfROOD/2y3VW70fi8+91UDl3VC7GqPGc+sTGl/dSyPTKPie6UHFEPIAt2nLSHPa99B30QkPzT8aujCX9hb9raNsIDoU65A+0Ls4vl1K4l5rCwqZLUnwFKYNiTb2jdrLa53ioJzGIyqKiTKV9fzZvwCOMcrYGghutlSLm784p6I7qqI1J6HvF4hlgJWGXtn0eIGm+TQ+HNEFP2ZnuLpq2TwzK7v2aSseQ7iz7Wy/BFeJb4HWHjTYUQRgrigpdAeib67HQM5B0ZmHFBN0+tQuK8UcVplWUiWsak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199015)(66556008)(316002)(9686003)(4326008)(8676002)(82960400001)(66476007)(66946007)(2906002)(38100700002)(86362001)(6506007)(6512007)(6486002)(966005)(186003)(26005)(5660300002)(41300700001)(8936002)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MxqtAQQOhags/fQgjsH4NNRvc63YAZO3pJ4IBP+OW4iJh0vxv/hrHAYAabm9?=
 =?us-ascii?Q?wXwQxDVi0GVrj+538L1uGtf2aK6CWmUKyJjjwKxI0MQ0Alp2UYx0LtA9IDMx?=
 =?us-ascii?Q?NNbNZ5bZNVOB74KEUQzCjB0QCLelVmFeKs+BblsSfZRad0pa4mWJ+rMxViZf?=
 =?us-ascii?Q?V9bFfpkCzR+H/JMwqaIQvv8OnR3Bur8H7Uz+RPFk0tR3pXDcwC+XvtVVA0aj?=
 =?us-ascii?Q?RV4BgunolV4Mo1k4RE+z9BlRDyqiB2E4PxsEikykSBXISAXY4oxgyMSZBg5B?=
 =?us-ascii?Q?669FZtjbU0tzNuDEF0IJTT9pw3yHzoYsP9HwBBYLsO/wMpB2KYMom/6Uv4xs?=
 =?us-ascii?Q?NOrNWaNjMe48ZbpSCWsHMEMQhyd5Ci1+pT6os3oACddDlnC/I3s6GkTts6uB?=
 =?us-ascii?Q?uhZLICoeCehjEmJ61DJBBrnnMRV0R1Pwkp0MvbXg6HNGDayhi0vwLhRuLPqX?=
 =?us-ascii?Q?kbZqD06JatipyZ4/dva25p4tDBUKCanaMYC7sSC4hRxbpMS4AoOZ2U9yxi5d?=
 =?us-ascii?Q?MIGZi4NOLv6sb6UqFf5EFUCLBQ0tfvAF1oVhJI2hEz3Jpgj3rj6GaRzY4XWt?=
 =?us-ascii?Q?kj5VKwL611jTby3O6HZ/cXygGR3sxD5mqZpcMz70SVXE5q7A3U1QHMyzryyf?=
 =?us-ascii?Q?vydtNMfotcbrgiaGqFivvB/EeSHxr+sMNughBCbIAZWKPlVcVllvrT29OktA?=
 =?us-ascii?Q?EgZkOLGp6dKCq7rBPnQrcXdvhUu0uyGIxErKQkj0xBWDuyNfvhJ17mrBTUT9?=
 =?us-ascii?Q?7oM168g7YR+cv8swTAIWihT2KRc5lIPRs2w5wtcp9s7TWTdaeX5qh9S0dvtT?=
 =?us-ascii?Q?GMfqMrp7SokeqdKE9srdYzG2bOj9XfvTYZL1FCcxfShts/wh/kgoX0Duq9mz?=
 =?us-ascii?Q?Z6xECh2WRKpnAdQ7sgWdHxtfhLvJpIz2Ccdc9LncAE3MORkuTXCzlfSvjTl3?=
 =?us-ascii?Q?tEpys8qC5kI9EEHcfTle+SBSWNF0lGTPSNmDIng2eyZeLa8BerhM3D/4zPHP?=
 =?us-ascii?Q?bv0uVPGK8Gs5872EmDnwNcIhvS4JIY2FajIRLlLlkLWSv7oyK9BIDYaVUEOC?=
 =?us-ascii?Q?pMcqgBSDlzKHDjZUuQrYRAAC7qMBVeOPgPa1PAa3tf/h8lVZ44pQ6vtTJIdh?=
 =?us-ascii?Q?TKH/o8MFu2zmZcRi9d8m7X+ppy7nH2gKFz8XNwZO6jGvhOfrs2wiq47Ehe+M?=
 =?us-ascii?Q?xY/jBUSQLe1ZPqYSntcGMVf1Jppmo5e/w4quxxPoJwuSfzySzKP5CcenfGzC?=
 =?us-ascii?Q?8Bl8Llw9q3zD3+/Z7MuvL+4xZEaedRdTvlgdl/5LILUPWyibajhlHvP1JzFJ?=
 =?us-ascii?Q?dxzVNNNcibNTCzeDi80WeAu7HZ9x7X2u6/ABwAG1isTCx+AI7cfwL/Rh7Rmb?=
 =?us-ascii?Q?3lpEisoWi6h7lFnowQBf/7z3aUdTHX1YwCYiB3H5iC8pPQq2bRkrr2uez6EL?=
 =?us-ascii?Q?vj9W0L4Du0motp1mLAutDmj3GJ5FoZfGWieDjnvU1th5ayf6xxCBzFEqsHNU?=
 =?us-ascii?Q?l1ILfKQu24iv69dzUaq6jX/8jGbpQFLMnXmVt4LlFd2UC624awR0gS1sNPtC?=
 =?us-ascii?Q?aCoXw3XNojhbvA9GMH0jqGr+mbgmpGwjNzWIEPRh9aEs+p0usrjvx8KPjXb/?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a790475-0182-4177-b67d-08dadef8a8ac
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 00:01:19.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5A196tt/cSXE/diVkTgfMaRU9ZIglom9hoSIZ4o8t4iC9D7NQBL0HGtK3QfD48R6jTs0fk/KyJhtA9v1VGojdUvfZpr4ae5dVGliOtrE8fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6997
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> By default the CXL RAS mask registers bits are defaulted to 1's and
> suppress all error reporting. If the kernel has negotiated ownership
> of error handling for CXL then unmask the mask registers by writing 0s.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Based on patch posted by Ira [1] to export CXL native error reporting control.
> 
> [1]: https://lore.kernel.org/linux-cxl/20221212070627.1372402-2-ira.weiny@intel.com/
> 
> v4:
> - Fix masking of RAS register. (Jonathan)
> 
> v3:
> - Remove flex bus port status check. (Jonathan)
> - Only unmask known mask bits. (Jonathan)
> 
> v2:
> - Add definition of PCI_EXP_LNKSTA2_FLIT. (Dan)
> - Return error for cxl_pci_ras_unmask(). (Dan)
> - Add dev_dbg() for register bits to be cleared. (Dan)
> - Check Flex Port DVSEC status. (Dan)
> ---
>  drivers/cxl/cxl.h             |    1 +
>  drivers/cxl/pci.c             |   48 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |    1 +
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1b1cf459ac77..31e795c6d537 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -130,6 +130,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>  #define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
>  #define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
> +#define   CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK BIT(8)
>  #define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
>  #define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>  #define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 33083a522fd1..64272db6a3fd 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -419,6 +419,53 @@ static void disable_aer(void *pdev)
>  	pci_disable_pcie_error_reporting(pdev);
>  }
>  
> +/*
> + * CXL v3.0 6.2.3 Table 6-4
> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> + * mode, otherwise it's 68B flits mode.
> + */
> +static bool cxl_pci_flit_256(struct pci_dev *pdev)
> +{
> +	u32 lnksta2;
> +
> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
> +	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
> +}
> +
> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	void __iomem *addr;
> +	u32 val, mask;
> +
> +	if (!cxlds->regs.ras)
> +		return -ENODEV;
> +
> +	/* BIOS has CXL error control */
> +	if (!host_bridge->native_cxl_error)
> +		return -EOPNOTSUPP;
> +
> +	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> +	val = readl(addr);
> +	dev_dbg(&pdev->dev, "Uncorrectable RAS Errors Mask: %#x\n", val);
> +
> +	mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
> +	if (!cxl_pci_flit_256(pdev))
> +		mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
> +	val &= ~mask;
> +	writel(val, addr);
> +	dev_dbg(&pdev->dev, "Unmasked Uncorrectable RAS Errors Mask: %#x\n", val);

I was thinking it would be useful to convey which bits are actually
toggling, otherwise this is just printing
CXL_RAS_UNCORRECTABLE_MASK_MASK which isn't very interesting from a
debug perspective:

Something like:

dev_dbg(&pdev->dev, "Uncorrectable RAS Errors Mask: %#x -> %#x\n", orig, val);

Otherwise, this looks good to me.
