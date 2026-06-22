Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058D1D54FA;
	Mon, 22 Jun 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123271; cv=fail; b=J4Cxuo0QeZDFUTLACQi3VUgRqXXpesDa+W2ztBR2TXtUwDA8dEnzKzVMf0C63Mc0q3/t3Z6GClsWRVNQ0ken2ZPHj2+ffv2IqpwK4oadyYulij+ZU2NDodGi3iTiwVSm0HFeKIiRMPno5x5ToOmFzH4LNF4ioMhQYPDICD2C4rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123271; c=relaxed/simple;
	bh=rCgZnVzuhlIR/PLNaFtKbNvjzuyi4VpEJEUZ3jaMZXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q5h8ewcpDO6nuKewoHMh9EuT10D+OhIXmSXo8auny6CzbYwLtXDCJsFfTB7A/tQK0ToLKN4QskyySG/dyObhFOtU2VIbj0iCLgGRjEtPM6hmkG0n2J5y6qaTxl0yCYONDEv7MBDpBuEZ/wQvA/Xv1MfinXqnGxRjtbFNwj0CL9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H7ul8zdj; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H7ul8zdj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/FATnT8QYi2BTqJlEwXUYm4tR2EDS7pEfLGUf/Y6vV7oJ1s0hbgVClNht1k0cnj1ZQbz7O4+4VMkA5a4ZWlYKRPwEwncJWChyS1Mle2gVey8T9ZInLZ7i8z/xM+3ij1jiFhpqbWPlZ11JCngFuUkXHiRvTfPmn0gZlIf1/l9iWQluF/m+TiwBAdqarqCOuVtoh3hown40iRYSTgsjO/VnlUjVSquTvHCUK7ctWVlGWtrfszwipA12svrxfQIOEtfgdZujBEmEd37HzeLEuYvz13h1BjdX67r2VzG82eZ0zFi7L9MHq0XvU2lJWxcbPH01i38H+5vRQ/1JoyKtvOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MByvmm+7fferyzKi0KoHSWYVeAICQZFaZYUrj2nwwsk=;
 b=tVXYIvZFyQZjsU3aGcCM8SyFwwpqbdwjmz+FdI/146VJdqQvTSAZpi3QgMd8EIwh/e85evZNWlEVtMXj4FShg17BnR49pbdS/4NjoACGGJsRr5JJSi5p9M6BcFVbTAd8HFyvIw45xNs6Ub6QY3zBkqisyZuMtyg3Jx6iVVZ98GQrF4o1FMRQsKpo1stSE0zhqhIGIBiWVdeScqMsauyshNHkTN4ccGuSxIwNqOJvGQrPOhv12MXufdXuqX9WUOYmS3jCx/s5vN+QMD0lYDev+jSsjbVd/m0EkwfIBSIzMSIXs3Aoq2I/jnAquCfw8mFEnj2hvmrbG4gTke6/fyyRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MByvmm+7fferyzKi0KoHSWYVeAICQZFaZYUrj2nwwsk=;
 b=H7ul8zdjWKfMHRa0cB87ISITQrngHUooGEHkcQcjM8URCjCRC1lKBsk+LT0+xdrEq6sa++/yDJ9YDkzhJn7Jso20VNyHWzD1Ktd7SAtTBoLqlEborZayY6/imDzDqvYQ4oUzJI2Xu3i7jNJcojLaS/GBfOizt74XSVZpF8o73L/e/RE/ZopdfS0yLQCDGmh7yy/gk9pTBArUJNHeiw7Cc1ekMyI2+DI/6KhDuBkioageocUhtG0YDn2WP+ZBylh7qbWfkr5d0xrcKQp/z88KJG+95EkhXx7PlBAt3/58D6g8gkNgPepBnGsDKvZk1fyrRNTiZtgKadMjo5t4JjEDjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 10:14:26 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 10:14:26 +0000
Date: Mon, 22 Jun 2026 18:14:19 +0800
From: Richard Cheng <icheng@nvidia.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	shiju.jose@huawei.com, ming.li@zohomail.com, alucerop@amd.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH] cxl/mbox: Bound the output payload allocation to mailbox
 payload size
Message-ID: <ajkKyqHp2TPR6K7C@MWDK4CY14F>
References: <20260611094546.31496-1-icheng@nvidia.com>
 <6a31b50d3d5da_9b855100d9@djbw-dev.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a31b50d3d5da_9b855100d9@djbw-dev.notmuch>
X-ClientProxiedBy: KL1PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d90266b-db2f-4b7c-c68c-08ded04709d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|4143699003|56012099006|11063799006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aeKDVAfHVxy9pk0JTF8m8F4OdgJk9+M1Jo6NY0ZdaDPBMwP/+wuGJUlGZokG/6umk+k6VtYI/gL34LSBIKWSQqBFhrFWKhw8fAtp/n63QnievKya+b+QXqfSSNUEvbdW88sfxJBKJ69vJ1FHgWZp/AvGYDBmx/n4LglTqDxHg0XZJ1zl7lHMU83MDuWHEqtndyZJzMM2wSaGGXMyXL5NOrRA/ZFPbLShjN39bs2JbTaqeiko+Q4xb8MX96qCgSLTwSQv0YHpm6qfQxA9MBww0/dLWJM0U01s+pOMml/QMA6ezbwXP7HBlh74i5YUvuVRz4Ow5OTknQXx7Aex3Nu1SySm4wye1sZHCJCTCg/JZhuWukPJjfMYYDnmlpo+VDq7cJIqUpJx4zn3XkEPe9gT9yot/K7uaMu9Ut+2mRkagidEmQEzfa8IKS98/1Zclq7MAlJF6fAsAASCHLYh1k7f8oeg0fM2L+JnXw1niWHGY+cqFKQKjjiFnkUDOFU/QoE4wSW32v0Hx9epJvEVOSBClUbJnOpifxjkNNFA9tJlq343opWh7ZFF21QyyyY3DBLvYW//fguWoQALe4hHQUEN//r642EqY6u6b3RAUHLBVyINlSUVa5mZC/JpN5Wo1KBds5aRxwf7i5mQJXeTxweO9/9S87+E+LOr26p6qlkno8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(4143699003)(56012099006)(11063799006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+yO/gDRrwi3xnxuFvtrQlhFpST+zdAqa3z+Aqj/sLqavLYAfKakeJKbFik3G?=
 =?us-ascii?Q?ZbLqlUXBAlb+25dzuIei/M9TgQbgqu2Vub0WMIaDwzIr9q+T0qzYImLMoxGB?=
 =?us-ascii?Q?lKLGam9xRVllP1a+tJG9l+aewkt3SwpuOmr1GkQHfZqv5swYXx3+8ftURgui?=
 =?us-ascii?Q?eHdyQ+V/vQg6lxGaLuf5Oz0l00I9MZRk1Ad7IuYZ4lLWGaoANb0whSBSNnAs?=
 =?us-ascii?Q?drlGUyFTr4HE58lhPW/CWxyPN5w6F38xaNGYmeXJ8Gx95vkSMLRttkSE4cKH?=
 =?us-ascii?Q?y04hLCWJkRToIKV3xFXPDwFS2aFGM+NpLsZdwMvq6GMozW99i5uwO2M3Gouz?=
 =?us-ascii?Q?Zhc6+QyX3SK9luvngLy2ctpaYBJwYQswa+f0ZxejY1S/z1GuXah/yCuTJMDO?=
 =?us-ascii?Q?vDaOYB5/m+LP5dKGktGr16SdE/iWFjV3XXdofgNuAQM07zwh1B/2sJfE17km?=
 =?us-ascii?Q?QGwjoMaik3tierGxFoVQA4iNGav15fxRK3Rft/NdTGcA2kE/UVQl+3Y9IzTC?=
 =?us-ascii?Q?A3duVi6wsdQ/tCYUVMb0xTvCsFwmq9w+Y/q/tVMlrcf7iEFmLDGteqhdQg6N?=
 =?us-ascii?Q?3omozqE5+7lO50mpfQ2A86FYMVSwWQxN2i6TYB2UtIvuielOuwQf1XozkEWX?=
 =?us-ascii?Q?uAE8op5iZVl8eS9FtRk4JWhNH+zj0xKk2YlKbt680Z/Uqpb7pt4IgSXZJoty?=
 =?us-ascii?Q?FUfdE4LuJFDlIxknV8DTKJkPknoaiywksm3/48lmD+zKhXPzSqzD2o+LV2H8?=
 =?us-ascii?Q?G1ghDO4AUr+FGZ0fLevwYGW1hDRFnmQPD0p+Q9KZ3u6F6qRosE3zNg32VDR5?=
 =?us-ascii?Q?h8pd+znwv4QaMxIaxE9J1JuExZOflSfcLqDPqkDomeLl7LqaGOkmue2u4eYH?=
 =?us-ascii?Q?HM+3h+cUc37qxKYH0AyzXsY5cA8B5cHzYBibNf9vCpxpunXLxty/0FEJIzf0?=
 =?us-ascii?Q?mub5DxVeg13mSbwfld+FrfEnMMEXHoRgVP8yP3iAw2YJdESrse+xuFhjJXwa?=
 =?us-ascii?Q?Ar105Lg/4XvHiyyQdDeG/6PqIDKM5M5W+/8atqzGjPCzerp67IKU3eQXTijn?=
 =?us-ascii?Q?ab/HKAeNBnGKbGvB2XZM4T1+lt9i6kxIxoBNIxv/uOAm57SJXmElkwwtn3+z?=
 =?us-ascii?Q?1+CVrhG7xCpAVekV50HNhDXz3KQfBKW8tYlLB73Nvy2oEEfSZ9ggy+j7eno3?=
 =?us-ascii?Q?3XQeYCxUorYcW5p4cBKKKdWo7klQHadCgVJ5wY4wnvH6Ij8TcTR2Ct4F8TnX?=
 =?us-ascii?Q?P7PeOzMWVh9wpQwyRCB3QM725iKgMsCGhg/RUzX4OlTyCUGun6eEXSyk/qUm?=
 =?us-ascii?Q?zTZLkirKhdgzZ6x+xwhdgUAayuUewiRP8pmlPZ2lty/joPI/i5MQCE4jxF3p?=
 =?us-ascii?Q?W9QJAP6Vo6WeNwcHXqChFcY/dcnFSoUVrfZ+nHrpIViHVP5mOHe3Erm560qw?=
 =?us-ascii?Q?xa9z4KuU8QQbVDeiFARNH4S6bh7o4CGFNwjX52Kq2PX2LGCwgCdSD84rCw7G?=
 =?us-ascii?Q?ofu1ANiF6HyFWB7X5iITlOwrPs6HeVqzr9EyoqummiUIXVzHWbhjFj2sjzn4?=
 =?us-ascii?Q?5sa8lGwHD8y8tXX6UJyxmevsXLk+MC1+3LpkwpVUEIvSc3jRnhIWTNE79TNW?=
 =?us-ascii?Q?jhutK2svl0pHH151TVm3rFOa0IjHMKIaCKS25hIafu+QFNuXzcTKMlLxRVsO?=
 =?us-ascii?Q?QGSk/tCQgia2VzlP94GWhS01I8lCLhIu5bAy5KfMlxv4IpfnwYWMiyeqafX1?=
 =?us-ascii?Q?hbbucBrdaQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d90266b-db2f-4b7c-c68c-08ded04709d6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:14:26.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MpR3DWjuEXxfGh7A4dXUDcxXS+LtjsGjPsCPygnfTuHHnUrpMrcMUCKKOpwxnKLsl+mpIGvVCasHObO04us9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103

On Tue, Jun 16, 2026 at 01:41:49PM +0800, Dan Williams (nvidia) wrote:
> Richard Cheng wrote:
> > CXL_MEM_SEND_COMMAND bounds the user's in.size to the mailbox payload
> > size but leaves out.size unbounded, then cxl_mbox_cmd_ctor() calls
> > kvzalloc(out.size). A large out.size drives a huge allocation, even
> > above INT_MAX it WARNS and taints, on kernel with panic_on_warn=1, it
> > will panic.
> > The transport __cxl_pci_mbox_send_cmd() already clamps the response copy
> > to min(out.size, payload_size, device len), so the bound buffer is never
> > written beyond payload_size. Clamp the allocation to payload_size too,
> > matching the RAW path.
> 
> Patch looks good, just comments on Fixes and formatting:
> 
> > With the following reproducer[1] , we'll get error logs [2].
> > [1]:
> > """
> [ .. snip reproducer, yes a new test would be welcome .. ]
> > """
> > [2]:
> 
> Trim reports to the relevant information, I usually drop timestamps and
> all but the Call Trace:
>

No problem, I'll drop them in v2.
 
> >   WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x534/0x818,
> >   CPU#131: cxl_repro_outsi/4668
> >    Tainted: [W]=WARN
> >    Call trace:
> >     __kvmalloc_node_noprof+0x534/0x818 (P)
> >     cxl_send_cmd+0x514/0x7e0
> >     cxl_memdev_ioctl+0x7c/0xe0
> >     __arm64_sys_ioctl+0x4a4/0xbc8
> >     invoke_syscall.constprop.0+0xac/0x100
> >     do_el0_svc+0x4c/0x100
> >     el0_svc+0x50/0x2b0
> >     el0t_64_sync_handler+0xc0/0x108
> >     el0t_64_sync+0x1b8/0x1c0
> >    ---[ end trace 0000000000000000 ]---
> > 
> > Fixes: 4faf31b43468 ("cxl/mbox: Move mailbox and other non-PCI specific infrastructure to the core")
> 
> Looks like the correct Fixes would be:
> 
> Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")
> 
> ...as unbounded input was mistakenly allowed from the outset.

Oh thanks for this, I'll correct it.

--Richard
