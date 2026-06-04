Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D6E26ED37
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569060; cv=fail; b=pJduHYXdcbAvT5Ic1ZudZTkpjufqjzRNDwFcWkhvmXrAvXLeS024ojGEactbuF/oi0CTNgGoo7UohioNHHds8JX4EF2KhTpppTJTSHWLuurqf+2YqAFnXAbALBDmm02en7BKVmw81S7eT6+9RIzorXvHZMj2FYkznqBcQd+iTkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569060; c=relaxed/simple;
	bh=yIdoxKdYk4k/6jIBLrlqKR4H73b6fggPNOD/4PGx4f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ad03ix3t4Ww0+qNcCxQrurLtgrz1SzwWC+YFQP0eCYs9wbs9G9I9Bci7HV9q8zDbYORLY1es1+lu/rLdXboMHT40Sz/6WKKpsCwi4ee8gjxic2prgap1CG8bkesPb5I2ZzHdeHk+BPC/5gsGwP0bbfZppMM+b1Ro3Gbz9zQ8t2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=utMl5fHx; arc=fail smtp.client-ip=52.101.48.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="utMl5fHx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7pX1NJiQtRDjCU+yK2zHFPeKYc6zicL1ehYVSO7XNy/fF32DdiEVh8RS7sSpSCijXEs0bZWqh7QfVohsSFOuBDJdo6jb9qyW0VIzuJJ9DO4JMgRIgo5jnwX6dGEsAi4QoZVPWqzc5ycvPSsadGJjw1Qr/YkbTYITqCX1pxt0/r+iL9vEkRC2Q1stwxaU3iQbJdwXqS/vGtF/IkGa9vO0CrV3AKJ5hqITgL6aZCeRy82gg6KYFQFkZO95TyE0iZY8TjBiE7bgAMWv7iamdSfcaoKoeKz/VNe0/sHpBJphHWUYFcAYkzYJqvkxdZPU0QCBCcNq5wu0cb6vZwMG/Zt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoNEYrb7kt7sNkHSQjr6WCQ2lIlFRCl7FQPa4uHud8g=;
 b=t5DnosbyhU4pnnMFRDwbMHOvfrpk3SrN0T5Kab6IwGTOM3m7a1mSyIGuFh4zphu4GZ2mVTOZynbtwRCnuh0oYfu0E57X6dTSxGAT7Eb++Ay3XbQyaXO2WYy6zFz/iuzUSfbWuhQ3cK5r67js8ZXGN6NHaeMwDCAEZXTIkjh43DKmfKvQMjd58TNgAq2ZsxkDacUSog1TxcqvdeKNpi1U6sn+wzTWZ9G1swiO5CewC46HGkgJQ8INoKmtxNPzTsGEsz6XQ6hu78+9TYUxtVwzzRwdER17D+pS3WrYPe+XFPqVoj5JvcjiNEKyAaNaZqR/8h6VvqUKh+AbYsvT9N5aSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoNEYrb7kt7sNkHSQjr6WCQ2lIlFRCl7FQPa4uHud8g=;
 b=utMl5fHxeg7VCxkeemlycrISYAB1PnyvADzJIufsQQwClNXl4K3/fzw7x/2riDoZrepz1zYSISX+xGH0NUn53EZFIBs+XLgmxmtKEzYvtdSI2jJFDngQ7PVaqSfFOYYiRt0jyJf8WDoEWO4v+fW1KIeAh1u2+aQhll9MRIQNo+n5b2Gv3aRiPpo8hJaUsK12/+BmRm+etu9AIJvgV6m/27Qo2IlFJdHeB8en+se5PkAuSwpf+cITDm40owR3x5UdvjyCEYpUNvqXcUlKiAWreQyZHyyrTkcz9E3hbxSQWG/PRBYTpuisI2yUYey7l9DIEh7Oiiw55FJZHjVF3oyHog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 10:30:56 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:30:56 +0000
Date: Thu, 4 Jun 2026 18:30:48 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org, 
	dave@stgolabs.net, alison.schofield@intel.com, djbw@kernel.org
Subject: Re: [PATCH 0/2] cxl/pci: Fix the incorrect check of
 pci_config_read/write*() returns
Message-ID: <aiFTbzlUZEr4UT6F@MWDK4CY14F>
References: <20260603185752.4149725-1-dave.jiang@intel.com>
 <20260604111744.74cfc2bb@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604111744.74cfc2bb@jic23-huawei>
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 329b92b2-88a8-4ba9-f2fb-08dec2245c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|6133799003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	JMkLYPNxw8ETVH/EvVFY15nqxyyCQfsi6FCBat7ESHY6vqrOEBiinubwf57bysLk85rGZYZEg52eNjV3TNaD7i1XpDox6blDAMz2uX/M0PJ+R6UIrd6Kc8kWJzB3oa6U1URE+4tySgTaY0bfWlnagYUrmJlJ7mT4xRsNJqV+0Xbsu4luu6gmP6Q24Fz2+U+sayaaPl6lMSDGJARWd65SNYU4chotb9kQFx5J+8AwKz9CQT/0paPHIAW4QsbMTYV+3Fuqh8Tt9A41rkr1xPjfWMqsGnHVrSVXACdiHtWVPYhFflSkTK/sDYAE3tzrD3Uds9BzvCu/UR9yWOZu9D8CvEqNrHvLVaG4vukBVyOSxJZufDo1Ya9EeenQTNRIP3JFYISe48n1tX5VTf3wTGqPJDHl+V6Z0h1lCxqL+PkiZu7FYOemjTiWTFLiZjJ2StjjvD1rqPcKNsN+8NfSY+yj1QmF4o0klJyfvqu012rnwsO2AxR8ISGHX8/i5pqFjBhOczm7rUxEiEVHwB0uWDJ1k0/YgJ904XxybAqYxWM/WvS89gdmtcmt8IibEwJN3DF1zWChuqm1k5o6EptF34Hz4WYFfvdQyqF5i9wc/XuGbQ/x0hSNaXNNWMortTpVB6Nmm2ptkLcDQ3PsitFKacLVsy9pwyRJKkrp3uHHenqZXQ5dOReGtqjaAZWMM5KWX17U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(6133799003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p16r7XxBZDV6k4Cy3yc0jQ4USiUSpxTqGredtvuTrWoankAbM62B2x5z5xsX?=
 =?us-ascii?Q?fIrzXW7fBiFXH9C/y5UNxvKrYvda4KGUjLN+KCYU/TkpAaDn5ZbeiU6y4+VT?=
 =?us-ascii?Q?SCVReZdzuineMtjvNZDDsn1hvCLqhs7DesdtMwph3SiqVM82XxtkBoAsXArQ?=
 =?us-ascii?Q?NPfAQGfbtnN/tdxFh5RTVmTo98znBBrR2YudTvYEDd0xQ6ndqVATij4Rz7/Y?=
 =?us-ascii?Q?rsq+M4WOFBY+vGy26HPbRY8uGyxG306Qc1jRq7q2OhKsoqQQI9csNWdqSawF?=
 =?us-ascii?Q?OlyLHpS7hKucv7q3KsQ1ehIApLyftKxc29c+E061bVdtmV7kU459BBnbZLVj?=
 =?us-ascii?Q?uERVEOvLpPZRSGn/YtvQCgY0r+ZKDwoq11ijDQQOpqr6dCehWVr/wyr1IyvB?=
 =?us-ascii?Q?U+U1pPPZoKqbNjIaBqxoZ/hZm0UMiJ3LlsHVc7GwN1S8YynWwgNKKJlpXO5c?=
 =?us-ascii?Q?2XJ6x2uif0Qy6ygLv5v/wnLrzD1goBK6ElKPc6xsSvT0oN9wciD9HdADxBSj?=
 =?us-ascii?Q?Un8/bFqROUERmmQdczDng6fp4lPu1I2+5e1Q98LVUolBt6UsPYRfeZHIkymZ?=
 =?us-ascii?Q?mWS4bj+LD5U4vMiyppHHJGcbLqqKFVlffywGs4zYpoNqBEXBVjGDluhaQxWD?=
 =?us-ascii?Q?jzHvrD457mFiWe0Ye7Uysjcvj3Qfc6tKEzG1NhOHnTB02HEmpwfAw7ohVQsy?=
 =?us-ascii?Q?lU57xTe8wzL6jUI/fCuARKAWB+fbB+6kId8R0n7xZqdljONC1hCtjphQpIMZ?=
 =?us-ascii?Q?639t0zuNqvTD27LNcDXyLQVNLVXFru2ggIeOwUvrLMgOVZw1SEqiYkgI01WV?=
 =?us-ascii?Q?DZZjoqSM92uCH4bPcSY7KOdwHOt2OfebqJxcUN4gjKiaE13Rz271hqOnIGAA?=
 =?us-ascii?Q?bePjjlG6/Oegb03KJRKDS3Fnz5l345lFh9Jo1inEHDQer5W8iYxNa23Hp67O?=
 =?us-ascii?Q?mYOYLXOMqEsqrNyaj6vHlxcggucfLg0WYS0a7R8XYWUMR8KUR5V7hHN5oCrg?=
 =?us-ascii?Q?PRT/LBLFfdZPlCxryxtavnlgCPrXU8xMf+xJcl1XY6dngRy4y4YwcgpJU919?=
 =?us-ascii?Q?8bDz8MwcomE9QDydfzLk0KTG3hrElNlvLu+Jw6X993n3fr3Qnxg5cys3TDGc?=
 =?us-ascii?Q?XDTxNwY9Wq/AeB2MqdhLPkGzs0x1gRx3V0e8F1htnPVrTUqTGa23Ga/RbDMz?=
 =?us-ascii?Q?MulN0wSSlpEfii+UrW/8n5a1HyH2KM7V5t3NCt+Al/94+1kXa+Dt/3WNczly?=
 =?us-ascii?Q?t5tJWLKvuqvpb7vGmc8YdwvVQclEBMFYd6nbOfXM9Hp3J6D0vw2e/KTHD6/X?=
 =?us-ascii?Q?yyJFhlNY7eJbuPDV7x+i4aQBCESGZPdUvf47yeKH2wEqZCJjYoFUpjNJVCSw?=
 =?us-ascii?Q?M+UQFZnMis/cfIkSB4aNRgvorLI9dlqsfVpSxdiW4Btm/BD2g7to+NTzxjdB?=
 =?us-ascii?Q?Eb7sWb78BpLP5maQEJdzywoqZv81KAYHryILb17FkqjIqLgHTimEhtDi8E7D?=
 =?us-ascii?Q?0Ygvgv9Sdt0TuNwYF62jh/WFtDqShjI7bwHX32/f9J8VEpixOscfTwEJl36g?=
 =?us-ascii?Q?zQ2wi5VvXfEdmFw6jAlMeiLbXfecGg0pf6cXUdiAY3jqQ7m0jNfD8CRpyUWQ?=
 =?us-ascii?Q?+yRfYE8R7M0gv84s3pbX1ty8rYWDGwqedmBFq/jqz3UQR3fpxpkHw35rT9Bg?=
 =?us-ascii?Q?CerzeYaOdwlt+5LqxYU07u6NxePRkSajiDkdba4zQ1vdAqB+Ygdrx68h7Sb8?=
 =?us-ascii?Q?jPuTBkCVAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329b92b2-88a8-4ba9-f2fb-08dec2245c72
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:30:56.1993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a02t7G+GLG3tJepH2UchphDn6OaMF+vgNqFaTfV2RN6WE8ZhNlFyK+ZZdaenC7Fem1rVoGIqvp05c7lb1+Nyng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630

On Thu, Jun 04, 2026 at 11:17:44AM +0800, Jonathan Cameron wrote:
> On Wed,  3 Jun 2026 11:57:50 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > The patches are inspired by comments from Richard Cheng WRT pci config
> > accessors return PCIBIOS errors that are positive integers rather than
> > negative errnos. I went and audited the cxl PCI code and found a few
> > locations that need to be fixed. There are other locations that may
> > trigger issues, but at this point we'll fix them as they happen.

Hi Dave,

Thanks for this, sorry I miss the email somehow
I'll look into details later, seems reasonable to me from
a glimpse.

Best regards,
Richard Cheng.

> > 
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> 
> > 
> > Dave Jiang (2):
> >   cxl/pci: Fix the incorrect check of pci_read_config_word() return
> >   cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses
> > 
> >  drivers/cxl/core/pci.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > 
> > base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> 
> 
