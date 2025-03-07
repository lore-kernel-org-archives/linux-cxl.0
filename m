Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CB183CB0;
	Fri,  7 Mar 2025 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381126; cv=fail; b=MwuD/EoBYtzLy5L6mUEjtqGbm3gLQNby/x8u1p4BrUqgCPPceaj5HOlyZJChm6KjdkgbpEb9ZTy8IZM/vTDbx8BHbalPkADTnmAWu4O/bO76xxXwUccLrIe4OgFvfPy49laxMyFWFu9Ll4rMXc0TZPLF/OtzwAe2cwruhBnsoVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381126; c=relaxed/simple;
	bh=9FEGiwS94NHSi65R6OTAQZXupTJuQo9tRnp/yfZuxuk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qARMO9AlxT5zcEDafMLl+UvtJYKxeBkeNNb0VUrISrZ6qd0BjDpf6gg4a7PpmwIy3iXGler7VEleZtENgsyPh/p4J4AiggP3YzfR3P+5DlQv9BzaBSwGzx7E9NfatfLESf8fBCijD4zos7gwDoD2uUa68f7JQAmeWIHlmSmaO0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YH2n/L5I; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YH2n/L5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741381124; x=1772917124;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9FEGiwS94NHSi65R6OTAQZXupTJuQo9tRnp/yfZuxuk=;
  b=YH2n/L5IpVTbh6XCmmr2R3UFPpK6/9bEMefjrp51/s16bHQMcZGKP+z3
   11A0woHeEmG3/ABaSvLFitsW7Q7pvrmdi1B+WSyhZ7J3vWuyPNBxl6uPv
   mMHGfMyebUKBDgxCc2zEim6DAYA0bTp/+lD8fYwhhlrlQOP1LpPCE1+7S
   Sco660UexrE9QoOoR5SScHD94g4GAQ/Fr74UotwSTGW2736ak9PLt6l73
   Mz/IG/KCZxntGOj6qo9+fe3Ur3eQm0OEhxEy2xdrtK39swGv8e6RQm/4J
   JbS99Wg6zF0E1o8FQRbWhnEf/sxNzQqm2Yq2/j6kGVb8+ouvCn9VIOOs/
   w==;
X-CSE-ConnectionGUID: 20/HpzZTS+uyCXuoyVI/xA==
X-CSE-MsgGUID: Ow38Dv1pTdGxr/b0BY4BtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="41697509"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="41697509"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:58:43 -0800
X-CSE-ConnectionGUID: qd24eckfQ+KdK0pJ5Dgy5Q==
X-CSE-MsgGUID: tPZNGc1zSaeZ30GFbq+h3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119413733"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:58:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 12:58:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 12:58:43 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 12:58:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFPDWC1fqapbLXU9g+m79GbnqcTqx15agjziAcNi5rMC7Z+yYw1LUepLINKtoOcwzvlTQMj8LN2xOu85AGcL1Zr24Okl9YHY4oyC/j1MCFxnNTRMceFnFcGDcsivrJ/mHgkxTe7MOky2bn3EQwiqr7knpo4hJvz5XZgDcfzuhO3Zu/aXbeojiNWIi5zzLus4iM+51iwcn68qRT5b8uGVq/Cfkcjw5D2c32QlC2I8eViUqNrhKiYGegbs2Wa3R0mfY4NKINxoo4S+WyOaeHNCZZ50FpSqmVnDJ1X1M29OSwmIYN0bkg7kzH2jjMwd4tY9Lml6pZu/9NUwgCmHAJMz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAKaSGBkMVAQDiOddeWtaCUOGYJeGM6bMbRKp7ULpUI=;
 b=AlIhHTsdOPsngW6Q8sX9sOOIiM7/BtILHHTrVp9C6nKjcFvdzSmNm21iR8VfKpbixA6h6rL5G02ER6b+DXetOF1XOHjL9oISFRD84qaOmxOw32IygcZYLS0ZOWbwZxBExlthrYpL7La+sVjM/tiFsPSi+YDpygIvqIgJuMcp0zReaWo3U/WCN3LFQKcw0bFHH5x2jECcwsXVDU/wLuNacjv2SfZy3QZN+tRPoi7NL24tOjZwI0A+K3VLBiIJn9hT/fowoh4EHYO6Tv+SGnDyx2vyVP2/0JRpCS7nFSaPu1iLV5QyUza3wif+eynNrAun27lmvXfMgy1wpeGU2BtxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7542.namprd11.prod.outlook.com (2603:10b6:510:28b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 20:58:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:58:22 +0000
Date: Fri, 7 Mar 2025 12:58:19 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH 0/2] cxl/pci: Inactive downstream port handling
Message-ID: <67cb5deba156e_1a7f2948a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250305100123.3077031-1-rrichter@amd.com>
 <67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch>
 <Z8r9cSxdhNyq4bvC@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z8r9cSxdhNyq4bvC@rric.localdomain>
X-ClientProxiedBy: MW4PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:303:84::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: d40eb870-40a5-4d96-d198-08dd5dbacbcc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RtfdB9xSAsz1Phcx0/lqDTNMhLjR6gMC6xHPRNGCzxwk5llNhjFbh05YHtfa?=
 =?us-ascii?Q?/Ciup8xcyJvuwYu4b3OLPMe6FvmIfgLK8tVQqFkISiI3i4FCCHax3c5IWH9H?=
 =?us-ascii?Q?yXtpxAHN2wEhqup/+jVi8Oyr98Tv49hxiQlAFJHpfh3G0aQ6AtOI/gK2kZD+?=
 =?us-ascii?Q?FhBFv1fysYi54nJx78+EltBZVAmWDeu9gYjExu7rebZfv/QJzGx8EkaEvMLu?=
 =?us-ascii?Q?IPnDUr53TckZn8ISBv4Lvrv/d43EAb70Ijdz6AnyciDHodCBM4FADv5zyupy?=
 =?us-ascii?Q?wLVyou/wnO0Y0ctx5nnwW4nmtDJg8JKpY0yN+yFVpYIoir4jZCEbWEdU3fxZ?=
 =?us-ascii?Q?GiTnbY8PKTglK+Q1RzPFbEHyxWqzZvqPdHbPOvZhSrf9z3V6VuJXxnKFo9of?=
 =?us-ascii?Q?xwlSwklVJ6s29/hJgLigylC2JpYegBOwdfNAVWBFdKOF5vzYTzGdn0fzVY6B?=
 =?us-ascii?Q?r/hVktRDI+tFLeenDsBgwVgYlIAO8Apf7BMgn8kuQzemPvQWPLmKBBYNm8qe?=
 =?us-ascii?Q?gt3tBRBayV3Dv9fCF4viu839sr1WLovLaIu8wfnDKD8gSqf0ggklOPq0PQdF?=
 =?us-ascii?Q?BLTvY8FK3X0F4KuZsXkS5L9SVGnJlrRmzTqdHevbGo/fTdslXDmIo4ssnKLg?=
 =?us-ascii?Q?Y3lggVO4TBwcpg8PbYPbMrHi5cDjakKVg6Jc8m74e54QA0chwi1xdQpdhBHc?=
 =?us-ascii?Q?7BGuAgoDKjF6ZXjYbZLhZfoQCJD86o6JSEIXjx9bia/S4RV8tB8hyN2M4eiE?=
 =?us-ascii?Q?QQi/Mh/Eqcqc9UQ9papHJLoVExNGNNho8DMhtXA7JFr3Oc5eQpB+UtNtel5e?=
 =?us-ascii?Q?bWYONGC+0CleoMkOOB6wZPElaqztyBIAZz3SvprAut42yAWW2/ysIL3YoFb3?=
 =?us-ascii?Q?PJ7sWnnydXP+FoNoEBvsLRua9Aj9seH4WX17O7MViFIO89FdNA+Hahkx5+7A?=
 =?us-ascii?Q?ta7M4KWRLknM2SGWliQFf8FwbqMn8cjoDYOp1uk066Lwhv9tGrObK8+WXLc0?=
 =?us-ascii?Q?eHE47g1b26kNo+T3lXvSRN9Of61zrUyXoZEChn+0Ae8Cu/cXX4UnRMoww2NW?=
 =?us-ascii?Q?a8AvtvkgeiTs6ImGRwRNLQS1Tak4xl6G/HwwIOKGe+jV9Pc1kCuJcUmx08wt?=
 =?us-ascii?Q?PjZheThAsgF/UGollhBK/ESviRSt5OPq3LsgadVgqobvykqPJsgyAMKYimI+?=
 =?us-ascii?Q?naQSCX30yW35oP2N9MTWN7d94TDRk+ozup582AfAlr0iVdSETtJ6xSnXvnJ4?=
 =?us-ascii?Q?7I1BmMsaxobcLxhrw+h/eyh76FVK2Iu43csKxLiBLzi6PKNs8KmXEK5Lqf5r?=
 =?us-ascii?Q?+fKTw0Lvg2ni9+Ic4HnupKLBIsXYQEXNpb4jG2Gul/qN/KIobSoY9+aNVUXG?=
 =?us-ascii?Q?klLltZpaRHkoTtTTS0bkikZcmGWv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bbjFix9AChvXsVCVLrnnPqzVI+z7/nqsy+FNVtIvaX1GRBn1mKHAhYPJtTp4?=
 =?us-ascii?Q?2Iff8YbkQ2DkSOIi797tiUgvsWcunXCast6iiAdIUOJM0WC4z/VzEidIG+mG?=
 =?us-ascii?Q?/mRyqREnModnO3YMbGwHUQRpf6ONRL9LJCXhBXC0bPVx0wdjW87uw3cju2Tc?=
 =?us-ascii?Q?xbxZ4Rghg7FVz46j3uZ72RujAbkOZx1rDvykb9YdBoArcX2jckuEqhXJ4QL0?=
 =?us-ascii?Q?otelR5UxgElGh2SBhGWmmFNzIOx1YyExv0HdyOv05Kr+4XOKSsS061KpPqqf?=
 =?us-ascii?Q?p3bzCPeqRuV3rQNRHU3DuB4fP9CcteYEhGFxElQuytmi607NN37+z0YwRM8Q?=
 =?us-ascii?Q?B4gZam4RgUDKkaX5QFs8ydQYN3a+je6Ilodz2C6q1r0xOZ4OQCnz5CqqM1SJ?=
 =?us-ascii?Q?b9dPfYC7y/wLfrqDPSfu4GXYGvC4gTt/PzMRUWdI5bxTs4zYsfuVZ5r3/ZPp?=
 =?us-ascii?Q?/552c60rjunTuNesbqGaNmFEZAcL73oj4pDjP069i0XX224nWveAplKOkfXf?=
 =?us-ascii?Q?7q1V5Ff+gYW50ISTLKTRi4X14p2Ibv+U4ChKRsqdtsX7qJ3dw7EnsDCtld4N?=
 =?us-ascii?Q?LKWApivDZl3xpyZxU366I9URpP4a5GaFnxa3veew+2dzb7PJeqgZiIJrpUBD?=
 =?us-ascii?Q?mhjllAlqElaSsM5zcSflF+PBNNtSs+cEzA0J/bI/U3G+pJZ8qrPpYUGhawCO?=
 =?us-ascii?Q?7f2Z3Z+/5y2r5qKyA/1ND2anOnhuyWLmfM4Vuw47lkLuWhklay3tZ2A79/WT?=
 =?us-ascii?Q?Ug2ccoeIFbdA8MJKlPUBncsruLdvCQz0RqXoE17itX39RIxYSFajD9/VngKu?=
 =?us-ascii?Q?et6qFBuF2cbckYexGLzhaKK0hNFnG5HXnLCrErfsNZv8JQ7VHNr4AfXPyUkT?=
 =?us-ascii?Q?CzNS0Xxh3OYrDlk3lgpqnsd+Cxozacq4Hu9hS4Tap6B9bTZvxHKgO+5qTjm0?=
 =?us-ascii?Q?sbwkNURm4FCRDl4tVledDk5wZoPkNaBIAg5EV5SgP2yuedvCmKoE5Tq74zkd?=
 =?us-ascii?Q?m9UbOGKyrQsUKaj6jTe3xevFEofQjXd9fixYkmFtuW5l3jZgOJS/UbRHuXqH?=
 =?us-ascii?Q?2rhvITNE7OrYlOVQzLsScTOay8nMOg+ahrLyevJt4KPgD6b0frMin4XCHNRb?=
 =?us-ascii?Q?3VNDUApfFgZFgtpex7EHPcgj8FS6EOWdyhsL5z8HFaEFseyta9c2YUKjWj/H?=
 =?us-ascii?Q?iQ0F7xNgDw9vf824G+XBs0rs6YGc7oBw48bwTTSlhkPevCqza6+GS/zXqmhl?=
 =?us-ascii?Q?l7H+8gRwnDH7tRkCRwImSo4v+xKit4w9NG1BJEQIxkVJVMNqX5T8wuxCYCLP?=
 =?us-ascii?Q?USZ2DftFomckqxYNqEZzogzDWfihPxsmX2MSL3VwIltBEMjAuutzqmTBuwBt?=
 =?us-ascii?Q?vkihJSqgd5NqbO1mzYr8QY7GJt8ikRLBFltPsqokCUJFkuBsU3iBm6Nqlpfw?=
 =?us-ascii?Q?RwnV/86i41xKYj3TP6Bc52r04kthBHw/wChsXuH03YS0hiAeOM8ewdrJ+i0J?=
 =?us-ascii?Q?KCmv09bRsM0g/Aj4NjOEUNOlBdZxAIftvfxgQAprjB3/vslQu46a9ne1Ah7r?=
 =?us-ascii?Q?c5UMN7VlQcEd/X3xLsIkkaV5JNES+8c09qUSYTzJdpA02p456wtIz4f88fhc?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d40eb870-40a5-4d96-d198-08dd5dbacbcc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:58:22.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzmlpggOtAvI1n3qz/Cuk9HVx6WftR6KFGbwx/ZEuWrwGdxhknoOvHhazXihaxrazdxq5migt4sUa80yt/WQedIR1UnKYE1JxbktTF6bT4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7542
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Hi Dan,
> 
> thanks for review.
> 
> On 05.03.25 11:06:52, Dan Williams wrote:
> > Robert Richter wrote:
> > > A small series with individual patches to handle inactive downstream
> > > ports during enumeration. First patch changes downstream port
> > > enumeration to ignore those with duplicate port IDs. Second patch only
> > > enables active downstream ports with the link status up.
> > > 
> > > Patches are independent each and can be applied individually.
> > > 
> > > Robert Richter (2):
> > >   cxl/pci: Ignore downstream ports with duplicate port IDs
> > >   cxl/pci: Check link status and only enable active dports
> > 
> > Both of these problems are to addressed by work in progress patches to
> > delay dport enumeration until a cxl_memdev is registered beneath that
> > leg of CXL topology.
> > 
> > I would prefer to focus on that solution and skip these band-aids in
> > the near term unless there is an urgent need that makes it clear that
> > waiting for v6.16 is not tenable.
> 
> Port ids could be set only by hardware and there will be no other way
> then, than the driver to handle the duplicates. Relaxing the check
> looks reasonable to prevent the whole port being shut down. There are
> other cases where dport enumeration also just continues, e.g. if the
> link capablity cannot be read or the component registers do not exist.
> 
> The delayed port enumeration series will hide duplicates too (not yet
> tested), but since this is marked RFC and 'long term fix', how about
> having those patches first and then update them with the delayed port
> enumeration patches? The duplicate port handling could be changed
> again or even made obsolete. Otherwise, until then, the kernel fails
> to enumerate CXL devices.

Right, but this is something that has apparently be tolerable for
several kernel cycles. So the question is one more kernel cycle to
develop the comprehensive solution, or put in a band-aid that still
leaves dports in a broken state relative to hotplug.

I would prefer to not need to onboard short-term debt, unless this there
is another mitigating factor that increases the priority. Something
like, "on platform X the kernel hits this much more frequently than
platform Y". Essentially, clarify the end user impact of not addressing
this immediately with the half-step solution.
