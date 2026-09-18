Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93143A48C5
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766309; cv=fail; b=ChJmRzsLgnX+5zBYlEhRuxuDb7R0fV4IoPoEOt/5g5H2w7zvRjkxkazVvme13SfdWwJrIvjbRxDYlkIbr3/fT01hXNIhl1poNZ70W9C2hqViIhlRnVOeH/4A35woBOuPWqjb1SHl5Thiuw1itjzsUk3TtB1k0IPiXn2Mot0LDQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766309; c=relaxed/simple;
	bh=5xpWilD3M+RmAXfbApNnxGRyKUvtp9nUBR8fAWQze5I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oHBZgyLzYMri4lmchu1SvE19ZPve2NFFZDDZq5c3oSS95EKGKaKWjYJG/Kyn8quOT1JQw6Qj9axS7rLMrASkSchVlPjN6S+SogQ7ys2Uf/l67aUTyDDDhPQ7O/WY9BUKTAbW8bUv4NmsF0mcwTkxqdZNX/r11V0n9ug8h0kSo7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8RHsJyb; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8RHsJyb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789766308; x=1821302308;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5xpWilD3M+RmAXfbApNnxGRyKUvtp9nUBR8fAWQze5I=;
  b=B8RHsJybNDlxDcgK1nSvM9qUCpFQUVRvbbzUjaN9MkJhwimRN575RywO
   AxOV6QWlhocJdmMMYcdgs4dsyl39v+l9biY/RbdxWIGqI53Ster7IZgo/
   WvtjhzBlospvUiNJ1IzmZVZtpv2Bf7imyeJbxADlU+IbcZxORET/82qsM
   MwUNaonMr2vXyWU5HuY/JMdcAvKGM3xTJ8fqC6937Un21X3rpG6JzGDnt
   ErEH0fCk9YIClB1vl8OASBnGkuDl8lsfbDl+HtAv6MVkZw+w5JFLA6ETV
   JNovlJoCQSrGzjTE2RNns5pi2ea0jbuFrNWEXplTsGQ+7SN3DG+uHlhGC
   Q==;
X-CSE-ConnectionGUID: aGyscCO3SpyEo4fqrIM54Q==
X-CSE-MsgGUID: a/I3fAdQSLWErmOUlsTJSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="101649291"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="101649291"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 14:18:27 -0700
X-CSE-ConnectionGUID: qs+NHL6iQ6ur8xBSFBazbQ==
X-CSE-MsgGUID: HRhafbmXT8a5yNe3Bh9pcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="276547834"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 14:18:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 14:18:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 14:18:26 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 14:18:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAGAw6qeq6qRa2Ak7/003ZufW3UuTkrFVjRwU8NxmYHJRYkUWoZQzkXAQghO6roIQl8DuGUZiYn4y8H8wrqZZym4Jv88wxin3So67q53z4AieCVfPU343VTP3Zkx/cRCmLASSR9dMeLev5NlAjSQfJ/wra3YF/vy+PIFT3R8p2q7ZEXXTVYpNDO577F1htGuXl5oOu7IpiVJFpRmXF36L2b3j/2YqaVlmapia2JsZfisq2GOZmykH6lAGGsg8BO2nuJZ4J40MfvJgvB+9nFRrj+NY3dI5l8DRQNyPuwPNCmBpoTXFD3bPs/VlA7a9bBwn3ohtEdHbD2M9HhkmNUBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXJzDx14sLmbHFxmlYjghvRzanGX4+YvGd1CND29NBg=;
 b=e4XWGqmWNSPT2EX7yOEmvfsOJXoNXqqBF7evRCbys94EYEU9ifX1/GcG/7EX7YJriYED1cMjR3iP3mYtQfMzJd/yidtxtiIblxep2+BpTB+7OBa1Pe7bUfNyo3rt6SmM1tH3H1LoHkEljzaLyfLupw6CFikY4jKX15bcL4E63M+pk/U+NDcbC1FizwwVdQFmGxAvJtsPLOykBYTdF55zfRg8NqTdvz7hs7zbF5PZEZbTlP1s1lBiL3CCnvhky8tc69kf/3PXgeUGUx8QetWB148re7+desZGftw6pRivTnF3IPXJgmOblAWLNu6U2ED5BXjgmpvpxBb3cb3b6K+5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 21:18:17 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 21:18:17 +0000
Date: Fri, 18 Sep 2026 14:18:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/7] cxl/region: Warn on user region position mismatch
Message-ID: <aq2qlauyD3qSosT8@aschofie-mobl2.lan>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <1d662e3ea78ec8b05fceb500f04e69ee9f6d4a72.1788475206.git.alison.schofield@intel.com>
 <aqqF98W7MnnDTTet@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqqF98W7MnnDTTet@rric.localdomain>
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aadc609-8c14-4295-de5e-08df15ca5b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|6133799003|56012099006|4143699003|11063799006|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: WOFnz74MiXuR/mN54VqolcF+iZI9j/LsFAw3AJnCt91JFCNHIUNN85Mn+sDNqrpmbozoYGXwUD+fJasIPS8S4sRqH/ulgfgKgbSEzJxRVwqN0yUb/rZH+T6zxFeqSDTJIROnwcMbAq+oSB3Yt5re9TS/0TKFXnDWqoqk+3qzrSu2X9+zgSMc4YlRe6Lz12dAnyPWg1yle08kXJe1taTY5Tqmkjg3w+b8e0GIFqQ2aGbiODQn8D0x+suU4D7QFIX8amGnfpqu5nEALeMYNMsAw1zDwTj7M0bohdGy03p+L8cKi6ajc1xTT5OHy/pBS0q7lQnHR133Wjt5ossZ9o+xATurIUAvVsKKhmhWdaev/7+sonYF6qOzQsFgWvFtUQHvK64QfNSErBJCigd3P37iAsLhKABJt+FVizI7dKd5MwEPJzaVNl9morkfAazrczdzWmOf/by78Boi+44JtZmtL0D4BJD+sV5RgqdTVaHoIVj9TitBwthzOR/yD/3bTliAGRbQPn6At9ZEUlU9N1l1TNuI8g4Ku0D7zhUdrX7TS2sLx5p2J2z1KcHVFek8HCSMxO4zL2nFDXxj3QKk9Jb7DaBGDE7J9v8N/Hu66imsIS5EBC/dKHA6xtxPGQyBs+QEhSJdXVTGJ14LFZpek8z2YHU3sj7z3S4wQDcRrosaEh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?inAMkPAPtbx2yO3m1pIpzZg4PzmG6y41IC++wCDtyx/KZIZT80BHTKepQrgT?=
 =?us-ascii?Q?U1CZUvZ1yhZwRQ8Ko2IHXJ3TxpKC9I9oEGPch4DkRTsJr1e6GSnaIZfAg+7b?=
 =?us-ascii?Q?fk7gse8VA5xhHoayEFKABUMQXh80Z2+c8vPVTIodHGHHf9+esRzYHd5T+VHE?=
 =?us-ascii?Q?Pc64MNgO1hgOA8I6ryqnxSMvzVQw4P31SWelxHPpQsBL/uo2FbOBthY0CKuy?=
 =?us-ascii?Q?2PtBFN8BaBsUt6S8FJe1rM39j03kWgjbtiVsR8kWsJXRClEsUa6DSxNtz6cf?=
 =?us-ascii?Q?/Oou343ThKi4STUfU687wrMnnuR2/tRTyNhntpzx4Iyc/wCGh0ACNaozm7bB?=
 =?us-ascii?Q?NCWSFH8gnr9074x1lw4F/wBLEFm47bZGlzTWhJwe7x4PLU7lhWfdAIrs1X0+?=
 =?us-ascii?Q?v7uq+19ugOX6cneQxew3aAZgF6GDgy4d2hKtz8grZajEVdczMkzXwq/Hr8tl?=
 =?us-ascii?Q?fvWKPtL7MZvIihIaRo2UJSq2c9CRC5r3ZudsOp2bwCmpuvjZp26bLFDWa3IU?=
 =?us-ascii?Q?Jt7cjAU/50w0NmzLqtQHO1ScgyDeUbBvYFRdsSczOIcPnmfkTKyxllubJkvx?=
 =?us-ascii?Q?WTKPt3tQlmyvZHl3HhFxZoHbSDQmhFV2LS4E4zZHygKQ+nVMNSRoA/JV2n4E?=
 =?us-ascii?Q?n0/Jrj4FuxBtNe6YmKF3+EUpndefDBcxMQbLhriylqE0ZE+9tM9fDqQOIOhs?=
 =?us-ascii?Q?743wvWM3TGqU/ljqqoBZ39D0JIwu3RGXZmeB6meiRO+CKJN/g1VFocMH4ACk?=
 =?us-ascii?Q?K4jEXgiOVSJJrk9ro6j7mgWhLMo6yX64uHjV6anwznQOuqU8FOUM7CwP4Fof?=
 =?us-ascii?Q?h9gE1QcHYcfLvKbeILsB2OVYLdtSd9uguP9hbC8NW0HyAnE2Pmv4ei3d+oHQ?=
 =?us-ascii?Q?VXrsCkSFEo6w6Xx5HJMV6MuLTpNFhJRmuJxjTzFJzCKH6kVkI9EbmPYxtC2e?=
 =?us-ascii?Q?veQGD+mRca7OmaphxM6xo/+1HDgsHmjZ4O4U0c1TCagygVMU161/Lagjze6Y?=
 =?us-ascii?Q?Lzn6SW6fOyGsqTv5jnIm92r6oEvUxgxcxvqzLLymlUHHGBXZpMCJNwYRCQ2w?=
 =?us-ascii?Q?fhva7TP4l+PNNwXLIukqlJy1dDYbhaOObfIb9P13H0D0QEP5Y2y04+y1xg8g?=
 =?us-ascii?Q?gnGzEkYLMYmaVIK2b3MQ+xIBBEF2WwbV6oyxV6wC2XB/KRqZgxK1fwgTX5/y?=
 =?us-ascii?Q?xsj3wZwvZu43LGSfCuO4MuDPtIYwyVJtdiwRx3gv0OAOpds4Ha2rc34c7u2G?=
 =?us-ascii?Q?nzRfqCGnkf4IlxNSvGbZb1ltwCvXfp+95cp1+xWxtMoa6jh4LCgh+z1/QfqM?=
 =?us-ascii?Q?NkMQKb9WfHAP+ocFClL+AZdtp/0OKxHfOIHbuF7+Wu9L4BJf8Z7yCHVXoUS9?=
 =?us-ascii?Q?CEmfzEZdCk44EntTyVMVnNG7xqPD5ov8ul2dqOGqz2FPIcp50Md3a1CLSLi/?=
 =?us-ascii?Q?YI6eEy7DSuPw5EO00SpZ6jAyZv3sVHEQsuukiNoNglbPsnDlRjBdOCgOkzwL?=
 =?us-ascii?Q?imj1eyR/UsvgMbYzXUTko71bWzdkZsIVMPDCHKdEKpQD6FSbQ4lUF648qVBa?=
 =?us-ascii?Q?nJ8jgsTG+yi0LrzEtes1H3MNVX9v8dlgT9cAdQqBGe9zK7aCUikdJ94v6xy9?=
 =?us-ascii?Q?1V9heHq0L3VM1n059fDBeuZwgRC/8eVuXhR9+oFFuUZcpyWq+TURtOiZjT5j?=
 =?us-ascii?Q?bYJIkRUShYPmgdV87O1i0NoFBGxtuZPApHtp/CzRQSL81mYdxsUGyaLIAk0k?=
 =?us-ascii?Q?U7DYjoLVagrpTYxuWBIc6jHj3RoOTEY=3D?=
X-Exchange-RoutingPolicyChecked: 51JZhfG6DBhQmeVMOZhdLdfm1dAWR/TVy5VNEMMMnH8xi3bIpi2r4pfyOYPu2BemZk5MzfTB4lsD5R6SfWlN4cXJ9XlGrwrbDX5H2p95ftURI9nN19GrwjNbadb+2pERTsJwYgUNHJKrctcgGRB1DdOoYTWcNJb1VKH+pkuGyEQ0WPGgSHeRwTMMAxBYt0LU5ncw2BiJilekIQRXQ4XH6YyoF+Kw3tqvOvcGtH1rzxQlqG2fpTD6X2uBoC+Ndjkc5yr+HasMm471ByHfekJb7L54pm0uGE+EUwNmWuenhz0tmZ6piNrkr28Gx0OKOksw9v2LJrXudFlV8GDJlpFeOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aadc609-8c14-4295-de5e-08df15ca5b73
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 21:18:17.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OifDmA27gKtbmNuHRwLvW0vrZHKkSACnysBwj2H5mBoAFfaCHA5VSJYw1GQcQ44LXD2t1UM5eTIRcSIWy7GnusWZVCuvdp/0I2zzSc9ZTlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6462
X-OriginatorOrg: intel.com

On Wed, Sep 16, 2026 at 02:05:11PM +0200, Robert Richter wrote:
> On 03.09.26 16:23:44, Alison Schofield wrote:
> > User region creation includes a self-test that checks the assigned endpoint
> > positions against the position calculation used by auto region creation.
> > The result, matching or not, is reported with dev_dbg().
> 
> As commented to the doc, the position is clearly defined as the bit
> mask that is striped off by the endpoint. That should be documented in
> the code to describe, what position means in that context, esp. how
> the position in the target list of each level adds to the position.
> That clarity is missing.


Agreed that position could use a clearer definition. Patch 3 updates the
cxl_calc_interleave_pos() documentation, so I'll address this there in v6,
along with the documentation changes discussed in patch 1

-- Alison

> 
> > 
> > Promote that to a dev_warn() that fires only on a mismatch, so bugs in the
> > auto region position calculation are easier to catch as that calculation is
> > extended to support more region configurations.
> 
> dev_warn() change looks good to me.
> 
> > 
> > The matching case no longer prints, so dynamic debug on region.c no longer
> > confirms that the self-test ran.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> Reviewed-by: Robert Richter <rrichter@amd.com>
