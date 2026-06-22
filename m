Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013046.outbound.protection.outlook.com [40.93.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E693A5433;
	Mon, 22 Jun 2026 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123553; cv=fail; b=X+lzrHPUSURiJ+s6QNg6O7HVDQA5niRlp2XOu+puaG4uN2EbwwaX7T31458z4wZynjZKl5+HmvkM4A9fKsfy5aYb7LjfSvYJiYThoaeyPz33oLW3f9q/WWggQEBYMO+bt3fgel7cj3OKOQEHQLhxByOgicOlLnNS1e7S5QMotW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123553; c=relaxed/simple;
	bh=qzOLJI5c7HSzh+mIuztoEJvfF3JEMY8B7wotNS8+/zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RU4ya/er+R1oqPRRsrhcDSF9KmNhZXWgDubplg5fSdhaHmJGSi3iqhpmxoUf4RsJcuHBAfLXC08Y1EKv4fj/ZxMHgaN/eMacB57H23DQL3cfKiRlH3qJ/g4M7+0iEiWXrYqwsoMrH/RgZnc4j736tQmGCGcjTiZo+wnBrKkYC/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PDP8VOCb; arc=fail smtp.client-ip=40.93.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PDP8VOCb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpxwUGq3L4WuQ63mrzrdAtw5bAqKm/jzESvwfqt1BM2n4cce5B6/dZtTK/X8vV2hXizd+DkUVBQMuNGePWH2Ayp1V+UzgqzkowXKrCvo5gIRuk/aJo9xznLSk8o3Sl7cGpxiz9nJQ1cN+ZTG48OHGqdLv8QSTiKhrCuQ1aMUKeZhd0OX+RUJ/TRMav8s3ozBBqj6OKKj/TK4QOnBUPXlR6dA9xm4PiDHx8cBpcbBGzSqE63B2vHvGiB6tthPzp8mp+YvKRYzDbZmFbMQmMU00EKr0fDrPB1yKjNz7SEx6uQlje9RM6tMW+w/eq9q3K5ZnwK6PFqkQj8l2jjsw2NACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLegYtOEXjMgltDEg/G+YRjxHtZ/JO5EahbYzDN/Mrs=;
 b=Oa2Ro20Ugfjk69yYmBm+EgCVnmJNbBG5vo1FgZLaU64p4N/OumLT4Bncs7qpQEWsZHZ6cuNJ0h8JpgX6Fi9Bw+NddUknMDDYRmx14+US/bxp+OByEpC84Pmi/qLZEmClca8oLvHMqX7cD1bfOtTAFDfbbZqXGLoNEgBDI0pjLeAqqR0x+duZx8V2CSnVA5e5oHtY8YvWMsvqMaKq04Uv8zhq0PkUkHSoZPs2YP04/mU/y4Er7vLZviA4J+0cJ1yHoVcIqp7MQB4j3qd4GyZPNQPipgZ45sXGB0RbFNbI8/HaBhWmrMe3Xov/ZatGnwNRmSYtnYKFFZVJz2d7I1FyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLegYtOEXjMgltDEg/G+YRjxHtZ/JO5EahbYzDN/Mrs=;
 b=PDP8VOCbNH8JcI1AqoKKa/j1qEaY0GUQ4ya6tMN1lHj07kL0KCTY9GaoC64kSAF6I7pqfBHd0Xdr/6SDNcN8eVsShhUkSJ66xTW51Fpc5D7tJf+BufrfgtTiP3VB5bXHWqv410yZ/OdcWYrMCwK31wrw4d2cM8K5ZALYNrFo9nMJJSY/hS/yGruQiPUDa5x6uxz8U4fKnv0P5OHVbZl/yg5c7AWzEdoFvDsHxoCaawzwDXQdjl+q/DlxQzkK7bUEbLgDJDInfHgmCv1I4tlyou2mO0cNJeJ6NF2XtZCwHc+kY/rgmL4nzpUwGOSe5lqVE6HmqR4llby3lMdelrxVGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 10:19:08 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 10:19:08 +0000
Date: Mon, 22 Jun 2026 18:19:00 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, vaslot@nvidia.com, 
	smadhavan@nvidia.com
Subject: Re: [PATCH v4 2/2] tools/testing/cxl: Enable zero sized decoder
 under hb0
Message-ID: <ajkLv7vRScdspEKV@MWDK4CY14F>
References: <20260607081345.61954-1-icheng@nvidia.com>
 <20260607081345.61954-3-icheng@nvidia.com>
 <aixM4NA7hX43Bs_y@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aixM4NA7hX43Bs_y@aschofie-mobl2.lan>
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e760eb-0188-471b-fe8c-08ded047b1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ouXOJttnJNKEN4UH2IwtWQ9zqyhoc5MJi8lIAF4TIFjjpKuhL6ZhqRFdwErtlfUyCwvYh4IBXF44KfcMsY0W7Otk2nS9ZkTcnYucGT6J8fMaMSqD8YFfn0zAzdEXXBPqkSB5411xISqg+HSDfZS68uUZ3xsQHk1veSqeA10NP0/xx7dhf8r+81jAUWfm09ENK/btKA9yCM9kwDcBhT9ez2OHetTf5vMcgNKT3+undIsdLuZ+dHlxElu2fynxWtrRfrRsNQQb73aTQXGf4N4ryOEdr3uQKtoCjBd6hQUM7/RaMc3P7dV/IWSyvMn5n1eHjJCwJtOJj1T2caS5a32qYV8ZR0NrZTlY9J4hldJ6X9x/vKPuI6RTV3YVojEgPsAOnqNvwPYNQfoU4kWlBbS612PkAoSGqWCzUeYTCw8do5JI/b9p3IBORJ2cpCCXb6EHQemtDbSyAZE50Uag5h5F7ZQw1ijGmVHJVvncZgzjS1ugY1w1oXbHyLnn4diucVME4wZNGYPnpAjbVHqad33CGTyEV6HV7xJLkv2Ooqe5UZdR7EVxIUElHo244xPbZcABrBQ1YYqk2NUOsrXunyudYAmLPnPaHMCV2JgKWTAcMKo/+LXcWjsMr/9Hm7CAuCQIWFOQDs22NT0C70rnkzOzL7xpbdBFZMlEp6IGhWDCnHc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ocmuc0tGVbLEysTfbPLtSmWT3qE+27q4k4HA2TKN2DvuQWaeVZUqNgOhRbde?=
 =?us-ascii?Q?MZB45hHJTjYM1xm3aiImZUgO/uqOcqTRn5cjEbdyPEEpoSZw5ruDMs123hyW?=
 =?us-ascii?Q?BAlSMNj76LZi4rZFXmfF0+9WkzlzafhAx5Y6Zn6+MynzvWw8afe90RJZ6z4Q?=
 =?us-ascii?Q?g38K5SEAlj6NiDtuJIw71iMJGeJCSDgYZEYdaYrkgXhYPjHjqSvnV0bRnTQN?=
 =?us-ascii?Q?nDmc7c06R6LGSZLn6J5w6aSLIJmkVQBkHEUuSi+TNV/6GCJ/gkSjZVYBfhRi?=
 =?us-ascii?Q?PiD8lZS6PQ+jrq9orVOiRQI7zUKen87hOH69vEoewHe8Yd3WnQa2lxPL5kqp?=
 =?us-ascii?Q?WP1MkTQzcLq1vDBu5ZliifbhFB20g14ZTGlIek3vJHROx5mwUCP5Vk+Hhu/W?=
 =?us-ascii?Q?lJGN/YRuOtb5y6G31bqwv9/aICtxGUu4UFZ6eL9KdjLtQLP7OoC4AI/O4jMm?=
 =?us-ascii?Q?eSUQYzSvaTPIJvDxEkg9gxxFwbTQ1zAsiKmXBbbC6ApQev6/TTN7/dlKRPxB?=
 =?us-ascii?Q?X1ffCttjKe3y4jo3oHQdjEZS9T2CNThFrm+B3VPsYf5tEqjQltD9Nw/m/0fG?=
 =?us-ascii?Q?imrKov5cnZKSHyJD2F/GRUPWmJgQh/S3nGiQWjR/gouyTzsdz614qY1brBU1?=
 =?us-ascii?Q?ffmigR/e10JvPOXB5jEkN0Y+3/06a0AWlQsMIMhdsiI3lr9zUmnQFJMy31zQ?=
 =?us-ascii?Q?gVROWma5Ee46fQTD/GSOFPBMPGePK5NnF8gExyVus6//9RRxZ3dXUVVwsNa1?=
 =?us-ascii?Q?MaiiLpyvaM1TfEGLI/BzyOsdtO9sDjR5O3c8WLLaBzwpoU0ZS9Y0neh4DSgL?=
 =?us-ascii?Q?j+A05ij6ZhDG64dPiiew7kwJcJKJdFwYokudJWA4WwT6qLZ8L+UWsc7MhktS?=
 =?us-ascii?Q?YqMPQB9TqJfkU4Z0MsU/DZS8pAyreBLwXUV7lelSeh5TSFBprLBjC8Eoza2n?=
 =?us-ascii?Q?F7TGoBbhNAls7MWjY2OFZdF++5bcFKIQb42j19OQIvh8/EM1JhX6UlUg1IgR?=
 =?us-ascii?Q?0qxRE0C2PzhETNyKOX3wxFeVRzVsuKW4iAPIQ0V/B7SbvDufuzva4pBscEox?=
 =?us-ascii?Q?/e2Quv4Pg+oJlX80oYuGYlHQqTHKPD2cTdR/sT3TTpQuEzfNZarMPyj7zER1?=
 =?us-ascii?Q?0BHTiz43YOgpp6c3kcKpQ1m3Vj06nt3sev8t4NSA4hAbFvhgMuq5Z/4V9rx0?=
 =?us-ascii?Q?7UpptkQv6LCI2DpKhsd+0nqRNrIH+nigW7iKi033/mG71txsTVjKSSDchhJw?=
 =?us-ascii?Q?YMsm8gvZgEj4hMaiuAk16MFfhcKvHrRyp37NxCSKHrPxUG8KpHrdltUYYkE3?=
 =?us-ascii?Q?nx+I4/ag4ETYdpB/OA7gzcDkfzMhKjfnhJpvWENQEYDl7Bsr8+LH+VnpjS7m?=
 =?us-ascii?Q?VweFmQXhrLb3MTkgfiTG4CEsfp0vnR8KgMtQhUDpVbgdpm9yZa/nfiuHn0b7?=
 =?us-ascii?Q?CONPHG8tFeycHb/X7OiB9WApYzILSO1qPnBuae5QU/nnV43mtx0eIKGsDx7J?=
 =?us-ascii?Q?CG2iGgQf07Ffg0ZhdEDd+FlNlgDwyoikhX2plnXcWslueXH0E1V1q33XA9uG?=
 =?us-ascii?Q?U5ZWGXtJ3bWtXj7D+j7C5POVIq+aMyHg2rxSG/gCTz2QyP9eM3oL1BvjDuDv?=
 =?us-ascii?Q?DLhBbNuv952UcQ8Jsx9e4kCUhAMSDKl7+my0mPKycBCnevtGc3ulvgZeiZ1q?=
 =?us-ascii?Q?5SgbVyIkcPt1RY1wHXOm3C/R1drsFB4CuajeX/euY++ukfs3YDbYzBk060Jf?=
 =?us-ascii?Q?9dHUWtkHmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e760eb-0188-471b-fe8c-08ded047b1b6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:19:08.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7Tu02WREtqAumRJcnvifUsPdLZ/73eeCjCT7IV7ys+1y2PxgnmrmRHML+Q7DqBSRRJwVK3LGpeRQUjYmi/bvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356

On Fri, Jun 12, 2026 at 11:16:00AM +0800, Alison Schofield wrote:
> On Sun, Jun 07, 2026 at 04:13:45PM +0800, Richard Cheng wrote:
> > The kernel now allows committed HDM decoders of zero size so BIOS can
> > burn slots with LOCK; cxl_test needs to exercise that path.
> > 
> > Add a mock_zero_size_decoders module parameter (default off). When set,
> > the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4) commit
> > decoders 1 and 2 as zero-size + locked above the decoder[0] auto-region,
> > mirrored on the parent switch and host bridge. commit_end then lands on a
> > decoder with no DPA resource, exercising the new enumeration and
> > poison-by-endpoint paths.
> > 
> > Gating keeps the default topology, shared by the rest of the cxl suite,
> > unchanged.
> 
> Can you add a unit test case for this?  I think it makes sense in
> cxl-topology.sh. Perhaps before or after the work on the default
> cxl-test topology, load this new topo up and validate the zero size
> decoders are as expected.
>

Hi Alison,

No problem for that, but I want to make sure you are talking about
adding test in ndctl right?

I'll send v5 within this week, want to make sure they are ready
together.

Best regards,
Richard Cheng. 
