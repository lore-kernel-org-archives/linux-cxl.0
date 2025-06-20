Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C385D30E859;
	Fri, 20 Jun 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455161; cv=fail; b=gbJMuDjW5aUyeE/Q29h3LqfuO8h9x68eJBPcshAxij7ZyIopxWzVE4R/9d80tH+KundF48jlEcO9r84cejFf3GyTP4PMFg8gvef0E0tzm2TRaQBBTjptC/eyh4jQ4qPDeg1v3Vz860M9B/nKkrRU5jG/Tcgbw+/ypSIE7dPWry4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455161; c=relaxed/simple;
	bh=PMQu4hFTYMC6gDubJ9cxIDif5u7QvH+DGJ3x+IKZX20=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZnn8d/UeJyzMlkN7yaUtoks/M5NCZjEGJYbhc81efsJCgzem4yaJtkwklEYe60wRpgMlRjwX3Wi2AIVEV1G4y73TF1VzV2Apm4EX89W2RqZbontyQ079q/xqKLEUc84xGGFi/kGQJzNY8/jKnx7Jh75sILZ4WSStWq4BxAB6EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlRZkSmN; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlRZkSmN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750455160; x=1781991160;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PMQu4hFTYMC6gDubJ9cxIDif5u7QvH+DGJ3x+IKZX20=;
  b=ZlRZkSmNqSSqaS6hHlNllBOE3PdgqlM2WH5Qu+Tks7ZdJlnxo3duhY/v
   Ndfh/K5d3WoLnep3VTQmxgaqMYT1IbL+H+Kj9pGDV9q74gKQ7NW5otQjb
   hnUxpz5m7O4MXB1O2nhrGtHRDgjwtkYrmGZ6Dib6/bp+7e5TYMVN9kDPV
   I/8HmO4Z9Yl7Y74aIF4MhP2dLzMehBksnJdfHZ5sxgcbZjE9kNWXb/b6C
   zmFTVitd949PPpn5Yq8y27f5SrkbyAJ1+fvKhbOCDNh9IrTk04q33tQ4g
   fuqDjs9Rxm4EhVCxjibGq6A0zY/Xw72STAg7b3gvdCAmYNzmrBqwDPdCY
   w==;
X-CSE-ConnectionGUID: JuSqLVm5SfWiScEYYs5pAw==
X-CSE-MsgGUID: 5LBn2peORH+SoDpwtbhVKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52598587"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="52598587"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 14:32:36 -0700
X-CSE-ConnectionGUID: 9kR+g4GpRuONBNrtmDnkvg==
X-CSE-MsgGUID: YcsnH6MsRzGfwzWLG58EVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="155571635"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 14:32:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 14:32:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 14:32:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 14:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9x+mo3jiGUF8bNAA78hAZDXB/gzRnv+rI1ZnRTkbgxYF0yHyZmBWdnSIf2Si2w8DYZaJ0kPC4D6Wxmo54NBDdye57rYCYtGKOomJF9HfbljsidfLlyNu7oPZctTWIVhEAnWIJvGSFFej4c7/Un3t+OxKWJ8ZgQDEbpiftkkwfzHZ49Jg5BGUV80vQfX3gbZRW8wUAQWxzbwbkGqaz1ypOtM1eLmidT1fFOsIpfCpV2sWoBTziW570QjxXHf+iQXz8FY3r3tL/nigVHs6PY2NsoAu+8V9hGpgVRKoEj4V03sea6E/379H/Od82mifE24ftHhjA9+mUomFsHUhC3nGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8Y+EerqeP4JPByfa11pcyAu3k4T5Igg1iodZCUEgD4=;
 b=T1CjlzV++Ws5y18VfLQMDQZ23rkOHE2i0oHEDIFpjBzYVAAK+UYolw+6+50/0ERV4CsoaASRNbX8hHbwfT06f9jFfA8Ab6ZGLcXtzCuO7pRTHcIWxQeA2cAB9JLBW7CTNv4tVJTvidme1a4wC4ba8GuOKDJ7PC/ifLSLm5q0MbepJx4iXUgc9AU/R0XqYyPXyJYvY6o3V1RN1DbYG0clTlOCtWm4bVnMoPZ+yIRpWrTSN6sPSSPu+YngDtLPtCawxzRL6ALoUAl5XtyMvmMzHq4RjYn1gKMEYewbZxBplpoRk59eyvtcUwrGXLD6w7FdPTP926l/qUpllKK+SaRROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by BN9PR11MB5274.namprd11.prod.outlook.com (2603:10b6:408:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Fri, 20 Jun
 2025 21:32:32 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%6]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 21:32:32 +0000
Date: Fri, 20 Jun 2025 14:32:21 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 5/8] cxl/region: Split commit_store() into __commit()
 and queue_reset() helpers
Message-ID: <aFXTZVnyPoxGRIcj@aschofie-mobl2.lan>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-6-dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619050416.782871-6-dan.j.williams@intel.com>
X-ClientProxiedBy: BY3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:254::11) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|BN9PR11MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: e856a300-a114-484b-8528-08ddb041f72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MrjmYMt3SFVn/TLP3/ySXnNp1+IcI7OQctPcZTpxcNCsgaN0RuVzwzTVFoIT?=
 =?us-ascii?Q?0j6A5uD9PvwufSzt+ZZh9TRZCGSPRHTvha+nkJ90SEDH9w5BmTz7GCkzGPmt?=
 =?us-ascii?Q?T5IoyjSDn3IjtYA35FTnaByrBPM0ax/2skLbF19fbpxd+e2yWXtDTKsTiSTK?=
 =?us-ascii?Q?lieHZNCT7Nbu8n3VOMeswmX3dhOMIsaD92g0fpWl3T7qilDCFJrShuyMaRKg?=
 =?us-ascii?Q?aWlAYL++ZcVPE/G9xQYIRQvz8o3XuS6Wii2tREJZw2gxQqwce6K0UUAlzcPs?=
 =?us-ascii?Q?MAmgiiMsyZzwK2Mr3/o7jZDU52+1dwe8kQ/fQBbrtFx819cPto28gxwdokvQ?=
 =?us-ascii?Q?2vsGxGZzlTvaw5LqKQC2DjV3a7zdH7lbgjWz1+dvJZu6JoX/KgLb/Z2AF2Sl?=
 =?us-ascii?Q?CGwRD3L8RvGc0C0Y+avFAUjzQFiUN0Lo4Do7TzlbI+7lXNFWqgSu46Htuzmv?=
 =?us-ascii?Q?jJSDVafkhfP0Fwtozr7pNlkeEhoMB0Tlvd3UsEjnZIAeIj5uenjV2wuV5LL+?=
 =?us-ascii?Q?24/O/5IDQbVhfmERTcuXePZnkckkQFaEA3V2ZB+4hbA5AH5oU0zgJv+4CZrJ?=
 =?us-ascii?Q?JNw1pnjDWNZXeAlXmmXXGEfYZZP9J2HaA6pefpTGn3yKFQgiNlstijK71g/W?=
 =?us-ascii?Q?nvmiYyoY6qq2sP+pKRv1Elget2ehfYBp/dZrbmmhBjhWPFA1iXTL9yUzv0qb?=
 =?us-ascii?Q?j8ZL37bLKxhm6T870Rjf5DlRJPJ0syRDFD4vP3ObrdrH/5SmxY1F6DF4h6Dd?=
 =?us-ascii?Q?4DNkZ7XeD7RnsfnspSr/WmZ+elSy1Jy2UocoirhpiuGJecUWrmqvOuQB6Cxf?=
 =?us-ascii?Q?1F6ilSE/GBujfmwmoUoQIqKt2gpKRbTtNowlfA1xMQFz8cpasJmXV4BdpzzE?=
 =?us-ascii?Q?uazCVVCZtXkknLgvQ+6cBZtIGVcX0EsedoBdkNTY3XMOMWz4YzHs+4N9nU+Y?=
 =?us-ascii?Q?vzdTqNhgS8khFim+D3Bec009hawtZPO0FAXXGg27KJcsqKeXRFAb9V9F98Xj?=
 =?us-ascii?Q?8t02oLsXF7Knduzwyu1dhFYw3MajaHT4b4ccd4uAcAb3APFfR1jwdIzj6Ip7?=
 =?us-ascii?Q?uOVnH3LaAXhjeHOP/wAcC1zFaBnAKZ2kNCDFi09XYJf/dU15oCQOJVFRQYB+?=
 =?us-ascii?Q?4oLNAk2XC/Sv/PmnheBb7EH1I3Ts+q1iW62QlB/TTwl9xyGDrz/zRjjtlmKp?=
 =?us-ascii?Q?gqEsf4e6hWP5XbVq4n+L/fcsB9PV0E8ggitOJqcfyKM6lBvsTMK85deXcZbj?=
 =?us-ascii?Q?KTq6LERo7B0xVQtHk7p3MfDSY/uXKHShFvT8qVJDVG0MgysaudpECyfHpW7D?=
 =?us-ascii?Q?Wxzt1qSfUcNyMRFBGFVO9yPtMMn2JkgEkrqVYRselc/0YLxqnlOSckqfvGMz?=
 =?us-ascii?Q?7Il8UVrBeIH5TriOzdvffpsPHTW2CNb2knTR/ML1qJqYHDd16tzlBak4y4d7?=
 =?us-ascii?Q?YVsvT4SKzoI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uNJHvVbBwdkPqsTJhLWpMrq/83GX0P7UhKL3xQeqixD5khSXBrhuwvnEc7+k?=
 =?us-ascii?Q?CVBjKNKGLtQvUarFd3jNEoUIxlwOvMidpCUjhTqCGEdKZQ3zbQYgnW9q7wY2?=
 =?us-ascii?Q?22e/NfegmK7St3Oqj70HaqO5iTHhbfc4lBvgDTHBeSlWhmGg2xeD32ukVpj5?=
 =?us-ascii?Q?taXpRp9e8dUCebkYezKKhR9VKPLOG86Gu9/fz2hU8irQiWEZSFZS3md+nNws?=
 =?us-ascii?Q?3yaAgSmtAw8yEx+rd+P/8c65XHBqqdIXM+hDTQEvuAQ9g7uiSOy2uUFYvrVW?=
 =?us-ascii?Q?CMSfhGMuWLx4wOh5vWPI/KYKvS8ZmB9lYWxv8v75QHkGZtwUDN6XOuk4Phxu?=
 =?us-ascii?Q?81xcUUV4LgUptl+zS213AkNyGDFiHp4Y3FpQa+xL84PmX+4BToDFSsRhLjFy?=
 =?us-ascii?Q?NtuwtzTe9987AlYcMHOS/arpd+f0qRXl6WVFfnHImc1V0yEkS58Q7Oi8K+9J?=
 =?us-ascii?Q?vAc6/JPDU3FHrWspffyenr7YVZPiju1W0KuMOWaiSg+Ox166r2w6TbkFtkLj?=
 =?us-ascii?Q?5rtf+vwjHlgL7qrWe827cFsvTSDxS2FKtCaZRYH45VbkYtIceyX6lkCkQe81?=
 =?us-ascii?Q?wuxG6CpNxmq+dsp1GePmV3+XRfSy2qm+CBiUIFyAJRgP4OK5EXXvgRPWzOsl?=
 =?us-ascii?Q?yjjIc6tIBrHYQf1tv7bFPoRitPZzoU9tvCiKMbEVF6v3dit++AHLKYgW/az5?=
 =?us-ascii?Q?D9aXSTvm5KUgzCJvK15xEYwHzZkxRPT58TYrU2vBKdhCDKqblNl2ZTzJ8Ytc?=
 =?us-ascii?Q?PDuZZL0hnnCzz3g4466VLwo2is1YoFpEbqMzLEx0c/faw+Qhbgal6XExL0NI?=
 =?us-ascii?Q?gMuwl+0fJleD1/Uts7h+IPYNvgCorWo2z7So/h3QhJeCNduOxa1txTT4QFZU?=
 =?us-ascii?Q?Du+2Phn03H4p0SjDeqOEThCC8tWvn3lpYOIzSLtXRDDFIGCts8Bp/txxaNP9?=
 =?us-ascii?Q?r7WAKdextaZgij4Et9DTsDGAVKZrbNCZj6+uf2OWuM0yx8nakQiFwXRSGbm6?=
 =?us-ascii?Q?E1YejLiripusJVWgpYZcDy68TRRiSoBzYpUTZK1WJOfp7ppSeaZsCxrw/mRb?=
 =?us-ascii?Q?t2SrudsDDGMdyEaDgdkBmA9eIK2pPi5DukwcLYFuBt6Ki/SAcg7KfsbAwutf?=
 =?us-ascii?Q?5sjt/e/XICXRwrhLWMTSQOT29yGMjVQiYCp6r5LfqRp3r7WCQuZbBMLBMqZA?=
 =?us-ascii?Q?Wv6hBM6PphSyvZdj2bYMeuBd/cVyDFDD/ShtMKB7N7gRYuZtQmzHP9VkSs8s?=
 =?us-ascii?Q?jH6M6MahYh80dfa8L3Rwwxwloe6WrWmCsvGswqRJw6L9G7BTDPQ0+wsKq2CZ?=
 =?us-ascii?Q?TfNhUtYSfhLVkTEgGYe5nGXlQ+Lz9ny1nm6b0NbUp87/Skv+7mPc4UykMVLD?=
 =?us-ascii?Q?7AiENfPcivTFdeiIyxc8CRXE6YbScB5sRhSU/07J9FHZVMIaAoqZnI7RG9kZ?=
 =?us-ascii?Q?SBE1KNS4bXbvQkBqNyurJZFnJxifm8xHb6GWQZjcmoePY81M0H0GjQVbG4S8?=
 =?us-ascii?Q?lZudT09gizFf0Zy4oQgElB1mItqPJ1M86lxnbzAcypQcOpfpifnjy6yLjLLR?=
 =?us-ascii?Q?xneOkP64pS558yk6g2/UKj9zFEwBGItzUT+dVKLdKsqkzEFA/RkzTR/eyJLJ?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e856a300-a114-484b-8528-08ddb041f72b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 21:32:32.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRT0oWbC7Ud9QG0ks7gPY8grF5jxQk6Bkm4e/GMDz1PWcp2ElvBcenTkG+fNTliVhuFjjk3rp66UWfC+NU5gAFY9KJo1UV/3D5ln0rmhdcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5274
X-OriginatorOrg: intel.com

On Wed, Jun 18, 2025 at 10:04:13PM -0700, Dan Williams wrote:
> The complexity of dropping the lock is removed in favor of splitting commit
> operations to a helper, and leaving all the complexities of "decommit" for
> commit_store() to coordinate the different locking contexts.
> 
> The CPU cache-invalidation in the decommit path is solely handled now by
> cxl_region_decode_reset(). Previously the CPU caches were being needlessly
> flushed twice in the decommit path where the first flush had no guarantee
> that the memory would not be immediately re-dirtied.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c | 99 +++++++++++++++++++++++++++------------
>  1 file changed, 70 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..3a77aec2c447 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -349,30 +349,42 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
> -			    const char *buf, size_t len)
> +static int queue_reset(struct cxl_region *cxlr)

How about defining both new helpers to return ssize_t type for consistency
with sysfs functions. The local 'int rc' can remain as long as the function
return type is ssize_t.

There no possible breakage here based on the actual limited return values.
Just a suggestion to follow sysfs convention.

>  {
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	bool commit;
> -	ssize_t rc;
> +	int rc;
>  
> -	rc = kstrtobool(buf, &commit);
> +	rc = down_write_killable(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
>  
> +	/* Already in the requested state? */
> +	if (p->state < CXL_CONFIG_COMMIT)
> +		goto out;
> +
> +	p->state = CXL_CONFIG_RESET_PENDING;
> +
> +out:
> +	up_write(&cxl_region_rwsem);
> +
> +	return rc;
> +}

snip

