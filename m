Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACE3B840E
	for <linux-cxl@vger.kernel.org>; Mon, 19 Oct 2026 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395100; cv=fail; b=kTMAHgPmiwrsc+OqbfT3rvrBMSYlhMwj1fEAn9mOXrLhQlS2pXeXm9nsFgFHqotPZySRoGm7c27S5PUCpBbQh9wKyAURm3DQpXH+bzYq6MvdyJdppaRTAAUyVd9MIZGFjb8B9zQMs+yAnyR9T7BHdP4k6yECAdXu4IzZX98xUUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395100; c=relaxed/simple;
	bh=WLLOwR8ZNs1Goiz6+u1gJ0A2icOjrzZNx6gKyioLrUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J1JgQvehxTUMVOM+L9aGA+eFCKDsBrO8EIx++7GyTkc/gHLI1LTuqzgCsPCi2OShnEaOZAeTzNovykZVq1trjuy2D/iYnH/E/JYZpc5vwbg2J20qccrtyLaoHR/0seYQyOe2A37fbRnFBNJrGZL199IWQc7079NaJjj+xITE514=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XZvBtpfC; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XZvBtpfC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5J3uhcbP4nKjvn8TWSxmbajN7fldF2Owd4CsJRX0t5DdC4yLNLo/I7kZ6bjqikzjwf/3PFwj2sYxvt45jNParXYFkUZg+vv5U0HBgZDMBXmRbiQW8tEleityd5je/XOTWCtcfK3bVK+OLRrXRSDqO6b0/LRT/9SGZIZdzAmYgNUzVXHg5xLsAcYIUBNBHr/zPhHZHsiOjFfsy/H27HONS45G7Tat3pGEYGUU5xwp/skMVn/GlgNm2BxlxCb2x00NtvXfSC5dmhYDHuPDAf+RMwOktPS+jRYR56MFPFwct0ZZorw2v0js2tHCmFdCDajsWXYY3RyI49VrPUdpDryAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSZyoGOe+WHKpjBAhJiigPvvETme06/QVHtOTKhduyE=;
 b=BCe3K8r9XgZ4s8qWSFFVzn5W22aJUm30QYo7dGabzVqqeThwyQlsySfIxIRofslr+/3C86ZNE1culfjblPPBQgIH5NVT42RRKKtibberXe+O7hoplLnRj7MEPIIYkPmYyhJkBXHevaP75txTYhv5kroFk7hVQGQ5Xb8qq0Ms78g7Mu7Kw8cEAX6HXGIUZTkqmSvpYvh2NG+ee38IJbP0nXgt1Jzr1TmGrxdJPDnA2pwP16VszCA/FlVshU0R6OkXFFT6GUTJP7qiGHgb5wCbSlhXuw2U5KH8WpIoeEVFUmvp++1a4GG+iDrc0yCwIX5Ga7he1MTOfIkZRK203yfyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSZyoGOe+WHKpjBAhJiigPvvETme06/QVHtOTKhduyE=;
 b=XZvBtpfCzVu49XawJ4tiLGIR4KyUhGSvat6HR/CgJwSEG1NlRuPoaq/BRhLaq1iCpGbIcmE1ZJLPKgZz4+dhcNWlD0+KvHHIbHnd8LsepP7zszVwELqECVaRHvILelmGM1wtBMxWLPU8uB85kjOLQCJxWb9LHjHdhy0A6ZBP2dJE44qq9xiJOyTdR/rKOBKS7aaQNIBnR87vi9oHQabWNnJjtpw9PudHgtSaqUW7wpJNg9vYnrHEUv9K04kLdpVkHM7DqMhBJPEuk+eDFCgUZd9UW9Czw3LHAILYaTfEH5aZHLiQUXrrd/vuWuHI96LGf7yj+Kcvsmrxm7OODtFyHw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bda) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 07:31:36 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 07:31:36 +0000
Date: Mon, 19 Oct 2026 15:31:29 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 4/9] cxl/region: Calculate peer distance only for
 reused targets
Message-ID: <atXHAZIgcNlLURSx@MWDK4CY14F>
References: <cover.1792263750.git.alison.schofield@intel.com>
 <6ac7f8fae75f7cd29b5d530a552aec2b6c6169b5.1792263750.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac7f8fae75f7cd29b5d530a552aec2b6c6169b5.1792263750.git.alison.schofield@intel.com>
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PPF8FC6E1236:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ada7e8-56aa-4442-340b-08df2db30163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	aytwxFiIbB3z4UHlBrZ9LrIPztnT5+qd3UjSnXBzHHAX2f+fHb+zI/WbfYzC0UCGgtJB7BKgsYMGRf71tYhSD93T8puT8R0YH33iiKabrW7EX1LSlZz4k+S0dMLOFQHnb/fwMRCgKryYGoE+Zn3PhtAFYm8IFd5drJTbbAQz1/0zKKxJbxhRenVv4etYxLIvQeKmOKg91zbWHxl11oZo5IZfXVuxazQC3PsIxM2qiudYqJLW1bwIoNw5GAPTLXaLvp+MmDYxF/zdNtBe6hRta0WXgyNQYt7/hHVnXvmN/tOgN8xdErvMyrKSE6RGPEffAzineAwhJhtMY5ger2RcxaebYEQ4bquZBV5QNEeVIJxbWywvBOJionYiQY83eV/yfikK8eROf2RQld3d/iWzaPniTMV/7TRAUwBHkCel5wATLRk7mRIvksiOfU2nhHJ2qStrZRoo/G+Kpl5Kn8oLHo8zsvpcc5Snsp33rTuwo9uo9KqTuaAuLYaYStcFR2wqHbOdkvoTiAECSmt8OqwoEzoltEx1gHr0D2gUdZm2y34qOrTOSzpuNXiTHhH98ZtwucgUQe4elJwn4mA7+cR5LyPV3pKnZwdw5gwUW8pdLp0Uf5jtQgP17qOJxn/BBEwBEXgxfVZawOx6uYdfIHIo3I70wk74A3iXKA0Pjhp+X30=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dee4kZEgQ9jMYvTcA5OaX2isuF9MO70ZdnGmami5QyaZKxSN5Z/SJTmyq+0J?=
 =?us-ascii?Q?g9QwBOPl6SracZHKPdWjm9L4hDatal/1a8SUrAmNQVUUNYYUN04n/abP55Fp?=
 =?us-ascii?Q?HkwtZHV2oD1IHDD4RA8f2X8TQoC1Jvezc0VSVdusbwIjfa2uMBYUcW8gF5lq?=
 =?us-ascii?Q?NQDu5GRri7/kekcXUQGWkdKQfA/0GHPEGa89L8ToT0fr7owkRZmUirZvnRqE?=
 =?us-ascii?Q?rv35f06NYuYIPkwQ+qMpoLbOLdsJw38e5Z+9AHnfFErYwFBJMOfHAEnE/RT5?=
 =?us-ascii?Q?06CNeJjLufUlrmscUcunu8QU7RQnjSk2kNeBwfeKXyq46JdH6rqhaM2oskTT?=
 =?us-ascii?Q?Giwk1REMf7Xis1zjHrGit6t6LlMiAGlZvYIv7EyLMt4DODRXAGGiucBoK2bT?=
 =?us-ascii?Q?IaCdtLTqfB/XzRl77OmJiX7FeinzoRAftdOjZhrKXWn0bSe/RlMLTUEc2npH?=
 =?us-ascii?Q?H6nsKNGFVQN1SSvD3BQfdbKGrktVhHVJ2rfGE3YP7hZEJL0T7nK36rsYIhbt?=
 =?us-ascii?Q?PwNVLl8x+FJK6TfEtAR7qsyLYVMplvDmZ+AJdYgwzu04zrFUpV3mk52piMFS?=
 =?us-ascii?Q?w20f8nJ1QLS4qcrR5flhiEvgooEr0c2QKuzq0HQcxZk8qR7g+6FmOqg4rjT4?=
 =?us-ascii?Q?9rXaYTH/8br8BK38QexHRZA3iLYY5SdD+5oOTDKRUftDRU8U7vPaPQPTI9pf?=
 =?us-ascii?Q?P50qXu9alEQSK8z36+mDtKZf839HbdKXADDijrOLVqAGuERTk4LLuDvMFsIZ?=
 =?us-ascii?Q?DfnQ163Le5avLjpQYHJxhHWmIRrfdPSL+i9S+AA2/wzjYpmFpjvy8nWbAPBH?=
 =?us-ascii?Q?pqCrtNYIpPrr65AA2mngWq3e1Tgd3CLm6VzO3FQigYMeJFMrstQSFxgmIhcp?=
 =?us-ascii?Q?GckT2IL5OD42i9oOu5EDLyJvPB7jv9p3Cr948a/rRDSiujV39ezW2HxmhiZD?=
 =?us-ascii?Q?EIwHx7S1mGRvg4cEBnOFHLPAWjbtIYEYkqbEA21GHEYQWWlgfvHL+96kqgqd?=
 =?us-ascii?Q?dyqmULfv0BF7Q49rn5bzV6slOi1976dbu0UuQoCS/y9GvlhxqQgMkz8wvt6R?=
 =?us-ascii?Q?3Mr1kCcHp8KAtZo6ImkmnSLF+7U8pT2t0J/DeFb6OcsE8OH5a1u37hUOP7dY?=
 =?us-ascii?Q?5SeugVjpulusnQRtGCDjkUbxRCmoKNQh8xZaJ3ONQ1HKmWLQMS3f0NkULKft?=
 =?us-ascii?Q?SoaOhjohpL1AcFgP35l38kw460dd/443M/9IHU8ImgQrzX4yFNVZhm0Tnsuv?=
 =?us-ascii?Q?b8UFztimZtOCGLjA8nN+Xve50lVjXoH9Enuq7Hrmn1OR/TGL+iGuX76IRWK4?=
 =?us-ascii?Q?vMR9sagI+TYaS4Fvp4IrCXeo97ET7uMpjKcDjj8fkdgjCbGtss8fYlqgLt2C?=
 =?us-ascii?Q?nsZ09ahZDxqJ+10MOgeRsci6TYBI9T3+7Api8Kf7jCiYwO0xPr5dFa6QSFMi?=
 =?us-ascii?Q?lq+MPyvERoBayr2jHU7JAQElcNsAxjwarnmuXf6Gl1hbizIycFgDvgqV28gN?=
 =?us-ascii?Q?WuLqCXiTC0zCiSMd0raMeST/ATwB89vXnfhjfbi9NxWtXFbdD3M9HcAYS6I7?=
 =?us-ascii?Q?QYA7ahZyPNWoMQMWwBWjkauOWDtCCYLHFSw1kcUp7TnkM1F4PhxzsviRs5U9?=
 =?us-ascii?Q?H1+iH+JQnbu2ZppS/4FyWknw2ghFTM0lqAUwqHUyHenLSKBXM3ftMP4/u30/?=
 =?us-ascii?Q?s82e4IXAlxZidHlbAhlW1kv7GjUL94k8LxB5ylB8u54LSKBF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ada7e8-56aa-4442-340b-08df2db30163
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 07:31:35.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIQzqKWayd8nlIyZhPFeyRLdP650A42rYyPnU8HffTOy3s+VblCZsDEmoi5jUy1rACwx2GLRMgqioJrJWyQBog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236

On Sat, Oct 17, 2026 at 12:19:49PM +0800, Alison Schofield wrote:
> From: Richard Cheng <icheng@nvidia.com>
> 
> cxl_switch_port_setup_targets() calculates peer distance before
> searching the existing targets. When the endpoint needs a new target,
> the calculated distance is never used.
> 
> Move cxl_port_peer_distance() into the matching-target branch,
> immediately before check_last_peer(). This avoids unnecessary ancestor
> walks and per-port region lookups when adding distinct targets.
> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Hi Alison,

Really appreciate for the testing and if we can, can we add the testing result
in the commit message demonstrate benefit it can bring us ?

Best regards,
Richard Cheng.


> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4ab5a1d025a9..8bfebe3e1025 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1485,10 +1485,10 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
>  	}
>  
>  	if (cxl_rr->nr_targets_set) {
> -		int distance = cxl_port_peer_distance(port, cxlr);
> -
>  		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport == cxlsd->target[i]) {
> +				int distance = cxl_port_peer_distance(port, cxlr);
> +
>  				rc = check_last_peer(cxled, ep, cxl_rr,
>  						     distance);
>  				if (rc)
> -- 
> 2.37.3
> 
