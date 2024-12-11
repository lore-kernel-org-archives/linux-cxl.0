Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C361DC99F;
	Wed, 11 Dec 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906347; cv=fail; b=VNxKObIj6Id+7SgwbN3iX0Rrp+/LCHriQTEeDuaaJ182Px66CvwryRgR3EqgpPiCTUYcWnl1YCB/7QAA9UO02+VViUqAg8l+2hRuXZBJOlQ0N2HkJ4vM9L1zQjOjzdio5lErKSZSmRVMV54AsBOseSWxXcgFf2JM8SEDBeD+hqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906347; c=relaxed/simple;
	bh=STtoxUE3McE/J615VQ6UmBISJct7lIZFikGBYKUjhRw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tW3E1gAWKx+ojGIkjQmEQFgECFf/B48KPEbaFbVD26jXrS3anPK+179OI95ZDZd2fBzvtv3gT9nTVflz8xcTJngOqBkzdgjoWIzVDa3AJaLzgG5ZpXmjz73F/KxsZRT/Hh7NR+zChYpP/O2vpniUnTJ+8D1lt2ZfDvKTtpMx9WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlNOy/c1; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlNOy/c1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733906345; x=1765442345;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=STtoxUE3McE/J615VQ6UmBISJct7lIZFikGBYKUjhRw=;
  b=AlNOy/c1j+8FhsGF8eOSfRreuxqCVAS1Ti+DbP5cR/gsul0CcJuPm5Hu
   sjpRo1L4S9JXvG03HLEhMxV6B3JJh+BXShUmPp12BFwuC9pMDYKWoonTM
   01/TGA6vsLxI8DX+ckftDfE//ggr4NUcIh2qnmZK++xiYILDilcnPz/W3
   lYhbSYdPty/Egbgc1xuG5sje1W9N6WZSZHThekj5cC93AAT2n8FLS7GEI
   dwzxpHDtq6gdMDXUS/cBC9CYIcUgwvRyGRjdZMMpJVr0Me9lB69OKv2AR
   v6NjSk6Pi55gEUqXyKbMhBfzXdAKlNoNj2jDdiMpWcJuvZPfzJ/mIwrQ4
   Q==;
X-CSE-ConnectionGUID: eyf72oVeSU+7xbT3L0jh7A==
X-CSE-MsgGUID: WUz5NgtkTVmWjjDhoCB9sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="51807530"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="51807530"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:39:03 -0800
X-CSE-ConnectionGUID: 1/4OhsHlRSKIZSrBcrmZfQ==
X-CSE-MsgGUID: FWnW/XtSQdqPIcPcCcTqow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95910776"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 00:39:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 00:39:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 00:39:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 00:39:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbUB3l/eVyk/WDyUCMnz5I8OeHV2DBO0msHeoV9lKVu3aBr1IQCAiCkmJhOZHrsyH6fQuLMgL/91LDZ6sv26ZHuGbeSXmgj0QhOnJ0Z/vQ0GFa2zpNJC+gksu/8YjWruTLs+L2K8WIu2+TLWkuOIiEAn2MufdgmYgZx0ldBf54aGLKvgFO7jHCDSFDt37NtjSJTvI856j7BtLnqyxTQnwOuGWrhMCVdCSCupjHeeFae28+RjlMFVRHyQNOdj49/RBgGdC5FbNnu0D9S1DAYnov6vWXNM9pLXHriGUxTxHFojrqBnYRSU7I4JupMrTxEZm1emBKP07OqNPHVGSHDvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkehXTccwO0Guy7/aher82K+VdZeNnQNhnwRg2pu5rE=;
 b=ms/ARzQwV0dJO8vxhOCGRbAY/5jOJmV6dH330U5fQqGqwahDS8dIZ198I9zp/qY30KhJ89VqNFj8IlfmqsdrFxd4KUGBGcX7o5lq5FA/DOYmw//A0huSnOjJ8aNYO6QdOnf0UbZn4Mx4V8MK6yhiYv3Y/ppjKj0OYsM5Qn2/KC1FI4AShqpWkCn2ti8jPU/417aiKaXPqV/dRhhURj5GsKLZ1X5eh1qpT1WLcDHRElWYjAPHZHI/an1zx8jbVfajY3ecCQBNQPoUs7i9zNTsXYeIP2Gvqd3TxqTvrRGkJFAQmAXsz9F32hWu5Zk38R1UAlh6DLIcelepQi9Ye+Q8jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by CH3PR11MB8496.namprd11.prod.outlook.com (2603:10b6:610:1ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:38:44 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 08:38:44 +0000
Date: Wed, 11 Dec 2024 00:38:40 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bharata B Rao <bharata@amd.com>, Dan Williams <dan.j.williams@intel.com>,
	Raghavendra K T <raghavendra.kt@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Huang Ying <ying.huang@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Alistair Popple <apopple@nvidia.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Fontenot Nathan <Nathan.Fontenot@amd.com>,
	Wei Huang <wei.huang2@amd.com>, <regressions@lists.linux.dev>
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
Message-ID: <67594f90a7b87_25073294f0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <674fd2b4942f1_3e0f629420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <33b4b93b-5ab6-4a3b-b3b2-c9b3cbc9d929@amd.com>
 <6752acd92baf0_10a08329424@dwillia2-xfh.jf.intel.com.notmuch>
 <2b5bb8d8-6a7d-4a58-bde7-ce42d0a23f61@amd.com>
 <675918b414c17_10a0832943b@dwillia2-xfh.jf.intel.com.notmuch>
 <de22dd6e-00a3-4183-a123-15cc7c53980f@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <de22dd6e-00a3-4183-a123-15cc7c53980f@amd.com>
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|CH3PR11MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ed0b1f-11a5-4a99-e3b6-08dd19bf38da
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jOxVtG45uybSOD+yVENS5myQBH6qqMU8tgdObcNCBBVDzu7XNMKOFGI/I+DZ?=
 =?us-ascii?Q?XtshZL+vx5IxStcnB+yZJfzWu7vcviGUUJnF3jNVtW1TpeKdJNcZn4ijrI1g?=
 =?us-ascii?Q?+Pm7JfUdrIyG6v09jCgQYWGC/u6LTe8zpC5/h/P3WdJv3vcvWh1K3VrRYSW7?=
 =?us-ascii?Q?w4YC3ZVzcVtdO2T2HCAXAehdcij13uPaIj/i0DQTWjxCn8prj8LV6vQqS46z?=
 =?us-ascii?Q?u3Q9WfMkjN4DBb/8T9XMvIIH7R95+d2vBgBIBNO+8ARpqE9Yqu1MszpVE2tB?=
 =?us-ascii?Q?33pSsRpKwV/mRFDZCg7VT6LhBh5JU5OnPZ80/QNdM044CUf/idzRqMRZ/DwQ?=
 =?us-ascii?Q?hZ5g8Pe4r3C5OJI7lmrQb9KZA8fZbGdDr+0IPKW/PktTNqHejrN14AMsyoZv?=
 =?us-ascii?Q?Z5IxOLFeWzTs7fDFN7vEslxD/enkwcaUQKi+n2rSwAKAvJueS3gCN6HNVSlq?=
 =?us-ascii?Q?5SwrBpH9GJ6bu/YXBB3JusZI+sXNqa6+9k1UhNL2oxkS8vlVsam20uWzCbEf?=
 =?us-ascii?Q?xsdzEskFlC7WARHmHcbIXJm6/w0u1oA2zRrbcIGd7Vz0012pvhaeekiLzd60?=
 =?us-ascii?Q?5e2T0stnA2hcJ5mv+WLOyLMjvkGag29/0F6faRChto9fwxCsIutBcqyqLapD?=
 =?us-ascii?Q?R5AeIOZBS8MSkoCgJ/KYaBtbtCKj/1aHLPxv4LfElDFbPOuhUYRT7r2gZ2Os?=
 =?us-ascii?Q?X/A9P0hh8k0MRfpdMs/WbO2/DxMq500nwe1RXfvRuCwQIhOqINUwckmjQvuh?=
 =?us-ascii?Q?VzHxfalFWZmJ91pgparQCUlG6n5acRMvL9sCXitfAZ2C5er35xR4j4KKe9AP?=
 =?us-ascii?Q?PV363trx/BKEwXETKZL/shSFIDjnqrZt4Eur2D5ns9i58hUs7SEM50hNQzhh?=
 =?us-ascii?Q?/XcjEVi/0lD0hkBI3noSShwJDSte/WZagiyPBsCXt2JiUpVRKnJL5h3LTPZS?=
 =?us-ascii?Q?s2paQQ5dPE6bj7xop5oW8Mgcb51bYaqWgSC3F9mqTVRbNZLoZUANlwLfIzeg?=
 =?us-ascii?Q?x1OgWpCUlLL6AleGXGk0QEkyE4x3uk9oOvQUhFKfQtTm+ZrS66W7Zeh2kTO0?=
 =?us-ascii?Q?6E4vPQxVb7lOPncch2eA+w6hQz7aJAycjaDDHRqjq1oxHUauDNMxM77SaN3L?=
 =?us-ascii?Q?ivAU3IESmClQ6MgztbNm81ipDdkJJ+W4ij9FSn5Z+oAFtL6G4L58cnhKKz+B?=
 =?us-ascii?Q?22FMsWUb7DVkdvvvMqOYOf4BH8Z0bpjCt2UmTeP21LiqIoQMqLHvvrs1BeFR?=
 =?us-ascii?Q?/Qf1hpE5ySz0USESMhnTdJ5yQ1k4n+oXpbufubyd7fT/jdzBSvCU+lxjgOnm?=
 =?us-ascii?Q?KFA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8tUhC9xp4TqBrMGM6a0TeW5veKiPopAdGTEaBbSTEWmMIkEixrWduikNqBSp?=
 =?us-ascii?Q?Fv+Livi5hWDyY2OumJeeEgi1N3eNBJakMptm97UoJBTkNbVk4o690Kd/Tvap?=
 =?us-ascii?Q?U7tOwkLRJzYnS1oN9A0QvvOEZxjWEO9o6v7lOj0sl+/PyHO18QTE6Hym0v9Y?=
 =?us-ascii?Q?3Am4CCZNMKK1fYScvPMUvRNYSgo9gaBgUaSlA8RiklqbR8fOlJ7RhI8V9WmE?=
 =?us-ascii?Q?X0o5IAeSw5gxH6a3OPWXSBXVa86JpPNMSk8FHsUXs7zpn+MoxD6Qq6NF26vA?=
 =?us-ascii?Q?HZThhOidQEr3FNiv6XSZRlo29NyccPDAiB2UW3fcND2DzY9uGxK40R+DRGca?=
 =?us-ascii?Q?7N7TNh8B8UPC9V2/pYUoQSsycwXOcCzW5fQ5TifCL0qI8JYLQ0gHMkGNzRXf?=
 =?us-ascii?Q?DSOtv0l/jcQ+w5nTp6NgOR6bV6wL1Wt8PPxFVuSlqhuFGTlg7peaAGBppeuZ?=
 =?us-ascii?Q?9sYFjb3uuahGeCxUQBXkn+kd0BLpxTkrNTXvtn8DnQ+U5EvPHD+FRtjL+5If?=
 =?us-ascii?Q?b1X8f1iyvryfufti4HbVKtq6Bq+YZPpOAaZQwxXFdOE/3tI1w+hdTu7c5CjZ?=
 =?us-ascii?Q?OaiZKnWUSYCzUugZDkJbPGGmE5aWLso0fPorGsHQOVhSI31Qi5P7H8wJn4V3?=
 =?us-ascii?Q?BMRhaU887jB60H3LXsitEb5PSMyylIAS8rwoYSnde09wU/RmiNi/XhtGBIfg?=
 =?us-ascii?Q?KnKZKPVi9lQRq8zkTu4KNAiWlWmiWrGScwV/YbUhN+BuK13i6tWp329ZJr4Q?=
 =?us-ascii?Q?z8CBNZGzVQdqEioYc4yetM7Wf0augRWEpQQn2V2tU3EG+sOipRsIwN8YrxdT?=
 =?us-ascii?Q?j5m1GnY5I/fhq2ymuX9ljGMCJl8Qi1X4IH2V54WYc3oJARpI0KugW6Vs85lB?=
 =?us-ascii?Q?rs7HyUOJ8YtfYJQCInQmuk6kz+BVrZyisP/xZl+lXuwAOOt3XrjYKQVOz6EY?=
 =?us-ascii?Q?d28Uy51YxZPUdmujyy9H1DiDT4hrMn+cBJE/54X5zksmrnzUDV3WY8JbVqvM?=
 =?us-ascii?Q?r+VyBq3qiy6P6MEwnHDiqePobi46soPIzkWf6pXipfJ0zKhqnhUHqvjPsckI?=
 =?us-ascii?Q?gfQWGSvwgobNqfsGeOR6cxc6yR9QXVzxWTABUf41BN02jUHLlh1TZVqzZ0MC?=
 =?us-ascii?Q?5OeB/Wg2snZrArzPAiGhooTVoSQQjPX2K2dj/mNUQ3+PQA+4C11H1Pu2Esko?=
 =?us-ascii?Q?em+vC/rBgFcBPzZp+rM/vhRehBgoUR8QDlKlnh/vzBAmfCycs3TzNb3D5ib9?=
 =?us-ascii?Q?OeXsaQgMeyku2CIkw5jdH2NNmbXO0YUrgyCkoDvGePXoYBtzlkzHCi00pvtQ?=
 =?us-ascii?Q?XKfwWk01robvw54oNnSKDbzzbf9T4eR5XDET1Uzzof+4RBnJ+1IzlmlYnAOL?=
 =?us-ascii?Q?FKM1dg7UOjagQoXWl8+x7uLAH7T4H9Q4E1JOD789VVXi6squgTDyVrDcd9T+?=
 =?us-ascii?Q?Lj5wqlz8DZXVE4e9jGIeemKX6U6/UsjJOvNT0r5EO0dwCJO/ZGRfvl9FKS6t?=
 =?us-ascii?Q?TTV5dW7vQO9Pgh4Ih4F31fiMCPRHu+TZR/+4RH6bvie8pBJHFteRPefCoWkF?=
 =?us-ascii?Q?vQnlj5BrfgSXL4OEN6igTkA3v7fGL9YBJPn6sE4Db7lYUxs4mr4jDvz1BvJY?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ed0b1f-11a5-4a99-e3b6-08dd19bf38da
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:38:44.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7VN7EU15xdmrRKO+nJbxjnENk8KuSa4nfcNMWGtAQ0iXZryMlOtIB24YgJwZgRN/33W/3W0JF5ulNB8gUcuMBoL5tVuZhTiCwq0pHfwCps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8496
X-OriginatorOrg: intel.com

Bharata B Rao wrote:
> On 11-Dec-24 10:14 AM, Dan Williams wrote:
> > 
> > I was able to reproduce a similar set of conditions with the cxl_test
> > environment:
> > 
> > f010000000-f04fffffff : Soft Reserved
> >    f010000000-f04fffffff : CXL Window 0
> >      f020000000-f03fffffff : region3
> >        f020000000-f03fffffff : dax3.0
> >          f020000000-f03fffffff : System RAM (kmem)
> > 
> > 
> > ...but that did not result in the bug. So there are some other details
> > missing. Can you proceed with providing the dmesg from the good and the
> > bad cases?
> > 
> > gist.github.com is useful for this.
> 
> Sorry for the delay in providing the data. The system wasn't available 
> for a while. Now I have put the good(6.11.0-rc6) and bad(6.13.0-rc1) 
> dmesg and iomem logs at
> 
> https://gist.github.com/bharata/4a57db11e044fd1d313035f3dd5f763b
> 
> What I see is that in the bad case, we hit the below shown dev_dbg 
> message (not seen in the logs that are provided)
> 
> static int hmem_register_device(struct device *host, int target_nid,
>                                  const struct resource *res)
> {
>          struct platform_device *pdev;
>          struct memregion_info info;
>          long id;
>          int rc;
> 
>          if (IS_ENABLED(CONFIG_CXL_REGION) &&
>              region_intersects(res->start, resource_size(res), 
> IORESOURCE_MEM,
>                                IORES_DESC_CXL) != REGION_DISJOINT) {
>                  dev_dbg(host, "deferring range to CXL: %pr\n", res); <--
>                  return 0;
>          }
> 
> With this, it appears that dev_dax_kmem_probe() won't happen for the CXL 
> range and hence CXL memory doesn't get detected.
> 
> Let us know if you need more debug data.

Ah, thanks for that!

So, it turns out Ying's patch is working as advertised. It is traversing
past the top-level entry of the the iomem_resource topology to discover that a
Soft Reserved range is described by CXL. Then the expectation is that
the CXL subsystem parses the topology and registers a dax device.

I missed that detail in my repro because I was not testing the HMEM
handoff.

Now, the dmesg shows that the CXL subsystem gives up early on the
CXL devices as they do not appear to be meeting the expecations of a "CXL
Memory Device" as described by the "PCI Header - Class Code Register
(Offset 09h)" of the CXL spec.

Specifically these messages:

    [    4.449072] cxl_pci 0000:9f:00.0: registers not found: status mbox memdev 

I think this situation is increasingly showing that the pace of
non-standard quirks being deployed is higher than CXL subsystem is able
to keep pace.

The immediate workaround to this problem that Linux discovered is to
disable the cxl_acpi driver. Can you confirm that preventing the
cxl_acpi driver from loading restores that missing node?

Longer term the urgency of Nathan's patch [1] needs to be escalated.

[1]: http://lore.kernel.org/20241202155542.22111-1-nathan.fontenot@amd.com
