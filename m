Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865412FF69
	for <linux-cxl@vger.kernel.org>; Wed, 20 Nov 2024 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732125703; cv=fail; b=H/Q+1wh9DhLFblNt6VdPd2WG+I3mcvSnXdNcywt8qC3j55u+UIQ6MGRc6hW+jjmSfhhaG5t7MMFattVO/XWX2zqpvCissEKkNyJGEeoOinn//mI6t1OqPycONDdKV42RhotpIUJhq8cJjg04Z7Zk7RaxrgmXq8lvCtGxK4l6eRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732125703; c=relaxed/simple;
	bh=Eo8nkCOTwc9Mr2fAQQEUeKmF31IhL7M2Occ1R71W4EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KjfGl3vsftQzOkTjI7JTEEinUOXX8wleCFy0Ezp4RMm2+GHh3/caS9BRCTn5LJ2YHVXMhHc7SJu6vIQy1YMCYtrQztE77iR9ebmaSAPbqFsF4esVTFmNdyyK4KJDiw9cC2cDoNpa4UHIcbNTGMxNWSCGyhvudcveBATdfhNfoCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S75qpsGD; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S75qpsGD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtghChT3lJ4BhISChKd6w1xn02r+wkGfQlHN6yaCMpwOvVPORpXpOMFJRYumX+g8dUEfmv753Od50Po2IO+5FEdXcmljw7qeIjZHfU0K0NlFrlHtUsEbOBHlRxX6QbWpnLVdVmlDnDAK5HENk449pPkeUDP9nW5Vku+m8aS0sfSjRA5yOVPEtekzMIsKror6q9TP+Xrg8IqJe3Messm6zYS6Cf+S7NMy2G79bX+9GNOWFitt31jBeYCOteqhDz5wjSua5N6V1NCI+j1WuxlcQFbRzEiK4HxnXcL9cwPL/pAjkEfi9+ubp3ewBSrbI0OPEYGIPRU9+ERsZ5xOTLDrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKVGn/FDX8uQS7AMl0zpROgMDUv8ESOz7OaAgitaT1Y=;
 b=UVnRj+x5sY5xPDNO281kkug1lL5ZCYy/U6KTGV3sTxAaZ8g0yXZITKE7vur1RpOBfCviZnZAby1UkJR1xb3gagEUxYDj72o7rA7KyHUlsmSpDaubQvKxYwH5GyxUc9Ghg4Ve38mAYsuSyOjoiaOtziU21oYVrgN9PEI9/NXKEo24EGgkLqhBn36N5+TAIOFdg8TA7ywtwhcXBhaSprCFsx32hBEI/+On5xNq6XXOPxWLxfzider7VMaZOr9KsfDBMT9FIPmIUO0czWrmXsGcnUy5FthBczT7LJX1cad8Opq4nqtQNZsqJ8pbzkWMsOOqgGPMaWQheBg3e7SCYI+KCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKVGn/FDX8uQS7AMl0zpROgMDUv8ESOz7OaAgitaT1Y=;
 b=S75qpsGDJOuY7iyGKVv610sx6+2Yhp12+brvn4grl0/ALMIyOm+F6GWR3B6H6GKPFDluKyyezClWFVVG0ANgBEGSLWDE8AhPJqjXe3eSzs+akXRrZ19C+GtkPuMpfVxSDx5l2mUTALbPz5HCmvv8+ayNF2N2VT+pVcG5Q0PPlcOWEiZ+dTLyz1Yi4P1CQ5nUQ+aOVYy8Y1UcvkF2eoTXeqnuA2w0lYqibwvPytrpAlBWJzzd53bYwEO6ayCJFS991E6nOK0Bl9XNUKGlk6V3NCikS8YLTYdBqc9GMGzYI2eqyD4FJ8+ka+cnkBXe4homRaahUHD+kPeqt0n2jiyMEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 18:01:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 18:01:35 +0000
Date: Wed, 20 Nov 2024 14:01:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH v2 09/20] fwctl/cxl: Add driver for CXL mailbox for
 handling CXL features commands
Message-ID: <20241120180134.GB876522@nvidia.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-10-dave.jiang@intel.com>
X-ClientProxiedBy: BN0PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:408:eb::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ca116f-913d-4dff-ddd8-08dd098d5f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wjFpR04NgZ0oojexr9BefPeDf2sA2MDcWuys41W5nXm6z5q4Qj3ok6rRVdci?=
 =?us-ascii?Q?ThVIzC2Csz3uGut2jrdNsyl19sNHQCp/ulvod+Un2yl9/LN4Kj4naMF+vSlB?=
 =?us-ascii?Q?vCslOUPj3HO+KACD6Y2p6REM8ediDtY+MFkfGIVFFACXNdZlu49TFH86dRzE?=
 =?us-ascii?Q?S3KFfhTJJgeIs7VMOvt3WgJ3Ivjy736YmG+TMw20fGd5/XfVwI/LFqxM+Bni?=
 =?us-ascii?Q?QQUcDNc5+OWp86S5sZfQhrneblVysnhsm3iPyNwAPv4MDFn02lzv64mQijQs?=
 =?us-ascii?Q?1J5ayINq8W+p9qGPC0hwmdlvF7d+BleL0xMLuZs2Iae1k/GcnA7esarKC221?=
 =?us-ascii?Q?zJNEWngCqGjY1mb6MWMpqnrTKgemEO2CWligVUfyAfq6h5QQbi2kCSXjQgbU?=
 =?us-ascii?Q?hB+BFNExqCF/saefNWhhgqaEIfR5qcTRIFzoD+dCIZYP7PnX5+iwJKVcE+Xq?=
 =?us-ascii?Q?WgpxPcXDND6CP5T0JLfsT8Rv7Qo1fV4VnqQ7VYW3C2g8K+w9cALR1qaoDpTS?=
 =?us-ascii?Q?DAX/vwGwqVLUwNhInTz9ZQ2YzIiDVVjOK43hYjVTzGeB0sJBXE2HzHFVsjDZ?=
 =?us-ascii?Q?4WN2iqRpRSeoR8UWVpR/QQBDNnLuFGb/gjWkKoPHCIbTPUIW3WME/V7GHbnp?=
 =?us-ascii?Q?59lYqPdPaIHY9UWzTNEJs6SfVyFq+2Kt8MAVxSh5glkH8pbMxnep4Po6op3N?=
 =?us-ascii?Q?Mm1TzYD+BjL0SLrV6V+kC40/n4/Y08VCFu+/DA7DhpGcahLSiTJC4pYjEeWv?=
 =?us-ascii?Q?x0t/hIbCfJruG+bSQCF0hk+Qszj5Oz0SGzAHrH5hfRCC+OoMJxzGVqBPR8Qa?=
 =?us-ascii?Q?RLdIhO46vJG1fiwYbON1CSHU79HZFwF2M2wLkRx9tFG9xi0CbjuqNPBbzFPf?=
 =?us-ascii?Q?kTqUVZod0W0EjoHtOdN62aq78lVpsCTVcgEj+XnlJ0fV4w3CChc6vK2ke5Om?=
 =?us-ascii?Q?xGUGWwxdSelC/Oi7i/mfmq2Ri6NKlbh7rr816f9U8VmxvgP2Zqz9VoYyGjVU?=
 =?us-ascii?Q?kj8y0tDc493GX1NAHafCTI6OQGWeEyZ47IX++xqmbjczoFdPr9z8gKaSRO/3?=
 =?us-ascii?Q?TvJubY1Jtqk6t0/apJ5e3DgrYurdR62IV/EeHcpKV6LsVAXP2rB/pctQ/tb9?=
 =?us-ascii?Q?fzC8wetylCk5fGr20z8qTmiPr/I05EvSYv1Pw/Xx53dsYi8YbfRadSJaK0mR?=
 =?us-ascii?Q?s4DBTy1XNqHEFxxKR/iYqTv59Yr3H82ShjEP4nqXU5cGgwTMnb42OwTiUXT2?=
 =?us-ascii?Q?sVKn5aEyPpqWjVUgB99/+E3VfLgXc/cnqxzjBfz57wZkKPOUi6AAbKrSpcBJ?=
 =?us-ascii?Q?fWhiW27r9dIbmtp1zuWCK0uv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I5V/rIvRPKA/p21wt0jynCpsnLxOCXRAW24sir63J2Tkwb4V1GL/wJmjt9HX?=
 =?us-ascii?Q?Kn7yp8aERsrYJoqKaL6GMWmdXFBdTrM48Zl2U/S+ZGvb/aWNWAA2C5AOBoA8?=
 =?us-ascii?Q?sWLdMMHqnlZsw5gxMMcyBCXrJOoAQJYB1nj5hF2ICkRcKAziQNY6Iy5bfr4c?=
 =?us-ascii?Q?NZr8edbns7pWI/fn0Uo6xHhyWuMpJxDv04Fp+nVKj5bT+gANU/04FtwL8WLy?=
 =?us-ascii?Q?76EQYF59jyGoAfut/M5zddXtGceBnxiSUdaSzwItdAF/usGgJdG7qHQWFeh9?=
 =?us-ascii?Q?03LwVZ0q7Js5gBglhj/c4NVAKNC/BlsjF41V6+F4mvqESqD6vZPrfLpola2K?=
 =?us-ascii?Q?wjhRFxr343vB78IANAKfXgqVcILDzx/ZLKeM5Mnzhg9XiPJsG9btKj4v/5eh?=
 =?us-ascii?Q?9PtHARaIpz4XaemCIIfi3GRIXAJ+XHiysgsvlT4esJnutKIx4QEtzDSYOjh8?=
 =?us-ascii?Q?6PPNUwUIrtncby5IKJWNsazZz97SAqqrQ91eDX9LvKjltldy4b66og/pMqih?=
 =?us-ascii?Q?MTKdHxw5nA0UycvXrSb3+duE6ikQxGgeXtFx+bgn0Hw8uwCiALe17/S1i6JC?=
 =?us-ascii?Q?CNEm+KMMG+57GUKLetQRPo0FzphrMUogI5zxax7Y2tm6T7qFI8ofgI8XLYTl?=
 =?us-ascii?Q?IbHB2xFMfWZHpBRUqgp5IBXVjVwV1x7FSqJPrvX1N2CYNoyIBs3m/YXNv/H6?=
 =?us-ascii?Q?bXe2AgIzdvRh9WJw0wRJ+WThntHoE2rGqw4KAfZZ1w/WaYgxyFznh/AjnXgO?=
 =?us-ascii?Q?Cu7/zMhtKloepP6U+7eFYIyuk05bqcSRp1So+uzM7ttUXroeoJRH6C4LMSP8?=
 =?us-ascii?Q?NXT/LgFggwf7fNSumT1LYkrykk0zAj/8fUovIDX0s0Kt/kbpABMsozXnjCRO?=
 =?us-ascii?Q?yVae1CQICkHEHGVjDfhjzsL0AUzHm81hJauLFFXX4XHrgZoj5P8713NodClT?=
 =?us-ascii?Q?VBZWgP5c8b7I6lFU/p0pKNFRke23hyj2JhUsmOO9SDfjOwm5RhZDF5D+pBKp?=
 =?us-ascii?Q?T0N/s9zNAfZgLc8T9YAsrGjgcd4+KmnDzHilAEbW3C9NFj/yeUjZuFNTK2/p?=
 =?us-ascii?Q?+MQwC47leZHwIPrdiLo+90h4oxdC2cWsODFbBEbgR0r7wiFpq9oHGo+OLdon?=
 =?us-ascii?Q?Lmmsvx0evO9RLX5szAC+TIS7hxboFDmAgB4NxZJHnHS6mKgoH1ZSWVC1AU+V?=
 =?us-ascii?Q?cFiNTQzLwqeyRTgRRHojnnSk0JpBuFYRGXqW0fKpCfUn3wLN2Dfxyo37tG1y?=
 =?us-ascii?Q?IHyITx/A++lYUKvPC0vuGDkaYnYkWe/WONro1tONQMKjxNkM/OLXaLMH+4uq?=
 =?us-ascii?Q?9r4N/fEJtpptbuXxt4wsQVqqyO8Dhv2dwpQDO28Ck0IKvVKZVwOTLqrAKqse?=
 =?us-ascii?Q?OS5IkrKiye6vWYDVshxhQ1J+YYrE1HkUzV55G/s3uGVSDYiB8HEUu9FQPabi?=
 =?us-ascii?Q?DlJvskGBa5/rP4BRxvJ887Kep6nl0iHOKH+rQv4mPtLKI7UDhaKK6FutoqQ6?=
 =?us-ascii?Q?XRIiCDDKJNkvnoBKBsp226M6+mnEyH1b9r0ku09dn/D2Wlk9qzR2LapVJnHv?=
 =?us-ascii?Q?hqUl4MZx354SNChUau2ivuwYFh1m4HGFP2RiEjyF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ca116f-913d-4dff-ddd8-08dd098d5f76
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 18:01:35.5359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dwx7srpxpoqCWQOhf8cqsuFdN19p9usFspPvX8PXbbJaPLE12KOYdiOguJndfG0c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

On Fri, Nov 15, 2024 at 02:25:42PM -0700, Dave Jiang wrote:
> @@ -1721,7 +1742,25 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  	mutex_init(&cxl_mbox->mbox_mutex);
>  	rcuwait_init(&cxl_mbox->mbox_wait);
>  
> -	return 0;
> +	fwctl->cxl_mbox = cxl_mbox;
> +	dev = &fwctl->dev;
> +	device_initialize(dev);
> +	device_set_pm_not_required(dev);
> +	dev->parent = host;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_fwctl_type;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;

If you don't call dev_set_name(), don't you have to set dev->id to
something unique?

> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> index e5ee2d46d431..e49903a9d0d3 100644
> --- a/drivers/fwctl/Kconfig
> +++ b/drivers/fwctl/Kconfig
> @@ -19,5 +19,14 @@ config FWCTL_MLX5
>  	  This will allow configuration and debug tools to work out of the box on
>  	  mainstream kernel.
>  
> +	  If you don't know what to do here, say N.
> +
> +config FWCTL_CXL
> +	tristate "CXL fwctl driver"
> +	depends on CXL_BUS
> +	help
> +	  CXLCTL provides interface for the user process to access user allowed
> +	  mailbox commands for CXL device.
> +
>  	  If you don't know what to do here, say N.
>  endif

Keep sorted

> diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
> index 1c535f694d7f..bd356e6f2e5a 100644
> --- a/drivers/fwctl/Makefile
> +++ b/drivers/fwctl/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_FWCTL) += fwctl.o
>  obj-$(CONFIG_FWCTL_MLX5) += mlx5/
> +obj-$(CONFIG_FWCTL_CXL) += cxl/

Keep sorted

Jason
