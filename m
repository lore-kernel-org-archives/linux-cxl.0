Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019ED1E489
	for <linux-cxl@vger.kernel.org>; Wed, 20 Nov 2024 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732125928; cv=fail; b=WrS3jyLNfPhWzAf9rTSND8vgAqABO32QK6gRFUBo+VxyjOESmX0OwjM8Lbe8jdoJUcmP02+LZ70hWKgMCT6DD2yuwEivS+8EgvklUFMlOqE2rpVYymErzb3I3Kjtatx+mIuuKiRC6Zuj6qYMy+lWc1GaGb4yRKScPQPVeJ8Guy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732125928; c=relaxed/simple;
	bh=+JPbitFgLPVO7dV6vhDJ0ltlJidp3Dv/iWfVPYWZvfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SL8lILUmo2L4uyCKLP0j77rPPSsYZfTqG7NIJDekyzg9AiLv41YGRW1P0HYg86/QM64PAVGtaDkAe/Pq9HB/cJqPGUrzKq4RHfedbHfuIqHIwaksuxs+JgeVo0Nijx/eYTzUipczJG04ASfXaEznHOmMmHa3TiwXeEfOLxP/ISw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=af6NAi68; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="af6NAi68"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8ekFvoRokVxgCxoYJU9bf+k6tPrWiKCcKFagmIUn3cE/QkQkemrAi2Oh3WXbXjFaNc5I6TRkwh6sU17ZQfbR4FLKfyMzfqC9uNDL6DNCJoM6eBh72jzNirrKmHkb40CIhdZTI8pAoQdJMGdwlyAbmQ83/5cEYRSDI4TB4Lvxr+1grMKZbCsPnDNdY9iuO8NasJdkMYdFXz6vdrqIgiDboxeew7BlFfkra3pWAqnH3j7tv8IT66vf/4yr0XWLLn5xWnhTWtWpDxbClK0gOdX2VSYBZ3xfv1t7gd59RTWcDQT7FKuKIxFqS/h5/RndDReOePcPRo/Mn04SctP0eZ/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSzfSGCFT04QF8Vz1D8IM+30AHlGKULjdZncJyGoaS4=;
 b=tGzvVdw2H9c+KGasfu7Ca0A3D1roNu9R3MJyMrTwi7cYDAamC6af2j64yNzaK2+BL5n7XkV9bpkl8S0ZRWJWDyb2Tl+nQb92Hlx/a43/SZmXnb6Od3CUwn+ZBg39DmoTwp2t0mUY8VUf7OWXOmQvp7rnYTQuDcogzZhH42IeK/gELXwCmBQta/utI1aiCqRgx/JihgrP0biLLqi0j++Mvnn04miJe6poNSe/+0tU5xY6P/PntuwNznihacRz0NH33W4dcVCYiChqLZpI4g6SrUB4GzNy8xscygl2xBR9shRIboVquQ/spl2lRhCj1++3MEQmEQsTaV/Tl1FTb3swGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSzfSGCFT04QF8Vz1D8IM+30AHlGKULjdZncJyGoaS4=;
 b=af6NAi68AIO8W9y5ZOiCdcrTMfjCQPPJaqDNzRATV7nFTo945LAxMbtTWDy4I0obwhtmrtr617s/PbeoT7AHz9h8oYmWTRaNdYxlbGrGekcjUT5+P6pGa5BK3tanf6aOIGxbaKT/bTlnrbANsZX3Xm+/IKQ76QBbbpgyM2KTKmK8rbbRjCGKTqqoMxCXV8+VRTnRSq4HYoyhbOjdmjD8kfVodsGnjwzzBJPY7/CtDQQLa/4EtCsYmpIey27ZAx7isspkI/2V6XZz9b4gofLEkLM2v5wJEpDDlWLetOLgGz9YS9+PtG7zOCqDfZzPLU0U1mFLJl/uL7F8CUzNo9jytA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Wed, 20 Nov
 2024 18:05:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 18:05:21 +0000
Date: Wed, 20 Nov 2024 14:05:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH v2 10/20] fwctl/cxl: Add support for get driver
 information
Message-ID: <20241120180519.GC876522@nvidia.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-11-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-11-dave.jiang@intel.com>
X-ClientProxiedBy: BL1PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d8accc-d9b1-4097-9148-08dd098de5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xb4jBN/Z8LxUjdnGj8URZwInpaESur0qB4Jtmq8kHLVUDszmoi0jAilwaDs+?=
 =?us-ascii?Q?RdbnAFnO/CW6LskjRz/8dAZBYGraQ8qIKW97WoeZ9cLOYetc6BvVBi1s6HeP?=
 =?us-ascii?Q?u+JJ2DmF/5YChTBirrwtua92zs4TUfxi/PFhUWy6VrFAvh+niov6bibYy+r8?=
 =?us-ascii?Q?aHVpIyF8tkXlQ0iaaWuXab3UcMnRguPr6Wj8NkRBC0djiZ3iQ6f5Mmn99XT9?=
 =?us-ascii?Q?5vqW3f9JHm4x8tNcmMVaylVRgkt1yUvV2TF+O3g5sbjSatwOx7RSDgFNOD9h?=
 =?us-ascii?Q?46UG6sXwaVI7ysUyWUMoxb/o0DhJ1ozYur8Fmli6QM2++GcFxt6/akRHqQFV?=
 =?us-ascii?Q?mQ/+JKYgwlgv7hrJjlMdBM3fQ1tDC4c2r0l5PTlyC3iEVNUk6nxJ0Dv9brG6?=
 =?us-ascii?Q?Hf2D6hRJGlz2EDPsdUqRRE7rfw0sYUvBrGQW7Nbjo4nnGLBolVzjaZKJA2p7?=
 =?us-ascii?Q?l8MYVTF9ziVnwjZ7Cf2M/KFQk721WFoMUA4ykt0LeZ6pJne/fwUtlpxQyhyc?=
 =?us-ascii?Q?+XICcuolT4dUMuLD7DECGZo1GK8ING5JTeryb/Wfh3vDAT+x+XS6zNpl+w17?=
 =?us-ascii?Q?m8PJFASHrskbWgzWCSaBNBiJReh5XYUTFF9Xq38kbAH1pkJbKaijLJV/Y59F?=
 =?us-ascii?Q?/qT+lD6ecO2SaZu9TKytS9wjsMA0T9kUnkvpylujfefTJHYUkDXQcAnVcplV?=
 =?us-ascii?Q?gs4MARCUJRrfdg3W168AWIMaOpvLZ3yOjsy48F3I9Y8C4f12CRQOiCQ+wO+a?=
 =?us-ascii?Q?gvlucr6cxYOwVY2FYAQw9Uwtg9jJFH4BTOH21QEgtHg26hopjNe1AKSTbMCh?=
 =?us-ascii?Q?wTU0BM1LvbL+9aXBspqfpL28sHjnbbrOo+tSetFt0gimHMmEiQlu+7cpM8Ta?=
 =?us-ascii?Q?B55ZFBHPCWjY9EyDZgGn5RDGcbgYbZntFTaIbvAikXs0m4EsNouNAbv/OEsF?=
 =?us-ascii?Q?B7UuA2KZBauIekYsJzdlE8+2RSDdLKbvwHmdVejPfP3XlNKsbl5L+RdWHDiI?=
 =?us-ascii?Q?s3/qHyuPcBy7dXeCrvBeHfwkXFI2tYh3JM8HfXvxy23dK+MxBRlUq9GZejUs?=
 =?us-ascii?Q?8xiNixjUDDxrpR2lqnjLnJQuhAJpq4+d/RhjFhYdZ0usn65WHea75D7FCSi8?=
 =?us-ascii?Q?Wvv1z8zskyPuyMTI4KkIbxcDtYt6WgUtQgiUyXfaSg51bJ+WvbGtTECGLh2k?=
 =?us-ascii?Q?p1lCmpqwSVft7rVqk/0DpwPRUBuOzFaT/5/EWf1C2y3IezuiIpWO0p3CzJzy?=
 =?us-ascii?Q?6+QzyJi4l2C117eWJ91aIA2keI53JUWzG3qskr9mSM0ynYsQlW1A4bq00dsZ?=
 =?us-ascii?Q?D5IEBO5e51qY6dFBAHQkuEZT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1uBI7F/OFtImSGl1O393xttKpSPLw3CLOCeLF2MnNCD4SHWFtsIaDFYM+ard?=
 =?us-ascii?Q?OtjtcEANa+RZmCco6Ikc7bGT98rE74jf37di72cvNqJuGR07CVnS2LeYsK7t?=
 =?us-ascii?Q?vnTOi+7FRMvOwu71+aL07C8N+NeqqfcY9EdrqvETsrZ2qlI6IqyY0R7Q+wnj?=
 =?us-ascii?Q?bXymBHf2chXqKcvW/omFFZ2yBFN5/CvhYO7gwkEHK9Ckphmo4BNJz0ZSxiyQ?=
 =?us-ascii?Q?u8f7wFxMMdS/cxhIGm9HeWK/d299HHJzeCrmEze0OU/8ozjMsgQ0D1I5EqXw?=
 =?us-ascii?Q?4Yo6RnVCTmIUXDsIXoSoSOwEOxalQfobQEjHfh9R4GPoy/j8iKb68MF7FdCz?=
 =?us-ascii?Q?w8hr1BOz+qLEI4Spv+O1XB3EDk/pmDQj8PYGqKjUitKlEuOgHg77o4yTqXW6?=
 =?us-ascii?Q?Tk59Ihp8xubYqQk9p3Nduo+nJhNbMANzVV+bU5gJgBXsCl+i8QYJ4ZytgrUy?=
 =?us-ascii?Q?LOXOdFwWut5RrLb9yjSTQEX5MGr7uiqj9oFo+14CotV0guuxWaK/MYDdAfsT?=
 =?us-ascii?Q?XHnjg3AoIJhwiQup+B6fDqMlLjAla1VEF4CsuqgNXos3nkTZvDFfn0TwYYKs?=
 =?us-ascii?Q?emWJnNXfJgzXBw9RK4/avonLorlSrXPmDUg7NOyHUz6bAE8y6Ux1qSOsRFHU?=
 =?us-ascii?Q?OSPJ/AvyOtdIAfH7hUXtj7ZjR1vT4DxY/3pZFq4jloSm5d6F2BXgxGMnjaFn?=
 =?us-ascii?Q?v5MzkLQuzHuxO5P7XlHHt3EzqTYx/iGniPDDxY9q/ropwGcBdK62O/YBCxB8?=
 =?us-ascii?Q?MeOArW6pqT5F6T0rkQKNgO/Rrv5wYXnVJ8Iiq6OqZCdKwmKUbHPL6W2menvI?=
 =?us-ascii?Q?DoxpitQ125w5Ondctjc345Aj0KVw7St5JDj0FkXhoyqXY/jy7L7lQF9e4/ca?=
 =?us-ascii?Q?E23QjCSzE7vj7SbZTpJOKC6ZBlSWdvgOnmxNBr8hFF8stoiMUjPyB870CVdZ?=
 =?us-ascii?Q?SFznwLWLvD/Jke2NRYd0Iq9jsyhqumbgroygCCpCXJWqwOXxoPldwH2PdVu0?=
 =?us-ascii?Q?86m3EWxznQ3VyjJLzbALlhjAIEsemBXqFdtgmPVKOiQF+udy0dI39RBGQWqZ?=
 =?us-ascii?Q?sHV5YS05m24Uj8UfTNqEs9rlj53lltOC1B9DQXdWr6YzS7ldKfvIgcugFF3v?=
 =?us-ascii?Q?2USEijrHllIowPxUzLeP8nine2whfN63ep6PuffR+PSauHqsj6iSIwSuQtE5?=
 =?us-ascii?Q?G4rs8Qtq7ytD8dWM6yJtIh5eeYFms0CatPbXR4g16nNWGt3lRy8lpOo3w9ew?=
 =?us-ascii?Q?6vHuFXDhL/Rbz4us/dwb3IlJ1xgGMDfHbwbtrYM2rhBnIEbCPyAi11jMsfup?=
 =?us-ascii?Q?nVA53pgBkMHyp+4OM1uLTF3c1QqGlyHZ104e5/cppGcafPU4swd/mbsdP+W/?=
 =?us-ascii?Q?aM6vAdPUQzFlbqv1vjcBE5lPgaqKIVckLPxFtdYc8XVA4pVomslHllv0GPk1?=
 =?us-ascii?Q?tYhFL8rvsdNNBHtOr0ujp+EawEguppm7Be+676H91bSiRL0EcPuLZzrxcB1w?=
 =?us-ascii?Q?LHYZt2W0TknWcU5SMaDzuu9pNVj+CtkUWp8pnGdnBizNkAS691RgfR8TwN0n?=
 =?us-ascii?Q?xhCkvbQqWAE0xBwmejgfMg6kDLlKOZl+Lv6se4m8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d8accc-d9b1-4097-9148-08dd098de5d0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 18:05:20.9671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 786O4mkOc4ZVm+uwdz2nxotNDMII8/MPMMIogJYZbw1Sq3sd2Rsopx9fkL6HY/sv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451

On Fri, Nov 15, 2024 at 02:25:43PM -0700, Dave Jiang wrote:

> +/**
> + * cxl_mailbox_user_commands_supported() - Return number of user mailbox
> + *                                         commands supported.
> + * @cxl_mbox: cxl mailbox context
> + *
> + * Return: number of commands supported
> + */
> +int cxl_mailbox_user_commands_supported(struct cxl_mailbox *cxl_mbox)
> +{
> +	int nr_cmds = 0;
> +
> +	for (int i = 0; i < FWCTL_CXL_MAX_COMMANDS; i++) {
> +		nr_cmds += !!fwctl_cxl_find_command(cxl_mbox,
> +						    fwctl_command_sets[i]);

I'd just use an if here, adding a boolean is weird

> +/**
> + * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
> + * @uctx_caps: The number of commands the driver and device supports

Comment needs an update to nr_commands

Maybe write a few words about what userspace is supposed to do with
nr_commands?

Jason
