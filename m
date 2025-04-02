Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7123816C;
	Wed,  2 Apr 2025 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594711; cv=fail; b=CLnuEfGymmcUER0IGlOwQpIh7VmrinOWVK7y1lU+KIDHfIQKtfyV4V0Qj0gBORgcMyegshTkvjdeGy1ygTR2BxvamfGannAYEMn0yKWx5H5b1EnFzk4RCDRgw9ZUkAgzSoL5gZfkB6x+d7eJl+WglzKh6Jj3yN4TwtMTQgxGQdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594711; c=relaxed/simple;
	bh=jHSJ2uBvI9AFrvS5WzhYhKh0+7OOciaNkBTnc51hesE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iRhZs9XzcMNF761aKuwtmQVqj//rUK6IsiIBLteEQjhAkuRFd+7Ly2eeQjRmlXcEy/5oWE+XEs2liobeg6qSL/d6SR+1JVe79BayFr3jPAQDTqFMr/m3/3nxJeVttI35/kdTZPu7ILpfDE/gYrVeLUilBIcc4cvSO7blgq95/7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dcY/x3R+; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dcY/x3R+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0VDyxEX6yQI44kmpfEi76vpiRXwYSODktyYKBUNvCXTScyJRXq1Xf+zl0Skn/w5T+2e+0El2a9FJzmYcslipmElqGuMCClK2zrENKH4hrCEun/xGIto20V6uCkBGR7m/9fotsYTN6U1Y/gTKxEvRSMU+YQsfMVKLE3HpK5Xg29TtcnhCSCv02v9dSkx0rqoQam+IjvadnziNpeXJnSQqA9kc82bEgeN9pxmcFxgwsrVXqAhsXClve4CliJM2kaafo1Z20My04uaVVc6g+NipBZIEcfM87etSn6o/l923RYQ8LAYFoPb7V9M2+aueYy4WT58kcpbCvzWCcYD7riW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHT+IJOMWDsBu7JpQ/kSQKGLbKKc9HPNsBgq6DwYfL4=;
 b=x6awyIxER++84qDbag1VQRLYeSanV2MpMO99nB7fuWr0lcsMQUhf0vBVLikiKfYk3XkMBIoZQZd4EnzvNl74doO+Jt11nZ0gySy8qw8DlkAA1t8v4Gggrve6dbZc+tCm2/xtU6mj3EKkhHQwAc2wTZQQ+We6rCB5IQLQVCzr1/c8odsWFHKfPp3E9/t1ny+QPwROymUzZbbOtUMQMY1PyTR2RPgB/nVdBx8k+8rB8jUVunOkAtNMHlu9c1XUlpzIVWkioKK1M7XprCvnabgBMOEx1XTwz76p+texozagzxynFw9J3Rpd9rF9uqy3802WZ9BZFUygfWxY1fgDGpzzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHT+IJOMWDsBu7JpQ/kSQKGLbKKc9HPNsBgq6DwYfL4=;
 b=dcY/x3R+coHJxeAWC1AiGgLBdmVVSpZ8SBi5kmM8yJ+A3w/FFo9bmOr5SHOvnv/3oMlTUUnVcPtPwpOVM2Io29BwqSMlGsdaqtRq56WuiF43wguFKs1quHHHdHkFGfaax/12PhXcZBUN2r6bDebZ3tKFZF5yhGnGfrWzPrNxesQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 11:51:47 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 11:51:47 +0000
Date: Wed, 2 Apr 2025 13:51:42 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/4 v3] cxl/core: Enable Region creation on x86 with Low
 Mem Hole
Message-ID: <Z-0kzvPAS2JrNiIb@rric.localdomain>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <Z91Au5en7r6D7IsW@rric.localdomain>
 <3301434.hkbZ0PkbqX@fdefranc-mobl3>
 <Z-Zlrm8emmOtQjhu@rric.localdomain>
 <ae1e1b6f-3435-44f6-890b-7c7bd013113a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1e1b6f-3435-44f6-890b-7c7bd013113a@intel.com>
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: 842808f1-cf3f-49bd-89e9-08dd71dcbf6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mUvC/Qol9RNzgSyA6LUjTRL1jrdAx3Y92Dl6P2ONIyCMQ9vKxlQXwHJYzZW6?=
 =?us-ascii?Q?8fk0Jg1ielp9Xz92jvPHKygVB8WEj5QwxC11UIK/mZqg9jy/xOk1WltlJjg5?=
 =?us-ascii?Q?wwYgkI2zyxrtcJ9hLU08UvHP4gXTgaSPnWAYxUGUS5nCMuDYL8FCKLgLJhnv?=
 =?us-ascii?Q?qdoL1oUT5cyrZ8adavzi2087bflK7Pdxoo2eMz6QiQeagYWWR/iKXdzOfLZ6?=
 =?us-ascii?Q?O8kfzxRytBbic/g1qlFQWQZhlIdLz4T3ZarPbLYtAMjzy/dK0C7HzMTc9W/B?=
 =?us-ascii?Q?b9Hy+a/fLGUiPf22rJ/I/jl31ykildEUzAkW01DfE5mKwf91i5Fg0g9GDf5e?=
 =?us-ascii?Q?//FMBj4wr7FZ9iHnBYG7B6EmJLWJl3neul0MscFFTB7YcmlHCvCBWcT13Gy9?=
 =?us-ascii?Q?JI9gI69y2mUdgKtUokOXRXOexmqjpgoerURenR0kqc2AKTl5nqcHustndlwd?=
 =?us-ascii?Q?BXLPyR3xAElNB7Wn2Y/TAxho/Vr5Jngt+++J2J+kQsvzjEK/TsJ7nPR07A9T?=
 =?us-ascii?Q?5yVsCMJpAV5bS19jhgVmak+km6YtyjOPCnlBWf2RKQFdGrl9ui95yWuOueSE?=
 =?us-ascii?Q?pgjnuLRC85IubZd7Nc+GcFh/27AYjuai6TRj86dh5V7p6Vcn+J32UmK3fhQW?=
 =?us-ascii?Q?TUxlk47o4UPvWzZrHwQ3570SCUXWNr8ezCQGCdpWiP2N7EkeblHu6bv50lXl?=
 =?us-ascii?Q?9JihTewJZ09PDhK8gz4Z59kPI8K5CrEQ75nl0ndxqjDl1fI1jzvGLBvorM2j?=
 =?us-ascii?Q?kw9MCLC4dnTA429M+wmJMqW95R/Jt/mvmbqrfAGmf9+qYurN6Yp5dcH9cb+r?=
 =?us-ascii?Q?/HIQIA2krhVjVeU18apAcFfIVpB1ykbZwA/nAZn6R/2ZqtGcO5OZ2CO8UEeT?=
 =?us-ascii?Q?CDiB1GiKA7b6X8NjI7uGkz3KlU3lPLW5qwHURDNrDvjCneOTb1xpInqitP7H?=
 =?us-ascii?Q?NaShetVDTqiB/VJYh2r21gpAU6aFvJdldy4CsEBTiZEvEezUopgdFhxj5iLl?=
 =?us-ascii?Q?dzGVESGde5XLwCnQnwqEI10VpIIwHYlxcAXHGQCtLaJyUAjg1BZ2pEXJiwov?=
 =?us-ascii?Q?tQMlIvhkgsrpkFbiwzx5oKu4gtd1eS4KOyQyazdq8SmL8H7mCuQD+/WqiBc3?=
 =?us-ascii?Q?fSCEdJmOImMQDkyjbf/SJHvJz/NzgzWGHN4/nI7Ny3n2I7kRmbc0NScVZK1Z?=
 =?us-ascii?Q?lq3r6hqUrgSTzexGqXczMZ7zrJgB2dTf5LxS2W4sIvfWDo+SP2oUHdz7+Xzm?=
 =?us-ascii?Q?NhwBaJFze3mDsMMwCSW5D9xxOlAAS5psr3AULbr/Mmm/o8Wl9UD78QD4zok2?=
 =?us-ascii?Q?dG57Fcgv5NG28bUVMBL+x1sNDn9hR+GGU4H+KVaSR1lcC5VkUPH//NixfJYH?=
 =?us-ascii?Q?hVwzU3l2yA0opICFYgieUbMrSqTT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/8IFzMVND9SuVAyWPYU5CcWxQRoC2fmSZnC55lV4aCzJmBg8qV8PteJ1SJry?=
 =?us-ascii?Q?Aj0CqGcvQIx57KvqKIseQTV5tQE+7ZkHqPmGoIs4EaumMqXnzoTejteY7Kqv?=
 =?us-ascii?Q?l0tGhBwlFg27XuQHMg+iUuJRZhS4P3euH1GS9d+kGn11+Gv/TfXH++ipQbq4?=
 =?us-ascii?Q?EAF4d3CMSGtDzAVLQsvckN3IHlrd7WIsU2H1WQUmgYYt9pj2ZNxaCFYs2W/t?=
 =?us-ascii?Q?7yRRlG3mTvju6O6OUKfV/GW6SwL+mrZ8AOHZaphZB8ZJjpuk6xHsND+ARzn2?=
 =?us-ascii?Q?2Re9TuCy6QdwYYemXVJFjFjze7gZffx0FoRnAD7dn4/nkqtq0KOosSy6kU+z?=
 =?us-ascii?Q?M181/IjFhweGjgrvM1WCect3Lb9kMfCyAe/eXXPhLQlkf+OfUHRPDVaDLTAK?=
 =?us-ascii?Q?+tdcW5pK2qRmTjdsK0UuGcDy2Q7ek2LK5IQC+1fH3TAoX0naQakqrt+ruERt?=
 =?us-ascii?Q?G4/DSc5ZP7/tBB+1kNltIsea1kY421jNrEgFlJpRk3u6y6jVKdkD7oqcT1Uq?=
 =?us-ascii?Q?A64V7SWbatGvbbQmpd0kQ3pVYTY8sU+LggVkVHGbeh+7Snle0aSuy2jF4Hv1?=
 =?us-ascii?Q?3Ut5rXhTKPhd04oBp8UTBi5y7+aWDVYrhxIT1ItVaonhLcTW5mldUuXuYNX4?=
 =?us-ascii?Q?hf+Rx2ASkPNTJBKJXEQdaUfm9QPVQerOoqvIpEZv9fbKCQ5wSm10w7zqqw07?=
 =?us-ascii?Q?FgAATanwzJz3wL68gh5xptCNNg504RVIUvtGSwYXfMFcfRZvNTRsZd7XwtZb?=
 =?us-ascii?Q?eAcXLIZxSp3WlhQqpMCBDokDJQg8gPL8SLhyKw+yA1egmx7babZai2PC2UKa?=
 =?us-ascii?Q?PoQ8urgUhFbEjETW2UtH0A8ebh+5G7ZBzNOiU73dUN4Jum8w59sDM/KjFGMn?=
 =?us-ascii?Q?L6BjccJtRJM3sVCGxMK75HrXYmj3lcMcB3cLi1KcbJ8ovyy6nAqW5Ba2aybR?=
 =?us-ascii?Q?hcmoLOsQgDvIiV5ARUIl1VNTU6BUYqr9YJshtHqz7vjc6P4d3gsJXU8Clx/2?=
 =?us-ascii?Q?E12H9YX5tKtE8cbiXJB8W000L7Smbz7K/5P1oxOIOMuttyV4nXR8UhgfI1TK?=
 =?us-ascii?Q?Oht7mya8gGSHBbb8gfHxB+Rlrs5uECHdwFtstXo/ORvbxsnNZELeGAE+9XKX?=
 =?us-ascii?Q?mzriiM6LFiP6X129B04XXNfQ1ARCRvtY/jNzMUSC+WIze2+O3nYSlH7r17cc?=
 =?us-ascii?Q?1aplyMsBxWkV30rtheYtpuNIftWahCSLFK4Xq+H71OKa8HldZtrXUf3zqT7q?=
 =?us-ascii?Q?nGESKS4F9JN8nK57NNyoRYt+Kf+j3S/rlfUe5H956McZzB3J5ChU+16IxBFB?=
 =?us-ascii?Q?v3V00M7j82C88rEnm6Bk6AcbtWx/aw7tcVBbOvQJmgG5zOEx388jv5ksDtmA?=
 =?us-ascii?Q?T1u+BkhtbUTTuSzFZC6fkX+M7qdcZEd5S5IIPfAFchmty0Lv2a4CcOLVEa90?=
 =?us-ascii?Q?o2PMYdJGqh8xE8bD4aYfvPVHFW+cJwDQCmPdAF4aoQ19bNNiqxcAdfOzcCCc?=
 =?us-ascii?Q?w/c6hOXA3Ftly0+opnLdm/5Uxf2JQJof8mCDtDrbtYKDhkYlKmNP6yK5gldU?=
 =?us-ascii?Q?buY+ezc2YXESuZwa8BA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842808f1-cf3f-49bd-89e9-08dd71dcbf6a
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 11:51:47.6170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gxk4HxtW378TeazLt66eiV4xub+LwvKPm7D11xT/MxrsIUiPKlHQHYnUoA2jX2s2DPLIoMKgb0hLPCS5767T1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813

Dave,

thank you for your answer.

On 28.03.25 14:10:00, Dave Jiang wrote:
> 
> 
> On 3/28/25 2:02 AM, Robert Richter wrote:
> > On 25.03.25 17:13:50, Fabio M. De Francesco wrote:

> >> Interference? Do you mean that this series would make the driver fail on 
> >> other platforms? 
> > 
> > No, other platforms must deal with that specific code and constrains.
> > 
> >>
> >> Of course I don't want anything like that. I'm not clear about it...
> >> Would you please describe how would this series interfere and what
> >> would happen on other platforms?
> > 
> > Other platforms should not care about platform-specifics of others. So
> > again, use a platform check and only enable that code there necessary.
> > And this requires a well defined interface to common code.
> 
> Hi Robert,

> Can you please share more on the background information and/or your
> specific concerns on the possible memory holes in the other
> platforms that need to be considered and not covered by Fabio's
> code? Let's all get on the same page of what specifics we need to
> consider to make this work. Preferably I want to avoid arch and
> platform specific code in CXL if possible. Of course that may not
> always be possible. Would like see if we can avoid a bunch of #ifdef
> X86/ARM/INTEL/AMD and do it more cleanly. But fully understand the
> situation first would be helpful to determine that. Thank you!

We implement a "special" case in the main path. This adds unnecessary
complexity to the code, makes it hard to maintain, change or even to
understand in the future. It becomes more error-prone. Though it is
limited to x86 arch, the code runs for all platforms. A reuse for
other archs will enable it for all platforms of that archs too.

This general approach to add "special" cases does not scale. We see
this already with the "extended linear cache" and now the "low mem
hole". While I am fine with all those special cases (AMD address
translation is another), we need a proper way to enable and implement
those by reducing complexity and with a good isolation. This makes
future changes easier and reduces conflicts with other
implementations.

The change of this series does not much, just find a CFMWS region that
is unaligned to the EP decoder's range and then just shrink the used
SPA range of the EP to match that region. That can be implemented in a
very simple way if we introduce a spa_range paramater plus a custom
port setup. The generalized part of my address translation part alrady
implements this, it can be reused here. To implement LMH support only
the following is needed then:

 * add a setup function with a platform check to add a custom
   callback,

 * the callback checks for the LMH range and adjusts the spa_range.

The modified spa_range matches then with the region range (no changes
needed here). That's it.

I can help making this work.

I hope that makes sense?

Thanks,

-Robert
