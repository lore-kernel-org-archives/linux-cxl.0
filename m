Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9031230264
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967709; cv=fail; b=c0hXk8iNi2QUknlBJwL+bsa4ZBjx+wJzW/Z3+PMB97C6DZeP9Uj8gGg+S10tgrdpdSQvr2MKISNeYPapml+P/nTIzbfgz4JMSiATGMZNZIei+fZZgM7qObutr0WMQu6VTVEXjQfeZAyp0GqOzVX/TMalo+jT+WQZXeYqWxd7PCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967709; c=relaxed/simple;
	bh=b6KJWsxZo4DprHa2/8zuS+CiWEdwetqA4zHCy6rR3BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MHTZh3RmyTJIWoyQYAbg79di14/SjjrxMc4vdNwfshnivvOepvc8P5nQRhznvbuU5RAhcyK4WH8lErX7FbsfIitYwXIzW8XOqkIPi3x9lP0KDz69CIwr7loY9MXt1C3Nd1GnadXo7TTM9jg9kO+Ejn3vOeMzKnyU6fY2e/fQwtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RItNShUh; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RItNShUh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HisQMzoKfoCfsF8TQZQPbLeu3dNTm7o5Jl7RQHgcByDgrs1CWB9QgweS+hauc5F+TDd1VOl0juQYsolqe3tLiuuuhYAtBSLE2etn4Qhjq28zHkwjn9Jp/Jwvn6XKxpJ8iCLa+3MvypSmN2yODzAx7rW7nqRjYM8PnmFfnZHYlailrjKKKC+MEM2cLQqbCPuVwR3fpvOFWfyd4/4ETHScyThpxfhwjvelfqgJ7aG3EcsDf2Nw0SrEvi+PIkBn/qgnz3NUExxmIk1NFbnULN9KAqvg/L43nfRGav0CalRq31d7hhI5Dssfwxmnx/aIcuFb3Oggx0DhTiMrv479v9qfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p37M92bKJ1Eyd1THPcSIBQdkLyCiIAOVm7PnpvCUkmc=;
 b=xB0l04ooq44cDYJBmpTsPq0WinWnwhosejdFoUnwe7GPBaJVOuSV1/m2EzqSo7PBn8DgLAU6tiCQfBDEUlmHiYGCs14pa7pNkPpTgFLsQtLCLUcQFiIZl361hE0nE+qz3VPP6qeL8p1e8MJp1TEjCFmNvfVzfBFv4V7LV+OivvIQBZSUnM8j0Jte+SyNhALztOZB50A3SIYpH6j/070Nb+4OSDbxCnSc/rN+3xpFOcAjoe6oPF3LAStAhPwWwjWkAmvXgagPgxXTQv5Q1k8ALWk9PE/Y/Gbim91J94Q45eKYxngajVWIOwH/nkgaSVvB63qNyDJYBsODIIcCl652BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p37M92bKJ1Eyd1THPcSIBQdkLyCiIAOVm7PnpvCUkmc=;
 b=RItNShUh9wzN61pei0NMpqvA/LqtdsdFQihzpMDXzov+DTs5vwwcc/sAd9mRiQCWqkXHboZpDZ4fr+TwQWZ5ujI056JmaCrzXGCUhwtHedoKGWXm/ioOFB/3uxICvrzSw5of5agW3VE/XL10XQutVvkWL4gjPZYTHxhzw6ZqNHnhBN5JyFKkJ+QGwLGDQngiiz/Z9lx7Ai83kGm2VlXqrmdHe6yYlHqh0OuXS9SNBz8xcl3t04o3Zmbn7ADu+VySEKK8fWLsAs+UamoNuvp/FD+klTuPlg7Dd5SlmWRtUxMvwJkwJV1u5y95o/tswSOLvt0vnAxkHLYixT7pU54LaQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 08:48:20 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0496.020; Wed, 14 Oct 2026
 08:48:20 +0000
Date: Wed, 14 Oct 2026 16:48:14 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/7] cxl/region: Rename cxl_port_setup_targets() to
 cxl_switch_port_setup_targets()
Message-ID: <as9BtjfZqcvQORrA@MWDK4CY14F>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <3342ed1a893f001bb96efb3aecaccbe311697e87.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3342ed1a893f001bb96efb3aecaccbe311697e87.1791860305.git.alison.schofield@intel.com>
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c13f88d-1ce8-4662-40c4-08df29cfe5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|261009223027099003|4143699003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	f/cH6yoC07Jx4DlFtYdEU3MHuIM6a6w4WVm0V/oxPxJamE3lAfyzSC2iL62fQhKhkLwmI0qcRzrURpXMB6Otac4LO/F3V4N/tomoiEyTCF+yYBpke9ylgIOQKWo61bZQ4ShWZ/cc931hj6WuUo959tHjV6D4YaZRQSOgj2GJt5ADKpW3EX13QHdCv3eyTSx4wpOPuCS7+D3vcravDNk8lY6BCuL8aL57mQ24Tg6FUwzmlryyhIA1TFFrA+sDVf/3bxfox08VuLTcmWs++kP7t0lyFMJD50xJcKsXzecsstt9FNHXOmQxhiqLynzZfgUY53TJxVdMGUQ2lEHEZRsXSA3oYdmzCGKUoMvTqiS+ul/ACPWDPSratRiQPEG98hloa47KjVv0Udu+X0SF9a0T3l0zRbfpFl5bIdwbDHBFHnnPfyEPzeYKLZn1FweX6jVzyinRBcB9H5/Hp42f8VKulrHNLUj1k8URK2YJrqCNmm9/tQ9OsEYhIXireaHWeCIOeuz8rG+p2fr3Sfn/uGiCt7v38iyx3Yq2MsAqzEDurm2tU+m3hhZFOnEDMB+jlpwztEQFFpmb99jb5Uv/pBkEwSudsF11Sl6gS7Nz6j/EzG0PtmXKXot8pvDObwb2cx150ex/qmvM3QOH7pvgdX6uAb8bafWMR//0U5a7n4gruAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(261009223027099003)(4143699003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aYpXrMM4da0IY6JXSqFiMwVAhftDEDHwP4DqZNCuc+ebCrTlsFxl4OVNZ1eX?=
 =?us-ascii?Q?ADfNf++m0FNNtr4V42fp44ls0C6DIB6vOtDbBBAm4BVowVzPOlgijm+V07nt?=
 =?us-ascii?Q?sUnanZOxuA4mPZH839BaWxTyM0efszIwinbwqQ9MBWk0hVR368lKmaF7f4Wx?=
 =?us-ascii?Q?rwsihXLjLjWKVXvWVV3Gc95KDGBVLuqSPm9rf/s6Uboqw66nsBjLuncNCx4Q?=
 =?us-ascii?Q?aK41SkhWFoL9cbwB6sgu2oNYH7Y5gMtBqknv3W0VmB9w6JnBVh62N9mC3iyG?=
 =?us-ascii?Q?Te7WGvmu/sdXqMbgahC8BBJmkpvppkFGR07UeyP8+2Wz5RvAq5zQ7Rpo1Uxw?=
 =?us-ascii?Q?woPl97IU5Uqc+nSDjaTiRy0+oaS9mE3Q4abVE/jhZTiDF1GaYhL0evN6sqMj?=
 =?us-ascii?Q?T42BwKAoSRUvxPNkrV+f9O0SRYvNye6A6P9YW3nPyEwyx56O7Y3s5KWOWTb7?=
 =?us-ascii?Q?6iyEQZEd8QFtD3hVF8wv3IAVIO0Ao0OLjV7T9kZ1xrxjKjObgztSoKFIrWqI?=
 =?us-ascii?Q?F9gV78c5Yz/Rb3CGsA+7FBQ9hBsfZp7Qds8iR85X2EGKAFCKw6/1iYxVaUUc?=
 =?us-ascii?Q?KtXKTXgzBHKgqkQdr1A4j5djBZizakuZ5TEtkuEJCwSjP4uIxd2dZOwxtra9?=
 =?us-ascii?Q?U6nQ3DDqgKosZ3EIDJ4Br7XYs0v96kdLdzM4alysy3V0adStsBLPXu0sXRE+?=
 =?us-ascii?Q?ut9D1k5vJZwK7Q+H51dqVtBhO8UALXKW5rfY55fazd/nZRklxgvJs8ujT494?=
 =?us-ascii?Q?WbUIOMc+h8mM+hJyk9RXpL1v7Saurwqnrb1BcCjWchB3DUPFRxFPDXrkbKcG?=
 =?us-ascii?Q?0/Ey+qs0JiOJeTyI28n2jEK525ld0Bu3qukiS753x7Cm8o7vDlInstBhbgxx?=
 =?us-ascii?Q?IZFy29LJjluXPN1W7ibpkDrZ3a2fhwwQmTMle/9MfKpYNws48TeDdIElZaY8?=
 =?us-ascii?Q?LAThI1zLGrUru1AdxX9NPhsuPmGjD8NMyNf/7XAwi0zYos/e4sMGkoVtiC2S?=
 =?us-ascii?Q?r5xU8vtxBVYAF8U2MvOyEU3NmPJxrlEoxMM3cOYLa2v0rczN1KgTTEGuTCR6?=
 =?us-ascii?Q?Ub1w7Sv/8j1mCW2sKwymWpaPGW4dzTYIAjQcE7qOfDaacW45Pcx6peBJ7INw?=
 =?us-ascii?Q?YCxvAVkbpPTGOKsSLt89hOzTs/N5ftF9jczJ1fvGwJ5vwCvcEhGIvfUiJpGj?=
 =?us-ascii?Q?5vxH8xMij7NiGCcbSifXt0qjgbW5zhvTFaYHtVlouTCR4O9BbM+gN0d9dcYS?=
 =?us-ascii?Q?eT5m+yIXmxQcCw3JpRKc2qZ+D40D/24iX722W7rIA84Vn+vrjKDIg+mmiCC8?=
 =?us-ascii?Q?OTDG5Xi6UMbFc+/iDlE//ru2LZwsAR6Vo9aOvVIGkvrk97tYZoi3QCNab5+g?=
 =?us-ascii?Q?EPUTU8X56+hamCbE2Padf6LV9MhZR98WwjxQ8Z+wAzxsMnK368ocKAoxwrXC?=
 =?us-ascii?Q?MxawM+loNHd7dTnm7elrptLx0CCV2wNy+JHJiwUi/NUS7XiQXMP4X8bmyoA0?=
 =?us-ascii?Q?Hp+DiOvo5L06+aXJx5sLZs4RzoPOhqRl4uxMUoXxVbMXoPyLvgsztUG7+2Gj?=
 =?us-ascii?Q?S7Rt3B+pc1go8PGU75g7nmO2V6sJEOQl9HXYFOLfxCN60YbkKJ3qcmbimfMg?=
 =?us-ascii?Q?24PTcs6yQ5HqWS5gvc+XiDLNU8bDfq0nP7Oy1VLsLBqr+p4m2WxmicYCcvpp?=
 =?us-ascii?Q?liOOu7giD65Px4OheBjfO62R2XiPYRZ5h571GFL6l1qMvVbq/GqrBKQAEzk6?=
 =?us-ascii?Q?ar4ZPSJmXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c13f88d-1ce8-4662-40c4-08df29cfe5c5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:48:20.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nDQihev3WiYKh8HzUykLeSqQf8F7Uk44UcdNr3AV1xEH2SjrOj0mxh0KYv/I+kP7WPJ/W9quLOqdHb5wJEQ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860

On Mon, Oct 12, 2026 at 09:25:58PM +0800, Alison Schofield wrote:
> cxl_port_setup_targets() configures the switch decoder targets for a
> region. It runs for each switch port, including host bridges, between the
> root and an endpoint.
> 
> Rename the function to cxl_switch_port_setup_targets() to make its scope
> explicit.
> 
> No functional change.
> 
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> ---
>  drivers/cxl/core/region.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index bc087ca63946..9b0e2f195d1f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1432,9 +1432,9 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  
> -static int cxl_port_setup_targets(struct cxl_port *port,
> -				  struct cxl_region *cxlr,
> -				  struct cxl_endpoint_decoder *cxled)
> +static int cxl_switch_port_setup_targets(struct cxl_port *port,
> +					 struct cxl_region *cxlr,
> +					 struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> @@ -1716,7 +1716,7 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
>  		 */
>  		for (ep = cxl_ep_load(iter, cxlmd); iter;
>  		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
> -			rc = cxl_port_setup_targets(iter, cxlr, cxled);
> +			rc = cxl_switch_port_setup_targets(iter, cxlr, cxled);
>  			if (rc) {
>  				cxl_region_teardown_targets(cxlr);
>  				return rc;
> -- 
> 2.37.3
> 
