Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C52080F6
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403446; cv=fail; b=u0fc+sqoSpCOxUt77Y1F5chYtt2qQVSqpiMcvwL61cc6yMvYrxGsLrZIEJmFQYE2HB+BwNWq2fLSSzDMvlaRslDJdTG5p7jPlfVzJ5VTWKLCtNXbmWQgvFiL55TCFt67wxHoo7t9vvaMHlgSdUHgwd0lurk+84x/SxlitaREeFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403446; c=relaxed/simple;
	bh=IdpNUspA4GQBDtQzi/e1wdk1YKhI/vdpmh3jAnEoINs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DbVhOT1gC6iWNzYuuCKjp+wzg1ZikK98Z4ChBr0sUKRw1UHGETwnmTPZsn60mbWuCYcfdJwKTtWNLLHvWOSn0P3JuAg1uHHBHqus7bMRhsmqOCb/bTFuSG7radj//TRHxcGOwsRqrn2J4ZHsMmdZrS7qo1iU/Pha7m5Hjne5W40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kisj4sHn; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kisj4sHn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVcx7A/wNlk8xBfLTjguOewARN/J+ftDz2ui1vNK53WUbGGLannG3TlZihybhQj7qZ7MLjPfmm46DDfG0nhGzq1vr4rCYBUqAbH0dYRXYVSILurwJwzHUjRNx7+ZeTDESj/s1t9qF1uEhdK2OOuVvjhvthhkIx/+ite/5xiDeZKOojKr55uD1DzNSXrBkhuHtUPpZ9QwSfK4hR1Las22Ef0+F21sIx0vaWHiAS6LLegWflcaw74uIA98j5koPQzbzV4AjfqN9wMLKxYUyerQ0RY4+1nGjipofjQFvgc4zRp9LLxbPJhlEECyZGSHUgp78Lyx+mJs96tCGdrh7osF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+nuf3oaPka7yIEr5/+khWFRIKFKz+iE2+sH/3I6ITo=;
 b=zQULdK5VST9xWFbEOL5paWqNtWEcV7ZKLQmNIbcqcOf5GMDFPKlS2ZiYehDOPMqPvmi55qQJYbqvPzKw+dn66aqYNEF/eKVul7VtT77NEz80G16V1gF0K7XFeqxdaOXaSD/3jxjBGsM0Xjuw3T+C2vKY4EWbkpx1ZdBU/Ixo/Gw4e4n/quDWeWeOvebhNv76MHdFAPvfRY1LWpXluYdol4/xwX7+6H7MjtHmuqvQ4yGpUdIo6kqISHfIkOt1qYP1tyH9FM+30hWoh4J47CdnCnROCLlFgbv0Isvy1UIoVLFcrNrnAw8r5LFf7tCJRAlvAxKtM3lVpErybe61trIt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+nuf3oaPka7yIEr5/+khWFRIKFKz+iE2+sH/3I6ITo=;
 b=Kisj4sHn/8EyQ72W5sqH1k2hO6/XF8cqNqsIFrxUU5QkgxaKNxwAP5V0l+Ml/nGtkRD15zoKZ9u1ZTXAjWX5aakakBPg6fLA46k4sSDZnViAxCoUmbnUX8YSL533NmLGC32lycL4y81BHjPqzvBibQrTVFOWo6cEH1aMe+8xNuI2b2bVC+suatpIBvoJjwd659554vVOZan3ZgvrTXXY/Vd2I+YhO/Mka63EDMnatOp5yrCpScruHDMQHLXe3gxoUvgfr45Z0KbaZ6H98rMjPafWssSF+gEcmkNIN4+kbI2owKOu7Ca6lcsEN3AW3dFF67ldFnM3/9RoJmvKBSE0Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 23:37:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 23:37:20 +0000
Date: Wed, 12 Feb 2025 19:37:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [PATCH v5 10/15] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <20250212233719.GW3754072@nvidia.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-11-dave.jiang@intel.com>
 <20250212175534.000035d5@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212175534.000035d5@huawei.com>
X-ClientProxiedBy: BN0PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:408:143::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfe9b78-40b1-45bb-e300-08dd4bbe3196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4X6Ws+ufmR4Jqj0VEowUQnpF99Rv5252MSfMjB3JKmTa/GYfavTYNdEgEhrT?=
 =?us-ascii?Q?0wFQul71lcG58TEFL+F2eW0YUYXL+dhisgRTaUqxfJjO/5W7Jo7F6zUiyHAl?=
 =?us-ascii?Q?IBQnUUxgS7i+RwuoDMiGDb+zpjgk5HkcQyqPWJ/6GLzMkZHadYyzg1X3NhR9?=
 =?us-ascii?Q?XZ1KM0GU+y51U1smnwdF8kyVI9RPAUlzXZb6yC0OwOI4HXpJ61eyTf14FN7f?=
 =?us-ascii?Q?GDGUAZbeLyYSElcjU7JlOAuplhW8n5ZapdMFEjSxJpwj8dePzhcwopfr9U3H?=
 =?us-ascii?Q?pzujwZKZTfqPoe6tKIQh5jksq/u0++O1b2rg3/VCBYpygns5LudPF1R4A0qE?=
 =?us-ascii?Q?gs+3l2KY2edzR8DAytKyoLpAEH1D4Pr7ncAebqELjd8OXvqLlchUM4Z4Seyl?=
 =?us-ascii?Q?1xUB/M4zKsRTQ+5XUUitMxpCso0w8NuSXGDfu0QX4a9/7iPmm43gj1Ycvrt7?=
 =?us-ascii?Q?USskhwyV3Us9EE13yH6mxFTpYYFGLQcrivco6Ju3/y1TdTGc5wGQk9Cfww68?=
 =?us-ascii?Q?mN6jGn6ibneY3mJeFcegzLhX0VlZ3sQ5GjSV4YTwqK+5egl+YX6ncYYLmgrf?=
 =?us-ascii?Q?h4iL7YzIz6Cvddrp8aq9gYLXia6mZfgqvKWQ0lrUQuHFi1ghF8gEcrAJCdhC?=
 =?us-ascii?Q?c5Wsm7e+aH97irmAoWnQGrw6uv6dWM0t1pb9PfpyUm44w6/c3XyoQ7h/uXyD?=
 =?us-ascii?Q?eRO0ydDMhNCUAABhQ9novZSaREwxUQ8ixF31/nEXn3f8kiSLa+0FLe/kbCqs?=
 =?us-ascii?Q?y68P0bJZHwpgeQvqu/VQ+UeKzl7Aew/GzZ65r+38evAa9VIJf2PFQBWb1ahF?=
 =?us-ascii?Q?C1k9nu4KmIPOC3mRPZpQcphuvimb5xI1Bb+Yv2arjjD82BtIdX6/sWqaH9xa?=
 =?us-ascii?Q?C5Fr27eRUlJH5n0Taov13ZnUukZ1ve0ER1dxdk7rjKUvlfbJk1dZOG7BvoOF?=
 =?us-ascii?Q?nJIQUKrIB+BqcHwCPhsat1McadiGImlGrlZVf/JczWWux4ERZoSrYoz8RLey?=
 =?us-ascii?Q?Gqv/rWR0AeM6s6s1LibUVKa25SEmfpQxLPCatKH2iSH9GGUkUdF8xMggr329?=
 =?us-ascii?Q?OiX9i0vdbizwmngi+kpttWimjB/JAHgNY/ZMtBSA15Q0wpLwXF3oHkTs10ds?=
 =?us-ascii?Q?FB+heaVX6Eol8ZdcNFDcHM/hn072JzK2E/Kg9+XQqevSQnBfQk5HaT9VDGGC?=
 =?us-ascii?Q?eWlDfYM0r3tjMcAckZkHvJY4XDaIAYWdZjrY0LQCximq3W24isN0UuVJWfHN?=
 =?us-ascii?Q?XY7F1BuhnJ2VluPtxpBXsFR822hELMVM6l1F3px0y5gDeqmepV/0MGkeUvmG?=
 =?us-ascii?Q?r3Zhh3BWYYZCME7C8jrtmZY9ZJYRs3OdMVqiv95HZ6Fx/TJcE3WR+VW77YzZ?=
 =?us-ascii?Q?0SXi1wfRk8LvFy49mz8+bq07Iq1p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vc0H9j5shrvFnKULxaAXuRRsQI+YVMqN0wavk3a9nPJQh3tRIIDN0GKQuDcS?=
 =?us-ascii?Q?9mg+Q695UqbNQg3FK/dcaHqIHKIoPx6+jvEPoxa+qSJtZAUfpzTnzd7qDieg?=
 =?us-ascii?Q?iqwK1C9SXfEKEYLOVpZsaw4gKhBGtp/+IKhikI5Zx1uBZxKc4rRZpjpgyC4O?=
 =?us-ascii?Q?toeXnELfzxxfEVQQbMZFDpzuABshGw5vsKgjGHm1Az1cs1vG+6t1wewu7sHS?=
 =?us-ascii?Q?730x6mWabbvWI6+Kz8SM1rP6c10iEgF8av8gGbUJD3cbZ68Fw7XL1r/s9SBf?=
 =?us-ascii?Q?nY4ynsoulyp3VdMgwGeuKQz5fS9sGLdgoQDg0DTfBCwjKmNcYUG1QfPFdqWv?=
 =?us-ascii?Q?mvk+yY9e0SOTAZLOQ4R+7LceH5eANayo7VBcg3cdiv3WfaWCaKkiIq1bF7eh?=
 =?us-ascii?Q?GkBVgN1j7Eh+m75ooF9gp/sGNyHKrNRnoASx1e5v4/SF3yYaM/zEFkopKRJM?=
 =?us-ascii?Q?mQRXi3J9UR+sbejUtxPRK58bIrMP15jmR4udUOhSiftxLxcxHmF3ycRIjvNQ?=
 =?us-ascii?Q?E9emOpBm1rcS5DPBZZby7S4kOtJ9Q+FKQjV4eA5FdltAeqnqKH+0Fnu7d4jn?=
 =?us-ascii?Q?NNmOMa8qlaolD6gJyLlG4tetWptNUF9ur2TGa8o28CegPEx8RPt2GRsHKfhV?=
 =?us-ascii?Q?aTfw/cHFGkS9iuRrsvpv0ol0oXuY6EB2cVYjCa3giE08NAoVOWteYunz5AZy?=
 =?us-ascii?Q?Nn5QYOMFWmkve0C4D2EDj4joneeYdZnJSjc+eGnuYvnE2L9RQ2tjkXe4z9T3?=
 =?us-ascii?Q?3znoCA7lM5MI7i8DC/gYNRcnGzX5Y6B9dCeEjIpI+9niwv4JaGSya/EbgTDR?=
 =?us-ascii?Q?y6Rx+T/xMt/hbcqzjuLP2JXEj81iBDphdH55Ngyh62sm3Yc4dAJMUUng4Z30?=
 =?us-ascii?Q?TsUzU6AHyY9H/NPLLsLOdRAfqynvlP/uDvMxJtRebUd+FshDroQcKeqEgL61?=
 =?us-ascii?Q?gqxpdnXQhKEfAg/MoVxkhK+kxfjA7EfrSUZRhoO/x9T5ZU3IwB3uSnLhiywb?=
 =?us-ascii?Q?V9aET8n3MtVOozLys3QMZvq1uge/ngT53gH3Te8AIxTDszP38JxicitKftXk?=
 =?us-ascii?Q?dA7sCv6fjhtrrdXhzXNK9B1tk79i47te2ZR3Lh0KlQPdNmxGX1qfw1jVnN65?=
 =?us-ascii?Q?ImWMcm0Ll3LjswIsB6M6LEOHJPvxvytgFFYxOrJQckb8wFvP0dBahUze1Pxe?=
 =?us-ascii?Q?9c9wShGjVheOGaNeu7UBDVvBmwMumhLGDZNO4LezYhEbmn3VhPHPHizDjHhD?=
 =?us-ascii?Q?PB3QJHrjDKRx0LED9sVjvUpg0uKIP79gmQaaChAyqCIdXy5Jz89UBSw3KGGo?=
 =?us-ascii?Q?QiQyPPJ3Y2mbCIg/1RyKiDgxwsH6VVY6psoUg5LhJ0i0zvw7o5bRbRH+DNuQ?=
 =?us-ascii?Q?f2ADIuo/jEjEw50mQbRXxFuKAXYfWS40YUzTRg7rDREFtHIlars/kKmB7L8v?=
 =?us-ascii?Q?mpgtfq5Q4rTUdSVVc4j+CGkgPi1IASQAab0Wfi9DBvZMtPJw7uwqhMwVWz0h?=
 =?us-ascii?Q?RUSCO9VmFCS6EWZcN09mjWVjb4ORqgecQkq/80zl640zWpTxOQR5zZhGHZ1v?=
 =?us-ascii?Q?p/HmoPIpI0jIL26RAzq4j+6UGNW+DOu3G5667emh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfe9b78-40b1-45bb-e300-08dd4bbe3196
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 23:37:20.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pWVF8F9Hzjrpw1wF2pPOLK7Mbbg9naqpnwKUYKvYblNxQCgOz9sd74XYQnfuoJS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160

On Wed, Feb 12, 2025 at 05:55:34PM +0000, Jonathan Cameron wrote:

> Trivial but could do
> 
> 		return scope >= FWCTL_RPC_CONFIGURATION;

Compiler warns on the tautological comparison. unsigned int cannot be
less than 0 :\

mlx5 wrote it like:

return true; /* scope >= FWCTL_RPC_CONFIGURATION; */

Jason
