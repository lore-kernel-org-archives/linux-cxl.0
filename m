Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D7C566A
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139901; cv=fail; b=VXOgjAycYi3PGfx4J0qm/W8CbudvEg6GxP8kajXbgmQObNQ9xA+wg7z9isDHesAAhUdgp4H6m5hyY4FKxnRBzKzPide9a8BzJBqbFsJkJCyKTmnUMZO8Pp0NQ8DqzRIQqeprbAMgzaS0X3hYhgayNzrag8fKknw7FsBbiIYzr0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139901; c=relaxed/simple;
	bh=D5GY2Jo3HOaOT3GSH3yocZpwcyrGr0219djkifOe/80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dw9a1lIAvCXdWssAfo/5xOAag+Dy4EPgVdjAwf9MswCjPbhzzuqaqCWMFqfaqffHjgE74Bop1s4M68ddehqtJxNXcKfnYbdSTA6dgk7Al4eqsxo7Ad9b72+QQ6wCVqgaUIIneSAW+SrrTc53+avcWKJn8lxTG/AwjaCUKRkx7Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=urV7DvY0; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="urV7DvY0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aszhXSMi/E8T+hOM/e+8So/M/tCEAPvkM6qwSI5/lYCAhagi3I8zlAo9G01yErv+jCZKIJXiKH6LprqVkR8MVJkrinUYSLt7sQmM+EciiJv3uRO+LSkzXvkqHqzqe3KsF43+aYsJlsQHWnaktK0uPYjWaHh2339lyf2h9Yn9kpPCqr1NUt862Jq8olG5tT0OEHInUfiSbWWCj3eOG938VNQY/pxBVvxuIORqjyS6VYvCaeTFNeafoRssYpCgK9Ubf3wZdWqXRlAaYI3raOd03eBKNO3izqN25p2KoTXVbNT3VXTJVx0py5iQhWWAkmijNPbedugtFsXBcacIW74OVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PoJyEqYC6ieVWES+U6ksz5vq0bsGu8DJH5e1KsbcuE=;
 b=ieZA+mor6r01KESp2+iEXeq+1Qf7y2iKtzmJIcyxRHyACXfGcCkkzUlsNmI9r3sQsgJ/hiK8F4mvLMso+CR8ySCFFosGIGWehofLntMhLW/1+EuqV3jv58/eH18mLbH20IGSZsKGjW5mo5PT1R67b6i4J+gCNEIfyYjRm4elF7NxNPl3k56eig8OSHTVOi9m23jLK2b7G32UnrBmlZblemNIyE6vQDmWgisoeRgDQHYfw0lxmcQY35TK2/WIXhThUXgkBpDpcvJgdPOSCAWNP5cM7M5nGuOxVoJHyQRPU6//dsgzJh8hFAi8+d3D5kkMkrSZljDyQyGxAX1leOl6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PoJyEqYC6ieVWES+U6ksz5vq0bsGu8DJH5e1KsbcuE=;
 b=urV7DvY05kYxjzPmMlRRXOPsizDD2fbAUXGNSwKQEVcDwuPndWr7h3TVD+SBrEFUzX/P5bgsZn8k7Zrx1dPDaLNw+PGhFSbo/fgQ903WRB3jZAEPD19MIwQgQC4zgeHwwWJAW64STqP1ra1aqogED2pf/O9mgFDcB5TPRCYeXso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:18:16 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 23:18:15 +0000
Date: Tue, 22 Jul 2025 01:18:10 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Gregory Price <gourry@gourry.net>,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v7 07/10] cxl: Change sslbis handler to only handle
 single dport
Message-ID: <aH7KsgySE8q6J-wB@rric.localdomain>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-8-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714223527.461147-8-dave.jiang@intel.com>
X-ClientProxiedBy: FR4P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d82cb0-f2ab-4e01-5373-08ddc8acdef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AJ8AIlgMOase/T3JPJFWTalYpZW6sNjE9j8yRlGT7EkK64BP0oO523pbenLG?=
 =?us-ascii?Q?Q9h2Fa004/n4A7/IgLcnrbBvEA+lz6Ov7sctMmoOk1aYT9xjAWJaJ9SURm5k?=
 =?us-ascii?Q?NmIkLFTKzCEMskV5urwPPzl9OVyiWLIw/aqTlKUmtIB6chLGpL7aVRjxIEnY?=
 =?us-ascii?Q?0bUQPqUqtYhYxgtoflmMipnZQezcN7EFC3ovAT/eoJVf/4cxyRrReg9u1FXV?=
 =?us-ascii?Q?taEzELtX6YRjbg+G+RfKq0khLbFsAueZrRuzQEwLE98BBvbWwRmio9LERSoZ?=
 =?us-ascii?Q?zHOfIgr9ZhBq8yV6kWbySjXDtCe/+Sfwoz0LKcpxvjP+XdfUeueDZS0sqMbV?=
 =?us-ascii?Q?PUARVAuB3+mZ4QGXX+oIXKEYmCMu1cn3WK1vsf4+klZZcV1sR2KsKJPV7wOH?=
 =?us-ascii?Q?58i/CrqnEJbJo62zQOoDlmCGZdb3dxgqbKjnPuTBg/ISYUBYrAqtM0bnLlPq?=
 =?us-ascii?Q?modVSypd0bAP4PLn93P9oDoSQ7OeplyKOd0zQKHbKGIqK/XBQkeCzXJzvLIL?=
 =?us-ascii?Q?vtdqKvDlqQRktgW1/uhChH2RGLcEqa8igJHN62mPgf7fNw7XIem+S9B+EKHw?=
 =?us-ascii?Q?/jpiZQvbnDUPAPmOHGvxNYaJTcr5dG/E+B+QYjNbRYK9ovnPNICFto1Lr2tm?=
 =?us-ascii?Q?EBS3SCEFrrzVkr1MOfC14XGqZYJGWMULBrLHA4OIFSJslyrVgw9xitJvUVPd?=
 =?us-ascii?Q?aHGvwWUwSm+rCkPDR7fsfBk+lFJPQG9A92sqyCWzYajhlSOpaMcTgB3p27tg?=
 =?us-ascii?Q?w8VyTweAfxBNBrPMgMD33vrxuzPTlz6fUmoiEjlF192YV+DiDn8K/BHmczos?=
 =?us-ascii?Q?wHd2tLE76Fa9ZraBnjwEJDa2t2btrQQjzwSlSwG5g7mA5hjjOt5Bp58WzcFG?=
 =?us-ascii?Q?f0WgV1Sb/hEFw9coRZb3uyaraVGC8QY/w9+zOhYe3vIjioCUqUCKm2SX/3kV?=
 =?us-ascii?Q?0hz/PgabUN9tvAEnfZscXSwp/LgEaAqEoWQqCUAMw7r6dnfPrviUQ1buf7V2?=
 =?us-ascii?Q?ooW9VyWYuzLYrCs/M7Yv8aHHLhj7gTbC5HyZ+U9iyzYz9auo0dJ2vTybxb1+?=
 =?us-ascii?Q?tk2i/Z1IY3tmQmATmWJRzvbauK14E/72BrG8E6p7NgZFUyMSMe37Sh8lRegD?=
 =?us-ascii?Q?KYJJ2tn5vpN21/2nv8HmCQiqbWJuZNJvG+QxfVWlKxy9LQBZU9kITR/J7Jul?=
 =?us-ascii?Q?qQuUf/x7k7n0mwZBv8lfPysFc6/hYLxYyYDqQJh+JWy6nUYqs4pWKrZSmu6S?=
 =?us-ascii?Q?kCTMYgRO/PKn41IVgHn3jtFkRPH2kwOYXHVYfCoKS7XrUO7Sjy65MYLpFFM2?=
 =?us-ascii?Q?Kdil6BKIC2yjLJBK5JZBkk8s+Usne2SvKqVhyngTppbup37QMqAcERXOP+pD?=
 =?us-ascii?Q?r/SiMT+hxdLn+asLvRxDSwEEen8QHZ57ZvmkR1k+c5UTfmhqTHMKMCWQgU5z?=
 =?us-ascii?Q?UQtL1goCbhg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wfMhp+QsszTmGJcqG2dgfw7QywLhTGSpN+dqGc09R++f2sksg9uMtsR34gqy?=
 =?us-ascii?Q?X7G768rRVzb4GWl0kgmaGBSwCqUGghyiMnfgwc2tuKUTsuyGv/DdX7OX4nZB?=
 =?us-ascii?Q?Bqk5wE+452BKbgs0JF6FY2EDb0u7g9rwK7e/GG5y9UaGgwLSnPa1AyMBsQvS?=
 =?us-ascii?Q?XQdSt3r70s1lEn8HvalFRU+DbCUFQ8/3MFo9y9qUa8VomL9arCRSctZpZmmj?=
 =?us-ascii?Q?eHKM3R4Xq++ljdqAMuIgB8/JQSCfYHNYWJr7wUNuo4CtiluRCOkIV035hNGY?=
 =?us-ascii?Q?VLo1TQcLuA9iT2w+I3XrDFRThHXgOHD/1PPuEq0DGj0R5mbcfI2hGQKr1M2k?=
 =?us-ascii?Q?cvKVzANU2Ounm3MILVZkHXXeasRVB1KN5RchVnCBG3+54FbqC/ggwPUptJnu?=
 =?us-ascii?Q?08ZQus3o5nrBLY6smQ0LFV+ar5GZKjXnRlrqFvZhGCkt2V+1BOgl3p/mZO0/?=
 =?us-ascii?Q?apXmfaYDAsH2MevgBUVha58m4ot9HCckTNyrRx7FXZhhy7CQm0hZX2PTykrr?=
 =?us-ascii?Q?kNaIfaqZjMIKK+nKPmds5Wf1JcrrDtvYcv81NGtQDUiAwzSuM6RINZ/tRJbF?=
 =?us-ascii?Q?JwL9CnLU6pdxuGkVawYz+H8FY/PlfvzAmjHed/SqkW5itOmvOWaF/X2YfTXG?=
 =?us-ascii?Q?CovcfHF+VXtJx8nDlIYdNq2lXZeipfJ+UbrhZa0f9Dt9V9gAJt+dF2p+nBIZ?=
 =?us-ascii?Q?1hXKGelNp8yEKtIfVzzLDKBqvOwU3VgI3QDhqlDVzQ6eKwvcg7sq2Y4M7NFj?=
 =?us-ascii?Q?PomHnAvJ3mAhvNfwP5D4v7cmq0Ekin6l5oIEC6DOFpFMSJWXRQQemRYpnoOT?=
 =?us-ascii?Q?S9DRnYOQrwn6ufGdaiN0CVVZUZ6EloNl/MZdYTBQFsfPDK4Qx6AknNX53ue+?=
 =?us-ascii?Q?SwKf9dzXQw0GyP4YyVqx/vu5L9YHc+f9v8x40sXTvSUHvo3Ct9EGo5hR5SBR?=
 =?us-ascii?Q?ikO1J9cUAFdEh9zrfx6E2xwOjXvzXKmxAkmryOTMifYVuEb3re7zG0cMjt+F?=
 =?us-ascii?Q?24NCggZ58W2Eu6RL80h97Ue2pXsMk7lWOm6HL52M9zKKCeckXOiXYvL/EXC1?=
 =?us-ascii?Q?9jFfnFc67LuVaWiNXT1lhfF+V4lV7jR8nh8oUfNrV2k3ZpBAKFQwGfing9z9?=
 =?us-ascii?Q?zK02GQ5wOwQFv5xY00J8xpq9nMFSn5lP/xczP6ES/IyZWQEjVvqBtzvyPzc4?=
 =?us-ascii?Q?vwUvc3vh8aEJUWmMKWOV3KEpeFwOlccFMAFm3WGMzu2g0vp1RVQQP6/D5/GO?=
 =?us-ascii?Q?Fxidyt4gulIzqCMh71khkAL289JBDlWBU9jp3rnFKCfKOR8VE5LF4T1VBptj?=
 =?us-ascii?Q?bqijsCU9nWyx7IzhuD3aMC96VT+ePx/TFw9ux6eO2ToPcg4/5fvK+PtFtMr2?=
 =?us-ascii?Q?psymi3gaPb8c28iWcABNs7cA/w2D3p2Z44Z5JIZuSp/ikHwbC9A2TUlvXB74?=
 =?us-ascii?Q?rsb9L1Ho2VDfh+4JbXU10SGku0pSJzW6fCDiDQ+de700nNnuDPMsq9o/TZpi?=
 =?us-ascii?Q?Xjs3FBrEEvgt0qKj0Vdrz3t/BjI3WjtF0+yQIuE9f6XX7FPmlYpJinHhMKMg?=
 =?us-ascii?Q?9z3eyMPWGPX/bEHsxq4c2gzBumzGegaqnp0eQirc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d82cb0-f2ab-4e01-5373-08ddc8acdef4
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:18:15.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qS3TLoKl9O/eObVxTQ1tk8IRLZ5Xmd8+z/LsXA9HZLAtpubjTvq0uIzfRIYZs9NEDyqhumE28s0PNgCRlC1rbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396

On 14.07.25 15:35:24, Dave Jiang wrote:
> While cxl_switch_parse_cdat() is harmless to be run multiple times, it is
> not efficient in the current scheme where one dport is being updated at
> a time by the memdev probe path. Change the input parameter to the
> specific dport being updated to pick up the SSLBIS information for just
> that dport.

I more like the approach to read the table once that collects all the
data in a struct as it is done for the xormaps. Have you considered
this?

> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c | 23 ++++++++++-------------
>  drivers/cxl/core/port.c |  2 +-
>  drivers/cxl/cxl.h       |  2 +-
>  3 files changed, 12 insertions(+), 15 deletions(-)
