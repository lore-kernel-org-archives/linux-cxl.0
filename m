Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733141FFC7E;
	Fri, 20 Jun 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750452272; cv=fail; b=BC5WJ+ulQ3mdmNPPe2xZwQt6Ti6LttM5GrlddKl0jGlk0HbyzNdQx0YZPIBgeagD3KYF7ETVYZTFNR18AzWRmUNemscBtbUi6S6DSQkJoYFklE9tHuXahnI6iT3CVCTpqmUCadq7sO+A41urgCWRQoumujLlaEr6uwK63kCmmoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750452272; c=relaxed/simple;
	bh=ml/Yo0814YFIdB62cbRsi6MWM4rfC3er29POQBTzcRI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s+Qnhs+iofm9QAeLVxqxigIinuLor0CIl76yXNVIeTcXfUlkoSiGvXNYRav6kotEKbSDj7dmPoJjOdFAFabZ9qqtvE41OAAuRF+BKR/0yHZUNsXqHomZC5stcrP6MLrCf6hlv+Yf4HXm6iZtm0q5S8MpysuvINqMUoRmSZFW4U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWs8eqvO; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWs8eqvO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750452271; x=1781988271;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ml/Yo0814YFIdB62cbRsi6MWM4rfC3er29POQBTzcRI=;
  b=OWs8eqvOAed5Dw98FiAKJOM2feVm2D2BqV0ksLVLYOY4qjUzacTelxnX
   o0rVy5mAWlX/KFHai5GzzINqpnlUcH0l4AD/Q61QxQWjdi63feBL8uzK3
   qWW2pUxMX/VVHWdetKC7udGKYSG7ju/vaDFrGh8VGlV4j0FYTd8vsru5V
   R4FDuk1gLJs+TrNetv8GdwRCTErH/nxNy4Kx38UzY+hsza7jrT2Pm2DSC
   9dy5n5ruw+rgOnYDnvKGveZeQNWWzajACf+wc0RFwPwqRjCD8gsKcKOIr
   iZFmd1YoQPp4Q/CtAIgRIpRCjCwpzUMwwva7YHzFM418+aU96Kb9uUiIb
   w==;
X-CSE-ConnectionGUID: S+OLC15eT4WaX7gzhjeRvA==
X-CSE-MsgGUID: Z+wISGYHSNSQQouaYJlCyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="75258903"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="75258903"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 13:44:30 -0700
X-CSE-ConnectionGUID: kqI1OkTRR7CnYfukManuAw==
X-CSE-MsgGUID: D6CtQcMqRWKnin8mmVA7WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="151306940"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 13:44:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 13:44:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 13:44:28 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 13:44:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppL9T5pqNe4xg+vUmCVdnt17dEiBZL5EfUnXOuYew2qRDHfdxsLjR0tJsNv3Tau4hCy2GAAeNNFXSWmAp9+hFQvC8JCts3s+CpEzJbgEqrXEo5G5RMmYzJ/wJx5wpw+ZKmZVa+HfaRRi2aVAmDmXg4PNvE6ITGOSGHaazCZTNWOGITK1panLbg60HlK0Y3peoND6roZhuzen2kYouPw7Y9l0LC8akopQMJUCysL7HqKUcbttat1d0Zw6CR0+ZNXN6GZ2in0wT6uL//qI3z2kWLLubrcerXz2GAXMDnAPb2b71CV+6h4NTZhp6CNU9z8h7kv+1pwKxJmi3JgGKMo3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0Pyu09AjJxF0HZ2hsFvQg6wTah5Bxm9QnQzR8onLrw=;
 b=HSEEE/9eoEkl6rTCMmU8vMQaIJcWaqodh8bk+YHRMSoB7Fp4y2tH6+g/VZVoIPewUeQsJ2xlR7rWqaZZ+W4vpKcaZh2Z8DdV0yaeCWYk0kErA9WfiUxHV9I24QFsC3Q52Xq++OAYw/gnOydVuR9WHokHAHTULEerjv5VQUN/9u8TWCbkyYlooFCDwQktHjXfxTiSXRVkL6gHfrc8LYJR9574OFlWGTR8fBcsxw90L986W/NQKKd0O0TsAJTYwXUYEDDTjOZLd+OEOrciFGbgEgOozqxK50by8FVGHMlZTAVTf7heayiXC4laTvhzKVSnRx5s3utHzgVmRZC6z73hBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by LV8PR11MB8511.namprd11.prod.outlook.com (2603:10b6:408:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 20:43:56 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%6]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 20:43:56 +0000
Date: Fri, 20 Jun 2025 13:43:47 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 2/8] cxl/mbox: Convert poison list mutex to ACQUIRE()
Message-ID: <aFXIAygNhn1KESmX@aschofie-mobl2.lan>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-3-dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619050416.782871-3-dan.j.williams@intel.com>
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|LV8PR11MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: b54f1322-f472-4aa1-61cc-08ddb03b2d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LZFDx2H/1WWOm4r+ZyrlbsaoMxTCbqMhOCHIiMRVd756or3gkRXDKxMcn/8H?=
 =?us-ascii?Q?GEaPr52fWwEb9nEbFyN2HqfWeDzCcAveuHNq/o3fTBGJc70lHGQ840VDUuNy?=
 =?us-ascii?Q?8h2UUw2Uo7S6sq9GEmAK2SwnH8NP9IesnJEI2DI8wFyjWfUeyel7cCBUBrfT?=
 =?us-ascii?Q?k42oRzqCYsKrjBoCMn5OKKDBQUUJunYZyaWjReTHLNxxkUQvWtJVLXjr+Ag8?=
 =?us-ascii?Q?NHn20jOmPDcq5MoF6hT0XvYOxnQb2OeMZAZcJdhaJPPMEq75BDcxNDqECGuy?=
 =?us-ascii?Q?ITguWUirDwNWbxDOUqnXISj6v6pKt/43Ui5bzDDetU2vpdY6GBMt6Ryh2Cts?=
 =?us-ascii?Q?Y+JBCrGVe3CjCtZpvks7S4piDR53q+nxsOQITBuz98bq69Uvo3MNqqVPFzH3?=
 =?us-ascii?Q?pw4WXtLw2BrQaFNnhDFniZY2aHo881zLakBsON6SqumBRDUhqDF4qGL2CMEv?=
 =?us-ascii?Q?qbmvfr7+tzk8CeSoY7LsaDOGhuyktVZtCtMtlC1k5qRhpDjhFYlwfXFrIAG5?=
 =?us-ascii?Q?mzHPB2dHLxY3lsxF4elWicaIr5L0vzh9d26jbxolP7J6YXK3owMZLMfAT91k?=
 =?us-ascii?Q?kYE5+y2MsOIWQ4YR+3DTCQCSophQh1ew06dt2d/n9AR6BPolqaF7C7tyP1A3?=
 =?us-ascii?Q?yGdsdoOXmLFd358invaScY2QNHsCyZ7n+7eP9CPq7qd7vXx+MjKOolKUy3N8?=
 =?us-ascii?Q?1tJLkm6MvAM7aeC3TW15vl5TtXv5NX5AH1zUmsPHhAZDUfTE71wuDJpahoPH?=
 =?us-ascii?Q?5Bm80EJGoJJDPCaANYL8iJk8ktL03ae4VZdxFeaXipLaTUJnKrFw1vQX+6Dn?=
 =?us-ascii?Q?VFPFgxBB/dhfgvNs6yD5IyKflkFhi8q9yLMTSWbVcZvffAAMwtjgxNH5lPZn?=
 =?us-ascii?Q?HKTtI67QKy1o5Bjguw8UyIEC/sp1mbJsNUPpSngQrfShXe6jloWwKSDRhkoh?=
 =?us-ascii?Q?RiAbyZ4JqEoETTjigThJlNUS2jgjAwP7450DQ1O8ckOGVEBurlz+59toygXt?=
 =?us-ascii?Q?1rD1eLYAxdKD1OisiKjEqGWC7l0O4DFa6TC3bl3hcGN5nY5GgU0TPNf0OEvh?=
 =?us-ascii?Q?4fLxn1Gzav+h8+C2g8ICnNoaW2XXMDiZQ4xDMgdgHRXup6Ncqy3CCX1mRl/T?=
 =?us-ascii?Q?4uUy1Y921dw8gDIKrzt93JBoCQmxyf+4+7aKgxxXFY7zJebBV+WH4yHajDeb?=
 =?us-ascii?Q?5lmAL36QDocYzefqe2KT/61+fshsijeTByQ3PENNJ6NamMY9gPdj1V5X9xGC?=
 =?us-ascii?Q?V2qa/9i+VEcRNTLtQsrJvrTNgec7lBbbH9MI7mJQzbuvz1ernSKJY/g7uwI8?=
 =?us-ascii?Q?XkOfb81wrkdgbcds1Yh2ufFdwgDKzqcmERR113UdXr8DAEP/RVS7itwcNMyP?=
 =?us-ascii?Q?DOM6gA9T4OJm2+Pb3LJCNJGCeL5t98uGl2kiT/GGscroMWGfJzzUzT/U3UFk?=
 =?us-ascii?Q?PfjvEYWVZIU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?esk449n9feTP91XMNi8+341dQFvgC09nWnBRZMcnIn70Sjf3J1heQp1aCI98?=
 =?us-ascii?Q?m9moEbwmm0qv80pC3iVRnS/O/5pk6QNFDI+/8fVyBVBEWcPZSmaQlX4Chz8g?=
 =?us-ascii?Q?prcsoceh4J6hjnZBNWSFG4bPQK6/jBJm99S8TsXOeNfL3nrmSoMg0j0KF1jz?=
 =?us-ascii?Q?lNch2jPqNjFftD6zL5pNee9NpRaJIuCxN0bsrp3ekW1mjppLWV6xmqk1QLaO?=
 =?us-ascii?Q?VkXQGkoA6RgpPFo8aatEN5mnmOTsGMvsp3LE3RrViPQViicceikB7Ea5BwWQ?=
 =?us-ascii?Q?Kea3JYgg8W/f56qA5OB9ROlLMhbvWWmYKUocI2OhSbmTSdmO+oOe8RvoZbdw?=
 =?us-ascii?Q?cly7ey+Ym3VhES8b/fikxGnenm22bURJYNQl71FFX2Hrj5GtYAgIAx/bdkJT?=
 =?us-ascii?Q?qvUb7DIx97zdecs5OqbYb5SbtF5i6RIt24pJRyXY0Y9ldRTIIKQaLekdveu/?=
 =?us-ascii?Q?WZEhmxmq06GnHfl0ObXFHkvieJwmCtDVWxDZ8M+uwl2eFvS83GGqTPCsY+iO?=
 =?us-ascii?Q?hQFLCIvYAmhzrMDR/ulrMZMRj52qnXGMzl+JKi7OEknDYSdVz/D/ZKs6TWLK?=
 =?us-ascii?Q?3j3rfPnc8S7zSfg30kkK1OhOaw3jmoTPYx6blnuBL2AkCSj6lVfAJeSWRmSf?=
 =?us-ascii?Q?3l/l+J3M8L0nEhsUJFBXBbX9AkIqQ56XSagPTwIIImLI+FbfJYcUh63SU2HK?=
 =?us-ascii?Q?gw1iCvTLHVvtOpLEU16ITSDF1Gzwwi6YAB3I/ss6q5KfjMEo16ZVAZHi8jEj?=
 =?us-ascii?Q?8yfdklIPpBOiOq0042pbAs0ZboXMupYophVfGJwQBpIqOShcAYCaP4wfoyNl?=
 =?us-ascii?Q?9QhM/dhCvhs3Z7DQCxEx0xkDIjBXMn7yv/KWgGPSq5pjv2P3CDiI9PdFuGwW?=
 =?us-ascii?Q?TJktzJv+qzX1eO+YoNCNrrkavA0bKSIt0ewRZN0j6ZGwdC9wVp8oOzCpmnCS?=
 =?us-ascii?Q?RuwkQctEyq81xvJNNFKbeEArSFBEIMP1K5KreD9W1kEOFyC4Zr8iXtFImCt4?=
 =?us-ascii?Q?RLkU8QVjdS0jFYGK9etX1Qz2pL2B6GYLq8VmZ6XL7o0BIByPhS8gBrFbuKPD?=
 =?us-ascii?Q?p3cHDmOOemADYVGZ3kDQRXqKTXgpPOzxLI4RkphMh5AJq/f1eWpH4RQd30wc?=
 =?us-ascii?Q?5hPMKO/+7XbNxzSRuNXmSIZyIhYmlwpnOMydAEeIEKBwmdGIfxEU1ZDAKdmI?=
 =?us-ascii?Q?O5rIbeL4EWGFhdNRAmaBv+4VssvpR3tY3yvMPbT0Nbc3fh2KHiJFxO3sJEic?=
 =?us-ascii?Q?5s/7fO6EcibaFVVShi7Uzieqws7Ymkb9palBXoqoy4Wc+HvrXRcQ+mzvmrqt?=
 =?us-ascii?Q?h45pWyEwo2HK0WYfK2gBQJUW8I69QSuPcYDX3JwEaIKNcxRJYW4uPsxFJzYC?=
 =?us-ascii?Q?yfb2wwduq0A+9yRXFVcigSVREbSp8ZqIIcHxp4fmXC+bv9+dYgws57WP83W1?=
 =?us-ascii?Q?WxwyFZuw+jbbvoCNWp6m24/q3txS67RnR+F+p0/RT8KEjQ+6uymxViKIXsuq?=
 =?us-ascii?Q?WicNVYBTgvqOX/CUkVBNSqhFpBCXAk7dOecIMfmr8vyDzlYJIoKGtrh69mDi?=
 =?us-ascii?Q?TaxP7nOgwZ4Cw5zi1Cqp0AUWgHDTeOCzdVUOkcFU9OUSbdXKsvu1ulCbuRg4?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b54f1322-f472-4aa1-61cc-08ddb03b2d34
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 20:43:56.5664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRfQivFV5+BzrLrFfze75QhJTBq13NKwpapL+NHMT+2U8T+IPTQf0VK6imo4H4/WInjlWHTrgCxZgcbZ9BwOxPrptzyT18QOyH+8zJu6OaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8511
X-OriginatorOrg: intel.com

On Wed, Jun 18, 2025 at 10:04:10PM -0700, Dan Williams wrote:
> Towards removing all explicit unlock calls in the CXL subsystem, convert
> the conditional poison list mutex to use a conditional lock guard.
> 
> Rename the lock to have the compiler validate that all existing call sites
> are converted.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

