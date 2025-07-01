Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAB220F23
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402473; cv=fail; b=lpJdYk7RyQMXccaGe3xu1mQ0rV2BKDOG/iLQBFElpIk3QBBbMI842e6yscG2wSZoApQBZnNMfypOyemRqG+dj4a8YGgaCkaE29iHdoom+mXuAIrXy7v16sQaqGR3OIKrwPbewQg28d2yAAK6cCEpgBfz1wd0VlPiOwhylDnvlVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402473; c=relaxed/simple;
	bh=q00jRBnb38xTCgEsqlAWS359gPnFA+qTDJYR5aEvk+8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=egcV9TIQ/yL8lJYadCifahpWdEzf2pb4yfH/5g4zYacQn0AiiZGsJ91PW6A150eFcHYKjsKxUeStVMU4r9mHTmfGcqOGtNGfPturEQVPkZoDpUEW2Ow/RSjPg0wv8B3LX3eVTDFAm41Chw19S6ECbe28b6qTmIqwdAvKfTpcG/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctuKpP3t; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctuKpP3t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751402471; x=1782938471;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q00jRBnb38xTCgEsqlAWS359gPnFA+qTDJYR5aEvk+8=;
  b=ctuKpP3tJiQcnMmrOfdwUMXEq4ETe+MQygp+gr1v0nbF4aklWODuDaP4
   mzirti4Ep9YExMAYge70zjdoq0bd2hya8F2VKFTM7qPreKDp0moHUfcoq
   ViOvvFl+TRb9eEM0Nyyj1eSq5jP6J88uT9rHjZVWktxHq96sTcUxBO84B
   PWT1hd7cvfVblpyjXN5H/idVJlkqh/vkzmqfg89voQhDcPlmNL74hBcYG
   f6VA0jne0r2AISY7L8c0ThCAvYmodKsWy3rbDS0qv9eP3Jy0e2RnSawQU
   AHUjHh/+AaseWb29EXVwIPb6s0E0m4y9tt/fF9wU/wNlEPd4GOIXRFlRE
   A==;
X-CSE-ConnectionGUID: 9u+BqfHqTNWbRnvWe3S9uw==
X-CSE-MsgGUID: n3pr/EptSXyt6DI7hzq4MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53774492"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53774492"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 13:41:11 -0700
X-CSE-ConnectionGUID: FljnlSt/QqSyOiuZLh525w==
X-CSE-MsgGUID: hcWbiDbaSHGMwJqxw31R1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="184917105"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 13:41:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 13:41:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 13:41:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.87) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 13:41:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWbtvwaujCdgy3acfMIfn934u1/GFak9wjHJwQ3l7y81sSk5we849OhxwB7fuQWFz7wm3mM5hayC5eMGgib7lFN85K4Z/EURrR6bUz/MegavaBdtr1pDp7zi2076CQYmN25RQgqaYKmVHLFS4c1eGMkuhpD/CCiN9cKxh18fPDnczeNCaZX9qlsPVuD6W6c2XKNvAAiCj2/AOidBYhmfbKSDPwsW4TW7NhvO2jZUV+u8Pdx4JeKb8B1c9HC6nQNIKy2BO1/fCYHI/VCMxT86jvwginrWnQqvRXCzwgdc2Pq6g9N0WcKS1ZmyIAY8pyGNB7lMp7rgJTi+jp0Soztb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XNqTpYuX683bGy0Tw1zbFRnaK8k/h3NDeZhBL/Ap6Q=;
 b=X8OsOsWkGf5Tlsr5t2HBA95fuDljsx6UtaS3h4Pgv9P1LYWXzxje7ib6+NYYYc1GF36jOJnS43YcBOrchdJioaGDUttAU7prMVW/ib4ghkt+ehg2vD4nqszKYtmfzhNztzOwcbzTSy95bP5oGtPidjr06VTqBSCjdmqJ0xRQPqghF+0z9mK9MbVM7K2LXxTGe+AdMrW1BdKTIDI6D1DS3nnNaIxmCC+bUZ6WtgvymA+P5t9MWW0arbK5lyzzAvlt30EnULD/EwzRmzD8wA1kREBDhXomwPUbDzHikzRFbrETb6PSjgDJ4r8dx0z5JYYUhbWSFgXjl0o9q/ZbA/lY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 20:40:26 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Tue, 1 Jul 2025
 20:40:20 +0000
Date: Tue, 1 Jul 2025 13:40:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/region: Introduce HPA to DPA address translation
Message-ID: <aGRHsBjCxfaYJX_Q@aschofie-mobl2.lan>
References: <cover.1750725512.git.alison.schofield@intel.com>
 <4c4a1a52a4651b726ef66d9020e71e731b74cb5d.1750725512.git.alison.schofield@intel.com>
 <20250624152716.00004c0c@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250624152716.00004c0c@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 0477e036-1cd4-41cd-83b4-08ddb8df7e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QDV3Rc1t80TI9WYxM8IiZH+iw4+rV5hZU7IUj35ZlbaF2vLw8kXXNiOMR6nb?=
 =?us-ascii?Q?c5rz++jLgC+gdfgBnm/KsB9yGMtTBlKiwfvx4ksiRNj9y8KzEo0oZkHq0qc2?=
 =?us-ascii?Q?TODgJYQYwMYV3ur6DCKHDkmyL19TETZ63PKByB9AbKk4UqGmQ1/yTaKUK0WT?=
 =?us-ascii?Q?Y9kMx/QWMU+w4cXh/YIUbUOdmti3n54Qqu1M9QQevScLxYeuTqKL1j9TIFk4?=
 =?us-ascii?Q?6P8t0QMgbFDcz31DJUQfcLA+8htmZ3ra7dqOoNWebs54AUf8IVI2kADl8zSp?=
 =?us-ascii?Q?pL2CnnzU59H2WYiI7hx4vV3OTJbdX/d+MZ73vT/50MJ+1algHBUR5h7K3MTv?=
 =?us-ascii?Q?bR/aHimzdInRu+CwDgkpzgSlmXAVLhXytC56mDFU5i/9f+PJ5VF+mbatixF5?=
 =?us-ascii?Q?B3pZPupxhXhwCGisCd/WyJd2bVmorH7eTchkI0Bb6YvAzEjQYx4xDtzUg8Wj?=
 =?us-ascii?Q?zXBf/5OFI3XGt+qxwCgNo5a4ZczTp+o+JivJl+yo0+P4lbREcsxLYqXfyhyP?=
 =?us-ascii?Q?+pXVq7GkKWnRwnnLPKIZ2ssp/LMIYj1cuao8IIDPw33dowrZPS3YBVJf3nGX?=
 =?us-ascii?Q?kALEGT++JZXJG/9bSP97zPO6EjpqbuCP6hw7U9HJ4eupPBY8dos41sPwlamm?=
 =?us-ascii?Q?kDguTZB90gCmyogcBGRCfy4eX12RtSniGWerQ/ZGn+c9BoBBLRrO5LoM9T+O?=
 =?us-ascii?Q?KVcgxXd04HcHJFRxXafp/lrurMwOcJ9kET6OWGEN62Pf/k0o/fMyuzY2TzPU?=
 =?us-ascii?Q?OQNde+8IwFtx9biKZ/xeCz9pHDFiIaLgJq0rRPiQIMZQCrsK99SDAjSpKpLq?=
 =?us-ascii?Q?7jUt98hhm8JeVE7ATQiBYfcIXnu0tZRdKHcUbjURstP4Ti07AZBrRyjXr2G3?=
 =?us-ascii?Q?wpLKypGemNSLLDgSR72zkg5G2r+8CXymlRr6TTSV0lLI6T6Rtq22kgA/Hb9i?=
 =?us-ascii?Q?XhLQrlqM6Qb1Gn0XRFM8oFSFnx8BH1qtVoKsM1OA+dTppbCnNxJ5WdGjCISc?=
 =?us-ascii?Q?k6tJkKE3swiXGusYn3Bo6gq+eEUuzU8IjWhU8mlcY2IDYZnn8PZqhaCyrb8B?=
 =?us-ascii?Q?Ni5zgb1YC1Vc5j2EznTER+849+0i7VF4Wga8Cu/dPHNQplRvXrMf1zP+dMFa?=
 =?us-ascii?Q?bJpD6UZEsoou+3SN45vD+UjRvfgSmu+Jap2LGrL/MZtJYxkFFvPqNnE6EDkU?=
 =?us-ascii?Q?y9bG4NWD/KjKb0tdHatecZ+3BL3mn53QLN1DjzTyx83d7UyAmxPrV4vXwgWK?=
 =?us-ascii?Q?cLN44VDWAG1VcYKKs2AptKBOPY61GPCYwLXMGBvQu2vOrmAiIoKehnJ7M/vx?=
 =?us-ascii?Q?QOtc2g562QgeUuNQLV5NEHgHZNwpVf+npBzedJ1eD0/E7hIJugLmHxbfyDEL?=
 =?us-ascii?Q?D/TqpL1h6dRxpBwgZlh+7SlAlqrc6umbGsjWdRJFpezOUvy7ZLLuCP/gFhgE?=
 =?us-ascii?Q?qcaUd5wKibw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a+G3LWnYapUDZQAYhUoBE2CrXY2DjPDrQrEt5yHbJ9BRktFkFqAXgGa6Jqph?=
 =?us-ascii?Q?egVK2LfIPAWmrWdw/t0QNh523Y0PYub5YVSKr4KYvi2kelGy3VtauBs5bvl5?=
 =?us-ascii?Q?vauyNR04dZ2M0RDzA8NtE54WJILHmW4+x09ou6275MNZZ108Iaqycf7kWZqd?=
 =?us-ascii?Q?psVr9XoT8pwg0rya/jUjaDP6jayUhNqs0GsjlwkcgVArp1zSLRgc838d4tLL?=
 =?us-ascii?Q?QlYXRvB4d4ChPbE+6E1UHZteRPxSs5fIMjr99YlZM0njE4fkmpj/lTLcCMzd?=
 =?us-ascii?Q?UHCeahy9SVenD56Cr1brzHIyQR44jMaQb8GKppQobqao2oQDrpaUKZ/JHguZ?=
 =?us-ascii?Q?sLESS90p+7qMymlnJptc1JZRyG1EP4pj2+IUe+mipyQd7wYrLMwJbOMIn0+B?=
 =?us-ascii?Q?i881aKD5JxCuy1EpBnaVSlDEeDWhunpE1HdgjireUch4p2HD72ARMd6KAm0/?=
 =?us-ascii?Q?7vKIsiBLQDb9o/s6GHMS+RQHqKLav6YjyfKyUWyF2hl3c/RB0/+S79juz6QW?=
 =?us-ascii?Q?pMAClwJtt8gFobjaslAgv8uyf+hr+N0FvfbuVP0SHih9WZ9H756pZcnADaI+?=
 =?us-ascii?Q?TTjWHO6QPqALTIhagb7a86Trqm8b9pEVVLHPX4REBPO0qDn+DNFaBSuwgRL3?=
 =?us-ascii?Q?w/MLD338x0yvTxPsgJCNvt+5ya8ZrRKAqKhAWP9RO+crfwrwEwg0o+5pu/TJ?=
 =?us-ascii?Q?EQVz4vJpl4j6FJNQOsU/4csAY6m33y1nYtD33T5uA5k8RqNGrGHrv1Eta3Pj?=
 =?us-ascii?Q?OlYx3JjLoRhAWk5/SHYlyU2TswQn7oEkIAzzwz3V4hOJDTK6zmTBgxJ83ynO?=
 =?us-ascii?Q?ojx6WnAm2oVqUFClmK5+pmj+c4+x2uWg1fZ96G9A0UrtBVp+mDPQ5H9CvuHi?=
 =?us-ascii?Q?iat2JWtDvDeiw5Hxwp+6WXb/sPwmW4Mq416g+5hrTUGvegGZXhqF0fCTgdOE?=
 =?us-ascii?Q?+PzItC3gUU1AqJuIV/6gsi/Eti/aIHHNUswvolMwT/4zNbg3DPQYacZLt3iW?=
 =?us-ascii?Q?O9/hCowPpw5H+cJo3eFpcMkrNChPT52FzqlObBJwqs5knHURQ71431sZnTfZ?=
 =?us-ascii?Q?nb3Un2N++3fq1KcsK8nNp9Vp+SAyK93jISg5K9JgXwMoBX1wvYu9S9vn7XnG?=
 =?us-ascii?Q?XgOgVGlYX2xK5qBTpxzlaTWOUOXac7omHAsNYCNDLthSH1HmHgbRJD6JLu3E?=
 =?us-ascii?Q?bLcHZnS7KexUKA+er8gNCTx7o8kv1E7danjc7QLWLzousrsWfjF5e0+2t54r?=
 =?us-ascii?Q?bMDEiMHU2YMR9smfFSXjdE4VwQZqjn9sIK3SDnImTa2gnmCyQ3p6Njt5FpgE?=
 =?us-ascii?Q?S+3ZygTGZW/6xKZxU4m6l61/4c9LcFKNY/i5/Bmjz5BNfhR5N9VDH7MPZf0z?=
 =?us-ascii?Q?437bPrHFg93SUv6Slj9yvf90+5rcD8YQdtWpZ46Vb9mLOqZfw48Eq2U9yCNa?=
 =?us-ascii?Q?PUF39B23qgxsa4wlaN3NyEgyXt0reTBAR8QB1JOIskIpxlg8p41QhhgPESSo?=
 =?us-ascii?Q?6UwhyBDHQrqPgWOO/KFkAkOpAv36iInjVTBKhEbKMixplCQ13sjySyTbd2I5?=
 =?us-ascii?Q?Xa9S1pdlFQx5rIH9uBFhlyud9BtJFIK5Ye9rY0T0uoZ9KZJC8uT2u5yH+m+8?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0477e036-1cd4-41cd-83b4-08ddb8df7e9d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 20:40:20.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSqlnLivMdnIpFOB7we5WQVud8MmVhzncHZZSs9gGcAUGVuIlP1sBxevXiu5/lk/E3cWPS1sFTixCu7DqRb6CJFnV3XIJOMkn3pQJeahOj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686
X-OriginatorOrg: intel.com

On Tue, Jun 24, 2025 at 03:27:16PM +0100, Jonathan Cameron wrote:
> On Mon, 23 Jun 2025 17:53:35 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 

snip --

Another response to your review that I cut from previous reply - 

> > +
> > +	ways_to_eiw(p->interleave_ways, &eiw);
> > +	granularity_to_eig(p->interleave_granularity, &eig);
> > +	hpa_offset = hpa - p->res->start;
> 
> Given people will line this code up with cxl_dpa_to_hpa() maybe a
> comment to rule out subtracting cache_size?
> 

In v2 we make sure that the offset is not within the extended linear
cache.  Not sure about a comment here, since I change 'here' in v2.
Please take another look in v2.

