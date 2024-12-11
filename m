Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF791A83FA
	for <linux-cxl@vger.kernel.org>; Wed, 11 Dec 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956333; cv=fail; b=hOehx8Qntqu0pa/OZfriosAeBUgy9V9685PMh13fgk+06r8ide9YDNrvbOkj0IvrZEJzWi2Neq2ZceIMzcZuil1ruNKjy0tIqCf/ppz6WaZkmoqq/T//hPJIMhozw8e0XeKk7K0cKffRivfI9DulhomhIjAa18k62lotomB4xME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956333; c=relaxed/simple;
	bh=JZafF23LR0O9RiVRAvv0jPC8HoNTgkxdMhTgeb1Hyus=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X7cIeO6zbxbZxkG9UJsHE4j1G39I8Xylz96Gqjcmyb05h0UI2RvUzgornY0F25a/dWRCmFqqBdP38En2ObMobZHakP0va05UKE0QXKyT5nF7T/EAlRf63GkZlFb+LzWoQVcXtJKCBQ+nihjzo1fTtz5V3NaThYaWQSRpUO1vPg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aozdVMsF; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aozdVMsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733956331; x=1765492331;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JZafF23LR0O9RiVRAvv0jPC8HoNTgkxdMhTgeb1Hyus=;
  b=aozdVMsFJc87WoQJOo25yLSLS45Qflq/i9c/+3yPRReKl+tO48RuK0Tf
   Ds3C83OwJZdLt9A1NHOCRUTqnAWkdYx+BImxVPLVi6HMC2+wQUhrfEb1R
   jQ9PKfK3kg2waJUeJ4dc4BPmw53zvQhR/fuBfjh3+d9az+OPpZhfntH+B
   ssTkZiRPDJMoTdsghuAYQiMKeWkOoxKG73g+etrkuAYy27zZloAeKAiWa
   ePfIRjPiAUEol/0jqhBkxQgPqhaJVvyLr3+ricLf5nwml4fkiW3rWjUMZ
   sf9mkaM3d217ws9lJhHvJRdKPj2zmKtMfDMbaUeed4jC+/9oegbBGi25F
   A==;
X-CSE-ConnectionGUID: tYmImSW8Ra2N3BbHXsseXQ==
X-CSE-MsgGUID: bHeHuAioQHWuw/zZ0qdxiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="21939460"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="21939460"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:31:06 -0800
X-CSE-ConnectionGUID: TlL9dMpPRiyBuAAiRSDejA==
X-CSE-MsgGUID: kYKN74AmRDCDTwTAX4VSrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="96061805"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 14:31:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 14:31:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 14:31:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 14:31:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azHTk44eFFLhvk95O76ec7JPjkd76Nw67W/VMsc8uigzXNDDiTmb+tYY3UdHkHX6eH133olEQGTi7nVHSWmEYw3L+F9NTJVgEt9X8n1iMGrLFzSoJGVURExLhx2ajcxO3cSglWdG2OirYaWfdacTUc48KLywpNxvGaIIyv9KIb8336sb8mAJk7yOOT09QEdCrcR8gMy1snOHMVbe6mBC0WuWLGz90pfSeKdxC3nKuOUez+L9b+HLbUs3TiSYIJay+adRU3i7b+gJZqOW55YuBZisqRLd9FXCAUQ1vybSSp2+lkSiu+EsZK+I3AIYAsUGIvcpHnfQ76jQ1man+9vlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVFgy3CzGeXs3pVoRKqbqfVYzy2ZMbc+Fc99szgAsEk=;
 b=H/68e4X7blyULtyKO7jYhH1qXOtMH1+3T85tKP/DMJZchPGMcwcW7e+mKWRAAyVcRPsNrpDGLxsHZQzPrxt/Zf0EURevvlpk9PqwmhmWvx/T+9a91ybVO2CZXhmgQQDhKXl+agI9WFY5otKaMhEqRb48exJHwCxu/dMdf6/huL5P0dwhs/+UrJ96SAe84BejJmQfe2UzxRYOodTRGmwftlVIQ6kMFRCOjpK/IJkLuNjHzrdtM8rwm3GxY3M3CKGOswpyVqsdl33K0jLnNKQq8cRQ1WcBivvFu8cD3GguHHcNi3vIWoixojPnsFINFQ7+QcJBLj3WiDBWbKY8jO7XMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Wed, 11 Dec
 2024 22:31:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 22:31:02 +0000
Date: Wed, 11 Dec 2024 14:30:59 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Nathan Fontenot <nathan.fontenot@amd.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <675a12a3d09d7_10a083294c0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241202155542.22111-1-nathan.fontenot@amd.com>
X-ClientProxiedBy: MW4PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:303:6a::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2aa100-f3fe-4f78-cd3a-08dd1a337e46
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o+rtXhEy8H9fz0v4JmUd2h8D151a5vKkUWMudC3uHaXiNaGACvl9CS8Eee7L?=
 =?us-ascii?Q?Sh12c65s9fosctftms9Po4wxZlQGOLxFlY38qC1bI0Bavues+0ziln5iu8go?=
 =?us-ascii?Q?0aS77+uKvB4bY9w8AQAppuMcNmfGMkGD7axHC4R7J1MR9J5Ae1JQ2tFUR6F1?=
 =?us-ascii?Q?mfXnvMKPKxwuthDCkh07NnEdurh9oXkUpuqbkJqP8kP54iYXF2gmYl2ETtSP?=
 =?us-ascii?Q?2IiFars1hQMvljO7qHpRSJMDxmNKtoFSFE50rJGQ+VDO8ZMT5sxvG0676MgA?=
 =?us-ascii?Q?pjnk5Vk0lzQR82epZdJXySQ8NjhQ0WRPb8J97Twm7QJE+M1vZw2oAcoXBWR/?=
 =?us-ascii?Q?tlCiTrzUSPIrmI3upvNSWnCPCo/OJvwY7tql8ppRwlqGjPd4E9JurDlJssJd?=
 =?us-ascii?Q?xJLkMQvXlGhsVcn65Vrmvwt1MCxZ8JK6f7S1Y60NktjOSIIYeukmtOAe6cWD?=
 =?us-ascii?Q?Mb6YjT9IXKmKq+3ThsXXEOw+TQh6+74ftcxyG/5auZ1qPW2zTMUn/Iwhyi9O?=
 =?us-ascii?Q?/rCqWlWVXAqlbnrfvzHk4YC00jAX7/4tEA/HJ6QDgfC14Ev+1zsYy/i+4olq?=
 =?us-ascii?Q?7aPcWUQ9+YK/bfcN/ZJn5ceR+vkuF/xw9VaQW85phVRCpRFxXQrynp/z3fYU?=
 =?us-ascii?Q?5fa6pvHaKPf+zUEqH5OuUy+5VLqz4vETGB4eSPS02pDkaa5XH1Gp20bjRBFe?=
 =?us-ascii?Q?fV+wmRzpgiIfP6XaoqK2Stzv81r8g5yLUgVfug1CR4xnId2YZkD/wGyhyBtq?=
 =?us-ascii?Q?DY3u8mIpxL2KyQ0EDYFeF1Yw9TX2RRgEkKU/Wc8vxqypS+x8GQjBKp75Dh2r?=
 =?us-ascii?Q?RmQU01raLTo/YJbmJM+zb/5OLM6jeZvoH2xgK3f4wnq1wyPhrLoeWksMqx+p?=
 =?us-ascii?Q?eMPSqAc+FjrJLoFzuMHJj959y/0/eZOTMEwifjHH9s1H3BTqokY4LiVDZy7k?=
 =?us-ascii?Q?0Z3uio04WQsBCnWA7tDy5Pv5zHvcma8zNkL0y22kY+9NsMf+7xVLHcdueap4?=
 =?us-ascii?Q?EahL1z5DC4OrQhi+23lyHYheC/1t/TDRaVT7m7Cc8RXH5MzVEZeg03T4Gd53?=
 =?us-ascii?Q?uz8dhlWvGAxKOV7/L/3UDxedD5fMu6UFDYkcmXaAzEvH9xDUYUtnq97ODF4l?=
 =?us-ascii?Q?P7Wi0kmwQQBG9GXsEWg1too9wC2HsQa7mMDRiRCkhLSeghLYO59VZrK69ld2?=
 =?us-ascii?Q?FB9oeAiqr86eRiZFC1wg6Sbt90OBCJyUbaaNpHGwrP16TyC3nF+Otkz5hcQT?=
 =?us-ascii?Q?Kq8yhlgjSyrNeYL8P/+oXVULmEfDcgBHxUPeJZmcu5jaHxaq4lh7N+j32Rrf?=
 =?us-ascii?Q?c3KlC5fqfhXsasXyw0CTo5Cqn26WO2+0/DKfc4wQ0YY2Xg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x3gZig3y4nA58Iy85u0mR/3t40HM63JL/PnmV39QP/hb8zukBROcDdaDfiYl?=
 =?us-ascii?Q?9yefd8tkpPoRJQTgIOeUVnH4mOds6TWoL9/iq+r0wnvq5+jM9gqGn5U6adZh?=
 =?us-ascii?Q?AucO1mHaugYWpG3yUckHcXrBLyFdNHWr7KbLgAeHkPhpH64O+j8/ovnrjZmz?=
 =?us-ascii?Q?zAKIc1OrICm1f/Mcno7IgYyweZPS5wdLpQjEQeDwSppNSoCtWVRAurQDu7dv?=
 =?us-ascii?Q?Ynq5LFvCCmy9ntJa5XucFrMaNolJZV2gCY2Ja/dTxrm29dCRS9y9XccLr+QA?=
 =?us-ascii?Q?t/o2ZRS9yH+3OLJ0XvJcRFfdXBBNH0J2Ft+e0k6ajRa6h5M3ZfSdQouAeRFy?=
 =?us-ascii?Q?SSNpRMFc8RAbFX3PaH/BEjV18QF/5rkefWqJ+Io19cWE0kT+pMEIEbTSEhq2?=
 =?us-ascii?Q?ccRveRqdKGmHJF5T0EF5h7/MAz/V9eGomQn3ty2adg0NhThX86powl8QnWO/?=
 =?us-ascii?Q?BE5vBMRVA5jJNK7Ial4yOdo2dhD7NqR98g7JT7oRiAb761vugjYu/3bgHG2X?=
 =?us-ascii?Q?APCQ6w30MC7uStCQ9Cllx1BTv5czHf0zxB8gjl27kcFKP3gf0YLsAgzBi0IU?=
 =?us-ascii?Q?bdO9O4gYp3jD10Z2dPIYdv7Btvfl1w73Ze2gNrtjwHaYwR/WWwjQQ0RGEuYN?=
 =?us-ascii?Q?iudqQvaJa3ZYz9uLQL1/vYL16V0Kftf1bPaxwk3ohp59NNS+Jh5c8k+g5VP9?=
 =?us-ascii?Q?BGYDd/IPSCIygrOUxeE7QN20NqiHmc/ueXwIHsxrN+ElSRmUM1tVXYQzQgym?=
 =?us-ascii?Q?XLUoO/FR+J0xWxEyEo6rOGNzhK4cbbOBYHFTmGGMRE+jvn52klPTcaq6/2Jb?=
 =?us-ascii?Q?07L9Whzj2LrKF8TmybVPWXdYRoAUmSvXKhSWPwBHB9to0R/LKq1H6Sd+cgEh?=
 =?us-ascii?Q?xSLiu2ghu0gqnro3tWrD3ZPOPz14EI3Be7HFFEv2KGO2+M9GKyEnn/699P/9?=
 =?us-ascii?Q?R9ud2ZJKufZwQJgLXVjiumKwIl/WoOV91F9walpmz4l3VLW/EMvIjB2lO+05?=
 =?us-ascii?Q?/3T6FsBJqFCvVkzzhf/P+FeySzySnnyvUqja0mBD3pOLBi4Wzr4ayaTv3o9K?=
 =?us-ascii?Q?RssocOtRgkbudD2b3fZJRnFVuZemuQjAYHLrQ8TqMGGd8krOu6drOEYHfQZY?=
 =?us-ascii?Q?sA8wFNFBgO9JVm8bhojpOdT9r4uY8q3Amcp8jcIHGD94VS286f8uPZ9ujQ6E?=
 =?us-ascii?Q?h5Ao9qWwzKekvsTbja5XjmXXOxo0kMuAG2FEmNU6Ehbq0sO/PxRi4RppHnwQ?=
 =?us-ascii?Q?TZOiqg0kIlq19hLJEKibrYHv0ENQw/I9sKBi+pHIBPkVVAIdrpLiFJLQOKRq?=
 =?us-ascii?Q?5HxiZ/utNXx1b4I3JN0/0xY90Xwx3uLEooTQvTwIW0eQF2Uhac1ZcXGOWCEw?=
 =?us-ascii?Q?0PJYH4ueCyGn6l3eSNPbq08Q+QSTIWzyBhQYntbn5z5Fi251gudkJX8PUsXQ?=
 =?us-ascii?Q?DF2gpo0SxJyq0jK++IL2jL0+4cDwaY0mDRNl5rwdKz0E8456NOoyucYchxLh?=
 =?us-ascii?Q?YbLJiAqCbM8ZHnxPFodzQXIQ1/t+l5t7zbEHpoafW6AtrpVVYDXGU3rTOjU8?=
 =?us-ascii?Q?1jjHWN2almpcHXiOqh1Tw5Nhz645/53yggTgZy8BUoE21i0L+o2iQPCtoqCU?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2aa100-f3fe-4f78-cd3a-08dd1a337e46
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 22:31:02.2259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvtIHK4mUS6Xfgzn1LYnUxpETNzS6FZiZG8UVaLLfNoT63D+rpF5wMiqc1ydbVTsIwJOb7r1Eqxr2gfmwFpWdlwfh7ExB2YbRj3T3oW4GDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6211
X-OriginatorOrg: intel.com

Nathan Fontenot wrote:
> Update handling of SOFT RESERVE iomem resources that intersect with
> CXL region resources to remove the intersections from the SOFT RESERVE
> resources. The current approach of leaving the SOFT RESERVE
> resource as is can cause failures during hotplug replace of CXL
> devices because the resource is not available for reuse after
> teardown of the CXL device.
> 
> The approach is to trim out any pieces of SOFT RESERVE resources
> that intersect CXL regions. To do this, first set aside any SOFT RESERVE
> resources that intersect with a CFMWS into a separate resource tree
> during e820__reserve_resources_late() that would have been otherwise
> added to the iomem resource tree.
> 
> As CXL regions are created the cxl resource created for the new
> region is used to trim intersections from the SOFT RESERVE
> resources that were previously set aside.
> 
> Once CXL device probe has completed ant remaining SOFT RESERVE resources
> remaining are added to the iomem resource tree. As each resource
> is added to the oiomem resource tree a new notifier chain is invoked
> to notify the dax driver of newly added SOFT RESERVE resources so that
> the dax driver can consume them.

Hi Nathan, this patch hit on all the mechanisms I would expect, but upon
reading it there is an opportunity to zoom out and do something blunter
than the surgical precision of this current proposal.

In other words, I appreciate the consideration of potential corner
cases, but for overall maintainability this should aim to be an all or
nothing approach.

Specifically, at the first sign of trouble, any CXL sub-driver probe
failure or region enumeration timeout, that the entire CXL topology be
torn down (trigger the equivalent of ->remove() on the ACPI0017 device),
and the deferred Soft Reserved ranges registered as if cxl_acpi was not
present (implement a fallback equivalent to hmem_register_devices()).

No need to trim resources as regions arrive, just tear down everything
setup in the cxl_acpi_probe() path with devres_release_all().

So, I am thinking export a flag from the CXL core that indicates whether
any conflict with platform-firmware established CXL regions has
occurred.

Read that flag from an cxl_acpi-driver-launched deferred workqueue that
is awaiting initial device probing to quiesce. If that flag indicates a
CXL enumeration failure then trigger devres_release_all() on the
ACPI0017 platform device and follow that up by walking the deferred Soft
Reserve resources to register raw (unparented by CXL regions) dax
devices.

Some more comments below:

> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> ---
>  arch/x86/kernel/e820.c    |  17 ++++-
>  drivers/cxl/core/region.c |   8 +-
>  drivers/cxl/port.c        |  15 ++++
>  drivers/dax/hmem/device.c |  13 ++--
>  drivers/dax/hmem/hmem.c   |  15 ++++
>  drivers/dax/hmem/hmem.h   |  11 +++
>  include/linux/dax.h       |   4 -
>  include/linux/ioport.h    |   6 ++
>  kernel/resource.c         | 155 +++++++++++++++++++++++++++++++++++++-
>  9 files changed, 229 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/dax/hmem/hmem.h
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 4893d30ce438..cab82e9324a5 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1210,14 +1210,23 @@ static unsigned long __init ram_alignment(resource_size_t pos)
>  
>  void __init e820__reserve_resources_late(void)
>  {
> -	int i;
>  	struct resource *res;
> +	int i;
>  
> +	/*
> +	 * Prior to inserting SOFT_RESERVED resources we want to check for an
> +	 * intersection with potential CXL resources. Any SOFT_RESERVED resources
> +	 * that do intersect a potential CXL resource are set aside so they
> +	 * can be trimmed to accommodate CXL resource intersections and added to
> +	 * the iomem resource tree after the CXL drivers have completed their
> +	 * device probe.

Perhaps shorten to "see hmem_register_devices() and cxl_acpi_probe() for
deferred initialization of Soft Reserved ranges"

> +	 */
>  	res = e820_res;
> -	for (i = 0; i < e820_table->nr_entries; i++) {
> -		if (!res->parent && res->end)
> +	for (i = 0; i < e820_table->nr_entries; i++, res++) {
> +		if (res->desc == IORES_DESC_SOFT_RESERVED)
> +			insert_soft_reserve_resource(res);

I would only expect this deferral to happen when CONFIG_DEV_DAX_HMEM
and/or CONFIG_CXL_REGION  is enabled. It also needs to catch Soft
Reserved deferral on other, non-e820 based, archs. So, maybe this hackery
should be done internal to insert_resource_*(). Something like all
insert_resource() of IORES_DESC_SOFT_RESERVED is deferred until a flag
is flipped allowing future insertion attempts to succeed in adding them
to the ioresource_mem tree.

Not that I expect this problem will ever effect more than just CXL, but
it is already the case that Soft Reserved is set for more than just CXL
ranges, and who know what other backend Soft Reserved consumer drivers
might arrive later.

When CXL or HMEM parses the deferred entries they can take
responsibility for injecting the Soft Reserved entries. That achieves
continuity of the /proc/iomem contents across kernel versions while
giving those endpoint drivers the ability to unregister those resources.

> +		else if (!res->parent && res->end)
>  			insert_resource_expand_to_fit(&iomem_resource, res);
> -		res++;
>  	}
>  
>  	/*
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..c458a6313b31 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3226,6 +3226,12 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> +static int insert_region_resource(struct resource *parent, struct resource *res)
> +{
> +	trim_soft_reserve_resources(res);
> +	return insert_resource(parent, res);
> +}

Per above, lets not do dynamic trimming, it's all or nothing CXL memory
enumeration if the driver is trying and failing to parse any part of the
BIOS-established CXL configuration.

Yes, this could result in regressions in the other direction, but my
expectation is that the vast majority of CXL memory present at boot is
meant to be indistinguishable from DDR. In other words the current
default of "lose access to memory upon CXL enumeration failure that is
otherwise fully described by the EFI Memory Map" is the wrong default
policy.

> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -3272,7 +3278,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> -	rc = insert_resource(cxlrd->res, res);
> +	rc = insert_region_resource(cxlrd->res, res);
>  	if (rc) {
>  		/*
>  		 * Platform-firmware may not have split resources like "System
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index d7d5d982ce69..4461f2a80d72 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -89,6 +89,20 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	return -ENXIO;
>  }
>  
> +static void cxl_sr_update(struct work_struct *w)
> +{
> +	merge_soft_reserve_resources();
> +}
> +
> +DECLARE_DELAYED_WORK(cxl_sr_work, cxl_sr_update);
> +
> +static void schedule_soft_reserve_update(void)
> +{
> +	int timeout = 5 * HZ;
> +
> +	mod_delayed_work(system_wq, &cxl_sr_work, timeout);
> +}

For cases where there is Soft Reserved CXL backed memory it should be
sufficient to just wait for initial device probing to complete. So I
would just have cxl_acpi_probe() call wait_for_device_probe() in a
workqueue, rather than try to guess at a timeout. If anything, waiting
for driver core deferred probing timeout seems a good time to ask "are
we missing any CXL memory ranges?".

> +
>  static int cxl_endpoint_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_endpoint_dvsec_info info = { .port = port };
> @@ -140,6 +154,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	 */
>  	device_for_each_child(&port->dev, root, discover_region);
>  
> +	schedule_soft_reserve_update();
>  	return 0;
>  }
>  
> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> index f9e1a76a04a9..c45791ad4858 100644
> --- a/drivers/dax/hmem/device.c
> +++ b/drivers/dax/hmem/device.c
> @@ -4,6 +4,7 @@
>  #include <linux/module.h>
>  #include <linux/dax.h>
>  #include <linux/mm.h>
> +#include "hmem.h"
>  
>  static bool nohmem;
>  module_param_named(disable, nohmem, bool, 0444);
> @@ -17,6 +18,9 @@ static struct resource hmem_active = {
>  	.flags = IORESOURCE_MEM,
>  };
>  
> +struct platform_device *hmem_pdev;
> +EXPORT_SYMBOL_GPL(hmem_pdev);
> +
>  int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
>  {
>  	struct resource *res;
> @@ -35,7 +39,6 @@ EXPORT_SYMBOL_GPL(walk_hmem_resources);
>  
>  static void __hmem_register_resource(int target_nid, struct resource *res)
>  {
> -	struct platform_device *pdev;
>  	struct resource *new;
>  	int rc;
>  
> @@ -51,15 +54,15 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>  	if (platform_initialized)
>  		return;
>  
> -	pdev = platform_device_alloc("hmem_platform", 0);
> -	if (!pdev) {
> +	hmem_pdev = platform_device_alloc("hmem_platform", 0);
> +	if (!hmem_pdev) {
>  		pr_err_once("failed to register device-dax hmem_platform device\n");
>  		return;
>  	}
>  
> -	rc = platform_device_add(pdev);
> +	rc = platform_device_add(hmem_pdev);
>  	if (rc)
> -		platform_device_put(pdev);
> +		platform_device_put(hmem_pdev);
>  	else
>  		platform_initialized = true;

So, I don't think anyone actually cares which device parents a dax
device. It would be cleaner if cxl_acpi registered the Soft Reserved dax
devices that the hmem driver was told to skip.

That change eliminates the need for a notifier to trigger the hmem
driver to add devices after a CXL enumeration failure.

[ .. trim all the fine grained resource handling and notifier code .. ]

The end result of this effort is that the Linux CXL subsystem will
aggressively complain and refuse to run with platforms and devices that
deviate from common expectations. That gives space for Soft Reserved
generic support to fill some gaps while quirks, hacks, and workarounds
are developed to compensate for these deviations. Otherwise it has been
a constant drip of "what in the world is that platform doing?", and the
current policy of "try to depend on standard CXL enumeration" is too
fragile.
