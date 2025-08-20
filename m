Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C418C031
	for <linux-cxl@vger.kernel.org>; Wed, 20 Aug 2025 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699486; cv=fail; b=Z8MiNeXZLcz6qt3h5rlQBWhZZeqsM1yvbQxtVtAUbi9VE9sjJgCjCu99OAmrktIAiJ1fZ31tk7o0DmwQB9nf7T6Grswaq2aMKus5ps/a/HDkfbPYLszpTuJ5XtgX7F1H+Er+UGQSW9NZtFdtzm+bssCLeTbQcTtyKg9KVOOK+NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699486; c=relaxed/simple;
	bh=IIP5aAKURKQw9jou11utdHQbbodO8o956sk9X66D9d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mcXcNcNubokIEExfiVp/1wjGCpZKt0YxS1JmZykZcVj0qdkDJS8QkzXKz5/q+AIIKQjRpwovBaAJowVjp2HdcF9pna6R4SZDBqfRtI2akuIoO0XT2Ui8uTeBdx+ML8iY+Qr/mxHgEpp1kr+WSjr5ZTFVoMhtZ5Vjg1CuuJ+XwmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fpt+Z7z8; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fpt+Z7z8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2Nq1aRE1bpOGgJXmnG+mN61PQoIABxga2p4CtwHfXYND6JlX+phfVZSnoYwOpg0QZUqJWXuUx0okwsFCYu1nDykZ2N+wZX8H0WRVrJYwqVqklNrjAA3XOCz0isePEO7GzsPn18VoO7eJ4jS0GtYrcEv25LyQX9YFzPIbw9MFphCmPCLdZUb2T6droA5LrjP0wHsiVO3GK8yoddMAhfbW5pwKwUT3qE/4vG/8LQb1PcIKT0BwybozM9G3i/zzjNwymHkzuuDq53LyFmCHvSGQPu16AyDuQL2bbiN89jBHoCtkVhXmU77kki0FMTTTj6uqnZimh3GR9YGgZ/PTMoG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtb2gkkvSm3Nsdf7fyNUHJnVxmdRGsWr5QghOQYqEdc=;
 b=nbK1ufiiB1+WEz+Bll9h6OA/QM7n7H0NBmVdf9hwzQ6MKIiWicCxyg2vGn7QZo0m/a888zgJNS8Aj1fqxdcqh+3pGOOPtbRuy5QaNZ1nI/q+lDkZ79+GEJdRNOi+60ibjwiNvR2uy5LX6r+i9VCJO/tzQFPuSRv6S8NNHVgBM2mvQ46MGyKYA8y9fQEofGyYZFX+rdKMalmZQ6tmGZAtrms3/hkJwePBUVD85RQEDF8VL/V7DqEGsmggNFsRS+zuw9osw3wKyILOZFu71k9OPv1iIaPPep3hcXphhuPokCKBjTFsqqDRtVnmvuB2u4T+XSnbLACLW3PuAiaz+JTZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtb2gkkvSm3Nsdf7fyNUHJnVxmdRGsWr5QghOQYqEdc=;
 b=fpt+Z7z8kb0nwRu/PUKN27opLQ3qkfN37YEO5kjEjzhADdIgRzIenq37Ye7JnMrdWLQjoglEH5g2WxvWnQB3MfxJt+TPU95lUYojv0p7my6lFqFaRqkC57l6bHdUibaT6UGyL4bhQgFEp+1KDeh5oFLhwkQXqVYZlL6Bojbx4wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 14:18:02 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9009.017; Wed, 20 Aug 2025
 14:18:01 +0000
Date: Wed, 20 Aug 2025 16:17:55 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v8 03/11] cxl: Add a cached copy of target_map to
 cxl_decoder
Message-ID: <aKXZEyG1PpPQ25dC@rric.localdomain>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814222151.3520500-4-dave.jiang@intel.com>
X-ClientProxiedBy: FR4P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fda32da-6baa-4bc7-c05e-08dddff45eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AWHEOXeAY5gKDvmFLTByZc/0VZwncME+D4ngTtyi1SCP95vJf4lsrDoGeR+e?=
 =?us-ascii?Q?DydvLut1I4IiNOeo/MEJlQXmbn/6TdPAo9AILphjRt5XhglmgXT/eEFaM/pm?=
 =?us-ascii?Q?sFGHlsIeJs9k4moqHGjwUXGsPvpeyzdtiCslN0xfhSV9Gjva8xEf6uM2jdGZ?=
 =?us-ascii?Q?VAjn/yjS4grcDy1n/1SK8sPRRiTdHqpVsTQakdYUfGtYGr0AfQPvloOcaN+D?=
 =?us-ascii?Q?/ABo4oF5M14uZja/DJezbrDNFhiCtUpKIZvfIKOmQZGgHvcalF6RYsDV9DXi?=
 =?us-ascii?Q?cEsyV3lP7TctejTWu7Bqbq6uz5n0wQGxjxleb/0nlefyywlqFDjK4MSMY6W4?=
 =?us-ascii?Q?X/l87A3cH5qFkv5+SvayhHRVE5ZpShBXKvTB1ACKN3aMTfwWuvH2asuy+7td?=
 =?us-ascii?Q?qT7UGm/w0BXaW3mtVqqyn/v6rIqa/PgRoh3cJkSqjh8fUAgqwMaYbgyTTeAw?=
 =?us-ascii?Q?KvUsVmblijYNvb7Prj0eFwhqaNSDlfTVyfrteYov33ct1G6m0I31WMjCxd+m?=
 =?us-ascii?Q?OzVpr6DK6eDTHg/Mqfs9FQt5CJP583nMOAWvCsUhQa/jZdkAb5kNz4+SVoY0?=
 =?us-ascii?Q?H14JUlSnOr984YJbdHDxnXmcExgeW8ya9zoNdg73gY7qhK3BxrTssgEVX9C1?=
 =?us-ascii?Q?VAfg+Wq8Vt/a/wp6guipc/uDRlGDg9rGR/tIOspWhJOHKlvRanMiutDIUBqZ?=
 =?us-ascii?Q?O3k263hNimnR3EPRjBhpJlrMMVJ6foPSQWKQ1mezSHaGAGTeav7krXaHSae/?=
 =?us-ascii?Q?27SBOBhi7AXJLAWel6Ye9aPtw7Ore0GhMs5vOJrHtOBNMJWNJxdfDa9oCi/z?=
 =?us-ascii?Q?bnGp4UWox71DLP2VMHgTUkwrjslvmYg3V9UM3HZH0/Ud7Y9iXk8byIP0K8cl?=
 =?us-ascii?Q?VsuLnlY1qSUJIKZPSYHqq/evWQeseL7uy/I4X7bgestoYKztJFWFmgG2YDDf?=
 =?us-ascii?Q?zVO1QfmZKWUrY4Cg08qScI+SizZeBDdX5A9n8dqr8hN/ecYSnNC7jYJHadiu?=
 =?us-ascii?Q?5wAwh3hqwuo0FO2g5L0mBAlo4O6PAtx3QxDl6m/AziR8VWNEyy3f09HuChEC?=
 =?us-ascii?Q?ZNftyG8+7/8yMmwuhqVyHIER5qKGD9NIGmHomPNh25nnq+0GgvEKgFqrygCY?=
 =?us-ascii?Q?IvyZvYteN9gi3w1GQN4GNCrVwvdOj0uJzVRe7bm/Xu/YyS/ATcgFElN5Gsfb?=
 =?us-ascii?Q?vaZDzWELNFw0FJSi8x9UkFzVv7pdGk58K4vnDp5u/6QzRyxUYPwvQdQ3TEtL?=
 =?us-ascii?Q?duzkUxZqMOiCa7l418aHdchL8q0QMiRFMKbuhnonT+3WJRH0Q3z4I2XdY6Dm?=
 =?us-ascii?Q?IvKeqjwTVXNtnRLc3ijZ8UlYDTo9pIv/OAzvkHoVstJHorumVUdh/IM1xyBa?=
 =?us-ascii?Q?6qCt7tZThlLHdWoQmc+Y0ksX5GTdj5jEIvUMwzF73qo5NJcUeoYKecum8D+t?=
 =?us-ascii?Q?SobunYTqKxQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r1sRUA7Fe+5ttdAB+Lw7687unLalDrz9fnp5TPgnnn2q7d+hCqnrWAi+m4Rn?=
 =?us-ascii?Q?4lYRI0f5gqeM+ML8mtW1pptSUVB3vFCWREePdg8zuBA1O5Tyf4WbxHJacgep?=
 =?us-ascii?Q?/gC2GAJhmKeVHvp1hc1WSQXdWTke1H7lw2NkFrbPa2+f/TOQt4EIt9AlFodv?=
 =?us-ascii?Q?UdHVnIKMbSAUtuYs+QOF6ozT4cXIogrP/XWI1agCW1sr7z4eKVSSTqRPlZOS?=
 =?us-ascii?Q?x6iLh234AuQm+foc3Sa5vD6IwSIFx2oycr8GE0oYwpfys0L63USXuYPksjcZ?=
 =?us-ascii?Q?lOk9OQqO0nDfVgtwA99ANjV4CCNuNvFdJC4swtzh7PAXHz97RoT8xBuKkowt?=
 =?us-ascii?Q?85OU4I392X7GYxc0vX4Pi1gow6GmZZHi2HlmGKugB9WAD630WmdCGZACB3md?=
 =?us-ascii?Q?FF1PB0syAW/FNQWALUMfFjlMYLjeCFlX8vH8zfQhF+QRgI4rxsLqsbVqlFLl?=
 =?us-ascii?Q?tDk+zAB0Mav/bUu5wz63QtlUWN2/RscEE7Y+iv8UyuMLOvZZF/Co0y5ZWLaY?=
 =?us-ascii?Q?QkvVcXy5TdW7633R4jFm8/Sf2xq1DquuXUJ/EDerCTlVQ/KXdrQO5v9VLenz?=
 =?us-ascii?Q?sywncaJvungsFnEgw31OqE/ZVCnzA7aT/t4kINtxiCNkUb6r2+7vUKezW+vM?=
 =?us-ascii?Q?bCtKEnc0IKtjUR8HShrXleYhMVYI9Qeg7qUy+hkOMJyS+89vGp5y/oWAnvL7?=
 =?us-ascii?Q?B01Sso19oiJnX5SeiXCG8sn0lJI3xjkph5UKtN0nXC5Kcz0qzIonT3dsqkhb?=
 =?us-ascii?Q?qM9Ev+M8l0xl5APbaxmvok1WZgrwq4Jfny17rUaIWINJd+Z5HTvI48VeJ+OX?=
 =?us-ascii?Q?ajU/Cj8vy/q38FO+pHGIepFxLD4DQEUfdjSrvGwij4xwSXiy5YTynbnSqWPO?=
 =?us-ascii?Q?HzEMN94rwJMDX7AiEgjWVEfT3vukv11DjaZDs/kaMWLpvbUUO5ZZrsXLrEb8?=
 =?us-ascii?Q?4cnrvhwZYwwlZwm21zcPYGl+xMBLhNyeNCepgyE/YO6JWeu9RVRNl2rvnfN1?=
 =?us-ascii?Q?CMHOc5SAZymZFlHWgDUmVmebvxMja2CmP0jASIrPV6d+PY1qbH4bYf4LGopH?=
 =?us-ascii?Q?452RFm3Vo4w2c70h09JHMR+hpB66PTY46O5qpRGfB8iNrld9hLtxDny/7PCe?=
 =?us-ascii?Q?/OgoHE/JWI27aN24w5bAlNVR2mTMs+GcJpXLUlXp5WCCdJRaq2C31JqEsvtk?=
 =?us-ascii?Q?JZjnKvCbLO5P2lvPvUdVH58LrtbocaNXdExCxkZy8sz47h0WECvqN/l76HTK?=
 =?us-ascii?Q?znGfkj62ibF8/ob3rlsyQw2cpMyoVEjaP9qEv8GCZsQ5Iv/umFSjZFQKiODi?=
 =?us-ascii?Q?ohfp3znCowLkokdZo1CG7bMul/qoYkUoe7MpbBQi6hTEe1qaD0Zspq/vGYqB?=
 =?us-ascii?Q?Uyacm/WreqlcDZVmU9546l0T+agsub0nbpvl0cpFYqnfpn2OjndI1VTiM7P0?=
 =?us-ascii?Q?1+UVYAfRSxX0A8UrCfddQWKf5LyPrNYEbYdRm34N76fAKu04xN2LNQOloR8l?=
 =?us-ascii?Q?14nTqhM7PIi7NSGVJmMWGKrwLBTOUta4AAAqV6PeSZhfyzUDZUUNEaO99sSA?=
 =?us-ascii?Q?XnjEXfKkZpzoIsvY3aaUb9zMbd89fKjwGR+frWdu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fda32da-6baa-4bc7-c05e-08dddff45eb4
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:18:01.3162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWHvFa/GhF9kI+jFjeE5BgrhjuHWyxfR2hz75mM6MgUBnzHfnLD5Ede9LKC62U713L/i26tK47WzGhjR1As4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911

On 14.08.25 15:21:43, Dave Jiang wrote:
> Add a cached copy of the hardware port-id list that is available at init
> before all @dport objects have been instantiated. Change is in preparation
> of delayed dport instantiation.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Robert Richter <rrichter@amd.com>

Nice rework, thanks. A nitpick below.

-Robert

> @@ -984,7 +982,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>  }
>  
>  static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> -			    int *target_map, void __iomem *hdm, int which,
> +			    void __iomem *hdm, int which,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)

Split line to fill the 80 char limit.

>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
