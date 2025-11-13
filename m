Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0683161A7;
	Thu, 13 Nov 2025 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066147; cv=fail; b=Mm2swRHGAvL5E6CnzgOpkIW2gQHQXLr5lxfRQKx47nVP6k8zTd1gmN6/hNeEAw/Q1Q4GW3uRvrOlWNf9hCRQKpuJ+0plmNxVrahsew6jXfHRV92+BmINgyOBxgWNhBL7jQCr8d8UyzWnO7VnYw8dMWnldUBL7HkrqIuhc71E7NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066147; c=relaxed/simple;
	bh=DsVEI6rVC+GtQ39rNmM3czNUxjZ7gW7jHNhNvJrV9Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Em7jyIhpXnHizkSUQNT5OJ0nZMPieDbEiKrfm/YUQSikfiPygLx1dttFRCR/EP/ciEDj2BFhH1jrOSmU46BB3HV6eGZBv0VDV/3MFtNvuxjd9kuXYhSYwc4IVKz3jKu5ixMRu96QoGCmlntT8K0pj+NnuDCY/Bh/h03bjw+gFds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EoWGOlEh; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EoWGOlEh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIQacLxszATUR4e5X3IHfqP+Bd13q9QSs1puroVXTe4A4wBAosBP7HNSFfhbJ4SfJl+0JnMtbdsJnfVqI3XAecyU1s3pb2Kk4sX2ql83FNusKqW94zyTTSlS1Vf6fyJPhF2hd0IQaYFIaoPabbjuGh7RBGWPp32L56B4/BaqqlmcTptTslRqraPxuuJUSQccbwvZWtkS5tcNWjAh90MacPkGmpgoMhq+umFRTtBrnVKs9H0+Qv6Zp2+gTJP6dkpCcEHMmFETIjx/dCulx/NB5gwzVz0N7TUdEDK4Au+KSX0H86r4snNbUkx3jTLJjVGaeXvzYelZ/8bmOoqVaj/d3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3MQoLcLzRln0iI6SXSbvdePLJib9ZEbAsdDjg9aP3I=;
 b=Dr1Nvi/XWzJOueRqzsong8jDs+WHocDycMcFIv+Sz4KqHjloLkgoAGxY85iIMm8O3anSsvm1bhWHXUYmGIj9sYmbr/ZQJuubrRFu8Ajmd1K7tnz0aoXgz811daaIbQ42SqQLzjn0ItCnbtLIzqGbVXpM3peq1FLJ9wJmMwsN3e+R1PxGm6ScFT2GRjj3/oJvTAI6K3JF9lui7EHri1WQSPgyyDvSjPvSF9ebGeTBxHLY5C0L4Hxjjb6JYIxZVuIZt48gQ9yGLBRXCpC1Ash5ehHHRsByeIoBIA4jbvWWUICfOj/M+MaQbezOh6PZCSU9lxYTIt2gv1mIPdubYeEBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3MQoLcLzRln0iI6SXSbvdePLJib9ZEbAsdDjg9aP3I=;
 b=EoWGOlEhAZSbZ6MBLBISdBNhrpGUZ2UINfcZqkjpcUHSjrv6Acvp1K7fQn3p4yXTKh4BN9CKXEC6A9hFZaMW5qjsLt6vDRDG4vzJBr3ZM2IxUrGOW1e/g9h7OpJOxo9XVV0k3cN4Of4TFoob2KgAK5kw4YWynABtxz1WL30RG4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Thu, 13 Nov
 2025 20:35:43 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 20:35:43 +0000
Date: Thu, 13 Nov 2025 21:36:10 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 0/3] CXL updates for v6.19
Message-ID: <aRZBOmQH_pVs93T4@rric.localdomain>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
 <aRW6h127k5Tzns8R@rric.localdomain>
 <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
 <aRYLJmjBsggjzA99@rric.localdomain>
 <a0881237-60e8-4bd9-b990-b72ad29c57aa@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0881237-60e8-4bd9-b990-b72ad29c57aa@intel.com>
X-ClientProxiedBy: FR4P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 165411ef-c1fd-4346-23a7-08de22f4377f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xLp0fmj1T+SKAam0LfXBJkPWH4u9/D9zT+CrmS8sgDut/zG5BMdwwoUfu5gj?=
 =?us-ascii?Q?rMvr/zWDrtDT22ebZP83IVgOhX1KEx5VCSdRqbjAGht8lbxaxrRRh680tbNF?=
 =?us-ascii?Q?x4yAn4HWSyVqehjp3zpvL4CShySkGIwSYjg3auOdyXkWU/FclfhsmmXrNsvt?=
 =?us-ascii?Q?vKC20iR4OSmGrfVBieaFy3ggv2i8j6ABEOOVitGpwWOG+Au1hB/QKQxetM0s?=
 =?us-ascii?Q?GVgwsl5TxxE2AaEF1a8Edmbla1JKbZ0yismJ1B+rHBmZX0/yUDyYz8QLcdmq?=
 =?us-ascii?Q?kA2lJJMIS41lIvg3LK1H7nivrzoOlIqx77nUlU7uKug5mgVvCM05u5DOWtw1?=
 =?us-ascii?Q?0H32sw1puhl4RWZoOAItoflkKrh1i5XMB47w8+dapuCFQPCav4KH0BqhGnJI?=
 =?us-ascii?Q?3ULldTDQoEOcjqiMRhsO4bidjO2Cu/K+iQEOgZoWrNaawbCcSIHzA6LkXfwE?=
 =?us-ascii?Q?ikrRTQbmtUcb3mdv8mpTzvSj0BR5SrTL7MLvpNbKDTZ2Dxs3UbQSTQvyJHN9?=
 =?us-ascii?Q?IGkdY6Iw3rwStlXSX7/jLGvBHL53V0iWds3er28TEL4sl/2LVZYZgcmLKD9W?=
 =?us-ascii?Q?CfWfIGME5UqW7VAieFHgn3+w93g5yJeEiA+RmAyruADzwK/houf1gOIG+nYn?=
 =?us-ascii?Q?gOW7AYfMrpv746rhL8YSVPqcUMo+sQull6g2Z3SFrA2sHMpIcDkIrr2VJiam?=
 =?us-ascii?Q?WGDCTyRKUE9hakO/zzOngtC644p+eBur6p7D23TSn6lD1nWH6d8Jdgrcho9f?=
 =?us-ascii?Q?ZY2/QxFWtPbGuCLl0J2sTJ0p3tr4pfFd3AJjN4+8aT8+eVo1BhyczUoQdIxw?=
 =?us-ascii?Q?T/hYsKsAWA6bg3TLw1/NRDGu857Qs/mCX51kRTxYoqq9zwfkmnNbaIde0Hqr?=
 =?us-ascii?Q?pL43smucPRNDWPpTuVoa0Kkrun95AKiaIkojgyNC+iwLdVO+waEIMxc8MTQ3?=
 =?us-ascii?Q?vJ0p9VFzH/xY0HHDYvSgwxZ11ppB2V+qPU50Fu8irD6S0glcz0wJNPj9QeWM?=
 =?us-ascii?Q?xKHbZ6ekvWou5Y21nMoMmIjKjMuYmzBLZU+W5eBYbO0zbaxHzTu7dbqyQg1R?=
 =?us-ascii?Q?SMj2cofsfdzAHq3fZPoprn7bhN69b7KuT7oz0Aci9pWFr9iSyRO6RnwVXcKh?=
 =?us-ascii?Q?Q4DqrQhDv2apcaOxvGs8DjYlUEzCH5xoUDxgR7ih59aE31lyA+b1BtPmVHb8?=
 =?us-ascii?Q?x4DppMoXbBL/vbG0nrD7XI3GkAZuQWQ+sJA/QXg9PQGGgP8IchKE1s6DXtOK?=
 =?us-ascii?Q?BNiETzsiSpdB20XPQDigjcDhCywAUAiEcw4ZugcKIneHXPZDhkJZ6Fl55xze?=
 =?us-ascii?Q?eIT9rwtGZGG/cLGW9k7+RQQpVDJrbDWHxroWvtonhGUF7h0LU4hndzGl9IdN?=
 =?us-ascii?Q?ZEI7azamC+AHgNAAZ2SVE7xsQkDWbbnW+6n/v0vTU/RzI0hHHnIgGDj2O0ud?=
 =?us-ascii?Q?xX8mQYUdT7z3+2hP3k8dmEg6i6m08h6Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fwMFH11EFEw79ERPknbOA8KYDnMs9R/25HIBqZOljWwryfUzNXiRkLB1wGL7?=
 =?us-ascii?Q?lUU/TYKlYHnq7slRn/tKNegw4EbtHMbQAedZWjogl5sjwuiWWjYMqaMTUzi7?=
 =?us-ascii?Q?HIupf9aOfduc7U1AKr7f6ek2rw2wz0DXQgVsM5GXRPv1ctRG/jUBI6j38dXe?=
 =?us-ascii?Q?+hxE5w2bzfXLNzl8IQkgmzNquRd3z8gNYj6WU9aUY59pGYZ65bpEXD0fFGk9?=
 =?us-ascii?Q?RCqIc+yqEpZkWVzUkRsj4NbAZmGYanToNiIxEqOvJzBO+a9kztNpm0qa6JUC?=
 =?us-ascii?Q?8g6mgBJrB0Z6L/X9n0m0+u9RO9DiLfqAPK8m1r2s8VAu8I3LfWftZHFmCtQv?=
 =?us-ascii?Q?spZ2maYbarE4YYFLpiZfm5gB3vfOMOKtIoKwXLWcgvZdMUaPqdagUGqmVh1L?=
 =?us-ascii?Q?lFOAbIh0t7JiIqYy+LZQ4qpdXOoL33u9oJDfeiP/Gj4zwdArSmVRzN9tFPQ8?=
 =?us-ascii?Q?GmUPnmjXjbvNzBoPv05qRKr28z/nXiYRBV0nEtmnaVTm3c/6xHOXg9knxDcO?=
 =?us-ascii?Q?L8yzBkHjKQwt9XouwMXyU9jfxlIh9ZQHVBsVs7pinXxfVkuh1PXawC44e0MS?=
 =?us-ascii?Q?T9G3hoR/y9AdO4JUSOzdJKsGKW14Z9HTY5OmbON4TuE0GY82JMaE7TBE0Aba?=
 =?us-ascii?Q?tlyr+9Mq2gSzkk5EzGCpK5vH4qVtk6uf6JZJyumZLRZ9yw2G1EIA8B5RJjfk?=
 =?us-ascii?Q?d/5V38d9kGsuwlAMbRe3Rvuq/cgYi2YgaBh5EDaKppdJLoiA+Z60oWSPWLae?=
 =?us-ascii?Q?hIArvWMFrc0pjOrioUwwRK4z9oulpoU1oieKxYHtBeNPQw5y3Th4OJRmIvH1?=
 =?us-ascii?Q?Aie89XtiFAQz0pgae5j2Fn/anowWG6tbmaOx4IRmw3GisK+PY1MexM3g8qqM?=
 =?us-ascii?Q?Lx+w3OwERf3DPErVKh//1syjd6IaoIByqs1ypauI4/FdLeiUPh5rHWmOc62J?=
 =?us-ascii?Q?LPwTTdMDMvhOsGIbrhpmhTH+DnrdzF/O8OiutIBLZliORozhp7sMuDxCzX4U?=
 =?us-ascii?Q?rD10J3Fj1CcShdxqVIqiunG0i1i/fEWENKL6Ha8zXT/ZLKS1dDN6OXhiP8PW?=
 =?us-ascii?Q?zfLXs33xbvF3+WiD2H5yqvMJ4HYAyAkZlp7J8r1FLCwfi6D7t/N2kFIexAzW?=
 =?us-ascii?Q?0fADMwXBAcobdYvK3YFWHdKyBv5884DLtejIpAzBIBRb1ixx13e0xFC2swd4?=
 =?us-ascii?Q?y+xbyJIG2NdTs+laO8z9vPyW9TgLZnkoaj+MieuqDerap04WNbObQsig7tVG?=
 =?us-ascii?Q?0BZTnziq4rM5iD2Cs4YtX14jOzmB36ac4SyyFGLVVrmmslmnI1DWarepJ3h4?=
 =?us-ascii?Q?+okDzhEzCTlJtzEY+y9ZujmctkfFPTHdEpTaQ900D7P7smpRH2tvjypbNkTE?=
 =?us-ascii?Q?56RmSmJq/UXn7NDxVqoF2ozmT1eNB07OVCDKP+AdjCxV8rErJhOMQKmAHjDg?=
 =?us-ascii?Q?UifPVsY9Iqd3rPk91AWtQjP8UxlyJm/N0FFZoJiHGdFxELXoTFPDMCWAApFv?=
 =?us-ascii?Q?jygp2OJTwvPX43iW4LaWuzTkWNWq8ryd0D752yxwFMKTUhZD8RNNIvpGvltq?=
 =?us-ascii?Q?gqp9xjXV9mxaKskEx+mrpnuFE1mb3wacEpUsg5p/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165411ef-c1fd-4346-23a7-08de22f4377f
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 20:35:43.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AG3pcrXo70SC3Gz2cQc6y8QLy1s6SgkUa+xa6cZM/DDQSAE5H1ulGmWCMZZ9WNFZij03Fsgn13fT5U6DXJ8nUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453

On 13.11.25 13:10:56, Dave Jiang wrote:
> On 11/13/25 9:45 AM, Robert Richter wrote:
> > On 13.11.25 08:20:59, Dave Jiang wrote:
> >> On 11/13/25 4:01 AM, Robert Richter wrote:

> >>> Additionally, patch 3/3 (@inc variable change) of this series also
> >>> depends on patch 02/11 of v5 (store root decoder in in struct
> >>> cxl_region). If you chose to pickup some patches from v5 first on top
> >>> of cxl/next, then all this 3 patches should apply cleanly.
> >>>
> >>> Since 02/11 is one of the first patches and it sounded to me some of
> >>> them will be applied as well, I would prefer that order to avoid
> >>> rebasing and resubmitting a v6 for that. Let me know if you want to
> >>> handle this differently.
> > 
> >> Hmmm....maybe I should just take the entire series hopefully next
> >> cycle when it's ready given all the dependencies?
> > 
> > Patches apply cleanly on top of each other, there is nothing that
> > blocks.
> > 
> > Let me know how to move forward.
> 

> So currently we want to apply the 3 patches ahead of time right? Can
> you 1. post the series against 6.18-rc5, 2. provide a public branch
> (github or kernel.org) that merged this branch with cxl/next (given
> there are expected complications) that I can reference? That's
> really my preference.

Ok, thanks.

-Robert
