Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4101A42C4
	for <linux-cxl@vger.kernel.org>; Wed,  4 Jun 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051884; cv=fail; b=YqbjduE93al1CFKtvVmdKDZp93/7N4+l5Fih4doBEzjdaKUhMeNgYdIzWyNVcrthF5rUMXlgVcwCF+begqvJeHDm/eKxPjTm6vxhto5x4h+I36Rdb4NT8vhPyClBr7yHKm1ay9ou622eP5Mk0SNpf50SCm6iRf9jMwQpX7vGViE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051884; c=relaxed/simple;
	bh=vgWDUazjZWI7Tr7XP0S6Ggu7e5t3/s2+DNWwzzaVN/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mp2DlQYUL4i6uzFVmuvfD7y78Ytv17KJcSCP4L5kXWMW+mvvylMd6IwAPihjiZcR55FBX7UpaErUIxh9U0IJ3XhbDPgVJoF8EGEh5JusMVKy4bcW3Zg8N8DPLzagG3RnCWVA9WLQgh5P5muVa2dF/D9NiZ84whs1Oy2dOq8eoFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0HyQjoZ5; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0HyQjoZ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EX8TMajR2DnqquDD01ZH1kea7eoxyyKX+k6ywOobJwgouE5eJZ4ONkTmn2I9q3iTfCbvbIly1VqD1vGtQPOhB+x6nDJZZb50GkWMRmm8RBe5GEDb65aXjLhTbfuLUYg39Jt+ML3jMde5bm6O/yZe6Yux/WZbenXtFX1smNMxDq8VDusxcmxSZE60W1Gk5P9Mt3nb2iMjR2+zFI6jZ0k+d5G0/InwwiAYumBGEkd4SbpcrPHNYbQJFMBzBuiHmytPijQGMo2BTfO3SKSoAA8mZ+zKj6kBunF7YAUw+i9k1LahqZ9O0NZ+d/zgUlWVP2pdbg+ys2ZRb4A6qPQeKwtZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9k6mnEmvXPqfdXHKfPREZQZfkTwdnjG5kjJkXAEuR4=;
 b=DeC6Wqt5TrnWpFKhVQpPYcWHYzJOnRTjtgjYgqmewsxCHRehXTYtlHa1UTLNkempcPU771IKfSV8eY5dLL2u/DM8V1j/gkIx3pxIvJAqQCW7XSzRZB2skF3UpLdVO4xp8v7uCiFyLUa1cMwJBc8wnBS5LdkDWui8sQRG1gk0dDJqKOvFK8UpL158Z3uuwarjyS6tzNXv30r7kz3R1dMidfrNKgAdOBg03RWsuED0dNalndc4XH5vX0XU3uG+2QqX/o5OM4w5YoAjazJ4NvhMrDYVCsVj8OYidWyvF3c4+VBKdtmeEUJPkzStnp7wiVoy1CrxqDuajI/0d/kxHYjiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9k6mnEmvXPqfdXHKfPREZQZfkTwdnjG5kjJkXAEuR4=;
 b=0HyQjoZ5WIXSX1TCVROPk3Ms579EunMJ6x6k3DTy44y4vmVZnieranrV96UJLPppK9GaEWeFih1cNyYqiWlyJu3aannTCwMSZL1JtdgvNaRRt/RVPTOFvtN5I+cIDOBTfel9xjdAxclq8csvnOsa13zafB8eSbn5nvQM6czE6HM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Wed, 4 Jun 2025 15:44:36 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 15:44:36 +0000
Date: Wed, 4 Jun 2025 17:44:31 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Alejandro Lucero <alucerop@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Jonathan Cameron <Jonsathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v3 0/9] cxl: Delay HB port and switch dport probing until
 endpoint dev probe
Message-ID: <aEBp30k03GP46eBd@rric.localdomain>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <aDm3zR2LkC3joLFL@rric.localdomain>
 <ff8ec7f0-6cae-4c1b-973d-c126ce60435a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8ec7f0-6cae-4c1b-973d-c126ce60435a@intel.com>
X-ClientProxiedBy: FR4P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: bfac3909-a0a3-44dc-9b63-08dda37eb58f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HVJFxnIH57oZYfp9rWDcZLn0s3KLyNacDipJdjVZB8t6foTngj5veDfMrqss?=
 =?us-ascii?Q?utDYntUSEYKNfKxzTCIVQB5OrzvZPSqmXrj+pNrUDsDv+Fzx2Pm2HYqr2e3j?=
 =?us-ascii?Q?mqET4RbwjKJyQRTt14RFxY/k+NRWZ9PkjoC1LNFlUYji2EftOzueTWib+JM5?=
 =?us-ascii?Q?x10UxYJPv7kwDdZyh5yjBIIeKvL8T+97p5sG7UhDDVSfPDm8wTCaii4uTrAE?=
 =?us-ascii?Q?wI1gtTg6UJSIw9MUJQZ8E4ESjI7905gFEup1eusGET91NZPn+JuIx9pZDn5c?=
 =?us-ascii?Q?wGBPaRl+LtPHGc7NDudGXGfzm0QuUFMqs6FuAoOdBKHTkqHrj8z77/eoGblV?=
 =?us-ascii?Q?NTByMi1e6IMvsmQ7SzCzoxThgp3VKaVftFcaywzD5iGz4pq3XuVEqcZqrZzB?=
 =?us-ascii?Q?j9mZat3W/vOhh2enisW+cU6GfydeolwdafEFiCDMGcVtM38Zy0EXxAU+85Fh?=
 =?us-ascii?Q?vGBgBa0jR1MgjLQU8Ag+k9ACxa3ojPfFTJLcY/YwR2MvIusVgsK5B3/uz1Dp?=
 =?us-ascii?Q?4L80ZxYttk0/2S2PLXpnFSn9ixCVliqd4pnqEuDQ9oJzywcKdh1M+BG7KYHJ?=
 =?us-ascii?Q?3Z8UEJPcQxqRLrJ9+2m1yf7YYh7yDGv6BSw6bxAHm2vgh03EKGyNpbPLrqgK?=
 =?us-ascii?Q?LA/cX0ueDOdZq2r3XVVFxgUx85hJ9gsP/e4t6AzSD9OhzHh6BbFDDlyPxreU?=
 =?us-ascii?Q?cBaxjgPfhJfmKNmmrr/1lilISMiizCr9shbX5RbBErDLL8Vcy0wIXUOg5uY0?=
 =?us-ascii?Q?vOWMvUzh/3ibSod8rDONOm5CvvcprO48d1Rh7CEQp9WGrLNrme5ZkqJcRsiE?=
 =?us-ascii?Q?YdDYdA+q/FGz7lSqGQThraMcU1tixzh8gaLAurNyzVHLhqMgjuSN17MwX1kN?=
 =?us-ascii?Q?TIL9/mVZTC1beNHqhY8u29lrbu0UfrXGUDS+UmVnBhtTEBrLSLZVwXny0lfZ?=
 =?us-ascii?Q?7FrryjkJUAfXJnQTqCkM+t+mtpuqKMuLyFkxMJXM0xU5jPCOWxMJaHO3sjp1?=
 =?us-ascii?Q?MpH11oBSC/OaLRab9ZlwvS3zoN8H01s+xmNLfEiyLX/hu61zYdOrn/DzUZ0c?=
 =?us-ascii?Q?+3Gt3tz1wDOdD8QD2wxH0ZKe/XLRyadpvbqIK8zCcaiAA7ZIErk0SHwwVw3G?=
 =?us-ascii?Q?l5OQ/iq9s+sIPD84y06hLPJvaWKVRdAeW/mYRZ8HWRQ/62+Fd3LCFQUvSvwu?=
 =?us-ascii?Q?w4wN8qOFA6AIx2TcKnqein/kNwkECtqj/hCYrnaVmBUr3iB/ffNmdvjeO64T?=
 =?us-ascii?Q?qV2pTzlofS12sKxRY6uFqAMIzabA9E7UYV2jdOGZwIVyVorunV6aXvxclmnG?=
 =?us-ascii?Q?ztOIa9Y514OfGkpJ6kKAVzaXTaJjmC+IDl/klmYyu14JaSK642FchH83OwVV?=
 =?us-ascii?Q?rHlDFmy8ioEJPy0oQzCLfOFfhgGyS/aFhJq6lbUJVW5RKG0AteFMemIDhOTZ?=
 =?us-ascii?Q?Kl5wonUzepQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zr/FGZsEItmo3CG5XhJUh5Ibb+SuqBd0JfCzJPGhvAfUBw/lZjt0LIYP7rJa?=
 =?us-ascii?Q?+zGISPFt/iMYNYFtSzunS3M6u7pOBgqDb+bAhRJIcACwdsp5bK08nZ0huaWK?=
 =?us-ascii?Q?jN5ZS5irbL8rdlshYL/e1jfYvdM4/kqvmLPff9b7SCOVdnSJ96hqmARP9lSj?=
 =?us-ascii?Q?D2I0YJPH8DWJWg4hHXcSsxVSMXCTIBa3Bj41zCwtaJxaBn5do5fyv7SpggeW?=
 =?us-ascii?Q?tVxplUaCMfyUs8fmcFS2t74OkCGxehf+y8gyxsp8x35y4UcKW3sBB007w+I+?=
 =?us-ascii?Q?wy2BiE0bF0bZdIbhpianI/8aXErvlXqrnV3LKxwWMR1PM2uVYykXqkstOOKJ?=
 =?us-ascii?Q?avpiwrEgSnMAE7YYBUpG1AHDDkkVlamRXOHCcrWug9ONRKlyVBCE1px99tRD?=
 =?us-ascii?Q?sM0g9gVYnvJpmL9xpHRULB49x1UuyK6N0oN1F+qdUNqx1rcAXnfJ1Bu6K+gN?=
 =?us-ascii?Q?kCvHbK8brcdhgjMpdIkm3TZA4CHn1BE6vv9LrOAoq5agiFwiVxVulhgz1APh?=
 =?us-ascii?Q?wGOJ0283RN4SEt6EjKb//sNRs0Oqwl6RQ7BurzO7+tQrotClC1hKUhFVChs5?=
 =?us-ascii?Q?v+k/Zi05xqsSKVaoRhDJSWb436eWz7zhZae4aI5J4pzSe92tR1L3+TrzO5aN?=
 =?us-ascii?Q?V1ncQJ5+rE7WqceCAdniGS9uC+pUwmeEYWRCBfWdnMeCOKZ/p8mOpgbGzYm+?=
 =?us-ascii?Q?YfpmjUw9abm5l25BTr8Or5Vq641Rhh1PCZqDXd0CyI0TC5gAl/4YfbKhShmY?=
 =?us-ascii?Q?bceZr3MQ+KPtKduRFoeGc30sCOJ6OLcBHGrCweDmfcjgbQfNaSDBOGSDHPOf?=
 =?us-ascii?Q?pitXDg/tF+9GYfsD/p+9e8osuEXmxa1ILOK4SGc+C8JRDDEwlVep5rQW90Pv?=
 =?us-ascii?Q?Jtn+/H+XbvXrNCJhTcsz8nPKINnoIjZIfqiCA5tZjBzQDZiTHRVEgxhtUOxk?=
 =?us-ascii?Q?B5b6VsGd4sxCwxHNyv6fqfBQpHqDzrSOeL3oQlEjaejpPOFcgJnyuDd24MkN?=
 =?us-ascii?Q?zI7n4F8b4SfMzNBKhb+tMz/Y8Ec36FUOO/mSpnsecvBXAAzT7AehVAR1y3pO?=
 =?us-ascii?Q?0YpHmKBDzncSVhB4QnJF3ZTLWEpwNMz/L22zn9dELDKe1McvYnyDe9fzv/eN?=
 =?us-ascii?Q?BPecdSwmliObVr+rPxy0/SKfl9qEH6w7SvTQHz5wPtBgQ2XTVZ1LOyQDx2k/?=
 =?us-ascii?Q?CRz+a2mUpSRjrgTx368CDITDhFVCDKaYWlQQH/+3M+3vBRgug2CsvxfwCKh0?=
 =?us-ascii?Q?TNNoScYoFLuqnsj293SF3hDljeD4BX8IxwR4OYVWsvxHBCYv6vnwhQVQ6epO?=
 =?us-ascii?Q?pBWLGn6AzyAJUejSkcdBJe1/QVgzWG7CMebOY/F72fq/yRA7irOxkmAe1Mmx?=
 =?us-ascii?Q?Dy70tTOdZZIpdGPX95oI+CuDuvsa1ZNiHyTrYB+bela7foIImGHSfCMBm58F?=
 =?us-ascii?Q?Vb1dlxnfrCFnIf/vMnSf7VJ7//rzCP3zYdezjEqZaRbGc6oG9QYtzrnVGWlD?=
 =?us-ascii?Q?iMKY7Bs5VLYn2jLakIU9nH6HYcW9A+nS/H0qT5hOYhzwr4dAUydkDXDOPzfN?=
 =?us-ascii?Q?GIKdKVWs6duMYxqX/oPFnO6Hli07vG28DXTILDOj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfac3909-a0a3-44dc-9b63-08dda37eb58f
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 15:44:36.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TYvfUErMSwJrllBj85vRsDcAjmxhHlscKp+GnBdT9L55sL2C3FHDHI0YvEgbU+NpSjxVKYqEAmutq4/QBzqkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324

On 03.06.25 06:55:15, Dave Jiang wrote:
> On 5/30/25 6:51 AM, Robert Richter wrote:

> > The port_num can no longer retrieved using sysfs. Previously, the X in
> > dportX could be used to identify the port number (former port_id)
> > which was identical to the numbers in the sysfs target_list entries.
> > This is esp. useful to reconstruct the decoder tree and map pci child
> > devices and its decoders to a parent decoder including its positions
> > in the target list. Maybe create a targetX symlink from the decoder
> > device to the child decoders of it?
> 

> The numbers in the target_list are dport->id and should reflect the
> dportX. Is this not what you are seeing?

Exactly, but I would prefer real numbers for the target list, that is,
uid and port_num.

> > 
> > Due to the different initialization order there is an odd port
> > numbering now showing up with unexpected, out-of-order sequence
> > numbers, e.g.:
> > 
> > /sys/bus/cxl/devices/port1/endpoint2
> > /sys/bus/cxl/devices/port1/endpoint3
> > /sys/bus/cxl/devices/port1/endpoint6
> > /sys/bus/cxl/devices/port4/endpoint5
> > /sys/bus/cxl/devices/port4/endpoint7
> > /sys/bus/cxl/devices/port4/endpoint10
> > /sys/bus/cxl/devices/port4/endpoint11
> > /sys/bus/cxl/devices/port8/endpoint9
> > /sys/bus/cxl/devices/port12/endpoint13
> > /sys/bus/cxl/devices/port12/endpoint14
> > 
> > Still, this is correct, but maybe we could force a specific order
> > during initialization, such as per-port initialization which should
> > result in a defined order? Note the shared numbering of ports and
> > endpoints is also confusing, maybe that could be changed here too?
> 

> I think the upstream expectation WRT sysfs device number enumeration
> (for all Linux kernel devices) is that no ordering should be
> expected as the devices are initialized async. And previous ordering
> appearance is merely coincidence and not the expectation. And the
> expectation for user tools is that they should not depend on device
> numbering order and identify the devices by other stable means.

sysfs still is human readable and for good reasons not some binary
blob you need a viewer for. Avoiding un-ordered enumeration where
possible helps understanding the topology. So let's think about it and
if possible find a way to get a defined numbering.

Thanks,

-Robert
