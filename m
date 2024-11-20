Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59C15747D
	for <linux-cxl@vger.kernel.org>; Wed, 20 Nov 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128180; cv=fail; b=iL6Th0uEsuksA69r9MZqsW5CrQXlYJFuSwLwCf2/XJW3zludzirhgdJuRpy0xLqkSJnRrn8uQGkCCd3wegnWjm/4t5gCp9ESXGhCgzBqHrv2SvGAgb4EmZnTvuo3ljygKQYP1mGTlUagX5XtByEGo3BZqNdCx1HN/KjMvMKk9WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128180; c=relaxed/simple;
	bh=ACS+tqAAWl8c3k3ZjId2WaWGaIQ2orEL1/Emz7h3Sn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLpsMCeA687TJAi8oMCaxanikwIJGqVwZbTFccNM4HOF1NgCOPNRtrSEnXy6tI0ARoORyIYHZ8XR8I5vywY5zOwt37VWOv09Za7VZXs2Syk7taXG+iTuCorfWLTvbAx5k31/4iRMYvHK+YX2nwDtk6fCrsVhcqE6g055ffTyWEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NvTuKMJT; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NvTuKMJT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxNDCd3/e7GQUuM2bWDrM5rd9eF5Zvt+9qU2ALBp/X1HNaEZBRL9XK5iKpWk1mfDjaudJx7jJA+kJjdKUpqJv7atGNuTe6RQI5+dU4Ep/kK5YYR5m8J9ClMPaOw4mkITUAicZcjf2Swu2iJv81OJs9UugZx0ombQkmQxAV/IK1psYzefETTLqMwZDu2Fesju6+bpRbMC5AbJeNoFBeW7gfMNuv1fALysPZE/Y/uZAodrz6GTqahDk4pQHk1BeEhGL4uTbmXunWuFndxHn7aENuotyiRw3HfrlvR+NNdEVMhqUoPSPWzHgFxgk78x6zosrBFhj3d9Bdmm5ZIxK4/hig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9ERMjffvG8vyPraEy9sDGCS6tBK8W1bZ5pRrBuEeX4=;
 b=Rhh2yBkxGq4hqdTxUWbckhga/S5SJlq57yEdisrMcv1V2iZXmbFpsemCRc1IZQrO2mk2IE67PpC+VuPmuWYUpbcj5X+6hz4ww94XhQSY3EZG96k0vYH+7p+SsdwmK0LcHw0YRDIV3fcAio3s+/gLly7y1eWfVQhIoiEq4cds376TgfeLv1w3IYMfRDjJtwsTIV8iIaPdmrU4YRUjnQK/5UA1LD045DPH+XFZmQwLihlfUvR7zL9Lbh/kHw0tWLkDuzrEcFLZnBJjZYUUgi4oZQ7v2sJu3DJ/suBqUh4BWxNNe74v9abW8uOtROSkiKVd66wZSAeavsf/mEJfQugrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9ERMjffvG8vyPraEy9sDGCS6tBK8W1bZ5pRrBuEeX4=;
 b=NvTuKMJTboqiA0qk1HAVcNk1DE4ojVycGm+uzL5Tz/YJ4eInNbanLpPHX5BBU/atXTCC+8mOOSro5V5B5ey49rw+B28llRWAKuKOc/JV6vTgwbMG4rUl+RRqFZudGIlu7wNI5xzA2O1PtzIvz7BVJ28Ic6j7a378766YEasQ5Ezfx+V9UJrcHQF/GHQ62VUI7/y/QU0/Fjd7KEbb4ZFH0FkgPbiXfRlhK/5gutgfveiwYC9cAgcEunuIoKl0MZYx+xgSwqOYzKeM+1W09XBm8hSMKIDWqTJX0iwHE4sqO5r9hoTPIfG9hiUceuc6Yg7vEPY0Iwa7eFhSMghaV5xCwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Wed, 20 Nov
 2024 18:42:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 18:42:56 +0000
Date: Wed, 20 Nov 2024 14:42:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH v2 15/20] fwctl/cxl: Add support for fwctl RPC
 command to enable CXL feature commands
Message-ID: <20241120184254.GE876522@nvidia.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-16-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-16-dave.jiang@intel.com>
X-ClientProxiedBy: MN0PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:208:530::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: e2dc827e-7e51-47d3-c1e8-08dd099325ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9gR38jIVsLF4VffPJxBDOS+xKdQfPvNcVtH4WfPUUB9t3slVGCtEP6X49O63?=
 =?us-ascii?Q?HmTfNGMq+/3mMELg7f62h1yfiruyI5y3q0aHVDQuBcMLOHwFy79WeRER2O/u?=
 =?us-ascii?Q?ttNvD7mJXUapFHj0qvmd9nE1jaBpzN6OTEY4N9NDZyKZE/AOjQaqjFty3oYr?=
 =?us-ascii?Q?DBY1RUPaU1PxmfLI21t/hRUTXzXAEGtvO5Ka7qJY6h06L1QuO22rGEhx/zNd?=
 =?us-ascii?Q?FzhfK6VJSuJ+dh4WvtQPaN8457XoSw+pubSOmbx0LkOZZLKbDI3PsA7MEb93?=
 =?us-ascii?Q?WWoIBSSzioP40Z9WB8pMhvesEZeB6qfX8KpRVVTRfMxYFWRs3YjEX8ctXKQq?=
 =?us-ascii?Q?/ddEsiWm1LLJipZMf2DIn3UBG9Gz9ztLjnNirZaTHxonmU2zZzQR7e6bEAsI?=
 =?us-ascii?Q?U/c/DDKg6l9NI6ViA2znYVaYmBe4Y3X0wKGctZiRLFiqJ+KGCphPJJk0RL4s?=
 =?us-ascii?Q?RNk6sXDgtCMxG4GR1Ns3DQlYv+pm4rpJaZD+i3ZcO0H2XGNVl22vf8VtMfA7?=
 =?us-ascii?Q?frB0i/jhg80+KOYS+uOxQ6tCf0p6IZXRCSSB/NGsLpBe5o92jOSpSPynRvoL?=
 =?us-ascii?Q?6kDobYVtesTuNzYw4qI5pJhPAYikW9CrXTZ/uezd0qc9RTNjh9CoXP0/QIP/?=
 =?us-ascii?Q?eMOk0BTfTAZxIuMC+InPK2rPddPuW2T5kHHmnI3Kt9SIA6kRzRIIkg+ZCIJO?=
 =?us-ascii?Q?APy6ME6hnYmt8SlY/wObfKWikqYhAyIxUqwHkGBO6NNcSTGxS1PBiawCTvRF?=
 =?us-ascii?Q?lwU7+NaOxZ4KZwK1Qr1v0yIX+w5uXdpQpS/yIZbtAAbsC9F+fmkgRoUiLOlE?=
 =?us-ascii?Q?3+R8WpQ4zoM6FUIJDgbMQneBnPJtOxlIXj5TdRPpK1YnkysMSCXw9LfVpEan?=
 =?us-ascii?Q?53mJWog5vQsmr9WObu5pI3t0VCd2oe5e2IR3KhIlNswNDu+eF1d/TKOSlNN9?=
 =?us-ascii?Q?xWYL4iL3dairW1BVHRUt5fJFXjyz9UIygpYsqHbeS3huTDgrosug9zGhymjX?=
 =?us-ascii?Q?KNL+F6YYiba8Xy/VjahbfkhBH5T3dhjb3f2l7XfFjpU9Z08UAkAOnkVdpcMi?=
 =?us-ascii?Q?VL2xTDt6FYJD5WDKasIvoBLWgPBz6Qr2XM71k6SyGaqcueVstURZdA1mdSLj?=
 =?us-ascii?Q?/ZromTVACONgkWVoPcobvEISmzdRERRUZs0atg25ZD9Nejkd8FAuRTCeXjPI?=
 =?us-ascii?Q?ZvhLwlhFxl1QHgU5UYpaJazDge5ZCtOYdcVoyoF3l0e9f/Kn2RbD3T+x59S7?=
 =?us-ascii?Q?54R9rtYuuXIm2KgTlzx2mX7nJKpLNRH/m6K1h+DtIp1hyGo7HE6yiI5IHVZz?=
 =?us-ascii?Q?6yykcEBgl/nBwGrGxcp4Bweh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/suaedOV+Nf01ECqdPLdpGCi8HCw3baWUAJh7Bww8VdR7kXwjCpuRMe91Gbd?=
 =?us-ascii?Q?spi89ZrRhHTB5vZdDz9M1qqzGku5j4WGE9DKpR1QimyDnyYynNMOHRI1XzYe?=
 =?us-ascii?Q?I8KjKXy6hiEMeJmEOh5+wi+aGWjEkVpNA7XYD3do/3z4Xs5nWdzv9uiUVFQC?=
 =?us-ascii?Q?lpIF8kfN70QSoO97OPENNT609FbUnKMtEBhgkWaCzZXzeeWxCWsExDXyW+JO?=
 =?us-ascii?Q?fsLBsAxbsMci8WRyCZmlo2uC571oL7xk0uCr2zhUU9+hi+N9dByCbQAO3k5H?=
 =?us-ascii?Q?shje8pO8B/80XvGmQ8zxuH7FZXOrMS6tU460jCNhSoKPu4KvQzXRh0pYxZof?=
 =?us-ascii?Q?WTYGGbUBDiOgwUvHfRSbNsXXK7txoU3Ch/6TmsMGTf/JvkAEfgFK9noLjUAl?=
 =?us-ascii?Q?7jzYXcC6gh0yF4zlyeMTuzB7pR19kpSKVZVAtS8M8I140YdjhUclXp2fRfn6?=
 =?us-ascii?Q?MV/SgIYIFxBAzK7b5b+fa9RBPit8NqufStAgIyLed5Hm5FxTTNnAQoaN/rBU?=
 =?us-ascii?Q?+8ax1Yje016Uz8X9YKpeDZV6IFBQszX1zrxcV0Z6Ia+QPfX7qy2zpEo/7A32?=
 =?us-ascii?Q?0k6rNvi7tOLZZ4399kvM4tO+g4hBJBSvtRAoYrCdxTKgIuBt29bMk8nfFQWk?=
 =?us-ascii?Q?hxLFnZ06xZl5BWkIiP3JjXCO9f4gphwyHcf8hqfysIzC/UGk0eAZi6uWRFfX?=
 =?us-ascii?Q?FwI9fhumAATIEOpMgfVCxgWUMZvvPAOUO7hs2yRO7rijwkCGrOHM45Hcc0br?=
 =?us-ascii?Q?YzEjMvY9vglLXwUnvDjHYPtYUTvZs9jc7oT53jMODh8tWQIOwm5JTy4QncQv?=
 =?us-ascii?Q?KwDlA28MmYzDfnG68HsJE5aDvJxQ9YMvpbtSYQiSWVAkTKAdF9XzNmWap/ZB?=
 =?us-ascii?Q?HxF3yVv25zU2e4skpBDgZvDqNfj8ST4wjH9dq2w23+kWDJPvQXQOyqAba8cy?=
 =?us-ascii?Q?Em0rUzXKA3/HNMEqfBtCa3n/HjN6YmzZc6TSV/+hwhn6w7pHblUB3+dLtaL1?=
 =?us-ascii?Q?5KywUvwMr9lMvm1pGf2YVmgpwAFF9esECkyAeoAHxbMTsNSAlrlU5bmYLVFB?=
 =?us-ascii?Q?kDxGNll507li/FE+1Jp8fSHKbnGaafS5qDPE5bXS/D8TbFvbhyHx+NSTSA+V?=
 =?us-ascii?Q?c4fstu9yND2XezdYDcPFamkraPj5R16txg5T1Zb9NbTT5k+XqzvY+nmLR8YF?=
 =?us-ascii?Q?e4iAzniyakfmOwW+2Lga7bir4vqNhvoTA9MPHMimulAUzpF/CrhWg6ub0EeU?=
 =?us-ascii?Q?Ec3jEvd+mBYk2urJUgYAR4O71WZJpbk2OPnE0o373ePLRDfIrHSvthkHlQRJ?=
 =?us-ascii?Q?G7cGMJaAaeIg15OquAf7lItD+dXH1kMtKRP6hh1jnSwgz9DV85RA/+tNzyVt?=
 =?us-ascii?Q?oLRiNJqkpJJgEfU71261+RtI8nqQElH2blcrz3XjmVDQGOHapXig3x9eupiC?=
 =?us-ascii?Q?/QGtS1zaaWMr9f6vFewjGnQbf4Hwmq/kKColTyZmcUsxp0xjH2qMeFy7sW8R?=
 =?us-ascii?Q?vspyy3mVEyF4WmshC9wbbqcwTcBHsgAcRpSFB6bSRKfppwGYqG4/zV1xVCcr?=
 =?us-ascii?Q?zplJHTQOrONNA2YLlroSJQNnQ674s24qvUk6G/Pl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dc827e-7e51-47d3-c1e8-08dd099325ec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 18:42:55.9600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umGmzfvz4B49io4xSHchLlHVJhRDqVEr830OlEELh9FRe58EfmF6XDoxaGiGrMTg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247

On Fri, Nov 15, 2024 at 02:25:48PM -0700, Dave Jiang wrote:
> +static bool cxlctl_validate_set_features(struct cxl_mailbox *cxl_mbox,
> +					 const struct fwctl_rpc_cxl *rpc_in,
> +					 enum fwctl_rpc_scope scope)
> +{
> +	struct cxl_feat_entry *feat;
> +	bool found = false;
> +	uuid_t uuid;
> +	u16 effects, mask;
> +
> +	if (rpc_in->op_size < sizeof(struct cxl_set_feature_input))
> +		return false;
> +
> +	if (copy_from_user(&uuid, u64_to_user_ptr(rpc_in->in_payload),
> +			   sizeof(uuid)))
> +		return false;
> +
> +	for (int i = 0; i < cxl_mbox->num_features; i++) {
> +		feat = &cxl_mbox->entries[i];
> +		if (uuid_equal(&uuid, &feat->uuid)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return false;
> +
> +	effects = le16_to_cpu(feat->effects);
> +	/* Currently no user background command support */
> +	if (effects & CXL_CMD_BACKGROUND)
> +		return false;
> +
> +	mask = CXL_CMD_CONFIG_CHANGE_IMMEDIATE |
> +	       CXL_CMD_DATA_CHANGE_IMMEDIATE |
> +	       CXL_CMD_POLICY_CHANGE_IMMEDIATE |
> +	       CXL_CMD_LOG_CHANGE_IMMEDIATE;
> +	if (effects & mask && scope >= FWCTL_RPC_DEBUG_WRITE_FULL)
> +		return true;

I'd put brackets (effects & mask) &&

Jason
