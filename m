Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7266C35EE2
	for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ytyd4e53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703287893; x=1734823893;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JfREm/WHdHhCgB69M8cFTP1HELMRmc1kluoXOFd40zU=;
  b=Ytyd4e53tRCUlTpOuarkHHTUgVFrGPDwcaiPV/7RvOsUx0NKjWgApXyL
   gA8opcatBWXW789eSiIk5Yh/rnV229oG0zYZR3iXnHu26iPuWDAHgOJTq
   ZwJnXAj1c2Z+z0U/zprGsr+BZeTAicF5ZXYo17nj4Th3PAkf2HXhRVBxN
   BkWto3KtvieVit60sKYRN6RAzolGyEnQunLcINCG+yn+eGxg6Lp3fg/QL
   xIOUzAF+4N8zUZfe6t0/zj9xmKnrk0euTH0oOlGz8/2o/KL7d6mXyt+qz
   +hcb94RtdpLOzzn1Ffq8gU/lpiZShubNyx/zgTlcSc8BcKE7T/tWH/uHi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="395909147"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="395909147"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:31:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="753410652"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="753410652"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 15:31:32 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 15:31:31 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 15:31:31 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 15:31:31 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 15:31:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STxbfNF4KKIfdVZ05A7y6gelmcv5wp6YilcGh9vqxiN+SO1QqoweFDJVV/5w8H0RBaeCoSDMDpfJWcgPoowrycYYqEiTl+hcrZ3MzLuywkm0ab7Y1KAxTo/ARhvx+7UabFmvCGSErWnHOLFL6EGTrCswfI3Pkw7yXgFOM5wbIcES0qLMG4RK4UgdT6j2TYNY/ojpY2svsLng+cSodfkiN52cxxEvvXpICZHOWerwc9KQ4EDbR7kcpVVFkuYMMXttUVIlUQ00QBesqPRhdZZG22q0NoVwRA8gmjrhjV/PvXN7WQm1jjZHB0RVntpnVxpGEMUZj+HXRfsIzlMt7XUKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=melvAJwPeFJsNj7o1IPzd9f7oA7pckbz8EvipaYPVdc=;
 b=Apdsz8VIlhvw5N7JRSumT8HDtwy9jhTcIOknIPUxhJBJ8HkCJ98PsJzj4wwhbRc7/e4DHMJAZcECXCZINtKi7ZO0X1WoJhjr/NHYr8f19ngspwvWB5x8n36yAc0QPMACNpooow38BZwsBXzWlp4gCftaZWBgv1Gr09Uup3cMgddqQafPxQJPF1FbfsMlFcfPRiy37cbirnSTBB7NhZflWCzxvBbC4b2YACwGDCrEcUsrbflfVRFjChX3MVwwSZznmtmsRm+oJTXVAzZhHbbIY2Z9zsR5deqD+o96R3JGxejSMCy95kQCIFU5m3OPhfeC3/j3on9anp3W7avl0H5lFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 23:31:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 23:31:28 +0000
Date: Fri, 22 Dec 2023 15:31:24 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v15 12/19] cxl: Calculate and store PCI link latency for
 the downstream ports
Message-ID: <65861c4cb2fff_2581a29433@dwillia2-xfh.jf.intel.com.notmuch>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
 <170319621931.2212653.6800240203604822886.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170319621931.2212653.6800240203604822886.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:303:16d::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5163:EE_
X-MS-Office365-Filtering-Correlation-Id: c98f6fe7-3aa5-4426-dd48-08dc03461ec7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBhh73q0mdIHh/9tRT1YyC6FnjkxDVMMfYkA1WwfsNbQB7uMSIEwbPjc5R5fnzLRcDm67aQuNqmNNlReBgZzFoPfxxb0cnlXF8QEmet+mbAGZ8QWN03fb8T7yi1WtouGw/OdhDEERXgEoKUt0xxArEzkNVtPKtLBKuZoFLip7I5wVNzAlkBqNa1B0TGg+jqSocAhJRodchWLCs1U2Cj5VEdKhihRZEayGGtRb+u8e87l2PpON4oym7gzSg5FU0kp1mczgFSUuZYe3Cay4NPt5RSo5rnNtZ36ppHR/+PEXH5kSizr4W7qjGSIyxfJRxUD7YA6EEg/5x2wG4Eo/I6v3vK1giGsHY/hWIyk4kN3QssNSSSIK5lPxsdxZnwpX9joiHpaLqpe0HA/nrinhZfVuOLzsPUNyqWFZMhaEHEXQI1F5G8J0FYDnjaALuF37KbJpKO5yugYkj88pt3/DsexjgAvyfoclAfwz3fUr9zJi+2rbW5/ugMvnzaeR4pYYesVyP2GxHUDKYmhVyKaD0+DGa8gjOtqclBUltnsk8JPNiaMQxkjLn4dLRO3SZoeP3blf2oeWx5NhI98h0KYd/2ovAW1NND5qYblsv3JwTt60vvYK6cP7zvaHYtWdWKuK5bl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(478600001)(6486002)(4326008)(8676002)(6666004)(8936002)(2906002)(9686003)(66946007)(66556008)(66476007)(6512007)(5660300002)(54906003)(316002)(38100700002)(82960400001)(86362001)(26005)(6506007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mjEe6WBetR305361bST3ZSxglOAT1BOwwkOilavObrzjI2WtthK4N7ePEk3i?=
 =?us-ascii?Q?+jkswILO9EIM2DjbeUOvUVjSDRKQ5d4o63OOLR1pu9ASh7Qx16G3Nh/8Tttq?=
 =?us-ascii?Q?sBjur/LE3usvQtWhVxjAZzpf6fmaLbd4z+mC2bo8yjJshkdOdyOcJf+HMAqb?=
 =?us-ascii?Q?qLPsF8SIfwjOZPvJQOpmFQbdtFNo8NvAvTeTxEGHqRjXf1zbBye2Pcmm1MHb?=
 =?us-ascii?Q?HPUAa2zUhlcchrNxY3+ceX5MdS955UpVaDsYeQBt1tD+WcjEUsQ83kaJucAr?=
 =?us-ascii?Q?jYMLZ30kgPN3St2ZeoLLEaWQzQQNz6fTLQ1zyioG+jefBAoxOOz4bzs6h3bh?=
 =?us-ascii?Q?zmkFaxdDFQ/6o0sfffe2M1bIw6SeLsMhudOlKOKDGJsJR4mN4akAxIrwghlA?=
 =?us-ascii?Q?wUoNGzf6ZnjKJmflqW9bdhhlydhC1pDDo9D4yDBB6XAHJ6peA1n5ashfwxY5?=
 =?us-ascii?Q?kqMxJsCAh2oKg3AAQAZYa77QLZzCOFSz2fvUTuOf7fVfoUwfPRs9tX0xfbKl?=
 =?us-ascii?Q?7yjWkWwYcnUmWVl+sZTSnPbbN9J8PHUOI9rXlkh0y4eWTNPehtD0R3wnE8LB?=
 =?us-ascii?Q?4QHbWqR6VMLFgj9gF5IIgX+m0zPqhhsjZ3+JRJzlp8/stqBz8xVd4vv7iT4L?=
 =?us-ascii?Q?ld+o6TfoYZi6GcLI6RvzIGC7mOo4m6aqBWOMuojj7QlpQS4VHwY+JCOr0W+k?=
 =?us-ascii?Q?Bw3yinm8uOGk4Tb5z8l6WyMlLd3nz5c26FaShHbT+c7bInKmTau/VNG7s7yZ?=
 =?us-ascii?Q?djij7D54V2wE7lsuXsjt78Fub721W3QBnNz987wt7zgZzf57GPVhd9M3tE+U?=
 =?us-ascii?Q?POxkGL8uZUpe+9W1hGA6hAECWa1vKeqZVPlkco3wG8jgdkMlM1xWMo/FVZQ0?=
 =?us-ascii?Q?LCYnCBcDG9VeKFRL0e6FD2SKA+WW0sPRg31tbAFx3sX2HCgTxtT8NTjGsDhO?=
 =?us-ascii?Q?uDIRRzqcAK+DRsnKXXsdniDkqlYxJiOtipuV4K8CIU+NYxFhmIaxz3nuVXuy?=
 =?us-ascii?Q?TUG+vnBDmgca7xeXU//5M0lJNHybSiYnLAPBjQV4h2ZZyZidzjLszaTEZLzZ?=
 =?us-ascii?Q?CM6emVe7TDmvzATGwyA/NeB7lLD0i0+16hGeZelJ3cb5EKT3iJT4GhoXZRSp?=
 =?us-ascii?Q?Yp/eHne1QsZpqh8Uj+6oQ8hTXcDBfu8VShpsp/BWuUB0fOJAumNyE8qu05C1?=
 =?us-ascii?Q?Nn77TZSSODT8OUCLtkdDYlTVQkyDjxZuOjVmCLQ34Ul7tRMGhzWZ8nAar8i0?=
 =?us-ascii?Q?9GNJzT5a7oa8MjSlG6VpYDlINhvZasamUv6Htn7gSZP0FXdSGo+3YGeX6RLL?=
 =?us-ascii?Q?AjHMT4lr+1siSfLmu8U64JWbOjTSo7BmAgLFph3iCRJbqu5rPTGrJhVckhpe?=
 =?us-ascii?Q?ZutUtL2CIP/5bWlQDKH7v95M8V1feLex//Q01HxaEIQBtiEEbuzfmYx4Lq6d?=
 =?us-ascii?Q?HVWdF7/ni6RTGeGjFz+QoV30iOAiz9erCtJ8S2XSVYDm3CD6cJiKy+bLO1P7?=
 =?us-ascii?Q?LbAihQiQi0uCtwFJdVjgUTyCwoK7+wU8gGiHz6FdqjQD/kgmNtP3zIVkjglb?=
 =?us-ascii?Q?i6mZmzH83X3I1Rvt62iKfMfMWpH582LXG9JICaoW/GYeDqVUIhORGxk86qlt?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c98f6fe7-3aa5-4426-dd48-08dc03461ec7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 23:31:28.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7E5JuTMuBi98pqbAq9Bgo38wJnwz6vXOTCEsWZyL7UYkufXNBcS6+Yfk1oj916o6BjMvMGmw4GmunQ9SFmTH6ht+oNPoLDpOoS8Dp6Gc2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5163
X-OriginatorOrg: intel.com

[ add Bjorn for the new changes to drivers/pci/pci.c ]

Dave Jiang wrote:
> The latency is calculated by dividing the flit size over the bandwidth. Add
> support to retrieve the flit size for the CXL switch device and calculate
> the latency of the PCIe link. Cache the latency number with cxl_dport.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h |    2 +
>  drivers/cxl/core/pci.c  |   72 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |    6 ++++
>  drivers/cxl/cxl.h       |    4 +++
>  drivers/cxl/cxlpci.h    |   13 ++++++++
>  5 files changed, 97 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 86d7ba23235e..3b64fb1b9ed0 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -88,4 +88,6 @@ enum cxl_poison_trace_type {
>  	CXL_POISON_TRACE_CLEAR,
>  };
>  
> +long cxl_pci_get_latency(struct pci_dev *pdev);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index eff20e83d0a6..a014d49d2f12 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <linux/units.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> @@ -980,3 +981,74 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, CXL);
> +
> +extern const unsigned char pcie_link_speed[];

Checkpatch complains about this definition:

    WARNING: externs should be avoided in .c files
    #48: FILE: drivers/cxl/core/pci.c:984:

...and really it's a PCI core internal that others outside of the PCI
core should not care about.

> +static enum pci_bus_speed get_link_speed(struct pci_dev *pdev)
> +{
> +	u16 linkstat;
> +	int err;
> +
> +	err = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &linkstat);
> +	if (err)
> +		return -EINVAL;
> +
> +	return pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
> +}
> +
> +static int pci_bus_speed_to_mbps(enum pci_bus_speed speed)
> +{
> +	switch (speed) {
> +	case PCIE_SPEED_2_5GT:
> +		return 2500;
> +	case PCIE_SPEED_5_0GT:
> +		return 5000;
> +	case PCIE_SPEED_8_0GT:
> +		return 8000;
> +	case PCIE_SPEED_16_0GT:
> +		return 16000;
> +	case PCIE_SPEED_32_0GT:
> +		return 32000;
> +	case PCIE_SPEED_64_0GT:
> +		return 64000;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}

This looks like pure PCI core material, not anything CXL specific, lets
move it where it belongs.

Will fold this incremental change, Bjorn please holler if you have
objections, otherwise I will start this soaking in linux-next.


diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7551dee1c7b0..6c9c8d92f8f7 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -981,42 +981,6 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, CXL);
 
-extern const unsigned char pcie_link_speed[];
-
-static enum pci_bus_speed get_link_speed(struct pci_dev *pdev)
-{
-	u16 linkstat;
-	int err;
-
-	err = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &linkstat);
-	if (err)
-		return -EINVAL;
-
-	return pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
-}
-
-static int pci_bus_speed_to_mbps(enum pci_bus_speed speed)
-{
-	switch (speed) {
-	case PCIE_SPEED_2_5GT:
-		return 2500;
-	case PCIE_SPEED_5_0GT:
-		return 5000;
-	case PCIE_SPEED_8_0GT:
-		return 8000;
-	case PCIE_SPEED_16_0GT:
-		return 16000;
-	case PCIE_SPEED_32_0GT:
-		return 32000;
-	case PCIE_SPEED_64_0GT:
-		return 64000;
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
 static int cxl_flit_size(struct pci_dev *pdev)
 {
 	if (cxl_pci_flit_256(pdev))
@@ -1044,7 +1008,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev)
 {
 	long bw;
 
-	bw = pci_bus_speed_to_mbps(get_link_speed(pdev));
+	bw = pcie_link_speed_mbps(pdev);
 	if (bw < 0)
 		return 0;
 	bw /= BITS_PER_BYTE;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 55bc3576a985..00817d403ad4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6224,6 +6224,41 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
+static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
+{
+	return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
+}
+
+int pcie_link_speed_mbps(struct pci_dev *pdev)
+{
+	u16 lnksta;
+	int err;
+
+	err = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+	if (err)
+		return err;
+
+	switch (to_pcie_link_speed(lnksta)) {
+	case PCIE_SPEED_2_5GT:
+		return 2500;
+	case PCIE_SPEED_5_0GT:
+		return 5000;
+	case PCIE_SPEED_8_0GT:
+		return 8000;
+	case PCIE_SPEED_16_0GT:
+		return 16000;
+	case PCIE_SPEED_32_0GT:
+		return 32000;
+	case PCIE_SPEED_64_0GT:
+		return 64000;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(pcie_link_speed_mbps);
+
 /**
  * pcie_bandwidth_available - determine minimum link settings of a PCIe
  *			      device and its bandwidth limitation
@@ -6257,8 +6292,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 	while (dev) {
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 
-		next_speed = pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS,
-						       lnksta)];
+		next_speed = to_pcie_link_speed(lnksta);
 		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
 
 		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dea043bc1e38..504a4ba2c29e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1364,6 +1364,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
 u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
+int pcie_link_speed_mbps(struct pci_dev *pdev);
 void pcie_print_link_status(struct pci_dev *dev);
 int pcie_reset_flr(struct pci_dev *dev, bool probe);
 int pcie_flr(struct pci_dev *dev);
