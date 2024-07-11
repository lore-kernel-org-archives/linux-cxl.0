Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA519E83B
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727998; cv=fail; b=bZDWS5jwFOCCvGQ1oYK8ViMTdWsTttrvUekoM51+6dgqcQOHDY5q/cms+ZUeecxT8eacZ/MB3zPgwyQGYk4eke8hBeiAds8cx4vomiYpemGxpcGE5Kd8hwaoXCo4BFP/YpQmH5CvoTkP0jiHZOlzPMW6FmVSSSiDNC+yli/THeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727998; c=relaxed/simple;
	bh=bHZdBgceSdp2h1V5JcB6bwGQhjMVPMcdDyXvexdU87g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V5KeykdeKrG84hsLlHXkekGsmJrDNAhDLMXJQ+GkN+OV+7kUNqG60LT5woqgIKpmSpzh8x5qDoEwi1/uwunIGTa77DBg2SaQDw4Drj5uJst4lG/eQMhn6U/aNp0lKyqPS8cTMY99awTPVJYxQZRxZgxAUCOHGiR2LCbDyUbRN24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGFDf0pc; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGFDf0pc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720727995; x=1752263995;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bHZdBgceSdp2h1V5JcB6bwGQhjMVPMcdDyXvexdU87g=;
  b=KGFDf0pcX2BtZqEzDAEkpXT3dxra/GCkokUFaYRgZoUytbwbEtHV0jQf
   cvAp4HCXnAZHceE5oiz5s8uoKxAhMNXG+qTQs03beHp3rNiL7yHPoC4vh
   znjrrQdlBX9du67KH/8MaRIdSZVl7Ai4nm+8rgVYZu+6v6cQbYgWBRQ54
   N8c3q0QW8a5aRlGsD14KwDtYcxogzQrjGqaka0+ITkHwmQxL1wF4KFJLN
   uzeSsUNPYx020qGfiKZSU6eMu3dxH/pgGG8IkV4SLmGlpJ3T6nUkX4mhk
   byRzzDqcFV9jiuQAHLOeAoFT1fnFE8U7bqi2VILGl7l9sGk62qisGI5DJ
   A==;
X-CSE-ConnectionGUID: nRzhh3wXRZqCUel0Fa2rKQ==
X-CSE-MsgGUID: zBUdv9ZNTiGoCZsXYYExtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18286796"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="18286796"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 12:59:54 -0700
X-CSE-ConnectionGUID: fWNqHUQOToS6oXUxNugKKg==
X-CSE-MsgGUID: ArqWTHc6THiQUHotHCwN2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="48747273"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 12:59:47 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 12:59:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 12:59:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 12:59:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab8htHQ03iKSFE8NWopBU4mf5uhi8C6xJiVp5qTY8IOOLiojGA1yUP4RvW29MK6NprSvGV+/prgVCaOBVk181e6D3e9lQyRU8NCF2vDl1nQJUg7RfjAVxqq8z+ngYv9BlW/JZvBIaSvVm/HHxJzdp/zDOPG2BHWYw234pbqnNCdE6P1twIumlJlMQbkg6d18UNVRdeqWKSYxmKTF249l5CjdcUPlGW00ZPqJOHhHvTGIKQLaHoNogbpQ51/BohPJwRwU8GQC26less3tMjvb1XKmFUB/XAeL90b5tp8pKYUxl5P0Tb5NxAQaJRv31QvKF/0tm/YB8/d4rubEY5juCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIlhnvMot2eopVHmMVz/3ecmrRPypPFxtxm+zcv0V/c=;
 b=k58mmroP2wc++oQPPySV0yBO7ZqV7fQjwUuwQhhh+TGLCXYrJu3WIeu9xvfwVhZfXz6vIBM0Z5bWgMzfu4L9fq2jxGJ5fAWwCeoBJpjQsFJYM0W+q0WRV0+OVHW1GyL5/TcUxUa+zdP9tpiOdtRUGa5von1Dk8idJBOuQiYD27TGSLizI82ENcl3PobeyXhBQVamTLj+LQAj50JXsbB+FriRHyD2uh5Y/4qY3/M8My8Yf8Pjjp1EDPiWs35NKuPuusVSH6Siw4swXZ7B83sGMmYganlWjxNFakYnGclgN1eMv6RQGwRQpYeg16HeqhfR0JN31BTJzUvm3ydc/Gh8uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7186.namprd11.prod.outlook.com (2603:10b6:208:442::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 19:59:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 19:59:44 +0000
Date: Thu, 11 Jul 2024 12:59:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] XOR Math Fixups: translation & position
Message-ID: <669039ad9612e_102cc294bf@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1719980933.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1719980933.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:303:87::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 55449c28-4483-4f49-ab36-08dca1e40217
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Fey8fJVj6bbMJiiVLIv544cXT+u/50PEA2zrH8c4MLASQY0o0RBtQeIsxme?=
 =?us-ascii?Q?OmNHydQ06Ezmy5PyiJFzVAiSvS2pPmUtgds/mYKMBq47qxJs4G/xlugMXMK1?=
 =?us-ascii?Q?mzwYLaaQEsGj7PL8+GJKvhVnm2km1IBW5u5vxD2eUGFG/u3ksv/QUiLIT+Mg?=
 =?us-ascii?Q?5t2CejW1xLNULFLQKahG+6yDarz3LCp7PbjfOPWG9+PPNk0n4Q/CoKAnqpEy?=
 =?us-ascii?Q?s4v4PiD0vX/f76YMHBvGoVw288TAbhYEqGHA3E29sH+15soomu8FIjpwjZPm?=
 =?us-ascii?Q?vD0GrmiMlU0ed7MG9Tcj+NByU518caxc/ehG0cs58HBAEYNA3n/KNak245VP?=
 =?us-ascii?Q?31BDC2x1P5/96JLc1Bl3qL5ftJ1tRJMdnP5pq/HbyZbwp8Ectt/yPzq72bAm?=
 =?us-ascii?Q?Yi18JyKPhcjANFyopGB3dv5oO72c+vWjDq0uAOic+Z9wWvFz/aItPfxYZ2IY?=
 =?us-ascii?Q?xezfvGM6ryz9UDwWmvtnuKYSxPJnDUOBj9AYAf3w3wDpoIdbnrF+BYMqhvh4?=
 =?us-ascii?Q?yA/ui8n7xDbrfBm+Gh8ygIdFsTL8SP7WPN1NPqQjDrWDHId7+1hlsTqEWYp5?=
 =?us-ascii?Q?MXy7paGkI2CzPCnx+ZyXcJpkiL59gAsdjEjX6p64s16YIDFZ1dsXDyJVx32L?=
 =?us-ascii?Q?iIC2SQeY6ITNSribBIRr8c/c9E7klFKE/sK/nZ05GCwACayoP33XM72UGa2P?=
 =?us-ascii?Q?eNMhAh9ZCFFbHXPl2al50I1Ri8GNtWDu8cyxRNBD7ixrw6Yk9FPnhmBZ28/5?=
 =?us-ascii?Q?V36RTgQ4rjtWM8A/tVtXR28yRICWVKeOO2XzOvghdfPxcRh5blJlw/XN13p5?=
 =?us-ascii?Q?ncSf5DarlTjKlGvwakHlv6XrM+OIwJuKLASnIH7F47/gxUm7PeRHNiehN4V2?=
 =?us-ascii?Q?3Zf+qTJuBnVJd5a9WvDpbuLLc9OK2luWo/L5fVe8fIQVHSOwCCpKIJs9Jk8t?=
 =?us-ascii?Q?QdhBzCX7cXZS0Ejw3ezACMgHVZ7KULAE34ji48m1lSaRFFMTfNUMHYRlGXYg?=
 =?us-ascii?Q?qHfdpl2BQ5aVf2IVDcJG4c/a3SbVXntimp+Em/MNNIt72TAFVppWGx7VicTC?=
 =?us-ascii?Q?rCq1IcqGCjEWGmJ+LtmKQIqtvlWlCe/JUR9eBfNbKCxWZQu6gLuEcn/RMbAJ?=
 =?us-ascii?Q?0KC9hJFUc8Py0qL3zMoQBmN/7TGRDh8yRDQe3YKnb/fpIeBR43motUCCabdn?=
 =?us-ascii?Q?CefPO12ETBjnXH1rff1uGqu5Bx3RDeO5lZY38+CLV+Cr7bHLEDfO75zBpZqt?=
 =?us-ascii?Q?/ckr129B9LC+EsC4VvyiJAMvz+00vPIkLFcejTop7mk2NgZ8INnIiAphYx8R?=
 =?us-ascii?Q?sDU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P/dJvzwqe+fxCiBT33WK9Dsljsa/EbTDYnbvHvbQGmhrX9oRf1/tBZtnOTRq?=
 =?us-ascii?Q?rbm8yer82yr8uSzkdMm/2FZPeH+0b75/4ORvnIUaHXiuCLS/i5JwVGqeYS5+?=
 =?us-ascii?Q?mePUyFVYyiGOW/YH/P7z3iHWW7s1eDG3jWvqM/bqOG65opXYoh5tYZkCkcx3?=
 =?us-ascii?Q?2fcmvedJ0XAdd3z8FeMqAnbD/rlFLderPddCEdQ5+RNZ43z4L6tLk4GsETkX?=
 =?us-ascii?Q?Y5AuWf3GoeKT9T0+1O6/Y7U4mqHUqrMt9kuzLbyD/LFM0jZbORTmkfCV99c0?=
 =?us-ascii?Q?QQb7YySStJGMe7g9ToEFSiItG4ycYymtilqENrP8F++fWWXNVZ5jpU+9AP90?=
 =?us-ascii?Q?M3T0v0wTxZFmJn9i3ZfNm026iA0+K3JwMPpJQA0Sg4PveILXscTfcvwVHSqd?=
 =?us-ascii?Q?WNmXri351exo0jJ96X/Gzt1mzaY7IwgEQYZOyD3zKtrCw6EaUr7lyD5K3m+d?=
 =?us-ascii?Q?JspawbXTvhzawRBKfV4xJoVw7rC8o5OLxTWpirUn6nlKn/ixviT7NUGMwWdb?=
 =?us-ascii?Q?3vwms0TNkcCk8MjzrcUHKwiMw1vZ1dr+biFoaH4xUwjt1U3PL4AplzqcUGR3?=
 =?us-ascii?Q?yVFWc9vvEoKin3Ce1DFIwlk3+kViBoooC7ACQLlhsXyTm4OgWn8tXF2vKh+W?=
 =?us-ascii?Q?exOX5ReBHhkFXEEiV8mkcI8q3d40Onsf0lEOoPShj8vJU5eBTMjoGPqTeWDV?=
 =?us-ascii?Q?8rKmCG9UZAzQ3abxAtlqENhcLr7YuA2yqix0Lbm2My2RGSFGeQHt5Y5bPugU?=
 =?us-ascii?Q?QSSW11BnB3qIkrgaQPFpMcmJHP552AIUELi9I0azWYsBSSUgOlkhb0yizJjm?=
 =?us-ascii?Q?kxyrCWdUpj2KxhVRKcbkA4CEfRQzZbd4ZYcomcu55eXTpSrM+lxy4XEk6+C8?=
 =?us-ascii?Q?xhQJqH3ZqFAHfphz31DuhZg4YQy2JMJOo43Gxakv/Ta6MVR9DObyNpu1Habs?=
 =?us-ascii?Q?YXZswbPI35zeqe3uklZjrVHdZRaj3MP9ijb7coi2os/wkXYxJPx8oFUd7SIB?=
 =?us-ascii?Q?5XAUiygQmp5sNQvIWbCcdTfbOpNTQ/eSUQ806voULGXhM0TDDJ0b529UCtEq?=
 =?us-ascii?Q?9vcSFrKVyxGtmBiI0lfRcXEkcatKqVdnYzoPKOREC940jvl2czevdUwrlRRW?=
 =?us-ascii?Q?v7T0p1AEqxmqVq312O0jWVG1diKfNdQWMMKu3aDOZ2viVl2lkTX8FyP3d4Tv?=
 =?us-ascii?Q?404jkjxo2z4R9d4OXmZXkNSnKibOanCjwOQyesmekJC5NiJzNSsV/xWlU4Bj?=
 =?us-ascii?Q?RUCFCQPbeyFgOec96R2Eeq9EWRkKF5/1bU8stM4UjEI8evgji8Bskr/7hBhx?=
 =?us-ascii?Q?s0pJedw8Axs7vzgbTh4Ie/hHgOshLVAuM3I9q6SQrtc/CyvBUmFDLUvE/GOX?=
 =?us-ascii?Q?tb7SX9oeKrC2Nm2sW9HK2GR1OqGaABs3LWb4Pjf8P+kMiVlL6hZzxvxDpQde?=
 =?us-ascii?Q?rcb0hEVtRXh6mnJiLEDud6HOY/Cm5T0DMTylANCzj7xFAok6S83UMk8bUyoI?=
 =?us-ascii?Q?3jzgyd4koKF+sRMKpHlycNvo8toTWpDgXR/uk/rxp6vHjT09TOueEZbyxi7l?=
 =?us-ascii?Q?4sKhHqnCag9JsSFE04wJ5+yjQiO/XpnZWwh/LgZZJ4p/b3TYrfhYUfXfw2Ou?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55449c28-4483-4f49-ab36-08dca1e40217
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 19:59:44.1807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxY/Z9HtEEvGJbZKEawktdh7daCgmsDuWeq+S00d/VE/weREN5FCJPg0nvDjSHC6riyPRWVMuMHmdRfmVy+oXfL7mmkM9vM3BbwpgErVkh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7186
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Dropped tags on Patch 2 due to changes. Please Tag again.

Short of obvious cases where the approach is unrecognizable from the
previous version, I would say always include tags with a "please holler
if you disagree" explanation as to why someone might want to withdraw
their previous tag. Email communication is already lossy enough without
constant revalidation.

Otherwise, if you do ask for re-tag then please explain why you think
the old tag is invalidated. I.e. I could have acked your explanation and
trusted that description here rather then go re-review patch 2.

> 
> Changes in v4:
> - Patch 1: Updated commit msg/log 
>   The name tidy-ups eventually led to a 'fold' not a 'rename'
> - Patch 2: Rename the root decoder callback hpa_to_spa (Dan)
> - Patch 2: Remove hpa_to_spa as a param to cxl_root_decoder_alloc()
> - Patch 2: Add code comment that chunk check is modulo only (Fabio)
> - Patch 2: Add lore link to unit test in commit log (Fabio)
> - Cover Letter: Add an introduction (Dan)
> 
> Link to v3:
> https://lore.kernel.org/cover.1719275633.git.alison.schofield@intel.com/
> 
> 
> Begin cover letter:
> 
> XOR Math Fixups are presented for both translation and position.
> 
> Translation:
> The CXL driver intends to report DPAs and their SPA translation in

s/intends/has a responsibility/, right?

Don't fix this up with a re-post, but for anyone new to this patchset
they should know that RAS is one the main reasons to have OS awareness
of CXL at all. If address translation is broken a fundamental reason for
the driver to even exist is broken.  So "intends" undersells how core
this functionality is to even having a CXL subsystem in the kernel.

> the TRACE logs for CXL poison, general_media, and dram events. It
> is actually only logging the HPA, not the SPA. That works for CXL
> decodes using typical MODULO arithmetic where HPA==SPA, but not for
> XOR decodes. The driver needs to restore the XOR'd bits in order to
> get to the SPA and it doesn't. This means that address translations
> for root decoders using XOR maps are wrong.
> 
> Specifically regions that interleave across 2,4,6,8,12, or 16 host
> bridges are affected. Interleaves using 1 or 3 host bridges, even if
> configured with XOR Arithmetic, do not use xormaps, and are safe.
> 
> Aside from knowing that any address translation of a 1 or 3 way host
> bridge interleave is correct no matter the decode (XOR or MODULO),
> all others are suspect because the decode is actually transparent to
> users.
> 
> Position:
> The position part of this patchset came from the discovery that
> the driver doesn't need to calculate a targets position in a region
> interleave set. The BIOS sets the target list and the driver can
> simply use that order.

Thanks for this writeup and the insight about XOR vs 1 or 3 way
interleaves.

May I ask that you incorporate this useful bit of prose as a kdoc for
cxl_dpa_to_hpa()? This can be a follow-on patch, no need to respin this
set again. Otherwise this gets lost to the sands of time where only
someone savvy enough to do the lore archive search will see it.
