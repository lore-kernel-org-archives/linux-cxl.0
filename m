Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEF1EA7C5;
	Thu,  6 Feb 2025 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848330; cv=fail; b=AFk3X1HED6oRtm+VlvRSgnykzdP619RoF4ED3TuoeIWT88Jgaz2z+NNE5V4LRgoX44dm+QOsMBI4gezKAFSedvb2xk0TDy4TYueJWiBg2vpsx7pRsA0B/MMPaDoPPfCQAGM7eJLejgr7BuviRq69MK/pE+YBZXq1N2NtZyIId3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848330; c=relaxed/simple;
	bh=P6vXU0p2pWCMgXtrEbv0fH3LGOT814ZLj+PYZ56Ev6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X5n1rcVQugZQO6eadS9qai0w7Lymjq76TFCdOMAVlCgN2TS7K4pxymSWyJcb0EUmoFJ2GUmw89iR5BCMWSOibNSyMUuP9ousBqVeQ33L9h0jaNbwskVtB5DrCmvZL7ukUpIPbCRSpJrF60P7NIPjA4vODTr8VVHZa2R6eilKcxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wVp5frp/; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wVp5frp/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMMqViuJlkfxYckbgspm4qQdYLGDSQ+U8QnYXgfgaKwXHgwQpzhxpfJz6zEUDNTaBtuemPBS2Q6+IDpHIbYLfaDAbKptH9QH5BtNL96Gg7yOc+x8nVQSLNgEOumLwiTDPJf1Lbv9+v4EwllKisSof8PBoQHkXXVpRsUiLRPc2FrFbzC26M9jkL396Ol8TTmA9C/W/VbeUxjCB0l54FEL1XbCDGDa0Puj3iVP6gpgeV2XtqxE1aUWGAaL/mIZDQsUZcdfXGY2fhZzyzZGZNbImDw+a5+IjLSAJ3w7RnAdul+/fCRt1LBpGapDcRzc2cIaFhem8/aYEVdMYveZZ1uX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8unNNfI2KiwoCxZ/W9pQqanZhhBHj1FDHDmN5v4i62M=;
 b=EnifL5duz7JpOI30UcAWz/Jlcu/wz1HtZv9G29eO5mjBldrrEPOYssAYnvfAvhCvTmFBfl/8T4OdYCGdJRYJqQ/QHE6Zxfy0QQWWv3ZzXQ0LRlm7fd2wRqT4hziVWubffkdmGS1QxX0+EWBWzeXrPB2WbCgH3suwuZW1ZCCKuzVhJRuRxdofPThzxLDjTcm2W6pLZ/q5+uB2Yt+DjiRJuRLWktxRcdjswdS7tRFnZ5z6y60UYRcUHdRtQBfAymDX3Gf7TBE1g79wKxtL+CGbw8C3EjOVOqHYEiTGgB8Nm7zfXGG2GZsVcrIICpntwXhu/f/lnmChZpj691DocINtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8unNNfI2KiwoCxZ/W9pQqanZhhBHj1FDHDmN5v4i62M=;
 b=wVp5frp/OvkXXMH5/3tMhxXX2pnbb3f2htrFpzcKEEQOmgD+v8sqXIDw/j80z0dKSx24dlIojg6N5ucEPgH/80sk2DO5A1ZnwxfqC3oAzhYAvH+UqQTSwOUYSdTmU1bAdeWNHGaMwsLQpOaFwvVpDOz3zONwrAx+f3hpsHFh7eI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 13:25:26 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 13:25:26 +0000
Date: Thu, 6 Feb 2025 14:25:18 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 22/29] cxl/region: Use translated HPA ranges to create
 a region
Message-ID: <Z6S4PjcrnS-_Rog8@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-23-rrichter@amd.com>
 <Z320C6u_qXz8zQbJ@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z320C6u_qXz8zQbJ@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR5P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f90be6-c0f5-4b72-a957-08dd46b1b793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8oPRb4hdxmCWk+C0WjbVRUbYnRaBqBEhUiRjLAksxcP0TsaN9ctDKhpJO32O?=
 =?us-ascii?Q?gr7hKMPtydx1dGjxHwODyAsDj7bnx5+g9nMKQKBPJfKzd6/f/O22qRo72XjP?=
 =?us-ascii?Q?MuEw7BnPQ33wee260xXWlw/b863lIxy+d8odVA3blRzuYQDkUw90gekCz/3a?=
 =?us-ascii?Q?DfgHm6VyKrFABUTxSlT6Mb7WglSnYQyw3x/MlTZAnnMNwMdSbnTQZgtWJnSn?=
 =?us-ascii?Q?iCzMuBQVrSy/4Yxg+sx8L39qjOPLOBhM3P4EljQv956HylXiC+N2CrS20bMh?=
 =?us-ascii?Q?B+ejbKtW34oGkHuIfrVWprwdDMG+JekaITFFcfO3g6pF5mpqHLng+NYm4KAq?=
 =?us-ascii?Q?K5hHI3wkWojvH7ml+7CyK5A+wI+brDM3uT0QYH0SZYcZOoSSZWnJS5mw53xB?=
 =?us-ascii?Q?XWpJ5KLEPIPGQDaj45HaptJE2FFFM2Ee1+3hqs8MWHX3q6wE+v4kM+2F8eU0?=
 =?us-ascii?Q?rYZU3SQLtYtcSOBi+Ay8Hxg/GdHxUnerZVGP5H3+Mq8wGKof8WbkNoOn/zG4?=
 =?us-ascii?Q?Gtsg8o6UN1D5nACH9ryPHslfRjeva1d9myqChTdja+LgTzBXRhjFRcAGgliO?=
 =?us-ascii?Q?jmcEHUo7sMOZc38YpSf5v3oMb0nZg7Jk5ZyQNNFfDJ4pLjqg2EqCZ7BO5SoR?=
 =?us-ascii?Q?2B4Cpr7rFgt/mvpIqI3W26uMUD3TTLippE89DKT52aRWYYBT5ZlFStsda+TZ?=
 =?us-ascii?Q?ZQa0tJhiS8Hhg3gaCoSyg6JS1UIWgRlV4iLjg20otrnz08jh/GYe56psukA2?=
 =?us-ascii?Q?0CkkVBk8o7WaZ9Z1PslIN/8UAf9ieTkyzO0zIsjLr9XKZ8mBrTmOSJkvUiF9?=
 =?us-ascii?Q?messLfBfXPqcFyFM5H9pvcyro46lSA8ug8+mlC+cMuwseZQHxk3J8oHLBS5m?=
 =?us-ascii?Q?P0aDUEWrr2jYzPwr+Czx6dH6KgWSKUxIacdcrIv8ouCUBRu6x28aOY98ejAu?=
 =?us-ascii?Q?O+KJWooXOU7D3nFDWLDPftINkN3FY/OyrZmqW5ot2Amus3IZq2gCRa2T33Ug?=
 =?us-ascii?Q?Ksjsmr8XeiXzgkizRbgLEUsS3SW7RngPcxJq7yLTJe31WkSZ4o6bkuYM1yCl?=
 =?us-ascii?Q?pg77MSvhYygin1AooX+hTBpE3BtUIld9tVdbhYDdm/OTI8ImkXHBV5Ai9+/j?=
 =?us-ascii?Q?mTYAMP1TqmL762r9O10Ofr96drMaT42s6ZhMnFFv4xHp9LuCGEgQ/M1kZymF?=
 =?us-ascii?Q?Jno9I0//hsChwtAIUrsdFZ+fPFg71cDaiZrpEw/oqD/POV4ZFjMGFZRVUwVv?=
 =?us-ascii?Q?+Z0DhJZwhavHXlhtstl9MFc/PTm4YwMZIGbiBcTF7++cT0A0E2oKrKjKGFWf?=
 =?us-ascii?Q?H8Zbp05u5lPZ+PWmCUnmUQho1d+hXmWe2VLG/LqisflgIRZqzakmcsC6a/Uo?=
 =?us-ascii?Q?NRguXYJLNTdAeEQq9LsLBJeALRhO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lZF3ZG87tbxoeFgIaBgkGKWIg6cSwsD4V+nPKQlKAU7kzGqrArdD5aDa8skP?=
 =?us-ascii?Q?dOqPNi1MNw2ODBKNt7T6juOTAWHLZD9P9gHPpAiY4QzgKE9uYroQMueNVScS?=
 =?us-ascii?Q?Z5YRBTCv7GkA0UnguU55DRNwDD5POoN+5cIRgAWVWKriIrAHPBbdKPqBXpd+?=
 =?us-ascii?Q?93PjIRQCzmPdZJJn/KOrEI6ZeGSmMwR84Ogo0s699tW1hwzX4j0MLVUv2kzb?=
 =?us-ascii?Q?mbMFdmQLRHIaefAuJNIkgYuZ30TmVIzHKT3XhAuV3jE4KYB3NiTTnCztk4Nl?=
 =?us-ascii?Q?AK7oCgAUDuK4AOMUmnftYl6wdPRnRf8Ma45Inu9NjBBlGB4t5zcdgb11L2Zz?=
 =?us-ascii?Q?tIqqkCa5LnzoyMYUdmThObwlTH51K3BbxaEr4hepliUO4OU3GkfL8cnJ4ojk?=
 =?us-ascii?Q?u80BcWAv2kG2W7abW+S4ty87zGLpNjIOjVgwvb+F8NGAxRWiXOBgOKTJL4Vg?=
 =?us-ascii?Q?teHi/JyN5nWS9h4M3svD+z4/wU/g4hwvVoOWAghJ56KUSXUQN3WoL5SkYeUw?=
 =?us-ascii?Q?nPrrQPs1SVbQKV71RxEoH3Rmw1q1sYGRa9lurmUh8K1zdWw7t9EqOSPioJ0A?=
 =?us-ascii?Q?ZjCfRKLXMOK0za5HfW1MFtAaykFfWqOLwikCPqKBxz8+lc+GImIYJ9oAkTx0?=
 =?us-ascii?Q?YY31APyj/Z4UjIlhEmR5xoIPCIiF61EBwq6o79atbb6DYgs0FNKaTFI3phRh?=
 =?us-ascii?Q?BRAx2i8B9kGK5qakDF7RzYEGrvAOr2HPvpqGFrOvbPZKXT1Yg6srDDM2Col+?=
 =?us-ascii?Q?9YGJ+Z3/lavJgV/LMOCPK1j/aukVbSGnBO7pSnblDEiMOI8w58+RU8sObSCl?=
 =?us-ascii?Q?1IP4Ejd3AIiQpZ9YDj8Nu5Nnum1THJqAdRzsEfkn7rS4sRDJHm3N7lD4uyhH?=
 =?us-ascii?Q?dbm8aLjg2Vioz8t8b6Is1Vw/uLUCDA35kdyAshSKO13mJ2HgiApAM0kEFs5N?=
 =?us-ascii?Q?ptfaoZxgOMVCvgpOTarq8MYi8DZjuAOwePQflwbM5eM3n5eQ8U4H1dqJVvhk?=
 =?us-ascii?Q?fp/ojU7LgwPO/GlUfMUMZ7nmmLHdGhobN/USwYPHUZdYObzPaWKXq++GeyXU?=
 =?us-ascii?Q?9hBlphYjdZT8/0geyeNIxH5CbJnTjzvMwMSXAiLXwHa8uPc7XhLHd/59Hzkb?=
 =?us-ascii?Q?RjnQjPvcCaYm8uhnqWqq0G5PbUOmm0Dctu3x88UxAPX3XOVq5WD/z8eBQjS3?=
 =?us-ascii?Q?3Z+u/G5qUGfcjfD6PrrZ6+VkyzshGTsfExiStNDfA1kB1uIxnztk91XIPgvN?=
 =?us-ascii?Q?zFDgrBvX+juQNOEyxmxIsRNvVuqFjGz6GGkTdnLSh1vdFHdUrqO6dTFGQj/D?=
 =?us-ascii?Q?eW4IJ95M5rX3FwlvrJ5g7IDj+G0LLwK+hsy+leX4hsKo3dfh8R9s+3wH2TCX?=
 =?us-ascii?Q?Cl4JVadNbrQQZ3GlzfLFHirDexRz+ZPHcx3I3fyMq3TOnPRmpTRMGRxd9bpD?=
 =?us-ascii?Q?uqRDeMWN1WNkfxMPIR8PHO7AAreyQKrjKCNDtCoA9nySzPKHuLKOlNiFa7uO?=
 =?us-ascii?Q?NZIuSNY5KVRCUfC4D7ZIwdbgZRcppDpPO7Dl2JZ99BZq/YTk74PEAOqw+aw+?=
 =?us-ascii?Q?id/ySvscA35G0ADQjx0t+n3rpOkWVTsiIg3jUZfb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f90be6-c0f5-4b72-a957-08dd46b1b793
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:25:26.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPYSCggfF6pOOyRXtxNubuLMQKG3Ywz20choyl7SNfXsD3qOGLTAfxY7EChsKtkt0IMzIeBv+nU/EPMzu6Fhsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342

On 07.01.25 18:08:59, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:10:08PM +0100, Robert Richter wrote:
> > To create a region, SPA ranges must be used. With address translation
> > the endpoint's HPA range is not the same as the SPA range. Use the
> > previously calculated SPA range instead.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Patches 22-25 seem reliant on each other.  Should I expect errors if I
> were to test them individually?
> 
> The individual changes in 22-24 seem ok, but is spa->* expected to be
> correct in the absense of the PRMT translation functions when HPA==SPA?

Exactly, as long as ->to_hpa() is not enabled, there is HPA==SPA and
code should work as before.

-Robert
