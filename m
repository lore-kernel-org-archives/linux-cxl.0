Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245F3115A1
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596398; cv=fail; b=b7O/8Hj22C3m3xASvK+CsODi8QBu6IhdjJSgsf8/clezr0ssMVDO4ONPukkCbOw8JW3cSDftp/TIxNgejRQOvjtCF0o7yc3d1XAru4Dm3lu2BM7W6Mk7rlG+A2Z8QheCeNkvOcELYaX2skggF2xoQMZjukUCab67Rg4GpDjpyls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596398; c=relaxed/simple;
	bh=/9dCc/2zj1TyuW3xtoXdEJQYlWDuPOQQMaYN0bx5B8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=db4OsS0eXR7BdeEY4emtxUS0UOKBjyMbqxLKklU8tECKWDwsZ/1OrKEC5QV6qfGIuLL5IxP1R79QEwkV56alxHQrrZ2hvE00Bnc33dQp+jLgysN85HKKKdRXTnqFfRDE3UKxEfBFIqxm4FnIydEmx5MYNc+0MZYrGVSBkwC1eS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K9hlA3qI; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K9hlA3qI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5uI7cyWhYit91CdWwiOVZN3+49g3lpWlzBStMy8P16uOfkaLgPxyacl/rLaSWlfK6TAANLfPPA3vuMbno17wU1MnO3+HdCFIX6bijJjAHIVUs+LxoxvKpvYFJevimsQ53o93EZjjJ5LEy7R85MYbkaguCrjE9v5CHu39mIIPz5sZDhZ2dw1k93hIBA1xzs+6g/6TATZP8mvXCl2k5A0Yh7FH5HmoVRaOmjpDyZlPVHTQ6JoWG0GJ4F6e79c/wVRKxuYPeHGYdNdyxZrzNO/3voPR/FnXXJOxyYjGjWpuUwHGjpTTE11bVpGDZ4c4mx8wGUgLWW5utGGx3IloH+fRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TNZOBMRFspv6LyrrYvuPCdvaUfl5AUKZvZtbkwKSXc=;
 b=rro9Z51JDFLrNfglc3dTNnblUJym6opU3mlWher15+dB0cLwMXgB06v83C9EzARhyQlglp+ENnrki/PS/94GEZVmM7LJmeBkFCYPeqIhJYSulUKbY8qf53zt5Vt7E2nMrygK+9KwyT2afvdwa8twS18Kk5+CYEHMgu2B+MqrMuhI2egg5B53lDEcSsb/iUJe10cpCR8rYd1NdCRBp0S8M6dAggaONs/sExTUINiAdZNfbxcUWX/QaGoQQjYgqASgXdIFolRqNSC1ReH4+o3PxLrufygRQHsBQzJ+0sdix7OseVrOqlb5Tm/GPhN9ihpSHHcl0HWzRFNiCMuck23dbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TNZOBMRFspv6LyrrYvuPCdvaUfl5AUKZvZtbkwKSXc=;
 b=K9hlA3qIsDUQl+hPYpZbC8cyVdm1U92CRKdTdE/gJMV18l1D5dDzyDamu/xrFI2e111CTlR+QZtG1du2l0ExwophM66kbI5H70cl5/wtSBPovhcJLskrTsPAnYJc+4qgC10D3PsTYrt1beKv+hGGTKYT8vBk652499qoPwR8vMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:39:55 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9009.017; Tue, 19 Aug 2025
 09:39:55 +0000
Date: Tue, 19 Aug 2025 11:39:50 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Gregory Price <gourry@gourry.net>,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v8 00/11] cxl: Delay HB port and switch dport probing
 until endpoint dev probe
Message-ID: <aKRGZixtY5AxDUU6@rric.localdomain>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814222151.3520500-1-dave.jiang@intel.com>
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df2ef3e-6cd2-4c9e-9b87-08dddf045aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yF/amdk5ZJJLd8G5IERncdIhdD6gjyt/S7qC30Lmvy1c9yq51rSmP6AKKXGI?=
 =?us-ascii?Q?R4xInytSzKuNE4pjZqXdgmFE1F0kGl4plmJ2rSjBDIyDrc3KzCbVfCvdcni1?=
 =?us-ascii?Q?1QtkerJlE8Wcx3SMvD/DO4uZzXlRTTwEMKvLuRPUdJXVfObFI970yqDcgPyt?=
 =?us-ascii?Q?xFYRTU0bvVk0KTGzv8fNokW/OuxZhpttolMoXtGWDTZ9YfXl0HRRtBCZfVnN?=
 =?us-ascii?Q?vkWqYoFOqbBcfNVGoZwyXL9XCfdGfBtqokswP+qIaME91BSu6VGsyCm2IarN?=
 =?us-ascii?Q?Ax0oSchS260sggz8wXCc1e03rfKkopr91Afy73HlYjKHpgEOXktWV9kA8cfo?=
 =?us-ascii?Q?7mZWJvbQwN2za7Hmzmb7HIXIme+uCfUZqu5zk2isCPdDufhxoZLRugywER1b?=
 =?us-ascii?Q?nrXrVDfvzh/+GtfUO6NC2I/UelDc4CS+Af881jhgynzHZb52GeeOsDIvAiHd?=
 =?us-ascii?Q?a5hIGM0GTJYiRU8e0jRNuCYnGBD/J7oovuLPOGx0KLrY0IyyAWe6tMLYksAY?=
 =?us-ascii?Q?RYijvInAkGkkg126JksNdcdYasAuN2TvLfA+Wl91I+ydlF9WfvY54KasXptz?=
 =?us-ascii?Q?lPwdFTDvwGqc5jC8ffZ58N2T/ULMuoAjTLNjf13vbf/ZnU74nxJZLtmey0kz?=
 =?us-ascii?Q?Jk0GdgZSPV9ZErbdIgkiAaMpBGpDWsRDn/J8gzOiOUAQdjBIK0TmgZc/bY9p?=
 =?us-ascii?Q?f9ziQtkg9HLvtVBrHxw3Qs9nmre/aOekVkuuQLw/NcJH1uhf63ROfsFaWgvX?=
 =?us-ascii?Q?NN+0kw3IzUj1TzJOQYiaDOQiXtvkkjSZUdotmwfkvWO5Ef7GP0+qRroS7ESm?=
 =?us-ascii?Q?7Lx2oRD5RZxKoz3xuShI+DtVLzM2ISYSgZ1ti8Qzi+kXtRnA1WFcPYOyq/Zx?=
 =?us-ascii?Q?utA9nSHmV9GoOo014FKPwC67o248XUt/cZXRH1TY/aia6fr8HjYIGD2S6F4C?=
 =?us-ascii?Q?DTEcJxcEYKjju2XjRnnm79vxBnHk8BJ8umSQXh0Dam7XvlSwQCTpNX97mVnb?=
 =?us-ascii?Q?ELzK7IvE6GGRG05Pxra+mtz08Buahvc1fVwlhTOwfhwsmL2c54b7CjQsk7ou?=
 =?us-ascii?Q?692aF6cVK3KmQtf+ZejFFbH9gi8HxdfIXFRjYpOerM6H5PqdBlyrQGFQToFL?=
 =?us-ascii?Q?NmbECUDpQQzEy0qHGq5alJUxPi3rAZcpaPSPFQricv3QC2F2Zbkwx1cEvhi5?=
 =?us-ascii?Q?BTbuLT+WSJ+SWoQyrf46RP6ABOcCCUCbltTjawTnCn92Ob6bBR+cbVjh343W?=
 =?us-ascii?Q?NYh7lj7tLwOoOhmKDJJLqIPVTC8rUYTbFvhawncM1U5SBVwNqQnCyUbSYs7I?=
 =?us-ascii?Q?FCvwYoQuDZ20r9dg57LZjOQI3I/OlSTrPLzTsM3pNVBWrLBkpqzVColKi2eZ?=
 =?us-ascii?Q?YhfEAGq4uGReiL82Xs1diTxZN3d49EPTgCqV+gDgJXC1VjgSEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AJnfEdL3/uoVlbx4inBeDYvaUlSC2gIm3Q4AsF/tazHDVBsqJERkpBqKsTIk?=
 =?us-ascii?Q?QwmYqxllJG57YC2K5pyvLqVcxWo8KZpj8+3UJN+d3HCR6vQvCjojgsjBxtdH?=
 =?us-ascii?Q?eF07JPCdD6Yk6DYkVqyIryoVp0IzlQSYcSFGrLv+TV8DLpdGpeuJOOMY2sxo?=
 =?us-ascii?Q?Hu9YuAoNALWavDzTHpuWwaMpjFmbzcOwAZMgTBZi/Qzke6vZhhD7wGk1PMsj?=
 =?us-ascii?Q?Zc4pHRnC4uJHft46+zAY2LHT8HqLHvkx1UPNfwD3Mtp9LCxf9wHky9YBCOIm?=
 =?us-ascii?Q?o6wBi2k3SQRFtltnxWeG5RLJct1GdH1wLIO0QJLvosbKW9gBS2eUXCwDuSYq?=
 =?us-ascii?Q?jl4Ta930dNmoz8wBW7xjc3vNrAFrTSkOs9ICHx4JX2CU1N5eiMslLLpX+DuO?=
 =?us-ascii?Q?PGNV0bHO+4lIWvd+UDpfbKELgeaDvZ9nDGtC1YRD4wt8NdqWUHD+eYcByBHe?=
 =?us-ascii?Q?DrNoF0jghh+xL1QkGE956fsOu5rbLYNCZ7fXCUwSYjalgGroIpNcZmQs8J11?=
 =?us-ascii?Q?QLaPC7kPwmzCGZvmEZK7jyHqN3GXrjIg9cR0xIW8b+/PLttWgqTqiT4oWWHS?=
 =?us-ascii?Q?+dCWGtdpoFRxUP5ObvbvZ8UVSofWW/IGtI1RYDaDMOCGXY3jjaPBUN8j5HhK?=
 =?us-ascii?Q?rY8f8Ee5rsOj7GkXqJTsEupj3ucxfxrBtZWo3dR0MAvV23Ke9LfEfNVUpHsO?=
 =?us-ascii?Q?gyxJXodiaipxeyJW83hk9AKxN/f3pS9o+qmtcAGTsIBKpgtRkUwmY4b7qDx1?=
 =?us-ascii?Q?9RiCyEURG6xva600EtzaRbF2cK2dIsTT4hDUnVKBL+Q/5LSO7V+DIOqbAB7U?=
 =?us-ascii?Q?8xUd7+Cga2IiZwLBfu5NuwQBSEOUX1CQTW08Cp3Mt87O03xsyBzGFhK/4hap?=
 =?us-ascii?Q?zRHpt73voksgljB1upgwlfCiFMZb0Aj/ZPSTtAwEZqMOZTMVnwipB0jAulIQ?=
 =?us-ascii?Q?M58lfnqP+r4slkNAnTBEDh6zr97fzUMZlMARXrSclCV+PI6CeCH2bkoEk7oR?=
 =?us-ascii?Q?wR4f1v/2iSZZc+sYI2YEsrK56HitPW7twb/evnfQNw/bRFzlxC4CJ8LZSOuj?=
 =?us-ascii?Q?gkyAkhrKZWWcGNDcYHOgp0etDqc0rRCIpq2hHYUf1aO/ZnX8cgZYeeytiFBH?=
 =?us-ascii?Q?vQ25cSFW9aoHZokqKahdrj9uIN8wMJLmsKJdouBp3HeGkgh7dRa22MD4GVUM?=
 =?us-ascii?Q?UPIa7brzJOq4aTz07pnb8wqPQP9oOkvceunMcu5MYUOO3N9KN3dK3D8TJ3o3?=
 =?us-ascii?Q?P5V0PTAyGgNfPNGECipyHvt8kll/Dl00atruoWh9mcMgkrDPStXZFzAZIUa2?=
 =?us-ascii?Q?A2KhQeKKFKUGeLLqLTEL5KlQ4fxdgg96ADfERot5DNHukFGH+2ZSKzeLYLbc?=
 =?us-ascii?Q?neMy/oIhbO9JlyRBM4enQK6GTmOqVxeYe1xmMBFaptOki4rnKU/PEscDD8yy?=
 =?us-ascii?Q?EhpmpNyE6U3U5j7XvPVw6fKlxzDkmvwKQ7+2g1B6xa//o+PgoaJBODZxYZQR?=
 =?us-ascii?Q?l7Eww8YY+QXlYMQikcBUvpYjqQ/XlCtbHXMr6Lvx5L9kwmbDF4wApYa7RhNE?=
 =?us-ascii?Q?MH+PvSGCKSJJohY9dauEiei+hDeWQipVhay3UpPP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df2ef3e-6cd2-4c9e-9b87-08dddf045aa6
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:39:55.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrynikW/Qge2JKjwfF5Qd5Sp0Dd2eCcQQvrCadIdzM6v9PqgM0NyIpb4wNyAzu1hPDaiC3BKG9Ab1XOxl5oxAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217

Dave,

On 14.08.25 15:21:40, Dave Jiang wrote:
> v8:
> - A bit of changes from Dan and Robert's comments. Main change is moving the port MMIO
>   register probing to after the first dport shows up. This resulted with decoder allocation
>   happens after the register probe.
> - See specific commits for more detailed changes.

thank you for your rework.

> Dave Jiang (11):
>   cxl: Add helper to detect top of CXL device topology
>   cxl: Add helper to reap dport
>   cxl: Add a cached copy of target_map to cxl_decoder
>   cxl: Move port register setup to first dport appear
>   cxl: Defer dport allocation for switch ports
>   cxl/test: Add cxl_test support for cxl_port_get_possible_dports()
>   cxl/test: Add mock version of devm_cxl_add_dport_by_dev()
>   cxl/test: Add support to cxl_test for decoder enumeration mock
>     functions
>   cxl/test: Setup target_map for cxl_test decoder initialization
>   cxl: Change sslbis handler to only handle single dport
>   tools/testing/cxl: Add decoder save/restore support

I have tested the whole series and it also solves the non-unique port
id errors for offline dports we see like:

 cxl_port port2: unable to add dport247-0000:00:01.3 non-unique port id (0000:00:01.1)

For the whole series you can add:

Tested-by: Robert Richter <rrichter@amd.com>

Thanks,

-Robert

> 
>  drivers/cxl/acpi.c                   |   7 +-
>  drivers/cxl/core/cdat.c              |  25 +-
>  drivers/cxl/core/core.h              |   2 +
>  drivers/cxl/core/hdm.c               |  51 ++--
>  drivers/cxl/core/pci.c               |  82 ++++++
>  drivers/cxl/core/port.c              | 358 ++++++++++++++++++------
>  drivers/cxl/core/region.c            |   4 +-
>  drivers/cxl/cxl.h                    |  44 ++-
>  drivers/cxl/port.c                   |  29 +-
>  tools/testing/cxl/Kbuild             |   5 +-
>  tools/testing/cxl/cxl_core_exports.c |  42 +++
>  tools/testing/cxl/exports.h          |  21 ++
>  tools/testing/cxl/test/cxl.c         | 399 ++++++++++++++++++++++++++-
>  tools/testing/cxl/test/mock.c        |  70 ++++-
>  tools/testing/cxl/test/mock.h        |   3 +
>  15 files changed, 963 insertions(+), 179 deletions(-)
>  create mode 100644 tools/testing/cxl/exports.h
> 
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> -- 
> 2.50.1
> 
