Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F16F3A2E3F;
	Sat,  4 Jul 2026 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783162629; cv=fail; b=U21UTsRlkbuQr+9p0Z/0E54ZEfqmv66n1B8ARMh/f/gohlz4j49GliaWKoh+zuRqtoWv4BukyR6CUh1Txe7i0Rcon7/Bir7A3n9200eR9O9wpy6zkHjzNIuHsvb84v2tB9B22cHtEk36LaST66Lk5Y6gb1e4KpepRexJnQpbOUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783162629; c=relaxed/simple;
	bh=/tLElXgCzisaovftnym2w6kn/BG0wtKxOU/pZBYOv6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rXcn/dtbnGKZh4XReWsMpX0LyQzEwHPT43XzZzgsZzwgPYe7k8H4cw3BgkLCVv2jVrjGG4P+j6qMUHLJO68bqz4tHu9e1dCfTSnFuHrwRbCNE1r631gSBwhyx/n4Rm2ipEjgfVgqb8pXFvSbd3ko3VdD81XsWK8NuiDfxivcXT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XcLvRNZU; arc=fail smtp.client-ip=52.101.52.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XcLvRNZU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2N4FcPcPRdg/M8gAAbjrBiificf5NOO0mXk1EeJD/hWN2RUq+Usm6xl1472lV4LwJWomZveJsJv4PBuOzPNxJ4AlrnGdmNWk/bnAQY+SqEjBme08IPCJbGmK9YK71cuq41so/J2eIvHYm+yIQIVjhnZJnuoOFHkY/uaDuDdsG7V3hVw9cchBO4EyqOkJg0yRONErX84sqgmeH9otQKYMpK8AaYQRGiHRlHjFHcxbi1vW64ZMKFpfWN5uHCBPcEEwG0kYd1rz4PlWo8/eKfNtvtqYRDgHEkk96txYe9WyxIIeMNZQBBCFM1Mx0W2QnV9d8ntihNPk4iP+sxxzewC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtyKheNbVYBsDNmG0/wYNO0+AlXjwVyN2A4d7xEoaLg=;
 b=tnPMRWg9lBwoZ6qvAbe/gPwsLu80FWXmzIinMETRuHIJuQMKG3zcztpOTnos69FU3wYcVVqIZjwnFLAYfQqipIM8yPZXLO2UfrVtRAUiLxYYtBlDN6wuLmeKoQaSefTXUXIt2FXEwDKlWMs22YK1lHC+UiP5qUvWMHulRD9KYVm3aZJtbGQX0FErg+nIB918LXSsJrNVlWetvqYPUDE2KIUr2UuwtsO6kIzHDkbh+GfAjxX/UjwzhwL5bG6O57KciPGv8Og9udZb0FY7dk07Jy1UXOcLZBilFN6YiipHQQz9D6+Nu9DPH2wwV7Mt4Q7yCH/ycAFX837EArMqFOBdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtyKheNbVYBsDNmG0/wYNO0+AlXjwVyN2A4d7xEoaLg=;
 b=XcLvRNZU51Fq9dVqSxRqg1ipLd73BVOnI166FnNYZi79XH4xoj4OZf96o5pSs+7wTFyQE15WBbHC8Kce14xRICtHNBmCWmIF9+IhXy7w1ZfHS8fYGyXY7vzDsRPKoTnt4gwQOfLqg1nC/i0IWO39luvjUjqLRV605LBJXfdvIUMg73uQFJPkQkZyBLhGEOxJqffBr5d2+OS0iRv11BjQYKK6ToVKjEsnJ9nLHA936iNGNnffw44b1ROZSZ79qVdnEA3KQCdroUACFP12earCNdxf90ehhgmYyXs0y0VR9WClg6nVpZfr5onp2hCi2TBx8ZfV/Ac1sLDRT5bwrHgvOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DSWPR12MB999127.namprd12.prod.outlook.com (2603:10b6:8:36c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Sat, 4 Jul 2026
 10:57:02 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.009; Sat, 4 Jul 2026
 10:57:02 +0000
Date: Sat, 4 Jul 2026 18:56:56 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Praveen Rajendran <praveenrajendran2009@gmail.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org, iweiny@kernel.org, 
	ming.li@zohomail.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: Fix spelling typo in asynchronous event string
Message-ID: <akjmxFrZFbmbzYex@MWDK4CY14F>
References: <20260703145250.3953-1-praveenrajendran2009@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703145250.3953-1-praveenrajendran2009@gmail.com>
X-ClientProxiedBy: TP0P295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DSWPR12MB999127:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea62967-d630-4054-9ee8-08ded9bafa62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sr/7IK8k2zykex0Ioap6kjcXbHE7gRV7RLG+QaxOSS/KBhT07zpziV5oN8vzH1/n6xQHzsC+EQxsVXOqm23WLnelAAEkYRF5PaNtq5OrqqYRjFtA6fQei/Oq1nOK/v/XPeJKAiIKL2d1Gdi7PaiHRokBPTMux40d+AWOgARJC3Aq6EblGoTuH/pz3sb2O2ES9H4+kA3v/MewK80UH6L2HR/T17jqiELDJ8NKnC5HDoCUBtzXYa8ILPpl0kwMTzyb72/VDyIvETPyjQ36gaQEEsDvUG6atClTs8ycIaLSsjHrZ5wSZamaJlX/5aUzyq6LuPIfYHfJFhzlEqPNoYBaN4tLG3uKIYksI8Guki0/ECvfz1mTgWiB1etYjJHNQjRlf8llYfJMMegU243smt/aDroOZOqgYPIPF6m2aylhceyvP0UVzMMQqkwGMj8M4qI6OLxLTZfscprQIg6EV6I1Wxp/JyCC+x3bPe9e27aMWuO/3LrezCiuqB5C9nXfViBbNtJ59J5+7vreaJ/+AVfu/zkEihYM9pwLl+YTWsvjuM+hQU4LXSzp8TuKDs8Lka8wsfz6vt8ArPChaxfFIaqL/lucwPSzr3poT0zyQcThEjLOFniM19C7fz8BdvvMSCJGQhcID1rKHWanUROqrS8e1TP+UvzoJ+f7ogAQyQhQ9zQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2G3pTzM6nAVaUx86J/kxeKo0sZCB8Bjnmm+xe0aint9H6RDHK+E++ZnKdztv?=
 =?us-ascii?Q?xTuxalzg891kX5ePN+QJ7xSoAmzGutFx//+LvGeHQXu+uVKULoieHWlawapw?=
 =?us-ascii?Q?iHcpUw0TGxU/IfIbytpNXwcofWKpDWmgmlvKRO9esXbsnvDacbICkXQErbRJ?=
 =?us-ascii?Q?olByQs8mxv5BzMJNZezNnzzYElw8PhfwoIHv+fTsiDQTwiXkGM2n9xj/FWbN?=
 =?us-ascii?Q?fBWCKsDbvPe2flo4KiYuH840EQ8v53i1gjBLje2zWnHpNoAsc+iFeR3Xh+5s?=
 =?us-ascii?Q?UIc3lVKyLaRaTOf+GAlqpQ4JPRLT7UpM9+VocEA1SphFoTzfudM5Aa1Lm0Cp?=
 =?us-ascii?Q?lEAc6zHrtDgibIK2k1bbheGn11F8ZeRb1qu7fsgIg5SHFpSbOpOhdwIZ3Ozq?=
 =?us-ascii?Q?gAc6h8DuswxBzmvUyuFGMbLNKFUHAEb4tqGF/xpuDmT0FexWiQmwTqhK/PcS?=
 =?us-ascii?Q?AhdrPLKzVMi51Ymfe2iKyTz726px4poF37Om7s/wkEMI9RY4cEr0cS6VMI2R?=
 =?us-ascii?Q?tNmIr9zFLsaiWDR9OOghRe0JX25y1Zenfkr9fGGoUT1lM4QrGfv0tkvIeWai?=
 =?us-ascii?Q?ijMPjwEBWxebSefMge98Quhmrzv84tJtnGue289e300f3lxLvOc/abFiGZMA?=
 =?us-ascii?Q?SZBMyaIQucjp/6FYI6FSVIzdmzH1+QZiadbzefGuJqCn4bc47AeiAmi66Km0?=
 =?us-ascii?Q?j1vQqWCM6UiXgkvtniqy0EJUCrxAXg+JPh/NJgq8XXNIBp9KGjfq6TTU/Nid?=
 =?us-ascii?Q?E2hyJoJzMkGN4RLpIIkQqMWiqMDetO2vaCsOknXCSLopSb8fFCwafnZNdya4?=
 =?us-ascii?Q?0rjyhKjwWy6MeCFcvxOtANFbpvdgRWgJtdXyfc5LwRQMf3h8pV+LXptxur96?=
 =?us-ascii?Q?GfuyPbON1d9vXICtB2EMWy5wD8i6t/q0RtNntxVoFxqZ4nExAIVpkyeIf/ga?=
 =?us-ascii?Q?jm3oRnsGAwbdCPLPx11ck3qfF+wtAoMo6aAI6UaFIZmxZxXK9EtOvSDhr8rq?=
 =?us-ascii?Q?mHQHB3lNQsGwkwl3OIlckcG8XVbO5PSShnreadkutOcrF7gDqsOkIrunAcNy?=
 =?us-ascii?Q?GyQxucntlC2qorGifdDJZqZYM4ezIaoW55fmFi3ExiPwIfz1+HGgEjTi8deO?=
 =?us-ascii?Q?U0Mf3/BIX4CY+1qazKrKEysZkPmpvAXMlfiEJuZjY/UHdncZ1/F7iUUwDNV/?=
 =?us-ascii?Q?vMK1NooFBHRPOIVF+Bt38N11kiY40V9IQO9QZmTthtIp2CYS2qTbwdTGIWAZ?=
 =?us-ascii?Q?A2CMmerPG5OrZidkZ2YjJ5U/6HzDP4l0GibJfSaaHbzOS/yXYlXuy3xR0iqT?=
 =?us-ascii?Q?vGVTMk9/fPliwlG60qku23Fkgt72tputREvEyFqa7oLnWD0QREyukNS8YWgM?=
 =?us-ascii?Q?vxgB9YScACFaz0X/Cz58X2WJuSeESUZP/RwrGkT0Zfxn6045CsoCsjDP4lQt?=
 =?us-ascii?Q?HeUVG1JVRucZl57GVqOlbl2b7qy+qKXbsOzZd0EB9zOE66aax9JVJnw7Qdpx?=
 =?us-ascii?Q?K72Lvm6MkK6Ia2drvs7K0NacROFl8GOLQ04groR4G0ZPXhKemHOhRWm1z53M?=
 =?us-ascii?Q?vxR49h8ZjOpUbuY4SRTA1+V5H9NhXvdXY/UKdIUleIm42hbKoODBJ0hNZeKu?=
 =?us-ascii?Q?QJuAxr1ih+mln90CBtJDCxcYML0ilZjpMjz+e+dXq7uWBP+M1Hb52iQOTCz3?=
 =?us-ascii?Q?e4QFgAOyDGh0cvA8ZtKtWfqnHZq3T+Nsx8s50XFGR0zU62DQvu3Lp43GLGYy?=
 =?us-ascii?Q?HXqPWNImOw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea62967-d630-4054-9ee8-08ded9bafa62
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2026 10:57:02.5482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3R2Fqx0ofoAURLMzs7LdodlUE8AVJRstajND0RijJAQvG3XO+8j2m/B+TE9pMj0sdoiszzilLZS+inIlV7OzaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999127

On Fri, Jul 03, 2026 at 08:22:50PM +0800, Praveen Rajendran wrote:
> Correct a user-facing spelling mistake in the CXL memory error logging
> macro array where "occurred" was misspelled as "occured".
> 
> Signed-off-by: Praveen Rajendran <praveenrajendran2009@gmail.com>
> ---
>  drivers/cxl/cxlmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ed419d0c59f2..503ae2864591 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -183,7 +183,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  	C(MBUNSUPPORTED, -ENXIO, "unsupported on the mailbox it was issued on"),\
>  	C(PAYLOADLEN, -ENXIO, "invalid payload length"),			\
>  	C(LOG, -ENXIO, "invalid or unsupported log page"),			\
> -	C(INTERRUPTED, -ENXIO, "asynchronous event occured"),			\
> +	C(INTERRUPTED, -ENXIO, "asynchronous event occurred"),			\
>  	C(FEATUREVERSION, -ENXIO, "unsupported feature version"),		\
>  	C(FEATURESELVALUE, -ENXIO, "unsupported feature selection value"),	\
>  	C(FEATURETRANSFERIP, -ENXIO, "feature transfer in progress"),		\
> -- 
> 2.50.1
> 
>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng. 
