Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50ABC2FD
	for <linux-cxl@vger.kernel.org>; Mon, 22 Jul 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662347; cv=fail; b=U19EA+Fa2zSDMoqtaFXZNTZ8obENWu7GR1cY0TNt1ZHm7CTusiV3oDdW9s3Rw9Lo2zYIE+emp+pVkr5dH/HwHGvRLxLDuJlcH0EJJsRfEmhw0Gbx+cD578mnCFVT0kdTuaihFgSRBIBGeybefKYyhQt3CJq0czTNtYJEpSo3VdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662347; c=relaxed/simple;
	bh=9iar9HVfLfsgHJSD06/Bd2PyRA2aBuJMMk6gCqas0Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y1j+YuRtOCGEIYkjhBSFIsR50Gx7hCUV6TCK9jgDeoDaZIC3mPyJaXr2bOztvfUKKaYxeNMDFwuYLKaBdAl9+343unlKt6GOFc7AWszaDKcf+rBJr8JyJW9QR/tNuaMWstZzkfxaa5PCTB6P6fg5yo4FYwD7jBTipvciQS1DVZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HgFMswrj; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HgFMswrj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsrXp+iRn4gHB8S80KDjwALtsskYwQ1KzgJ+nXbVB1e7jyxu7p0wT9/8BaMfwiuzVGquPB04o/fmmntGjHZeKZdM4CAR574aMw8m1aM4gfUIR2eMwgw2IrusFuFBdgu3BEoBQi1Uics6apN8JcfNh/oACV6+fBdp8J1eeshMwdwL3mp6zc+B8uYC3fkx958dYwwC6NZT1zrX6HqgxfJumr/7WCABCF/r1EH9hOzfzp8M7RwXLdcw/yn5l5k0aOcRjKGsTbXAN+QsVi6qXAd4V04kn+TuRWQpDGg1gZKRlZqhV8hnRcQADFD6YtkrIXMI1ab4UhWRg6UkVVj1x479EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iar9HVfLfsgHJSD06/Bd2PyRA2aBuJMMk6gCqas0Gg=;
 b=hj8w+hXdB55tWI+8+Y6mJ/esp/2QQzS2J/I9NavkFO6V2tc/5tQ+i8/0MBDmFpXMyCN3iCc7qXYjCnC0GNsbKwap2wjMKDMT37kFJWuIzCJtHQvAFilhHvrvZ/Fnop6TegDaXYS9b4bI+cIW8Qkaw3a5IlL4HiHHZ7UckAZ3Ym3UxXJyyzjnhilszjU+35XlFRsqQQ/Om0xalanKnoqJdVGtMqFd37S69+u/n4x5pcRIbFC/z2/59Ei2WmnvX4wp5RtrNVcyVlz98gfPZsXsJH8ypIOcvPAqbYsSRdAfEzejDrj5E1/009pnle5rtKLTZ0DZ6bqUovhOhihUz+HzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iar9HVfLfsgHJSD06/Bd2PyRA2aBuJMMk6gCqas0Gg=;
 b=HgFMswrjtFOzEhHrv+ss9MAL9xa2hQ3tK7IqUO9DgsP9vSEG70dEiPRlEqZS2WNARBqwKRUdIlJEF/BuNeqY0Pi3ML42mHFYddM2Lq7ESqusAapqcwzCEWIcEBJny1wHi+X81ZkhwMTWmhNvrQJVRE02bIHsglEetG5YvUuh94/i0rYlQUIEVIBWPQ7apgGeWflegsa/LGiyJsGN848PeJLSAQy29ngE6N5rjOfvZMZmbWJebYtwa+OSIVrFgrUielawPpQrZsKYXps0si91tY1qPiSgf0CrJ12xLwUMrIbummqSbGgYI3VHcNVMvL8wVmf90GANgNH9dCrItEH5Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 15:32:16 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 15:32:16 +0000
Date: Mon, 22 Jul 2024 12:32:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH 0/13] fwctl/cxl: Add CXL feature commands support via
 fwctl
Message-ID: <20240722153214.GF3371438@nvidia.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718213446.1750135-1-dave.jiang@intel.com>
X-ClientProxiedBy: MN2PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:208:239::34) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e390ab-fb19-4090-0e03-08dcaa63775a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BhFylLysd1xGAhtSjI2aZrt357Cp+JK57QtW1NxRAfdSmS9+mX1WOZK6dMZw?=
 =?us-ascii?Q?0ot/NESwt5ykLwRIqgzTTr8xBM+vXaHJWVmyee0YAHxUn6dE+PaqxL6WH3lH?=
 =?us-ascii?Q?Qd5JBcye3JUxVXMuOeznReREp2uBZ7Hk8W746Brguv/vruUTwP8xqbJXsV/C?=
 =?us-ascii?Q?txnNXWO6FQyb8K8JI3uSjmnsueNgmvLc5npHc12Mpg7ep7PuNA2KMWXAoAyw?=
 =?us-ascii?Q?f6z/K2+rMVUdwo8G4eYNQM71PK6fhP7jQjAe7mwfYmZjGdCFUOEZdj6peYM2?=
 =?us-ascii?Q?dqtuuF8wDTLv4/zay6x0dtflxYGM8VX+/U57BsGPRnQIRNcwUbpNaugXlu3b?=
 =?us-ascii?Q?CGRjANm2m/Y5SbweRf02OfV+VeWspVsORyX5nPzV1XOoABKSt0x3iBh8WXrE?=
 =?us-ascii?Q?ybB85y5uejLPSz5d/inFWAaqs1tIHt+MRQNcZG4MZdX02Wc/UvjaGTs4W1tD?=
 =?us-ascii?Q?850r3XytVOkDKIMEXdsqF/OWywAqQeurUy+iLyen7p1tIxNZXoNyP2CCxpv8?=
 =?us-ascii?Q?8KUBhRqU1ryNJ98fn6/VwceKn0vD1iiqQdJHH86m7bLZTlUQxIRLyCx6pRLO?=
 =?us-ascii?Q?lJVQaFQ78TcWZ161PgP7GOPi91oHwQd2GMp4hUUYpGl262HFG3klQUIHwxgY?=
 =?us-ascii?Q?Va2EIYwr2W4wpXR7aJhBqiYE1VQCpjSwXpnqEP3IKPtIEn7PxOy3TolEoxAD?=
 =?us-ascii?Q?4yKcQ9k/FCVBS0oEycsu0MpTM5VqSWZBqV4hQa6df7vwpvyUQzMlQnv7f8Uu?=
 =?us-ascii?Q?mP8soe8zzu6avuV9/stg3qIa8L6qP3ncRQAJoNyP9XSYQeCROe51bQhaE0Au?=
 =?us-ascii?Q?LPHIvJUZXD5k8lL1JaYHRspxTIvai+ztXwOWMGIJDnPmpZX3z3uaEJLS5+hv?=
 =?us-ascii?Q?06tDRIrBM8tTVLXPFz/OHWIFekQMs0vllbfbHLZ6AX/DFz3LY1nwUiv4qgmS?=
 =?us-ascii?Q?c0xpKPf+To6Xs5vVL4VE9sXF4ebTjOXsXEVMHGuX9ZD4ELyes10bDqFHFcOC?=
 =?us-ascii?Q?5qfnuTIOiAOBqEOGxszAGNdVolmWFLlpel/wvczueEe28ORKUtjLrwfICToR?=
 =?us-ascii?Q?09jkVabzigepqvMxrox0aZ2e8bIlsLC6pm+BrP2i6sY+EMFZr2gJbf1QvOix?=
 =?us-ascii?Q?23FuBews0M0vh0cv25nPyJKgunNmTUV6CqGl1+zkcYkzLnnzitzxCykHawFn?=
 =?us-ascii?Q?g0euztT9i2WmnQm4ohF2yGjAFRuOwqKbYDkYnjPGLbWHoh4ZS48IfdpWU5P+?=
 =?us-ascii?Q?fNoKy3k8B9wotgtM092l1TALAn1MR17dGFghKebQYSRN75+8T0a0YRMXmUWO?=
 =?us-ascii?Q?YcjjWR0qXC8NBV+PhbfsZe0MLPAuyIdkBIgkFExoykg8cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Yjv365jhBG4sACdRU0OD5SWWP4JOHpbsuGmuBOyPB2lwxgqVcPotaA+pU+g?=
 =?us-ascii?Q?OXWcwlak7K3SE4YVe8WVhescJpJ+6mNhj5CzVke0C+YBhqjTimVGvVVV6v0C?=
 =?us-ascii?Q?m3mKo20E167oXnY6t1LaYuDN29jmluQhMFVHZpOv+Q7fncWJ7NemtjF0nttp?=
 =?us-ascii?Q?6X4nv4HmExgDKihoITJS5RwwVVVFH5qO+343zFXNxCwJz7cj4nfRBqLJyZsG?=
 =?us-ascii?Q?JjBECkZN7UgG53js9HHmU01lQu6aDobmtFfbbxoJ4uNkZt+sw9y5O5OkBJvf?=
 =?us-ascii?Q?ffv+LIuw+HUHoFlKGOklqfTeLyTXs+TduUT8fvjSXu8f9WVI95E2Ywk8Np9h?=
 =?us-ascii?Q?yjtRVDah9LYaqKreQXIxeSbK7Zkbgk+76o/35QZnkqokysqAZWkA5vucdlhJ?=
 =?us-ascii?Q?B90uYGmEVnq4D/oiw3Jgu4Iocqj/i9mpHbBj3rCpBNksGrXRJhVMGw1sNcqt?=
 =?us-ascii?Q?HrnPX0SVQbbrrdan7awzu4MyCiY31jF9b8KKVOFsuOGn+80mCSL/zIbZRfnL?=
 =?us-ascii?Q?4UPbrkM77ksEphown2qImB9BNqDRyf1HsYeNgPuKPMtfP6DoE95dr+1HaMJt?=
 =?us-ascii?Q?YPidMB//3bPYPIrftpkHVThxfsdjLsc1dOzU6wtXnBQwCjJMVoIUA8QvwboU?=
 =?us-ascii?Q?BIJN+n6DshLWrksa6dKK+4ESeo8Otr3x94rqZDskGUcqfc1+iQS8bZrxf7pK?=
 =?us-ascii?Q?Re+wOf4rot8ea0SvlrRMSqZtfA9dA7Dg5hGIUasqRTC4S4+DD2nOSdqeX5PO?=
 =?us-ascii?Q?ZFNCsUUFgZvnjI1HSd+Ri7lyF03u0JJhKrEw0LtG3ql/SS3r8MDnwx3UAOnw?=
 =?us-ascii?Q?IUtTXAZozOz1nVRGcsgXAjbGXTpcYQYAiTUx8xiStKM7VJg9QOvrTlluCck2?=
 =?us-ascii?Q?S+g+xtd2pFyhbg3j5hYRpK6HxGh7ls3F6d8WgwsneVqqfppjKMwlUsSY9kg1?=
 =?us-ascii?Q?eSwKC7w26P4gpEHGPYSueD54gVyVHdPSl2mjOyy4Lmk38qnmkmhgHqnjqRYn?=
 =?us-ascii?Q?YUHhYYB4ljioL35h5mZ+fExnFVOA/PACuBtpsI4hvSPYPYehvHyq9D6wljl8?=
 =?us-ascii?Q?rbJdSQ/plLgli3r4xtjv9rM+fjnHUOvy8yacBRFvDcH+e+vagaUZYgwo/Cu2?=
 =?us-ascii?Q?XcRU4jKrm1Ue98W8If1agx1ETnEcMHJy1Alck95TjVA9jiZdbYICx3CoaSJW?=
 =?us-ascii?Q?Vdhs4h395ZxhrY7+FfmpIiy2mGUwpc/aIMFQOp8DSUm/PSD5Xc+6bNDmiMXl?=
 =?us-ascii?Q?0sMsYFIyuiNbfDaJuzg149BxZakGoZ9nF34bw1RAKIs9QOPDwYv8SMdHXdhG?=
 =?us-ascii?Q?nWYg5sdmJyfKCoH3vA2ICyMFlgRsl7k09jf0NqulxuP9iD6PufZ2hHvfwy2a?=
 =?us-ascii?Q?ETTapd7prIqed7E+GDUG6xwMVLev8nwgnQ6Gy0LrdRALQkUmR/KYL7iAHUGo?=
 =?us-ascii?Q?N9Ti42aEEMgTTfMjtFJpHWd75aMhHd3EtHdln5dcHFdLzwAlB8zpT2oV0v3S?=
 =?us-ascii?Q?k2GLqz74pxPl5hBRaZbY+ECJOEte7Z6oStCjCesgL4M0DdBnTImr2drSMC63?=
 =?us-ascii?Q?X/16qHB4DKJg3QsGV4s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e390ab-fb19-4090-0e03-08dcaa63775a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:32:16.1818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aslraZ9dm+WsqJorrz0EJ3OJsWTjlxS6y3ExV1EncJgb98J92djT4bwyrS4yRd4j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9173

On Thu, Jul 18, 2024 at 02:32:18PM -0700, Dave Jiang wrote:
> This series add support for CXL feature commands using the FWCTL framework [1].
> The code is untested and I'm looking for architectural and implementation feedback.
> While CXL currently has a chardev for user ioctls to send some mailbox
> commands to a memory device, the fwctl framework provides more security policies
> that can be a potential vehicle to move CXL ioctl path to that.

This looks pretty good, I think it shows my general feeling that it
might be better to have these kinds of things in a structured
framework with a documented security policy then ad-hoc in ioctls with
every subsystem..

Thanks,
Jason
