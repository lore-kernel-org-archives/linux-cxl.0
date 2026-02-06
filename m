Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C0246766
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342415; cv=fail; b=WWB3aLngJygJUua7yeNk9/bbwxWgoShjaGvJZOTWfkX14W3Nfu4ohEPwxPyh1ozXJcG2S7XWIEhK0Hsb3n+6mb8b6HcKCMsr/VDqvLcJry3Pz48Te6WXsUjJr96Z4EDvy4ujVXkKiRGEZTcSDR5h3bq5Ltma/BaZhNKKnxYRkqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342415; c=relaxed/simple;
	bh=al7PA67YhHpBtvA3Eoz2leszMwcZOcHd9F7NeCLSsaw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BLV7KFTRFGAFY9Qoyx8P3af2yXaQe/4JUB/eUx+koFfNK1rVs4NVKgxNDNxZTV9kPHxRGqrFHkipDdxVwiquC93feWl++rqXa1Y/RYN/eutkZr53GXBsB87rBinxYyKYxo1CbtR1xffNckV3P1jTe2bU1ME5Z69qgVp7EfBI93U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OX5IwDgF; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OX5IwDgF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770342416; x=1801878416;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=al7PA67YhHpBtvA3Eoz2leszMwcZOcHd9F7NeCLSsaw=;
  b=OX5IwDgFLJuWy5JawwljfDVwym7PTn7cjmmQ7vPI7S8uujVUjNatu3nN
   jqqU2i/3mPUOH6j6S8JC7LcIthXwncXa1lHBla3fj6yDbOJZnSURHD7ps
   RnKpciEZzzhLgn2/ZKsN6GJwIV3xrYknYGGQK3jUNw4hTAHvAcoESGkhb
   /K09JtTUgGKqDSe+eO0Awfli7K86O3KwY1lBVYxn7Dhn/q6mEiFoE1n8r
   FHmRZw4wITlm67pZ6Ht8Ht0Jysn+0QgtF5ZaSxoIBXx3asB/BR/Q/JHFB
   zM/6YvcRjXrt7t+oY1lWl9WXBghnIrOaCBIyyDy5xu7oG1PZmCA6VzM/D
   w==;
X-CSE-ConnectionGUID: QAYrOOILSvOC4FNCkn5Igg==
X-CSE-MsgGUID: oyI4OSy5QNmO30SnP/ounw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71731973"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="71731973"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 17:46:56 -0800
X-CSE-ConnectionGUID: TwPdHbE6TOuivVIAYBahEQ==
X-CSE-MsgGUID: Y7Hyhv0MT2mHNGhhX6aAdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="209823136"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 17:46:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 17:46:54 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 17:46:54 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 17:46:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0l/qzKnLi6UQCeLep6Hn15Qgw8D+9g3MnIhkmEWXOqmMF3z3t3Dmtmymivxgdewy5GTahHe0xiEWxouopXiNSple8BMALwGGzblxucQOedBHIj3cDu237c0Tu4hWDDonvRDMNpaa0RCbvNJmYvWQjbg6GKsACYOt3mmpkCiUFc+rqqh7p69x9L1cX3nRSH2dWjF59PYUolIO7RuEF3M35washhpundjL4D95qygGZPf7PcP2R93AsgKYLnZ6TDyaICpnfT9fOhdFhxP+JJES1KuCCANCSGfLl7lHZD2titulP8lRw6K4OB2kBPzVRCcV4nxnJAj9P9sbhbEMtIJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRenEWGbNaLdIqQzD05oj1UHc5I7a0aGKJR5P/zA1LQ=;
 b=O2rHosQzCJEDfKkQW3hlcz7Qp+xddIgIkls8LurU97txwmN3kM7haE9e8M+B+MR8HzT6iYnwgoIqTtUynFtWFvVSDu48VJUVSVwQpOYMHe1xXJPrQfBye8dlotHx+HHfkhiNkb4eUR1kOwS2b28LYCaxtAgVrBgzLSRDtnZpZkxJqNSOKQiDrWrXLJUIkdtXybb3rPfLaOSMQNSqRDScL4UkmIiwg37chOPhiM1o/aXKEHmUPCl+B17VEuq2kB+j42MlUnSRIXYe5GhNEJaT1Si8wrwxBDnsgPkI7m2DB6e50TcJqI7nluCEjGJ+V+w6lJmMt533dz+U/y4Jx1w5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB7972.namprd11.prod.outlook.com (2603:10b6:8:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 01:46:51 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 01:46:51 +0000
Date: Thu, 5 Feb 2026 17:46:47 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Test CXL_DECODER_F_NORMALIZED_ADDRESSING as
 a bitmask
Message-ID: <aYVIB1PvG6Htuiyd@aschofie-mobl2.lan>
References: <20260206013135.1012375-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260206013135.1012375-1-alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b461617-f8b5-443d-4981-08de6521995d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nk/MduO1UDLgwuvfRQpNqNu+owxCc35EPjK9UUgSbIpmXVfJ2rOR/RqA0/G0?=
 =?us-ascii?Q?nbtg8LwhBYtX3uPsAHTgYBNhSQ6MLYK/9tB3gwtaclG6MNeJIrObkb9nQn1T?=
 =?us-ascii?Q?SUwdUnIUmNn+btVsHsNAUahGiiRgpz8CE5dHGYrQd5HSuzACcQTaXmz2+O51?=
 =?us-ascii?Q?UjpfRCjK8dxyzk9wuwnATzB0Sf1cO9pVBgKu35V4KzI0cTGCpUBRlF1TqZsg?=
 =?us-ascii?Q?ky/CSM/yO9ZM/eiMOo40Yf55foFGCM47IzQyyhOmPJltNFkkWT52DNwLM5CA?=
 =?us-ascii?Q?PuTk+60XLNXHJMyiZKZ+BzBfspkTp4hQ5A2wMdOIbnTHZbjfGQ3Rky4z9UHp?=
 =?us-ascii?Q?C7Rs76WLLAOUaR2RUlJgI9hfgoRHIfb2A/Hhds6TUzQjUlW6bCdBrsWagexZ?=
 =?us-ascii?Q?ltoP0GSPKc9A0kLnf6duA6nqAq0FUkk/6fdhUVw+aXA3uXe7GANph7vMWi5T?=
 =?us-ascii?Q?Y8leRs8EZyrrwm3VjpQeJ1dzPMS8z+0wM7H8Mchz+zRSpKzqNhzEv5Rzh9oL?=
 =?us-ascii?Q?veXOZ+ztz47ZPUi/lupsMkdeQTF3ofD2p/rFwbL5i0HTTQKn10ByT9tYrQ7v?=
 =?us-ascii?Q?PR4rjJupGHCvsIZoSlH9VAZtf6XijoMEsiQW8SBd3yexpd9T0Bx3/OHKKvyg?=
 =?us-ascii?Q?vDKdcYYmmO7Xwk+y/RBGeWfmsryLGrgw2VBGqY4REpzKNvLTWZJF6xmI/lLK?=
 =?us-ascii?Q?SJVf6hMXiDhsFqOk6i6r8ngPELFU6peOcnw9Mgrkc+iniifAmuNG+daBMv6P?=
 =?us-ascii?Q?19jVYvF+sXUnZ9JDMEJlyVqmesiK3E45CmF5VqOIOL0h403YVGB5ZTvWzbKb?=
 =?us-ascii?Q?/knWiCXV2JzKb7nZGLUY+Zx6PP5dPstaSUF/qjK3bONZuNoviWVDnp7lwF6W?=
 =?us-ascii?Q?Y/Rn0kLtH6CKUhthOkMLkNgEj9P/tv3vA6o64Zu9YcQBmSBNEntiX5tpYSAi?=
 =?us-ascii?Q?BOorY6J6erHgpThsLObM62bUAA8BhWbDVZAVy5i41sGLCtccx+Te0mi+527m?=
 =?us-ascii?Q?344mhqeL8YJxTb/WQNKAjTtXtM6HOsXKvG7dH1hOuP4Y+3KOopMwfBHpey7w?=
 =?us-ascii?Q?eAHJGQy5Taab0JDwGgrQKzcZOWF6JEluwbwjaV0j+w4dWtQlb7MzNTWTLi3B?=
 =?us-ascii?Q?NGXhacreiOB7q89rRVLTqaTU2fb/3wuswVcv963XktepoNvHoIX0r0SkRdkh?=
 =?us-ascii?Q?Iu4DNnk7evv/9n9jE0h7h0u9VsI0YzCnI4/TxtPu484IV2w9L3HAYN2SnXSC?=
 =?us-ascii?Q?pKZq4IoDTpPQGalLL0XUri75UYnvi1bEPwh4dgctpmAUvt4/Ax+Td2rs7gpl?=
 =?us-ascii?Q?Qcdpbhuu767He7usialfIlERO2K0eEVrAaHd2Alhj2QA1Nw2qeawIcKi9t9V?=
 =?us-ascii?Q?rAwu3frB/Dmn+Ahl9dg9+buN0Ws8H5oGE+1HQUXmzkHTeuc8427oO1qxu+SX?=
 =?us-ascii?Q?PISpK7lpOZnWQkQy+JHbT0U9BHyvp5c/CHfNMv6GhC2YbucRFNABVTfqzhRG?=
 =?us-ascii?Q?dalS0FlNJYN2SyfsBG3R529WmbnaSlsYmuzXTYoyGZIcpOjRtyv6IHSmf9s8?=
 =?us-ascii?Q?C6XzVULv3k/teCeL2UI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?isWPd6hGPy/YOBo87vT+8PMLotFCrR3j4kRFxmY1jyeAqVV4XM1tN59JUmFa?=
 =?us-ascii?Q?fcGs+XuZhNE5/QeV+Ip8ZsI6mN5x/ph76QKo4e6jM1hRx8tHQ+Lp2HVkKlCL?=
 =?us-ascii?Q?0ZnNSRleZChwLl9F+6O8vmZjbONw0kc+R79oRT0f6Qsz/+NtacKDX8p83Ksn?=
 =?us-ascii?Q?wqiwpTtm5xvzAMci8Coj6GHRpgTVlTWVkxKCy4NZPxwS8xXintG7FrIXg/L8?=
 =?us-ascii?Q?qtwQbSK6FA3OpQJOe6CQjBg0I5S/7ckGr22M9Mu+UBNFEFgrZKV+LkogcAdr?=
 =?us-ascii?Q?f7tcY1h6U5w5Lh9y6jrZiqjONNAIG8aTVx6TQAxiYj9FZUOAegobw821w9zT?=
 =?us-ascii?Q?vk7K82EETwYocg2uOgBl/WD5cO0lqGim7UbPHtGT2r1mjRsInCuoDLLSlVDH?=
 =?us-ascii?Q?mtFEHa92KVPp7tJvoL10G9p4DYe8o7ajRI6vfjfSyLtFVuFjyPrXmaz4KJZ2?=
 =?us-ascii?Q?3hqK3qPPy8NecQu5RKJMD/bZ0TJcD3/8Er8gUgh8wE1UFeU8RSxXUJiyguNh?=
 =?us-ascii?Q?vHbheQbxVADvmR5nj28Xjg2NEzeD3ywF+GH2Cx4ndy2Awh2BJ1IhMdMJqoMQ?=
 =?us-ascii?Q?ej754B8IKc4vq3MebJSWyx7U0K0X+LMVH66BWHgyR/2r8yACsJDVWxL0ncQK?=
 =?us-ascii?Q?mnHuo9Rtv71P8NkRtJDJYngzZNRpIAMuUHNf3iRJoAZuM1B9j+M0hHsdGTDO?=
 =?us-ascii?Q?XbZlVRmuzkiolgy1Kl40XEWAEi2hlfohPqC4EIf2bAz6vPr9Jsk3X6YjfLBk?=
 =?us-ascii?Q?bLnS9r58sVTMOGzDpHrkzzKTzVjnYXHAxRyVg6mK2FYSVTRHIb+xWPYH/lSl?=
 =?us-ascii?Q?kfLhIXE4ESm53lOihn21ZLqgeomIORByIXCYz6S989ByTHxW6RiizInYN5SN?=
 =?us-ascii?Q?g/17geoE0u2vp5QpKfTofwk1/E4Hh6uPMTSQGDeYrSlxRW9zi2Pk3GZ901qs?=
 =?us-ascii?Q?OamPSdLbevm0qSPXfGMMT6KkZEkQ32XKLR8dJBw3qfnxI3l+1avERWopkeye?=
 =?us-ascii?Q?0nWTOQ3YttLpL2BG3IlH6/69nFB+8DIW+e/9aq0ypSgAkwdfsQVCiUQTXKC6?=
 =?us-ascii?Q?DCV3qbyV1F+T3n4Ia4nPxvmROHS5AGOWvX0E1jr6sCSd+g72iYouhMMXo1ge?=
 =?us-ascii?Q?BkwJtkD5x8AAlh5+JblTsNhWGbSSNOlSaxVKax3yDdtLPxxa4dHIIDxZYYIo?=
 =?us-ascii?Q?xzuHvghE+OKzyPv78WLhHMkJMGTb5xlOh5+cCRRlyZ+J2ai3hhGzhsbaNBNW?=
 =?us-ascii?Q?ViJ96idS86leYdVvd5ZjtmmxuVe4/9ULwF9mER88W0/MLFgF070bkpgULaeL?=
 =?us-ascii?Q?5On0dDTGQqGawReDPmOQdb74lnIXSrdX8d3HfAkcKA0j6q8XKjPWncyLgQPa?=
 =?us-ascii?Q?Gbctf1YkrFFUf90DC5fbYBEiVvHq1btXXTxVSf8AEpD+h0fLYW9fOwMcWiBU?=
 =?us-ascii?Q?Pz2UcHBJNIQtPTNE4V3p3FB5AuAzR4WiLNucqpL1wtHKFsMtfWVYcWDPT6gG?=
 =?us-ascii?Q?trqHHxq76uSQ7tiZwMo6lNpGyLzS+3b+W7N1Kk1FtLL8c9hNbSFD9krtOYoa?=
 =?us-ascii?Q?w0hSLg/0E/xBZcATGCO5u/FTm5oiuZxagf24e7SMrWZJJ1wvAsdwKfWL9KyC?=
 =?us-ascii?Q?9+sycYEqeOQ4DqdTphzAIKTkUfmTMCr+hR6yjr+f6pHvNXXH+QGiBCCG0zHU?=
 =?us-ascii?Q?iwV2/EXnMFimmuECtZ4aAGp/815l3+3wg2xFxejBm0jScpqO5woE/NFGK16t?=
 =?us-ascii?Q?LPESxgraxKLE5BRJsF6w/M7SLkJBTJE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b461617-f8b5-443d-4981-08de6521995d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:46:51.6600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDovvMt/jq02VJOM8FAtVEhaqfBXpV8F2aOnhYGk1t0HxQS+giWdlbccMz56qDIYBdf11uxyRGvKnT48CC1K0A9YVSC/G9SqKv6zjYA5JKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7972
X-OriginatorOrg: intel.com

On Thu, Feb 05, 2026 at 05:31:33PM -0800, Alison Schofield wrote:
> CXL_DECODER_F_NORMALIZED_ADDRESSING is a bitmask, not a bit index.
> Using test_bit() to check it caused undefined behavior making the
> flag sometimes appear set. This prevented creation of CXL region
> debugfs attributes that support poison actions.
> 
> Replace test_bit() with a bitmask check.
> 
> Found with cxl-test.

I was focused on getting this test case to work so it wasn't
until I hit send on the patch that I see there are a couple of
other places to stop using test_bit().
I'll respin and clean these up too:

hdm.c:		if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
region.c:	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags)) {

> 
> Fixes: 208f432406b7 ("cxl: Disable HPA/SPA translation handlers for Normalized Addressing")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> DaveJ: The base commit tag is linux-next today. I figure it's closest to what
> we'll see w 7.0-rc1. 
> 
> 
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 08fa3deef70a..00a9b57cdd80 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1105,7 +1105,7 @@ static void cxl_region_setup_flags(struct cxl_region *cxlr,
>  		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>  	}
>  
> -	if (test_bit(CXL_DECODER_F_NORMALIZED_ADDRESSING, &cxld->flags))
> +	if (cxld->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
>  		set_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags);
>  }
>  
> 
> base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
> -- 
> 2.37.3
> 
