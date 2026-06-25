Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D712253EB
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374769; cv=fail; b=jD4GtWT1YCyTl6r78+jHG0d+d7DNzijhyyQBTzQlrg1CboXTcSJpuJn/Y/8JUjCTG/cr5yg0SEQ8gnvA3USyfcgFt750aV1WQqQUuKSRckWodvHC3CpZMfmGz8MRkUHtXwuPCc+ep9SKfjaso/dFZBIZJytSb2f/+kp1U1Z5C/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374769; c=relaxed/simple;
	bh=4SN8uZNMsWUoqAaamQrl3se3uHYnwYK6vOnQ0qE55PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f3YUV4DtiJeb3ol6ijWOzoV2pW8/dwnzCVO6WFBozAlTVQX30bF5hM2kVI6qvpgcKdfGzyiVEU9vpRp+RYgbunvremOsF1R4huCGoWwV8VHJOSzzzY9Rt0hLmQ4uiotDkxzV050+uosKA0thQlAfbVolgD4VecOcJkm35vBjH6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QqM85y78; arc=fail smtp.client-ip=52.101.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QqM85y78"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBn5EuPptGwgGdgfC85oR4un2qW9Ugx6pWfDVjDrbaFcyX6J+42aFpqia1xIGHpttjAir9jm0uGmJSUy9J4AB+4hvX9tZ5Zn9EP//S+wTDLrHVc6ICRim+HI/cwZepGYFwpSpkoT6aTmzbbdkiSO3Bo2PBHPdkmlEkzuZNBk55spP/rppcuolO5yVrmkK0x+T9LjkTy6gcWHLA76U3maQL83PzqIcav9GPAnF+4hn6M2Af7pFti/APn/oTJuRBRyQ4e774OGipRhtPHs5U8FPnsSxuHvTJ9GlhTXu+i3BbqYZ5SRYNY8HtDLFdNL9LLR2+HqFev6vn+NFr+WxexEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhXHmKNNgwe4l2a0ocZA8Z4SDSrOGea+lqqEoCgWmvo=;
 b=ukgIPFE7xLbna5pOKs8VLbsM5nuTpn5Q8pzjrguYGcf2OEWZqIbb5LwOlG607g7mBgpQ9aXANIhIrZNG8wQaJ7Phr7TA05Lj/mjOnsWE83aLZeLt9rSVqewgz4oNOa4wNg+bxiQPb1+NGMTlATqropmL/ZIbAhQjsxCidr2n8wBpw8UQB4cVHyacXzDUVFUI1XnjhxkdWa3TfCqjtkASc7I+QUl/RXzhYBUuaOSqKLtDghz6KUqZc3amMPbRTd+Oy9YdXz5sHyTAO5vemEXooHaf4qEi9Hnhzy+0jeWs0FoQvasMLygoSVAWGPdKftU269rZPK46ga93KPjWB2YK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhXHmKNNgwe4l2a0ocZA8Z4SDSrOGea+lqqEoCgWmvo=;
 b=QqM85y78C8y/JV4F+3uolX3rFl0BJi52CwVq9zw1WCz1RFK183ztTBLBGom9ryvJnqk5jYOPY0sugRmYQdbE/dxvcAj7t8Qb9ncJM5n9YOFuUl5J5oiDwlQ7O3TPgEFWA4D3kzk1hRFTSHqmshfJJ3WH+BWtETjyPSBDIbReOnj+63mKzyCK+OXKKo8VIkpdEVdLWWZv2QTR+8+jSa9n78ivT1O51g3k47akS+MWgFjkTo0PYglq0dpaOTQBrAtYNzxKflUzqPv1zRuuql4nFnrjSEUs3iBcm+iIX6fa+QoCXJTEak0bC1xXZAekpfocbI1VN41euohrTJJ6nn4zuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 08:06:03 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 08:06:03 +0000
Date: Thu, 25 Jun 2026 16:05:56 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Wei Hou <wei.hou@scaleflux.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dan Williams <djbw@kernel.org>
Subject: Re: [PATCH] cxl/pci: Remove incorrect mbox.valid check in
 cxl_pci_type3_init_mailbox()
Message-ID: <ajzgfJnDxLfUEZHg@MWDK4CY14F>
References: <20260618170356.25382-1-wei.hou@scaleflux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618170356.25382-1-wei.hou@scaleflux.com>
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 971cb949-04fd-49d8-e824-08ded290999e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|3023799007|56012099006|18002099003|22082099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	CFNgXG5qnu4uSrNyUZQJpg8cWZKR6P5eZq4OJshKTLgJbJFQKW4t+Wt8lkxt2T+TehQ8GUyPXK/5J2T9e7gWhp3xpYhewaaRQEilY11yovfYNzj9zpWw5qm3EDlU984HBkSxp9GcN/xbTbLF1AHaSJu8sZboSn+Sb96RfUHcalQ1Fz67r/WZppnG6iGA6HgZ2FcWf7S+flhVTqyNj6RmymSOXb2WA7L/ErDLgrHU4IekoS9X8qvwa5YssmHLr5sjMILD2ETEGIaRYzcDdeaiVvVaBtjVYzR8CxDRBeX6fNn5emzt4xepDd8xdL+HjkyOemS8MhZsFNG6wLfEqoRr+6ajtX93rN8ros5Im+/DlyEQDqL+/WtKuLNutRjD9oKU0sIjihB80agGiTppBj4iQEetyCKMdC2GaqHqyRg+Wu1zR2BWDRDe0PiA4JDgdjtkuo8ihlxiAOJruEWCWCwsuvKaza1jhARvLmvGXVXGsiqsiE4/PGoijs1b38jSUfAveIf0exLC3cHWmixpQ5idi/mYb99CPu2NvNL01IzaM2ndQ8MLzKS3DL14HbLtZtvLhL5RhBPYfkpmFc19nfD2aso7rM6G7OyT+iqlMU9Gin6Ruzlo/fxqrR6gcZLL4IbYb2WWhof33R9GDqkt3/DWSTL75OahJGUAaP4rhxLat3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(3023799007)(56012099006)(18002099003)(22082099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bLUg3IcDe3K9B/RW7NZ/IL1yA5C/XnaF5DY4YNpJkHPDqm52YQEXtCYGGErH?=
 =?us-ascii?Q?/TkgpFucFTZTLI+sCaYbAOqEj1qiLQEMzUMaAnC+3gY7G9dIoNflH6aUJvEu?=
 =?us-ascii?Q?nurYbekUJsBwPyPk84DmUwGXoslYe9/M5IL8FxlDVW0DWm4Z2uAunUxDeLR2?=
 =?us-ascii?Q?e9dxJSlc1RXbEL9okThdRdfk+D5m1w5pJafNdbbeV6reNdQ5GRDM0G4au/Id?=
 =?us-ascii?Q?XShML3pF17rM9hG6CLL05aciapPcR1LOMSx7yxpNRmYr5RUnoy0MWVuyiDcQ?=
 =?us-ascii?Q?Lzf3Rvyed4+LGFDNkli+YLnDonpwUsdBQUgn9whgovmppzyP9lp33kLe1BgU?=
 =?us-ascii?Q?fIg3HiyWpyO8E3Umztei57BbHvkCZ+ugJcRXGhBg74qBMix1ZX9bvL7U+N1R?=
 =?us-ascii?Q?Ws+7+pA/jlkD/73D5DnUwS1gISaH53ppqF+DtqwVWnQ2COoq+kuCxgsViExt?=
 =?us-ascii?Q?AayVujC3TpZwL4e96b61P0GQDQync0FHjHBpWVau6NY38CNbRv2rw55Mlg79?=
 =?us-ascii?Q?Lf2WWhK0n6EIxUBxaGfW85ucc75kEtz96MxDorIJfxW00Ws3FJo5a7H1qkp9?=
 =?us-ascii?Q?ztNa2kVWTEW02s7vSv7eDsbj6mxDQ5T3XDpYdHchKg9AN7rQjFAk3s/5/vHm?=
 =?us-ascii?Q?uXNn0i2bzZvv5tTgvcR2qfhw8lJSpG6cQ3Thu2q/rIuXlrRrcOfXOh0QNJpd?=
 =?us-ascii?Q?Id+3VCDHWG0zTcOzBMYoedyWt1TrEeixJbgfKrru8xHODHaXYUabHLtkVQy7?=
 =?us-ascii?Q?/7J17399Yr07qxvFZWAQNAoO0bw7LSfcn8xw7cEEyucPQr1dYoDcumni5uuA?=
 =?us-ascii?Q?Z07f0qsPJUoSYWisUpOD2SRW87YYugz4ReJlXdQDBU+Jky8WnEyOxeFsTuvH?=
 =?us-ascii?Q?ny7XoPnRv2CJaubsFGgM9saySoJj3UdPDDMrUEgpdMFw/90Woh7dfJOIKKgY?=
 =?us-ascii?Q?ACCMKEznX0Yx+7uDra6WotMYPfFMEec7jmTQiFdRqxtfcSQUn+ao7HGSAAGG?=
 =?us-ascii?Q?HwpNXYOtg4DKNdSd5gWxmdVPyLlRxvcIqjQX61Xiy7dGwhzX7xkCIStUN3UZ?=
 =?us-ascii?Q?Hz0GRUQDC2q3SfK1M1tZIT7DJYwZ6IsRXnZ27HslIhcByBdLYx9Apcfb7rPR?=
 =?us-ascii?Q?sJ07niSWtdp6/AmyucwbIiDdVpgR5QFSZkwOueGozlv3uZvc79V3p2PElOrv?=
 =?us-ascii?Q?5flyJ9O6rtKMda5IU996MYsQJOcgkUy1/5GXOfk3T6Aj919ukPb6Ag8g0eQq?=
 =?us-ascii?Q?fc5Tp4qcIGt3w02tjBlSSkoNsj77ZoVeDBuJrIBfYACpZESMsyGHSNeGK2M9?=
 =?us-ascii?Q?8z64K2Vg7sZ7i+it23lCpDH560lS2dgtfJzxbmeEdGXwn56I3HF+c56LiXEC?=
 =?us-ascii?Q?H+NyfiqmUzSFnJqgStILN7tYFRShOAUV1dIIPqO7U5pzMOOXxAkd/2SPvOjv?=
 =?us-ascii?Q?RWa4DeN/p8eJAnXfyCGKK1z1W3UafnkN/WLE/fwMJm5jBKvP7WFDFk7Ls4yI?=
 =?us-ascii?Q?IdMUYr1TQpSi/yF84c2qh5b4ds5yNvH8BWZHDNHfxw5pditn1yawQfyrpTN6?=
 =?us-ascii?Q?mh6bzvdFX3g5FQgtUZSrp9I4N3L98+TkzYZqP06FIdT525y3vlTYrx2MMH6o?=
 =?us-ascii?Q?l1ZUzEmQAQzX9Rvq2voqT0q8RvmYw+BDwcXWikKWyy90clCOy0yoWgH4Uayh?=
 =?us-ascii?Q?lUK1mgwf4ZqAC+x41rLOKgXWWuL19Y1814+Z6z+L6RFqoC8/iIr9fJceS6Gr?=
 =?us-ascii?Q?8+DUHNs1zA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971cb949-04fd-49d8-e824-08ded290999e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:06:03.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpbeIzeUXNPhqZo6z45niTghqA61HUF97JGbW8H4MhzRrBilI+1aIekNLN6MU16mVwRNvbq7uSm05S4vJ1eAGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118

On Fri, Jun 19, 2026 at 01:03:56AM +0800, Wei Hou wrote:
> The driver's design intent is that missing or malformed component
> registers should not prevent mailbox initialization. cxl_pci_probe()
> already reflects this: the CXL_REGLOC_RBI_COMPONENT setup path only
> emits a dev_warn() and continues when component registers are absent,
> rather than returning an error.
> 
> The check 'if (!cxlds->reg_map.device_map.mbox.valid)' violates this
> intent and is also technically incorrect for two reasons:
> 
> 1. Wrong struct: the MEMDEV register block is enumerated into a local
>    variable 'map', not into 'cxlds->reg_map'. The device_map.mbox.valid
>    field inside cxlds->reg_map is never written by the MEMDEV probe and
>    will always read as zero regardless of actual hardware capability.
> 
> 2. Already validated: cxl_pci_setup_regs(CXL_REGLOC_RBI_MEMDEV) calls
>    cxl_probe_regs() which explicitly checks mbox.valid and returns
>    -ENXIO if the mailbox is absent. If that check passes, the mailbox is
>    guaranteed to be present by the time cxl_pci_type3_init_mailbox() is
>    called.
> 
> The value that the check actually reads is component_map.ras.valid,
> which aliases device_map.mbox.valid in the union. This is populated by
> the COMPONENT probe, not the MEMDEV probe. On devices where the
> component register BAR does not implement a CXL Component Capability
> Array (e.g. certain DCD devices), cxl_probe_component_regs() returns
> early leaving ras.valid=false. Through the union, this makes mbox.valid
> read as false, causing cxl_pci_type3_init_mailbox() to return -ENODEV
> (-19) even though the mailbox hardware is fully functional.
> 
> Remove the check. Mailbox presence has already been validated by
> cxl_pci_setup_regs(CXL_REGLOC_RBI_MEMDEV). The presence or absence of
> component registers is irrelevant to mailbox initialization.
> 
> Signed-off-by: Wei Hou <wei.hou@scaleflux.com>
> ---
>  drivers/cxl/pci.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bace662dc988..e44e5d209900 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -691,12 +691,6 @@ static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
>  {
>  	int rc;
>  
> -	/*
> -	 * Fail the init if there's no mailbox. For a type3 this is out of spec.
> -	 */
> -	if (!cxlds->reg_map.device_map.mbox.valid)
> -		return -ENODEV;
> -
>  	rc = cxl_mailbox_init(&cxlds->cxl_mbox, cxlds->dev);
>  	if (rc)
>  		return rc;
> -- 
> 2.24.1
> 
>

Hi Wei,

Thanks for this, looks correct.

The MEMDEV reg block is probed into the local "map" in cxl_pci_probe(),
while cxlds->reg_map is only ever written by the COMPONENT setup.
Since device_map.mbox and componenet_map.ras share the union, the removed check
was really reading ras.valid, which is wrong.

The real mailbox presence is already enforced earlier in cxl_probe_regs() if I
understand it correctly, so by the time cxl_pci_type3_init_mailbox() runs the
mailbox is guaranteed present. Removing the check is correct.

One small thing, maybe you would want to add a Fixes tag. I think it's
"""
Fixes: 8d8081cecfb9 ("cxl: Move mailbox related bits to the same context")
"""

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng
 
