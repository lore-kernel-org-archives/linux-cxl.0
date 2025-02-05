Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4D1FC0F7
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778593; cv=fail; b=Y3rlo5mEedL1jPYQtisYhDFNzEdpwUyZHU3mM4/D4+COTxRwQoYGVJ4Ov8/38a6bp6iuUR1Jg8godcU4Ch9z6/HyKgevkoZ/LhTTPC007M3tpJHSSSt6kaJs+1aqflfw8dfLMJoK+QP4bZWdWU89+2TAY9DOSuSrHv1ywsjdSMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778593; c=relaxed/simple;
	bh=FdgHTpPcVkXbXcXFqyGeD8oUZYrHz6xZgNIq28Lq5JQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rfk2Q0CcLC+KgrV1UaeIhxx8UtRd6vkurwsD+LXcWYG1YPBJK3Fw2v+XxhjQr1fTObYg5KgEq30AZqEBwnIkxF/xuHD/agprukPBM3W7zx2N7yO7NVhMSTmnXn+g6yc6czkzwqTo/WilO/SIymDytszM53QaqC4J04TnN9H9ST8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYkYSgJy; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYkYSgJy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738778592; x=1770314592;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FdgHTpPcVkXbXcXFqyGeD8oUZYrHz6xZgNIq28Lq5JQ=;
  b=GYkYSgJyDuuPBxQTUETe51x/B914iQfCZp7bisx9PrLFv4j+85fpbItN
   6vC3x8JO1JRiIeGfZTJpViS1+5r0kaMWhpklIaG0R9GmuFgxLbf2wEDJo
   nVnH51uMQI48kUZ6luQcyAW71TmfTWOPtNvcojum1ALibV18f08FdZN8b
   11FgibLmJlSxrM8FwAtVHv7+vlIFuRDAQzEnhRtsc2Nch+3Twx89lhuWS
   NyZ+gQWpsiQbdhRoWdyHV5rz5PIfpUKTRN1YL7V8Z2j9UN6e+iRC79FYY
   RIZlPMLoUT0diCCAf6ZjX74Ba7H0lucWRjLFeKBLfRk5xN3wYRRN/wDbr
   g==;
X-CSE-ConnectionGUID: o5PlAKMTQliiewksgLKSkg==
X-CSE-MsgGUID: hklFYX5MRjS/4Y+sYv7SbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39239300"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="39239300"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 10:03:01 -0800
X-CSE-ConnectionGUID: Ro62D2DmS7KmkMP/O3VtnQ==
X-CSE-MsgGUID: k+SwU7+wTsWAGLRydNdP6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="141852524"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 10:02:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 10:02:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 10:02:52 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 10:02:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bv1Rgy7yZ9BswufqmdgGf5Ejm+9RDWeQQkAQqih6+V3udW+wMBCxih2AzI3ajmfTlcWuoVgJHQKBpiARj5MIcf1DvLw3VrDPRvs6Nv+5pahw00/9Fh9Tvq3asaI/xI8j86MKj2Zr3rQIgnYtz4VxFlALvn/O5DnONcBLDBATpgvxKPgGYPRKXe2sM+Jpv02W6k4/mhvtIEPsr9qHyls8j4dDOhv/sMttBTtL/v431pRfskQDxmMQ0c1t9TaGU2AU7pVNinE8D9VyWWwH63dHOgB8hujHcs7nAEc4uvx1i0xqZs94GPLwHY1fHZHvgaYXI1UyCEud6WZspFm2HOxhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wc+lS6ZpHjy0tmChMjjeSF/Ma8rn1DAMA56zEV1Srvg=;
 b=p927/V/NhhM4GZmRQ8qDBVh0Mtnf8vPykJhKUBDmEN00qvrkCAJsFkqYQhugSNj91tVL0IftWis/UmRTDzahZX+SMjhDgnkjXQfrlEO6TF+kpLB2ApsMYSM34SxlhwHj9lwRYV2u/vqSKsIrA4Ik8mU1k3wXwyg1CAe+dvGC1zAVIArv9No9Au8cFetfeOD5EYDFIVql4QT4v1GvBVKuvqTucTMNFKNELlZUW+7u3szibo4VJ1hFLCrM7b62N+gLJSbw7hK7ElgB9vCPU/44kJaFFmOUEuyNicElhWW4pv8tfr2fNUZnJjTobIr9RpNB8P+XeifXdOHwTjiQ8KSlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8201.namprd11.prod.outlook.com (2603:10b6:8:18a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 18:02:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 18:02:46 +0000
Date: Wed, 5 Feb 2025 10:02:43 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 14/19] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <67a3a7c3b6cd3_2d2c2943e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-15-dave.jiang@intel.com>
 <6794478dd8026_20f329455@dwillia2-xfh.jf.intel.com.notmuch>
 <20250127105132.000072dd@huawei.com>
 <67982790e13d1_2d1e294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <20250128120138.0000599f@huawei.com>
 <67a170ca464e3_2d2c294d@dwillia2-xfh.jf.intel.com.notmuch>
 <20250204100408.000048fd@huawei.com>
 <67a293fa8f068_2d2c2944d@dwillia2-xfh.jf.intel.com.notmuch>
 <20250205173652.0000363b@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205173652.0000363b@huawei.com>
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: d89e2a3d-9672-465e-0abe-08dd460f4b93
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0zdsX189zJgdGiARZHSSUzvKHJmNa6kGK6bRmy4QlMrvW3FFBOqlModTzag+?=
 =?us-ascii?Q?wXJDk9IWOkANkz9111vJOpekGsBbT7xIJE4dWGPNn0veSNgZRLocq8KuK9cT?=
 =?us-ascii?Q?REHY+HW6u9v0d4uvHwrkcNxeUTfrL/Y69J7lzTi/HxrOWdVPgXLDy0Qi0MVx?=
 =?us-ascii?Q?Yo/esua712ykH4ZlZx3ghJ78sLfpepFg5j2QdV23X1uBixw4M7brIlxvCk4G?=
 =?us-ascii?Q?H4YqGSG8fwbrJd4QdpC7ImhtM4bHaeImW4EimJzlGqUbdnKllPbgOieQ3VSA?=
 =?us-ascii?Q?RDfM3QCFQp0kl5rlb8sraej9U0sxGt4KhquT9QPQajSCpns09JnX8qdiS+Oe?=
 =?us-ascii?Q?qDMiIyTgiKfJA1Pi8cUqcVbU8PGKLJ/z+S0/rFEekGtG96rtSuohV4JzIv2Q?=
 =?us-ascii?Q?Il9BD7PGD6OyVkrhThnPcJBge11HVh6t3ohIOOPwLqsefNmB8h5/PPiJufl6?=
 =?us-ascii?Q?qrDbfzpcDGBJpxt2l1M8PhDB1VE4M7SUVTykCAm18RDnJDHEEjOTfdSJT05w?=
 =?us-ascii?Q?fQ7XjTWAOFoeQN/p8rWtoDtgCiqZuuPso2+EaalNtu2VffV2Cqb5pbwg81Sq?=
 =?us-ascii?Q?48mJYVgFMmN3HtPTXoy5et8RN1O6EuffawR9LREQq+0eUeCQzHweWdzFG9ak?=
 =?us-ascii?Q?xcqEi2iY8wnhsYjYvh56/ijuF0FObV1GGjohwCb1W3PRuMV+WB5KvKu19ayD?=
 =?us-ascii?Q?tGC14A50xx3JbW3VUY+xpET6/73ZnSLi4YaJfzLe+SVEUHJfPnFPpPA0n0Fx?=
 =?us-ascii?Q?rjwID4BcZkE5EXjynDQvmD9tLxDIY1D+blmV6AtGHXL/Gd1imlOWMkzC83Ou?=
 =?us-ascii?Q?OiphTr6U3x9OtJeoVBsSq25RUPBQLntmOzqcjF2Lf2ZewIc7Uaz3gNEBxAX/?=
 =?us-ascii?Q?qrV0npFH1JI3sXKqno0sbtqXDIeadxs88KF0BMK6nPMBR9sigHSBXYy5jCJu?=
 =?us-ascii?Q?QqfPEv8iFe0iThhPUC2LpxYMO/NEs7BNwl6MlZ9gPy3EzZpm/5eudKbC7S31?=
 =?us-ascii?Q?PlHwr+KG8Zv9DV9/uXe7KpVz3x9p9wq0vUD/GCo08WAbzqk0n6qeDLI+TtbW?=
 =?us-ascii?Q?9BUPEz58ydNNtfa7/X8VbBFsDvSN9D4CGADw70UAElxEn5pjNhKffSk+78m0?=
 =?us-ascii?Q?fhW0yZCzbyc++34OecBJ1cwMCm0105IpahscfJGrHZdtXB1Pel316LiaWC5V?=
 =?us-ascii?Q?BvIotNY5m0fqjXc0IDUT+QoVRVHcSKdGRKMPPG38ZZi4016p9JzLd1JJF4FW?=
 =?us-ascii?Q?UxMQMwsfHGoI7K42B086Sqtfm+f5mmsqMxvOjQuo2Krf2hMcWtVnHLeAOiDg?=
 =?us-ascii?Q?ZFoTTKXZll59bli4UKXI3HKR00cM163U+w3hUyIa3e7KwXXR120nIY/a7Qqz?=
 =?us-ascii?Q?4NJ1kYlGLqnXd07WuSMWpo6AHh1s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nb0sfRpNr4BoAOpTLZT5usCfT61W65rAdQJFsbYxpkuLxuh0St/J5YqEiwG4?=
 =?us-ascii?Q?iouzhV81PgxCGmU9BWi6tmJ4cl7nbPY3hyxV3Ayhs55Jk0SuS/njzSdK67Yv?=
 =?us-ascii?Q?qpB5qYvpOPkacyOLVo36s7l0fQUzRfGh6XGNdSlv7J1fWTx2dOccYBlqrcoV?=
 =?us-ascii?Q?dQQhdz4CndM41MIK+yTL3SotGWuWYITx6XAyt7HKa/jvGugwsJqsZYB0qG0h?=
 =?us-ascii?Q?acArTb2U/29Z63nvJ9MDMM+AUbHFUm9RxR8O1jFCNmYHy4/lvJOEBGDEq2SD?=
 =?us-ascii?Q?8zAEx/TLP+Jubrvn52c1wMYZuXWYEr+hduKAAktzxwK3h8TGL9dADyl92nFs?=
 =?us-ascii?Q?i9mwfMOPsQrv1GAuZ4jzYWPcHyGWwzY4ax+B0jnOlC8NIFefkvOHuky7DChc?=
 =?us-ascii?Q?zjNaiKbaofEC6PkX8FcfjPD2xQIZr3cHlt0Ol/+c9ZdBOdSoyL2EaiSeKox9?=
 =?us-ascii?Q?rbK0tKR2/vOrw9ZYCx9WBrKZJ2WuGTyWqVO/7wbvZrp2JlV/tAFYMy3+cd4K?=
 =?us-ascii?Q?MmVRXrblB9yIzEi4hpjCdKWpKgzmqEZknDGHDlfiXcr0mic9CYYLW9aSvBD4?=
 =?us-ascii?Q?7jXupguuZwda2FstDaWnwJCefN93kbyg52HQFaBIJqtiS42WIPgNhELC7sHc?=
 =?us-ascii?Q?M3O09fOMhGJYG1gkMIz76AWTZK2IUv2BNqroZoaUsTPP+RGORLWKrw+uGbWR?=
 =?us-ascii?Q?FdzgoXw63Mh+R1l/9QL0sM3wru7CiS5pzM1ymn/kpYs4ZGDyAZTosc+Rshj5?=
 =?us-ascii?Q?1zqBJ1Gq+T2yLrbR8uCsRfqJ3BoDBWAA/jGXKgJqWcZ/ymKSGf4jWKrog9ko?=
 =?us-ascii?Q?o6TFDoKDrYJeZ7hRHM3CYIYmnNEjcJFajWzlUrtpAoJXkCY9fG4oFZB/TDGg?=
 =?us-ascii?Q?VwZ/hDC07z+3afyRlUkkStpOwe6+4FFSWBJqmzyu+b0G0tY6nAr5jJeksfMP?=
 =?us-ascii?Q?9D1Q8+66FkYcPbduVIE0Lp4s2r6bbgUWWCT2jmzvMG8iwO7wmASiXZu0GoZ4?=
 =?us-ascii?Q?ULI42fR7r2ER/VR8mX2yCO19YjLZfUPEk0QuGWlp9LDvo9FJDF4/dDzra3+D?=
 =?us-ascii?Q?kHmnVO8Bl3m5NyGwr2S1/aK3hdsLASXuE492fuDLYd92R6M3ESYNex7AWPt4?=
 =?us-ascii?Q?JevW/G25kO3oTbkcZKMLEEcu7WlrRgK1f5m2aPN+8+ra2Q5rpBZa7cG8BGyk?=
 =?us-ascii?Q?e/aM3pianGcnFyR/AGIN2zhFhTrmqee9REUwdTU7hKhsy7s5rHRFKdIqvxme?=
 =?us-ascii?Q?keIBFGQfua7YIKlrbAuLu1fg0lVnf4dI5Akq0T3m1CcM4846ZNXfm2oPsvbf?=
 =?us-ascii?Q?XFlnBekfMINZoN1rO3qo7cQGnrdakyhtXfbFyN+sSN9jqFLmHjkxCz3bEBB/?=
 =?us-ascii?Q?n1GSQ1D13Y6Q5AA00fwArwHGLR+uCgK8XcKvmFlXOBNbzEHxMP+RYTehLLjr?=
 =?us-ascii?Q?LTor2T98Q3vCmLqex97a3XllbQyexuqCkNry1fPYzWC1Kch1IBK7TfKkzurL?=
 =?us-ascii?Q?Nu4TI4VzxIMYUmV0p8CKIT2tE8buTq5h1X2r6AjUWUK8eNS5UNkGmrtYAzE1?=
 =?us-ascii?Q?R0vssqnTsZsRvx2ao+2qI86EgSmI8AqStVbdeuFkHVF8UwGBN02ZKqVhki+4?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d89e2a3d-9672-465e-0abe-08dd460f4b93
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:02:46.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76/d+tpTJqQRdytTfMS8TnYT6KFAzrHZGJuMYTAF3noVDtBFW/cGXGAjBipnJwIMPJRcw8bThGqcC79rNKnmMgDqJGFLCEZB0homUU4Wooo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8201
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 4 Feb 2025 14:26:02 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > On Mon, 3 Feb 2025 17:43:38 -0800
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >   
> > > > Jonathan Cameron wrote:
> > > > [..]  
> > > > > > > > I think it's fine to let userspace see that exclusive features are
> > > > > > > > present, just need to return EBUSY if userspace actually tries to use
> > > > > > > > them.      
> > > > > > > 
> > > > > > > To me, a poke it and see interface is really ugly.      
> > > > > > 
> > > > > > That smells more like a matter of documentation. "Doctor it hurts when I
> > > > > > try to use the documented kernel-exclusive commands?"    
> > > > > 
> > > > > To me this is a nasty interface design.
> > > > > If I'm writing a tool to enumerate what is exposed etc then it will
> > > > > have to poke every get command just to list if an interface is available.
> > > > > Hopefully none of them have side effects!    
> > > > 
> > > > The kernel exclusive list is documented. How did this tool get written
> > > > in such a way to understand how to get data out of the interface but
> > > > without reading the documentation on how to consume that data?  
> > > 
> > > Today's kernel exclusive list is documented.  Kind of tricky to know what
> > > is on that list in a few years time.  
> > 
> > I expect new software for new capabilities considers new documentation.
> 
> Time travel issue.  New capabilities are supported as features the day
> they turn up. Tools are written. 
> 
> Sometime later we might decide kernel support is needed and make them
> exclusive.
> 
> Ah well, we'll cope.

Yes, that is always going to be a risk especially with the vendor
experimentation that this is going to allow. However, vendors will also
need to heed the FWCTL documentation that this interface is for
non-primary functionality of the device.

I am comforted by the fact that all immediate-effect commands will be
relegated to a debug / permissive security posture. A high value Feature
likely graduates out of vendor-specific passthrough to a kernel mediated
interface when folks inevitably demand that it also work with
restrictive (lockdown) security stance. I have seen this dynamic play
out in the past when folks realize, for example, that debugfs is
disabled on lockdown kernels.

In the meantime the kernel is not going out of its way to preemptively
hide the presence of Features.

> > [..]
> > > > What breaks if software treats those bits as Reserved0? What breaks if
> > > > software ignores bit9?  
> > > 
> > > More generally we can't assume it doesn't happen if those bits are 0.
> > > In this particular case perhaps it doesn't matter.
> > > 
> > > Hmm. The aim is to decide if the permissions DEBUG_WRITE is enough.
> > > 
> > > We have already verified it doesn't happen immediately. So now
> > > the question is does it result in a change conventional reset.
> > > 
> > > Without bit 9 we have no idea either way.  So question is do
> > > we assume it does, or assume it doesn't?  
> > 
> > If bit10 is set, assume it does, otherwise not, but as you say below,
> > does any of this matter once immediate config change effects are
> > accounted?
> 
> If it's set and 9 isn't - hardware bug! Not really our problem.

...right, a bug we can safely ignore.

[..]
> > I think so, yes. Filter the known problematic effects for live changes,
> > and require the device to claim at least one of [0:5, 10:11] in its
> > effects, and filter Features that claim [12:15] effects for now.
> Ok.  With a big comment to say any device setting 10:11 that
> doesn't set 9 is buggy but we don't care.
> 
> Otherwise someone will 'fix' it.

Works for me.
