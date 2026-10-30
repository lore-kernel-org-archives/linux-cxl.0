Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793354109;
	b=pOR2fPMqU8RLRf6LKMH7zWDxmK0r/bR3lw+2zB1MehhPqj0X6p+FEf/frr0O2GBC/YTK
	 vvh0RwsJlqF0P+b3zNpJZACuxFh2HA36StEsWp0vG93BtXemXZSGHyHaaX2cRyKUhGvxW
	 uoHbvLQXWjdve6b/IvPy/6bD9T6g2Uk/QX+JNL79Ds53IYj/xG7dktZQcR4bZTpaJ9Huk
	 H4/TAeKP0mrGrNzOZ9SmzOwlN4P9VfLdJ5lwMRYn9b+uUOfNKqiJOU3eWu7DibIxydxCD
	 1Lyww+gmd/CNsC2CnT4kPOPOJJFc/M1gUHQgLs8fvmTQh908EZRmxsXHAaDCNjCxqJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354109;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Sw8bIX84XqreWLicMOPXzlGfc4oJh86C/+hhyKgX8Cg=;
	b=iP/9/yNsGWJiJJHW/ZcKR2D4pEP1cVpSzY8LbbNcDPqI/LCS6pt3m0ysP//oU2k1KR9n
	 NSvrLOUTYEJhmdimZz0jhSfvA3Ct+oUl68J3w3gXmJJn9NYILbpBP+YhAaUZbhQh9Gynn
	 TfakOC9vT8GBctP42QF2+uJnJ7uG3FeObgR7UpZVH92oUiXiDv3u7rTGnscwXHgHUiBKz
	 1+pvRzuXkfTUnf+mwhd0Pwq2Y6MGwU27oY0b5RI5M0XgAkky8f6E31waDaxWJSEZ8lAw5
	 iRRmcT9Gbbb0WHs9wXx5f1kZ6Opx23iRshwBNlg5tihJTIuoUKft4zOMZoooxL+m+lA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="hKnxD/Yl";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.36
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFD606A31C;
	Fri, 30 Oct 2026 09:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2AFD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hKnxD/Yl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPQ5MjwCdC21UpVrWoNxN+T+12MPqJpaAfcTChDu1HHv986otBwHBOzIyaAN1woPXFt+63kZftKlgY4OnHuoufrR4xwJYQtPVjFb8NFj/H2IdCfbPXHOkBVYYyagS/hjZ6u3NVLyoHTrjPioJZOJEuul3BnKwnSKD8OJIJwqQ0TScovX1Vy1nZA2KDJQ2bDOwK7/sdsnEBvLrAEhciDu1IQ6khg70XnfC2lKghpZ+w04q9TP9KP5NzxARz9TbEkon/vgRpvqAoDLo4xWIAiJCCM/07vNgGxdqgdUDo+gtjtgA5ZrD00oLuoFfiInUkFJaLBAbpimOPtywBV14VeSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw8bIX84XqreWLicMOPXzlGfc4oJh86C/+hhyKgX8Cg=;
 b=tpDdDwkSJ42HmuQoYfWnicGdAUUmetj+CEUYqOJvtk01Fh7uy3R2AUMFBvVJgvG/Bp0J16yRbSGvx6wMEFwV7B0nZdh6pMN5253BECEb4QR1jy3Dpuf0JDe4efel2zCYnmSkUugbSoaeHpLl++cWzBGj1lM86R9rUI5INMNX0AyrsOH5cwQ54Za3zHbog0hj5q4NIE4LLGk5Pol3J2ftoYXmvgCGSgBYQfgmvRRujwsBqWUsdhEDdaD6yRjxQye82iFtqsBwttky/PlcdHHvntRJcVUAwE3JBngfSOOq+0CESrhIRAnMoPHGP3Jbgk/OpkwZrDfWsksKFXvySnQhAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw8bIX84XqreWLicMOPXzlGfc4oJh86C/+hhyKgX8Cg=;
 b=hKnxD/YlCLpNXy8LkYex5hfJC3aV4Pw2iaHPE+6AKYUlE37P+NNiBJ/zp1/6WkvpYFspvqIAfZE6tlDrb9oCqkZC09A4DXdYH0bdLxA+AGBl0QqveVVyNCFG91N/t55YOxxZXDge24ASQ2CruNFv8tcO+6G8hd8UaPpOPNI3sPntAPmJHaw/FqL/SJEbo949PjKILEZm2n8Xr523AjvYv5OQisKWGMdpSK3HwBeHLW/6sXrVkAuS2vmYUjJuTBCAtwfT8g9z/ScUylGiqChODzNC7WnRgJlQXqyvkabQ8Q+FX4U50TW4ot9iZL+wrDYMhRHGGjUxDc0wa/Vz8bhy9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:55:05 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 09:55:05 +0000
Date: Fri, 30 Oct 2026 17:54:58 +0800
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org, dave@stgolabs.net, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org
Cc: ming.li@zohomail.com, kaihengf@nvidia.com, kobak@nvidia.com, 
	newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI/CXL: Guard reset recovery against inaccessible
 devices
Message-ID: <auRpP9Rooj_daFpd@MWDK4CY14F>
References: <20260929020405.9724-1-icheng@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929020405.9724-1-icheng@nvidia.com>
X-ClientProxiedBy: SI3PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: f4939619-0db1-4388-b374-08df366bdf5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|18002099003|261009223027099003|261028144727099003|261022075727099003|261021121427099003|10067099003|261021123027099003|261022105027099003|261026140227099003|261026121527099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	vkQt8D/Nnli3ooVrPe2R5p2NjXVg/HPwBrFEVbZWcQ/Tl8RkLqV3NZTfxIzoaQDYZjJeQzu2ijo70eUK0rbNPuWYlplbgBN/cz7wWBjmI8n4eI9moV2RBzd1CacFJmF3UhYCfiwHeh87F2pLkayi4092aYPLpxZWWqsNY4IlVPxJBeedp9+f2LxI6Ks61sSPoN5mIHdPjiAgagcHsol4+OJwA0crJsS7a7vwK60n7a3DjNCuRu4fZ1l0eS/FgoTgovj4jDeIdKmNn0f9rG2L8BOU3qIp2EJ3kME5kX/ihi6s91j+x30TtkJqnyaVhnPK1XEAG/yqhuuFM0yOQ5J/W4pwW/Xx8X2T8AujdBSBm+qHoqZ/AKoPhqdmghu1FtCeCxVoVcP8zt3mLdNWn1P/CVXoMT4M7tH9CqZGW2cHry0xVJzIw6cWN7v9ipT1N+BIRNbdDxNcrm8xMzlRzZ7Hv0ubdv/w2u4WW57dvmlMgFGFdI7PMXtPYkKXjyQIMGUfpWddJccynKVlTr4aacEK+6LrmBjAABMcaJWcCbC8tvGtcgHMHEfyKTilN5tjSmRhHVWa8LzYJzvLJBBfZmnOu4oZlXhP2Oo1LR3Pn1O73WPWTN3jKJkvDUuNzC+L3bw+Ruwk3vrOWqg6HwXJF99YtdL8NxysSgX+RKGYSC4NZqI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(261028144727099003)(261022075727099003)(261021121427099003)(10067099003)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?96HNRIz1PuV5LhWI5EfrCPnSQ/BMGXO6L1m+5SvWMT6QRpoRzsEzFNqgqNWy?=
 =?us-ascii?Q?XiozdD8OsdN2DrA279T5XYAeNU4Bm/NcBgnItVjdzQvxYypCldfCsR0Czes7?=
 =?us-ascii?Q?r9asAO2zjFF5JJ2Cr26/GMR40iqBvnNmu2lX9caKT+B+qhAUp45w8SWYU26T?=
 =?us-ascii?Q?DqahjobsC4H1hK2pr1nCg7dUXqVkRR/vpu0o9T2CvWQRtLztiayq5hQUSILD?=
 =?us-ascii?Q?g/0xn/GT+s29UtD8kOm6o6ZIiJ2oE4klMvBbUDKjdaoXssc4DOcv2DUTfsZC?=
 =?us-ascii?Q?QJOe80dZUOL9MIDZEN4c4h6czv+IL4FtoCywRmuEL6O5bBj1oaMX7inxPumA?=
 =?us-ascii?Q?hUhjNR5X1xcFI4hKjLg3bHLqF9sHM1fW4LqlDom0X9Kf6k5ehbwVK7PigMvj?=
 =?us-ascii?Q?cTKLdl4Ia/CEl0VRy99wizr+dRwvFCwHOEJGVCWlbLuxtUpDj6uH6R5OgTKd?=
 =?us-ascii?Q?xTi0icJv53qhQBsXLh8AAlktWQ1Z8eH8FL4bAZjfPodBzLpBX6xmI23CQKik?=
 =?us-ascii?Q?P/8Q3XT+Xzxl7xI5MgkdNpx1a1OEbsQNtpoNL9CADh2l3f7Qvv0SQwr3zGsE?=
 =?us-ascii?Q?wzIedsYQToTR/hmFgq7Mywtoh5ICxxwtxTKXziudn+MhDg5tRTGwIkluEyTV?=
 =?us-ascii?Q?S3hDqpM7hWbORtOHMQSP6dTl4c0kLRpSFa3d+rhAikfu4rJfdmSgTy1O4swP?=
 =?us-ascii?Q?eO73LRMs4C9W0a4oZpHMAh3cN29yuqaj+oCLGGTK0pMPyb++1MqY7lm4rqAY?=
 =?us-ascii?Q?TZnUSSQpDgGTIsGzXciAKrHwGHNzQxHdJgMc6UnZvF606MAp6/5uPQP6Wubr?=
 =?us-ascii?Q?+qCqdxLuSnJDb38Oy8s7Fi0AMLKYnT9AHn8hR7HXHELuO2OiSMBtB0esuf7r?=
 =?us-ascii?Q?VRjDHe3hfiGGmlSSaTdFeOSIXraKa0yRumu9qdqZKu7Gj445dORAmuvVifb2?=
 =?us-ascii?Q?XfQwzeIOGpfvy/GqnrK3LF+cnE6tJQDxUQ8Eb/1t19Atp7DIPPxHh6Mqw422?=
 =?us-ascii?Q?uEeL0+WKcsfkgqKwgjcft7mVH6drElX5ASbVSuCc71l60uC900WeqVqjx/ZT?=
 =?us-ascii?Q?hGcack8JvxAUDQCN9/w7ktItVJBzTDQkrTf44NXt7bgGM+2nN6lgiwVcen0K?=
 =?us-ascii?Q?E3B1qw6igtYnfBdv6jZU+pWt1z55gtH+VtytXu7yLDXPEpIUbkVEz91OlIuv?=
 =?us-ascii?Q?b+4RFl3LzLA8WHq+O7hHElwvb5lho1Wy3mmx9YctJViTG9PrQ7fB1atq1Gvs?=
 =?us-ascii?Q?HgQyqYKjwkgqJEiVMk65XNiYG/q1znJPt2QqV/cvBZrCMbIVOrITeAY0k9gI?=
 =?us-ascii?Q?1/fLVNGkNXKaI6+VqH2WSSe0UEHe1uv7/GNnzl3367/wWQFZLqW5hH6If81d?=
 =?us-ascii?Q?KOjMFwBfJu2P71be062MScOYW4C9KhDnjcSFxosNdZ/IaqdhZ+eYBSvf5EuB?=
 =?us-ascii?Q?4nCTq0Rihi5ohqfI99xAiCLHUBvPWpHaZFIJnn2b8iUW0tK8qhYkcaK9HCkm?=
 =?us-ascii?Q?O9XoYtJUxVwHcZwgx+qq67En1cXOzaO6QvkhQS+Ym4elcbQuHJdi6z+TTtEk?=
 =?us-ascii?Q?RAfxLlPAkqLcVQ3R/VbsXJjgvRlRrMKp/9ZhB9ObK9tvjjI9kfpeYAgukF87?=
 =?us-ascii?Q?wmmDsSbwpNOiz5nL8M17wpXSCOa2i7mxNwrse4IQkg/wNeijJHiwyGvwIOa5?=
 =?us-ascii?Q?35BKhMKpNd3c2EpTc4RzostSjZStK53QHrlreGMMP5qYLyd3eHs7d6jMSMG0?=
 =?us-ascii?Q?iPw3GQfD1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4939619-0db1-4388-b374-08df366bdf5c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:55:05.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhzVCZSINNdkYpv4eeyw4pOoRCYWtmGB1fGUq2JmJykeZkPlY8HEJ+ZHGlSf98vMIM2c3QkKeS/zrIaujdFeJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457

On Tue, Sep 29, 2026 at 10:04:01AM +0800, Richard Cheng wrote:

Hello folks,

Just a gentle ping on this patch series.
I would really appreciate any review feedback on it while you're available, thanks !

Best regards,
Richard Cheng.


> During FLR testing, PCI configuration reads returned all ones. The
> kernel could mistake this for reset completion and proceed with MSI-X
> restoration. The resulting MMIO access triggered DPC containment.
> 
> This series addresses four issues:
> 
> 1. Reject all-ones responses in pci_dev_wait(). Use Command-register
>     polling for VFs, whose Vendor ID legitimately reads as all ones.
> 
> 2. Return -ETIMEDOUT when readiness polling expires, preventing fallback
>     to another reset method.
> 
> 3. Check configuration accessibility before restoring PCI state, while
>     preserving driver reset callbacks.
> 
> 4. Skip CXL decoder MMIO accesses when configuration is inaccessible
>     or memory decoding is disabled.
> 
> 
> Best regards,
> Richard Cheng.
> 
> Richard Cheng (4):
>   PCI: Reject all-ones responses in pci_dev_wait()
>   PCI: Return -ETIMEOUT when reset readiness polling expires
>   PCI: Skip state restoration when configuration is inaccessible
>   cxl/pci: Guard decoder accesses after reset
> 
>  drivers/cxl/pci.c |  6 ++++++
>  drivers/pci/pci.c | 16 +++++++++-------
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 9eb6419022d81aac6d1d9ead0e1865b451153da5
> -- 
> 2.43.0
> 
