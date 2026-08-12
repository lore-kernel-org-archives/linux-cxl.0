Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D4418A5D
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528145; cv=fail; b=GAhlVYdvIQRNX7azRNlKNJ91YH/li9ZmInHdERO47DhxXHIUUPn+xfLi7Oa1ZxLkowu1660eyaa4WcidlY1RzJoBbLHyDJSvU9PU6HjudsznwSRmN6PB/EII6+zzRhpulZwNJPXrvsKFMg+E25mSsBe4ERiPeASSVeYt8JEeZUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528145; c=relaxed/simple;
	bh=oNjlDTSE3VRZJaI7pXdEUMWuY1BaMpxi2mHIaD4YaVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Im9beJmH3aSDArNfwIyWZ9gmoEs0g/ykLyzv7TFuKGZe36JMY1ED+OHopFJJGbBP+kr0XdyYO7Q1brwuF3n2iOCgZhFP82Bwasq+ZQv2jU8/WApwnzJwzC/LjbySL3ZoKeXcU3wYNEQfrc6NJDK+1xkG3916l0xPk305S4Q49ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F9qKaQL6; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F9qKaQL6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtGnlq3vGmS69nbE7QJLu3ibYm2QBmPJ3fSCcg42FtNx8IH4dXwNAUe7wkpLyAVFG1u80dhAf2wzjPowhLEX64JopF0f7zYj0m5HYD1lskm2m0LvzOdntfvIL3W3Jms1k42EmcAvvaksWzMZ7AIjhlmeCfzN5rxijDIrur+mDDjPjy3H5VIYjUT5iCKggBdreNwuO3jBlUwS/RrjxKw/n+mo3qD232MhXq31qb8JSNQtvYStPUX65CasXo7Y1EAcoGSRYp52rq7jagNXdKoeTLUskPpSBiWItYg/IIevMv2HIbFD/Ao0LEzrCzZ1ACoeYoGaTzV3tPEd0l9/S6xoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIk3VejUzW5HqZU80dccvFFWOtWJfbMZcTLjlBu65hA=;
 b=LA5XVbMZehD595VHZ4Jls87g6DaHgSgkqtTm4rhe7/+9UxLk5Wd+WHoHODhGywMH6KYszwstgA+Jo5cN1cvmcDraqhowF6xAyTpp1qnyQ1753BCHBE8P73TDSjm1dgXzFfb4zeYQen4opdugNZWNvfem+LqwvPt+1rVD1O3+20N3nVJV64wDVUWJ/XD4dZ4l/L4FvjcfDdTPd/IIt14CWz0UeVpQ20hI81TXWDna4jGouGa5la1saMyszsHTZSkK6So/bxP/nCKp7HoU1Sbsu1DPpDQ5Nlge4X5tfNq5DLtDtYWkODe0BtK9B8xHoSinNegOtMlOXBqr5Z5UvJuKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIk3VejUzW5HqZU80dccvFFWOtWJfbMZcTLjlBu65hA=;
 b=F9qKaQL66XhtnuiRoiCv2yjqXSX9/Cvt8b3IpP81YtOJkSUNHbR4uNMIi4WhzlmAd1Kvyy6EYIMWAZEZjhG6naA+qkACW2nWKw5eJ5qvDM6lqTxw/LCn3aD6UkGJGa5Fi7p0JmIuv9+LNkSVc/6JsUcJS6yuk56QxGXQzRAK4soxn8C45EDFNZXZiuvemxNgSqYwqmd1R65HcO88Zi9hrlmojycWH3KPr7l9KeEOCSsMwkFrHzZLRiAbgCtuKsETH+mzTXk6rMM5+QVFar4cRW8xmfbkadJrBkBIQkzS45RnYw4v3sDrWNSCoZ43FS4LQzKhWkPXm+0lRcnO5gKXAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SAVPR12MB999168.namprd12.prod.outlook.com (2603:10b6:806:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 09:49:00 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 09:49:00 +0000
Date: Wed, 12 Aug 2026 17:48:53 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 0/2] cxl: Fix uninitialized access coordinates
Message-ID: <anxBWk7E1FOA6P2c@MWDK4CY14F>
References: <20260812083035.372308-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812083035.372308-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SAVPR12MB999168:EE_
X-MS-Office365-Filtering-Correlation-Id: d6354d9e-9556-4dc6-3469-08def856ef38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	E/SIwvBUWbOhekrdjv/43Q/06Egf13XFnTBdTqvo0JhUgfd8VRzBFm5w0+EgO7jTPxwt+T6vk9K26U5tB+wEbhHnUzM+GCig09OOeZe58xQ6Y/gu5FgZ6p/9Uoow++xkxdWcgY7Q+/7USAho3n+gchiC1it6F1zKXJx+NDFt51rycS5fLPcp2A1ls8661CVZKeEjMJBrUEPRekAENBR1okMBF2cbX6OnHacC1AkVEUOvI4AF6XM76e3CY+lR6zWnEiwIu3w5+VznCvN52uT9tvpQZ6WEINFFCuxmxQRIkJBv/fmwIkiHclwrlBONoahh5pvVbjyHDQK/lFJ1gVDJklyTbgQt7ZD5BdMWsPHNnlXdSO3fDrWj7c1c5dPcSYc80sc5T0a8CNAHr1EIh4CURW4gcFCc8XX1kb2zchhCY4G7s9MfyOKhjWfoFjBWaORNct7fK984CNjKVt87TJ2S9pszSeR/FPFwlAOZTedcJzV0Ph23yEERQ5WLFNNXH561HxluAizKdqWFJR7gOrYwHWiiq5ToJ8wjU04+ORFK5uNIBcTf9u6MmQ2gbg89S9t5RvAoROzbOaX+unM3ZqwZzTFHVTk+KLN0S+TXnpfNafqWT2e+EkhHnK07I69XFSujZDdpJicbwFDbplNrZuyHxuQnW7kWBdamg9iBwbhU6fY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lb7iMZop6Z5VrnQ52yQwFYU29QnfO4vdccXLBtbdWM41xy7WJT2a1NrpsNdj?=
 =?us-ascii?Q?RxePVwIBCsKrjBqjMZwov8ai6iMb0vz46bqFa3n/FPuy0oEGfRtxYo9G085x?=
 =?us-ascii?Q?W7eXqBB1lBn6GVJOWIzg9ydUlPakY0X2QIg/SppAZ3+7RE04CGzr2dYcPNZ5?=
 =?us-ascii?Q?7OD/sT+PhRnXNRQl/KQRgALD6DzBm8lYCbdVZZsaexJ9oj4sTLJVNvYc7f6B?=
 =?us-ascii?Q?HoWZRsto5VEwE4fjbQ0lkswJrBWEjn5FruetKWju/IHNEt8GMBcuf1BZtwWY?=
 =?us-ascii?Q?C6rIM/mQhRP7CreAXh5IJyavUupNnHYcaSCSnVFinWXmhYBfvQzrysYpahGj?=
 =?us-ascii?Q?bFGe6v+ouPB5i//g6Y6BZSnp+qtjHWKCJzonP1AuXpHUauL4eYcPYsBB3v1u?=
 =?us-ascii?Q?ITfAJaxnebGfCw1guIqL39JkSTKsXvutJ61NqZ0jofdRLmfWSH/MTkJATEpv?=
 =?us-ascii?Q?+7MR39CvwWJWEmBjYKDc+rN8aJGBAkenA2QEPFbjfq72MEd07g19kCR4GvDi?=
 =?us-ascii?Q?mt9wrAxucqcJq5S9pxCYJL0krGWZtYDAsFbna3dYmwKpLa/wups67gwBXE6c?=
 =?us-ascii?Q?DBHsFvB6ADSLaee9GplvG7/2tq/9YTEv2RDApgDuAXRUNkFm4VObMIJSjcO+?=
 =?us-ascii?Q?h7xCZFNRU0JcrxrvFz/dc6Y7nbqjacgpjKDnH274eTu5lSGkcHrPwLN+D+Ls?=
 =?us-ascii?Q?g+k73S/1RXn0Ah7HHMPS8wgF582rfgmfCWrUeIgBah07y2B0I29i2hP+bbNr?=
 =?us-ascii?Q?OsxhOc0v9aMJ0mYRRd34uu+JDJl/9y6pov1ItmS9klAnBn7tti9d/1zhMJDn?=
 =?us-ascii?Q?GqOAnk3gtFWWx8EEys09/YZ66TtsT+t2Prz8Mfft2K5apClZxY1YVUyGhGt+?=
 =?us-ascii?Q?IYpIaFJ3KZV/iT7MmAYd0JOtA9FsE9sX5S8V52RigxA1ebpfai+AQ7YfEZq2?=
 =?us-ascii?Q?uGIBkU5raW3iVIrSZN1QAV9L56b7YHajaM+j0LiJrECrbSYvZjFmEGMmTwMi?=
 =?us-ascii?Q?0ArUja4KwL6TEpanm5idr5NwDy/xsz54crQRAVwqCBm0rxCwxx591wbTk5c5?=
 =?us-ascii?Q?bfwb+DkGdKvoZh4A8zFpdpwJ8HP1qWI+KhBZnypE5HPTFNYdXFF76EL5T1zN?=
 =?us-ascii?Q?yWZoqNi3ZPZO9F4+txzOalsKIbUg2fvsdo/xxIMNFNvnQ3KYUq1Y1G1aKtv1?=
 =?us-ascii?Q?Rt2eXpX4SvxQX8wecZPQKIqqeQNn4/KZIS7LzBOhP48gZgZAth/50gfhF0Rl?=
 =?us-ascii?Q?UwPyOTTje50E0CmGHlTjlJz/cit9UFzDeqxeIuQ11qCRVdQGye6WGqppwu7s?=
 =?us-ascii?Q?g/XPsJ2oI4IbD3+IES3rCkjFZbiD567rruVBLIKZkqssKcfLjLomZ8TRQMo2?=
 =?us-ascii?Q?BBr1oZcp0R7NdbeCJad/enhd51nyVucKJL7qinljwXjtNHKTfbeK+jiXAGKS?=
 =?us-ascii?Q?MaKrPsu1RjvK7TbeSTQBEQ0cLYWcW6PXp8E/9Dus7BFLi/br1byvYg9/LfJa?=
 =?us-ascii?Q?ulm9LUS7MgUn0OqHglX6d6M7snai9KDOEUFWoLnr+nL1hvM99Bn/7LH6QyMG?=
 =?us-ascii?Q?f0sZORWLdSAuYG90pjBFM+epRne781LXPluLr6hvZjy+d10OzPz5PsU3eIe+?=
 =?us-ascii?Q?NP3YLR6vH9No1thoMScQkxqM6XtEbVs6oVactgbkUyLp2yk4WPF3EiW59n6Y?=
 =?us-ascii?Q?PMT+2QhqylEFHBt40YEhXP5aheRqT36z6zSq4ukjjOZSEI2NUhmr26dBFHvA?=
 =?us-ascii?Q?9LmvrUjI3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6354d9e-9556-4dc6-3469-08def856ef38
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 09:49:00.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 134Ow6fntIy4XskJV8VmS7uQGOpXKBDMZkRfYFk3Kx1hZT+WjB/zVmbSquyww+R8+VZ0Fp1UJwh9TijV7eWTLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999168

On Wed, Aug 12, 2026 at 04:30:33PM +0800, Guixin Liu wrote:
> Two related fixes for stack access_coordinate arrays that are read before
> anything writes them, both reachable on real topologies and both ending up
> in userspace through the access coordinate sysfs attributes.
> 
> Patch 1 is the v2 cdat fix [1] with one more site covered: the coords array
> in cxl_switch_gather_bandwidth() has the same defect as the three arrays in
> cxl_endpoint_gather_bandwidth().
> 
> Patch 2 is new. cxl_endpoint_get_perf_coordinates() returns 0 for an RCD
> without writing the caller's array at all, so cxl_port_perf_data_calculate()
> combines stack residue with the values parsed from the RCD's CDAT.
> 
> Both were pointed out by the Sashiko review bot on the v2 posting of patch 1.
> The third finding in that review - cxl_coordinates_combine() aliasing its
> output onto an input and leaving a member alone when an input bandwidth is
> zero - is the intended "not reported" behaviour and is not addressed here.
>

Hi Guixin,

Thanks for this, both changes LGTM.

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng.

> [1] https://lore.kernel.org/linux-cxl/20260812060912.54932-1-kanie@linux.alibaba.com/
> 
> v2->v3:
> - also zero initialize coords in cxl_switch_gather_bandwidth(), same defect
>   in the sibling gather path (Sashiko bot)
> - new patch 2: clear the output coordinates on the RCD path of
>   cxl_endpoint_get_perf_coordinates(), which currently returns success
>   without writing them (Sashiko bot)
> - drop "endpoint" from the patch 1 subject, it now covers both gather paths
> 
> v1->v2:
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>   the code change (Alison Schofield)
> 
> Guixin Liu (2):
>   cxl/cdat: Fix uninitialized stack use in bandwidth gathering
>   cxl/port: Fix uninitialized coordinates reported for RCDs
> 
>  drivers/cxl/core/cdat.c | 8 ++++----
>  drivers/cxl/core/port.c | 4 +++-
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> -- 
> 2.43.7
> 
> 
