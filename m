Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3CF4A0924
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790056154; cv=fail; b=WaHWecx3eys0N4hEMdKB8doR6mD92wSbu0sgjKA2bCqCPZKLAC/ZKmo2eRjgVBfVcEGh4p1nNxkfLs3B8+qZzEmPt7SVoNGX1cHdScNTDm33DCw9Y0VndY6RXSX01nmGfPfEEjQtchNAgUMdW5rb/zbPLkmNnPvfJXM2ntiNTtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790056154; c=relaxed/simple;
	bh=r5Cmti5WkDJycOW5uaBTKw0Ly1Vdt7jHZxon0aPUgh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TY3gzLOjrkMvNlcHFpDWNp/xxUUOFEeYyVHMdKrtZ8FNEbRlZ/mZYaXWiQH07Hgz2iV+cpknpAL5PWwohsrF03op9nisWpAPq3Rv8bQhdx1HM7b2QWptYzvISf6j8HLCZXauERbWUrccC9+PDuPdAGps3F8Dmo6FzO1DawEOOTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YCELL762; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YCELL762"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NybiwZsKV9leIQecaqBuSCy6DZ9dgRAka4821dXhii5HBmYwlAPFHXpl90o89G6ChSWWetwr6EBe9E8nLEN30R2HMnz+oDuSWFMIOoellrsJ26Q91JRq3JkPPov59j6R8bIHLLMZWdliitNMM9SnwnCtR2cN0RY0AF1Gt9u+PCjUXyMw2/Fk4zrZwKT0agb4zZEASXf/3xT/LAxGr8QfkYOvgHma3VnyDiqP0piSk2eDc9xDqX+HTVg7xqvSgAjFZqeg/ToM/9Iq1/rAcK5MKqsgLSt0y8ZzT3Tv5M+K0MrRolu2i0xvpqA2oT0oB4YoqQXL+B4VIk8zqRhxXuspzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDdmPEukX/bR67erVkKxtfBRnSL12dJ/+/TPQbSia4o=;
 b=vVBXss4Q6+xBAhwMeufVP7KmJUSw/UCwbpXluLpc/WM3pZE7FMx/CZXLLrT5wRsXA+bnfKgleoOgqazaoxxStNGH/CgBVFCkC98CV/uWA3hHaT+w6ESxxc02JL83zcBonLT9Su+VXGsbi9RXadwiloPR93zbq62E9sd5kk6B4ELcKofH1uNsBKQB8UBsKrtfDqU8RUQbam1c7MPc6x0UweYbbN+jrOpWyVw7UZ3id4sSJNnko5mN2+jMgHLHdlnGX7v8CMVRidzkmjs3r8Ax9iuim+MowGLvN04wD43mD0V5XOrQTK5vTTW+0KgzeQl4KPT5fgAVEorrD5P2RSqJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDdmPEukX/bR67erVkKxtfBRnSL12dJ/+/TPQbSia4o=;
 b=YCELL762dxoTNcl8XPlZiYMyRzc2sivmOdgNsM4g+aQxw6oej+xEM/KORB65My5Y2tjlejqz9K3Qri44V5VvIASQmhXhuCAc9UYzfU1HKONwcOAYUUp5JX/ipAnTYAzCBJ5HUeNjScCTpMknbe0p3FZeBX+PmMWnXBRjJYQv+euyaNOm+lX/1sOV5aNj7O0W/iHhA2nqMZtaapNRP2fVg2MwlxPlgGMa978PA+sBrLCmCcO2HtHjJxHSfbN10BLfAZDTH1rzWvGsLqPwE/qvwgP7yFrKOEm81JWdm+XxTl7Ka4oIp2ZO7XO+FNYXuR2hiERuA07IJzgHh2dx1P0i4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 05:48:44 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 05:48:44 +0000
Date: Tue, 22 Sep 2026 13:48:38 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>, 
	Gregory Price <gourry@gourry.net>, Ben Cheatham <benjamin.cheatham@amd.com>, 
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, 
	Wonjae Lee <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, 
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v14 6/8] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <arIWUWkmkwgLzQqh@MWDK4CY14F>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-7-anisa.su@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918203049.7273-7-anisa.su@samsung.com>
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8787a4-c0f5-4a3d-40c5-08df186d29ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|3023799007|56012099006|10067099003|4143699003|11063799006|5023799004|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BbiiO1uC9z66yqjwh0mBZ4GrDFjoqXRi6hoLxazPHsj1f05oVZQYYbfF2uuzXaZJFEL+uPBlXaL8r1fejXU4mR/NQmGNlpvvscH4OM2ep2Wutm60UOtbWhq4TO1FNpNdKjGvZDXuSxH/QRhmx7I/oGXkMxjRD/Nn+oPkUpm4lPMKk6QPUjcrOPByAxTQ7g53+nmIvifiiXj9xtHUMPXJWTeurOpEygkPvSpphmrCAtemRXyeZbuDTjX+JJbVEL4NnEb5ThusDIRRB6DN9Nu/y3ibXEZn2b+o/qS9/TdVBcSuTPgiNDi73vniL+r+bZjuozeAge47ANUcxBbqsuMjpEjfkJe93tSxuKQafmQXskC9W9C24eDFSIKAKICxHQZ2C2iNPeLBe1/1129a9iVuCuwAdtLm4g4nxcJyPlC2oOMJLVwSCLFxCuVnH+COhC4P3zUcB8MhLU59xmL9ZHZSdFknjjPc7/UVwmoG12Q82SbBiXlLdc/lWjwAiggx4mlMMWo4+J/rPQtL8Tsn12coRfegzAlVk2v3xS9VUZvFHGUrU61jDN82OueDCj1W0DbO0HN1AjBGrl+qZPdPKmbcdXY/juBTZ3vpH6+CyWYVFJoQrSky3/RUzaRutLHR0LEwjl6AjX9JNpkzNz6yWKcMn1i6QaF0wvSE9M0EP6CvvVQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IPCm4LkdLJbbo8Zbu9vEW0pRty/EuKzsQt32NqOddzPn6rwttxL8ln47xbPy?=
 =?us-ascii?Q?YRybTINjBCv9rYm/BBIN+nNBu7QUdg+6QE5pwhsIUTEsyDAOxCUjbLqZ8UPE?=
 =?us-ascii?Q?gOkXJAfhYvF5cXeiUmQUPJj95zLsiULrOSrBE9sdzCjI4JMLLUkiky9uN6XX?=
 =?us-ascii?Q?MrCLlUChBoEZtAuU+DhPhMC7z5sG3a5i5iDH8rIl+QCEATsRIzHiJyZh4FcL?=
 =?us-ascii?Q?hWiKcHv5jYn0p6CzlUx8hHh3Gt+UZtl5U/qzz+bMz95FkOEaLjLgtUMCt7pI?=
 =?us-ascii?Q?7oNTROoZxsFaPkAuxVn6JCPhcwT/uf+ApkQGcyUhozcRSARWjTi1jbFos2z7?=
 =?us-ascii?Q?5tT1mGCEpdxaIOrZo5qsVN+K1hT8UBSh/dOxsvoOlplOmCK+pME5dH44UFfp?=
 =?us-ascii?Q?wzbL6jAYSOCjIBMIxRuyEG/f3H9o0w/4MmfWLqAKkjxwuPai27M3sh14TPzZ?=
 =?us-ascii?Q?kswfuNqvRB1Dy++MQL6XG9pC+5Afu4vUlcO0ebkCUP/QXo+wo7iztbXP+l80?=
 =?us-ascii?Q?M/NuF7vHyc1xlAPKJ10bCNIttgBVnPI3ZClRHuvSmEgipDmvwkljCxpu/hsl?=
 =?us-ascii?Q?BH+F9Mc0AddhbJEeY+dYZ1bm5UtS4G6oWkPwS8lmo+DaQ3R852sBnNcveaiH?=
 =?us-ascii?Q?+aCe3il4ubpacZZ/iRKg62nLyn16YpyaoF4aZbJCN/LLgkqKs1XCxaalwWR2?=
 =?us-ascii?Q?wwZ6DbxR/CrFPaavdhI2y8NcMgu0CXsfy+4a5eEVWbrXd47TNOAatAGs6NrO?=
 =?us-ascii?Q?HLQEEwMNZaimjaI7vYUFeADrkduPYeYq64J1OHTD/M3Lzx8hlV436aqZMul6?=
 =?us-ascii?Q?E8QSRBXHA0+tGE6Gx9Jwz+BB8LFXroZo01+EIb2zQylI582cFs3Drd+Ccirr?=
 =?us-ascii?Q?nMJ5SqejzqCHZmvFdCy4VYnjcGM8NBEl24czXfmE4wYKGLg67EsMM1g7Gzw7?=
 =?us-ascii?Q?sJhjmVHP8FooSdLoc2LJ0sl5rSgSY8MYTvLF5PdSb3hYZsiJj0KsXA0dwz+1?=
 =?us-ascii?Q?2b0i+W7WotYNCsYNSzIkDoCU7LxTNF8cBzz4QbA+zfzir+nUtoeBOfVmhG1d?=
 =?us-ascii?Q?mEOASnCIMFESDzGRKCuSMtAkF6B/pBmQXO5k+J8bzqjgHtm7+/sYIbaZdxGN?=
 =?us-ascii?Q?L7QxVyY7SqKyO4oXuFb5XMtOGaJ8XIavyiVVsIaKL5Bli83gmqF02EBRweSb?=
 =?us-ascii?Q?cn/wdaXVgdZzwi6yVU3Dlewc3mvZgjxrAtc+O5ff9tV1uH7gj+8+XTTbe/bR?=
 =?us-ascii?Q?Ws/hyA1re1dTndecdHrz/xPdd0WuXuSXfAOccfavj4RZkmQUx/wUtnhhA6F1?=
 =?us-ascii?Q?pmZN924NCrWcC9viA5EMFJq3isH4GtyDs7GlJ5rLaEJSnpSpZAy9kx4ArZbD?=
 =?us-ascii?Q?iHKGIB8hJ0OAAPYS6gfSpI/P0w8BCOuxIO+c4uMDOqWs7zAMEjbOwnbm9nPV?=
 =?us-ascii?Q?ibKqB9H1k3MWGxBLeeX1SNQw29vn7GHyzGE+15UqbmtOAR6sqV9Wec+Fpyk0?=
 =?us-ascii?Q?pykuj/SpJwkU4zYALv5KzbvTX1CpHhcafpEWFbVf1dSNr3R9MEzRaKfwMwz4?=
 =?us-ascii?Q?ijcgTxFqwXdWR8TVpl/TgO+Y8Qo6fcc1cUmqa9iEj8KAIE9Pq9mr+4j98Wzu?=
 =?us-ascii?Q?uUE45KDXA4fbKj6Zs7EnkNwwAJkKLfoW6KxC2WH+0n8OcehEPHxGbZwoQb9a?=
 =?us-ascii?Q?LaMW1xx2OvcFnFxzYJjx4ZO+mX6UpB/DFDCv4N8LAcxgrJnz1sEc3YBsvpB4?=
 =?us-ascii?Q?aqy2AKh08g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8787a4-c0f5-4a3d-40c5-08df186d29ad
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 05:48:44.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sk0AgBtfOw100c/dpedlu/JtWjIwDfpZnShE0Ady9ZY4e0Zgmtp5MXo5aG1ErBQn+KSMvisvzrCcl5oUNBQIbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318

On Fri, Sep 18, 2026 at 01:30:15PM +0800, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Dynamic Capacity Devices (DCD) support extent change notifications
> through the event log mechanism. The interrupt mailbox commands were
> extended in CXL 3.1 to support these notifications. Firmware can't
> configure DCD events to be FW controlled but can retain control of
> memory events.
> 
> Configure DCD event log interrupts on devices supporting dynamic
> capacity. Disable DCD if interrupts are not supported.
> 
> The DCD event log is not drained here. cxl_event_drain_mask() reports
> only the logs the driver can service, and the DCD bit is added by
> the patch introducing DCD event handling. Until then a DCD interrupt
> wakes the event thread, which finds no log it owns and returns.
> 
> Care is taken to preserve the interrupt policy set by the FW if FW first
> has been selected by the BIOS.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Co-developed-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Just a nit below.

> ---
> Changes:
> 
> 1. [jonathan]: get rid of CXL_EVENT_STATUS_ALL and instead opt into
>    event logs we want to read individually in cxl_event_drain_mask. This
>    makes which logs the driver drains explicit if new logs are added in
>    the future. The cxl_test mock names the same four logs for its
>    probe-time drain.
> 2. pci.c: when BIOS owns the memory event logs and a short interrupt
>    policy has just disabled DCD, return before Set Event Interrupt
>    Policy and the event buffer allocation. Nothing is left to configure,
>    and the Set would only have echoed firmware's own settings back.
> ---
>  drivers/cxl/cxl.h            |   6 +-
>  drivers/cxl/cxlmem.h         |   2 +
>  drivers/cxl/pci.c            | 127 +++++++++++++++++++++++++++++------
>  tools/testing/cxl/test/mem.c |   5 +-
>  4 files changed, 114 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cab8ce39f465..1add114bc178 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -192,11 +192,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
>  #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
>  #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> -
> -#define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
> -				 CXLDEV_EVENT_STATUS_WARN |	\
> -				 CXLDEV_EVENT_STATUS_FAIL |	\
> -				 CXLDEV_EVENT_STATUS_FATAL)
> +#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
>  

Can we retain a named mask of the 4 standard memory-event logs?
Instead of repeating the 4-bit expression over the code base, why not
reuse it ?

Best regards,
Richard Cheng.


>  /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
>  #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9fd5af2e41d4..9106affd7c81 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -240,7 +240,9 @@ struct cxl_event_interrupt_policy {
>  	u8 warn_settings;
>  	u8 failure_settings;
>  	u8 fatal_settings;
> +	u8 dcd_settings;
>  } __packed;
> +#define CXL_EVENT_INT_POLICY_BASE_SIZE 4 /* info, warn, failure, fatal */
>  
>  /**
>   * struct cxl_event_state - Event log driver state
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7b754af2168d..fee3a704b73b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -510,11 +510,23 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  	return true;
>  }
>  
> +/* Event logs the driver drains: standard logs when native_cxl */
> +static u32 cxl_event_drain_mask(struct pci_host_bridge *host_bridge)
> +{
> +	if (host_bridge->native_cxl_error)
> +		return CXLDEV_EVENT_STATUS_INFO | CXLDEV_EVENT_STATUS_WARN |
> +		       CXLDEV_EVENT_STATUS_FAIL | CXLDEV_EVENT_STATUS_FATAL;
> +	return 0;
> +}
> +
>  static irqreturn_t cxl_event_thread(int irq, void *id)
>  {
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct pci_host_bridge *host_bridge =
> +		pci_find_host_bridge(to_pci_dev(cxlds->dev)->bus);
> +	u32 mask = cxl_event_drain_mask(host_bridge);
>  	u32 status;
>  
>  	do {
> @@ -523,8 +535,8 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  		 * ignore the reserved upper 32 bits
>  		 */
>  		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> -		/* Ignore logs unknown to the driver */
> -		status &= CXLDEV_EVENT_STATUS_ALL;
> +		/* Ignore logs unknown to the driver or owned by BIOS */
> +		status &= mask;
>  		if (!status)
>  			break;
>  		cxl_mem_get_event_records(mds, status);
> @@ -551,42 +563,62 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>  }
>  
>  static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
> -				    struct cxl_event_interrupt_policy *policy)
> +				    struct cxl_event_interrupt_policy *policy,
> +				    size_t *policy_size)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd = {
>  		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
>  		.payload_out = policy,
>  		.size_out = sizeof(*policy),
> +		/* CXL 2.0 firmware omits dcd_settings; accept the shorter reply */
> +		.min_out = CXL_EVENT_INT_POLICY_BASE_SIZE,
>  	};
>  	int rc;
>  
>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> -	if (rc < 0)
> +	if (rc < 0) {
>  		dev_err(mds->cxlds.dev,
>  			"Failed to get event interrupt policy : %d", rc);
> +		return rc;
> +	}
>  
> +	if (policy_size)
> +		*policy_size = mbox_cmd.size_out;
>  	return rc;
>  }
>  
>  static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
> -				    struct cxl_event_interrupt_policy *policy)
> +				    struct cxl_event_interrupt_policy *policy,
> +				    bool native_cxl, size_t policy_size)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> -	*policy = (struct cxl_event_interrupt_policy) {
> -		.info_settings = CXL_INT_MSI_MSIX,
> -		.warn_settings = CXL_INT_MSI_MSIX,
> -		.failure_settings = CXL_INT_MSI_MSIX,
> -		.fatal_settings = CXL_INT_MSI_MSIX,
> -	};
> +	/* memory event policy is left if FW has control */
> +	if (native_cxl) {
> +		*policy = (struct cxl_event_interrupt_policy) {
> +			.info_settings = CXL_INT_MSI_MSIX,
> +			.warn_settings = CXL_INT_MSI_MSIX,
> +			.failure_settings = CXL_INT_MSI_MSIX,
> +			.fatal_settings = CXL_INT_MSI_MSIX,
> +			.dcd_settings = 0,
> +		};
> +	}
> +
> +	/*
> +	 * A CXL 3.0+ device can carry dcd_settings field without DCD command
> +	 * support, so size the request by the device's policy_size and only
> +	 * enable the DCD interrupt when DCD commands are supported.
> +	 */
> +	if (cxl_dcd_supported(mds))
> +		policy->dcd_settings = CXL_INT_MSI_MSIX;
>  
>  	mbox_cmd = (struct cxl_mbox_cmd) {
>  		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
>  		.payload_in = policy,
> -		.size_in = sizeof(*policy),
> +		.size_in = policy_size,
>  	};
>  
>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> @@ -597,7 +629,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  	}
>  
>  	/* Retrieve final interrupt settings */
> -	return cxl_event_get_int_policy(mds, policy);
> +	return cxl_event_get_int_policy(mds, policy, NULL);
>  }
>  
>  static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
> @@ -633,6 +665,30 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
>  	return 0;
>  }
>  
> +static int cxl_irqsetup(struct cxl_memdev_state *mds,
> +			struct cxl_event_interrupt_policy *policy,
> +			bool native_cxl)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	int rc;
> +
> +	if (native_cxl) {
> +		rc = cxl_event_irqsetup(mds, policy);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (cxl_dcd_supported(mds)) {
> +		rc = cxl_event_req_irq(cxlds, policy->dcd_settings);
> +		if (rc) {
> +			dev_err(cxlds->dev, "Failed to get interrupt for DCD event log\n");
> +			cxl_disable_dcd(mds);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static bool cxl_event_int_is_fw(u8 setting)
>  {
>  	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
> @@ -651,32 +707,57 @@ static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
> -	struct cxl_event_interrupt_policy policy;
> +	struct cxl_event_interrupt_policy policy = { 0 };
> +	bool native_cxl = host_bridge->native_cxl_error;
> +	size_t policy_size;
> +	u32 mask;
>  	int rc;
>  
>  	/*
>  	 * When BIOS maintains CXL error reporting control, it will process
>  	 * event records.  Only one agent can do so.
> +	 *
> +	 * If BIOS has control of events and DCD is not supported skip event
> +	 * configuration.
>  	 */
> -	if (!host_bridge->native_cxl_error)
> +	if (!native_cxl && !cxl_dcd_supported(mds))
>  		return 0;
>  
>  	if (!irq_avail) {
>  		dev_info(mds->cxlds.dev, "No interrupt support, disable event processing.\n");
> +		if (cxl_dcd_supported(mds)) {
> +			dev_info(mds->cxlds.dev, "DCD requires interrupts, disable DCD\n");
> +			cxl_disable_dcd(mds);
> +		}
>  		return 0;
>  	}
>  
> -	rc = cxl_event_get_int_policy(mds, &policy);
> +	rc = cxl_event_get_int_policy(mds, &policy, &policy_size);
>  	if (rc)
>  		return rc;
>  
> -	if (cxl_event_fw_owns_mem_logs(&policy)) {
> +	/*
> +	 * dcd_settings cannot be sent to a device whose policy is too short
> +	 * to hold it, so the device would never accept the setting
> +	 * cxl_irqsetup() arms the DCD interrupt with.
> +	 */
> +	if (cxl_dcd_supported(mds) && policy_size < sizeof(policy)) {
> +		dev_warn(mds->cxlds.dev,
> +			 "DCD supported but interrupt policy is only %zu bytes\n",
> +			 policy_size);
> +		cxl_disable_dcd(mds);
> +		/* DCD was the only reason to be here */
> +		if (!native_cxl)
> +			return 0;
> +	}
> +
> +	if (native_cxl && cxl_event_fw_owns_mem_logs(&policy)) {
>  		dev_err(mds->cxlds.dev,
>  			"FW still in control of Event Logs despite _OSC settings\n");
>  		return -EBUSY;
>  	}
>  
> -	rc = cxl_event_config_msgnums(mds, &policy);
> +	rc = cxl_event_config_msgnums(mds, &policy, native_cxl, policy_size);
>  	if (rc)
>  		return rc;
>  
> @@ -684,11 +765,17 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_event_irqsetup(mds, &policy);
> +	rc = cxl_irqsetup(mds, &policy, native_cxl);
>  	if (rc)
>  		return rc;
>  
> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> +	mask = cxl_event_drain_mask(host_bridge);
> +	if (mask)
> +		cxl_mem_get_event_records(mds, mask);
> +
> +	dev_dbg(mds->cxlds.dev, "Event config : %s DCD %s\n",
> +		native_cxl ? "OS" : "BIOS",
> +		cxl_dcd_supported(mds) ? "supported" : "not supported");
>  
>  	return 0;
>  }
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 7b756000a1a6..6ef47265da10 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1818,7 +1818,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		dev_dbg(dev, "No CXL FWCTL setup\n");
>  
> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_INFO |
> +				       CXLDEV_EVENT_STATUS_WARN |
> +				       CXLDEV_EVENT_STATUS_FAIL |
> +				       CXLDEV_EVENT_STATUS_FATAL);
>  	cxl_mock_test_feat_init(mdata);
>  
>  	return 0;
> -- 
> 2.43.0
> 
