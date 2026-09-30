Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B4415F20
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809330; cv=fail; b=R3YLgRarOAj/aZo37pYd+ih50OZfi1KXvJReKtg71JCTMzQBuJ1EnSO3cr+vphy+bzPHbqLIUqEI9msT9zlW9O9xeNY4bpDxGoD6o3GcBN9EPBj85+TOrgwR5oMpe75qj7D6AgOYOJk1xiXfAeHUhb5ViwNMrm+RLplWNggcqIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809330; c=relaxed/simple;
	bh=vnmTIf3KxgfnSh9UKNnL3tJg/ZUz4a4ETbP/guzk36U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HCv9XPW3K50CNdvb2i5fOo91Zc180JEntxKgANQRBG2yuXGvmu4fH3PgrC6t80V8ain7xTt71GIx0gyVHTk34BW+ogfMg0wRBshIj9XhxocwIMlPlxFTEI79heO8/bWOYwAISHI9gJTH9rZPnBsJ8pqTy7KsLawVWdlfmxyDFEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IT/M0vsj; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IT/M0vsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790809326; x=1822345326;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vnmTIf3KxgfnSh9UKNnL3tJg/ZUz4a4ETbP/guzk36U=;
  b=IT/M0vsjq/N7/gmobXIA5qdq9uhmY3BI47EdGdrXjZsrv7TixmGIMpM+
   5yGM7rnC26WLJ+twZ8O1KrK2OCkcxSyQGA/O0HD+sjnf8BAwJugArKckk
   y3A5vEorc4Mt4nok03Q6fz5xGDTbZAYZNrnTen6qpxAZQGbZRlK/y3z10
   Q7A4Q7Vt9tpFWuqplHNOvVP2y0HGi/rNLFsJ8bwJTv2H84+4adIRdK9Ro
   DttqakPNyDUjIi65PpJeFAYd7oYFqJQ7eOqAFbJfSzw031fSizZ/wkGyZ
   b0wVVTnH9S7Ln+q0OpR8CGXyJfBvBk3GHcbj/8GEgTAtypow0+MuUiUw3
   A==;
X-CSE-ConnectionGUID: TrkvHdGdTRO4Q9qp8JcpFg==
X-CSE-MsgGUID: Ntwe8Qu3TMK5+c/vKs/IwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90418745"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90418745"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:02:04 -0700
X-CSE-ConnectionGUID: W4wXTV7QSLmBvgP/PNDlRw==
X-CSE-MsgGUID: jbn1ixepSnmbZLYNkg077A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="272272798"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:02:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 16:01:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 16:01:58 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 16:01:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSHF1Dq1zF8huVzT0b86VifWipzT1ZgKEaVANF/I/X7peGWOVhn5uBvc5u6CxfLAVjoBxLVZtGyqYkRHoyl4LSFU3Rh+vtxK/Fcm+VpSBl/C2MYn1TMglxMi/K/WBRvaW5FcF5GsLJc1bRU/+KSazawUVutnuXR6LikBLLdMMuhH0fNvwpg17/7lYYPcBBVY3gANZQKkimLKItcqnJP4Taya2gbpKOIJovOoVimOXCG3jvCv/U8oOH35EFuwpfcUy2oasfIMGqcIRHW0YocUYSgl7ckh1H+40bDbFKFGgj8ReQ9cMXQ4I4MgzP3Ixj7I/LW1Q9UdcYKqSZAtl99fAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JNTo1MWUjrrJUr/hHd6Dpn8nonUXMOn6o1yya5nAI4=;
 b=AE9jIVW9hFfovSYI0cAomUcsj9fDlvKmIAp+36CMryIf0BBnXeD6xkfNXoG9Ggcn47KCEGrUFg8WjdvIw/XKIetAdL5ngMAMzXljzz18vd9wbmA+jck56HACSb72SdOnlLIBnNs5CZNRDM+gQeExMEff8o9WZojqB9cnD/QnziNmoVl0rC9gOgSF3RiZ/W01UPMdkSLY/vsup9psQn+uv4SbsxGLoy5aRqNw+kq5UlLaIBt4Y5PWa3oL5Kgsfk9UHLoPn7i/RRqdANKRaa4o0bf7dBykIT5q9zHMfFvys+jmJL+EyyJgd08TTJN//WrQaYUPbAg+Bgi0Vrypts25zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH8PR11MB9484.namprd11.prod.outlook.com (2603:10b6:610:2c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:01:46 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 23:01:45 +0000
Date: Wed, 30 Sep 2026 16:01:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>, <alucerop@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v9 02/10] cxl/pci: Add BI topology enable/disable
Message-ID: <ar2U1hEeFyXa3ZTk@aschofie-mobl2.lan>
References: <cover.1790103847.git.dave@stgolabs.net>
 <d87ff01d77dacc7c0a0d20aaebb1ce906c968b91.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d87ff01d77dacc7c0a0d20aaebb1ce906c968b91.1790103847.git.dave@stgolabs.net>
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH8PR11MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 9448d8a1-6916-4ed5-e1a1-08df1f46ccf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|11063799006|4143699003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tRf4yxEZbsViliNUnCRmTlCv747WPE85/kCrvZvYQCZfQRBG8qmXOCOK3DGGd62AysRCvLk7dQ2pXoxpKHhSah26fveUHG8mK1hIph+kEJqcp2nYXFVzaYeYcqWjTyzZv+RgVWp7cAceCQTBrrNzDyIf7X/gIGNoHZ3FYsH7j53aVyHhJ6w7OQZkC7zQVdqN8PTBAltf41IXSmub5bK9LPBugx3NI9x1zgYKTOz4DPo3xdb4qSGxjpHnJt0bmG9yMtQZO+/EBTl01Hta7LO271GucTJcjjUXfCHqLV/mQGcdldv7j1DOzVBldnuU51hSHvHj/lRuMf7SHNsblblsJv2UmKzmXjOMH4dLoXbyTtmHR2wwhHP7E+hWYXjz7xq+9gj44kODBidW0gXqLtlGpEQGlRAuD18c3Vn5JUnl9VWhaQMx5zFgZFpSA0m7eisjVpwcHM6zwCHXFJ64py3b84uBP7m6AJggYk6X3popNDpwYpYvdhLqhn9XEcWeNOagUnI7v2IF34kIq3zcvGmw54Nqc0KPhVDMXb91+aNYbBUn0fsrE+sSxWAmWDBg9gdmG9Ne9rTrAPpVcTFJc6+dbcAuPxv73AfAKRw3M5qRYfxYIRmZkw00MbDQG1jfaTd6cO50k21oEJ+prPiFtM63kHlYX11/TkVxjj0bGZwdROA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X0IDbI0/QXzcmZwPi0qGQ8KmfDEd+8+RW4WSKn6sGKse4gP/zGMjHqU3XcVu?=
 =?us-ascii?Q?Za/y99NUw9pyQQ1/onWdbJD8LDkbKbDqtX2JPohnwPqdJIEoMc08Vt16UIMd?=
 =?us-ascii?Q?9GZhAp405wQ+7P+7cdRAUOhPzVnrXKbZnFtl5lmxJgz70UK8XoGjWKaqlrkp?=
 =?us-ascii?Q?NiD0QRy0YDf8ykCHEBoD71c/NcxDch3Tv0QmK4e9Q6AJKvCDfWJ92iRyK8QL?=
 =?us-ascii?Q?WaLIR2PnGXkFpDDrhU7jAhlLh1OAosP9EIszAw43Z59r6e2UUDi76ZHBtr0T?=
 =?us-ascii?Q?L/9XMoMVwCyqo66IvXIFL7W2nqey8dezdoVIwymn1QssWiwaa6TKAgv46XDM?=
 =?us-ascii?Q?1F1N3euvjYj88J/bhD8iv3ej6GVRLtficDcCg+QfonWl6tu+bJzk0vzLO9ao?=
 =?us-ascii?Q?4Ax++In+WJrQhwjvJDpshEGQsVLTbeCtMnudW0o6Qq3jHG3ylDoik3toyUOy?=
 =?us-ascii?Q?GadVETDVMuNVMd7Nj4zSqKzkraIsu9ME2FAO7GuyCdcQhirhWRAvJFu8FQ+e?=
 =?us-ascii?Q?YbOGAPB9fW9HQLw2iP/wgeSfaCy83g5/1JkgtcZwiXmeis97gKWzh+0QY7Q6?=
 =?us-ascii?Q?6ZRZnpFT6PEHLSSBiK7ugYVTrF9g9CBpTKrm4Uvay8G9Yr4kPk9SpyGrk5QW?=
 =?us-ascii?Q?3D4pmVb38appH9VZ5diNyAHZzTIEJdkpDK/CcRSmQ4mdSxbC069p2mINEjJS?=
 =?us-ascii?Q?aefSRUA/UsPcWI00yyHmIP8hAtCB6zpoynAv89QRWkFezxUEReNv2EiH8O2A?=
 =?us-ascii?Q?luv4CnS8ibSnRmQFWAurg4EIB9b/Foa4G/hg5/Oo0YtRiOY2xTsKCpEM/7o6?=
 =?us-ascii?Q?DRy3wWzUwmNDGvOr1s/3/W4+TkFwzWvcPDgIFe34afC0m61sY/GdW14S8jjn?=
 =?us-ascii?Q?2JgfYg78fNunproir5jXzZs8ZEQM7dOLQQ/1Mfxf8M+ywuDccyNh5JF7a7b/?=
 =?us-ascii?Q?mhm4q+xVwYvFuxpEQgcoUTkKkJRx9N4yrUDZFBmwgWb7LLjzPEvlAQ4pMV5S?=
 =?us-ascii?Q?K6HFlFWl26JCcDe400AIZEgI/+skbuhGdF5BiKkhqTndxjWSS5awrrq4IqUp?=
 =?us-ascii?Q?6nVZhZlK+p2VJYyRaA+uyZJnv2c06bgAIXCqTLq8z1A1erkctu0hBDHmDxvD?=
 =?us-ascii?Q?pmIH6h+arSjsRp7ST/pbh1Wm5kFrdP4dGmeio9KnPBVSgYJ1qpnEQUjK/MiC?=
 =?us-ascii?Q?n3k5sh5obpSPwfknaIpFB6iGkLB0mf26hjQCXcE+BytMeNwFLACwhZefze4u?=
 =?us-ascii?Q?Epeu8Nrz1kNS71csTdtteR3XkNKu1VzUimblh741Lf3x7D5CkReanneiT35R?=
 =?us-ascii?Q?Mpiz0onPqCHrbYqn8jhHbEPl8Bqbts/32ek9qblU7rQDj5Ppa9OcSF5gayiR?=
 =?us-ascii?Q?50bB8UBK7bVcq6HGsVgIgmM1/yc5sNODhlZDzIdMFpQFPwRA93WOnqpRq3os?=
 =?us-ascii?Q?3AlwZ9BvxAeR6t187sZGH76xO2R5CLmK0mVG3dE9FUYwzrackGEVt8yybsoQ?=
 =?us-ascii?Q?VNyYtH5v2ibeftlEHw5Hj9yvEHXZmzEsHJ79YXNMZueGNnKsfAy9gF+xibHV?=
 =?us-ascii?Q?puM68QIhns66gsU+WCcQlZbWZyTUgMU/bnGU2afl4LL7Vku1OwEQbiZGoaDt?=
 =?us-ascii?Q?ARPDR98LDXlOi5iDqg9x14RAI+zjuStOKQtkozwfFjb/NQQ6i7PFdmb3okED?=
 =?us-ascii?Q?x24457c2Lro/DhClREgmz1NODRmCfBWQG0Egi5vjaYZL5a9kEAwVo83Mq5BU?=
 =?us-ascii?Q?4b+oFx8VTo60koG1f2DC7Tqn9K5AjJI=3D?=
X-Exchange-RoutingPolicyChecked: 1xRXvsiV2Td9fKzpvEcY0lyegRcGZ589yoIsMKTirVsGdUMUUU0QgTBA4GNkaDPAv37U6v0ix6tXHPtZyLjhNkjUS8uOb27KEDNTFayavpeMGLC9RKGoC1zITNCS7reb6EnTRRHAjJVtFjxj8GJx9DxP96vB1iVBseyEQCIZvJbkL0pzRfFTt/uBJgoCooJxb6S6Ky6FrrqoWZMvNguNWZYvIchM5uayMTgaK6QFO3Up8747t7T/SeIUZJuMZRE9Tk9NRITo7/VKzvq8AF92//S5MY09JgoL5mCIN3GLFvSIUaLfTZuMEWH/btAj2eXek/hQtv6G2kAWQiOtSOVIow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9448d8a1-6916-4ed5-e1a1-08df1f46ccf7
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:01:45.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4cL4CHx35fUOctXmel27PAkMCyfGYx1tQc9avVcFPWgjv6fx1/Ze3TtstD2tXUHbbeQyTomp884jhsTaUx+NKpU+mMRnfgnul5ElSrBJUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9484
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 04:38:39PM -0700, Davidlohr Bueso wrote:
> Implement cxl_bi_setup() to enable BI flows on the device and every
> component in the path, and its teardown counterpart cxl_bi_dealloc().
> Setup runs from devm_cxl_endpoint_decoders_setup(), between the
> port's HDM state and its decoders. Registered there, its devres
> teardown brings BI down after the decoders quiesce and before the
> HDM state is freed, and BI is settled before the decoders, and later
> the regions, are looked at. The BI-ID and path enablement belong to
> the endpoint port's lifetime.
> 
> Setup is safe in endpoint port probe context. The port probes
> synchronously from cxl_mem_probe(), pinning the memdev state the
> walk consumes, and the whole ancestor path already exists with BI
> registers mapped (dports at dport-add time, the switch USP RT at
> first-dport setup) because devm_cxl_enumerate_ports() completes
> before the endpoint is created.
> 
> Dealloc is safe in endpoint devres context. Both setup and dealloc
> walk the endpoint's parent_dport topology rather than getting the
> port by bus lookup - an ancestor teardown delists the parent port
> before the endpoint's devres runs.
> 
> The topology walk is stable as parent_dport pointers are fixed at
> port creation; ancestors cannot be reaped while holding this
> memdev's cxl_ep; and their own teardown frees dports only after
> the endpoint is gone.
> 
> Likewise, the device state outlives the walk - cxlmd->cxlds is
> nulled only after cxl_memdev_unregister() has torn the endpoint
> down, and delete_endpoint() clears cxlmd->endpoint only after the
> endpoint devres has run.
> 
> Each dport is programmed by its position - the one immediately above
> the device takes BI Enable, every dport above it takes BI Forward
> (Table 8-157, Table 9-13), at any switch depth (Table 7-97). Any
> level can be shared, so nr_bi refcounts endpoints at every dport.
> Registers are written on the first endpoint and cleared on the last,
> but only downstream ports commit (Table 8-156), once per endpoint
> (Table 8-152), and a failed commit undoes its write and commits the
> undo. A USP advertising a BI Route Table that failed to map is
> refused rather than treated as absent. nr_bi counts only the
> endpoints this driver enabled, so a level can be cleared while
> firmware still has an unbound device on it.
> 
> A reset may wipe the device's BI Enable, whose reset default is 0
> (Table 8-157). .reset_done reads the hardware rather than assume
> which reset ran, and invalidates cxlds->bi, failing closed with
> recovery by rebind as for decoder loss; dealloc unwinds the dport
> refcounts regardless. It also clears cxlds->bi unconditionally - the
> endpoint disable fails when the hardware already shows BI Enable
> clear, from a reset .reset_done never saw, and the flag must not
> outlive the BI Decoder mapping it describes, which the endpoint port
> releases moments later.
> 
> With dealloc in the endpoint's devres, delete_endpoint() already
> holds the parent port's device lock, so to avoid deadlocking, add a
> per-port bi_lock, serializing the dports that share state (nr_bi and
> the control register at any shared level, the switch USP's BI RT).

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

