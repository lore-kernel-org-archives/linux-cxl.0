Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2136.outbound.protection.outlook.com [40.107.92.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD96CC02
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227749; cv=fail; b=VTe5HMSAhX1adp4teHQTfNWcGkVQFUPmhWHV4Q+RCuy7Hq6WscfBCrYDpQO4UxNsXQlJs+RJYh0TOTvYV5NgbY7RXTlGHetIdDtPbs58d2w+WeR+1swMMlFJptXsqEjTBg5yvbuhYrqNlG9FXb2TN03SeQQsuMD8aibCrNzoA3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227749; c=relaxed/simple;
	bh=TVicq6V+Y1sEPciCQbwBu8TeGljCbhltLa6OljPxuIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uVMt560W6GiYF5sD/cSOlGdKWoEQa7hgbid2xpRCA+Ukqiv+m6ePWSmO9XwyxPm+Fpc3VJNSUSqkGQKIXSLVD5URXhSUpJok1xNuVsAhEWA5MnNyoCwNJ3wWiqZOz5rIYMDY6HV3O+5ezmLhqcXaw33OrjYsZCwVDaFEU/p6ZHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=u1atIwJ2; arc=fail smtp.client-ip=40.107.92.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="u1atIwJ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSaSKSedqq2S8dv1OpIcTu58M1liSnhTohFGnRRYjAjQuWzNimQ60tZqmxVJVLQTZB77jlPWvKlUGICZHBEdJVIrJ+viJ3d0f28MhwN/A1YZbmjJa7lEUPI3QSB4O/pmkSToDVPPC/d4Dia0VAuNI4ANbPMvFW+ICfBCMzpkfe+HGZ9zDbqd6gEXFFoo+cK9q6VHRdaXi59naMcFuCZvMFexKovoM+EGuMHxN7rlaqrmMnoUW9pUa+MXJhhkVpCZack8ZPQlhnfduacwPO7mAUAE8vXw8QN6mo1htdelOYko8EN7MQ+W/78yNzW8+6yLroqqn+BYPJekrBSsnN45Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoE971ZC/b0yIJClEpgfWPxbk8X8mWDgt0nO7DWKq10=;
 b=fZ+ERl1evYsGqRb5FBdKOPg7g7387rIgIq0vjZ9gfjzxuZlGUZwkXEjzV0+L5OmGbMnt8wa8XjsAPmjMc7ufFFp83mO/nVKZSgv2gTyTg15lPL4iNqvHqmCA/9FPqgXswC4SlmzAtJZ6UCOO2Pcal7JtkZfEOWgOWJ+2vJQr6zZja/d9ZG03O9h3e+o2F3v8znesQ9ukfvqvLSa4OEqGLpZUHcAacSvuSIBw4SJxDg+vD7AlB51/7no+eAMLCTtNa5dY/XGz15+ZdGlSSuwTfi3Few2VRlJctDkxlYjo1uqTbLKfKNVrhicrgkIRKvT25xlNinpKh3kyRxGN1OiaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoE971ZC/b0yIJClEpgfWPxbk8X8mWDgt0nO7DWKq10=;
 b=u1atIwJ2PLq4D+cGESHyKwhPk0qI4ujdtAgGY1HujQo+IsExD6FMr33ar4b9z6obCNNoM9Rj8O+h0hYQ6j3EtdWT/SxGYcyy/qIVML0XartymhDukKnaaLStE9ylSGU4z8cWOFYrQHEC0qERFMVZsq0AExEBcYyCwh29HXEJlxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from MW4PR17MB5515.namprd17.prod.outlook.com (2603:10b6:303:126::5)
 by SJ0PR17MB4856.namprd17.prod.outlook.com (2603:10b6:a03:37d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 17:29:02 +0000
Received: from MW4PR17MB5515.namprd17.prod.outlook.com
 ([fe80::20e5:e2db:35fc:d24c]) by MW4PR17MB5515.namprd17.prod.outlook.com
 ([fe80::20e5:e2db:35fc:d24c%7]) with mapi id 15.20.7316.023; Thu, 29 Feb 2024
 17:28:59 +0000
Date: Thu, 29 Feb 2024 12:28:51 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Liu Jingqi <jingqi.liu@intel.com>, qemu-devel@nongnu.org,
	ankita@nvidia.com, "Michael S . Tsirkin" <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Ani Sinha <anisinha@redhat.com>, linuxarm@huawei.com,
	Markus Armbruster <armbru@redhat.com>,
	Daniel Black <daniel@linux.ibm.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] hmat acpi: Do not add Memory Proximity Domain
 Attributes Structure targetting non existent memory.
Message-ID: <ZeC7EO/fQKScG8Rb@memverge.com>
References: <20240229162545.7887-1-Jonathan.Cameron@huawei.com>
 <20240229162545.7887-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229162545.7887-2-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::43) To MW4PR17MB5515.namprd17.prod.outlook.com
 (2603:10b6:303:126::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR17MB5515:EE_|SJ0PR17MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: ded30c67-ddb5-4f58-75c0-08dc394bea3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G9NO93oUWSkoBGU0JFVwAImsQoVhxHY+hLjXJc6fng5CzZQJ1L6FPU9fbTeEFSV87LSHo36J3N7fCfKhPBKP1Om8ztfh/Sbt8JHvoXj30VbTqObOisTxLgFxlyxY6b05bPZeAfHGFL8qbiHPHIPd2yGm8ZEzlqdysYyswbbWIAXNMT+1lC0vkKnzxQftKHFYQsEK7RzbedPP9cOmaViUXOvnn4n4A7F1PTusELlnFnCzTREiDygRcnhHmWtK1gsUhNlI2vJPY7mlCfLlfg2asEIOjBfCY79Fw+JYOM5zQXTv9RFCYlxYWwmei8eSU8q12fN2tUvh6mJTKflK7xOVRj1/DZ+04nor2Yv55LSVec5WFnP7Q7nW+iPoYiCiT4tHD0Xf1aHCYwJNO95mXX6qbdw6pgjq1n79ILWgDzZeDEhwBWRZNXYB8s6R6bql76Hyb88aHYnms0ZCsRr+0qsOVr3pVfHqovo5xV9vlMxO/b+NMnhiqv+Bn+RBpVfQ2Riv+B8IcUGzLsXw7uKg7ZWMri9Gfx1y6Zmnp0rD3jJszXnOhAZpsL9iB85SmYEc82KmurniiTInVvkAWfFjdgn6PA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR17MB5515.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9VTylwouK7fYdQSgnbrMB82D3nTYQ3LW7nrvYP3Dj0oQU6hiOTDWFy2T0EXu?=
 =?us-ascii?Q?nrnFVWPIUBYnp23h6es1C9WTSuXGL0WRiScdgEXfrQDAfchwTSbiNYGrOQa5?=
 =?us-ascii?Q?ByOvIew1Ua/hHlCnvdmaoR8fWy2oARuZBaRLPiKoJmrO98PONbQl0V5c/9Zt?=
 =?us-ascii?Q?IiXTb95VXJ92gIbgCGKVrdaMJvMf2c9pnmdZyXitf8e0B7zZ3zp7mfxRO7tW?=
 =?us-ascii?Q?v94H4O1Ge79Bn+TeOV9dsBghJRikBY0N3mnVCupUcXKrAc0jfVqvmp5jN1lD?=
 =?us-ascii?Q?CgQpTgmUB3kTaayI7KUmbg4LVc+IRNfhxrIPMBmDiNke8Bx257XcEfzCYAYI?=
 =?us-ascii?Q?qgfG+yKQWpMk8FXMbqCsZL3g34M/FbogKfVKNGcCuBWyMjXK2Nk30TsgzZ3O?=
 =?us-ascii?Q?Kkz8Z2uYw23ebMx0wHfliDhQKRP61+INu+N0oxKPT+6SxeAtqxjIG1gAmAS2?=
 =?us-ascii?Q?PTBpj7xwTPu0RwIdl8Ob+DJ8DPPpzp1//vFCVFoi3X7kH6k0lTXgELDYo6G+?=
 =?us-ascii?Q?raKuYcuQO4FbIE1AH97ApK2KK8628DpiTyNzFWbD0qDox9HWYwqIKnTpK9ck?=
 =?us-ascii?Q?bpqbPRmbpIqFVKHCiPCTHJfPdkCbkSNTAxQ4hqP0TzWEXvGYsZ55oa59as9P?=
 =?us-ascii?Q?2VCCnuBcBLXUD2fqSiLyNPb7NbeQrY84bTMz/Fey0DEgUxhYedRVJyjkT+q7?=
 =?us-ascii?Q?PB66jnBr2Tjis7uOZ6LTXnCzLh0hA6eduV4wKmjfaN2SzoHVFqZ1nnQVYrgM?=
 =?us-ascii?Q?D8zD4U/FyxeJUctN+P5P3RRm88nUSMG844qjnxqqgwySwqpDsLCGcoeNAGIl?=
 =?us-ascii?Q?v0ZZMtNbKxE63nMDlNRGSUrs9tCp1luL7ir2oCJNIkMTWL9ADdjRRBiz0V3y?=
 =?us-ascii?Q?Hh/OLjyDar7PATH7ZBycLJMHbcxj06o6W+d/8dGkBiw2tdm9dVxTjbdajxFL?=
 =?us-ascii?Q?iVNvwiNPt9bK6JdzAl9oJ9snQFmmQ7fWBxsuMRDCnyu5DNTasyBvY/Bzl797?=
 =?us-ascii?Q?iHsT8uafLHhKWG+KUi3H3w3Rzbl41KRWZWTaLX9p8/H5x1VVMbGv2mAPkxff?=
 =?us-ascii?Q?qbEpSPh9cn3TsYEqckbuEOOXywO3HyakGbnsuxWl9FjfoDmwxUS1ZdUWOqrG?=
 =?us-ascii?Q?GldUFX0H44kOW3lHWhOgkz4ph0xZNYol/eqZhSa7sVH3QzNWuzMc8jFjtIhY?=
 =?us-ascii?Q?qV2pb9brMHLIVLGszlvb1w+WesDQHvwSE5Ehux2oRGUT+I6IJrzsYEh8VuEf?=
 =?us-ascii?Q?ImxX4yIh8ZbvmTZbs1paESrbCACLq78JHusIDb2mFtvl70SXyYXupkSu3iTq?=
 =?us-ascii?Q?ytu7OA7S9n+P9d6tICzuVpOoQ1FLotMGEoy4Gxlg8VrNN37ZRBvnrAknBpMB?=
 =?us-ascii?Q?tqwj7yElKFOnOcyrfgmAzUpTksMcgDREYUM2aYTrSwgvI+gInJvOzTG9735+?=
 =?us-ascii?Q?9GuuqEbsBu4NFDAy1iQ2/eBLttWQGCEX8WxH+jJvQ1QL2zmkyF1z1cgeqonX?=
 =?us-ascii?Q?2C1EeOhL9wFEMKQQMqpe0FoDPPZGeoPQXLI/0oUafBA7hrUkwGVr91KIKFGh?=
 =?us-ascii?Q?fg7g/4i5etthGBxiuxHMZDEDt2VAcWUYPtg7EtuZvpgqUzWQ2hSvpKWQZ5bk?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded30c67-ddb5-4f58-75c0-08dc394bea3f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR17MB5515.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 17:28:59.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqWSasfOM+GY7nijyZQgfvl8N8Tl+tQbpaJMDhnSo8cgdbpnUCgu2YADOHzxUVVU/klydaF8YjGYrPRqNXF7woMuJrBzXgVNvGZPqdIWAco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4856

On Thu, Feb 29, 2024 at 04:25:44PM +0000, Jonathan Cameron wrote:
> If qemu is started with a proximity node containing CPUs alone,
> it will provide one of these structures to say memory in this
> node is directly connected to itself.
> 
> This description is arguably pointless even if there is memory
> in the node.  If there is no memory present, and hence no SRAT
> entry it breaks Linux HMAT passing and the table is rejected.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/acpi/numa/hmat.c#L444
> 

Nit: This link becomes out of date pretty much immediately, consider
using a versioned link.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/hmat.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> index 3042d223c8..723ae28d32 100644
> --- a/hw/acpi/hmat.c
> +++ b/hw/acpi/hmat.c
> @@ -204,6 +204,13 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
>      build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>  
>      for (i = 0; i < numa_state->num_nodes; i++) {
> +        /*
> +         * Linux rejects whole HMAT table if a node with no memory
> +         * has one of these structures listing it as a target.
> +         */
> +        if (!numa_state->nodes[i].node_mem) {
> +            continue;
> +        }
>          flags = 0;
>  
>          if (numa_state->nodes[i].initiator < MAX_NODES) {
> -- 
> 2.39.2
> 
> 
