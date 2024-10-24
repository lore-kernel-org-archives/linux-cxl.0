Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651891A7AF1;
	Thu, 24 Oct 2024 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729807074; cv=fail; b=YD27EtPO+kcHxb7/e/rVz0fb3pLz4RiyNogvO2wIL9NUDIxuOp8WU2RxDQ2+qY6eV9DQl47g5RZS6rkvqtCHirCBpPzWjhaBnkXJWH9WZBIuI8yB9LjES1bM9+DnpsewbbAVM5y0gv7R6xGIDQwWm7jjep5LtwyS708rUzGBRTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729807074; c=relaxed/simple;
	bh=+KL8wwvPP7XNJSOg+Lm/msvtiAMsV/D/07O7Xjkpsiw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OxcXTjFMA8K6mBcFr3Y464oFaRTKUO2U5+xyPW5POXaCaW71HG1rHKm8ozxurBzqGGWOX+Hwa2T8Qe/XvXbEA5NIT8mbhj7Xl2iT1SR4PsXk0ScDYWHXtcYBEUiVqCxqylBTxRXdUGSYkMD2D5ckMUyehr9KT3Sf1jOsyzAc+g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8q5rl77; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8q5rl77"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729807071; x=1761343071;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+KL8wwvPP7XNJSOg+Lm/msvtiAMsV/D/07O7Xjkpsiw=;
  b=m8q5rl77EPPkSFF2mYdJlHAsTEkFNwtfVwNesQ9qMBCsoaKwKmLHcWT4
   soIs7FLN5vySovROH7DjMGfKvmxf/+ULuhmPkr5pHAQ6v3TZwwz4rW2x9
   tBthuPBrTN5leCfd4fa4CCfE2JhF0g/zgMTdH3xDDQlyo5bSLZ9IxWNiV
   3FwlHNsIeMCsfojy+SJcK1Qu8cCkFkI84eviE//ZZFYlHgOkxMv+Et4HZ
   TTy9SPKFj87BT2cYBQW5bDvwIcoWE8MBaeSDZn8Y8Ii29bWz6PzASYbr6
   AuW8v+VoRC1J+Va7fALgaCzcEEhMxMPzeZakjOMYigHaSBiYrUk1w0+XK
   g==;
X-CSE-ConnectionGUID: Y5id26AuSVG6d4twBftWDg==
X-CSE-MsgGUID: 2lDVblkpRZCdl4o06bpiDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="28919161"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="28919161"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:57:50 -0700
X-CSE-ConnectionGUID: +i22fRENROidI53BbuonLw==
X-CSE-MsgGUID: Mcd9bw8FSpOmRWHfBtz+Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80899860"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 14:57:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 14:57:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 14:57:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 14:57:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUWM/J5pDG7tkv6SMPZbslvZTwNNvEB4dE/cQnuROn/B9UuS5mWoI23bKxOFsZgCp3Si1b2CVv383n6hCcFxZiwnDPvOM/Z+6Zd0SGXZQnmokCnG00NyMukt1o6G0q1Q5lE92oFcsUauKVW5YS85TTIk6qFKxB3foMvAryRUEQv5UspBT55WFyfa67EBQ5rCWcZM7EWqt5Gdhu9iEes6NMZuNvqIVduS/+mMhMlcB+rbgQGs+5EZqD7uW76LFqP7+0bs/JGLQD5BrbDptw1eEXdyQmyjNi2RobcmNHRSfuo0HCD/St6A4dRp1taGVtl9a5Obj/vL770D0CfD/FhMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYSiP3P+0tPZG+eBAraNspmt5m8HTO447wLztkxZK6Y=;
 b=LRC1RTQ/G+2eQJ5htPpDFDHHvK0/mxNN3LZRjIJdSD8kaepVzGA/ZerlnS1m6K7LJYlsw5SIFSHah4oHmKN5iooQe/F3kBTvuGjhX4t3BjnfO4145P69/nVP2wa7BPNzYR4HYJGUNKF2tKCebdpfP7MOq9W/vgjk4wRV1LAtEKT/yPXORgsFZyKSaE+C/RbDt0bjzTkQtas5BPypzEqN2rDp1Fg+GjkLbs34et8Ng7lCOG2AMIExxwfryJoX2FxiUdcTKPhMFX+VtHsatwzGujj6Ifm5bjVdcU4flEHybwmR+TEABKCz0bj6kHlQnh440ncczWIGg2Ree4PkCaPKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 21:57:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 21:57:42 +0000
Date: Thu, 24 Oct 2024 14:57:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Huang, Ying"
	<ying.huang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, David Hildenbrand
	<david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
Message-ID: <671ac2d2b7bea_10e59294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241010065558.1347018-1-ying.huang@intel.com>
 <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
 <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
 <671965a8b37a2_1bbc629489@dwillia2-xfh.jf.intel.com.notmuch>
 <ZxnvyIme98Q8ey1c@smile.fi.intel.com>
 <87wmhx3cpc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZxpFQBRqWMDjhtSY@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZxpFQBRqWMDjhtSY@smile.fi.intel.com>
X-ClientProxiedBy: MW4PR03CA0323.namprd03.prod.outlook.com
 (2603:10b6:303:dd::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: eccb3941-12b0-4027-4f45-08dcf476e246
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9kMNx8nNpySk6NLMqiRD1s87veKqqicvlWOWO+OjUKbhvrASOzUL5ATn3zWj?=
 =?us-ascii?Q?X3wxWKnN1/8Y2k9OgSPZX92CYgRrd7MR7p3hFMIvCXwPRenK1HVzmI+xUJ+1?=
 =?us-ascii?Q?FAWrM8BTeJ/MtxQphN8e56xRGHQNyNxZyG9Lmz4M6QhJl94egdxuO7M9oALM?=
 =?us-ascii?Q?9ORifKlRbelejBDcHku/zVxSw3sTZF2b/zYBCtl1mZZx4J4kWIOHeFpc4WC7?=
 =?us-ascii?Q?VcJNdP4Ou5dptpPAaZlqLxocJVql+q11hWj4Eg7C9X9hV+T49yBAjFyuZB/a?=
 =?us-ascii?Q?InKBknsZik21IN6ugzCWe+eODMxoFN24Plta4zJw8d4w6orPrRyh2ofo1YPr?=
 =?us-ascii?Q?Vspy6BkR8YUSHEkGtUbFlz9/DzpZ2Ii2txk81KeJskGgMTk0WT1kuX6MlozK?=
 =?us-ascii?Q?FwabmMY4BISFhR6SAQdoxCVhSPUBLZjrEglVuUQOmrMyueRElgk19OCWCpc5?=
 =?us-ascii?Q?4fySfJ/X2UzRn9P3ZXJfJOft5JOmytBFGf1zDJsOEsNQKF5GcL/t4xId/c7Y?=
 =?us-ascii?Q?TLMVzh/AxfmjLM6pK7PyskpiVb54ipBkNbhBWC3yl+WQXCN5xMzd5Am3jyWA?=
 =?us-ascii?Q?BwcPXuNetR38FaUtOfmPAT31CfXp3kuG8H6lcWy4F8XbwMpZ9wmwL9TEfT1u?=
 =?us-ascii?Q?tcdMJqLz+KxioKWgTmk8QA9BRGQhUIjGKY1IC9u1gEOHUlAe/c16Mec9A0i/?=
 =?us-ascii?Q?D7GVpYdeO+yHqJf31B8eDeDlR0AH43gDMR21hQhfZynBQHQYz4GsGI+84QoP?=
 =?us-ascii?Q?UNlmdrCUFP3g4cJ76rHgGmQKIOnzIMjUCV3uDjtsgZ/XskjdN8w8n/rqCrwa?=
 =?us-ascii?Q?bXtNEhG+GCwV1IK66AIGS1xqahB337OWK4GINyO0gK503zAQhxaLIk9Z/Aue?=
 =?us-ascii?Q?nFjikixW4IzuA6+F44GuyNWduzrnFz1PFkP4qvXJg/hBITHbYmVyC1KP7w4C?=
 =?us-ascii?Q?2YLObRbCYTZYH3sqq3vocGxK3Etc2b0Tlxs2jRe2e6UfpTkGuzlp2ctiFUw1?=
 =?us-ascii?Q?VYs6qH/5eyn3CYG2bnGivF2nRDuKeSBsDkoF+xfSV7jSBzyxg2zaF0I5WnQy?=
 =?us-ascii?Q?IyFTvc1l6vllcmVAVjzFa635t5asL5+uudWqTTe600A0+yqpVZbyxowwxXZN?=
 =?us-ascii?Q?0luzVbmy1C60sLhnli6vZRSOCMeenaylCcbLfIboAwL44MsAw4wOQRbeGhQK?=
 =?us-ascii?Q?GzR7WV/ofldHOsIsOYpp5MK83OZZr/kkROm8bTiNlWTdaB6EqFEO96ZmZC7c?=
 =?us-ascii?Q?EHmP96ZuJ9AWoJgVhO3Gj+NJyeHn+AQ+izNn533nYicAzhLEhVOJjZ4dSrOo?=
 =?us-ascii?Q?LHgToUcxUvuXxtB9So1g8OLJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b58U4qgA6cYdiM9FQVHe+cZnnbzeOlMapYqEdituSgz9mpFtdhbmh5HZjwNT?=
 =?us-ascii?Q?UWZigkcpv+/O9XNRptKZ0pfzfxJYwZi778Iuf5EMmEuZzVhmYYgiY2tVwYim?=
 =?us-ascii?Q?0/ZUzQYtJUuAJge/peCxSFrzgiXtPZ4K+Q+CaOOWh4EXUgnhHmcoE7tdckwJ?=
 =?us-ascii?Q?V9BOjfz6XttytZ3ubDhFBpwQLb5Hu4/2Ur3rekooR0fbxMi/eiuzgbQt5lE0?=
 =?us-ascii?Q?6GW0aNRuifTXyV3C8eH9jUb+wr0/bf4rK6kkOX2GWQbIbUZzNdppUo23Xg6H?=
 =?us-ascii?Q?9DnnX3woZw1SLSHqJN51MdQpkHG8SvLEIyng3EeUDOte4VjjaLs/ySGtj7Iu?=
 =?us-ascii?Q?Hunz/N471fFW0BZoE6rYx06w6jUew2pDk5DR9/Z0GdBeG0dpiqvbixA63slE?=
 =?us-ascii?Q?mHzyN17XSHBk827VSHD7whKEv+y49ps7Kpeh1mKXesN/JVBMKsozYvR+9gnR?=
 =?us-ascii?Q?DZSlEg53g1fKHvOVNAZ0IvirNf97VzYRj4ebxlku8EWgKPzxcz6kHyWNGV9F?=
 =?us-ascii?Q?j6ryxS+VngrvPLJDjB8W7TiO/+x3PgN5eTnqRFqucKe5WtG6ebxUUp9p0v56?=
 =?us-ascii?Q?nLhmVOOGXSK3KHbxrLCP18L8Wk5DjJuj39ZNAmRMYxwcCCXgXk5JHBjjg20V?=
 =?us-ascii?Q?rdG8+Y5pU6CsjbOGiguNRtEj952wfX5pooh1ZbIeQTvmp29UnOv8jA5Za0Fb?=
 =?us-ascii?Q?QpLun1nf107Yp4jzVI5x8n4Ed7oPQi0siRsI5NmSdhjMtpkZZPmHK9PXruba?=
 =?us-ascii?Q?0TKgNqzbZ9U+LxTTNsbfKl0BD14SourOrVxal3J8qJHCPFyuNjfPbttg7o8D?=
 =?us-ascii?Q?m+tFyTsWOsZFv5ZQmRV97OBIE8R3DdnV4KnaRcT+BSxzoYvUekkpO35zxVfH?=
 =?us-ascii?Q?FoOAWoMSyUZttpQenRSOKgFhELrF/CkIpe/iC2kSTublkwM7t6T+IozfNonU?=
 =?us-ascii?Q?N+HOt+weahaZ4EwPbTYDALiF/PrnNaJoZp7jwWzTrc6go2hYuzcHl3UyM/fI?=
 =?us-ascii?Q?D4C6pKsPbtAH51PfXobYPwdheDfnNt8Z2IaXiN7FNp9KVqPG3a9kTkC6ZpCX?=
 =?us-ascii?Q?cB6pdMcTWQRZ3733HiGM6kVAegMmE6pI+CU3sjwPcbFWjQQeL8UArn4TwUlt?=
 =?us-ascii?Q?+T3FIi6qs6k3eomX/8BEnrDg2+pGLzDRk1NDXOCRslpDRKv1lMDKRqfD747T?=
 =?us-ascii?Q?Y4J+gzbGwr/sfNfL9g/vDdAQL3DJw1rjy6PcSW2FZglb3C9lnXWBQJ9/aUct?=
 =?us-ascii?Q?UUAK0wsuFKZFPSANy1cdSn0YAih7BVI6htDRulV5t8CKVoHeT9W6zoa/Pbi8?=
 =?us-ascii?Q?8r81xd7p0w5ADzag0cqWv3R2LvjCP+Aew2nL7RhewqnUngbKD/EdK1Bif3ri?=
 =?us-ascii?Q?dl5HClpj70qdQO5dx48hmGsbgSAcdtYsevkeDy6r0EPxaPAW3DlgQaJ3DGok?=
 =?us-ascii?Q?U2cxe3ddueVKmXrR44wOin6WucITbjrg0PbeWthKNKgB3BtOXHO8wVIVhV10?=
 =?us-ascii?Q?tlzw7F/sj9HZTfHIzOa+7KLYJXj7S9kZEYnMJXpsqq9tUIwbGl6DXiOJ4IdT?=
 =?us-ascii?Q?3j+MVC6v4k1V8rxv4G9PSH+sFDZzaLa1wW6tT8vDR0S65kTB23Mp3093JTLR?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eccb3941-12b0-4027-4f45-08dcf476e246
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 21:57:42.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpZ8xiDxUlLiD/Job9DLcHO0S3Lh0hi84y3RdGq5/to8pd5CvGF2AwdfjCOadMMUAc7lNvpK5aUD8ij8gFZM1GbHuNLelJFEa9h+AvqcCiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
> On Thu, Oct 24, 2024 at 08:30:39PM +0800, Huang, Ying wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > > On Wed, Oct 23, 2024 at 02:07:52PM -0700, Dan Williams wrote:
> > >> Andy Shevchenko wrote:
> > >> > On Fri, Oct 11, 2024 at 09:06:37AM +0800, Huang, Ying wrote:
> > >> > > David Hildenbrand <david@redhat.com> writes:
> > >> > > > On 10.10.24 08:55, Huang Ying wrote:
> 
> ...
> 
> > >> > > > 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
> > >> > > 
> > >> > > Yes.  This can improve code readability.
> > >> > > 
> > >> > > A possible issue is that "_root" will be evaluated twice in above macro
> > >> > > definition.  IMO, this should be avoided.
> > >> > 
> > >> > Ideally, yes. But how many for_each type of macros you see that really try hard
> > >> > to achieve that? I believe we shouldn't worry right now about this and rely on
> > >> > the fact that root is the given variable. Or do you have an example of what you
> > >> > suggested in the other reply, i.e. where it's an evaluation of the heavy call?
> > >> > 
> > >> > > Do you have some idea about
> > >> > > how to do that?  Something like below?
> > >> > > 
> > >> > > #define for_each_resource_XXX(_root, _p)                                \
> > >> > > 	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
> > >> > > 	     __p && (_p); (_p) = next_resource_XXX(__root, _p))
> > >> > 
> > >> > This is a bit ugly :-( I would avoid ugliness as long as we have no problem to
> > >> > solve (see above).
> > >> 
> > >> Using a local defined variable to avoid double evaluation is standard
> > >> practice. I do not understand "avoid ugliness as long as we have no problem to
> > >> solve", the problem to solve will be if someone accidentally does
> > >> something like "for_each_resource_descendant(root++, res)". *That* will
> > >> be a problem when someone finally realizes that the macro is hiding a
> > >> double evaluation.
> > >
> > > Can you explain, why do we need __p and how can we get rid of that?
> > > I understand the part of the local variable for root.
> > 
> > If don't use '__p', the macro becomes
> > 
> > #define for_each_resource_XXX(_root, _p)                                \
> > 	for (typeof(_root) __root = (_root), (_p) = (__root)->child; \
> > 	     (_p); (_p) = next_resource_XXX(__root, _p))
> > 
> > Where, '_p' must be a variable name, and it will be a new variable
> > inside for loop and mask the variable with same name outside of macro.
> > IIUC, this breaks the macro convention in kernel and has subtle variable
> > masking semantics.
> 
> Yep.

Oh, due to the comment expression, good catch.

> 
> In property.h nobody cares about evaluation which makes the macro as simple as
> 
> #define for_each_resource_XXX(_root, _p)		\
> 	for (_p = next_resource_XXX(__root, NULL); _p;	\
> 	     _p = next_resource_XXX(__root, _p))
> 
> (Dan,
>  that's what I called to avoid solving issues we don't have and most likely
>  will never have.)

Ah, my apologies, I thought the objection was to the macro altogether. 

> but if you want to stick with your variant some improvements can be done:
> 
> #define for_each_resource_XXX(_root, _p)				\
> 	for (typeof(_root) __root = (_root), __p = _p = __root->child;	\
> 	     __p && _p; _p = next_resource_XXX(__root, _p))
> 
> 
> 1) no need to have local variable in parentheses;
> 2) no need to have iterator in parentheses, otherwise it would be crazy code
> that has put something really wrong there and still expect the thing to work.

Why not:

#define for_each_resource_XXX(_root, _p)				\
	for (typeof(_root) __root = (_root), __p = _p = __root->child;	\
	     _p; _p = next_resource_XXX(__root, _p))

The __p is only to allow for _p to be initialized in the first statement
without causing a new "_p" shadow to be declared.
