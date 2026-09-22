Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B12489FDB
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055475; cv=fail; b=ZiJPsOSVJB4Lr7ovF1yGzwl6ZckBTkKcvZtg9PUvMbvh9y14DCCZLmQxWG+HfvK20ZgVLHkph5S45HcL644l0FGuXnhd1PZq+6zrZ6gXziVVuN4FeEEdCaInsi83LkeRYxD7TZAbuwAGImleSwjD8/0xNMZHzY02i+JyG9i+VrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055475; c=relaxed/simple;
	bh=NBQ4WNs/Ilc87BnBettQhLlCfWCpKz8q38pUchS7oAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BZPWAgjZfOORh5PlnLhIayX1CU5awyC+P9TBF5k3H2LCEWPDw6R+RiQ89j6nrpFmPFtRayG4V6bd4nF/D5YS/ZNVGiR4f0jAfVtojSoMWjX+6/Hqg5tXQwBLTK+yagZbIXt00XJQe+XfpOqFRX87BbhIokaQorRgw+theF1OQ7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sY0bTZZP; arc=fail smtp.client-ip=52.101.61.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sY0bTZZP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7OwiAE/+8msd3WsIuZtRs9aRTg13ENtoPbDlc61rmmuH7OSNhwsZSn8HZlmglQUl0cHebt26AfxxCASzxxKDJate5PagIznmK3YxtKNw24RCvroiJQFP1VSKNcQKHplb8FxQKm1AvUc9efjDOmKQ8svVgaX8DLN3lzYuH1gtgcwVGEymx3mnaUygnJ+PRYEjBL6IrYzxEnBLaMbbD6RDwVewo0xmTX9NkEUjuZPSPjMNEHy1XkLpuredqANpxo5T7X+gCMFMvNiAseJG/BjYNrm5wi0RQGKR5wfRzsGZagdIfO451OPU9csIt9OPS1GMwHgaPosrvMFvt+pN01Niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H86u8HkEmtF5maFrRfzVcHwE0+a8zihtXfg55fpFWZI=;
 b=bviQHsYqRTbtEHfOOve5C/KbXNzurH6Vo5fB4mQL2r5yIZGzDi/iascq3sUaSb81jjaI/MYr57iQ6G9qLmXkNJniI20yoEVPqVAFuo6xVVfOrP08Fb79JMn4IUQocSLvPVjVVser1GnTpchGkNB13+VWMpgm9qckXTnOs50a5zjDss4croZJHt1yP/T/U27IJ4CezIWDfduZ9tp4swl4YGDISX94RNQqac/FqX+WrfmHU+X3EroJoWJXPgAXfg6bnEpHl4+1KUnGmMYUP/SOVtcnXMNWgO01zq/Q17Jr2NTn+VsuV2o1aSku93TlcjORknz9SkqSarNYAnKY4vDqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H86u8HkEmtF5maFrRfzVcHwE0+a8zihtXfg55fpFWZI=;
 b=sY0bTZZP/wn9tM5YAg5PQx1FOX1EGhaTYIIA0ODg2g/pYUTeGpzI9Um1rUtDAnoadbD0Rg4ktTFxkObjr6V8KYTW9Ey2aRnYwhzo2G580ebSGy0PgK+WjkJK2yS56cYDV0/lOvZRtUtzJJl04lJCgtizw6ZziuvVa+E6jbMZMZXSHdiyFDjBF3sGWIWuY1u+stnOtqcVrukt0mmpbzsm3HeKEZn541UNcCHLZaalmQp3Y3WFfU64oD2aKVF9RXleE9EzngsNKERNgJCmtWDHzYJl6MCnI+/H+TU+pyYs4ul9Ujzq+/T4trghvzqOhx030hb/4+KgR1LMvGFnoGFe1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 05:37:25 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 05:37:25 +0000
Date: Tue, 22 Sep 2026 13:37:18 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>, 
	Gregory Price <gourry@gourry.net>, Ben Cheatham <benjamin.cheatham@amd.com>, 
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Anisa Su <anisa.su@samsung.com>, 
	Wonjae Lee <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, 
	Heesoo Kim <habil.kim@samsung.com>, Jonathan Cameron <jic23@kernel.org>, 
	Fan Ni <nifan.cxl@gmail.com>
Subject: Re: [PATCH v14 5/8] cxl/pci: Factor out interrupt policy check
Message-ID: <arIT-Jr7F93gtzoB@MWDK4CY14F>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-6-anisa.su@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918203049.7273-6-anisa.su@samsung.com>
X-ClientProxiedBy: KU2P306CA0081.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3a::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: c44ec1f0-6524-4190-2780-08df186b9498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+ShR+FXn5aHYsX/W4RE+X+4i/JWH1hBlF8zZ4B8hKq1ZyIVCZ6N34LsOGtQsCe7hvYw5SZb9oix6g6EGTA2R56e2qqSxF/INn5+9kw/allfSb7TRqXonrSKmintISHe29H/vuN5fYA/a7ExOghDndzQofElnaagV28i6fGhNXeRI8jiNyIWyMnlISf8qtj2qQNGp1yzYRKhUrSejvDKB6zrRjU6jWkHUkeAkcsbSk3a5gSltNbAyPN7ZiEthgDGGgrSFoFEF6yOok6U9rApJfmRP98gG1i9RuPlQANW+56/N03Xr6xtaLyul8O7ndq+ptSK8nZ0lXDlxxOK9/JiMmDmb9XhLn5gZRBtMKaVtGVerenX3f2aZZ4Ff/QICzNao3nYfeCTubrQ3Ow7fts1xWlF9THH1ZOgYBYm35ijnXqktOiqLV03qkqaeaMVSwto00xEC3457ljugaU5WDQDxXBPZ3AuH2b+odAxoMCV/pCPVuoQoOJIPrCWoagOTkmsEwTTqlxaQz3FHvluChPFXwp5tPYJd0duFPIJYQI6Dqv8uD1R6F0NCgUgUIaCwHDWutNcoic02dA5tw+Yg3ELzI7lv0WQzwwh1WPtrDhImYZOHetImX/M7qex7sUyYb1DyxArfZQ7Y7L6Pj+eB0dLJhyyIeBh2nNLfDF4+uK4O7LY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Z1bLmHvkO4hrUF8OKfE575G1cBGsTrpFw4iXZ/Irtm0Sm5h3RzxJO+LsWe2?=
 =?us-ascii?Q?7M5Deu72LbCXjAwAF2KqwLsC2Pkm3a2bRn8lCaCfQ83sRmTjXtv+SubhTbGj?=
 =?us-ascii?Q?wRIJcoXSBuiYydOPdhqO4udq9PjHWSxvaG3BgbLgYongm3j3Uxfi6frG8R8G?=
 =?us-ascii?Q?n7AczgqGo4nyWuy8Kl/VbvtTuO5M9ud/isEMuJQNHkCGu1nRdWB/IsUXfqUm?=
 =?us-ascii?Q?poV7Dtk+dPmoA15iONU52UZSRpsoiBkxafMak5JV5TFZuPNnYMahmw0eeBWi?=
 =?us-ascii?Q?9vZ62csEzOvBJAK1yKFDkOOwOAExu13UTQVLLVmFSJh+4MpeSqq5j9blG+gj?=
 =?us-ascii?Q?dcS8l0OWEH5PgsgbxDQy/3G7zD8+R3+5uj0kIBM35lcGMzrGyCg2EqzISrNW?=
 =?us-ascii?Q?hqK3UBFMdHCY6A5/QIRRyfUxX6ZjfMpN4ctm6CiS3UPQUevRNgk9q0mOQJwZ?=
 =?us-ascii?Q?gmtwLYqKhWNKeUnFT4SVSGUkM0swNMKg5CNJ6QSnqC1sNs3cXZZskf2t3G7p?=
 =?us-ascii?Q?XmIfdHKUuT95cFCLGYZ4RsybE26485bR/IbDC/NgYcJWHJMizEusYHmw8r5T?=
 =?us-ascii?Q?8lup0Tl/tGUWU/usFT5liTXiDkJmBRnaY/YoaoeeJYSlI/pyLH8rfj7fdVtR?=
 =?us-ascii?Q?5o7NLFVz7MLm5PJkvhCEZYTxOGXePr26OjTkSOO9JDnepyjjLWXYDo6rLnui?=
 =?us-ascii?Q?ZHbfmnWQihLW/K120UP3vJE3Egbnuz/87z+jguPx9PhPIgK3XJ58UZ7+Gq2r?=
 =?us-ascii?Q?Wo0VF59WUkcvOor+srnguGeLxVvFohXFHNkULmhxvsnHi3XEUCbdAcsAuvP+?=
 =?us-ascii?Q?3YUOYJL89x1RuPtt0F6qgYVjFtXWPiRL8XdpEjKR3zQETJVVsOP2zrY9R0Jk?=
 =?us-ascii?Q?dY7XJUQKiwNblWWcKX1BPU5N2H1zWQYyMyO9ikqnVtVKnrh7OFrOa8c0n4AU?=
 =?us-ascii?Q?x3vj9sOH353xPw7jptWJJ9mGEWW20rzOYlQp5xhaQX7+pDkwBjv68H6SJqHG?=
 =?us-ascii?Q?k0UWYCAn+oSqvWtD3bVn/ybjBuDecyooVtpnJh32GV+E3FIzDV0hl/VRjdwG?=
 =?us-ascii?Q?kZ0VNmm6PsuyGhRhbrtos4DmjLOkKBDWLIwcUfa87PnMfODOZ8vG7q/ydltr?=
 =?us-ascii?Q?sQ4uul3E1Z3H5zkdYS0vBIbPjP38jCcByGSg+FdKkyYKgrFBkOTLOlM9CnzA?=
 =?us-ascii?Q?vFsMHElF00xr+DyCvRv8BeZios495lYxkEF2rUIpGh/KRky+2OLoiYS8Z8yT?=
 =?us-ascii?Q?JIkR4EEGu4Ir4bBxkyDxb5VXN6LNNgpytEvdKYthqjDN6S7PFFxyD3w97czo?=
 =?us-ascii?Q?XuCP3wBhgZridmQAUNEbAklKqdjbqTOOkVZiPH3FFezvJ4c33VcG6FWhtrAJ?=
 =?us-ascii?Q?G1hvpbuHPjP894rzp5DqPi/iUyeKw1BHaLtjdW285vj8+1vqk+fqFTk0jqpx?=
 =?us-ascii?Q?JmYTGTTcqWKnwPPbahlB5zZUyoS4vHR7YTUUiIBeYuvY1eCjzGOa65gGF6QB?=
 =?us-ascii?Q?QCh4a9fjv/9RCAaraKvrV/RrT8nP4j/Iw0UaMOTq5CN7LnO6QjtUqhAIazhQ?=
 =?us-ascii?Q?l+DoG0wlOA5t/pQcfrhFgyz/bB5M4Fau/KfGCy5FsoIEO1OO9FDqe0/Ad/ZE?=
 =?us-ascii?Q?wGjbwjf5/5qdBOmmfjwUq+z7R21fh9THxyIy8vTq21dWQOzSidHcZy5GnM3B?=
 =?us-ascii?Q?vI7M+mucfcxgKjSg+75yM66QoYTLWO13cMNYcT38jxRSkyVBdt0mMsZofn/g?=
 =?us-ascii?Q?JC0HnyNaDw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44ec1f0-6524-4190-2780-08df186b9498
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 05:37:24.9621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbGY6c5wZmJOpmedWKkRkv4iQD4sZEHgcWnP3em13kaTPsLJD63M5jBCHIx/qBSPwx2h4Maq77hLYd+oSiQsow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927

On Fri, Sep 18, 2026 at 01:30:14PM +0800, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Dynamic Capacity Devices (DCD) require event interrupts to process
> memory addition or removal.  BIOS may have control over non-DCD event
> processing.  DCD interrupt configuration needs to be separate from
> memory event interrupt configuration.
> 
> Factor out check for firmware ownership of memory event logs.
> 
> Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
> Suggested-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> ---
>  drivers/cxl/pci.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4867657f5526..7b754af2168d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -640,6 +640,14 @@ static bool cxl_event_int_is_fw(u8 setting)
>  	return mode == CXL_INT_FW;
>  }
>  
> +static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy)
> +{
> +	return cxl_event_int_is_fw(policy->info_settings) ||
> +	       cxl_event_int_is_fw(policy->warn_settings) ||
> +	       cxl_event_int_is_fw(policy->failure_settings) ||
> +	       cxl_event_int_is_fw(policy->fatal_settings);
> +}
> +
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
> @@ -662,10 +670,7 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (rc)
>  		return rc;
>  
> -	if (cxl_event_int_is_fw(policy.info_settings) ||
> -	    cxl_event_int_is_fw(policy.warn_settings) ||
> -	    cxl_event_int_is_fw(policy.failure_settings) ||
> -	    cxl_event_int_is_fw(policy.fatal_settings)) {
> +	if (cxl_event_fw_owns_mem_logs(&policy)) {
>  		dev_err(mds->cxlds.dev,
>  			"FW still in control of Event Logs despite _OSC settings\n");
>  		return -EBUSY;
> -- 
> 2.43.0
> 
