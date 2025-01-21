Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424F1F540D
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737491422; cv=fail; b=D1I7DcBRjfFjmPM0VElB9nNGmQ6pE03OPfzAfMu75jyFme8aD20iOvkTLPA88rWOn6dfRIakOP/iqWwHwwGTa/CU4MonVb7RISCqCCa/dyK1Vgij8D5uCuidOWOtJ4Ozu5gYPG8r4AfAEAel2IvH1hHiiQlAPSXtk2/0F3QgHgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737491422; c=relaxed/simple;
	bh=ec+h6xQ4Qli7IgiCUvErMHNu3TYUSDbe4Li4L+RFOBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gKm92jmOhWaadqPy/zpBLGsNd+J8Au5dzR7gXEEKSZl5ctkShtgDOhXVAlVeA05K2LF8t8l+Slnp2dlq9KNM07H3+YTZcnEOiHVBGHBgJVJ2fYyFH+mOnR0ec9IzvhyaJpWVzqK7wVg+WFH0qZbBfY1ig7RQfeYEZ3eKRhv4c7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gQd/8nqy; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gQd/8nqy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd4x4cDCt5pX+kyjljGJgm6pFlyfzEZ0YmRgDN67NwwAl9fR9/AExIxU2Fkg/9M10XOBaMzS0jSMwSZmAqGJeG4zHnhaRz3arjZY950AN9qrFMlh1qerC6WpbfB47w0MklO39WS6tmgK55LSA8eh3Nl1ZMHXzA3ATY3WvhzQoSVmz6mFF5q/hWA5pXYLp0OqbLoxoEIM6eIfoSxXX0dVcoNmeDKBWkWzzjXjHBVNvfaaa5zmc4K0ok6F0v6S54gJDL/3ezPzA/mOwRb6/ufMrO3YI5Q/QJyq+8VKutaiq6fHeKDp4SiStzgt0ERmqz5siaMop0xl67wa7OelLMoVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ec+h6xQ4Qli7IgiCUvErMHNu3TYUSDbe4Li4L+RFOBc=;
 b=x0P9x+vI4f9/25yLcGYk5cg6y0mBVfmofLgf9K2XtddFJz50HpVKqa6BdLn6VpsYwZjHsNgMWhvR8qWTBxB2p2E+KzMwmZv4ffw7e1GkbyqlA7cA11bwc38pERlKrmMTw4wb6rJ6DLhajX4PZUUxePP1p3Vdw6sftWUOzRCUI8gAPjOcDlk/HPmTjhXyWstPBKkayZLHBF1cWc6rMrFz7i8qKeNud/CqcRIM3FgxfBL/7KhcwxL/orme+uRS34jiSnwc72z7P4hlPvmfMsijAAj1aNsl44/Pl5k1zIB0gJAHzoQGacTAy9EThM9Tl5kOUiuPFHxuPh0EpqR/B4NzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ec+h6xQ4Qli7IgiCUvErMHNu3TYUSDbe4Li4L+RFOBc=;
 b=gQd/8nqyKOF9Eoh4GVmmd0I20v+n/Ez1zQRCUkHK3iqRBGMmLcjvNu5n/9kRMYDmBpo9rFlxf9O1ho2YXlFHbRKYzHS97sBm2/qKssuo7oqsCkQe3D6kcf6CJASfQn9NM3M4uH/QRDkqWX75TuNwfjbA5hhvveh1WXUkABjko912oZcs6f4J6+6IkC1N0dOq+a45uSSdSEQYzocdIj7ve0+9M8pe8I1/PA4g4FepDl23ChVnH+kaQhFf5zfH9AYfINtCzx1m5O45kjVWnBM+AZBXBCpyIyFON0B9lHrZrz8Jjag9oP03xmaXbRDOmKs4W1nLh4KYj/XXxMlN4CJwOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 20:30:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Tue, 21 Jan 2025
 20:30:17 +0000
Date: Tue, 21 Jan 2025 16:30:16 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH v2 0/20] fwctl/cxl: Add CXL feature commands support
 via fwctl
Message-ID: <20250121203016.GA5556@nvidia.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-1-dave.jiang@intel.com>
X-ClientProxiedBy: BL1PR13CA0418.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: a359f5cb-e927-4475-596d-08dd3a5a6ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+j0gcobrkCnNM5EpPL15In7eCaN0HWELyyAXdbHLVviw5/L7Y3zhkf6JXSwP?=
 =?us-ascii?Q?0+s3GNFJs7wEVNbBqpP01FNaRvVwibHhxHoDmWYYBnQ0jw6A3jASA4SZcFHw?=
 =?us-ascii?Q?uFW0pRqdiQythT79ihdqfrNf6ECxYvgZvYkuaBAH+OjHXVUUA9nUeoKlNq2P?=
 =?us-ascii?Q?y5MnUBvrhyFlVal30pWBmER9iA/F5A8sxe2BWFCvnHiRkhcA/3unKb/1AA+i?=
 =?us-ascii?Q?1pw5eTYoLOzXyfIOr5BYzbYnpqSstBiLZjXSMncr26mq/wT+ByWbaYNyMhUR?=
 =?us-ascii?Q?4LiJBMrDDwXffN+tmf2W1P71gerwJLxsDzD/xNxHrBKxfO0WBvqyx2ezVB/L?=
 =?us-ascii?Q?TFSJesjzM6pX2uu+ZJfC77vNK1Pub0Vn2b5OvoLnODJ1yIoJUAgkxoqcD6KD?=
 =?us-ascii?Q?p4bQwzZzfO0T9oSIW1xsy8KNXOunuJb0ZD66bBUQGwBzbfjBSJpvCHFCDEiv?=
 =?us-ascii?Q?WlJCRBZW63OJBeqOXbiQiiKtfc+6r7kKRyM+b5OcUN16Dp4Kcv0YIZPAzlHZ?=
 =?us-ascii?Q?UqqoBbDXM2ePeyyfxb7rxtibXMbcd6E2Kc3oD/GF/Mqv7tipnefD+3J1lwvx?=
 =?us-ascii?Q?rzkquOPAQZyKTduNeGWpRFIOQQ+XBox+VWL1I4inKXzvb2ctE5Jr95+dXk9f?=
 =?us-ascii?Q?REH2QlpPhIiOhZn3F+uHhEd5tbhD8H1WnctS13cabGRgs4qmdSRyFSj7niEc?=
 =?us-ascii?Q?M6UvhMgW1e1UPtgJKtPjG2z4OwOmp1/eUupuPf/ZIA3ykMkk1oFoofDOiS0+?=
 =?us-ascii?Q?RxVhgazuOkUrle96BOrW35QoEfxO3sVnq0iaYZLynXFsDvrYwP3OJ25fwJ6O?=
 =?us-ascii?Q?76RAA2R/CK6gXI95S2yVI2N78R0PCy8hGdWo/xJyNW3JNusC7P338rqlLtCw?=
 =?us-ascii?Q?MUiHMxa2ljnBsaiCBYMtc0uZAKgrcaD+ffdE75KjxFlRK1JGoMI3MyQOAP8Q?=
 =?us-ascii?Q?JdStXe25ufU5Hoq8TYOWK5cCAGg5YoHb9yEBhDEoWNKRJ7U1VRflrrBlpXWC?=
 =?us-ascii?Q?P6aAM1XrvM0Fz+Dppa41ed1ELBEHxVJYICTadopPkqdU6feXFm03nbVPHKNQ?=
 =?us-ascii?Q?PUdQiHz293r6WaCKst051eAz6bsooTMXakaI1xJVXnjddyqyNpppqEJucLbZ?=
 =?us-ascii?Q?qsosenD2/dCCQb1iN50qlb4NTjujUWPc/ZiGSOuscAjtLSNur+vTs7PCj6Gf?=
 =?us-ascii?Q?lAsrgr+G/9hWulPBw992UeuXz0zilu9B/k+QZsXPL+KfLUZGFOzWsw1eZ7xk?=
 =?us-ascii?Q?mPFICfabEbkHiSwodlgyJwWg1Cytk8PWXaYmr8BxCp9wUWx3nfkC1IiyGw+M?=
 =?us-ascii?Q?4hjVFKZeHQpWnw8vKS8rKxxWhm9/nZ5TjQaUCDXT0wTqlLYYTd4yAdnpwWCH?=
 =?us-ascii?Q?adQU5UXP6ex772SChiWYNr0kc4RU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kV87ZkV+6MDcKQEHVFHs8f+9hinDVkhY46Q4nkEZ8QtATTpRwEwHUcWGLp/U?=
 =?us-ascii?Q?tTAQsWQT3GIDIAXbfwJrq9b/G1NQng40xPDpwRcCnYRc9Bi2XvVtXmUe3e/a?=
 =?us-ascii?Q?F1OaXxcagjIG8TCsdIp7Fyp59MBRbH+XwCJbLD2ZXYSzcCPFm5Un6ZrfnnTt?=
 =?us-ascii?Q?hnfRxqLPjdAw/MpEMr0isKx7sKhp78F6XeIf5ijqIrkbNcCCCC9dSt2o3qZE?=
 =?us-ascii?Q?UVjlhSFi7s84q9eNkyhDGICr9+dsWPhNRdozpztKHEpv6bBCBTgg+isYnJuF?=
 =?us-ascii?Q?fEZ9epEbwavS2NY8/EKw7hg7UBBALBTI9Q88d2NNY/p66XVNpdixIeqap8Wf?=
 =?us-ascii?Q?oCOAMUKxSG5swnkvxs9atmQ8nXlAx9QqdVXpotcj6gNTP1Ezlxx8NOufI0S2?=
 =?us-ascii?Q?hMQA7IkTJKmA1RZ0ofi8PJPyXxh5OvKlsQj3i5oyQU3K8ZYu9/FylUlyi1Vt?=
 =?us-ascii?Q?H+XFWOYk7Ale9M3aWZSQP4wadxT2E57+6WGrVfJYyOOB0FSzXUJYUFCIYic/?=
 =?us-ascii?Q?5iWqKp4923r8MeRsEnRozsHNTbyqrocZBvtU9mB6CZ13n8oWH0CkstPrqKP2?=
 =?us-ascii?Q?o30n4q+TGjoMvT5WhPCtL6tqUHJbWvTw8EziSMBMwXJY53SwM7hnlsFdOrvq?=
 =?us-ascii?Q?5yLR3PXd9VR81jxlbirigD28y5EZoa/Zn+iDs6qaglFxHAZzOWw8ZXYhvi9x?=
 =?us-ascii?Q?X3JQg+oZvTYsLOrT8Tf29CmX9BCGIp0qR2SgTJf//lAsrSFtVT7eqkYZAVTY?=
 =?us-ascii?Q?sJeJIJUxQRJoh+WQLBZYqpN6T6EqIvSl/SLdKf+7pkPNAyXz86nhQ0C9lwzp?=
 =?us-ascii?Q?S7Vw9oB6oph4NXy4WL8i4hDOrkEA8o6+2SbrzQDVoi+5jbOgOKuOdC54RwXo?=
 =?us-ascii?Q?AJxT/LiXGgskoa8e8znqcfEvd8gz1X6AU1v9ri6xW7fa63ZvfgBEUq0w8d5q?=
 =?us-ascii?Q?BR759ePppW0+pkVM/Q4jhOQJedVC9u7eaSKtaxKvl8cHh848/n1qWUpjxZ2T?=
 =?us-ascii?Q?zGgF5BcoZkvmLI4HIUuNZU70EcNPaxydu+qnfj9X9bOKLn25NJ8jOYzGpChT?=
 =?us-ascii?Q?SaBLv+MivMdkc+dxVDLaJo2E97FUrJ8RwGQmFdmdi8CTNQs9PhEsauPwXqbp?=
 =?us-ascii?Q?mipd+DP9g6SqfxWk2gdCq+aioOWsVjYKCdSXLORgGuJXIevnZcnlaD2tlWrF?=
 =?us-ascii?Q?+CVtWAit8z/blXNMJoSus/w9GzpyZxCdEmp5voobthHcLexXiOmu3HvHqQFP?=
 =?us-ascii?Q?NbSEg6JQRsD8w2PVF5pjmhrgpnXD5Z2tFGbG8gmTmAAxwAcxUBqsumSegjZ0?=
 =?us-ascii?Q?baNmZIrtaBvue9yAzLoz1JKZVT0Nxy/fYdxZ70PgR1Hn0ulzlf2BvnHMRMsA?=
 =?us-ascii?Q?2UJK3Fv7p0jyOLB82bJWSkmI+SJ7V0XfbSmmgBaxZVu9lMLA0cDVX3xLRMVl?=
 =?us-ascii?Q?2XbAE7MiEazULP8Dm2cN46v6TwV4bZ+K7cTb1zTSivAKFFoxmE0J3LmnVmdr?=
 =?us-ascii?Q?RgkVa314/Mh+pb2EVw709mIe+/3w/ktLECZGgAlrp0e6MG5N5gUR+FSMuIqp?=
 =?us-ascii?Q?qIoeK7hPfm20R6LL4N+xnFH4O89tGCDJl3K3aSh5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a359f5cb-e927-4475-596d-08dd3a5a6ae4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 20:30:17.3162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LzLOsrwpc8tNlaNbqnTkCeyzRQeR1gAxpktugdSuWqynWmRJHRJx1s3IOZUZw9T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670

On Fri, Nov 15, 2024 at 02:25:33PM -0700, Dave Jiang wrote:

> This series add support for CXL feature commands using the FWCTL framework [1].
> The code is untested and I'm looking for architectural and implementation feedback.
> While CXL currently has a chardev for user ioctls to send some mailbox
> commands to a memory device, the fwctl framework provides more security policies
> that can be a potential vehicle to move CXL ioctl path to that.

How are things going on the CXL side here? Do we want to make a push
to get this done in 6.14? (ie starting in two weeks?) This is approx
the timeline I had in mind for people to get their drivers ready.

Thanks,
Jason
