Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014591F12E8;
	Wed,  8 Jan 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736347965; cv=fail; b=UmrdjJFChx9qSuxelivoRCgCeICYxQY7wTghObMScLvjkT1X538XaaOI4XDRhD4rvVTFiItcwgWD9J4s2B9ZjzQ7lURXYJeGSIemal3PuRdr0wVZE7Kb2WlPBensCvqrG5C+BeX5s/I8OhNmbUjl2GdOislYrC79Z1tg3uiSFXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736347965; c=relaxed/simple;
	bh=9tjM77m+rwTciB5MVfz73puWjAeUz5+1vFk/JrZV0c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=US0UFQdTOzUXEi5q0SgKHtgkDPDOORCKebCKc9duvTFa+W4iQnyScjC0CcRFmPCqKLGaRkb2SkYwqikfQZZddFiD/7+eiv4pt5J+4bnnOfPkzJgPJNP6ao0dRHdxXV9hz946V+8QkaJLdx/+ehcmBbZpwCuERHrd1/F2oN2ODMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mD1hwefW; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mD1hwefW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2kZ/+pli14eeMlxtpWUOA+4s/zscBnCe7uq4ttiSUEWfM8vkfobJEch7mzOEWHJz+118c49VSyG6OgQG6U+vhgVHA2Zt6rioBAcqKD+C/2Y5ZohuLtc/TncIb1XyVIdC9jooVbv11pmof7yT95r0+oQniszMtXQhojTT0z9qC8eo40p7ASI6PQYd3j8qd/rNPND13Uq9NyafouE63rCtEUaDVgwfNDRF0+KjfuXZiuZ6BGkemg6/MCL4UC71lLucc3aFTF9D3uolHdF5w0V8f+SghmgthFI3DbayDdxwaMXJu1YK1J4677Alc/5dpXy0VigOiwmTsjh0G8gf2u89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc5FM97BBDRVMN8VFEEkWerpY7vLMaZ4EB83AHYX6ow=;
 b=mguoXLNtjA1iD9wumsh+gUt0ML4z4sH58GRRFmLnaVd/HUc/sgUTHvDayL2LG02G/AlHurgiLiws2IBN36whAk4cSLfA4C8GRXgi6i2ViipTp6HvRpChsHJ04ojcLAkmFHDF1NUy9TBnMm8g0ym18h214OEVZpLx5qhIcnRKcc2I49OLY4WGGHinLSh7R5IH5e6WXgkgPPv/xoMQAP/ZXvOB5esDIeN2H6TKHEdKHgekMFAUxjzN9FIaT4vs65F4yB3qFsuKYHKAglUoENvgbzK2U5bvPQ2KVrR18f3szZlaoQXt3c8GWDQ92J4y7RaWbGM2K+XJBBPrnCx1z4JHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc5FM97BBDRVMN8VFEEkWerpY7vLMaZ4EB83AHYX6ow=;
 b=mD1hwefWJD9AEJrWqObu0Q19N1kpsJ5RyXDh3h31rJg6KNqXZm2w0idTLQWRLXt8YSSMXbd62lsGN1h7i8k6dlEw6FD49QRytazSBaNXFey35+RBPlT+sBoGRNeTu3oYRK5oB0QSWUYkPCd+VEMsOvsmTn9JG30ozdfGON2Dm3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 14:52:41 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8314.018; Wed, 8 Jan 2025
 14:52:41 +0000
Date: Wed, 8 Jan 2025 15:52:35 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z36RMyf21c3l2ilW@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
 <Z324ueZ0Rxj4Sq6t@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z324ueZ0Rxj4Sq6t@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR5P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 684e5cb0-ae25-495c-97ee-08dd2ff41a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EfK38LjivxmmDsoWcVj9wEiOHhPTv8pnPP0sZz6CsijHw2hWxCEqaD8lZF1v?=
 =?us-ascii?Q?TDP7EuKnOoxqKIgckNZdCCvSQvxTLnY13dLh945vLyCyIl+OV3Sgcmrha5lY?=
 =?us-ascii?Q?6BYmIYXCmP/k97dvXW2nBT/nh6ECG6jAJ8dI7/6feQnZRyFRnqHR0JAjqUaz?=
 =?us-ascii?Q?0rJcj1oIVintR6Pj/Ts0T1UNx2xiKQDJvzm+nkVkAi9Ye7P7QrU9SsiH5yEt?=
 =?us-ascii?Q?gTKZNy+m7lsVul0k79WHCkQLE5XLUSdvdyU1v/L2LWuRcTERBA2RoRru4WFe?=
 =?us-ascii?Q?8smsMxLB4c9X4EQo4da6fKc/xnL9uikb3VmjqXi7uprS3vH3nmfn2tB4KtE3?=
 =?us-ascii?Q?Ak7B5cBwKFqq8hA+3uyfT+XDrLwmEOfFQ7jwEUohMtJGFFT+AvAyHPQmmWqy?=
 =?us-ascii?Q?iAVFAaGgKX6xbp5e6DFHWdn5f6B3wgSK3jnvXAKijYFaeXUMeR/UvuoHOmno?=
 =?us-ascii?Q?ZrEtIVtGixsTS7Zss2jygm5L47Pp/edy6THQDtbZFoSsqhX4wHY9QxCw1erx?=
 =?us-ascii?Q?4r519c9JD4xJZNtOtczIDAinYueJ0xeIZd7c0WdGzL0tMd+IkCyAGDQtAxAP?=
 =?us-ascii?Q?8WwmCZCnzAz2C2QwEnfgfou448at66oUVhUhST26cM/9iALEFpsmdbQexZaa?=
 =?us-ascii?Q?LVFAyxHyrjRJ/MIy5pkAgMtAHPJIYYGmgw+15IbqM49XcEljcuX7YTjbR0rU?=
 =?us-ascii?Q?SOntjNHam0PO8crjOEdJXMBD+TRIANt/cn/mxunAIu4reHpcXf/k1MOLVI9r?=
 =?us-ascii?Q?PNnA7j2rkmInjl1gkMQ8vt+A7mev0Ht61sMANloq6GYyiHFbaoYahNqRVTrY?=
 =?us-ascii?Q?ucLbbmbJeR0AK/bIzMhJ3r4RQC7YQxDReQJTVNjOfoOKP3eI26JZPfbKwg7p?=
 =?us-ascii?Q?HgpqrdWpDHS+1zmDI4EyaGNstiryQajOFUUbkpzR7gbpcCZ861tgg26SV4gA?=
 =?us-ascii?Q?lfIBcyeA4xeK0ur795J+fSzrQKrD8O8hbkIRoNh6gJbf0lyrCHS5v9nP9Qp9?=
 =?us-ascii?Q?2cz+oHlkpg0ENhj9B0o5sEFuQsujwi8zIrIoo+4ofaN0s3/4sXsxprsOO/vQ?=
 =?us-ascii?Q?hq1kKMrovkuZf5JqhZRjrC/7CSTuDhiEviGZCCQ6uf94GcSeMAsP8KTGpWTR?=
 =?us-ascii?Q?t0tdPhYBjbqFgjnfg0SpAhfpxMRVDEMuxVo3o+3A2Bhb74JU465OLfabNG/J?=
 =?us-ascii?Q?/WLMHKNudHnm306QYns66zqZrAAE+7Mrj+otxwZkG7VmrOFDrifHKhTTpCyQ?=
 =?us-ascii?Q?x8kMu9yvizGR45/Jt5HHU0kt8x7yTPKVtQAypw4N8tPOPTeO/6A+5Aqkzlkm?=
 =?us-ascii?Q?K3LOvr+RUnav0MG//X2ldSImpJVb809P8o26B4pq3VKy2rCStGLsVWSakNt+?=
 =?us-ascii?Q?Vz2JU4svpzR8tLjjm2mB5WONSlUq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PJo59iH4PKefzQt3snbqedokxyEU7vMzkoSEtxoNDw9FIqmHZakkBydx+RTu?=
 =?us-ascii?Q?+NA388smwEr6jqImWSF6sGXIgfonyYn8HKtuvrKgTZX317uDZy6TEEaSZm9Z?=
 =?us-ascii?Q?MMwvUAcCqsBu7jKKJxZARXW8dKuUDMlx3IDOpJgAQEUvqr1zwxbLpaieVlML?=
 =?us-ascii?Q?S0IbmJk+fR5Tv43S2kW7pHXW8cb3hIQc8SckTHjyoADyNVqPFeaSRgFpctJW?=
 =?us-ascii?Q?k7Kr/37Hfjm7EecUkWY37RkLy0rqWFslNXd8vAtSLO3Xsea9qu27u/KwhkJd?=
 =?us-ascii?Q?+oUfUcUAL8igOb2A0pDMoDhrvXH3ykT4bXl8Xvatus9PbsxWyyYIUveqxXWS?=
 =?us-ascii?Q?H1SX1ZXGH5ameY0wAGthz4RvmenEAkK/Pnz6vPBevYlMaHtSGZnWlTkdjYsr?=
 =?us-ascii?Q?6GQ1WoRC3hRjsGzEXE6KGY+K64onhe2l2XNbwveCRyvLMY1e5BgzjlYj6yoi?=
 =?us-ascii?Q?4F0W2ycgfyHHK5yAcDxCUU4x4AH6Z7m8ihxRTxTFAGYxRiXpfZ4xIfrt2yjp?=
 =?us-ascii?Q?H+VGy+Bru05MWHPmaZLH0+4+a/UXCbwuYXmJP94Dp6uygG3aZHLnxzSolAbG?=
 =?us-ascii?Q?e+3CKmQdG/xAjYI1KgKNWpMqOs/W7ab4DGcpwhTeKVexkKlLyAnr7/D6Imxn?=
 =?us-ascii?Q?nWWY/lVFIhtQHwcnVmS9Gi0qB5f/MwFav/xOzDuybXlnoPbmo5sLozTtKcv8?=
 =?us-ascii?Q?gXTGr6m2M8aQrMq1H7SiUZhnJqzEkeIa6OxD1RIPPiQuegmxqp95H7Kn4Vbg?=
 =?us-ascii?Q?BBf9VOomyMEtOniMmLs/b+qhGFNUEZ9L01tuV7G10zci8IvO2z6mdOCn0qHv?=
 =?us-ascii?Q?uJpjeD7ulH5zlSeJ+AziEfjGApT+YR4LEUam/OmaBSv7WHtx2MNpblGsH4kL?=
 =?us-ascii?Q?K0+hHY0YS2cr/cF/wISmIOmunJf5ryf8AEiQIK5NowccG9QCtb9RIJrbaO/V?=
 =?us-ascii?Q?fafCWVjcjgvtCN/zjkr3nrqCZniyRN/8FSPgHpwqwKy2jMhZK4/BrHOGfMWs?=
 =?us-ascii?Q?r6jYprJXN5X8zljztZqrP83leVCEQCzRYXCmy0uOLPnqY9uMaVTJoRyXnYNQ?=
 =?us-ascii?Q?6FDCJsVU3Vgrwx7mNxddtxXIUw5doYLEKh1AO5lFHxU/xLnYPv+u5vVrG2gy?=
 =?us-ascii?Q?XxmtNzQ27H5CnaozFiaOtkA+VzFHB4fMiMYhcJeQ/sZM5pX5EiAWoY83qDGf?=
 =?us-ascii?Q?SyGXmkV7h0KOZ/on2U2OVE6uxgn/Fv2xclt3OSoHKzH5u15pUenVnfZGL4bQ?=
 =?us-ascii?Q?JFHr0OVo9ki+s50jOaCnVs+BtdPyanygy0CFYXdCEX1pld3jvt61uiK986Jx?=
 =?us-ascii?Q?xV7NN2NWC/KZx0+O2pk+y5liy32/2oV2GIH0jPzMngtzSpWLEaeqM0HpupsG?=
 =?us-ascii?Q?DrnOFN+gxpoXkon+A9533G4mrDgQXcW9pf3fFtdW75LNPtgblmI7wdg77XZ2?=
 =?us-ascii?Q?NPjJSnDPPoJckOqZfKgtTK2KuA7MkcstOVfEEh6vt+I2qEZs72zo4whrXiqz?=
 =?us-ascii?Q?Jg3y5gp8LwAgysjt0aJGoYfxgubAc5bdlYLBbsEfpDOhN/m2UdP95sGygupb?=
 =?us-ascii?Q?OPDmg1Yz3iRQs03JbhmDzMzkGRz2wdMH+T779syf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684e5cb0-ae25-495c-97ee-08dd2ff41a24
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 14:52:41.5536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDzlTzr71R6WR97BBdy3uItnQ9HmFqkOHP5udxigd+juHcfsqZkYY4L2qSIDNPPTr2XgXz1iwBGwq0Zd4+XT5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

On 07.01.25 18:28:57, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:10:11PM +0100, Robert Richter wrote:
> > 
> > Add a function cxl_port_setup_amd() to implement AMD platform specific
> > code. Use Kbuild and Kconfig options respectivly to enable the code
> > depending on architecture and platform options. Create a new file
> > core/amd.c for this.
> > 
> 
> A build option here specific to AMD doesn't seem the best. At Meta,
> we try to maintain a platform agnostic kernel for our fleet (at least
> for build options), and this would necessitate us maintaining separate
> builds for AMD systems vs other vendors.
> 
> Is there a reason to simply not include it by default and just report
> whether translation is required or not? (i.e. no build option)

There is no (menu) option for CXL_AMD, it is just checking the
dependencies to AMD_NB (and indirectly arch, platform and vendor). In
that case it is always enabled.

Thanks for review.

-Robert

> 
> Or maybe generalize to CXL_PLATFORM_QUIRKS rather than CXL_AMD?
> 
> ~Gregory
