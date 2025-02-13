Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C0242934
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469948; cv=fail; b=tfwYi/ifZ1HgpASt+bPkAZrPJg+aGxjyE9NLD2m2GsSlLvLiH3pSrwEYDChXC5vyRuceCQYS7po7OALYHga71eG+Rij+oNDX3Tb3qYyETA3FY9GPadIpdhcunq5c4L0nOQceC8uaQl5RvpuZk5ghERBca0J/nnr+JsJ/CW3baUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469948; c=relaxed/simple;
	bh=NcRAQerOMxdVGdlb5/saBgB9/YtiSAwrzHq4ZHgRAPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RKBPiiHL9VBvBeD8ByPx/1iI0aK+hHGVp0K3nHM+LWPzFt9GtvpErsPA+aQO9vStwc8on9jhe050UsvrYraEw1RZcW9M7d9meD/P7dfqBP5Are/rxcXJy+XUCBe5GOBA0pElf9P4MxynIkgn3OHbWxwaBEL0EggcUPJAp87FkD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jXa/wAqv; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jXa/wAqv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBLtnsD0fB3P62sMgldNU0Ukb/V8l+Sp1y6IMOGCHJ1gRf4W86yt9nz/O6y9TAi8JQ9Z1ZSXeywGsllfGzmqdOdIfSJs+rEljp1bmUnWeLXx+o+srJRWE1Ky/qKsWwhAdQNFWKy+z87ca1QVQtxxLQgnvy9OMVwriMCa/r8CQAaNK2I+JcP9KNEC85pUKoWzKgCXT7XYXe/GMgaS94011nAQWRjgtV7GyDAXMMR+bt8QxMZ832TQgA2btC8XNNpWtbJyVGaXTxOQv6NBw8CLxqFI84ckU/dkXiyWRXck4s/I+7/zM/VY8HE00ec2KJ+WLZotyQN74riy54fmF6n+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkRhoG3a+naTXxNT1Qtcpwm8sGIx9+hNKau7Z4wfaDk=;
 b=qj6UBISOCcQsNOJTlR0IrqQM5VSaFoS+5YK7wexpBeROOCvZpZ1oYcJham2Dr6OIzBfnoWLdgU7/W4At02HiKsuPob87fzHfCZ/2WF+anwHzxlbEfYX+ktHRbjkixTDdD6Sh+A1u4MZWuS09RA0AjYHU/QLkt9yw5LaehIXMpsnN5CTwZKxDW/rmuHR3+ucybrjbp0tn3gYXmFuwEvA3SHwcqveRzkgFYZU2853YE0a9Sd7zyGcYzcB6rFg2JATcrSMBTt2DWiQqoHb2hbveRfImDQc9XTxXyYYCh0x5r+lvUEAakCQScRFgjRhB8Jul/8U5bjN+PTzonvzh1yCA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkRhoG3a+naTXxNT1Qtcpwm8sGIx9+hNKau7Z4wfaDk=;
 b=jXa/wAqvUOez+fklaZ9fK6d87uCTUocwBBoXLDY5JJrd0qR0UePny1xKUIEk5ixjDOkoDxFvf25cykT7+OELhnI1rqyeOo9W61mhIbdfDTRUkUt+glRdrP1dlTc3lS+0bLL4/Kg/YLWmmXr7n8l3ltPjvGrU9xYvq600+SLbA0cbwrVqbdCL7XeMrPGwXkK6e+BJUL+KTKbS5nA2NJRSY75htPHkoXXAWRWOWL8Y7GT2zM48VXOz+7KzBhPbT5cdHxQvjfq+IGvlspCous2Xx1YD2Diqgz9PR7gtktzw+KjK3eCLUYQbrdjykmswPxpCbAK10kVlVRZ003Do4Z0Jeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 18:05:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:05:43 +0000
Date: Thu, 13 Feb 2025 14:05:42 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net,
	shiju.jose@huawei.com
Subject: Re: [PATCH v5 10/15] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <20250213180542.GE3885104@nvidia.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-11-dave.jiang@intel.com>
 <Z61dsxVDH1yZAfEY@x130>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z61dsxVDH1yZAfEY@x130>
X-ClientProxiedBy: BL6PEPF00013DFF.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1e) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f36c19f-936d-4c55-1db3-08dd4c590846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H4NbYNTIXILEwDQ3Tpmynj6GP0ljMzoCM4ZS9Oq3nZCVKNWeqXCEvuApRO9A?=
 =?us-ascii?Q?xEb8ofcr29m+/OGejVfHnvmnS6s78xI0z+Z806LGaTGJttAAeM/uWnlsdfk4?=
 =?us-ascii?Q?8Bw58Jiu6IEexgCximkdA3XwKZdBoDHPtk87qsUK1b1lGfgnHScNI97CcieR?=
 =?us-ascii?Q?tgxNqeMdg+H0/WlFOkZsZTLC8A/A88jF6o1wvRXo3Ha/h2FVJ3cvfQHdCD19?=
 =?us-ascii?Q?dtF7b3rPzWsjM/aj8QiBPPAeGhiKFHPV0WwQwmWy8lHthxSRiikv+PICYdL+?=
 =?us-ascii?Q?dbqDnU18xob4AWOw7YJVihTVNWj+tzaLOvLqnui3dmXhgy+Gt9+A92VfAcoy?=
 =?us-ascii?Q?0zDlFc/ZCaXqd8jfurQ8U4/8BxClwMqXQirbE1nMRsWIyqaJG+qi1IaSh/WP?=
 =?us-ascii?Q?83FB6D57XJQFZinSDtb32WZAnxuPtY1DKbPecLRE4yttdxWKPMLi5rhcaUUW?=
 =?us-ascii?Q?W8DG3kNnqYoYgydvJx2lp1EOSt8KZTk70o+rhsa4Vplm+4OQpTwCxwZ9k+R4?=
 =?us-ascii?Q?r+bwLDyuElhll3pmh6rASf7B+ErSHgO5/8UX5scs0/t9UTbP//eDAoe+i6rJ?=
 =?us-ascii?Q?SIP4m+ZH0T4sD3JJBoeBE+tss66Q6ZUvkjyrQuQbzWfSqyxDMciXKCeFvlmv?=
 =?us-ascii?Q?x13dqmWwpkC32WAXKJZY522dX2tw93kkiF7ieRKjANPT6sAe7PIFdoWbWyUT?=
 =?us-ascii?Q?ER/PXjlS2p7rUccZgsZEEI/uQBvP0O5icOVYKHzfsJIyHd6RyYSGS6gz+9yh?=
 =?us-ascii?Q?gjvBC86DyyPGM9z7X2oXaRQjQdBYfB9NNf+liKliO2KWmC99TB41rYdNdO6N?=
 =?us-ascii?Q?whcwqQFIESBbFhchKfCsaSO9IOVCAFB29Pc1A7wTPqXqKNAbYbQdYT4kzTrb?=
 =?us-ascii?Q?TFyovmG7Boc5mH72kqR4ac9wwIJliKImd2MQg/lfAMG9NvXqPcI0M7N2p/3E?=
 =?us-ascii?Q?YWQkcBKk34d61idCznytJ/abe1Ml68oZgZldZtb2ab8y+e/XwtAvfbAgzq7Z?=
 =?us-ascii?Q?Y90HdXilOpW2VRWqc2nftsZ4hYYnX4SIie/HpRtZtzPOlmV7IvnufQqDO8fm?=
 =?us-ascii?Q?1hTlvoLxrgdE918sQgt3cnaYyHH+i4AJRMZcCuq+vvvE0lJ6NigDtmpGPj1W?=
 =?us-ascii?Q?ifznJh3bZHHgQWYP6DGhVk+JF0VB3kQEvYr4pc2uxJ3+TlYRKq6bdOeISGui?=
 =?us-ascii?Q?+B9ih8naC/1WW5rWMy7vTA6N/sFulv/7RZEIncKESadtYfKq/XN5U6K7FcGI?=
 =?us-ascii?Q?hH8icKSHUaCnBohzXhOkGKKtCUmBKBpDw4VZOlF7erk5q/wj1yyPmC+gL+H3?=
 =?us-ascii?Q?DKIbXhwrainxAfVN8QvL7/aNKAWIjgORqL8iISwSs0Y7IMaThuyHMGs1aUQQ?=
 =?us-ascii?Q?P+OyozDiZEjYg1mBjDYmO87gG5tz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EjYmx1XAM82ulSKaCAxeEhuO8GeyEuwAhvXeFqrWFcXXjWLIrEc5ogB1xxs0?=
 =?us-ascii?Q?jKZnovi6/rTQj5cY/LGNG+TvoSJNGtV9fkOxjAaI2iQjbis8yjED0du+82cb?=
 =?us-ascii?Q?V/AF1IwHZm7gsz4GI/G9MNN9tIPWETy72HVq1K2kYhMgBz38fKKat/3OTSAt?=
 =?us-ascii?Q?9nRkXWW8Vhx6PVOPCDDB6vPYbnvmOp6OiQ+5qVXtUBsrxlhJrNH87sgvuDu+?=
 =?us-ascii?Q?C3kwLEc7jKSCbBb+6itxDAfU0GkamY2wTQp9CGTUole5ykT0amzcd9aY1SAo?=
 =?us-ascii?Q?SXmJY4vntseHU7aQJwmq5v+MbeAldIj9JsIY4OVnC176tqkriAqxKKy5OfcC?=
 =?us-ascii?Q?6ssycwXKJdN2aUfwCBfqvg6Bp8Nk7GCAnPHHF9bIrAX1dnE3hWl5aEtfZInn?=
 =?us-ascii?Q?8RVnUKl4/Oe6cWwoI9b5Gd+xR1GrkVpYuP9AbytNc4G4Ma/F8AK88fjMA2Zk?=
 =?us-ascii?Q?fFg/rCxHCQWQLiEufrQ1ltev/Ie4nglVnyuZkts9wS8LTZ9P4IJDk81ut2LU?=
 =?us-ascii?Q?CHPQy9pQvN5GMQa5eN+gPlCABqXv0ymvYdtb8oO7zkODy5xjeKDdRPWx5WsS?=
 =?us-ascii?Q?B2Qd0jy+oeYP27+OrSk8D50nQZjhBVBq2+XrFbzpzJQSUeHeqfEEFoGVIRwq?=
 =?us-ascii?Q?WSAY4XOJ9QIwvmnFK3m1dcGh2a9HIPS6bsqhfaORlsDeRstHrjmGRklxtWSb?=
 =?us-ascii?Q?qDT66/x8ztOyvhJpwCqH+O8H6lnZfdk5LIH0e86yY9eeCyl2gJOhulUe9+L9?=
 =?us-ascii?Q?0H0qoUGw65o8akxRXnLUYtBJCinPwi8xYaq1K4rHnj/DLhjYo04HHxqecLuT?=
 =?us-ascii?Q?hnLI5Ph+OAkrkm/7RrGXijrqrS5M3k8Hc8REHF2BT5aj6j4N6LAeZQkn1NQE?=
 =?us-ascii?Q?0uGnn8EleBxdzxeNtnYFBOui8Bj8D1uRyhvH9PB5K2/Vwr/YDXlnnVYoiiC8?=
 =?us-ascii?Q?jaD07mtwtXbXCks5vqWRo9Efjwaxnc6Xk3QBPS8SS8bqIqqQ8cCll9gOVsFQ?=
 =?us-ascii?Q?tiaSQ5LQCoVfwlLWKF18ZRI+v52tO98mLuZChgHm/dRpe/+v9uztg7nCw0oB?=
 =?us-ascii?Q?3ldtaR2JqUoipY4BBDNKj+S7Gzudrnq9zvaQTArA0UqDqZNVhIcfGzjc6pjo?=
 =?us-ascii?Q?L0sZ109lsY7Sp+Vzro7bQeoip4dySW/3PunHGJlmKFofyqCr27Utqs4KtZoO?=
 =?us-ascii?Q?ieeNKDvtQaxPzwS2XPTVc0cSN+1pr8yWn84isA8HwviZH1RYrvjt6s5jhnLX?=
 =?us-ascii?Q?r7E0Sk9Z91B0D6z5U4+eb6rk88iPaHfEaBYMLKf32zT/AmOSqw3ss/cuEJsC?=
 =?us-ascii?Q?hURnomkt5i6Qg0uifW+6BZufAQCxog5L+a1Qo8gsIGyvnnEMxtPzZLyw9nja?=
 =?us-ascii?Q?7Kk/5Reb6IzKCfDHw0+LP1wT1I8smTQjgmZUaYLea1NGsZHcGZw+qMsVwsCj?=
 =?us-ascii?Q?hPrXgqLDTDJmdQh+QyVKQxSRDXYO8O6N0pCvdGYUla+nrEFHdPYeg/hIdaIW?=
 =?us-ascii?Q?oan1HPfvPNWFCn/wr+Sfo+UX+B8/bk6ualkc+ey1TzW0Ffu8EM0XF2b6+t2F?=
 =?us-ascii?Q?mpDihRO68X/wbJiQVlYlA/bJGrIwksO8z1klP1WL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f36c19f-936d-4c55-1db3-08dd4c590846
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:05:43.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTjIIxI/4BL5A67BUz3tU5qdAX2OOk7bRtkstQzx0PXUnfStjKQFBdeI/CkSxSxz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800

On Wed, Feb 12, 2025 at 06:49:23PM -0800, Saeed Mahameed wrote:

> > +/**
> > + * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input for CXL
> > + * @opcode: CXL mailbox command opcode
> > + * @flags: Flags for the command (input).
> > + * @op_size: Size of input payload.
> > + * @reserved1: Reserved. Must be 0s.
> > + * @in_payload: User address of the hardware op input structure
> > + */
> > +struct fwctl_rpc_cxl {
> > +	__u32 opcode;
> > +	__u32 flags;
> > +	__u32 op_size;
> > +	__u32 reserved1;
> > +	__aligned_u64 in_payload;
> 
> I think this would be an unnecessary indirection.
> fwctl subsystem already copies the user buffer for you.

Yes, the idea was the whole command would be in here:

struct fwctl_rpc {
	__u32 size;
	__u32 scope;
	__u32 in_len;
	__u32 out_len;
	__aligned_u64 in;
^^^

Why do you need to split into two parts?

Jason
