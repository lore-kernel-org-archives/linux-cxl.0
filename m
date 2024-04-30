Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CEF17BB15
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518256; cv=fail; b=qOROtXxOmLcU11mvJ3MvnqSU3UJw3ZyUKoXql7uorBELJcr80ci58yDrhN0ZrrZTMcrOIwf1hK1rbfjtdFvkVHAELyzkK/dDMN35GFmugZTJy13DcT/NqJ1DrTprZkMFwNT+Gs3H1J9+0dUqHT2IgOVmOuNp8ZdJd17ltroSUJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518256; c=relaxed/simple;
	bh=fMwxOhCDjco62u6H/QWLj0JrmkRuzOkZqchDSGnwGxc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=beRqL7quEfOqq666Xa4np2aTH+JgvHtfbfzZ/xmiec5nJ62k9yMepCW/8w8rs9kVc/Ttv/X789BTkc1WBmXfLu7D81/tNpMkW3zee/Hh2wn+fKRzvBjwS4dAbe5MiT0OCbMKIrYTdvZAkkB52/FKRjhHNYLN8T6AXmZavqpJgyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gn85neqn; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gn85neqn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714518254; x=1746054254;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fMwxOhCDjco62u6H/QWLj0JrmkRuzOkZqchDSGnwGxc=;
  b=Gn85neqniPRjLOh4AuRFVnDXmpM4dKd0kT+fiY22TtryxyTXw6dfw3cZ
   +cntHAr4yfJrgJmnjtJhpY3NRt6+pJ6+BCWZ2xQalyGcBUqfw3D4ftxdp
   3nUDdmTG/nE6cBoOd6ia9/LEwVrngpog25+zz6OGlt5MLswQLDFChLkw1
   w+xqcZ+K6JzDqCSQZBQ5aDMBNwQ+1kUv7K+BgCUKS1St15E+QTe6ovghj
   cSLp932cQ+TKzYsn/6HU3Iz8fHawfbzRtRXGZFmzovIj003mDOYZ3+dqP
   45SydkJSFncPOl9xfn1RtB7xvBEWrooHz1a4BMV2+ma2/9OtWYcpGWZNp
   Q==;
X-CSE-ConnectionGUID: n8m6Hnb3QNupLYoxFUkPwg==
X-CSE-MsgGUID: 3ycOtHG7QTObZycNOzmHsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21400863"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="21400863"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 16:04:14 -0700
X-CSE-ConnectionGUID: EH9pVuxOQbCGgUaJS5ufEQ==
X-CSE-MsgGUID: UdFFwJarRZSWi8FzkIlX+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="27115755"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 16:04:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 16:04:13 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 16:04:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 16:04:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 16:04:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W23AcOekosZFniNa2ic8K/GvPjsMdxdvbO67HuEa7fPSoke7YYce7kDQBV/tBz39T2lCxy4Bs3JsMgZ/0Hqbz/fh0kduveZ68YM7pJa6zGNEdEthffMOpwDK7Gn9hMSxO/acBmDEWSpd9IUrBmCjMhnWTj8NTid6aB138dxgAV0Rs3oaDF/iMIKCgxsubcEpzLXtdEEjqdPXVJNrlAEYVPaX10guEYjDLiyaEqrIYGu59q6HL1MxNQagkAKSRJAaTQY7IwUJaNu9g/0rCGst4zy44Ka+x1LwbCOEgsQrBPpY7AZEMpIxkBMR+x5Xi+MBjOhQDY0jYKuiM41sDemyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoYzTFk4uIi8XwbzlWrDh5qij+7/T8KGtMg9o+xMUec=;
 b=NQNSp/+aEMYB5ibEaQMxnaSEWlLw3F46Df2QfwAsynqf1P9kdHnr0doEkOo7NFOfmdi7OWfyqZulxaTvwSyecUa41yzKVCju4ALRIy9foCkSSPyWJqYiodipGGuHjf+3WtOoz3jpmGZDVi148IYSi9+bArFU2uNxlbQq2r9HBoVnxaqsj6cxzjNJAFAEppHdwuG60DzqDfDJ6VmMX8YcxTTjgQ03CfzO4Z/W8jfjOsuJ5Ua93OfdEmZja5d7zp378+EkGGfWIxdY400bbQDRNfAxum9AHtXT4W6c3cHsHEYuHEzd5yvrUqQ6LRkA1/HVA2zZLwKm8xrBO7H3qtJ7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4658.namprd11.prod.outlook.com (2603:10b6:5:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 23:04:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 23:04:11 +0000
Date: Tue, 30 Apr 2024 16:04:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl: Remove defunct code calculating host bridge
 target positions
Message-ID: <663178e8debcb_10c212946e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1714159486.git.alison.schofield@intel.com>
 <30d1bb5362c68a4d045dbd0f4a3c9593e21058f5.1714159486.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <30d1bb5362c68a4d045dbd0f4a3c9593e21058f5.1714159486.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:303:85::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: f7385877-7b6a-4055-022d-08dc6969d90f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nr3J3SuAvgP1yk6NpIhUnTGuT/a+ytU6jME3xoB9mHCzf7wDeoaceh6iB6Ny?=
 =?us-ascii?Q?qJcYyXZo+9lRa4qcZIKqYBzmlKFbJ05ocrEyZxuMs3DrfqubMw209F9mrlSQ?=
 =?us-ascii?Q?ONu3gXSnSOib5H12y/VttnDceX0oSdaDESycOroN6UXThDIt76d5l218hMoB?=
 =?us-ascii?Q?p7uNQLjApbWM7toGI+jqVwBjOBgMfUk2Z4ZRX+cOsW02FLXRc+gbXJaLDVnu?=
 =?us-ascii?Q?gw/m88Ij1NHnqp/SgBxRa7wWeGwV+4LfecfKyLOkOJ5YczZP/YrvkFkpUpXO?=
 =?us-ascii?Q?7VHVjXlztpl/+o35tD3UObUn66tYZtjWoIarsdU8do/9FyzOrQFnpcrThsgA?=
 =?us-ascii?Q?buH8yMljhTKm1Wcp3gXO6IlRY3xwQqBvuHeLYH4WcqRq+Bq8epN+MognBH5N?=
 =?us-ascii?Q?Bew0NHtGM9ImvPZCUJ9R6Kf1ZLl9rm2uye7MtLD9zm/7PB/97Kns0MUtA7PJ?=
 =?us-ascii?Q?I2jBXEGsGs2xjra/nZtBdma7ViY2+xZDRVPcfGS3adJPTWnPNkALX+Itkmtz?=
 =?us-ascii?Q?NjaJyfhXbZZXmaBJxIJwsEQAwrgvE253sNJCLNIpwB9/FrEjjL5Q9j2sLqq2?=
 =?us-ascii?Q?H4TTYhJJ+kh96pzzLsMa/2T/9hUIgP6XKTzCqefyll5doU6W6YnYFd8/nVAy?=
 =?us-ascii?Q?KQrQH5FOLjUJ0QEvfdnYKsAcuDnI9dDhpTDn7nVvm0GCjgbJ4nQlzL+iz3hA?=
 =?us-ascii?Q?MYRW1ms5OVzptlJPeomfX6teqWHxE2Bz1zPk6BihU8kxY3Bh8KXkvZCk5MBW?=
 =?us-ascii?Q?osJcYagxhUT9hSYQUYjiS7QYI5ExHmR+0BKADw/pV/EqpUcgrse/hECwq0e6?=
 =?us-ascii?Q?n01PzDRUk/0zFkloKxx8hsklGkHQqePcJOWsY94VkYB2OUBWe9bfJRfiv87B?=
 =?us-ascii?Q?tyik+tvXkHgQBsoAS/OFasdgEQmjFopWedfyavH5bPM8szGei8U/qUBFqgWc?=
 =?us-ascii?Q?XlVmslobM+oblBNzVX9x8p2Y8wZq7/0PRjbagjn2Q030aqkY76gOI7NoqnI3?=
 =?us-ascii?Q?v/Cu78EF1ko1VhkWM0wgo3v0ScDxnkqn75mhrEoTwTdDHFUPtGjX5kbn9PsB?=
 =?us-ascii?Q?e0v8ubgGfjq2Y8UzumRMCqAqeKoleDQeZfrGinBhXFepYpqlzLNyezUDKzRi?=
 =?us-ascii?Q?2vqouo6m4TRi+2ZAkR1QuTczIrUmI0aKLHZ2v/82DhZSKp7h6eLdYpVBTDsQ?=
 =?us-ascii?Q?yOl8OSGNbcieYv1oxh0asKqtHMvmthLwISPdrVS2LvezwL1un3OASmUgYl3b?=
 =?us-ascii?Q?RSTun0k0nsRM7CIYWT53eTcUxkez8TeK6D8hBYifsg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZwRWzlbTMVaZGWY1LgQ5mXDNJoiWQl/Fn80QSVxzeJw1yhyDil4B2kduEbvp?=
 =?us-ascii?Q?G5i6nMcFq5gAg0Gnd7aD2Gd52tEqm826YyOgT/gJF1/Otfs1Mj/biKgotl9e?=
 =?us-ascii?Q?bBoLth4WM72PpweEr7vtybsZY+SW4mADh7U6BYENj8291dsbIlrkMox4j+8u?=
 =?us-ascii?Q?NlZ06UrnZGOrkHRWL2OXgz5fjR3iKaFyS8YHW/o2+4Ytj9aPTgiXSMEh5yEY?=
 =?us-ascii?Q?/ON7HCT/XF8IPWJZdXBWQDsll/pURVjye0g6cp/aIGP9sC2GtHUCEHH4oS48?=
 =?us-ascii?Q?2l30t+GYmBAUJn1JBOPBaLwQoCpUuJenAVP9KgEtDF/l/oP8QgntidfRl44H?=
 =?us-ascii?Q?nqpFlSJr7M/zq5nkg7sFuPGIrKCS89jlH/S5y1fITFKUZBpibLzZgnL6Bigi?=
 =?us-ascii?Q?Y1ZVc9x/XOgbJrp0pmxl/IJ3wdaRvuvf/PyZY4pgOFWqc+NWjN12mmZruP5X?=
 =?us-ascii?Q?wBvt9kPZK6lDiiZd7jvvWYoDGHTqqomv7531abYrNKDrrkf++2XzDpKYIh1c?=
 =?us-ascii?Q?k0dSKiP2m5Z/LX+CWwt1fWXm8qgNcN0lFjfCzlnL5BF910h7GQs2hRKL9biu?=
 =?us-ascii?Q?HEMVdnaAjOCmxkeh+f+OFx2sd82w3jqJnTWvn2VTsUOWux7DNtlrydxLfjPi?=
 =?us-ascii?Q?jS4QOwZ9156offQoA6VH98/80k+0HpAZHR96qnGox8tMXyQeNmSB0tmcfl+0?=
 =?us-ascii?Q?pFXCl9QyPIEBZbEFArQg1cDBXBcNgiSmkPYqTwvw8GmxnW2wPyyQNd/X+A1r?=
 =?us-ascii?Q?qkxUDCB9sFRaCcq+i0QmTnG0h6rSfT2vqOODkA9JR8zcXrPOutcSxDBTxljV?=
 =?us-ascii?Q?4APKtdvB5j/yV92W28y4csW6lPl+QHoFLnBcKZRyODmjfKiX+jQLx6vxHvig?=
 =?us-ascii?Q?/RmFyv8tUApRHw0tnJeny/O4BhSSpz+m8pRcelmvt6my4Okc0otrhyy1hM4l?=
 =?us-ascii?Q?1v3dnyzaweiDkmISbgbWYAxZOOWamVgQfCxlhtP1Iz5/s1edthc5gTHH7ugg?=
 =?us-ascii?Q?9VqWQczrInu/ZlEP4OhJ2jqgYTZjD+VkVNApr2B7EA6Q2URaTb+MKX16ZNLm?=
 =?us-ascii?Q?VHEny2rymqPO2IO5zv0xWKtbpULi8PdPllj2qhqr2lQwzj+UIN4KwIodr3dM?=
 =?us-ascii?Q?BrjbpKcpLOU0MkgrOI3o6A18MJD/zZUh+oeEfPl22hsDyqYywK3FbCJKojXi?=
 =?us-ascii?Q?AvfXmFVUJpRcnX2Bqma5k2NMDKu3cRyMAJ5By0fs4A6cenJZ7C8ZHVaqh5QJ?=
 =?us-ascii?Q?TbSq4SyoIuZ9AFV/3Wdw9pphM0r+vKlAhPDOvbXV1t7uGWCYkNIa/Nk1lExC?=
 =?us-ascii?Q?sRUNyYJR/mell6J8W0sghGQaO6UyZnce1F0e5AN4NG4eNTPLB3benHSEiyC7?=
 =?us-ascii?Q?zZ1rhP5InhbbU7XLGKiPQidjlCXwsby81arNViak77nYyws09HXblQ7IZQau?=
 =?us-ascii?Q?1+KhXXqFKwaOKTG4sdnO3E/OZvVGjIdHyA5dxEQy7q//x6V3ppeDk4Mr9ZMI?=
 =?us-ascii?Q?W+YW4Ro96uuww5CzTRZ5I/yh/8I9IV/B/kaOY6tJazQYBmQy+hSMw1F5rwJV?=
 =?us-ascii?Q?dtn7BTrSQSSNoA7QfQ0nx64ob+SVhLSaobWs3g2aS8O/uq4itieDXZ/C8D2x?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7385877-7b6a-4055-022d-08dc6969d90f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 23:04:11.5066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+Fgz6A1/E/IVTHgxWMNkXYkzlagl5zHflYGzIbI0Isv6pqxfFYa3f/swsrcgMVrIUGgHUvVu2yafBA3L9MfQHFGtjVF+HdhwusxM8MgGkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4658
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The CXL Spec 3.1 Table 9-22 requires that the BIOS populate the CFMWS
> target list in interleave target order. This means that the calculations
> the CXL driver added to determine positions when XOR math is in use,
> along with the entire XOR vs Modulo call back setup is not needed.
> 
> A prior patch added a common method to verify positions.
> 
> Remove the now unused code related to the cxl_calc_hb_fn.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Looks good to me, needs to be reflowed for the the
s/addr_trans/tranlate/ comment on patch1, but otherwise:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
