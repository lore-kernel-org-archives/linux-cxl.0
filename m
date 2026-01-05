Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D137311C2C;
	Mon,  5 Jan 2026 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767651276; cv=fail; b=Z2N+acneC8WVG2aoVAm+Goc8Kt5nX95XlkERpPoxlmsade7uIKGcG3bpQIQrq8MoazVUXNsXrUHKX8ZpbqphBHKOT9QxpCEPCxL3gt+prlpiCIANrmqD1Mc737f/YrMfyI1b5WF06V3l/s5OIbBfnL7nvq+sImqY/qgghHWt5so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767651276; c=relaxed/simple;
	bh=OAAL8+5rnj6YeMTDxX8WucIIy2qzv46lt8/oo2OElpE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z/nMlmv9AG8OGnbKRakM10KTCKE+cLN4Pj8bFfUoileyIcQS9UHEeYROVE91XJQFb+l4q/1oe4fpdLZB5QkB4iuWeYve8LreUalqFV7I6nPtorsJCdi6Sue08QcfLqvG2hu+zB/VATYzUo87CkpCjzg4rcPLFKONL8HXFkTAvb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzKNfJ0b; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzKNfJ0b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767651274; x=1799187274;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OAAL8+5rnj6YeMTDxX8WucIIy2qzv46lt8/oo2OElpE=;
  b=VzKNfJ0b5wdOHSqs3+ert11iFlA+Ym7LbcUIHB+dW6jxsd0a/8WKp1Px
   mXTwz9XOHZmzFPSrjFvpcBdIMwBIl1TG4pnUb2xO6Xg57EDTYaWGrxM/I
   umdXg3Sr6wlByZyTEMmdaVPjTmXhizeiwImdMjIeNT5vyL/u4mdG+LxZT
   hoJ8+IIYojoUYnRT/ENuYs0OA3hfEGF97ZDL+RVPUKyhirDGyUC7st6Mj
   EUlJl7oORyZfNqH8F4AxMzJj9XOLDZKFQjC2JCi+iSC75BJjP0vZs3O9j
   SHbRbvqtwXKujhMNfufLxJFMyfsgo1gZOD/Ys8YdrYJ5JI5Dk38tzbRdj
   A==;
X-CSE-ConnectionGUID: CxOFKMVaSmeso1ayM5pymw==
X-CSE-MsgGUID: 8yuYkD/eQUq3nLEyQeGjdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69062771"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="69062771"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 14:14:33 -0800
X-CSE-ConnectionGUID: v7dDXLMgTfqhjnJaHg+roQ==
X-CSE-MsgGUID: i7I59SnpSXSgwSjvIOsbfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="202963220"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 14:14:34 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 14:14:33 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 14:14:33 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 14:14:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKapR1cBeJI0991AP+meT8RR26aYTiP18+L+9AKQPrDEBXUPTn/rre9rTEBMpejuWEaqLuZfb4GeWp2xLnsrWjzsRPjH2eOXNXXE1AsfALdFLZQFhcd9gjsTSIrLZ+N+Er5ANQGeFH5IsmUpF2Q4CBfG7hvOOCWg5v7e2Umjp3o4CMzy8eAbph1drhw+5d+MzXAww6SF/sFrPrnE7dTOnoYKVvpWJ6n8KjEYTGSY48cfxgwlSieG/ZZFS5fcyTIZKc3iOxC3Q5dVNRU5J4NfsfwyPXEkvEcw6imXWVrhPIIlkpRq/DEPq9M5Xx869sGhVF3COGHqRG0UGELnD6RjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5KOgepjY/PkxJiF8y3+Ixxgx0jF8Cw0wEDx/HKgOYE=;
 b=vw36ZtOPF4Meo7yB1//fR0MzqIYUuA7Crj9XvJlfomkRa1xrybpy6K1/S0S0s8UHrQ6PZkgdRtVsVmH2KoU6YaE+1DmwLX6fPJcYPQl2zjMjAt7bjBdVWXQqz0qwzT/Isz4WBkjf618Oj1FZUxPZS2FVBGQTm5n8fQ7RvNB60QMywar72V16QzeJ7JLJs9TFDR9TaAayIl2nbeF5lZrWaLd6C7lXJUM3ThhQc2H7SGW2dQwEj/z0NGkUtRkhz8+Kt1ilcARZF/wCXQiPGohPnC69BVjwa+AMy0fV+EoGNck5altJjcpwDdyWNEI1eFS/JkJAIe71+/p2WDGxwhCwuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9131.namprd11.prod.outlook.com (2603:10b6:208:55c::11)
 by DM4PR11MB6429.namprd11.prod.outlook.com (2603:10b6:8:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 22:14:31 +0000
Received: from IA4PR11MB9131.namprd11.prod.outlook.com
 ([fe80::7187:92a3:991:56e2]) by IA4PR11MB9131.namprd11.prod.outlook.com
 ([fe80::7187:92a3:991:56e2%5]) with mapi id 15.20.9456.013; Mon, 5 Jan 2026
 22:14:31 +0000
Date: Mon, 5 Jan 2026 16:17:31 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
CC: Arnd Bergmann <arnd@arndb.de>, Gregory Price <gourry@gourry.net>, "Robert
 Richter" <rrichter@amd.com>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: fix format string for resource_size_t
Message-ID: <695c387b6f5b9_90b64100ea@iweiny-mobl.notmuch>
References: <20251204095237.1032528-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204095237.1032528-1-arnd@kernel.org>
X-ClientProxiedBy: BY3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:254::24) To IA4PR11MB9131.namprd11.prod.outlook.com
 (2603:10b6:208:55c::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9131:EE_|DM4PR11MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 27410b73-3d3f-4912-11dd-08de4ca7cc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Avmi0MYhYboaRKP1NL07CSCEVgUichrAvafBa7DwlJ2DfI2T0PWdk1dLoTdM?=
 =?us-ascii?Q?uRYMn9+RcZbKUcQ7dmsnMYWUS2eYCtXPeGNnbvxsO2PFhzuoPCFFVW5Y9UK8?=
 =?us-ascii?Q?ahgL6CLSAHaJy5NAj5ekG/8j8HQYgAtaBIHFrnEB6UpUH6u83K0jv7QYku82?=
 =?us-ascii?Q?rJhNKkWnvvlN2P0t7lzPfurWMVBfPWT/hiNypuIuHd23yaL0Xk7qGxnqLPaK?=
 =?us-ascii?Q?KNGUU9FvNhS0pwEgzom3zLRJRTYHk5uPL0AL1btOtI/PVdNNiR/T6X56QF7i?=
 =?us-ascii?Q?xQrgr7TG15hVAzFbXuSp1V/pSHxLD2b+uFncf8E0Wg1if2iDaLHg3XBoYhPL?=
 =?us-ascii?Q?UZq2+6Tn3X4KYCtqSAlQm5170k5tsJhHwOb1je7/GQ6LmQ0ohfh68NlS3xE6?=
 =?us-ascii?Q?TS8CewyBH6PBBgYl90HRzOg5ufZW0Gg0oHvwlpegeBzNS25tSMwPE4Kw3VWZ?=
 =?us-ascii?Q?WXik/+f/uHeVyRMPBsN0jI+usaqzisbXjE/hSTN/BhY+8VF4VRn4CMuOZX4h?=
 =?us-ascii?Q?e1GnMWonOI6u5nXKQYmRJx3Y1Yjh76CwHy+CXVAlhMauOe4j0EK4bqCrU9Kb?=
 =?us-ascii?Q?6fSckC/fWBD2PP38zo7LDFQJXreiYcq+hIAVYQnwqCnWVxiCqgAnKGaxR4lU?=
 =?us-ascii?Q?A02QjObsvOdgoes1L+nVD99zAl+HvP6XOAMTSBsj/orxj68xQZf8YJfYeQAZ?=
 =?us-ascii?Q?wiroWPJnHqW7GD+WqHfWcFI7qk7nAIpDjK3rmqGGAUbXTHHG5t7XVsUHh01I?=
 =?us-ascii?Q?kT3kLEgTH3hG1kEy9EqPrSBFUF7RsExgCdIyCV3rv3o22o2Sl7FXdxwB7ht5?=
 =?us-ascii?Q?SsDJ4wT7tT1TaoNil6mdAWKU6LW5y0KumKMgt24zwPS7orHY6quBYjrwrso1?=
 =?us-ascii?Q?52YJF4ZBfz0z1ltDoLSAwLvcjl4hnmv9QZUoK/bGu11/O5Ld9TwFD2CxdnfH?=
 =?us-ascii?Q?kLEHFuAV90E/l8WyUI2+9yhpTGX+9kohZgpGFyg84U8AOWYQvmP1WN9vrBgy?=
 =?us-ascii?Q?bOWNgi2zZsyDQAZB90jM/8KZYxB9JlEec77wFNCZGmo68G5gQGsx9rQgGdtl?=
 =?us-ascii?Q?8c93U6arP4/XrlBmy0BTLLRwBT6lyxs/w3QGv5nOtkfesfKDjpN9yB//7sUG?=
 =?us-ascii?Q?LrKI1X+PdJWrJv4tqwC1l0rdzc1yUaKdGESkFDvzTlftT1WxA9MM7wYRviVE?=
 =?us-ascii?Q?yxAPdmDiLkvsFGh7ZQu2+nzcMy6XGNXspQkg58Dxqasf3Q7mXpfrKDgrVNby?=
 =?us-ascii?Q?k5kgSEtJNpE+1sO0JPikWtKqswv+WQEtHjn/3cz8Owl0CaMQunqpXrKaPi3H?=
 =?us-ascii?Q?HZl89LJtZl92vyI79MrSOFmv08pYEyfVb1MJs8C4jW2n+2W9yT/z6KbmsahK?=
 =?us-ascii?Q?7jtuVzaa7gt6+iL/ETexoWb92MnUFSQJXlb5EvbdGV3IKfYW4eanboZf4zY3?=
 =?us-ascii?Q?KFlpr+FFbUz7pucVWphw5iI/BdNGN3Hx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR11MB9131.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bkYta8M4aDCqZ8ufYK1E9NJDlVHYBR8Hc0Y0s8D8o5eJl7ZxmV1Z3iVZQWC/?=
 =?us-ascii?Q?fJpqgl3ncnut8pesWu9Ym0nmBbmm5JIi+sA4aDLtqmDi1NpzXLhZpkSJ1iC3?=
 =?us-ascii?Q?voOAAhl5T9xi8Ma9pziekBEakpl2eWsEMKcMZOKNUbe3psQGIhecCn50eBRb?=
 =?us-ascii?Q?SpsDRJxRLBKjm4I6g9vbDOmRUdVfGiS/cGoVwzu8zgRUtjVqmbeYq3MQqrUz?=
 =?us-ascii?Q?YkZR2gza43sm8vPWY0gewz22WnABiUO7tqF/wdT/fmKhC1LRmioWeRjcKnmB?=
 =?us-ascii?Q?m5XQL4bjpZROVwXlnc+EgemkPl71hQ2R2SqY+0Hp/72jAVktdYW36hkNV7ne?=
 =?us-ascii?Q?7bCl0v8N1ddocDJLeV+Lwj69vB9/Ml4kG4xOTGcmUVZtfWJBB/+0N0RbiaJc?=
 =?us-ascii?Q?p3VZUYYIaJcsdJAj4zb7BmInE2hm2y80ZH7xu/u+yEBdM0GEJJSJznxK7aAJ?=
 =?us-ascii?Q?yyqz+5WEU7px18ZF8wxvuiaujigmVmIjI6Lsv9mANtsyOOc1ax16RY2229x9?=
 =?us-ascii?Q?6+6YX8f9DOfYgoaKOrkOBHOR+US6RqZX/2hmEajxl0B1f02mZyIAXwSvgIMd?=
 =?us-ascii?Q?YaHcMDdaRfvndITEsjBhVn/iB6bpXmX4ZxKhCTN0Erkfj00a7xrsStxrhbl5?=
 =?us-ascii?Q?Il3n6QTi3rQA4VFtwt6en5FPkxesZQR178Fc7zy8pyGP84qet0dcQFKLfUzA?=
 =?us-ascii?Q?qLRr/vNz4+3YSy9974cvTHZ2KRAx+dd448Dd2C6bIINttVXsG2S7jBU/VUTj?=
 =?us-ascii?Q?02dVE5ZWKAAOqM/LcLZUHbglieElp/uxEtviBg8YM8JSlXV7Ho8yppgjb6FZ?=
 =?us-ascii?Q?MXB4fd5qPrkocDk6BXC2MoXOiF0hTgo6tWdRnQ8FG4AUnaccoBPo0IeoFZmm?=
 =?us-ascii?Q?YOYHBMFbclA1o1I4Q1DhOYEDhnktWfnDOsnt4RGRE3NWtAZdUsdTpTjTThR4?=
 =?us-ascii?Q?Szi1dBqs/2eUrsnvrolhtU2TYTEqSC3I+D6ee1e6U41qtL6tnZh+IdFOL+f0?=
 =?us-ascii?Q?FPaEkyP3+ppRZ/w6wvBvFHNJY/j8OipfHsp1rWS6jHw++J4UTW8BGdSjxQae?=
 =?us-ascii?Q?E7AOCbH4gy9FUUF5Y+qwbNW/zdTVXOOsdZYdH6/vyWsLG45IUZ1E9WRiUwKt?=
 =?us-ascii?Q?L+7DazXyXIGgMgdXvXlOMpA/I+VtuHSMsusG7B+oxVNHyEeANP/Gzlbq2EFQ?=
 =?us-ascii?Q?FVj3XJYoZH42tLMB8+rER/47KiugRufFLHMCgxrFKrsYPxhV/OItExBsxyeK?=
 =?us-ascii?Q?cOJhRGJSxWHNhFVm+SQ/gg9f5Pa4BXnF3xXLPqH9l9nIazs5CMEQSmn5aRJJ?=
 =?us-ascii?Q?yG1W3Zzy9JxKCgKbTyJFoszanpIO0Q/jU4E3rdaMHaaIG1bD6I3A3teYnVWT?=
 =?us-ascii?Q?qYGa66/bKavyE37ODXh1JFwoL4B59o+lNk3CbmFfTui7cXRhACcwb7Otf681?=
 =?us-ascii?Q?7dDHoSajv23jawgI5bVo64E1jI8EbUAlfSuxSoalVsURz52LHv+Okh/aCd9Z?=
 =?us-ascii?Q?2hU4YK/Eqfqxc+P22L+jHKkqODrUOlGsAsKFtmSiOeJJeVBXMGDbTEHoJQRP?=
 =?us-ascii?Q?GGiaANhSAeAHDLEAVxeQLM6YJTYZ4slKB5DPkTsMtJ7JLV+yhNm6ly+MQNPI?=
 =?us-ascii?Q?nFLEWioTC+zricDfftQzCyKx3qpWWX2WA/HXPWcfHvJ3yMXiYxs07nBls7Na?=
 =?us-ascii?Q?tTwKnkLPbZlIyRKfrKnLZRmuq8swFU7r/fnIKqxADDhUsBNsn47g8ruO7Eg5?=
 =?us-ascii?Q?NW2o5CwSeg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27410b73-3d3f-4912-11dd-08de4ca7cc97
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9131.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 22:14:31.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPDE/6vhhnSSM6vbUgyPFbmETBsNY82c1LddPzZZQTs9aUVsggGM7ngYTkvp7I9B3c3pAuuztSCb2XL6EYp/YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6429
X-OriginatorOrg: intel.com

Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The size of this type is architecture specific, and the recommended
> way to print it portably is through the custom %pap format string.
> 
> Fixes: d6602e25819d ("cxl/region: Add support to indicate region has extended linear cache")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
