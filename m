Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61ACC61DA4
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Feb 2023 05:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjBWFBO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 00:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWFBM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 00:01:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46A736685
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 21:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677128470; x=1708664470;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zcDz1eG6i2RyyVbeg+NOqQxND5x/vUl1/wOahwvpeUY=;
  b=fddLxN7WJC8+QZ5pLPRyHQFV+s6nCO8Ye1RLzcUYEVx5rOZfa0jwKQ5s
   hJKbw2oB9p3OIJasgv0itPPEYAmWjcKW7aLrrn7WoOclsMStBUQlWDfpg
   XkN6FyZMlvbNMwUYBqSo8lSIFZtxHqr6Uuh6wjwNHFeTyDNu71OjpL2qX
   eO7E4gSTRJDHMvlZYjKmBt3+TathWTDd85U1erMzpElSF6nBvDjXpfDci
   Yusl6EI9g1nIsqSB66MG0I10rn8hK7RjZqUhRPun+MC/bVswl3K9N4f7q
   vDjYy7+wBSycDF5TeiaAs45CPxfw7rwxTNhoSgdv6Z1YpEthEtlPRpd88
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="331785940"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="331785940"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 21:01:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="741125919"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="741125919"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 22 Feb 2023 21:01:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 21:01:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 22 Feb 2023 21:01:10 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 22 Feb 2023 21:01:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/yh5CoFi7BYI7yhvNCUBabXn1cpmJzpweoG58GOfszHv/7Nqq2dzt4tRS9y9dIG3n0aqbjcG2jJWxR5xsu/ER2WxiP8Kevxs9eBzvrkVt4Tt5LoBZdnjmshG5VDUdaHV/F3O5t5/EZfBYsztGXZE9EpE4+nVhdAbOkLKEXa+m1RI4AuBnQQKEikSOx3J+lzw4aY9yb8RA3YLRCjEzQvnQT53ou79pG8ZRxF2bdurChK3rL6aY9qtNFW3k68qw36sse9t1IcjGHXrbaSvEqpCf0PJoXujLLbZcmvccnz2JUTfzS2hwLoQphpgeOh223UqtxJ1LVPw6sPiV1dyIF+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvOa5XaN7xwj/XW8i2v+cjCl/QALxgWB67Ch1fdCjhk=;
 b=GHRZvbHZ3mDUOqzh6pIGnuibIi26+ZMLGiu8g8KTYLosIDzyUyUBwBXyu5lrBFdVjhSSFGuBMKTF0rVYAUBqHfui1sP98kg5tIg0t/lj8TNT5ZCkArq6wkz9N1WgW//fLWB1RKazjoBU9f/QVuTudoXDbCj/RbBwO51mFbuj/+mXlFMMmRdjdBwhoT3+EQfPJ0AYcRj+pOGQ/RKaAHoS9oySJ3ivhhO1L6xODfOngMFkLCgh3OJGyxV7SJ/aB5bAgfNxjpPIS+8A9s91LLyQgqTYmbQp7imeIya4ToaeV/a11JipIq1LaAw/uB8CrrVSTyAsbEUe6+TPgCyFXtFkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB6694.namprd11.prod.outlook.com (2603:10b6:a03:44d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 05:01:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%8]) with mapi id 15.20.6111.021; Thu, 23 Feb 2023
 05:01:07 +0000
Date:   Wed, 22 Feb 2023 21:01:04 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <lukas@wunner.de>
Subject: Re: [PATCH v9] cxl: add RAS status unmasking for CXL
Message-ID: <63f6f3103f092_1eb6b3294d8@iweiny-mobl.notmuch>
References: <167700213490.106661.13890376014908981260.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167700213490.106661.13890376014908981260.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: BYAPR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::42) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: d8dd9bd5-67b1-493e-cea8-08db155af912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpm9o99lpWhz3fsWpRLsWFvKBqHP4ynczLT/siH6CmoOttCneQBUaQ1navdAiwco3HN1GPtY7Is30GtbtaAFaR4ZqunzIdRx2WO0Y8L9aSLZUc2OgZdA1dWph53w0tfeCVoxdPuZMkMfe5AFHAda6O7f3M19yKVuLkMblDkxaVALpBUDcrxTQwmjs6F1gMldFCgyraLNiKkWoe1JIBh9JOSeEC7pFZ5nOxbLQukuhc4PrF0Cgu7ahz3PYYZa9OVx5keODBz0yU/yZBwfZAICNq8dLsT58HZjPGPX4TxvCUgt87gvoLEvFBINEqLehqHheyYihH4KCnLlrqPyb880O7rrZucevu/pgGXBZP1ucL1OPwOt9p8yAJzPk9zMIgwv9cVcOT8CaoQhsNNmfGnj36imMNeRM46bRlDIhU6UHYufeazJr5DDXnmwAXfGk0Z6K/UVl3BtdyG9+5XBZ3zC1TyV8WGPg94XN6pVdC5UuDVPefxBqjM8tncoLtoS/bgzcBn1EBg5YehubJpE/BXr1s0T+oO869duQvyhyPhyNxY33HUS9HzIrDj/xG5GFqnSfGLHeAvfTnM5UfAqhuYRfRs82aLjteIUweALDcsRVgz+QNgN8usJRrCFNcCZ3w6F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199018)(6486002)(6666004)(5660300002)(966005)(6506007)(6512007)(26005)(186003)(9686003)(478600001)(54906003)(316002)(38100700002)(66476007)(41300700001)(8676002)(4326008)(8936002)(66556008)(66946007)(44832011)(86362001)(82960400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IKCp9FvPmfWG9JCiHq72dUlxFt8QOlQVtdhmrj11TB45dV4nr867WtHw876j?=
 =?us-ascii?Q?U8rBpBRjWxFd+p8fxbwjGbpE7B3xNDXXEr1/JnS37NXYhyxApDilsarlaQ3t?=
 =?us-ascii?Q?UlWcQyuMl0YZH1Z9zpyA0sIP9kj8YeRrY7uMA+bgGvCq4OOU5oJ+J61hIBVw?=
 =?us-ascii?Q?RrQwZdOKOguIdTP01APQ/0lfm30eE0CBNmlDKctuuQKgWn5qAszbQYn7tdCj?=
 =?us-ascii?Q?UqPRRoy1Uz4RBrNyA5ppTK/M18HPFIYreJEQx4w67gt4FraASrFjUUWa5jdZ?=
 =?us-ascii?Q?wYjfmndzv5EjLfX6VEYohaQWspFsZswPNvKeaTt02VmEd2G1QPDQZEaW7NW2?=
 =?us-ascii?Q?ELcc+PhWOf0hh8N3slKtRcHguUI7JByN3xmnWLPuWjRxI5pd3BziIJm6zsDt?=
 =?us-ascii?Q?pnYemv6vOBe+9fG1bp9p90/bzmbKa1iRXOR/dC9fNmY0p7O1nusDAR+76rzm?=
 =?us-ascii?Q?dNIFEGLyxn9pPeCvA2eeCxiome3RyUNgi1HQkv9UMjUGEdEWKHTKJcLdViB7?=
 =?us-ascii?Q?6SFIEkj4Dc/eC3mKlApicFSggOoDGDmwOFZU7RsmPezV7HoVfth6/KUl8sjf?=
 =?us-ascii?Q?Dv93RnOYiqKnD/BEEFqaVpl9hEyZC/+AHXAH/B6swyhv8kAwuRZCJy+G+cNN?=
 =?us-ascii?Q?Nr8K0+vTzYZoA4WYyhkXUONkmJ+Xl6UxdS8IlOUTQXSS+ikes8UaZTRTaH3r?=
 =?us-ascii?Q?x2ClvPlGE02R15y8CXm4e33cnP2LCaxllnKRd4l/zrizeqwP2IRiF645J/0f?=
 =?us-ascii?Q?3d9Uy5SpoonQve227jWjBYBFrSa1LrlLPnr8mYOSaE7403LxLsXf9fllNi82?=
 =?us-ascii?Q?w6wHvXH786B5jQuBYYlIDcsDNdImiHRSiSg0KCN68F+MQW2mPZSvKhF25hWn?=
 =?us-ascii?Q?NUP+gcaPOuX6I67rE0KKxDGTKEtS4ifD7s0rsskU5Jnsi9/AxzZPV2TNMBSI?=
 =?us-ascii?Q?7GN8zr+JLm3G/FPo3srzOLFJICiaNo+BGwRJfGffu2JLZJygjhDB1qybIBxM?=
 =?us-ascii?Q?nfKzs7uziLLrNICV15Tf3sJrIlpmFrtwjb5Z3rj7kCHVSoa1CInZyy/FFDCt?=
 =?us-ascii?Q?lrmnFkMa3p2Pm06ls/5bLOB/hxaRtqh2aO51Sm7tsZcGobLDFbM0C0LjuoTD?=
 =?us-ascii?Q?i5e4XKY8wWuoWJo+3JK28Pxbe4+aecYfL1qUwNvvkYwLLoVvc4KXqqMt93Pc?=
 =?us-ascii?Q?vyv1+aeOKzRW99q/lIU7uQ3S7qfQebkDvWExbDGxTC199OQTx+Ay/0yNCOni?=
 =?us-ascii?Q?eAC7hca2yI2toMMzzHFZ3T6SHLB207jZS/hxvLIU3YuBaSjsaWdXlSqiL2DE?=
 =?us-ascii?Q?Nf9HikWveK4212dvPoWusDoQh9mPk1iY4SoiVhHdWtoNupZoh4tH8c3VebqP?=
 =?us-ascii?Q?TSX1jhvpqIJ+/IUM8oITb7TsItARw7HGsc3ZI+3SFDIjpN6oDSm235lb7kyJ?=
 =?us-ascii?Q?+88u+jzOj/KTukFQOKaST9OJZLqhgAaBmtjYkruFQzMWgUM/Zq7HcF102or3?=
 =?us-ascii?Q?8IDgTVas3hJKWYpE9knF4ifAeKLfGUjaXfnQsfSOMwBQNtpAqwofoug/7IKp?=
 =?us-ascii?Q?/XE0kZDu4P53T0W/QGrbIWviG46ywZ1VNQCyb8RS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dd9bd5-67b1-493e-cea8-08db155af912
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 05:01:07.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdweUKHUPHfc3RCSx/KX9A0SZbJ66YT4JpkVaj0Y4CFPUhiptfpD2zx/sL751ac2hfooKhW3xdlr6SIkCLtiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6694
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> By default the CXL RAS mask registers bits are defaulted to 1's and
> suppress all error reporting. If the kernel has negotiated ownership
> of error handling for CXL then unmask the mask registers by writing 0s.
> 
> PCI_EXP_DEVCTL capability is checked to see uncorrectable or correctable
> errors bits are set before unmasking the respective errors.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_regs.h
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> Patch based on top of:
> https://lore.kernel.org/linux-cxl/167632012093.4153151.5360778069735064322.stgit@djiang5-mobl3.local/T/#u
> 
> v9:
> - Move dev_warn() to dev_dbg(). (Dan)
> v8:
> - Fix lnksta2 size. (Bjorn)
> v7:
> - Check PCI_EXP_DEVCTL to enable related RAS errors.
> v6:
> - Call cxl_pci_ras_unmask() based on return of pci_enable_pcie_error_reporting()
> - Check PCI_EXP_DEVCTL for UE and CE bit before unmasking the respective error reporting.
> 
> v5:
> - Add single debug out to show mask changing. (Dan)
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
>  drivers/cxl/pci.c             |   65 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |    1 +
>  3 files changed, 67 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b3964149c77b..d640fe61b893 100644
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
> index c87340095a8a..b6882c2b26d4 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -637,6 +637,67 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	return 0;
>  }
>  
> +/*
> + * CXL v3.0 6.2.3 Table 6-4
> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> + * mode, otherwise it's 68B flits mode.
> + */
> +static bool cxl_pci_flit_256(struct pci_dev *pdev)
> +{
> +	u16 lnksta2;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
> +	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
> +}
> +
> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	void __iomem *addr;
> +	u32 orig_val, val, mask;
> +	u16 cap;
> +	int rc;
> +
> +	if (!cxlds->regs.ras) {
> +		dev_dbg(&pdev->dev, "No RAS registers.\n");
> +		return 0;
> +	}
> +
> +	/* BIOS has CXL error control */
> +	if (!host_bridge->native_cxl_error)
> +		return -EOPNOTSUPP;
> +
> +	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
> +	if (rc)
> +		return rc;
> +
> +	if (cap & PCI_EXP_DEVCTL_URRE) {
> +		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> +		orig_val = readl(addr);
> +
> +		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
> +		if (!cxl_pci_flit_256(pdev))
> +			mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
> +		val = orig_val & ~mask;
> +		writel(val, addr);
> +		dev_dbg(&pdev->dev,
> +			"Uncorrectable RAS Errors Mask: %#x -> %#x\n",
> +			orig_val, val);
> +	}
> +
> +	if (cap & PCI_EXP_DEVCTL_CERE) {
> +		addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
> +		orig_val = readl(addr);
> +		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
> +		writel(val, addr);
> +		dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x -> %#x\n",
> +			orig_val, val);
> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -728,6 +789,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_pci_ras_unmask(pdev);
> +	if (rc)
> +		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
> +
>  	pci_save_state(pdev);
>  
>  	return rc;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 85ab1278811e..dc2000e0fe3a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -693,6 +693,7 @@
>  #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>  #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>  #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
> +#define  PCI_EXP_LNKSTA2_FLIT		0x0400 /* Flit Mode Status */
>  #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
>  #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
>  #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
> 
> 


