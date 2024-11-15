Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DDE18871E
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697049; cv=fail; b=NbocrlB7nxq+gnsRLGGgFUxMx37bNLNfhPvLG4OSkpoAWBBES8rlgj7FlLGBd4xxbfr7T6m7Fn174u+CNxnMkR8xz/n04lsFoNx0K9zvwuG+LnjmtQJxODNNlUOXkqnVdtOj4oeLsdkHVr3mT5NLikL0RNo6kGuKmMGvmCaSVVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697049; c=relaxed/simple;
	bh=Az5qKLQ/MmD4H3p/DX3IFw0I7rP/bYTF2vVnkhE8sLc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RFxd+C3o7P6VG6DTMPkrmk4526FDozWvc5oRuJuOt8Gc12OMC4FKOL9BAk0dTtweQFTg5H/SJnqrc/gXnShZUYfUqKXDdtpmhG2VM/YiwCDVPYbHttTmsXPCpoVhEZMQZIvsE+ed4FIoHa8dgLJ43V9/jIgjB1YlNAMUC0UdZfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aS/EZfj+; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aS/EZfj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731697047; x=1763233047;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Az5qKLQ/MmD4H3p/DX3IFw0I7rP/bYTF2vVnkhE8sLc=;
  b=aS/EZfj+9vMFrVp8LF4TyYZbKiVT6gWRVIxOh00pE8wcbOCjV8vtihOe
   f24GgDHLToDi7kgjw1G9PGx4H2psqhc8p0eLA8F7OZT0fulihY6IkYgQx
   OIlik1IgRieqszVPKjvefd/bpZpvR2zWf5zMTg1I/3gdmXHCFL39VYlt8
   NrKzdQuf9Mifbqp5lYuseCz5kBZCH3o1QBVpu3U6Z51Xppn/7Gt5VVFkM
   7a1+Fcc9k7QAUyFu3nLtzmiArKpZxxFENPjmXgbQBeDHFWEJCTjaTXw5t
   4W6h0GnD8s4wVSmsTnihljlsDML37Btc1eRTdCymnpd+rG2A65QOANQzZ
   Q==;
X-CSE-ConnectionGUID: zm3K/S6wRK+exJizxnocVA==
X-CSE-MsgGUID: p6U9s8oIQVaOagb/BLMuPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="49242624"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="49242624"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 10:57:27 -0800
X-CSE-ConnectionGUID: 1vH/SRpQTJyHqYtTxrEHrA==
X-CSE-MsgGUID: 5XUJIhgMRemM4Q+lEcosxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="88222002"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 10:57:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 10:57:26 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 10:57:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 10:56:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzFZKr8SsFL+ni0fziq41Ook6cmnMB9/G9lV1ZOW2dObezC5uAw+V9arWjZSBGvDU1aPsy6fHKRRv6l6WfjvsGVeb8Fg+ludEGY5Lq+HOYfZMrz0/JgDxLgCIZ/G7n+oAiQ9L7V+6Ijm/vJwLSDPxX/vbeIXLY+yNmSjeIXxZfl0H9nxymMUkvVHE3lHt5YOULNyYXR+ZJdwUXaoYtC2T7o3Lxdb5719YWdQPWBpk6jZ0o194HQy2GlITj244hWSqV1Y8R91eEK2p21HYsWQeCSOqF8zZobgBY9p+OxNJl13UOll0dSxw7IYNYvUxRYgW/IcSuip3t4+0ghSg5pJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfAVgyLVHkLjd+mPQq5tjv666O91QKcpS8z1edZgUzs=;
 b=PZAiojId1Zb3YWhEHEo0AEgcgKUj8HmgDVH4aYzTn1mEDCSi5ed5LdHQpkXbgQbq0mgfHXIKtbFWpIiNItbKKUjisg+K2G3FSX0l+zfZdu3+VCkOMY8iUXhDFMUjtA70LpnF+rb5ejz4d5OoUmGm1LZ9H+YPPKFjM1OwKhcVI6foSQ2w7hjwh3flMwJE8XNuWq+6Vq5Z/+FopuFiODERlh3+j6AWdr7zxB+1rWybwZmMpmjZITN6tNrDnCt5Xv9Nf/7q42tRJ4UPV/oG2Cj1rfa52acPHSUIQnr7R4cuXdyrUgx4TZ3np2y7ii+5ztJauwFHGk5oRK4eO1JmfBpRHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8000.namprd11.prod.outlook.com (2603:10b6:8:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 18:56:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 18:56:55 +0000
Date: Fri, 15 Nov 2024 12:56:50 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>
CC: <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <fan.ni@samsung.com>,
	<a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>
Subject: Re: [PATCH v2] cxl/pci: Fix potential bogus return value upon
 successful probing
Message-ID: <67379972c8b41_29946a294b1@iweiny-mobl.notmuch>
References: <20241115170032.108445-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115170032.108445-1-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:303:b5::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: b35888f9-9c1a-4684-1e3e-08dd05a745f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Wklu3/XGEjkRy3F5M8sIpE61FNnHdKRMVWwL5MRM7nwRKfg/rroZT5XxezR?=
 =?us-ascii?Q?jeAU30P3PdXd19uhl+Ff65Tg3GknEJBWDNq/GSis+jxZm0zidFiFI1lK/VT3?=
 =?us-ascii?Q?kswXK8CjM20U79lK1rmcWjuqdZzF15dJ/0tOiCvS4FQmz9O4U1a9HMBdGxXa?=
 =?us-ascii?Q?nduYPma/020EU9k68zjrX/gUgKzYbk2IFh2jXhjxkCqOJmO7QT08CB4OgIwu?=
 =?us-ascii?Q?7Tz5wHrXEdDIy0MkEO86xJiVVAiYxUXeYZXlqBWmIsrrx6oRuXNp9XN/3JrX?=
 =?us-ascii?Q?WEcvzsUB0Ahtzw1KfWLBnljQgaR93nvtOeBrnYZ+XRRN1zpLW74WxSIjiNTV?=
 =?us-ascii?Q?F2PvHkmm4oxKhhYxvE2m2sS5mz+tVtnXr61jXGdJsiC2XcDWfG3Q2Xjw7vu1?=
 =?us-ascii?Q?O74uUF3Fjp2KTLAWVyxT7kjkD7RkPQH9iPCHbWd3YoRIXkV3vFPTSbydEHlJ?=
 =?us-ascii?Q?j1MlqoN73T7cRYqrRFWUxJd9i/JDNvz0hps4Z+VISrvZraTNTepf0tEginoN?=
 =?us-ascii?Q?mXwZCiIzafWapwo75FOTkyM8k9W852NeQimf9bJ8Lg7npAKzaZozdQwdtTau?=
 =?us-ascii?Q?DPIK4A/GGh3oZUuNeUHodJ0nfTVzE+sgmk8KkelI5eSv3DoOXgQQIDL/ISMz?=
 =?us-ascii?Q?wggsFcRYREj4I9/HjbwZzAxmPM2T+mUzxTO3fDtK/HpN4WrE9/LUTnMPJfqp?=
 =?us-ascii?Q?77RvZtJZ66iXQ5o1TeXRS+NqiE6eLlkZ8pvwIofNdAiseZbQcykuBZRkY5cX?=
 =?us-ascii?Q?sN1zo/ByarpVcTI22thNlCe9LEOhFkGXepFYES156iIcabftNhO+T28tuiVB?=
 =?us-ascii?Q?QDHACZW23DVgYLErd4Kph6FEzVyWRadUAJrVacO6q9Ov8qxLRNCs4h6RolRM?=
 =?us-ascii?Q?yCjscCCx/TCNLysJb9FOyBNNV9RAXs5+Zo+MH03RdRjUNlZVWOb2uoE5kJkR?=
 =?us-ascii?Q?cf/KJAa9aDB4yv9RAPbK1iNmfQOR1wPwdXvmHwk2JOsijpb278Ww9BzGII3i?=
 =?us-ascii?Q?0nuR3adsrrF3WyklA4ay3Y5CTd8sl1cTm+iVCKmaQB/Q0reTE9W5XkBXzn9h?=
 =?us-ascii?Q?HD/bJcqqiJj27DJh32uZcajcnS3wAtDiMnAP2z5bCb7BGdZeCq9s1odNSEqk?=
 =?us-ascii?Q?fo1cR38CrZwSIXuFKNGljAKSOE6KjJKYm6ZOJCBwyHfVDnHG3rakRlxkSsQ1?=
 =?us-ascii?Q?2bh4X6tm1Yul6XfL7LNZ9SH3TmFUuTHNuEri+unLv2OiEP9DGjnIMN0jTF5I?=
 =?us-ascii?Q?U2tY+R3k5fC+9c7CTsYOL+3v9TKdj3aZogEhv4Tjd24iHyI4tdiIAJlG979N?=
 =?us-ascii?Q?GyYbiHzHagbq5TgNMDNPN+IA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pWgPQ2nhZJaLdlvggafFLA0ky80Aschq4ysEzs4tZHO/kVmnkqIY8ajnROxn?=
 =?us-ascii?Q?UKhva0N4acwMydPeiXgV2uloQLHLC6jniXUVaKZespulLD0IXHZoeo25mE5L?=
 =?us-ascii?Q?Ao4uBjfj4XCdHVz0gKH75xhnxIoUDWmh1HBtpRgdIKLaxCWm4cZYRlB3D1cQ?=
 =?us-ascii?Q?6aV/aavo1o4wDn4YUsnkDRSXyKwp7sdhf+btcV7dOCBFmmWldSLe9ozGy9rM?=
 =?us-ascii?Q?kvonIO6XoVf+RY/p5wExUYwlgWrF/Sk+Ixhg2xdFuqvMDPxV9vnKuNZT0M0s?=
 =?us-ascii?Q?ayEhYc9kzuMuqq1D3tOrYwJDlQ2rnypxDgyDs0mWjiw+Gvlqs0YCwfSNVh1B?=
 =?us-ascii?Q?c0z5HOXXrPs1KNKz51Jx+HARA+p8BkY7qwLj4v8neSMmz0EIYJYykwTpW1kt?=
 =?us-ascii?Q?neZTzJXBsuwf+oV00RdspqGVSPvlQQdIeMKrK9WM8IY9NaDSFejHWzvTkzHf?=
 =?us-ascii?Q?Jq/sJGycYdSn+8X+cISjhZDVvkts+rbyWLL+keimf90fZAPPxxEsx9mlXocu?=
 =?us-ascii?Q?2F8HbE1XM3j2yVjp7O3H/7RTG4yh+5r1ayRgUdhw9QNbviS7DtbXANmGA4T2?=
 =?us-ascii?Q?omyenDko+8VxKyLYaO9V5/x1GDk6vxHHRU/sz0UD5kr67ZZ2jpF3F6PUIC2/?=
 =?us-ascii?Q?5dwDgsw85ayvE4mxZN9D0YbVRGqXj2IdPoLdRC8wQUZgAi4GQl5nNGCK2ecz?=
 =?us-ascii?Q?SraSJ4gueAboy0I8sbfHu49IsZoJswbO2Q7NsZFQ1jPJXgvWkzg9D3IYqmy0?=
 =?us-ascii?Q?KqvbGbFDQnkU3Z37rrKKFk24HGNW9/7sxggFd8SU4FLkkPyCawdPPaaQmpnw?=
 =?us-ascii?Q?hy4VnnZ7isNmPw6C9ygzPgm6q9jXKVhCXtULrRLl7RhQ8vHpn0gwfu7tXWKZ?=
 =?us-ascii?Q?KWiOoVQuHbirXYdUhmC+KCggzPRh4Bg1MQrAvMpr8M79Q4aU8llhbd2dAQdI?=
 =?us-ascii?Q?lryZCJ6VElH1nq0OVNAdvS274rYTxr633u8IVq+vBjWOi7ScraOg04CulUgs?=
 =?us-ascii?Q?7pbkunV5gE8zgxb8O8UffvqhyFMIe+DUmaszY2o1JHX9vdixwI63/K7eK+ky?=
 =?us-ascii?Q?UMojEpmKa9N9/Sk088En0gLU9H2tyT51zNWuanNNIVnC/etwhohZCmlDU/dV?=
 =?us-ascii?Q?xktqiB2/9Ld9wjI6Rz9TaPD+fKW+J5+aweQCxYROIJqX5CSuXg0NofjyTa58?=
 =?us-ascii?Q?Fz6mFFu5KLyPUQnn+p++IhbOzt5cNYa51QuYlDE7BLJWDFZGbfrMNEmc8Xop?=
 =?us-ascii?Q?tAeRPnksP8hPS7wp8WjFhUQabmP1iJ2F6BaPnPVjFnDTzhlEx64sFYrV/Yhi?=
 =?us-ascii?Q?AuzKfKVE6eCz7Y5jOGpiacLcM5LTXE4QdjUZxTT+cnA7nswX2g0OYXsDCgIZ?=
 =?us-ascii?Q?xRTeAEMn9ujWPK4/qyh6ydL1BWr9AGjSkwLFVOVn4X046kNZ6ZgGHyoNm1Ex?=
 =?us-ascii?Q?+aCumjnCNo31gfcveSiQcYvRv44FH1OBDlLvRVMs/tJ/QvbUpL0CUzAuctpr?=
 =?us-ascii?Q?73uqd/2TER7fuh3g7E2cn0H9sGUBGcBA5mCN89ENtbtUdtbcJe0Jyae72X34?=
 =?us-ascii?Q?vYTFlmaZ+fsJwET0e3Cv6e3RqIccvLRbKqYaVh3E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b35888f9-9c1a-4684-1e3e-08dd05a745f2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 18:56:54.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQKImPSRFKjImTmreCc+BuApVfhlzBk7V2YH4dTbXttV/X3p7fMbf4wKUTiMKnL0oQDJItW0uOsjgil0WpFCNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8000
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> If cxl_pci_ras_unmask() returns non-zero, cxl_pci_probe() will end up
> returning that value, instead of zero.
> 
> Fixes: 248529edc86 (cxl: add RAS status unmasking for CXL)
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

NIT below.  But.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> Changes from v1:
>  - Picked up Fan's review tag.
>  - Continue to return rc (Alison).
> 
>  drivers/cxl/pci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b2cb81f6d9e7..2012301fcfbf 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1032,8 +1032,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_pci_ras_unmask(pdev);
> -	if (rc)

Technically if we are here...
> +	if (cxl_pci_ras_unmask(pdev))
>  		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
>  
>  	pci_save_state(pdev);

...  Then a simple ...

return 0;

At the end would be more straight forward.

But this patch is fine,
Ira

[snip]
