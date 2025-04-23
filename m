Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D8266B5B
	for <linux-cxl@vger.kernel.org>; Wed, 23 Apr 2025 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388644; cv=fail; b=lynsVWasf9glKAwPJ/0Qfmr0tLXKmF/RJuR4ppjTynWk98ro6JnwYRpkY42pOW5Y6r+dI06b+XWbzNegYTo5+G2LFxDU1g+lIPs1pnSDn0/PD9vi0cYJy+yJ0xhcsUleI9vy+We1lgWlvJBGLd+HCZTCqb26VO0YiPyE45aGCYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388644; c=relaxed/simple;
	bh=cZVC3MfB51xeOK5nyxY/hz7L5KCxgMh1ZMRRzooy8KA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tgjzD5J59/WMiwk9d0tajxBe8LHTp4ninJk/XUp1dplFISFYaRTPi99BhinzYRHvns2d6/mlL+C7TxbB2KdVIIJ90fd9+S+fAXVLOSb+foXWz+wdMgfNxhz8Z7c/GDeWroDW1gRQlo6KYKiGul6r3kJ7sBhoaCeChgTC0XjoOPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eq9zx5l0; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eq9zx5l0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745388642; x=1776924642;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cZVC3MfB51xeOK5nyxY/hz7L5KCxgMh1ZMRRzooy8KA=;
  b=eq9zx5l0pckwlGDsSAiWo8KAuixo8TT29E9l5ECNyziwp5cyyr520sB6
   2BK1pttEMAyNHTWnA5M/22xJ6d4D4GyHnr+6X4Z3eRc2cMg2b1wb714Vg
   nY6VGOaqoIQ+I32ES1h31AB7tEtSYWLofdYl7Ylqzbqpvyua5720abnEd
   f1etaTCVayyd5PdQJB1zmOTFz8KJugKqs3hFVAgN1kowB4YbSCiYKBsjj
   QgkO/O8QOpSFJrLQGMpa6Xbz9aUo/Wqf0+EnLhKxXL0uM9PrGHu5Hi+EI
   EldnJcJVKoyeG8fbCGS1pQctEg4PPSlhOiojxoYiwmG3mQlhiHhCr0l7G
   w==;
X-CSE-ConnectionGUID: 4SiCM8EBRBS4LAfRsda5Og==
X-CSE-MsgGUID: j6DaCaJeTgChXAZ65h9npQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="47066204"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47066204"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:10:42 -0700
X-CSE-ConnectionGUID: 7xOa01PTRbuU/7tSHYOQ6w==
X-CSE-MsgGUID: rW3JzW6SS0G8bHR8IgYZbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163181489"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:10:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 23:10:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 23:10:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 23:10:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqQq06em7438YX9o5rwF56kkDmIxpls9qT01vXGfMxeflors2KG428HbA2jcjk2sCxdM/mjQ6kFbQheaCp407LdS6jtvSZ4So2hn/XpnA269MkaBoG+gSVhDaof+LwCch65imU1iwSBBjeBZknVZgY+3k5H7F3EmjxDI3YPLCO1T8cg2hwtL82qJi9RSS56r22WAlPxf+2hKnPizJiITRgx9Gsx7JU0tB9JxMaWUaxy4EdRJDE1M/nNTJsz1OUYn/0piO9R86vhZeavgSMcTnWrR+Q/kLaR6NX7B5VxfNEHy7zJ79wZ4dgj2hQ4ELrHzir51uJnLkHPJUy50jVI4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXAbJ/rI2tdfjZchPeoZibStumeiE0h5gESc5ko0Sxw=;
 b=uF04U+UYEgNQqF7+qkkhJOEMJ2DvzWO64NSHZ8NDN7YSVty9V5QGVTouH0yj/99HR1MXNbTPFxgSsGGRNv+nGOixPqx6Hrl4GtD9gZsGLWpaZaiTXpDpM+WFVl4xluKSChGu88irQJlHHjODTX4x1W3fw49F4++OucSLowF1gzrp6YBAIyt5IG92gC67otGwyXCMDmKlWMSc6ZOVqADbgSILtiIhDjpSqdqhN6Kj3MYTtaU+x943ZiKdQ9SU5ZLGxyQILRPaPRfLG2Dn3PL8yYnjlKMn1CE53Rso55ZO2x3Ie9kcdsdzz9M2q6QRMTZNUoWpqDcIVRCG84vONWit2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6253.namprd11.prod.outlook.com (2603:10b6:208:3c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 06:10:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 06:10:11 +0000
Date: Tue, 22 Apr 2025 23:10:07 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH 3/4] cxl: Add late host bridge uport mapping update
Message-ID: <6808843fe48e2_71fe294c4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <20250404230049.3578835-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250404230049.3578835-4-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: b3136dc3-390f-43f7-c075-08dd822d8146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DVo1/9f0igvAePL7p8VuXS4mXiy+Ph3+5f3mSmHpygjv9jgI2Px8cHbTnYLM?=
 =?us-ascii?Q?ekhX+4u02KQPSB2COyL6/rPhhFQTqWGvsb5vI9+4VSDumECfW49GxgsYkYJa?=
 =?us-ascii?Q?DVd0P1dwYIqFz8+8c0LnSra0mLC3V/hVlXjIY/QC0PA+ZwbThwEfYpmwD6RZ?=
 =?us-ascii?Q?rzwpdibYElvROhzdW9FPKQfJiyPcOvqiIimO1tX+thk815ZN4Av5/oQ+70iK?=
 =?us-ascii?Q?4u/+QrGwtFgEXmN9o/sBUKtpnPXMSCJL8S1/5yEJJdPJPOy8v6Iu4fGFB9v7?=
 =?us-ascii?Q?FVgOfE0EOcJTRcauLX7yHo34/DFNZbiddHZ7g4+q7qNSiNKttPN/crMShpMX?=
 =?us-ascii?Q?ewF2wqOlG8jzxFRdB0F+v85DomT2U9QPjuz16S+Egp+PKtL5VuRvJRFKNpwN?=
 =?us-ascii?Q?UKaPJeu3JrgC/NMAcLLOBzx9Y4qGgpfTLnVwCvRkKa2p5cQueY0vlCu4dpER?=
 =?us-ascii?Q?dNj+BWU43focwRPgm52BtEKnyaoUGURlt8j3M0LkKGzRiL5/sRMao8d5BLIx?=
 =?us-ascii?Q?cIyF+Ab0fa9XFLvY65K769J8keEP+t/q7+AverCo2cWq5iUME31NMW+t4P3o?=
 =?us-ascii?Q?tBuM7dXHdshRbr8qmBZeNf0ty9/sAOR3dMagsiWhrf1TXfw/ejIk1rDB1Sid?=
 =?us-ascii?Q?FHE9wlJWm95+oZAzULZxWHaIDbQkOXf7xF1naCHPqFglSEou4GinsQGbURha?=
 =?us-ascii?Q?zIQmHhhQOUE3D2zW0miZFVvTz/7/vz+qb61SimCUeYV2YhIBPNmV7NUr64up?=
 =?us-ascii?Q?Iwd68Wb+JmlDnjVaFa43J+WVPDyaKaKj5juNpJNMdF+9/eSu9TfBCESK5b4n?=
 =?us-ascii?Q?UCmN/+GDKW7gyf4C4YA1eS/Mh4lKgscX+517PuHUFcbXnvShmKrNrTn5pIL+?=
 =?us-ascii?Q?8is4YmbOy3VNjHjPRPDsZY0Xc3B24sdTmkhcfXpYH1AQkh1nyo9z62qih7Ro?=
 =?us-ascii?Q?dous2uWfMaJhWgIcJxabfF/zywigyyvMFBj8QiycRPcvJqDMP76rIIzBnwV4?=
 =?us-ascii?Q?tx720xPQ1ozjIMhPGVtZIcm0PMg27OTmc/gzYtuifFmhH6nQXcNQL/RfY+u5?=
 =?us-ascii?Q?tLyba2K8qfeFQOZpl0hE3X49fbAsW6LXuhhF1kVkGohPWRehmkKJkCVdERrr?=
 =?us-ascii?Q?Tr6T/CnmjXYvOzKkQHIbXrXQzeUZYaNZgs6AQculCUypaqEoyQnX8BBU6kAN?=
 =?us-ascii?Q?GzjcXr2burvr/btIUTTdidsOu2yGH7gMDrT4jIFlxK1yjvCNQTei85ca0Th5?=
 =?us-ascii?Q?8xEr3yquH6XP3poUtnnzE99Cw3z+g3Hj7RiH/t7SXV1TX4xk57ToY/CoLr/E?=
 =?us-ascii?Q?bNSKBkMVN79wXIh1KgsqHe8IfaxVYSl/cJQOu3MnqKGetwlXsQ/GdqtuFcjb?=
 =?us-ascii?Q?EYYs5xWRIwnEd7jZuAADMWNg7i/5LBASRaWs5fGlqLoZ4P3Qd3Y3LMMIrB/2?=
 =?us-ascii?Q?RjY6X6tpvjw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4UPogLSthXi4ibSmtd2vUDRNSdKM9mMf+Dbrr491hBrxDCb+QREGcUEX7f5Y?=
 =?us-ascii?Q?46TfJVwu8+hHUfAn/ImbXpcwWzsehsHf7x6Lo0JjChZj+lfR+r+pDoOpmQ/V?=
 =?us-ascii?Q?pbmh/u49KW4vrYrZ7QqfHgCIJxRc1lLxGtZ2M1o8b8HcQNuT+0SgUJ+FP/+6?=
 =?us-ascii?Q?mlMffVXE5qKA4CzpbmjSc6CUFpv1/Zo9EJrP5+9aWGmWApX/aF1aOfR0EJp5?=
 =?us-ascii?Q?WAXdMXW0BJ6KXFy/X1UpMIpiBK1SjQ8c8fEhXYZqoB7bDJ/EQsqz6z1GABsv?=
 =?us-ascii?Q?okCYuKCkxytj596sLKt6IIjYLuk3QuC79nfjOSnVaNMh1Czx5nj0hw2Bb2gF?=
 =?us-ascii?Q?atwWlPcCi75oZVLKULblkQm/8JBsJEXu3Ph7DBS938s7BR9xPZs9V97rdiaK?=
 =?us-ascii?Q?PaZ2RNL5IlmOKg+QHYhfOmGqPXVwwT8ssQ/HVCkRnB8bUb5SEOZ1QwxYDjlq?=
 =?us-ascii?Q?+SsS4d7LD+mm8fbJp7CqMw8Z/ADMZyt83qBOCbZR0MlIgRXWNvMjvW8kHIdK?=
 =?us-ascii?Q?G8aosZhZmUK6x6lJrxsIDEttqhSZZ+EnZrLjXTYGXx5s05d2I+aicMCr55tS?=
 =?us-ascii?Q?qc6pV/E5KLh+t74QHqJZb5C1LUGZxccyLUzUL8N4pEBFsR1/WQLdGDJPrdoB?=
 =?us-ascii?Q?IDeaEZZEVPhD/czbxepCFUsUSh0liBnMTZowBnVTQijV+BFn9RGQCL1cpWdR?=
 =?us-ascii?Q?x7aoJAJkbDXbqB4t11gVooSCIONhxL4KmUqVyUHX29kSotsZf8Z7GDbNWdRt?=
 =?us-ascii?Q?HDGrrQq3vqNelTXmZY0IZaIR7MZIsxcBehu2C41L6kBmzSP7rzf3tg9pfBiO?=
 =?us-ascii?Q?vGiJA3y2Kk4yBEpSo35pvyMEozKAwweQrE4UpUVJ7vl2R6y/uRlsoX2SEvnH?=
 =?us-ascii?Q?4qOAVvDTRbdd2iaMkgucMvtyX1Y4hd1+rRBCuo3U2HI2Zjqg/ujXc0sU6XTf?=
 =?us-ascii?Q?XgBEp9n4wZxat8kc4k1ecSLfuhLaUqudZY1PxuLrLoYBoCtDPRuF+QMH1zTO?=
 =?us-ascii?Q?dW3N0JcCR8m8zWFiCgQlka5cfkKg2UXuGgT4NsF7BYYAF5yMHl6L8PQZmNDE?=
 =?us-ascii?Q?0pEvQdXGScbiYnwUsiB875Ikl9mPFIWr9DxM731z6vrVLSPX/QAGiExkKLV9?=
 =?us-ascii?Q?mKpprhCvmOrc4kympRgCjvby3Gs7uLfsWEr4YNjLk0DI0W5DYJqYoyzkI7BI?=
 =?us-ascii?Q?qhfgNqAyHFenCKhyDFGlYizGz6VRv9wkuvutbGavBCbQ19WR+43/UxPBYDtE?=
 =?us-ascii?Q?rTp4efmOmHKmhltHfDlFyt+XQkGMlvrgTWqfhsAGkaBp1q+ImEOaPxGuq3FD?=
 =?us-ascii?Q?rCQp07A7YMo+QI5ExelcnT5TJvjVDdybpkUrqCs7e+t2JZDSYyolxND0c2b6?=
 =?us-ascii?Q?dBzOEUiNN52AF4l+W22YTQu9Yupv7UJFucYR79nZlcOmbaMmWedwXtAqW7Ua?=
 =?us-ascii?Q?wZVRhZ56vhtMxkvIRl85+kRpnnll2vrq6IHjOLw38i4pT3GT22daH7qGZoxc?=
 =?us-ascii?Q?2LtvJZuFr04GdwNaZ/JNKAQyQq6gLWXiubRHd+ji/bXdYAs22ui5H/5Tg1YU?=
 =?us-ascii?Q?ZH5cCN5EZadPJY0cJtJBUjLwGpREh3SWh9C0tb6L9n0AjxFCeCg4PgHMLAVN?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3136dc3-390f-43f7-c075-08dd822d8146
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:10:11.2358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qQUGhGxaQlaBIGvylkH4cbly+RyjqOIZoROOZpRCg1kIPbBz+8k/AoklNVUVTfJoPUyM1uYO/k+xn7nyORfihWMrAkKvMJEOeVxsUznDdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6253
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Error message "cxl portN: Couldn't locate the CXL.cache and CXL.mem
> capability array header" is reported through testing when a platform is
> enabled with PCIe hotplug. The cxl_acpi module is responsible for
> enumerating the host bridges through ACPI objects. During the enumeration
> of the host bridge upstream ports (uports), the root port (RP) registers
> are mapped. The enumeration can happen as soon as the cxl_acpi module
> probe() function is called. However if the CXL link between the endpoint
> device and the RP is not established before the enumeration happens,
> the platform may not expose DVSEC ID 3 and/or DVSEC ID 7 blocks which
> triggers the error message.
> 
> Add an attempt to map the register block under the memdev probe() port
> enumeration. When the PCI probe of the device endpoint is called, the
> driver is now communicating with the CXL device and the CXL link is
> considered established. Doing the register block mapping at that point
> guarantees that the mandatory DVSEC blocks are present.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/acpi.c      | 17 +++++++++-
>  drivers/cxl/core/port.c | 72 +++++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/cxl.h       |  4 +++
>  drivers/cxl/port.c      | 19 ++---------
>  4 files changed, 93 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb14829bb9be..3c8f04bee9a3 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -662,9 +662,24 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	if (rc)
>  		return rc;
>  
> -	port = devm_cxl_add_port(host, bridge, component_reg_phys, dport);
> +	/*
> +	 * While there is a chance the uport gets mapped when the probe
> +	 * function gets called, it is not a guarantee due to acpi driver
> +	 * can be probed before the root port has established the CXL
> +	 * connection to the endpoint device. Bypass mapping during
> +	 * port creation by pass in CXL_RESOURCE_NONE for the
> +	 * component_reg_phys parameter. After, set the 'resource'
> +	 * parameter of port->map to allow a setup via the endpoint
> +	 * memdev probe.
> +	 */
> +	port = devm_cxl_add_port(host, bridge, CXL_RESOURCE_NONE, dport);
>  	if (IS_ERR(port))
>  		return PTR_ERR(port);
> +	port->reg_map = (struct cxl_register_map) {
> +		.host = host,
> +		.reg_type = CXL_REGLOC_RBI_EMPTY,
> +		.resource = component_reg_phys,
> +	};

This looks racy. How do you know the cxl_mem_probe() path is not messing
with the reg_map here?

I feel like the rules about when component_reg_phys is valid to pass to
devm_cxl_add_port() are getting complicated pass the point of
maintainability.

I would be happier if the rule is always "component registers are only
probed and cxl_ports are only created when a memdev is present".

What is currently missing for that is that devm_cxl_enumerate_ports()
does not know how to create the cxl_port instances beneath the cxl_root.
I think the time has come for that. So cxl_acpi only creates the
cxl_root and the host-bridges dports, and devm_cxl_enumerate_ports()
does the rest.

I do not see anything fundamentally difficult about doing one more level
of iteration in devm_cxl_enumerate_ports() to check that a host-bridge
is registered as a dport of the cxl_root and then register a cxl_port
(if not already created).
