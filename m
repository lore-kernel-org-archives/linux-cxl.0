Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF132D451;
	Wed, 14 Jan 2026 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413194; cv=fail; b=oI/GeLUnQ3WAx4a1PVnmUPDu7o7pCY2epjJklFtTL8jCPRGJSXVG8JFsN4baytsO411YAgjQfapLir1vWEjOfV7GLr3B7QZ8DHvX0o3aAeQhI3FnUATG4ERrWVfUouwT6zK1g2YCEJMaj23x4hC2ppugShEAnadZSRYATePxT2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413194; c=relaxed/simple;
	bh=GXBgN1Hk36brT56kUzaCEVhiuCdB30Fu3TfBBmh8GmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UDhSSILjULqBLpN1fpEhBL/9D9QqlJ2cXctPpfymSWP3VSb+KiD9hVDVkpxfs/DN5u6zlwY0k/O+g5FMP26gbfMHbf5o28CAdFZbSHJd8Az62uUrsRD2vvN8aZC42FvCOiH1eITt/ZtG089UhKanjacHvR+MFGrmsvZySMUg7og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sc+S5Jdt; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sc+S5Jdt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+l4eVTi5UPSXoZROeGXWWnm7WMyCc0SgJGUy2nh1sq1c7Guj7ZbiQ27tIpNUipWFq0+zrefrPIsciDjUy9HHOUdyigX3F6CdqxYb175PQxoEKRJVWZ9v3Q8OtPemUDzW+L1Idl71+D1WkccrTQ5kkHc5eXAsGQDp4CcTvlWcXGXm3BHO+acaU0GmA39OWlxyJJFZv6LB1SUBxNJbJr2ndGJ6RXFrLeLzD5gfU23FCAmzfO/BrPVDMbSLUtYBrwsgrJ37PcpCJsTRoKJRRSb2uaKJ6euMRT1KWwIt7J+IAwyNOKTm3DwaHH7R444wGO9chmfQYGRk0qvUaor6M6GiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXBgN1Hk36brT56kUzaCEVhiuCdB30Fu3TfBBmh8GmE=;
 b=ZUeXymtdqEujhLqHnah8hvsCDQFxMIcQvcqDUMb2hZ8YMkpPm43tCC3OtIRNL3b7OLDkUwGSU5GKpQL9lAYPjsotBVlqqsZM3e+HjBya5hbrSuIrbe1GY8RcSu3put5tHOaHOR4WGGQ4gZAI63GMhLMfBP3zFuXvcqHMDMowkvss2uAdj7KUHQk6xElfWcD6gyffK/vIs32KOd8qUQkYp/ZqW7hozEI3IFvj3bdIhz4n8s/UOgQ4o1dofgtvY84ARLW/Dam633zP/IOjgptbgmDKPQJpmcTCTUyRehVM3lNyLvUtCQ9uVKQAzoY63L8LCU1TBr6gU2GtmmGK6dNI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXBgN1Hk36brT56kUzaCEVhiuCdB30Fu3TfBBmh8GmE=;
 b=sc+S5JdtWUw0ZNCBGGCE46L6C5TlqQ/8WLTndOzztsrOfGmKWbwccoCsF+yLIEOuvPsMsIuogE3jBeBJqnd28Dpbd3QiQ0JzNCDQKmxGwn8OXDl/hqaL1dJKr+swAtarkMhksQggYZu3OPoxzGWq2DM77b5oxB9IyVLulGCGOSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:53:03 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 17:53:03 +0000
Date: Wed, 14 Jan 2026 18:52:57 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v10 13/13] cxl: Disable HPA/SPA translation handlers for
 Normalized Addressing
Message-ID: <aWfX-QeBbhbdDh9I@rric.localdomain>
References: <20260114164837.1076338-1-rrichter@amd.com>
 <20260114164837.1076338-14-rrichter@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114164837.1076338-14-rrichter@amd.com>
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a86378-dd6a-40c0-4311-08de5395c3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TWoJ4URi1+q+WhsnP9Nu8XV2CdhaJyV2uNRpbV+fuA571dzZ4YdJYJVEfinf?=
 =?us-ascii?Q?QuyZpCLPJRrdjtLVDO1upzLWb5zSQ3iKAlgnMsfqupW0VhIwi8r19jOrnnhv?=
 =?us-ascii?Q?Kl7fF8Q4p90WR0azfst5E2D2PPFgJ9N//yh56EHpl9tM3Xg2manlTeRyYK8/?=
 =?us-ascii?Q?Lr748ezsMlUWokDznypoOJ5noa3HBOcGX9cFa4va8xx6RSi7wDfG5R/cTyDQ?=
 =?us-ascii?Q?dLrQCnLUN5KCHFEOiQz+jyVn52pt1AwiipF6RMx8OfwN5qqx9pbTrFDMleSC?=
 =?us-ascii?Q?R04WyIgiFSElCETVj2d3HhiUkttqH9/cEEicMhOsi7sckyCRIewdwTeZyOlH?=
 =?us-ascii?Q?Vq4VSZueTaL1/OBoFCINi15ux9GpSeQNdjJ8PMWpkmOnFTRkcZt53AfEyWoW?=
 =?us-ascii?Q?zXWZ/ajBwLNU85LS/zptg9MloB4oWwvqj381F6ePqLhPLFhNM9mRC5fdITNX?=
 =?us-ascii?Q?EKVmW+kFK0BfPvf6rYjMtsDf1s+vNkebG24o1WTrWRTkMVU2nG7x70kPiMzE?=
 =?us-ascii?Q?X9Nw3y48dnGKOmrKn8MoZ+PJSXQwp+yVYVgRQMANFU2RC9WnVPXa8knIyhuY?=
 =?us-ascii?Q?0TXbaXgW/ofbIs/Y9l92O/0QxvUGCaD6c+LV0gNPmiJXuB9642X01R+5T3CA?=
 =?us-ascii?Q?sty7LpMUwn9/o85yft6TSXyZMs3eCtphHT+g/v5tc4ZYiOVH3uAjl6PWI1A6?=
 =?us-ascii?Q?Yx7xMBI2V4HHj0gXvkDfceNl1AsM97hUFyjn2G2nzAvG5Dgb4plqBGRxTctf?=
 =?us-ascii?Q?JJNN/X0lhnpyj0GGu/aVkUGyHl4oMZ921iVH/lJ6vyFv2RfrGmh8ojLg5FEQ?=
 =?us-ascii?Q?EnHLc1gZ6I0arDFzOnFfJRkAUvfZGExLawt+wA3QBq5XwIt6suqB/GVPqxZa?=
 =?us-ascii?Q?oVi7pVD0JKtR/PG1z30P07IOvK7zcMm7io3oKZ38asozUgv0wr/IRjPcl/hB?=
 =?us-ascii?Q?iOf0UoTjfFwK4BJChVpvHbYq8I0MEpeSY+4cUTVz7KJlbRO0nzgiSglIg1at?=
 =?us-ascii?Q?b8PaNFMDrBP6+T6jV4y5E+zh3vUAMI4VZj5IVL9ydRYA1eGBerVgrmTmJlpP?=
 =?us-ascii?Q?CIOIXHCDngcQN3vDuLy3hTJtmJ00z/qmRo8AR//jHfQz5GVGgXhNS2MmVyRT?=
 =?us-ascii?Q?h5D31DKmyr5O6nGeCnDo3/o1FtxP7G0z0xnAwBpjwGb9tqRf01IhVXlS8HDS?=
 =?us-ascii?Q?TtvwdOD/s+wRfwPM4fbFQSYVtto4N7sO/EWvyOVtxSx+9xuxq1of8LwLIvPc?=
 =?us-ascii?Q?P3q2MifkznOLxVxZtDYUu5962sQGBC9qnXoOWNaqEEVmMk+EJOOn2WvZwXEX?=
 =?us-ascii?Q?UYEJd4VUSn0RPcEiDGnD0r/InLWYFYQOtksOs1/4re42bPnmCPbCxOQjV+ek?=
 =?us-ascii?Q?J8xCC44eJ/N4Te8bXXq0wI0L8qwEbGEghc8PPlnAnlt98abBErZKNi+RsV/e?=
 =?us-ascii?Q?iJrr116ejh8XD/Aa7cyvW48rADFQX3sp1+jNmrsJhab6x5QD58c/x+cKFo6I?=
 =?us-ascii?Q?gL/rBZqv1zqRMfeKvq2mzHJ2zQ+sAwgj9goVQMeHanv9kv1vL3+DfTcXt2Um?=
 =?us-ascii?Q?rQVfbNMOHEv1nSjBdwQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J9xFO0e1gkK0CCoja50fZwchcAhdPN5O5Pgr+yAmxlIFsg5BV9Y2svY9KwGX?=
 =?us-ascii?Q?1Q5n2uioI0dsvOO658xtrwSIVahLbUhn4E5hdRyWNSKNUK7XfLwvS9vcMi3j?=
 =?us-ascii?Q?f77Bi/qpQCGbrI4ANeRkqVrxNa1UDUUsNHLR3GeAMuYjUdA8kxWfK+/mTMh4?=
 =?us-ascii?Q?tFuBgrPAhCwEHvO7OeGZmJQn6MYaWTugMulxlz8/84LdpXUCmnk7JC7aJoKk?=
 =?us-ascii?Q?EjOgur2uu9Lsnp3nbGPHxx+x+iHjk+RwaN16lawufJF3N8N5b578/+sCw3oL?=
 =?us-ascii?Q?32gJ1ODeztwnMgevmMJ96nGKWHxCapiIX86PRZ0IJ1fJsRE/Ev5sLMxNuz2z?=
 =?us-ascii?Q?77m64kRTxm/i4gUnj89DVzyM7+goo0h02SRdYAlmX+J+WXzIdCdN/VVl8FQ3?=
 =?us-ascii?Q?nGyLCqV2drTVUPwxZw62YZzu+nhoPyr/G724ZZXBUCZctjBptOQvOiQB9l0m?=
 =?us-ascii?Q?1nbFCXo1JWcnIFzu+LGHWin6rT+HyYtwsJmSHdOhUm+XUTWnkOEpFfvy/yBb?=
 =?us-ascii?Q?+lk5IwHe/1YZjo1csB4MBx4WVQT3cbPdRpK51Kn9/Q+H42sL5ie33v/7geYs?=
 =?us-ascii?Q?7bToNhfORUxth6xfgkqR5lJ7jxoNXMeq+Wobv8Z3tnUxZroBc3vftuTelErb?=
 =?us-ascii?Q?HT5R9HmkJ5PNshgqq0tp3jCRFlA4fdBpgoV/lvPq/t4FaUSKWYvtVunWOXqN?=
 =?us-ascii?Q?8V/Rs4KCaeK+A/q9hl1GpQ61Imch++ziUptvKg2KhgfP6+q6R4w7e3knTxRw?=
 =?us-ascii?Q?g8MsKrWNKPMaqC+GJ09DWvM2FAahMNPGngxVLAFDiyU6AowUlzy/E3siCuiN?=
 =?us-ascii?Q?PEIikq47bG+wT+VVj7fMkThGp3+ZYsI+SNZ9s3z7ZLoMHtuDbknbEkS367qD?=
 =?us-ascii?Q?+NrXhf4LkMrqzYntd4w/lDkB4iUiWbtoTwRsC2NFrqPot4It2yilHOZsAZpt?=
 =?us-ascii?Q?AtXDIvJNusfkbke9wY+ioZmieE+VBy5NBu1fy3/sUZWluOotA6/f1tsDsec5?=
 =?us-ascii?Q?C0Gk6qecDp2uQ65GwAhjfca8E2UWUvWs2ksu1a/kww3D+i9lMKAzhWxzXUue?=
 =?us-ascii?Q?3h0dsM3cipSRWkFA5/a7+trUlZv/zx93nykVobms4Jt80FKQ9C5FgGhTBB3J?=
 =?us-ascii?Q?tcjGiCz7S4kkw/6NLNsRMfR7fM2L/uog3QELtVuWy4bz4cYFFF7eig88lO+3?=
 =?us-ascii?Q?41bgHm7CEIiEJo+6Dp4r8ky/L6abq5XUf+U5HIWaMo3SUX/ctlve0EtnWBCu?=
 =?us-ascii?Q?xMZ9myCm1Dm5XwhFsUAKXVehh94ZHm474bSTHL6udNL74iAH4RDchb0TEpZn?=
 =?us-ascii?Q?BOYHR8de63iRsmacO34BPGvp2GJS3TolafvGchXWd+u+MbXs+qGdn3n4DIFA?=
 =?us-ascii?Q?B5VmUd5CmCA1yhzhVGCmklG8FMawyF9guFrv76qWgER4yHZQwMrJiZNXdVbW?=
 =?us-ascii?Q?0XDszSSPFY5gNJ+/8rCsWCnM65L2QS9fpdYdlMRJ/XWckqafbRCtzLFTWOUW?=
 =?us-ascii?Q?iHo+ATv9X9sdzGbweLVSyk/4EcOWwsMoFSe5t+Si4WVBC5wdiNhRnUlRbjvm?=
 =?us-ascii?Q?MgowTcIpo0+qkH/KQZueBvBxhxU3RUEp4gcDYI2SfuEusme0OXMbGG1Gy/Yy?=
 =?us-ascii?Q?QULK7HQPa+VzbP6lRnKiRA3bszKiyxiJFl/gSYrkaSdis62lGIWVOIxyRLVs?=
 =?us-ascii?Q?OS4GgUx78zLwyTUijEaQUCh4nmLXpnyttShFHdMTcCMFJGGD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a86378-dd6a-40c0-4311-08de5395c3bd
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:53:03.4791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+GpDIstY+1/c3qSzGI1GbrbCUegV3iPG7fVb5uyemknm+kvmGehXETfvnw676EFLr2Uc5weLU7XTVuM5qvF0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873

On 14.01.26 17:48:29, Robert Richter wrote:

> Introduce the flag CXL_REGION_F_NORM_ADDR that indicates Normalized
> Addressing for a region and use it to disable poison injection and DPA
> to HPA conversion.

Just realized the patch description was not updated properly. Please
change the flag to CXL_REGION_F_NORMALIZED_ADDRESSING. Otherwise I
will update it when sending the next version of the series.

Thanks,

-Robert
