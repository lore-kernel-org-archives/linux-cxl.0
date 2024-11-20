Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8192F2A
	for <linux-cxl@vger.kernel.org>; Wed, 20 Nov 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732125145; cv=fail; b=YyTTtZScSgVJJYPSvh8bWZZCU7WcgYQKB5Td/QEiNKiOu/4018bSBRTmxldMnuvyuIeO6rng7QkjZFHEZCvHCX2xo8bqlyXorslDcVVsNVQUqlOAVl4b0pekEG3UGeLouuKVyrPK1iu4V+RdDCxHn4Kuo4BgGUukCAga3zCKVTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732125145; c=relaxed/simple;
	bh=HzpZsxP42fqnJkafIdUuIwq0IQ6zd5d3OmpLLrEHhZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NNZw+rVjaQWYGGV9q7chrSUp7AKxNgAryrGSnCQP/TI4FxOo8P6lWZ8AsM9eanSqdpPb8gPPL3yxn1r75jtkiYdgfPD6CWj9sqv6XHqohEwfaQyQVYhk1psVQ62ioflN6jihBtiHqeS4MiDnh2jpJ6BwUjDoG7gZVBY/W2Fk+xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=biFdYK+O; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="biFdYK+O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg6owTjrd/drrmgh6WTgqUbZ7qowxt+j0p+qWmlvXm+04YS78tc+jNofBGBMzCzWI9cVNoxjuVN8PjbjS9sxQxPpXqSUf1HIq3XZxOd7nCTgJ/e6QVLlwazmfpJmKLdSWUcBYNm/ehmJuJXodWgGrQLqMb4SDS8pW/fEhImDjclaK9sTA9TMYKuNO3b+61ajoXeXJsXzpdYD5OyVDwR4Jcu+iDnOV5+puQ8LC0n3sUlQjDuzhIziCbSkLVLu5M1cUbd94HlVamWMpMlEHP/+80ZcNdaT6VK9HdVyu7tmtGuEe8yvO1wcGaBHhtXpUW6kMZNxfiYgbRBOf83gFXiKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Mh0OshI24RVjLnOejswxaXkeaIZU5NU3C3/A31eRac=;
 b=b5Bv5O1bMdeqmKirmFfw4auwkXQM49CxvGwQzGru3/SdLGG18ZuzOz+fac8lMFHv5ePt01xSOeDHB24zNA+zdEN4OJzGbXqAkXXlpFwX2+W6nggLZHzwynuvfq9tTyIAHgqdeSl7nIDAeF4rS1Wo0kIJz+CTUAi/eBtSrNpj6zSLxzoJbMEayOc9lS/tp1T88ILkjnQ+2f8hwDYMb5qPwyIJJQRKORezfzpsbref/QlfUbxmdcWl0jlemODowR6sxXy3flnJlimOo//abEVAXpQb6ejOlWW6Y4//uJ748ZO/JXKLV5plfxFRa034LO0BjLiVEKuXXm6pqYDmARh7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Mh0OshI24RVjLnOejswxaXkeaIZU5NU3C3/A31eRac=;
 b=biFdYK+OodKi9ixvEqXBh2a4WzGafOCNsmpsUc1c3UvF8WTcWCHXNwGR76JYO8hq18x9nEMTXU51smQM/cL26KrFiVH/rQHrUYCkFavxLIXg4CEOVPscNa3ZzZvWXJOv09BoZk2OFcHma5yJ9IaH/R1oBj+jaOuy56sTxva2OJ6lkVrm3TSUbTSqkklo75PwPql1pjHaR37viHgSHa7fdIkBcpIPzMPmehqMXx0NqkNWGI8cdIAMabHDF/SALZZ/dbk+t15/CjkyRgzsISBqOhzUc4VJIFgJQtwcimnqgw4sFIocRUvbd3OJgSOAYERQDUw2G8eOkxM1bpv9At8zIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 17:52:14 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 17:52:14 +0000
Date: Wed, 20 Nov 2024 13:52:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH v2 19/20] fwctl: Move fwctl documentation to its own
 directory
Message-ID: <20241120175213.GA876522@nvidia.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-20-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-20-dave.jiang@intel.com>
X-ClientProxiedBy: BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab89276-6d03-47c4-14b4-08dd098c10c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G5T9KCCc9WkowCuQ7mBSeIBs9qFficqGbuVI8XhtB8gsqy+l45n3CsHSXXmh?=
 =?us-ascii?Q?p4r8VzCx0g47e7PkPJjP/FozrOiHcyUAmpqtgLDQSVj+38QYHvNpy2KHwIUP?=
 =?us-ascii?Q?+ltdlXsKkN+RLkBrkbhjt1N3sVdK2VPar8JqhL3a9R8CtFNn/I1YLNbvF1Xz?=
 =?us-ascii?Q?7Hx60FVLBKO+RqlEodVuAy/eSZNTHD9pvhwoEMBcm6UTXcO4tv2Wbh6GIxcq?=
 =?us-ascii?Q?PUnEP/YK2u9XB5fHExmZsCrQjKRJZzt5wmF9nKboZw8zOydr/j80vtwrzJBh?=
 =?us-ascii?Q?gxDsGMrkG589RgeqKuef8tbQ7+a5OyyAuAfmPXCqnVtzBlfYsV5bFikIz1wf?=
 =?us-ascii?Q?srtaNAXZ48Hz0jdC/9OQkRkJ5u4I8SmXbUbPj2FN3ieiUTuDgaSaVcRySywK?=
 =?us-ascii?Q?V5jKtsPRGFMGdgY0obvEq/UiRqDcmhXCMLBvIDhHX9LUEE5W472GTV6E2r13?=
 =?us-ascii?Q?UdgwmnHLDpiKoGBeUmOsLBEywo2O+AmOv2S891xF/nGHfPrxJj70YgZcl/jV?=
 =?us-ascii?Q?Lxl4VxNBt0tS0rn9hq4HExuQB07xtb6FC43ZZqGgiqKCdIVCDo+M9b13MOJQ?=
 =?us-ascii?Q?A6xTAb5Q8/H9SrNKqdVorh8URM4VGl4LjlYc3V4svC5FB8zXznV6vVJndHcX?=
 =?us-ascii?Q?zl33fg9KcahVaI6GXxLTQTDxSevKhvTEyMi/NMBRyL+Lx+Ncr4sxP5RiEESY?=
 =?us-ascii?Q?X7VYOoNVCxE5oQe8pM11W7XwuStEy/w/rC0QuvjO/h+drOoYV4Zuq87cnTeX?=
 =?us-ascii?Q?+++mEpqd8zzQ2s7ARAo5MdZWUEJUg32asPvi1HLIbje7XJk5pQLtrA9LFIqV?=
 =?us-ascii?Q?gLYulgpRQuldTbMjc71Oh4q2CuoT+qKgwObYE4v7fibDei7wNXU6aLu5Qnys?=
 =?us-ascii?Q?hFKINVMFtRLQcBvpFAq5p/4gCxXG3lpVE6lfVgPZW8HV6DCp3p1HJ3IYLJbD?=
 =?us-ascii?Q?XWoaSc7QIMRF3IDKyguizsAsdqVRzY3RtyHarST5YziZ2bpWDpC+f4CPy5Dv?=
 =?us-ascii?Q?DxBoyn+chPpT7TVdrFXV4TVPQMm6u0xiAUg9Zbp7yONzkxayrmlVp+GlBk7D?=
 =?us-ascii?Q?lyBskXD+Mi0mo+slZbA3cQN+h2CM1HvS3XZt7BecXk8zbGWe0TvUK8BRQ84b?=
 =?us-ascii?Q?RIQTblX6pUBDbxD+n0tO+PyEFGOj9xG3yBwCYnm7t//HMhM3kgobowzFyjYb?=
 =?us-ascii?Q?jP0ur/CG8HDyEhONADVozzB+fK4I/eDSyrdBXxre9dVqM3gJorC3hM7r5Yj9?=
 =?us-ascii?Q?gKZUPUNvUb14Ex60lJY54JyLl7z1rqb/H4B83ReTYtQh2Ptnj82VUTyux9Yd?=
 =?us-ascii?Q?ArEnpUmYhK/okeQT/iWMxIOM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q0W8FJXXPvnyXt08ccVlt5+0aZz3P+wu45vvd/T8mTFNfiWYow0UuQZDMCvr?=
 =?us-ascii?Q?GJw9ntMiqRZQsczArVi3meZex22X/pX9e3kKgE2rSSshsD26C4Z6pxcIHtOi?=
 =?us-ascii?Q?oHkvy1f4scGKHN2Z+FkyLlzpbAzvgQ6gLCVrQ6m0ovHf7QmYZvx8TZm8fh+O?=
 =?us-ascii?Q?t83pxLX9HE40/2x/lUkZgR2BfgTtKxUWXMKWW4bPQHylcAPhXfmVbCqZ7Pkt?=
 =?us-ascii?Q?ZZUskjQ8iOdAUnC1YHc2stmY1nGftQsa5LAu/OP/o/kiMmJzHDv+eyb+XzAk?=
 =?us-ascii?Q?KfFpsfZttc/VsQ/RD2ZnWDye2i5fNQlvP5XNkKH895s4zNSltXRAGCcdLC6P?=
 =?us-ascii?Q?pWuDftHQGKcQgXD0egyFaL8MNKeyNKeBPQCHtk2GMyK7fjF1SDjB/KpJcG1G?=
 =?us-ascii?Q?OcOUYQOKyX2GTFPlDk0kFIs98UaJOo6rIWNuDM8TTTdVhLA9+GrmEy9/kQfh?=
 =?us-ascii?Q?XzfFw72mgxo8g7eLBg5heS8oojfuiifwmCU8OvccnOV4JByaveGA7SztcTvz?=
 =?us-ascii?Q?7iBlQYhVvJgtUn1uOJEZDhEnRjsn2SXNW8cWxgnye+vXppfj2bEYMEYeO2M7?=
 =?us-ascii?Q?A+mSEbvIOjT0m42xNELIiTZ7PliWb6L/HNXMX8QVGg0uEZmGMvYCpApWeNdN?=
 =?us-ascii?Q?ZnoOAutHzkkpzho3EUTuIS4AyS3/jU1gLrPinmj/CzM1ibxhBFw/TRKTTNoQ?=
 =?us-ascii?Q?RZ8PRL11hPhnV7zluLLywU9FPrSDbiDTCkBuRNiX01H6zcT685w9NobUi3Yd?=
 =?us-ascii?Q?srDs14iDXUQRqwji7/ZxZfkRRdpH7m+3hCYMGdXRWgZC5675QISLA71+VEjN?=
 =?us-ascii?Q?Qh+yTvbg/FsLIoHrHvukf/c9lMsC8CIqIL8OUC1vW3kWXiKrr154HGhYDKUj?=
 =?us-ascii?Q?DukxV8s7wyoBLmtkyC5hkckgubHe++SYoVgr2uStKAmIS2vir33fhCJkAS3m?=
 =?us-ascii?Q?AxStqa/tltVceARbxXAbsc5kBsmltS5sBSVXtCwgnOd4wBcxXV86yH9p2qqs?=
 =?us-ascii?Q?u7ZXO5RpmNRZ6vFIa+YyViaXrl5WJoYRalbriHWh4z7qG3OILcUpuaeMRqXq?=
 =?us-ascii?Q?Hr3TN2m+/LmhGx1yGxUVa+P6aGZhfRFxLFJGRtPRvGa3+y1RC5ZuxosGvrhh?=
 =?us-ascii?Q?W2bzLkn+5/uvFcm34M5YUe0UOZ+naCitXka/2fhXrs4/c9CS/b9BUjiq/DZt?=
 =?us-ascii?Q?JFHNc1xj64chGFL5HnrydIqeRotpEZ4Xtv/HqhQt75TgcKYGM+u+UAAkl4Jf?=
 =?us-ascii?Q?bTVbXDd7nO7iK1cIHrC0aogpYVlGdPwGLc+4qWEKBWL1G1uymcahJhINOEds?=
 =?us-ascii?Q?aSmI9mlA8v8A4yXkNOG2K3SB4gq9n8HDjypFJPhHY7MDmRdm2h7y60UYkABx?=
 =?us-ascii?Q?kswwWQHLWlEYoAiSRCObefG8tBDBRV9iWXYQynqnRgF1nEmWcfo6nSAJz2nx?=
 =?us-ascii?Q?JJRlDdIFAQdK7jkI/tjNqQBlnUGfYPpGfTFCXZcg/jIfjKZcL95R8UdbH/mF?=
 =?us-ascii?Q?S+iWSiBqbamr124m+RxMEZ/79cO5DKrJ9z2+HBpPv64fk4DGMLkfKsBD8fgs?=
 =?us-ascii?Q?250Zhuo/Hv3VMhQqJlJMl6uWwrDVh7bjx6xin2BX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab89276-6d03-47c4-14b4-08dd098c10c4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 17:52:13.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKX4l7P1Adqyhk68BK6LiML786Wun+XRkrXuYb7rE6hV25PobGETBuNki9gOvP1t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344

On Fri, Nov 15, 2024 at 02:25:52PM -0700, Dave Jiang wrote:
> Move fwctl.rst to its own directory in prepraration for adding more
> documentation.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

I folded this into my tree

Thanks,
Jason
