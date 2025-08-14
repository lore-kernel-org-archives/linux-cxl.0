Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A01DD877
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 03:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141174; cv=fail; b=A4i1qSndRAUokHNOC1MMj7Z5Mx9oIoifJMGr48f0pM8P1dE+fOttCZ3ZxmP/88H8ALGiOXc6rt/UrEWFLsJqLR1mhhMZ+S6AjXMrLCs05eSYE4xyzXG6QJ0VUElt0bro/qcZhwTMeFrUa8FtfX1qlJLcp47oY4AjEZohCEHOMS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141174; c=relaxed/simple;
	bh=Vc+985qp6cMN0sNL3AxqW4Lmk8xUbNZhVJkWoOLTq6Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P1fEc+ZXEbxHNxpU+iCljRL0nUlT7ydToEkXL3sId83XdFoukPNznqrzAYZAu8xAEKhGuGXitdGEkd+0DMa+SksGHMIQcAt8zC/SPTEZ/JB+d7fyoqhauYlVYOVVsqFsdv5ZJM+zyqdkvlxeENdq3I7SYJvx1eTxjOVDxM4KQWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsIzXAFo; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsIzXAFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755141173; x=1786677173;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vc+985qp6cMN0sNL3AxqW4Lmk8xUbNZhVJkWoOLTq6Q=;
  b=SsIzXAFoTdCU6q77bTPgYZJzpy73JuBCSBAu9zaM92Rfpf4ZeANlnjec
   Jm7aJCxjLrkPGLdJD/MOmW4nHNxMvKAV1OZfSewq/iLdWMcduj1W5ZhOB
   mUmtzijCi4l/2o1KNiLL/H+UfRNyBwv/CWMDKoZ5GWuKYlX4vqHuozOvr
   XqOyA56HYoAgP3z4uc/rGcvxj1jpMHqczN96LARMkSZijJ/kDSWLGflle
   Pbv353HZog+ybMmKS0jcqPfPuZNxC7rIWPjzlGfSLmNARDo2t6HHstN+L
   tzNfIoBs9HC4Trn1wvRtRTk8iY6QLM1wftgAbDnUpZsb2qckd0PekQHqs
   A==;
X-CSE-ConnectionGUID: EzedOBa0RQyMZbnonFq6Ag==
X-CSE-MsgGUID: kbBY8pEhQHGXYT9oA21Wog==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="45029153"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="45029153"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 20:12:52 -0700
X-CSE-ConnectionGUID: cXmU6d4nQTWZiP+kcQRPEw==
X-CSE-MsgGUID: cHX8Ge37SDSL28bbcAM3Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170782657"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 20:12:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 20:12:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 20:12:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 20:12:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHHFIe4iC0OYJNQvAns1hvHh6KUVnM5bNWHfWtWwwe6eDiq/aal+7e8o/PCUVG8I6RdO97izH1SyGNAR2e4FWqN5VSHbKNyHWfaJNLipr4Oa/9f1MJ5BY1yN5z3oC7qNSbu0AV/DyXah/0N91VgTexbhhcj9Pv2rzu9DJPxsQ2ZpRU5ZbHaUiq/Vp+V5jSSnXnhAnYKU5z6V5NvFBbBKAelY8+6jTwE110q6WpwREznrzOWi/89vZpBLlMpYuxMjA2cH/DsLYc5n1FWSNDtfDjWAjYaYPlbf7eSEi7nraeOMGHR9VmnuXU/G3YY5JdvbX8Z1gZSWxYLQwPWFJ8NowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvP1PlbxteAmO0V+jLHaGe7lbBEDoM2RGU9xpS5kVbM=;
 b=YjbU2+5y0Q1GP0HNQ+B9sFepBJeyljWxqeRwTUzHsHaD8nQMLvV89F5Ep4H/1YfYTRgPTEqpc+lykpqj9WjORHSBLm/EYi1IDEFhl7jtx5RoEAPaSbRvXTn2bFG1D08zDb5v9DPrDmmpSIL7ZqoL/1MqlphkxFhwsTG4Hp4KKKkIYQJmh1XHM6si5Y4VeO+tOc9IDJ/CUD2bCrMk3qvZK+KnDiBUvr2FmsI/BnHsBgpYzNVmBtiuFVsMSmtJkI/2kdgwq1PQnc0PxV8EBWISeo2f61ilBII+3WsQQGbtJY9zBVErH9XL/ogC6jq9v4u2H9ED6n3CU81WJHR20frWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB7204.namprd11.prod.outlook.com (2603:10b6:610:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 03:12:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9009.018; Thu, 14 Aug 2025
 03:12:44 +0000
Date: Wed, 13 Aug 2025 20:12:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/port: Validate decoder nr_targets against supported
 ways
Message-ID: <aJ1UJOySCoM2M_-M@aschofie-mobl2.lan>
References: <20250813214218.2917555-1-alison.schofield@intel.com>
 <689d348e41a66_2709100cb@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <689d348e41a66_2709100cb@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::37) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f44915-ccb2-4e6f-4b4e-08dddae06fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y4EQetc61ZgsoZPw5m6hbgxmn7HXROICltqje3VPuIGSImtBOTmwXi39Hugf?=
 =?us-ascii?Q?CEJGsI0Q/tNYyUHAysUuuQHFSkYm6D9rvuMAfB/2wDQ9HqYsypRqA/5EAtL7?=
 =?us-ascii?Q?RD7Z7XZgBVwCw2Ro9MtFTOemzyD7nUMrHUdKE8HCVB9e8U7/lLsQetzQccAI?=
 =?us-ascii?Q?P2MCu8MZmhyhmRFkPyd8/gBuX2apKfIdrrcw6imzzbuykGa6os6qw8dQ1hzi?=
 =?us-ascii?Q?MFS2pbUK8dRfdgVpIY8JXDxyYsE3j/0X1qQltyBuFSoZwjX1GIAMF+2l3A0t?=
 =?us-ascii?Q?O6Lg74ZLAEEpP8weQEjw23xxThjwv1l8B69IDWDvNz+4siC3n0adep+15ukt?=
 =?us-ascii?Q?9wFP35tJTDPzAIFJy4XIXU1lAk4hvREV6RXJHAWIXnwstkBT0q46OJgvjaFh?=
 =?us-ascii?Q?VzU3kMi0AoM4yBq/UmrEa45mwlLq5hbHJ3i5ZifTmSiBFG9Vhcw2NyCffMGm?=
 =?us-ascii?Q?ZOJ5YHY4KM9bP/9rYAjqscp2uh3MukoxkH/Pt3hcQk5e1RPJbghzRD0VXiGM?=
 =?us-ascii?Q?6+fEj3PqT6uInYPNwZzMTb8280dptoW4yutZT1YUb/x80QSk9A4a1PrMECHv?=
 =?us-ascii?Q?XhgMrK+yYjvh8jLjLTl5Y7zFlbqFkJtUZ1rQ3Z2JIrwUUY7YlQDqOkR6RviR?=
 =?us-ascii?Q?oX1C4tzwSKi26hXe3HtyHZlr58PQSLtMUZf72dMrqTS6FpzPkg73OSAyx0Ri?=
 =?us-ascii?Q?XK4+vMTQSCF2vcJMfK5GLGEV20sDLzB7yR6kbQ0fel6SBXKxxATKAEsLUsH2?=
 =?us-ascii?Q?nMBK/g4BCEq28ij48uNOyP6rWHeCafuoPpbm8p/C2w2ujf81CF9vczoXNlPn?=
 =?us-ascii?Q?c+bGTas0nAV2TSmBWc1qLKNweslhAwD5XXV5/cu0WoImplQLVP7J7RTxEuk+?=
 =?us-ascii?Q?0o4aBKC4QHRfaGV2lk8zD25yRDyfaHdLkMVexZ9lhgRp9MvFhrNz74nESqMk?=
 =?us-ascii?Q?cEBSmI3EDezN8k6FCAIAbZwIi6oaneCgZun+9TKxbz/t3uQCEzl2BoIAE2/V?=
 =?us-ascii?Q?TgH4zQyGKzJ9E5NGuPTPvqIuPm+sqzWuOIXNEd4IhIMred+myjPH5uUd5Kwi?=
 =?us-ascii?Q?uclsLKg+l8+5vTKwrrT/ZLrbShCEDFrCTwIt9Nc/lyVLhyNWxcX08BvFlKvX?=
 =?us-ascii?Q?Ty2APo5lRu9hJZbWI7AQ0K9M0jbSrrACFbbJ1+1v3YYEfwyugbSz2vmExSz/?=
 =?us-ascii?Q?4xsrYH9qK12F2TqqjSGrDIPb3g6PEiRYYkC9FUExRAJPMpD7RYoY6NHEmV85?=
 =?us-ascii?Q?ivNSMAPf8l0EdKUCl/7wkdK04iLP2tah4JZcR95a8zxYys08XcVcIJ58kTCF?=
 =?us-ascii?Q?5OKYH5GIxnrpnTEBCrzFRPvakXgMfjBmTf58Sl1IIE+2tiasUKpl5FtoqzdF?=
 =?us-ascii?Q?kVvirwINimZrO9eA0HwIn2zN6f8lo2/9Ha5jv0woZjuHZZrWsMU1Ajaeq4tI?=
 =?us-ascii?Q?TGtTb/qxwis=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5C6mw90Of7GiGRUa8zNe4/QCs3X5fa1y/rmnFP52++z1UA8gKT5+sKoz6Z6L?=
 =?us-ascii?Q?0kvNEmwmUA5xRtMXUavoX4vcK3nhTN5cl1RpedKeQwryNS5AqNZY4PMCkBaL?=
 =?us-ascii?Q?mCWn6LcoIgeh26SLH+vw5O/qudqZp0Zam72p/vRDwENL+tmcwczXjpOkis9W?=
 =?us-ascii?Q?jvufKAnzl0VVkTQgPAHvCSN021LMI8xfVG8L9QjwYnth5U2sPOxVY6rXvb9I?=
 =?us-ascii?Q?kgz2tdAdrpUlDFwFPi+2XKMMoMsy8xgvNF5b52iSzRKe5tUmQkdPfXVtNZa7?=
 =?us-ascii?Q?HHG7fsUB0h3ksPh7Z6TVaJ45cB7SZH7Q7rB6pZB3pptE0Y0UzWsPDXOjivmL?=
 =?us-ascii?Q?LFje7W/Boi7Icy3ogQZS6MpuqZHXC6fdBByrNNrP6kB6Bb7DvD78TRcviNqf?=
 =?us-ascii?Q?ZAAPBmctcvGqVxFR9GilvxdErXjNE0jI8dbbovdgDlmCfYPsM+kO1usSHRqX?=
 =?us-ascii?Q?BTJYh1+Fv1dDG8SjC2oC7DxCRjPJ4+FXuq3kklK32ToGKXBzcg/6sJ/iOmXZ?=
 =?us-ascii?Q?P006nlBfPZYRYVO1bls+Cu/JWPEVRZlN35OEUxNUTfTQ+5Ak0JZlK6rsSaHc?=
 =?us-ascii?Q?HzkFTt56ZZLf2wV8iAnMMdLg4H1jpK5bQK7DxFs7o3SDjpMiCArSOqQc8/Dy?=
 =?us-ascii?Q?O/wMivQAQ2Nr9ah6svz4pYakfk2njU7Ka78iPgqry14N2cmr8fJ9mZy+mVpe?=
 =?us-ascii?Q?7DRtKLBszrrJWyiwq5dipZhDoH3UsmKAKLN/5qzjzfWShkicvQ3WK+1sTOQw?=
 =?us-ascii?Q?bBQd78JgTtP/MCZEH772ptiOHvV0+9xkGeYNdD57VncgTg7chiGYcrCkIqpb?=
 =?us-ascii?Q?BTwQUBTC+F8GSbFstoF5lzH+FNuMhnTvkwxSVsGBoabAvVlDWjvz+L1HqLsb?=
 =?us-ascii?Q?2qrGyQOuGLgoxOUTC8rFDbAJ+3LdEJVfcz4HL+PGFffK1vTmZ1DafqcQmMLA?=
 =?us-ascii?Q?/SoKeS1T8FG+m5tOU0mFfVfHfF9Ai5s60jUpcc5krtpWOA7bku0FlOKtS/+N?=
 =?us-ascii?Q?KXWHZBzZyMhFIgqmjboYBz5WeBZbWDLAeMqgns/tNAp9U36Yh72lEWF/2Ybw?=
 =?us-ascii?Q?1IQuQuxdP6XiBGdAi7gGxL/gR5ZhcUTs0fakfLS/Faf3yPZHMosOdEHSBCBe?=
 =?us-ascii?Q?NL999Jxj2nndvs4Bu5uCEByusRCX31Wzq6nIrr3ZIf2HVGJbSqmhF5B5quv5?=
 =?us-ascii?Q?grOfEbDt6qfnB5SL6Hh44wGo/SaoUFo/q0hKVTjGN0d4KAhcM+Mk+W38/CK1?=
 =?us-ascii?Q?aG5vxM3x6oIYJuqUPVJzsLCp6fA6j5EDudn90/hjTmh7G9c6Iuzy+xlHXBB2?=
 =?us-ascii?Q?LLvO4ThUXDpRLhL9s+WIWSc3bnh7zqRvhvinAH/xUnUMOzjnIW9AYP3hD7ZO?=
 =?us-ascii?Q?cY1Lt/IS9cLac92l/qhPtaFqYmqjbiL/XeHUsDdFvJTkdcD3IPp0z+lSyfgx?=
 =?us-ascii?Q?sheWiulweikeIYnJ2xDrHCwqPHbkOU6r7hyxHmuBubm0nuIqlhwx4nl186JH?=
 =?us-ascii?Q?IcKggbQx7Rh38o3JPyqaCZY42Q8szhBe3fbMLIW5/AYpFScwVoaJe/VrKOWz?=
 =?us-ascii?Q?XfAMQuYUlbj7OwRhOKjM+kCfU1FzuVBximwNKuyBNcg7bpDv+bS7xnJaB0Na?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f44915-ccb2-4e6f-4b4e-08dddae06fee
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 03:12:44.4475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jt3wyhyxW+MEi1nvotpFhEfj1oqc98ZeiK1jcPlHKUYS1meMUS1ZI9m0qBBbFaBKVSqUdmR9cgzDbjbFDBA6kgkzdCEHEzVzRmncQrU7aOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204
X-OriginatorOrg: intel.com

On Wed, Aug 13, 2025 at 05:57:50PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > nr_targets is the number of downstream ports in a decoder's target
> > list. It is limited to the supported interleave ways: 1, 2, 3, 4, 6,
> > 8, 12, 16. The existing check only enforces nr_targets <=
> > CXL_DECODER_MAX_INTERLEAVE (16), allowing invalid values, like 5, 7,
> > etc, to pass through.
> > 
> > Add is_nr_targets_valid() to check for supported interleave ways using
> > ways_to_eiw(). Use it before allocating a decoder to avoid alloc/free
> > churn when nr_targets is already known to be invalid.
> > 
> > This was found by inspection and hardens the code.
> 
> Well, now seeing this and trying to answer the risk question in 1/ led
> to me to reconsider whether this is a good idea and whether we have a
> deeper confusion at play:
> 
> 1/ "Hardening" needs to come with an actual risk claim. For
>    cxl_switch_decoder_alloc() the values come from hardware or ACPI and if
>    those are buggy all bets are off. ACPI is already protected by a
>    eiw_to_ways() conversion prior to calling cxl_root_decoder_alloc(), and
>    hardware is even more accurate than this
>    approach because it considers interleave ways capability.

If all callers comes thru ACPI then agree no need. When you voiced
concern over valid host bridge interleave ways, which would be the
nr_targets of the root decoder (a switch decoder) I imagined you
were thinking of a path to root decoder alloc outside of ACPI.
Guess not.

> 
> 2/ nr_targets != ways. ways_to_eiw() is the wrong validity check for
>    switch decoders, nr_targets is a topology limitation, not a
>    interleave_ways limitation. As far as I can see nothing breaks if a
>    decoder claims to support a target count that is not a valid
>    interleave_ways number.

nr_targets does not have to equal interleave ways for the ways_to_eiw()
to be a useful helper for validating nr_targets. nr_targets has to be one
of 1,2,3,4,6,8,12,16 and if it's not ways_to_eiw() fails. I saw it as
simple code reuse.

I explored using cxl/test, changing nr_targets at decoder init time,
and predictable passes if greater than needed, and fails when less.
But it's not a thorough simulation and not worthy of a more detailed
simulation.

Thanks for the review. It was a worthwhile exploration :)

> 
> So it was useful to go through this to get that clarified, but the
> takeaway from 1/ is "there is insufficient risk" and the takeaway from
> 2/ is "nothing breaks even if switch decoder target count is 'invalid'".
> The valid interleave_ways is a separate region-only property.
