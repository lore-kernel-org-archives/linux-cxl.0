Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F97212B2B
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550705; cv=fail; b=XW18XroSOJTR9vdLMcr5tw7snnQR+7T/Tx6UrCYrDBy8dzxOwIFOqWFHSn6kUCEFwE1A8tlEpD9/9MN8EYLxp9hll0OQUm0Os4vrPSkLDzbNx5m4M4LhVXYU9Cudk0RZ6qyJrYgrZjTJMAqrSbwv5Zd12gEguCbA/jolTlFCyas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550705; c=relaxed/simple;
	bh=/tYAzD85t4Jpf9Hm5JgJO3AlU/nP9teYIV68ICLOrhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nqSi8ScBETFFQGB2jrgihAytpu8PEmRDecaVNRfXAUK5ulr2G4A1voqcnKUktTCsvHT02hBuHxnqXmwVYX/II+tMIohbgKJAtAOyECI867+RLdL3JhPeQrNeFYgE4U6OOMjoZd/wXSp7yR/ZgWgzydO49OFTgHplxMLaMpDOeg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWa3n0RV; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWa3n0RV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737550704; x=1769086704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/tYAzD85t4Jpf9Hm5JgJO3AlU/nP9teYIV68ICLOrhg=;
  b=jWa3n0RVXUc3S37WbvBB5xGZWs3gF4D6BnxlLVmfTUSFTyY+6D9JHZIa
   +mLmBin7hnJQAjn4QgcdUdxJQoqcCPbDYnSw0M2Y9LyfSV0n//cYXTwd0
   q2VJzl2JoFWQrVpaCvLXMa/8IT/l5q9VeiGrr9gaEIptVVFEHje94GoZV
   CJ0s2ASKPt6VRZdnKyx2QaduoPq7p1wCOATOMj9gutxMUoFBfbk6nLpP1
   Yskr5YpPQbsFd7U6ELi1qhiB10tFR/OjcfPtA+LSGQ6z8OjQYnbbjMJTA
   NYBoa5xOYGlXcfVLAM27Js5RQ9RRiyumnMMOy5cDIsZQBSAEtOCuzUkjo
   g==;
X-CSE-ConnectionGUID: uLia1MO+SqevPFi+OqijlQ==
X-CSE-MsgGUID: xyPB0i9IQ0+PD3BpA8D8Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="48668198"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="48668198"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 04:58:23 -0800
X-CSE-ConnectionGUID: f+rc10kmTKS8yE/Zrkypwg==
X-CSE-MsgGUID: qubhMNj1T5OTu/QQ8vCe1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112222474"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 04:58:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 04:58:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 04:58:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 04:58:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNs3KDOdfWBUPE91Z4APu8Smzw7sRltqFfnhw7WZ4iUyS1Otb/dCmtsbYPrKNEBxCfN36UxmhNkYZVmdAhJ8V0bn2QEGrl1QUR2qoSy2sVuJ6+ReA/n4gImt5UADnPBZL+CNQJYNo2n9NdQ95E6z5+BJR0G0Y7oTx+jpFtxoDZ0gGBMGPsoKezLHJiQa4e3h+Rem4Komda/uvmWKazxV7kIn2ILD/+eF72pQ6MqVGu2trx98TmZ2r1PTqbDRFVsQf52Z0RaZ5dkjq3g1quHnYmkqWv1YdXS1V0jDgTVWZZUF7Tz2kJp2v0Ty/XtuLHiNp8hPeLh7jS4U6GHvYUytKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tYAzD85t4Jpf9Hm5JgJO3AlU/nP9teYIV68ICLOrhg=;
 b=s6B+bggde9/k3e/ztJ7pRZv9A/13ptDfe1DkUanLSw1c+PARMmcYsP7kcVAKSfKOl/d9mg0wT41BkweHzNfd3CnyeQcPtVi+qjXm1z8NuZiFS7nFFyXrNwt2jnCkvDtRLlw5J9h9S0nV4XwHlyscUF2M2L28ypoxH0utvH+z7YUnDAZHJr/8RUV8P54QdWYSSLTtxcaj61xbdo+UH5LhUG3vsCLxuD33tdU2tUC1spW/xnAnxmHrOJ52/o0D27dS+PFo70UN237KT6asAnQqm65b5oZVHJtVb2eYqSXMBcgrwf4bvgB9PMfVWGJ2P2nTmXyY26/09slbB1uQN9Pvmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17)
 by IA1PR11MB7810.namprd11.prod.outlook.com (2603:10b6:208:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 12:58:06 +0000
Received: from SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::4ec0:56bc:1ceb:7c06]) by SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::4ec0:56bc:1ceb:7c06%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 12:58:06 +0000
From: "Ye, Huaisheng" <huaisheng.ye@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "ming.li@zohomail.com" <ming.li@zohomail.com>
CC: "Jia, Pei P" <pei.p.jia@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v5 1/1] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Thread-Topic: [PATCH v5 1/1] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Thread-Index: AQHbZ2HJv+VXedd6KkKPiQVTUk5BmrMijT2AgAA9egA=
Date: Wed, 22 Jan 2025 12:58:06 +0000
Message-ID: <SA3PR11MB746119DED7A69321E168FFB99FE12@SA3PR11MB7461.namprd11.prod.outlook.com>
References: <20250115152600.26482-1-huaisheng.ye@intel.com>
 <20250115152600.26482-2-huaisheng.ye@intel.com>
 <6790b6e5817bf_20fa2942c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6790b6e5817bf_20fa2942c@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB7461:EE_|IA1PR11MB7810:EE_
x-ms-office365-filtering-correlation-id: c6da9f55-8a05-47ab-06e6-08dd3ae46a22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?lHMojeEYS0WF5GWF0TJN5pY3wYrMPummbZvAtOMYxKaORcRl+5E1SbhjX3Qy?=
 =?us-ascii?Q?jgfWBkjOa1+1i9ZJgRv0nkKUup4GFZBv8BLGL31SzZsbu4p5RVT5DE1GN5s2?=
 =?us-ascii?Q?TZ9ZbNGQFQLZw8Ytom/F4dcNr0qlN/mkFfSx2iIBTlY/0csggTclpfc8irwC?=
 =?us-ascii?Q?60fcNH0yJ6N08lF+eWfBaw8z1rCCI3SetJ4PqcLRccg8vmHXIqodFmWaT4If?=
 =?us-ascii?Q?Ry2iZHq+syF/LFkqkbd36sBwou7Y4eRODRm7GBOhpja+tdkUMXYpIF5KQYDE?=
 =?us-ascii?Q?OyG17NcTIMCorEcXZbeMSwtZPGHaher1x5l6pU9/SRKL0kOGRhfcqlyjkrv5?=
 =?us-ascii?Q?YVpFoh1PGp+Xo/2kGUWoTi+B76uuI+nRz67O2RHbKqjejqwLaDAfVJ5rv7p6?=
 =?us-ascii?Q?Q9WDgyXjaseYv7tv5vZd0N78xMducBkvpGFT63UaQ+BZlD95sLHHK410BKyz?=
 =?us-ascii?Q?uQvvJrqNinpcZKAOMzIK8qaY30pRdpZeCdQeeM4ukmUcYUHV7naQj+e5n6RE?=
 =?us-ascii?Q?ZirgrnMVuj/cGTKRBrke0SSKhwgX4ICcKw3p04mWtFFW+6+FZQ/96ZtEpbGi?=
 =?us-ascii?Q?+w8JAkITlWX+DsijK4UXuvI8DUC+nwXEvhroiMESb8WAzI3mM3sGQLeJDB1Q?=
 =?us-ascii?Q?o1ubC4jyKlig0ZCrtYyJfYi91Kg52572a3oqrvxcYOX59EbKGQI/2pIqKKLd?=
 =?us-ascii?Q?DuyCvR0s+EgQBN7VhqhmKxAABnr2sNl65hbqawJIE6SQFoqFFfF3Lv/8Wfvz?=
 =?us-ascii?Q?sVplIXPrKPEtSsKX0h0Zpf0mwtJgj4nrg0whDsk0BxYnAZ1rhcbss6kYSg+b?=
 =?us-ascii?Q?brd+Ds3dFMdMvReMnjVg8qaocYbppW8nUzj/ViilGeahAu0otkZMLAKAuG5N?=
 =?us-ascii?Q?aRbzb2DVtjwMp5xWb0tRcNIIuWLWQaCvCCmkRxVSFsbdZxWiZGjFMLFJxrit?=
 =?us-ascii?Q?k6/O3ouqTp3ryGEWCBbtxB/Z0dOx8akrQAHl+USzk2nqd/bLQrA4MdOoCLs7?=
 =?us-ascii?Q?Em6nHs9XjsNZklkjIEngblqkzvoqGiTeHvX3kK8WUndFvRMbOmLCxKrLDGYc?=
 =?us-ascii?Q?qG0yPlSifp9WGC2la7lYJCkj6t0Iv7ynDtKas6HXfiJLUTGHKE+wJtln3+6H?=
 =?us-ascii?Q?8b3GNmXlXj9/znf7eZFir2oD9BRPRh+ERih6jDzZ2i0lgRj0cPdxaslsq8tJ?=
 =?us-ascii?Q?Fn8pJXAq6C3K0+qKMb8NrCV8iJHSyIFHu4LZdN8wTuZP4ebcXXSAMhtOx5Jk?=
 =?us-ascii?Q?TLuv6ofMR6bb4eI51oy84A4UWKI92ejE1HvhRtsOze4XYsZWs0F3WYD2ceKj?=
 =?us-ascii?Q?co+QSJRgGQPkPYRmdpoj3qQCtZhcg1DizcHXUSFgsXY1k3cXUIXZ+WO3eaJq?=
 =?us-ascii?Q?NBbnNO1gGnnLGJpefMpiFxKzFL4nG26zrqrX66MIP4oTf1lvOYiTm0fERlH7?=
 =?us-ascii?Q?PdQMyZpzsOSd8oaHHrMJ1l8xLxyQ650G?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7461.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PLZ70NG7nPvE7TAka42Fr18L44ep03DKZLqglIubbbl47832bOzdQ8wvzWsl?=
 =?us-ascii?Q?Paejgn4ogV+5fyRJQ+pk6EFeviIKjPxL/uh65KtxZTIT2sG0RnO0HPU2OEc2?=
 =?us-ascii?Q?koJDZiBUdJ6M7uKZ+Q7FMuwkIuL5EWcVPg31yPxI2b4BcIjl2dcvlNs16sML?=
 =?us-ascii?Q?q7RrnMM0E4siQF9Y/umVfvj9fBxF0WAFY/+4jaUHWWcSn2U3P3udZZ1TBfjX?=
 =?us-ascii?Q?ReQ2odWkm7ulU0FBzuAj27nagq5S6x9jx7RhJu3X1HAQ5KfJG7afcmZXgAri?=
 =?us-ascii?Q?50Hi2QBAC4jIEWuralz82mAa8TrGWCg+NaC2mkTWaImL9DUni7P4fpFFQ3T7?=
 =?us-ascii?Q?9YasjgzSPV46/97ymHK4sZ5S0MqCGWgqgyZjUgZYsniS+f5rNv3/nc+rPxOn?=
 =?us-ascii?Q?qCO4GO6LOBb2LX6vaI8b7dScBguIGGdlcYGGYK0qIemFaBEURqY1Y26JRE+P?=
 =?us-ascii?Q?JQNGVsJ8uzEgwqv12yRhD9W76Oyfc6Ut0g2LlSwh+4u1eQzOTB5oYRCJYaHS?=
 =?us-ascii?Q?BjgPdIW0hdSxF17KG5gC7PIaYIbsnkW9+YYfvyEiaH02ET+0fCEQ/It5t3iG?=
 =?us-ascii?Q?pezmxh6sDNaHta5wdVX4ySXGhK1By6nrcBHcCYDRfsMZCLzF34AUC6tZAH0G?=
 =?us-ascii?Q?WPFfXt+/G87OAxEKlI54sfcmsFat69TWT0JOL0F6aFUsE34mxwGO0zAFM+al?=
 =?us-ascii?Q?7qh+frhdF31PP6mgBX0X/y4cMQNWtvh7UrW+kUTNMkEXvnfdJmux7Lz855Y6?=
 =?us-ascii?Q?6t7U5ctyaMw9C/HLazdW9DrNEvfR9601s3/JHj5pDyOdlKjHNoI24vvDZnE/?=
 =?us-ascii?Q?c9bSekd0HaTjtd26ka+sZMpKQPsvUFWaLArsV1Ge+Wc0xU4ox0pk3TlOWMQ9?=
 =?us-ascii?Q?FsAnUkKMPxSoj+xGDVbqQbGWsMx3LGRS6CKf5QHD1VDkJ54L49v9knNXokU1?=
 =?us-ascii?Q?33X6gBb0rbYVlQ29cvfgHcWoFsu+dJrIF1oaIsLaHmpbrEVwsI4BcyNCgHDZ?=
 =?us-ascii?Q?DJAF9Nh1yPub3t2a2IOKGYo1tewpnfR6PD5cU0thsgCPAZYXEYWVNj/FHOeO?=
 =?us-ascii?Q?HZD4x/4FiDCth/w/mOsMRJl6j4Vtx+7XCpGYKCeuPKu2IOsSSM1Go5KhCEZI?=
 =?us-ascii?Q?7oo6EyZDJ86g7Lzpa35NDOYn01+1KTdGaW82YWtC8qgMbbC18KfhUCtsNbQu?=
 =?us-ascii?Q?1SCF4H3yYIh+TKZGSNUWPycmbxcGb870xTxRI5st85PmATXgh/aYgYrJhOSG?=
 =?us-ascii?Q?8Mk/Ww6kp2WHnIdwEaOyLFMmArUFn3Fru3Ga6JiH92oc+chcPYP+2k2twobr?=
 =?us-ascii?Q?6u4pfbkh0yhQwEJ0E5nntY98QgExrxeulaKc4H/SQgDyUSM+ATeMj+JReyd1?=
 =?us-ascii?Q?kOKG9Ayrx6hA13cjwdIN64dRKYWYpB4cZyYEjy+qGdbMRH8S0UiBSXo7/3tZ?=
 =?us-ascii?Q?xfgadorpJldTOT7OtN0eWWoFIQFcR+Rmwdtptnmxx8eJc07LTq51qUfDrltk?=
 =?us-ascii?Q?/CRYJyEQSXSeseIMvYfXwDUWBvX2FoKalPJ54c9J8q8RGIsiWPycp26tr0pi?=
 =?us-ascii?Q?0i7tbr9iXb8qDACY9CQZeBso/vOQsvWVCwU9aEr3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7461.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6da9f55-8a05-47ab-06e6-08dd3ae46a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 12:58:06.3508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nnSg6foB/j2rJB15t2gr4O8Lil2n/tnjdiT9SM6ElWwpFO+j3L+FSAH66HP+fun0bCK9WZ1drInmrlkTc1J5gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7810
X-OriginatorOrg: intel.com

From: Williams, Dan J <dan.j.williams@intel.com>
Sent: Wednesday, January 22, 2025 5:14 PM
> To: Ye, Huaisheng <huaisheng.ye@intel.com>; Jonathan.Cameron@huawei.com;
> Williams, Dan J <dan.j.williams@intel.com>; Jiang, Dave
> <dave.jiang@intel.com>; ming.li@zohomail.com
> Cc: Jia, Pei P <pei.p.jia@intel.com>; linux-cxl@vger.kernel.org; Ye,
> Huaisheng <huaisheng.ye@intel.com>
> Subject: Re: [PATCH v5 1/1] cxl/core/regs: Refactor out functions to coun=
t
> regblocks of given type
>=20
> Some minor comments that Dave can fixup:
>=20
> Huaisheng Ye wrote:
> > In commit d717d7f3df18494baafd9595fb4bcb9c380d7389, cxl_count_regblock
> was
>=20
> When referencing a commit the typical form is
>=20
> d717d7f3df18 ("cxl: Add functions to get an instance of / count regblocks
> of a given type")
>=20
> ...however in this case the commit history does not matter. Typically
> commit history is useful for fixes to identify what kernels are
> suspectible to the problem. In this case it is just a cleanup.
>=20
> Also, for what this patch is I think the commit message can afford to be
> more concise and just say:
>=20
> ---
> cxl_find_regblock_instance() counts the number of instances of a register
> block as a side effect of searching through all available register blocks=
.
> cxl_count_regblock() throws away that work and recounts all the register
> blocks by asking cxl_find_regblock_instance() to redo work it has
> already done until it finally returns an error, that is needlessly
> wasteful.
>=20
> Let cxl_count_regblock() leverage the counting that
> cxl_find_regblock_instance() already does by passing in a sentinel value
> (CXL_INSTANCES_COUNT) that triggers the count to be returned.
> ---
>=20
> Otherwise, patch looks good.
>=20
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Many thanks for the guidance, I gain a lot of benefit from that.

Best Regards,
Huaisheng Ye


