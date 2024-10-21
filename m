Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B616A92E;
	Mon, 21 Oct 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543666; cv=fail; b=O/d58Fbtdowq2yfad6IauwpoFRPG5VQaZcaZ00ow1BGvEO80fWtDyl8kmTLfARk2zK4FQKIqGhJzY2Q33yit7t8JXqd6a14W/xaqZ3X6gfrepVepyo3LslV/OuJEpMmzQtoKXBr6cZxkhnB8lzz0zd6UJJhLRANi+NOlkdTtxlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543666; c=relaxed/simple;
	bh=4xgANML8DWpru0ni7zaFTN+UyQOy1ps0dvtP99ODs/E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u3PLcwCC04rCjmuSras+PaHkWLIVWRbie5S5VDsxQHANSEDb5PD0uNUc2qi+SY0ppb8PQfwzliizjN1anqYG9dga9uq39xAT+XSWhfVUkGfAKjcQ0+umYRp3aMSe0+enlp5rxo2yfFOoPeB1UDT4nQP3cru93WXFNNmJBDHJAfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrfNI5cv; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrfNI5cv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729543664; x=1761079664;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4xgANML8DWpru0ni7zaFTN+UyQOy1ps0dvtP99ODs/E=;
  b=GrfNI5cv6JgJoE//P24Fcyufe4eHKLsGQ6OQE5sd5iJtplW0iStheCHU
   v6ZFn+kvDRsQo74YlL6mir+mQAO7AmQc1RRCnTr7w1wG6jp6NRG4aFBoV
   kJacpK1OEVjKBkNENCfKAYb0MSSgs6QgDZ5gxFGuzNm0mT1kkWMyKQH2U
   IAUeN6ZGYoN6AoXuVz/Gy4FP3nlhLTuZvmnMwLls+ui6f2fNcff1UC892
   +maPusNpdf10Zk3lkKl9y9ZpGqgPBIexcEODZVrRuet/gnhLfo0KXlWYS
   fhj/HtZaIeWO87jpAmKXjBwa0ZjklGjC+mYfxZDS3aXb9CWHi/8iq00UU
   Q==;
X-CSE-ConnectionGUID: MLlotu0zQ0OpMl9RnVjm+Q==
X-CSE-MsgGUID: F/G5Sk0lRi2+r0HKO9p1pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="16678497"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="16678497"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 13:47:43 -0700
X-CSE-ConnectionGUID: ovgafvNfS+GNresQ3u5yEg==
X-CSE-MsgGUID: dYadGMq6QJCZ3BI9WRK8vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79814680"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 13:47:43 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 13:47:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 13:47:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 13:47:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YINVWMaYzvFGAXa832/Tl9TXFGXgJ9bGdxg///EmyUnbJH9RWER6Mk+Nt5J20noi6Kt3dVwQtCF5FFPIhQvIh+0FQtB4qfi/4XpY0xIWIhGgXeXdl2GX1GLRdvgrR5BXj4XOvH9OCdCSiBCDc2/Qe2yuHSKS6vI01ejhSwgBayB08CcNvc8EgKK/ZbgV49vf0pl4NJC7PuBPcv7aZe6abGGvHsDYVqArfFGFUgWTlARklTq9JGyAK/w7ovtFXPi23Yv4MLCrwWMIWW/7lPXYJWoQwoPKx/FMU23bBG1srvu5ve4MEHNgiyacTM18cM4mhn2x5UzH+blwwaQj+E1OoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpAWpB0894u8/mgigDpWmq3DqZe2RAKtXg6e++0WqJs=;
 b=HedMO9+6Je7mcqk0KAt/bBury/Jmy2wnFimzeY7hnsLFn2RI765XVscHbxRy9dMcz8wXz7YZ/4ThWtp15X2n4PFYfdor2CAF/nBwudIo7i2xfhzqqDwcJ23pMeVQu6WnpNQAec7dU90F8ftzvRI5eF9YhmJtVinTkff8B80NEVih4YYF1cjVhFl2rnRK0UBNuep0vehB8a4ak8KDy6lvI0c53FpCraz+1MMQAyQLay0ufaYfMr75Fs7fpsp2rmOSQ0BB5FElxeuO1Wo/J0sEWH6eBC9Go8T1rvZGDamhxZ6e0jLcJFYQkzzzswCa3akO/ISaGx1XjMEuCCZ7QOZvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5101.namprd11.prod.outlook.com (2603:10b6:a03:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 20:47:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 20:47:31 +0000
Date: Mon, 21 Oct 2024 13:47:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, Dan Williams <dan.j.williams@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] testing/cxl: Fix abused pci_bus_read_config_word() on
 platform device
Message-ID: <6716bde0a5337_3ee22944f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241016015213.900985-1-lizhijian@fujitsu.com>
 <ZxGqYPGNaVWoLuP6@aschofie-mobl2.lan>
 <6711b7c0c0b53_3ee2294a6@dwillia2-xfh.jf.intel.com.notmuch>
 <627bb352-29dc-457f-a383-0dd399f55ab1@fujitsu.com>
 <6716b7b18a1c4_b8f1f294aa@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6716b7b18a1c4_b8f1f294aa@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5101:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e463ad6-ab8b-44ae-35a4-08dcf211951e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ne0JgONEIASO/eGPEL5VlDlLYy8beejrJ1bpPn9disdTZ01G6WwGCxED5fk9?=
 =?us-ascii?Q?AmpC7AJ5/7y6/I06MuSE41bZMvJ1dZslEwI+9+X763p38fq1Cj5440P6MAsq?=
 =?us-ascii?Q?6NH/AEMouqBdCM+169vYWKo5MbIofrZdXRKH/j241+27VDtmHVGOHai7iBMw?=
 =?us-ascii?Q?KkHcC5BGaOuSBTyePMt3+WiA60XqfZCLnRZF3/zNBhTUSbyeGyucOmaOeJIZ?=
 =?us-ascii?Q?LdhQ+3mZ9jNTEv1DmLK5FybINB3wOniNPNl1VqvKfbbkn4ucxGBc89kToafx?=
 =?us-ascii?Q?JrlJDntNekDo23L7zRrZvedv2sP5BitNYaQ1hDrWSKNTnRuoLTcUpv7E0yF5?=
 =?us-ascii?Q?Z+sOheqRMdGzcg4EFSbsK/6FlSliz0rCzG46YnALllRcG5x6gEZo1BpnzHeE?=
 =?us-ascii?Q?UY6V+gOH6Axv8/12xK5dYuA3vz8ueMXJSdvRWMmVx2IvmUMA7ETkgZP8edMb?=
 =?us-ascii?Q?ReKI7vJuaq3AsDAs/BlqeVkn8hAw6kXgXXGo+a/caRCTgNfLujj7rAoYlw7S?=
 =?us-ascii?Q?OjNKdAhEU1kxXagpzj6rWeHiKb558s+kKIhoB6N/tpOeSRbgr7KxOXZ1VD5c?=
 =?us-ascii?Q?8365RAvdOwYvcG/O0LJcBI8rOl4KT2U4qi3JANrHg7kvga1Ynt2JL7fPZTPJ?=
 =?us-ascii?Q?w3+ZPMDfDNlYnJCDpf4mUydk3VcwSLi06s6wV3DH4ibIZKLw5Ue4pcyowCNf?=
 =?us-ascii?Q?j67rKZjeFBuZNDwSGOzKuPx/PSSMT/NrROBm6BOLNgd+jzvGbA7eqbRGP1c9?=
 =?us-ascii?Q?nToV+dGgKacRKeX0iXuD4DZw6pgPTPBOvT5SCWbOkYF5k27IhSsqpeDfFDj+?=
 =?us-ascii?Q?aZ2W4QYFTvBUcB+H84/pHEKzdb49sgqFci9X7xTZBPcC9FZrbNRnRBCnL1wf?=
 =?us-ascii?Q?nKqEzdT/iyYV9gEgFjZbrWqJ9W9mAoFimx0vvQrbC6jHCd/cid+p1pk55vu0?=
 =?us-ascii?Q?BTF95aMJXtzAHA2S/zYbM3atdTyFDs/Y4NfpbCpiqa2670+O0e1pavpXhM4v?=
 =?us-ascii?Q?JVoGV6QNYokD9/2ewA541UA5X7+97fGmrkcH+W16WVmZ/2FcwZigtYEq+y2/?=
 =?us-ascii?Q?yGoF6pi4+9sHl6OjAzM16Y81VWeqfFw7bdUe2spuvc1r5WjNFBR6mLHHNnf1?=
 =?us-ascii?Q?7gv2s4a/yT6wMqEp8QZSIJ5Lx6sMUmYceKTQ4ZEHuwtKJc03/EVPGi5zGslm?=
 =?us-ascii?Q?3xM/pUCQv45EoZ3iXiti3XvmnFS2xgeZYdglS25cVBOLd4AyqjTvHtg7xsLD?=
 =?us-ascii?Q?PHypWOu3/iKsgDMBkCA4nNCiDGvgeXXsBqsBMVbcvgSSzsoj6Y5FD/FpUPJP?=
 =?us-ascii?Q?fDakZEpjOvxBBaRugFF8UOMr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m9oLLV9lhrLaEaIROICQY0Ii5Vdj+pTnvePFKdbiZu6Ia7/2SVoyfn8jk1Uy?=
 =?us-ascii?Q?UufiuYq71ZfNcgScssAnNlEWgSv19xlGbwWhj6a/QRvo28wJwk5txi4h5rPN?=
 =?us-ascii?Q?STTWkaAWofgmWUxY3sfZGoz9KvMYbyHQatE9uE/eh+5T/pisX5R2JULeSoao?=
 =?us-ascii?Q?IDtc1s8TKKWi5J1NmSUORRcTtohCCWAMekLzM7CA6Aj+Zlkc5Rvgiwmm0eV/?=
 =?us-ascii?Q?k7XPOC59z45M7sbpNfFsPZWeoRJ4hC0oHwEntWVf2A8myZPCFhjjztddbmXR?=
 =?us-ascii?Q?VNQtqZKiVyNFdFHe+hqgrG9rtYn1wYZMR2X+nL+xdWE5B3Hb2HIvUhF04Hcv?=
 =?us-ascii?Q?QcyBybREjM+lqGaqFT4cVf9kGAtrgKF43dOp40Ztrfk91xDcZnL27fY/YEpi?=
 =?us-ascii?Q?8koOovQoGTItQvkjuXV6a6YyVI3Wey4i7VYtJxghuxSvicww93qP7Hm0tzyW?=
 =?us-ascii?Q?peHh44nl8d7v2jTkfoUhmiIMETJNUf6sJeKb8OcCJWMHZl2DqmhXsjefMil/?=
 =?us-ascii?Q?v4avQZrlATrixSLBMohchQuu4u1UljSoEoRoY0yRLIaB634oddmRl0E2EHIO?=
 =?us-ascii?Q?6VsRxUC6Ca2RoWUCzPKf7Roosqa9m7b+VztAv5BeaBo5EiHl8t3+S84eIQhX?=
 =?us-ascii?Q?rSValmN0f/DdAjVQYVdYziT4OMBi/zLl2wK2/oUxpu5P+hFH3umHvbdyFQ2j?=
 =?us-ascii?Q?/zbxD318HQOxojIq6IU0dRpPam7w+21dJYPKO3TV9gNnRH55Jz8S9srsLqvH?=
 =?us-ascii?Q?eKecgNWCjxjQew+3Qm+UKQsbbXv8TYgrTrlel2bN7eMUqGnma/w8is2C73x8?=
 =?us-ascii?Q?GoS/7LWIt036g1+3NOJPQLLh7xmNWPICp8tZgATSY21Vz6mouUos8NfkkRbW?=
 =?us-ascii?Q?CMQ1n3+W9urfHQudZCx2P5A3JwwfqPa6zu7OMiitgdatinYjpDfjcNWMHp1W?=
 =?us-ascii?Q?O3bZAFltSLfQeQITEvEnTQuu/3LB4dhFZp24kqADgBmKIKVw2A6TMlY8JC5E?=
 =?us-ascii?Q?6GAt2EG9VtxqBRSEdLd5lqOxdVDlNwroe++AHxTRDfcI/Kac39h7UVV+nVYs?=
 =?us-ascii?Q?huIPKiP19kXSxiJ7XfdooXTub/+un4FSzoXNa4N2GpbIsE7l6V23U1PdvZqA?=
 =?us-ascii?Q?4HutbVagvSWy+1OEQXJ1G3vhYGJLgeF/ZhmUJstlHFyBF45+tedco/+d8kUf?=
 =?us-ascii?Q?GS3/HggTGN2C8OalFAxkAhMBtPadm6uGN8f5Ek9zc1MllVrsvdnBqDdpEHac?=
 =?us-ascii?Q?McPrq/aQIYOdYiUPBQDeajrz9E2Qq6RCBFCkeAbgIHDcjggau3B0OlYmCtLl?=
 =?us-ascii?Q?OmBvCJflXBJMHsYP4WY9mIw3P9l4zdWe7jm/NBqMaqh7WX2IbgMZHV4lqe4e?=
 =?us-ascii?Q?ZntLeuPNP6p72kk3JUt+Rb5rmq2HSyjHZLcfsD13TLeJa3Cw3096CI5LHFKV?=
 =?us-ascii?Q?1ODYDwGu1KYB3KJSGdXOyYKMUfs2U5FxqiLKbZVFnQN8o1y9rkwlPOee0GMY?=
 =?us-ascii?Q?IU0/+W8utakA3leJ23XwLgdbAIrWZbUxltfbFSWbdkzbbuhUo6xIFDO+XO1d?=
 =?us-ascii?Q?k7FSx4JblPcBhcWgzsK+Yy9ihOi7fcFSx4ByGMNqiyhwLBUsFwXP1SGljErk?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e463ad6-ab8b-44ae-35a4-08dcf211951e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:47:31.1642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDecXwqbVTKNEIZJTYDsoGSHk2XxLmVRiMRcKoqO1UtCWCeLd8kh0VioYxC83jih/YmPteKHBxfvQ6PNOR6e20hAp+q5lQaECvLBFtdUZYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5101
X-OriginatorOrg: intel.com

Ira Weiny wrote:
[..]
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -5,6 +5,7 @@
> >    #include <linux/fw_table.h>
> >    #include <linux/node.h>
> >    #include <linux/overflow.h>
> > +#include <linux/platform_device.h>
> >    #include "cxlpci.h"
> >    #include "cxlmem.h"
> >    #include "core.h"
> > @@ -641,9 +642,13 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
> >           void *ptr;
> >           int rc;
> > 
> > +       if (dev_is_pci(cxlds->dev))
> 
> Did you mean...
> 
> 	if (!dev_is_pci(cxlds->dev))
> ???

Yes, skip non-PCI.

[..]
> Couldn't this be done on the endpoint call?  (Making it non-static?)
> 
> int __wrap_cxl_endpoint_gather_bandwidth(...
>                                          struct cxl_endpoint_decoder *cxled,
> 					...)
> {
>         struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>         struct cxl_dev_state *cxlds = cxlmd->cxlds;
> 
> 	if (!dev_is_pci(cxlds->dev))
> 		return -ENODEV;
> 
> 	return cxl_endpoint_gather_bandwidth(...);
> }

No, cxl_endpoint_gather_bandwidth() is called internal to cxl_core,
there is no opportunity to optionally wrap it, only replace it.

In order for this path to be mocked the cxl_region driver would need to
be moved to a module and then
cxl_region_shared_upstream_bandwidth_update() could be unit tested.
