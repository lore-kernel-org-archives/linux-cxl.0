Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8C4430
	for <linux-cxl@vger.kernel.org>; Thu, 21 Aug 2025 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736686; cv=fail; b=i2+EBsa3GnKYrHpylAnqVzyRRPgA6CzLoMHmKfNfN9ouCy/ND77/aQ7t+hayBG+b1ETR7ZELZmWrApxhKtY6Ju/6oS+p+uMiR/HPiVMBwm3yDp02wFviNm9EevLjjb1ZnA/AFw8a/Lqa0Fz0XDcTgx7SOzSvJjvTCfprLPT2hFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736686; c=relaxed/simple;
	bh=W/zpNOMbT/Yoj2ihjhpGlM3ml5QQ7WvLWMYWcvIlsuQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SVOIyfDwDiXJ8GgZ6X1fPJOZKYbyY2utZfd+QvDm/z9+5U0vZ4aRpw8zvSf49+/BUCvXV013kqNzsnOXPsu196k2S4CsBPe3qFZNcwOtasbBRNzw+Mk9qTX+10DKrYQAmq5dQlL8YdI0MJW0qvIfbTAfzOudqxmPh0L4HHQtpH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZtoNNg5J; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtoNNg5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755736684; x=1787272684;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W/zpNOMbT/Yoj2ihjhpGlM3ml5QQ7WvLWMYWcvIlsuQ=;
  b=ZtoNNg5JXxWK2VFRq7gvNhmWjY7n/homVVg18dtrP6XQLmCE1qIqnxIh
   1T0Jy09KO67DmJP46UMm5Rxo4kSdyg5Bf2BpdwCdy8BPjKnHnKJZGO/RV
   tPt4nJIU5uA5pKrihJ0bgvsCdG327R6f1pGjrymKiFGy8An2sluEfHwHj
   C2lhukQF7v32caLEceWOOnVnN1AVxxjVt2kQ5tz9hEwvdZR6C/PlU1O60
   YspEi7YODkvPslEX4C8yiQ0gxTlMohZ8V5w7uOZSzlULjq+CrQLGcUVUf
   05MvZ1MgAti49rcWKLqodhsalaPaAtK5MYXUlbT9n+vlBrT177x8icufO
   Q==;
X-CSE-ConnectionGUID: NlijzRNDQoeDoo6YR6QXcA==
X-CSE-MsgGUID: QtS+VwooQ8ac/KjTi769xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61828875"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61828875"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 17:38:03 -0700
X-CSE-ConnectionGUID: 0cBA/d4wRjSwyGZXQOLSOg==
X-CSE-MsgGUID: 0zmHzrYiSgy+PKxwyGofGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168204027"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 17:38:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 17:38:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 17:38:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.74) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 17:38:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ew1UD7saMu35tS8Om0kQ9Jy4MsG/JTU7BPvjvFA6K+E2XnPFAXraUf8uH44Dd8beGzG+M87yrQVxXpK/B66TjSspSHhF7Oh8FdvLE6X40v5CEGMwSXISzT6lxhMmf6rOyC1noFcHxlgon2Qunamc7kKNdDUbiDbizPHjiXTYzp48EtsmFQGr8niYZndug1orYmvMwA4CtXgpyumPjKn5V4+RFNQzXFlGvMmXDc/177Mm5smB8Lzp34d3a99PaN08Z5jKoJxzf4N33Smuk2qxjX86qD9vIjdLNMXNeqxDr3zsi0rShghSlBB2xXcxoe4dz5vFXWE9mStePyN06USfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmkQPdutHJZR/QEJSc/ZvxFQ62+HygAgxtYb1sBDRXs=;
 b=g2s5x6r//7LQMiZg58zbX+EANAFsGMy6AJnDvhqdvd3SfJikhV3BaLPHCb59/S8frIL54umM4MD9auYBhzwRjrYvTuB2U5sg6PawX6KxdX+gGhqWKOLK/FZ7ILraAVIppybeNonitl8YA6l8giCZ2FjmunD2oqphS8gVCJJA5+gjErfg6bElqX/3IlOpb7mV7//vIYqxR8woaH8XMhX/Pvb6Wumw7S5w4PNeF+Lu8bK63Hbv8olGyGJsQH/B9DQqxBOidwi0+rtmQUKupGTUwEEp+8s0HBcS5xcM7C2fGLUkyBnmE5NUF3clO3RwNRUKUZlWXogUTBb7bRTJ3pf98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB8343.namprd11.prod.outlook.com (2603:10b6:610:180::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 00:37:56 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 00:37:55 +0000
Date: Wed, 20 Aug 2025 17:37:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/port: Validate decoder nr_targets against supported
 ways
Message-ID: <aKZqXJfNn-Ei6fkj@aschofie-mobl2.lan>
References: <20250813214218.2917555-1-alison.schofield@intel.com>
 <689d348e41a66_2709100cb@dwillia2-xfh.jf.intel.com.notmuch>
 <aJ1UJOySCoM2M_-M@aschofie-mobl2.lan>
 <689e1e938b5e0_27091002f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <689e1e938b5e0_27091002f@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::18) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9aa925-e1aa-468c-129c-08dde04af845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cUg63Rtwvw+BQccg9hVfRu2Dw0Gnl1O5JYCLSLlj2+z62irO/YWPMP/Oewz+?=
 =?us-ascii?Q?76nTsA/fnOHjvPgI5knrPFeoZXKsC+BSYxvd49ooE4GX3CZSXBY+z2Y/F4tu?=
 =?us-ascii?Q?4JqQBFVnoRInmPSY4niQJNipkF7nT90w5AV+dO7Z+qQ74D+If2qGfuO6D1FL?=
 =?us-ascii?Q?ROJ8HHKCmdTHJtTDaMc/qWpsOibUMh/A01T6B52YxNz+WpEwoWDxTmG61a1G?=
 =?us-ascii?Q?tglo6vLBg+uypaNKwAvYBdbrcXuGUdlCLh0dIFbbheoNkvYRxK5/zXeLPYG2?=
 =?us-ascii?Q?2s+WMfqETrFKfLewdc63d7Gb3pt9x02DuKTwCbD7oZgyBIKDWUKu75UW/Get?=
 =?us-ascii?Q?mTr0IwbBkzrviow1xqmD11vXBv75auR71qpNUnWajR/BKHrU7qqFekdLvXSI?=
 =?us-ascii?Q?4KlF+D3Fbd1Pm29ygQROkc6RRA+E/oJCoa8hab3ZhQwaTCh+lImzEDxvt1DO?=
 =?us-ascii?Q?jkg/AKKdwFlGoxHp/Syc+vOQj8s6cARBZd0HMdqepXs7OexV1w/wCaYswn8G?=
 =?us-ascii?Q?9aXipYmhjFuoDdxNik7l1dNvmltfh/by76WZQHnuNxLigDFUlftRhgc2brV7?=
 =?us-ascii?Q?wSs5tb3WSTObcC/VIH0dKKX6KbhzLES5Q8HBcIhhB/f5n1UfF9N5MdlMZevz?=
 =?us-ascii?Q?DJaIFlsOFRPnK9acrbWoB28TCEPEE24PqUA6EpNMTnCLD+BwCXRZx133IJxF?=
 =?us-ascii?Q?s8ifC7X3dkKUmL/TXJs5vVkgQKAeJrVjwSnpGh7fZxskB4yBZxwple5PtcCK?=
 =?us-ascii?Q?Q5h3jnriUljeMqbbsPs9C5W8++h6fBdFosd8H/72qjNZT4o0PFcpPVhUITig?=
 =?us-ascii?Q?WOvzQO8/+R87WtquqUtNagXVMFpuicAj8xT+Wl+T/g5VQtUSr6KuIay3xJd4?=
 =?us-ascii?Q?lHvsJ876r0AgwSIEMVrz++eUuj4t2NMRvTpPjmLUBzjA0dN+sZNZrk/io039?=
 =?us-ascii?Q?N3JVlp/bCw7Z+lAc40thflsG7vU50bPT7RZWPknRIibpUkw0IPJPWLPZenAS?=
 =?us-ascii?Q?yrc/zIggou+VumEIe0LH3+Yr5p0uRffMGHHrY3dr+6B8yErIU9nriLbgQ/5j?=
 =?us-ascii?Q?Gg+nFRX+U9vubvuVEkvcHht8WdBRkVlTCvxrzS80vUPB7WxTYa9r7XNn1vzO?=
 =?us-ascii?Q?4TehBVPxuy0zMKcxyAGAbp9/CqQJUU2xE9XYmCqAP6fp4Q2/vDnsJgTRkFt6?=
 =?us-ascii?Q?J9pDvA8mWeQGDEuuGVeyPPD8oQcLTItyP3pYXCTidVPBKYVxFrr9djtjH5ck?=
 =?us-ascii?Q?nFKeSS78jGVE5fg6j6KBJSrVsRQDmqFJtfkQeXCERI1Ueejg3IVtoZurusn5?=
 =?us-ascii?Q?4osxAv1O742FFCak2ztQBZnSxLYqHVfFpV8rA9EXj2rcxVRwP2H2nq1RdEVT?=
 =?us-ascii?Q?XiJ15RgwNQJrS2lYghDsTR2BrJ1R48HG0kwfzoReqxPyMUskOj+Rhq+gpqTk?=
 =?us-ascii?Q?aGDs4pji5io=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xMwSdESHjrWCoqsjkEaKUDAGuQlE1VZF8jUraN+0iq5uIBMoyo8tckZtBtgD?=
 =?us-ascii?Q?UK+bCocmVDlPJQNE0RRIOPPXJwUM8UytC1Xxa99fBjtqccvQRiYmLRHjFGR7?=
 =?us-ascii?Q?8ljc/R2EAo2nGCKOWDs40eC0ibpURzpwxudbp7M+ZYdorzMmTWArroI1I4b2?=
 =?us-ascii?Q?QBrlImL1CAgsCG4dOWEdSWr2srvj0KnSDXYeqiIDMw8s2usGlwdcH6tn5Htv?=
 =?us-ascii?Q?wK88xEh7QAWFmXffJ+zYa/HoShY08MGsZyZJz4OHcE5oZfiaRJR+3ZFTBkB6?=
 =?us-ascii?Q?b8BLoRUqFLGvURVs3+rwQiPdat5iVKVIdIPvdR7IaQqAi4NL7ETjWCT/yCG8?=
 =?us-ascii?Q?djT/57WoCXqFNayc0Nnb5zMfrNffFYCAaDJX+hKPbrOyDSIuJ5rJnCEFFNaY?=
 =?us-ascii?Q?IYbOecSD7BBojvqY2E+5ymlACrcycnD4X6suaUb/6mBZVM3cZJDLlNc1TaUu?=
 =?us-ascii?Q?qQ8t20i3Oxuti6prXGfPh8a1xZxsZxBxOh4IsmmPtu/ASz51DyV6nIQVV8vL?=
 =?us-ascii?Q?6CWDrv+7MbK72B3Al3v8BOB8OuMq6F0qSojLeh7vcuhwuCBSx+f9T0CDgR1x?=
 =?us-ascii?Q?gr+rXJJJ6siDy0znvOFxQ7scvaGx+GIMWyfe3A3+8qxBh7Yq9hwLZVSA2cnm?=
 =?us-ascii?Q?AF8uPq99NVuuP4Def8hL1iNs1YcOBIbeFpEZl7q1b8gg6vk4YqZGixAVbx5N?=
 =?us-ascii?Q?T8zzBLpkKR7tQakGTPQVgRCjJwuhIUV3r4K4qPsc7iVTYMQgbv9UXCD5xbla?=
 =?us-ascii?Q?icPhLqqQ7o3pL51SDHNEeiJZA3dhJl6Fyr5O/tYhB6BL1bgV4Brq1Sgf5Xyo?=
 =?us-ascii?Q?MwnteRF6aLO/7ZDrTWY6zJvoT7tasdK5dWyYpMgoBMvl4GYlTap/G1OoIR3t?=
 =?us-ascii?Q?GH6ze+WS8mWiROeijrPIoaZMuH2iM71chwIklunx5MUgTVKLg+7NDbBi3366?=
 =?us-ascii?Q?t/h+mWtVCjuNpJYdsKuYAkyXVVT9zz2SVJRPSOvqZFKHr/g1qHMDJxodHK7S?=
 =?us-ascii?Q?2tBoPH3poxSuXxkyQTxsrnisTOR0iQiDjDI4kEmzwUZGdmmlf5NwrEiehjIR?=
 =?us-ascii?Q?JqoFAAXJEhXlavFu57T08p0sEtwsO9ozRs8IogeK9b9T5UMjYz+eyaDBmIpD?=
 =?us-ascii?Q?2IvPW8u4rhsBTqlUarVeHYb2hCdmqPZaQllZxovuwaDQj7GIY/FajBIjKi11?=
 =?us-ascii?Q?fF00zk8zud28Va8P6Hynvu/PotPStUusnfwouOkJcHH29NU4xtqW11Z1FED1?=
 =?us-ascii?Q?3U673Gn88PpbjGWrzpBEpy0BCw5FDM5yc+QKkDxDvPdhdd7zbzzRLiRq4VTV?=
 =?us-ascii?Q?riXw+umnhNNx4uQVf6ql7/FfgF0rHaVkmMZZq8uiJ7/Twzxm6z/tkhymlgWj?=
 =?us-ascii?Q?lyFpBI4AXCQgQ9601iQSBbvDSZGYJpdQ+oMdPjmSH17xPCSoRRBVnB+ngktB?=
 =?us-ascii?Q?dsk7UnsD50yzPT63ga2n1ohIz9CQuzfEXLo62EdC4kVc2r2BVktO7Kq/O6l9?=
 =?us-ascii?Q?7g2/VQgecUGkgCxuVFQEDuQq1jOTOTEv52ONTyTAKsvxAlwCL+6z21MMpaiu?=
 =?us-ascii?Q?gyVUabzIIrdXUNk4/Kjc6Xvf52p3eYIUkwAtDbIiO9C/OL9rZen/5SR4rdII?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9aa925-e1aa-468c-129c-08dde04af845
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 00:37:55.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nycawHjxBxAlvvm8cuPX044POwefT0ITOrEenpzngzFqriS29R77BBQEUgGk/jmKhTWSip1PmOfH01SV0TmjaKV+Csl3AupAApY/dlF4zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8343
X-OriginatorOrg: intel.com

On Thu, Aug 14, 2025 at 10:36:19AM -0700, Dan Williams wrote:
> Alison Schofield wrote:
> > On Wed, Aug 13, 2025 at 05:57:50PM -0700, Dan Williams wrote:
> > > alison.schofield@ wrote:
> > > > From: Alison Schofield <alison.schofield@intel.com>
> > > > 
> > > > nr_targets is the number of downstream ports in a decoder's target
> > > > list. It is limited to the supported interleave ways: 1, 2, 3, 4, 6,
> > > > 8, 12, 16. The existing check only enforces nr_targets <=
> > > > CXL_DECODER_MAX_INTERLEAVE (16), allowing invalid values, like 5, 7,
> > > > etc, to pass through.
> > > > 
> > > > Add is_nr_targets_valid() to check for supported interleave ways using
> > > > ways_to_eiw(). Use it before allocating a decoder to avoid alloc/free
> > > > churn when nr_targets is already known to be invalid.
> > > > 
> > > > This was found by inspection and hardens the code.
> > > 
> > > Well, now seeing this and trying to answer the risk question in 1/ led
> > > to me to reconsider whether this is a good idea and whether we have a
> > > deeper confusion at play:
> > > 
> > > 1/ "Hardening" needs to come with an actual risk claim. For
> > >    cxl_switch_decoder_alloc() the values come from hardware or ACPI and if
> > >    those are buggy all bets are off. ACPI is already protected by a
> > >    eiw_to_ways() conversion prior to calling cxl_root_decoder_alloc(), and
> > >    hardware is even more accurate than this
> > >    approach because it considers interleave ways capability.
> > 
> > If all callers comes thru ACPI then agree no need. When you voiced
> > concern over valid host bridge interleave ways, which would be the
> > nr_targets of the root decoder (a switch decoder) I imagined you
> > were thinking of a path to root decoder alloc outside of ACPI.
> > Guess not.
> 
> I was looking at the patch in isolation and wondering out loud if we
> needed something, but now upon seeing the patch, not so sure.
> 
> > > 2/ nr_targets != ways. ways_to_eiw() is the wrong validity check for
> > >    switch decoders, nr_targets is a topology limitation, not a
> > >    interleave_ways limitation. As far as I can see nothing breaks if a
> > >    decoder claims to support a target count that is not a valid
> > >    interleave_ways number.
> > 
> > nr_targets does not have to equal interleave ways for the ways_to_eiw()
> > to be a useful helper for validating nr_targets. nr_targets has to be one
> > of 1,2,3,4,6,8,12,16 and if it's not ways_to_eiw() fails. I saw it as
> > simple code reuse.
> 
> See "Target Count" in 8.2.4.20.1 CXL HDM Decoder Capability Register.
> The only hardware valid values today for target count are 1, 2, 4, and
> 8. That is different than ACPI CFMWS which can target 1,2,3,4,6,8,12,16
> because CFMWS has a tighter relationship between nr_targets and
> interleave_ways. It wants to define regions that target host bridges and
> non-host-bridge targets.
> 
> The next question is, what if a switch decoder put 5 in its target count
> field? Would the driver need to fall over immediately? I think the
> answer is no. It would simply be the case that a decoder would set ways
> to 1, 2, or 4 and select from the 5 potential targets.
> 
> So, I led you astray to make this a wider check beyond the root decoder
> special case, and even there the risk of it being a problem in practice.
> is low.
> 
> > I explored using cxl/test, changing nr_targets at decoder init time,
> > and predictable passes if greater than needed, and fails when less.
> > But it's not a thorough simulation and not worthy of a more detailed
> > simulation.
> > 
> > Thanks for the review. It was a worthwhile exploration :)
> 
> Thanks for the patience to work through it with me! I learned something
> about being more careful about the nr_targets:ways relationship.

I'm back, but only to share what 'finally' settled it in my mind. All I
saw was that CXL_MAX_DECODER_INTERLEAVE was set to 16 which happened to
to match the max region interleave ways. Dan pointed out the spec max
of 8, which made me go hmmmm again.

I had grep blinders on:

grep reveals this:
	cxl.h:#define CXL_DECODER_MAX_INTERLEAVE 16

reading the code reveals the well-placed, yet overlooked comment:
/*
 * Current specification goes up to 8, double that seems a reasonable
 * software max for the foreseeable future
 */
#define CXL_DECODER_MAX_INTERLEAVE 16

Got it now.
Also, with these small numbers, and the fact that the decoders target
count attribute only gets 4 bits, I no longer have concern about
useless allocations or alloc/free churn.
