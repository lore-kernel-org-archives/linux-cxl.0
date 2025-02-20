Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361492AD16;
	Thu, 20 Feb 2025 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015000; cv=fail; b=XeK6Ie1TvH5nk9ggJcEA+ow6o4yljPLBH82MsY4kJGLWzxRFifuFb1d3KJ/y/ObYaONxENoYQcqLt7jGaTGq7A4tiR86bF4SE9AG+DFu43xiDjFLEHh+UxshJwaPY2AIkIru41GzmLretlYYH9XZ7QRir44ubyhGjtTNAGmokH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015000; c=relaxed/simple;
	bh=LnOI8HKGV40qInwg3JMMrazJTCytR6frjCG9rVfLlzY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aGAlK5vUQTH7SeYUFpSo/6FB7iSofIgNxZJvQR0E3hTJG4jOdP78/I8Jv2d0WEnyBSvmM2eewW0p4jOeN3x9wcbhAXMmGPCWT4J+zYJeqmNmgK47TziWLUkaaQ2VHhShVSjC+Ro8ltVzMPNgxJw4hNMEsqQJy7l1+OHsyShfcQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZxNx5Ub7; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZxNx5Ub7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740014999; x=1771550999;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LnOI8HKGV40qInwg3JMMrazJTCytR6frjCG9rVfLlzY=;
  b=ZxNx5Ub7J4QGrU3wezdt5mplPmCrCVS7hsIfEwN8EFTDZ79dqyOou7At
   bJLXiIKpUwov/e6q9/+iH4le5225JK9uE9Rrin6HaOd+wKOff2fGYhZnF
   0LlaAj8v8OVYpo3INu1fga9A7VmtAtxzqkaTW5nOkMNAORtMPJdxq6jtl
   qUzAnxLwCpsDeA2O/Pj/JJJk0RwqPMdPdhb0jEUZXCjlpcKI3WbeU0/OI
   xzXglrXgM6irai8Y2ViJ5yQy/kqFD+FfHNP6ZtHIzL4kmbmShT+yFIvaq
   H7CkOMxtF/JDuE8TeBBxBqLZ6KSh+4WvprnZWauWNhKim2wQB8W6Oe7tU
   A==;
X-CSE-ConnectionGUID: W/nof8S2REyEMO+L41Ejtw==
X-CSE-MsgGUID: ut/RYbkoQfSoCEq9lr9S9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40634238"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40634238"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:29:58 -0800
X-CSE-ConnectionGUID: movBOjvrQti9wjdOXLUkMA==
X-CSE-MsgGUID: H4RKmubXTI+vfbBrWdVuzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114729684"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 17:29:58 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 17:29:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 17:29:57 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 17:29:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGjA+M0Uscfau6QSnlYq/JpXlMOeugaGevoWMViF3yuwuTLnhBL4K+vbRE21rymImYay6TwxW1pVPsXOpFqbpEvT6dj+m5SKdEVUAbu4b2hIhcFOK4BkkZjOSxZAzfxdB0TzPQNdJcF1KeMVQuP3/l5s/kWmpQ6ueyeUObkQP4my0qtGcVjapbxBnn7FhoaHw7J/LL+iKXxTRZWCxVXkKK6qssdelTZ6fCfxMm5s01y78h2qx5Dto78oawLj3CPba7nYTfAyAaoj/X3VVMioPWXX3jkUNa49sPBJXsbrE0OCK8eQMKoKZdIBedfhOBuHUQq4rZAxe7KraG2AxqIPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4quAe9hFZ4WrrqBM0ZVKXelj0jsjYKzeWduMH3H/5+U=;
 b=bWyjBp0Fe3Fxw28auA8UFbViOn3HOfh3ww1Kfl8SYnPsAErztkCsrun+I9UZ4K3u4Q+YNdxz9UdrhHB4bhNtlhUkWfTBFPd7+JmaWfBjUEcq5Wq62AqLCG0+gaK7IqQmAsMKREEW1KlKYA0rmk9kLrORBa595wkqU2mZzd3+4+WXLzOvIAYHb87Y8xDUsybAix9TofA2mVweBj4hXyBfooUYzdQlc0zpQybNe56hUK2z/AhK0rf15Pafc0h5of990nDBbNjKMLpTJNrUENbb2uKf1hwWonP/IzaYb0mhNfuW3hfFjohKgu14+0Va2cVAer2SO+QH1JAVD3TLIMZC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8194.namprd11.prod.outlook.com (2603:10b6:208:477::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 01:29:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 01:29:54 +0000
Date: Wed, 19 Feb 2025 17:29:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Li Ming <ming.li@zohomail.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2 5/7] cxl/core: Use guard() to drop goto pattern of
 cxl_dpa_alloc()
Message-ID: <67b6859048d26_2d1e29482@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-6-ming.li@zohomail.com>
 <67b67f05f0a58_2d1e294c6@dwillia2-xfh.jf.intel.com.notmuch>
 <55f67727-ed24-4ac4-97c1-95b65d110daf@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <55f67727-ed24-4ac4-97c1-95b65d110daf@zohomail.com>
X-ClientProxiedBy: MW4PR04CA0287.namprd04.prod.outlook.com
 (2603:10b6:303:89::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 90533d8b-ebc9-4878-7183-08dd514e144e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/y4aNYxIUFjNOumTggBzX8j6qxnPRxvzR5Z/HEn3tQGDulcoRZvccMkyNpZO?=
 =?us-ascii?Q?Ke/GJBIt/SG0MQSyAt6DercUSknKGUa8eAgqB8m6KR+aQVXdejMbUIsc9/tl?=
 =?us-ascii?Q?s9XFgkd7zb7Rak70znJ8GzkHYp83a1iKcAYb8uvqHtFh2OqJ8/3jisRqI5WJ?=
 =?us-ascii?Q?s579NPgjgA1IOkoh1eaHTnlpE6ltaWLZwAmu/z5AfgcFPWGIXSOnVTEOnEeD?=
 =?us-ascii?Q?GRV2jojhAOw6HSfTlp5NypKEy6NLL73xJ43FUz12G3ZMO/4rWH2Sm6rqC6jB?=
 =?us-ascii?Q?qiKKgaA0Goqi/VY3hufvAKDDChZJYdHK9Dpqt40pJ3nsM7AyLQ2YKoqv7FUq?=
 =?us-ascii?Q?YDFIvA4kOJ0N7QELS2jatZ+FnQRtuO0+/+E/Hk9lo16piSdZFhHoPaakHzaK?=
 =?us-ascii?Q?PPOE05rsT6/czSwZKme+s/siz/fZrOWGjVkkdrFaQ1ENK6nAuKzm/3gtTk02?=
 =?us-ascii?Q?38PBto8TwYelPmr8XEJirLU6JzbU6ATh0lNtN2oiKYz1oNwisozG33j/xN7M?=
 =?us-ascii?Q?YiMerxSD9tpDKZktDWdo6/5GewmLN51hSLLR8DJKyQT10E0OxAyi1uzxlk2l?=
 =?us-ascii?Q?QcSJhXOgeHx3s+sLuN2t4TxmwplDfhrwG1pFr1+fSUq4xVL2wVBkK2OOyaF5?=
 =?us-ascii?Q?ilIUMlbzXgU2oJqrRqvlDMOcn4119O7A+QmAdQH1kPYKvH+f8Cj0j0nMFhM4?=
 =?us-ascii?Q?jbz7V3/Shk9GPtZPMJI7MW2Xlm+39keNQzWxAKSc7k5EGT+uNP12kDyDoyMT?=
 =?us-ascii?Q?1E3AjUGQgJhpiCRQ7J6E4AHlPhKAXSkTUfipLc5Uvm4X8onlotU2zmGPv5oJ?=
 =?us-ascii?Q?7nNy/kblNQF+e1vzO+SWJeyR4IQInUpESXL1cKtZUkYgtxjyje+HCqkzxgk5?=
 =?us-ascii?Q?RZMsRRhChonrJJnXqgvJhHrGu3MlkuJltGTRKhZzYfcGOZly+P3GP6n7f1hW?=
 =?us-ascii?Q?frlKFh3Awm8YPpbIVV97//f6btyMckOb4GziZAnwDUaIzHU/2NFyZWKo/XQI?=
 =?us-ascii?Q?vn7CXhuuHtst2/r3OhYLkq8CFawd+FOXxeH1LkQuOQ7G4/kQ5dJ/EyKFrxtM?=
 =?us-ascii?Q?Kk0W8LLjubsTddX6bXXtLJvu/NY4fbBhyhY5o8KzZceto+w8uLZsBsmQiPgc?=
 =?us-ascii?Q?4oen7bFopgI4Qg4S4M21du5k5Z9yKPcEHAgunYWll87dvkeEv6DKyXkY+kLt?=
 =?us-ascii?Q?0YWACXS9JYu1BAmUSiWmcgqfRv4RQ0jhjSkikClfFUM8dqw19SfFO6JYyZCF?=
 =?us-ascii?Q?zoGH6rTP2eLbR0Jh2Eb0d0VMCZpdjEFvTUihLkeoonnpwP3kUIEfE87d3RvJ?=
 =?us-ascii?Q?jpp4yjB90qa0pQSzIfZyVFEh4LWuH9VilwIoUPgrsQqWZtfy1Ggfyr6l3ytF?=
 =?us-ascii?Q?ZWkA+RZKMR6UXpS0yYmL1hUKBwec?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ir3CkXL3AN6EFqHXLXmvJeeQZ48ePw4HTiCN0eNNsD+phc0joyXMVjhL64lV?=
 =?us-ascii?Q?W8+xLZlCHu/Yz5Bz2fbF/voxDFUQWUDNrBaFtCQNKDE0O4auiNlEkIlcEZ76?=
 =?us-ascii?Q?rjLFyXkeiO8OgSjX1U0KGXduAk3xDAQ4g3zXf/W/FsJhs86kGT30rDLqq4pr?=
 =?us-ascii?Q?Ib5dg4gblff/iNmJVfax8pVEjpt3iw5ZfLxDEwPYJM4ICsb8t34tSaAm2qCf?=
 =?us-ascii?Q?72cO++5F9iJojXnYNeQscVRezp8KpK2yw9r4/Bsr0vt5LqpdhPj8Kwcsp5jo?=
 =?us-ascii?Q?bn5fw2IofnIUIKs5WCuaU6jBZs+WaXR7jXiQe5pqY0w95n+uoinKbuTR4/Oa?=
 =?us-ascii?Q?F7L7jyEBGnA1ZOJfuNnOs+e5Ywnv+Ub/v19MqeOfE71FV9eFlIv7jVNH5zg/?=
 =?us-ascii?Q?TouulXu7YI+zhqmWEInyLHqmnB9j5Pld0VRYpEjuTSnpoX932oUoyial/sf5?=
 =?us-ascii?Q?sZ05CULcFl+pKyfK8UlOcFSmHXKFunHjIr27cmWVKsnVNikgqtaZ/8Dqftrx?=
 =?us-ascii?Q?Uf07WuaFmDn+GCH5Bcfq6aR4t4YrZCVHPm1l0rlVZW7adM9E2EgkdhwjHF0h?=
 =?us-ascii?Q?G5Jykxzw7lxa8J69kOBaYTRuAAOfuC/sufkMXI6bxIjZdOEomvdSJPys+p9F?=
 =?us-ascii?Q?eefreZxesY/3C0FEd7/63n58dT973WjEc2gn2f9GnQK8+T3BY0yVb2zGoX1f?=
 =?us-ascii?Q?2CHRelQrsAU5bW/kGW+vI7g9c7VUSaufvaeVCUiATwM2s+GlpzkSGajp4Xpv?=
 =?us-ascii?Q?wtTc9VRyMrqwRcmaeNL3Mw3QExcfRUVHQxicTri0vfdBIfBB6ike8wtmuTsj?=
 =?us-ascii?Q?bco6nzToGNAY4AUjw34V+cHsvASzwtTqg8FNSZ33Rr1/dEO2jUiTi22CGSws?=
 =?us-ascii?Q?ES5X+EiaKmvnkhFews6FcxdchX2zNIURBEu44tNqGBftJfcqBfJxHNC2y/vv?=
 =?us-ascii?Q?kr8Iph/zrFG60v60B/2ojsF4z5lip1Nruyz23mUO5feKY/oXNbHJC+aZG3S/?=
 =?us-ascii?Q?xSixo3WxOch7gBdbXt4AMHDSu9UTD5mD6tkCltaFPq8cLhA+0rZ/xBlK1/bS?=
 =?us-ascii?Q?wr24WFYXli6Txkea8Nzhb7rmYktJmQ8avSPBCBGNYNwIaJs2s8R7M3B0lu5X?=
 =?us-ascii?Q?eAD7FWTjgtSdF/dkKRQd4Un7DYvVqrkjggISNYGYKSOZ2FaDw5avIxdEG8mo?=
 =?us-ascii?Q?lRtYK1mMwj4a+5DXmEXkghJcX6Qg/ZvuJYuiV8gnleKhBpj/NS7Vx5ReNzNt?=
 =?us-ascii?Q?BSsslUhxExdaCCsiGznUVVavvbgN9HUe9GFlmgd/7eC0sx7WeHNALtbNailS?=
 =?us-ascii?Q?klpL7XTW1r3BhOe+yv8bkk6J35MNlQEBhYbW/6L2Y6bNDphfjS2undkbq/iE?=
 =?us-ascii?Q?fhxOt4fOKGDO+tfsbVSxZo8ubhtLlYTFSkXgio9FYE5FhpeG36TXA8jdhqJf?=
 =?us-ascii?Q?HKNUFXweofkaGGxacNPb7KgMfoeLnGNP++wZf56302S4pNxa7ep+S0pQgeTP?=
 =?us-ascii?Q?sbd4IdoWyLHPLTbnDKLwhGiDnsZ891Kq4vVYpVXvgMC+XDPZnMS1pNlz+Uzk?=
 =?us-ascii?Q?Ma6Pl9qMuDJkEMi5j9hv6kTspTKO5fMXoXiLjNkWSd8ys0d3DN6PRH1telSp?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90533d8b-ebc9-4878-7183-08dd514e144e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:29:54.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMLuWUEvGLgK0ZCGG7BctZ/JKn5RKJBusvgGpXfbQ3pXDSjTk7/iJtahJ1U3GxsqFXRvvUoWiWCJiMCFjBJLuG3CP33a9dgCGNWydgjPQOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8194
X-OriginatorOrg: intel.com

Li Ming wrote:
[..]
> After __cxl_dpa_alloc(), a 'devm_add_action_or_reset(&port->dev,
> cxl_dpa_release, cxled)' will be invoked, cxl_dpa_rwsem is possible to
> be held in cxl_dpa_release() in devm_add_action_or_reset() failure
> case.
> 
> So I create __cxl_dpa_alloc() to hold cxl_dpa_rwsem for the operations
> needed cxl_dpa_resem protection, make sure that the cxl_dpa_rwsem is
> released before devm_add_action_or_reset() invoking.

Ah, got it, missing context, makes sense.
