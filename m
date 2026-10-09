Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63113C09F8
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572616; cv=fail; b=qlUuf/R1pYKqdctTT4nzuB23az8IjpwiFB5Q1Lm2J/q1BEZ+3jqjuWmHOg4ylE6zyIh1QGD9uji1eKbSdpo1iMGn7f/yBgasNiY0WhXKOfeCC2t/jX0RV18hBxcriNvhkv85QdmWMP8bg7TBogUPNCAYnNWFZJR1okBwxIi3Wuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572616; c=relaxed/simple;
	bh=5ybO8ScVXU9/wu7yQvmGqLQiC4iX5dGhDOEB8Amdja0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pvkvvV+DljDYEXOIf0f7Y7hTfHXhJO1Nnh9VvddOmZB+dGvp0gkSOiA6h+EMLaPz8rRQrTaPLWIadn44CMCS5297sIfv3k7nxhZllG/aZDBwiW4tH/Lf7F5Acm3Hf2CCEMC25x5tud5OFPRIU1HrVrSTyjDXJEqhKgl3QsmY7pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncZHU8yp; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncZHU8yp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791572615; x=1823108615;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5ybO8ScVXU9/wu7yQvmGqLQiC4iX5dGhDOEB8Amdja0=;
  b=ncZHU8ypqBJlWuOuuHoNqwuucZlEeg1R8FT5LQrbNClij9wtb1+U54OH
   OnGfLDHeWJBgiiCbybwoRIFC82MSi5GEwXfU7wFhrqtfq1DpvuHVvwcu7
   60PrcZfE1CoR8Z9///mNuRjfM+4k1PmgvV7Q+oicdUwgmNbIYuIckPnKg
   Nf61YCjOIvN+4y32u4qJV3RxX5Apep3uCOXloaC+rS90IzVAa+W9173rL
   oLE4Jw10M3/g2tCGw6wGdhbtgcsgFrS2FEHqOsGXjiILZoBrLqytq25Ml
   jpE9FreooiDnOeke6bkBZmcz9GKzF/0ujJ+hf8YqWjMHOqvt+H8fpa61k
   Q==;
X-CSE-ConnectionGUID: IaXbhxNFT5CRn/xRayk5KA==
X-CSE-MsgGUID: Z+Y/ITX/SOqUQ4Wac2tk5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="392146"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="392146"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:03:35 -0700
X-CSE-ConnectionGUID: HGthIuwUQoGjAmIWKNSs6Q==
X-CSE-MsgGUID: jk+1aj+QQXGT3gyYV3RSUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="499313"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:03:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:03:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 12:03:33 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGSqq7bxUHw/8rW3TJqyaQdsKnMGpEvicYaUZDmq7PvbC71t46f2bOiXSlijWfA8l/VuB/S8v4xA+wjMKX3ahMSVwGo8p9DaDAuSzF7J73c++O9m/b2a6A62SObbJQ5aA3bAnsbxun9p+MDTLM7BvF9KbBXE2c/Qr6lJWgMvEvTD6PC9h8SmVaMo6v35J9Fg8XeRH3JvxmnrKJB0X7iYattDbfsLuu6fLsXQYdxUearaGVyeFu8VIBbYku6zWq6mwjDsviWrsDfzl83QebZpQtL55wpf3YJNqWMGnemRBmfKmYmRgROrSjXQLmc3mbMuEg/n/vdAUHpx1GsmugKX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++VBXVxEcn4JkijKxW6Ti68ElhCADAhhq0CVJM5oczA=;
 b=fEW9Xbwu9oSvW+D5q6h4VvO1V1dmDEtPsmL+znfX3GspJcHiWP0CHtomSzLuiqPv+ZGqGUVl9sTWVUWwgHzbixQiCzWWrypMD1ACGdjKtgtY7niNdC9VFzO+eg16KUnIcISntrlnjEVe2bevId4uBRs+NHeayGLfacj2UOsfVz69KyVtIw0Bf4OnuRFw1V13X4vzpE8B+po3hdk/SQAvQsZHCcJzrIYJ7S0mM84TLgWzZZPqMaaIkQhvyZZnTo0ip3CQwO1/RYmhbUwfhZrs0OJoph4RusGd7g/rwgHnWRmpf0E5Ed/9Y1HhXErtdfaAowZLU10Easp3RwrmVYGCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 19:02:46 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 19:02:45 +0000
Date: Fri, 9 Oct 2026 12:02:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] cxl/pci: Use the Device GPF DVSEC for restricted
 endpoints
Message-ID: <ask6UqwbfxnlF9W6@aschofie-mobl2.lan>
References: <20261008034619.28059-1-kanie@linux.alibaba.com>
 <20261008034619.28059-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261008034619.28059-2-kanie@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e4c764-f66f-4ee9-371f-08df2637e759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: CjkBIVdhG/a0dzI3NkWXnqA2C/PXPFgUb4b5zSELjLhRbHR9355+PU2OmlgJnI7qwmxcJzo8IaImrzkPOtlFFOcdv8oseT4hRnaLPlccX28VM6AVtBK8RQCcVaaHtId2rbtDFKrAE/BR1WtDGeQTphhRvt9UH8OOsHYjHUIO8NoDQHua5KvRal73lQ6YrAjvoTT20rqaVtwQgtg22qySi9WtzmUfum4BMnoRsOeIxCb9WxjQCOlGn18dRFKpIL2k09hkvafbSVUHorkaJ9hgOo3jAc3sbraw5vvOGxIDOZVtGlmt9tO/2ytSjuDIye8rW8m/tqOasEN6T2+f3xmp8unO5QHcwdbyRugt3W7skyxb20R4+yMU/UeX642sQmUZggnpBp+ijdylUSwh9bGgVfRxMXbNTH85G74/MPGsaXQjE7yWwv8ls4AsmJDxhsHnhw1Hc2BVrsXBrCBLumGX/u4J8vXf3r2kEosLBTLV/yEb/OJGDnvn8QMMJ464asA3gyOtm2HWW2f+abRjrXaBvGWbj789AK27gbLz7dUsRgz6hY6eAhBxuWRo3szrgq3oxpRMOvBou36A27rSlwf9TJr0avtfmbLcJAFd9cC5ZmW4wTE8YOji5JQuvFxAWmHxf+KxMWQPOIiswhFTU1eklYigP/c8t5mwDP5N1/EaCXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HZ6Yjs48BDWXuDqQoP7+upIU224PnuLnhWLUltFZ8T6InnkrcZa+S8FhCcbY?=
 =?us-ascii?Q?Mf2KJafff2rbUMY4C+2v8KmSHlq3pwmxQDridxxtRqjH1fmKZ5bnaFyzwPOl?=
 =?us-ascii?Q?3oHUleMF52XUMzxn9l3zeYbmHdkhrf8q/Z4Li63zngfkd71d3SvmtvskFIPd?=
 =?us-ascii?Q?1xfqjCz0pfz1VRrjombreaMEcnQYB4UN/wCExKD9RsnO/nMFTUAD/7ZpZpY6?=
 =?us-ascii?Q?GH5kiwlnWciqIrJ4jYdE2y9iPMvx9foFNpyibWgR7b8n07S6uVYlKmgIzGyM?=
 =?us-ascii?Q?pKE0ldZQlCnGyB2d7J3fo/vv3a69zca3Y9UITnuNK8qtEWEoQWZuNk5MJTRM?=
 =?us-ascii?Q?dITRngKmegtkk8DLb2bBNb5SL8f2IYr9zZ36rle/xmFPi7r7RmkbG3pQMacM?=
 =?us-ascii?Q?ID4Mqp/6cytSjOsBaah2SYlogkooA5lSiBiKH3qChgOjoXBRtLCi/q9sD0Ek?=
 =?us-ascii?Q?Zlw4xN3sczhMdyDHcIbDWMlSAURUa0sB6n6oIz4Y8z3khPpS2SZYA3H3DBI5?=
 =?us-ascii?Q?M87KH0RcSZ/XcC3JBAzxY3vd2NeJpLv35O1WR1zWXLRjEPnPfUxaamX1y8FR?=
 =?us-ascii?Q?RmXeKYV4s8Bfit+tD5UaSIYAKp3dFrLr+7GHIdLHvieL84QRtkeOqFRz2Tv7?=
 =?us-ascii?Q?5OhfiYXJJbTdHKIth6NqKzzSQM2TQb77fUJeVSPZCh7Q9BY9Etkh3fWnngF6?=
 =?us-ascii?Q?sAGdfwdfCKKbkQbvHMPaJcQyw39R9oAtzWL5tDHvmnQSEdip8izVheyzEhCu?=
 =?us-ascii?Q?cZsGrC260xIv3rhLe2Xd7wwNiA5niV0TXrpGLXd+UAaP2FFF363vA/tH8bwd?=
 =?us-ascii?Q?3oHdr/CdgrFbvVEfYUeRXfjJlEeAsM1DJ/TJSMn2iGBQj14jHUe7TfFiIGD1?=
 =?us-ascii?Q?BnqQ6qO4KiJs2cfC0vbDob+PGEpJwQa47XdJBqIID68v9kJZ9b/bS8pBToai?=
 =?us-ascii?Q?G7SYn66/ytU34Ore4RfmBpJ8axquEtp9Myhq+iCP/2tz9uPqsm1pBSfjgoUV?=
 =?us-ascii?Q?2Akus4dm+T3OQKaDcNCrigFlWZHIfo0XNxEXpV2J8EcqH4rBYKLJEDASegq6?=
 =?us-ascii?Q?D0LbSd5UQI5p1LqBF4f/BA6s3gvjSGRb1+rEwQYuH5+phlzmEJN3kBUMXSPZ?=
 =?us-ascii?Q?bzvha5YnCzgMeV2/looQHhxHYgww0uPNHZavRsp1loEAqmjAtZNpruAOjupa?=
 =?us-ascii?Q?peOaviL0082htBIRZ5UMdu01jtOKMRkswTvaX1jadstuEPGsNwUcgIAVM8fi?=
 =?us-ascii?Q?MEideUUSs+2YNblQabhg1dB6zkMvLBZdBh76JwRDBDnfMiCHk9EigGVDx22h?=
 =?us-ascii?Q?1fGv42ROVLz6RxP1xKIzJd0nm67os0Tmv0TM0723aWlaUEmzJWsQva9M0CLE?=
 =?us-ascii?Q?KqpEf6E5zh6giBoRCPK512g/DOSQ1eff3wc7q7gpuqXp+v2uSXDjY9dJ70zz?=
 =?us-ascii?Q?i9yuVEG3qON9MNiyBBtqLRqeoaNeqsWm+067G7ThUzCJnoZr2o4gD/4Dj56q?=
 =?us-ascii?Q?AXHiUZ6S1MHIByJoTL7VjE6MYx/S7XvrRsp1WW1pwrf2OYmoJ1JWFqMdiBvO?=
 =?us-ascii?Q?gsImKyNGafyDPvUy/jnBieqmA2JnqLZx13KzuzHDfupBLsIIDPFLu57ceyF5?=
 =?us-ascii?Q?Gw1Qzl1AqYl4Vh8qhy+kvGIT8MbT7OfnlAPkVgQWSzrr2pjvyeXfwuxwVJyK?=
 =?us-ascii?Q?j/LKksGW3toWkECDA0GTw+LLhmYZ5qATtZ8FzFeTi25FOIQ77Bv6Xvrfgk+z?=
 =?us-ascii?Q?rmo/Z56g9Rj++OkArKqD6/8gAhfwIZE=3D?=
X-Exchange-RoutingPolicyChecked: FJ8I7L2Z614IT6TPia9XeULevVH1DUnlUO4ltSmR6vZLHQnEaHvh6P8oUJuJhpYN+lAcW3JTiwchaeVRisX7XXNVgaAaJoHvS+0HLTBNm8Ld/dJOJxByFrP2WoJZQHawWmfUKFrDYE5Z9klNlCyKZcit+4fyFMobECQjASqmZk/7XPZRWdZK9M94NozA3Mj5RP+JrOlIdkfuwxT0rGkPPtIL6ypOLW/ltcgXqmYTvnswG7ORgFJS6JBjXjiJYW2+//b2xMWjKXDlrNioQyQeEk5VIa3scVcswClKGy6QTLb+z8iDEjNlQ2orcc/x5nBeGVQXlJDvSMJho/dTan6uFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e4c764-f66f-4ee9-371f-08df2637e759
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 19:02:45.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqToQylmG2i6xswp0+Yw1h9oll0Ae11BO4jF5ow2oEjIasx7Yj9Ziv4CwaJUwR1UwNWvyjCeOio451R8agat6vuBoz72oJbNfpzBNzAVCkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

On Thu, Oct 08, 2026 at 11:46:12AM +0800, Guixin Liu wrote:
> cxl_gpf_get_dvsec() picks between the Port and the Device GPF DVSEC
> from the PCIe type of the given device, and only a plain endpoint
> counts as a device. A restricted CXL device is an endpoint too, but
> it falls into the port case and is probed for the Port GPF DVSEC
> instead of the Device GPF DVSEC.
> 
> On an RCD, dirty shutdown tracking therefore never arms: the DVSEC
> lookup in cxl_nvdimm_arm_dirty_shutdown_tracking() fails, the dirty
> shutdown count stays invalid, and the warning complains about a
> missing Port GPF DVSEC on a device.
> 
> Treat restricted endpoints as devices.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

