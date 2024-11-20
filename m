Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559DC27447
	for <linux-cxl@vger.kernel.org>; Wed, 20 Nov 2024 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732129046; cv=fail; b=OE3WgN0SKzB1IPVALf7xZ9qd2I+kiYh7tQFPW8yz6MuuvS57YbjSxPz5e0Z9zdlPxTi9KVrqEWGTaWdQs1olEQNt3DR9sfDbC47iJMsD4CEsjW0c84XSUoiuX+ptwGmBU8XwzVMeU19LlBgmJQAlPnVUwqUIIArGVrcBKVNPn7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732129046; c=relaxed/simple;
	bh=qoCUnlAYa3j4J37jLSDes2zgjV3P9uQc4D2ChWkFEBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pUkb+Mc7jhGuA7RANhCjU58OPH0+sPqXTkAjBYlRCub5XfRCDYx2GACL+8P2Ct1rk++yBj2XstCeZ/hveLEOucdIXJh5VSCDQ2OOZx879Ue3b4wTQDyk/QX+nxnuzlqwbjN2Um130VxZwH0QO8oenKZj+OZD0JSVWsCQzkc+N64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aSikKxS2; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aSikKxS2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OU0ua/whHpDR0z5sFIBkmJcqKwPaKOJz6DbTbQ9kwM35UQIuakVtR0R6EYcgDiXqV+slLUEfzFpok5z0SuAj5NrvX96qM7HtW+iB/p4uCkparPlu0jePHn/JcrQpYzXCBFTpfszof3XSRkQfPXQU4+KGhtRELj5CAXVa6goats6/9waZKKj1gjP6Tr4m9ZMZOTgmss8v48t1bs5NorYdj7Yxr4+PJ/kxBgMvfcRyfwjfvtOWJgWeyjuKETpc64Y796SRgOcz/EH0W+EGCsVTIrBDWnrKOt5s3PN2S9MopXCugy9/juzmbWMPRg4iiQz8WfCSV/DqOgwrqZKrKzaxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP5gjHYhcq3YwLxa0Fu5knpzbDCtjyE7jCqllbzkvwU=;
 b=y6BemY4XuEuTiUV6UBRXNZjNjze0fB8QmtQzYfFR14T/KvmHi+FCjJ6y/+m68cJQ0EtFJxhCcD9tGxYsGAIPWRQjnh0rojV56bBXP3DpS/KOJB4oZBXdsmWd7mbNupdMXPLMuZQ2UsCMwp6yIkq4t1kCdAsrUPcuUzDOdFhOd/I9MYmxiO3A4phWpBMdP1YqpqXsratsWoVoKgyh2MLc5WKaf4RA3DA20HZBqmxeGoc6pRrDgopS+e/O7shxPdQDl5VFEOFH72EfTZFlkLN7EXtM/46313MFnbz/P8z7cP+P82uYuqFPH3gJXtvvm1nG2tjb2zi+gkndkRbJWwUDcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP5gjHYhcq3YwLxa0Fu5knpzbDCtjyE7jCqllbzkvwU=;
 b=aSikKxS2/R454UD48Gt3DYgCMVebHMljadtLZ+DpDH5bnTW73Neus+Ei8v9ni/qo99ZFdoFkC2cDVqy9e8QwSNksP1+1GvKEYQV0ySfSLpNpq4ASdJIDFifYw4rLZhic5QztMoDdR5MyFCG/apmTmRMPqccPWbrgA/V2XN+nzHErDNIt1FSNJpXfwHdC0GKIUpP2ZkKBol3+mtIfDS8xaOSTwT5EkkdMMOSbbcVgoWq14GKgBBWlspsyxrZmglKyiE16sQjQErAodUB0GidE92La8klVWWPH7XEOOPuD4jy4nZWYlcNLn5PcOasHGcG9f1qPll2VXzBi7z3RBrWldQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Wed, 20 Nov
 2024 18:57:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 18:57:21 +0000
Date: Wed, 20 Nov 2024 14:57:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH v2 0/20] fwctl/cxl: Add CXL feature commands support
 via fwctl
Message-ID: <20241120185720.GG876522@nvidia.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-1-dave.jiang@intel.com>
X-ClientProxiedBy: BN0PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:408:143::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 68dc30ea-0c64-4539-d8dd-08dd099529d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/OOadVa7VlV21hiKzrOM3ghlLI8Ofarzd6poiAdglvNOC0aFZQ0GYMl3X2/T?=
 =?us-ascii?Q?Ofq9RhwyJr7sHDUdnNhVmN7ok/+0yA2LBCsNYwMxlMmmMwwRUvb3LBuxo0nx?=
 =?us-ascii?Q?kMMksnuDKwtRsyI0AKMsVV88t7Zr7M01Y4FulSitSUWjXCBe5cIVXp7ynm74?=
 =?us-ascii?Q?vdg0dAnRRGNKnG0DQb1QYG2S7iVKUyX7IdaQh4ML0CXceYnnjI9TDICMj+vl?=
 =?us-ascii?Q?EkT6FP376RSBSu4Hc3WVMP0skk9fsfdg4RLZ4qmE5aggXiUlfDp6FRpvCJMg?=
 =?us-ascii?Q?VWaHIrrM+58OlLQ5wasLbQSCQDkTygPMoB3ja5H6TYZPpCtXht7vVLv5lN3b?=
 =?us-ascii?Q?F7rs6+jboqbRTaRu3DQp+SrUpYCswVQCWkWixqUEMenUCzO5KyoCAjObyA41?=
 =?us-ascii?Q?jV2cs3t/ZgxPggU+bfTGQaofiEEBDUGdWWlf4j6C09465B1t207gmEr3EK82?=
 =?us-ascii?Q?goaA8qI8BoAlSQP9LDmM6eJFVZwEH1QZV6AvaQe75HyfhjhVYHKF8XC/HOxZ?=
 =?us-ascii?Q?zq9etkx2EIheKGHhtczy30QjTXaOChBQIL1wTrDja1R1y7TQZMPy5h7fhku0?=
 =?us-ascii?Q?Hb5lTjR+zTGcIIh2y7D2x65jF0JZe3GBKsh8RCTf8TmhIFV5GZZAjnLtecEV?=
 =?us-ascii?Q?m32e+TZkEsZiYzNxxSGMPwMWGsNIsCAcvVCsDqeYWbzlAzvROBI3OCGXr/ik?=
 =?us-ascii?Q?R01HMhEv7yXso8qQ7t06dsqpLx+RY9/iwxNaI9aX6sfPsL7aLFVQ9C8vCoeo?=
 =?us-ascii?Q?NWpeFSepKT2jJ//UO03VhbYtND73hdAAzJhwx8PUF+DpdPQl9+ddRpX7ae0/?=
 =?us-ascii?Q?zkWVoAkfhlwj1/6jYHMHUKTIC/+VDqJuLZASf41FWqr1MwDQa2a86cBBnuGH?=
 =?us-ascii?Q?d+vqpAwYalpkcKnqJP6IK8YcMVl5eNcyid1fKwXrnLTRiO3+Mgs9aUyW90+T?=
 =?us-ascii?Q?T6lJwKi0aUkig9i3TBcTJkTEi+8eMDjQcI9jIN2h4vfRaIFzZhTaNuVdl9BZ?=
 =?us-ascii?Q?GhV0szBJy4QZC0+2yYyEX3TjvnTfqE3pdRRxkWLyrbgoiJCtoSOaiMs5G0d6?=
 =?us-ascii?Q?m0+JwGMCQWhSZRHXJNzXU/x4pB5C6+a39Q+drf3RRbh9UgA1hJ4IXg20q/Kz?=
 =?us-ascii?Q?biT/nn9FVrgb8TTldedBsRlFnca1aY6UAAKHYeZoqDapa9GMYkERebl/1x3e?=
 =?us-ascii?Q?fdTzuPwDQ7gAtznrAONKLNIXyQdN398AsLAPUOCNo0DG6OnMiUOqT9YD0BkX?=
 =?us-ascii?Q?M0UA0yS/qtsXEwQLrA4LmZtx8vqNJqu3+LvbmpPCiNsN6w79nsppvX+yi9ZV?=
 =?us-ascii?Q?U6J0qj61DBnhlcrxrYdpqK/l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wf5EDfVcmm84baPHrdJkZXZmDPVkF7icS7V/t4btXFX+k3V4OIlgrT6nGD7F?=
 =?us-ascii?Q?nGoEyH99u43rGLzDwe3zgfzMb3IGDvqsL3hyYTwaNSIj+f/UnDxRmT68IYTp?=
 =?us-ascii?Q?JkXFG3msmSDcJYWT4qR6WhPh5kkaylItmOD41qH/LXFmZd881l6y75Wu+BN3?=
 =?us-ascii?Q?Sk9u4qS9kzzGV76q9byE219WU+4ghzHn2cyH0nhJMPE+LnW/ybsc7x6fxjP4?=
 =?us-ascii?Q?/FaXw/3IQhORCJ6QSpW1Njr9cou14e3DzA+VPX/5ctwz8x3WPcD3QeOq1Md3?=
 =?us-ascii?Q?PkjCM0Z+cjgmhmr/8PZEe9fRzdHI4C0N06XVOJG4F7M188VUmjRTUbi8eiCH?=
 =?us-ascii?Q?F96OiPD7kCLf7EcdVBfsc0Ym7Merd6q5CydDZYdUjWkwUfeGV+UFsLbX2waE?=
 =?us-ascii?Q?W+BNjK2+agZk1TzkxDZ3DmEMqpTc5p41ymNiNFMWtfDwxeQrbemwBX2WK5Tu?=
 =?us-ascii?Q?OzsWjkSMBx0TQ2e3vvF863l6srHKVfpMuLs1jQ2+RgI50e50OdtXTC0I02gG?=
 =?us-ascii?Q?WAqJtiWxs7O5zLbaqKuSCAMwyq55lEXjfp3ovKVQlRAncGogVOiz5BsKaTwy?=
 =?us-ascii?Q?YNAaQBnvhth8KuG7Ccz7Ug/PczmJVz4N0rhg/XSKrTlfFqxynDQhbN8we79y?=
 =?us-ascii?Q?Eh1keRsYSfzVW0VV6OgTwGdsxiBPfiKRFxsGxETO686Gn5OIP02pbcxcr0Qv?=
 =?us-ascii?Q?8pibJGGmpbGrbpggnE9CxEH+/ZW+n81jgoybkaGYqoudlI0is3Wi+sIn6IoS?=
 =?us-ascii?Q?O3SVV6NbnltCq7rfMIqzIOCzcaWFZUgpsvKZ0zhqj1ftMRFl9LEMl34WLhww?=
 =?us-ascii?Q?ya5Do4c/6FnroxY2evQ4DMJYxRu/+bige2lo56sb61ZOngbCwUOrMgQbGY8t?=
 =?us-ascii?Q?DyghLYvGoV7KuHZ1jVTd/V4T71dVunx8vBVneB4oT6u01BvGoboTH8XelV/r?=
 =?us-ascii?Q?obmPBZY2fCwwNBL/XUEiWre6dR3Mn+mcp4Q+8ZB25+b0euUSdBj3O5efnu0H?=
 =?us-ascii?Q?srsuQM0rFC7RTFnapqTZBg8Ni4IGtCIfWpPEysntBriuMvhpkvAAQrgnNadr?=
 =?us-ascii?Q?uR6noqOy06f0IOZaxzXRvw22qVUb4PePnp+zpZammOHZORW05l5wDnqTIKZL?=
 =?us-ascii?Q?fD90f+OOtBSClPaheuWjsckRj9GowXcIhTenl4yUKpl7R77hZOsAwGdl/Cu+?=
 =?us-ascii?Q?hqVnb8ZkCuGnXxPEcPxraMRLCWaNInJ0NpbZAVB4uE9chHCZk1Eqkoo9tJwH?=
 =?us-ascii?Q?Yul9izsaDYvYEh7H9XYS2jukZB4zBcA9mDGHsHSOSxRm9zUhZzWWyL7RdajB?=
 =?us-ascii?Q?zmXBnMYRqtFB04YfmmVwGaXN49Rmu1PrZjGaCGIVoKNIwWpU4Njbibw5zJcP?=
 =?us-ascii?Q?mV+b/0ms56ClhgTd6dQOJIZxd9XVybXXvThEl2BiiOthgLY+GdEQziqZhG0Z?=
 =?us-ascii?Q?66zAAlQwbvJsxkdlz+UDZ9AoEtjnlpkT9Njtd7w7bl+ga36wyfGxVJyoXMO/?=
 =?us-ascii?Q?c3i3rUrSxZ5FgoOYqb8/0pLci8lzJBREIjU4BHgeo0lXaAHEPOvuLC1R/xII?=
 =?us-ascii?Q?H9qr6NoHWhSjoa2IWqainc5EF8FvzjqiIC896gbM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dc30ea-0c64-4539-d8dd-08dd099529d0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 18:57:21.4280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqZmoRscTNYaM+lc1S7XCwwVJTmiEn0jxWlGPAE8Eq/lNqiuhQulJMMlFazwK34M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

On Fri, Nov 15, 2024 at 02:25:33PM -0700, Dave Jiang wrote:
> v2:
> - Dropped 1/13 and 2/13 from previous version. Merged upstream already.
> - Combined changes from Shiju for "get supported features"
> - Addressed comments from Jonathan and Jason
> - See specific changes in individual patch revision history
> - Added hardware command info to FWCTL
> - Added filtering to set feature command
> - Added documentation

I looked through it, and I think it is good enough that the next
posting should not be RFC from my perspective..

The amount of CXL core patches has reduced quite a lot, it would be good to
order the patches so CXL was grouped together at the start, that would
make it easier to create a shared branch down the road

For instance very roughly something like:

>       cxl: Refactor user ioctl command path from mds to mailbox
>       cxl: Add Get Supported Features command for kernel usage
>       cxl/mbox: Add GET_FEATURE mailbox command
>       cxl: Add Get Feature command support for user submission
>       cxl/mbox: Add SET_FEATURE mailbox command
>       cxl: Add Set Feature command support for user submission
>       cxl: Move cxl_driver related bits to be usable by external drivers
>       cxl: Save Command Effects Log (CEL) effects for enabled commands
>       cxl: Move defines and error codes from cxlmem.h to cxl/mailbox.h
>       cxl/test: Add Get Supported Features mailbox command support
>       cxl/test: Add Get Feature support to cxl_test
>       cxl/test: Add Set Feature support to cxl_test

>       fwctl: FWCTL_HW_INFO to return hardware information
>       fwctl/cxl: Add driver for CXL mailbox for handling CXL features commands
>       fwctl/cxl: Add support for get driver information
>       fwctl/cxl: Add hw_info callback
>       fwctl/cxl: Add support for fwctl RPC command to enable CXL feature commands
>       fwctl/cxl: Add support to filter exclusive features
>       fwctl/cxl: Add documentation to FWCTL CXL

Thanks,
Jason
