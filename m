Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893394F5EC;
	Thu,  6 Jun 2024 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717372; cv=fail; b=NUFWA6Yhjr/3Mashkt3QZCmSAYdgxT7koGmbM1eA5ircKI4/ThNdZuDWvvXiHOrr/IYsnRdrrj97LJOGfXBy/3Zh04IoCtNFL4o4t3JBRvh81fdlxrQRZzwfOlcZ7HK9FyJRJoxRF5/9HdBYcwukpRJbDk1b2ns8odh1bxIhuH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717372; c=relaxed/simple;
	bh=oP6GwmE6ZdbnL8A3hYZy6P1TKYX3o9xEYe9S83FQWd4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O1UDdEHyUpMUoK9HzlyVNLPf/51MBhIXHjMIHlHhWr18xgf1+xhhFLqXzIJbXv14pvkfLO8UAc7VQP1E0Dci2yIjYaX9tia6HQuXYU5zIf4qcd6e2dEeI/SuDtscKxUsTo2yCLAg1dUwVv6OujDgyf8Cx+7zaoMzdqKHDkzSPXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROiDJr6y; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROiDJr6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717717371; x=1749253371;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oP6GwmE6ZdbnL8A3hYZy6P1TKYX3o9xEYe9S83FQWd4=;
  b=ROiDJr6y+11+3juwCJLC5wKBKlpWoJ/zjpPokB7oAxCkbkLPvPREMUWn
   B/7LAuIUaEpt3+ckG/mNGsVDp02kXN8TQOOPmlZ6SnnFwVnzPsTjrt4fo
   Po6VbK7yhAiFMWYzDk1XKk3v39eDW98dal45CVBMm3xJOd4UAH4uvYt0I
   QjOVBOHyW8DRHbee/LOfa2KnWwjqCpTnz5WFTCy3L2CsuS/vrUzVDGWn9
   3G2ZtaqT+XInPvoETuo2DdKJUoyuj9eF1SnsTJ4GhOv8tt/LkS0f7FYNg
   BPEoowo9DZZMYtkrMI37BwMlAvnrBK/qthUfVFsjjL+gN/DAvYK8/bhLv
   g==;
X-CSE-ConnectionGUID: NuaLVEhVRq2KUx9Ln5vzfw==
X-CSE-MsgGUID: A7VJZ5y5RXSgPGB184BilQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="18271924"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="18271924"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 16:42:50 -0700
X-CSE-ConnectionGUID: Rqk/RE2pRW23jLHyTcFYfw==
X-CSE-MsgGUID: lUhJfKY+R7CAnM5PEoHE0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38130111"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 16:42:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 16:42:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 16:42:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 16:42:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 16:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv371El2JRimu+j7kqIt92uuld7n4QSBOMZr2KEq/At43Osjbzo/SQtEuCqHu3xWIHf57tWGQfhYk9tsXtbsbUb9BOJb/2PXfqTw3014tnsK4vjvkV4D6ln6Af75WHim2TZYxyGFp96zwS5FHJ8m15lsG6e0fdZbTi+4H6v8X3rIS4dJRjoaB9ys30VizsoLhIfi21/w4cb0pcSyLfmZAfOEr0sXKQI4kaaZoD2SoaI8GON1vKhsPuyCys5tiVTzy6pQ4kJRk8DgMY7YmF84xHS0ZRbE1kTv7MBqppKyLMzOo+aQWoSXXEAZEMxHm+UEX/XsbWwbUQdvCHfqoHtBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2V4BWLuoHyS2rV1EA/zk2PQwkeFGoT6S9MGOjo5GfQ=;
 b=lvJS9NCztCm1pgg278WgRnL7xY4oiG+B/LAMr/GwHCkuF9eXKmH2bTxvyL2cyRDlINvnKJS5+ZYbooFCTHNrdSL0Rgr26XC4lWRHL+8heTN5gmbtwG9gzUrG1WI47hMcAT9rhaNdVwQwbRIXdm6asuRJGeuQZVExumGP88oUrYRr8fSysjCcaueNwQi5UL7ZN0a0RsKNlHt+Fw2RSjsM94bWSXFY2JvlwZ15lxi5pgNEooh4u0nN1nd0UQ7C1STXeMv9zXOEUuJTNq/aPbEOsz9VBGWB9/OJ6t4vAEag4uQsgtCAz8w4q9M1//VQl0QWVNLuEwwoSEDePYu8occCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5132.namprd11.prod.outlook.com (2603:10b6:806:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 23:42:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 23:42:47 +0000
Date: Thu, 6 Jun 2024 16:42:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] cxl: add missing MODULE_DESCRIPTION() macros
Message-ID: <6662497490e90_2177294e4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240603-md-drivers-cxl-v1-1-f2940f5c0836@quicinc.com>
 <20240604170445.00005c67@Huawei.com>
 <362fccea-707f-4430-8da3-8acc6ac5fbe9@quicinc.com>
 <20240606151521.000018fd@Huawei.com>
 <b3405ab7-b322-4ce9-9dfa-efb52438383a@quicinc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b3405ab7-b322-4ce9-9dfa-efb52438383a@quicinc.com>
X-ClientProxiedBy: MW4PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:303:8e::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ef17b4-a9f5-4032-768f-08dc86825eb0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?swE24nYe66upbU8c6AxFf5QYqIsk2Jpiuel2k1tktFvTqSakwIBMijWd+zRW?=
 =?us-ascii?Q?Xq+5D4cyS4zHk4ofY3rQdnbV2qVQufENa1zUlavm2/6TKDC4Dsju99hEsJ2U?=
 =?us-ascii?Q?OLHn/PrUrs60caX8oW3kIEMFASwyfSv7dgGDAx3vl0yWUmgYWTrieLUqPxm4?=
 =?us-ascii?Q?UC+mfZTPjNbVdNdrSwtocaxolSGLMpT10W8mZq2K7ExoTFA4wPGo4FbZf5K5?=
 =?us-ascii?Q?rpf37PSGqcqNhVQvqItbllJy9t1S3mxztKxwPvQZdrAG4IqflnydhhpBJeW8?=
 =?us-ascii?Q?DnY1Hknr5RA4Dan1ATh1v2xhf5Ko/1N8WPA8monQAZErk2eRx9iNAN1GPtbG?=
 =?us-ascii?Q?QeboxKwwe58OTfSLtXxls9wDNGF8jp8roMRwSxPekooTiTeZXYj8RQFM/F4a?=
 =?us-ascii?Q?VDTdLWfDF0gcDK5RjYxbV6NSukngEG9nKfKjmxmEL0RnyAhNys64DJR9phlx?=
 =?us-ascii?Q?VXcXRD3fisq1Jm7qCJcqTXLP/DqJoox6zTZLNEHlfw5mZcqMd/CZpIg6clvG?=
 =?us-ascii?Q?2iTLi/B4LdzUNZlx9GlIE5D2nQfZIDfPFfnik2lPd5zq3s6iIZycY1Y1ytiG?=
 =?us-ascii?Q?J5fgEx66enmHrgngQ7rpZnsbBKKAJN1bUbQa1rvVqQWvHyZWoy6ZpUfPcUYI?=
 =?us-ascii?Q?rxOY3PqSro89pGzM5nOt1/iWM0tO+Usb+mSCwkYaT4BfPrU0Q4njtZryG8Y9?=
 =?us-ascii?Q?OBNoeV4+fxeqbrLcMMyi6YeZWJQdsjGemLlCc/IzSe4yuhyiODbjNI4/cnWO?=
 =?us-ascii?Q?1cILgZhG4JlxvZmIVf1sKO+zQ76Zsg+JyxLHsaKIR6ED4SNGuAKRgq1ghNkZ?=
 =?us-ascii?Q?PeKL8MDsoJ5sE5tKBfLsu9Qc4yQV26inCGH5J0i4pxQr7rnpysg7zcOA4FF+?=
 =?us-ascii?Q?Mqgfhcki6w/i/r36BWOWFo02v7TtOJjGonsNOmyyAgjpt3f7IABOiS4XmDnh?=
 =?us-ascii?Q?s5rIfNWnviF1YNws2Z4hWg1SOfWNxYGERw6AV/curBwp+wH0BvvCC8Upbrdc?=
 =?us-ascii?Q?kF5A6foGpZnSATgaBEieNZwZeii3cemayvaVG9usp7Xb9trWH8nBUdY8R3Cd?=
 =?us-ascii?Q?PGUnQOnCziY0Ah/zs1JXi6tIvoAGOk9D6wPWrZPlDFjnjRjnEem0/zOB12HJ?=
 =?us-ascii?Q?P90GANyhhW1OO+AiPzfKiSdj1QPlPGhWZY6JPPRyPAerS+2Pjrsax9dnvBKu?=
 =?us-ascii?Q?E5lLJAV/ZGs6Rx3W6mgqCjBF014pCcJvdMNRSUUQ4IMif7Cj0e9aJDssw+HY?=
 =?us-ascii?Q?hpYIntt0XTsqhSpEeE/VhbQTjAf7oPimQYtINrg8RIYHe81q15eajEDCr/6u?=
 =?us-ascii?Q?WkhNfG6Km4GUeM8zYIXQ2jPY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0WG/3X93DDFHp53/sSlqLdDGWJXA/j3MmhoJi7akC215IX7HJmum53swoghu?=
 =?us-ascii?Q?d2qO2vspMpDKAIyaL77AqZs4zKsUjZNq+0R3lciQdxXCGYTAngVHM2oRw3PJ?=
 =?us-ascii?Q?+YYMUWUfJhPluQ2NOOEnYyrU/t6xUAPb6dDf7dYg9/Dl6gjy9YG1SJdYoCmw?=
 =?us-ascii?Q?ckibo8aWBYFcFyn0YndDhsqikAA99bwzzi1T6zxcCuXZhO7gsatqx2WVCex4?=
 =?us-ascii?Q?OuSAELPZB40GdmIlMQtV6tkPlJs14bNruzQfZCFoqvQOlmg64ZqxEV8gWLM4?=
 =?us-ascii?Q?g3FOGk5tA9p+PmBRidJBgH77UcuG2hD2VLDrmx52W7bn2nanvPx8Apw7CDyo?=
 =?us-ascii?Q?0affB0Q9EbBcUs+MD6rq0CeWLMStlO5rGNOpyA6eLe6BCEio0ZuBQxEwKCxB?=
 =?us-ascii?Q?/qxMZvIQOwY8NnS+xUkIAlRBUhtAWyPHyGo2gpz48dFROl8G/wUZhLLtUCmr?=
 =?us-ascii?Q?e5bFxwg88VxyUW6MUPs6MyRbDQqkPD0W63+vJuOow3QLEEPCmvfEpJ20XuC/?=
 =?us-ascii?Q?DHlk1MVT563qGU/OqzsKZDxDi6gyqVqUGZY6oaYuYsHoyw+DpqLbnlLOCwZ7?=
 =?us-ascii?Q?DGyo8ni03bBU+WFP/n0PHJPHRu6abAdo4KQz/CWshnZnUxuqm7kEt7Wshifk?=
 =?us-ascii?Q?kM+uL4mUhSYsnD5hBYc++kUHqCdd/Q/48dqVDOE3idMGaYhhmgsqwpzK3iLq?=
 =?us-ascii?Q?cvriI4q1HGI/q5dp/T9Q4DMIa1BAdxk/rjzHIaolenjT3pAIzvu1nLOcFVGU?=
 =?us-ascii?Q?DFewLk5DM5/gKJT3kSA0jm+tWoVCIA++VJOmHPtdHZBTUbkBL1lF9+sBpox3?=
 =?us-ascii?Q?UT/Bhb7KD/PzHyOKXoLTJoLwcZKE4Uk29opeybZwFENt6yhDWLUJSnHxcj7h?=
 =?us-ascii?Q?Ad5doC0afuybKdsOm7zHsQY5jPlcx31svoLWaKGOnuBNf0kktsqsLabd666C?=
 =?us-ascii?Q?cOh51KJPoSBdUF2EQcrAglz/ynFHx0PJaS0lC4vRHb/5io7wFdA0JjW07dfj?=
 =?us-ascii?Q?u6wStdqkCzYOILsgaN7HETo8+osHUmA3IoGAbLjWy/1EcxsKoPELVA+aJAY7?=
 =?us-ascii?Q?/MQE201zqQMMZKEXAQnC4Pppv20ax89gCPIHIQvk9qg09vMLNXMJq3EB4WBi?=
 =?us-ascii?Q?gBIDhF5mb+aUxS7zkYC/0tGCZg57uDf16Lfx2jinQ+6hjaiBJCtLDsR5jG4s?=
 =?us-ascii?Q?2DRqFPdZ67YH3Hc9D1SfNo7Zlu6nJFjtwuytzYdkDDhTzBe1WqsGDpTbgZvQ?=
 =?us-ascii?Q?760LmsNJqcfk6RxCfuKznfeVxuPXyzRLp9R79bc+wzTyc+sr7nP2HWobQpFS?=
 =?us-ascii?Q?5MrBZuyvgITiTXnQZOf/33YyPDaghTW7dUf7BizHLuvBwcgMnIZMNP6CXOW3?=
 =?us-ascii?Q?vJAmlDa3xs3SEczyaIdvnRaTAvIrkQrmWj2Sv2Mwxd1PgHYzTimjmN1Fi01B?=
 =?us-ascii?Q?E2/GDJC38qUeQh7yuGFLbWjZgfUepClCIBcTquaWRbuDEAfqXIRpIV9Q+Gq8?=
 =?us-ascii?Q?/Vl59C8nmARG3gs6YiPeH4AAYM0cVsKcp577h7yAdZF4Q+O2YygeKFK8axze?=
 =?us-ascii?Q?AF+A3sObRtJfY1sNCjy0x11Z9ZV2HMjVT0CIEaZQezLLhHnFGqFM+Axg+tHq?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ef17b4-a9f5-4032-768f-08dc86825eb0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 23:42:47.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNEv6dLZe+tdsQaerBMLBkXZf1VN2eOg+Q1rXiUeuXo5p0C2sRtnpgxlCW1WIKVD8nFVquD37I200znZoi38MhHHPOc9dUFJMXP0NGH11jI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5132
X-OriginatorOrg: intel.com

Jeff Johnson wrote:
[..]
> >> This I just made up from the others since config CXL_PORT doesn't have a menu
> >> description or help text and the .c file begins with:
> >>  * DOC: cxl port
> > 
> > "CXL: Port Support"
> > 
> > Not that informative, but I can't immediately think of better text.

How about "CXL: Port enumeration and services"
