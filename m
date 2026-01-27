Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4183EBF2F;
	Tue, 27 Jan 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548515; cv=fail; b=OARg736Ffi0NmVJamjpKKNE5IC6c3v9DBxGr7JK+iFqrRJwenzpu9jd0q5f5CDEz5v7OhNSUI8tXq3iuhlJzw/eZVxmnAxxg881x/IA0zv2I5pIlY6q7CIOgvl3dIo+VFX7SRjmXdMH0UJi4nVSFidkDfyS6lUj13n2YA3PQTi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548515; c=relaxed/simple;
	bh=QZmVctbtO+Fd0tfFr3vGN884iiqSDKII9Tq7HQ20eS8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C+y1GbSE9bt6fszyz/8lhl6593PcaC7o0D9cJzx+N/tXNRpg0qw5JlI8P61Vy2hAU440jRD1G2kR7jvDZJLPnqor/K5d8jUQy23VPBZDlbDgp4Imb/GNLNCatr0Oury0GR32MZ9sm1mzy4GifycFVKRCn0c6e5+iADySIF2muxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGf/Kzx2; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGf/Kzx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769548514; x=1801084514;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QZmVctbtO+Fd0tfFr3vGN884iiqSDKII9Tq7HQ20eS8=;
  b=VGf/Kzx2AnK49YakKrm8Pk3dfdG00Rkky5W9NePPQeuyfRDPX7D9PqkN
   6DXrr4FQxboViiuZGawhjBC2xkhOETQfA8akC3Ipfoz41RIbpemqzbv4t
   iZQMoh88BJ/eCDXXgEpDuTbsnvVBB8VBtakVVCVlUxbN4CpgtQFdZUT4U
   GWkUcmh2gywNI00kZQcYG8miYobjiY1BwT0xsaAey/xxj0JUyMzAEH5L9
   0PtCYIFSWZH0zBHMj8KFxURZapuaw4m7ZHZJUpbl0bt3tdMMROhpodWca
   fV6r+1Q3i4PmwnWki/mqFyXG9H/6/8NwRuOoz/0fq+07T9aeiRogeGMTE
   A==;
X-CSE-ConnectionGUID: 94isJouoTX2uacfTP6FTwg==
X-CSE-MsgGUID: VjZ4Mu6+Rc2iu01AWWBSvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70798274"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70798274"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:15:13 -0800
X-CSE-ConnectionGUID: KzIy5ISkTAyjgQoXem1DRQ==
X-CSE-MsgGUID: 2GXph8WsSDaH2AsCwNvdDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="231037515"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:15:12 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 13:15:11 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 13:15:11 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 13:15:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gg76PHcp1cD82GLYecuOCixJ0fXOxPtCRYaD9IRqaLKXErg4txQG8fiCgyYLsQ/smG2AofWoOpqhMURqsm7M1+60oSX8vDDC+bRYhSS23+UzJxRu0T23N8r/Jxgpi8PeVrNt1phl/wEdIfS5YpEz809+c/aZ3k46d9Zdka52R40jClz1zoPUshYGPvv8H/7cClHYGYj7RKISsjb+6wMA6T8xx1EYmIg7tqjdoihRfQJdLAhFwWFCaPTJHAAh5XOFkOp5nQ/dDges87pziqdReo80C+DbqguSrFmOYG2Qt+bSre4mn0wjZ6qGk5E1UpHmmloemPyAHP+Kx2JCWU/lfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WNmXCVq5s15n+dFYdH0WCop8Cz0RrI/Y1kw3Ete1GE=;
 b=nCn1qlMBsKab/bOT5NN1LlHm/1w17YuIVNotWBrGHU5LT3dzqV5HAWBk2tj8tGnAr01KSsqP/o1J57hREoq3Zok6Gal6FCbpfq4U0UVj5gSoIfRav16q4FssKslgP21pLhlvh+Bst1BHQgDH0Bco/bjyXT5wqhr+tzlqbTFSyZrgpw3SQZ9uSp52HWR2b07rZ8NlnqdxYA3JJ+lukYGMNrCR3lDcir1w/0+jVsyeBUUEOrdUvb76cjfmOxvfs8JD/Xohy/wWYb89Asw6OEbowIaLdlhMnjfcwXbe8HGQ06AhYipkeQUF5tp2K6DRep19d23+i1w5fwF4wvvtWgpcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB7022.namprd11.prod.outlook.com (2603:10b6:510:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 21:15:09 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 21:15:09 +0000
Date: Tue, 27 Jan 2026 13:15:04 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <ming.li@zohomail.com>, <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Ying
	<ying.huang@linux.alibaba.com>
Subject: Re: [RFC PATCH] cxl: Fix premature commit_end increment on decoder
 commit failure
Message-ID: <aXkq2DvEOeYQSVuN@aschofie-mobl2.lan>
References: <20260127084855.66916-1-yuxiong.wang@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260127084855.66916-1-yuxiong.wang@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: a60bb786-0c58-4542-a27a-08de5de92694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?inOO2N1lB3FipvAlAx+vXFv4ocWrD3Zl8hrB/gBFXRWjNXb20c0gFU+dvrWF?=
 =?us-ascii?Q?TapWRhMsdmxr/jcoF//Q0AH017Klg47W3IMHlxODc8u1SGCvD8M7NmAYTpkh?=
 =?us-ascii?Q?QdScWGb4BeSVLCI+sUYQ3ZNsAjlWLEiBDJA5K1XkBerbG5QltrrEXVGmT4m7?=
 =?us-ascii?Q?qSVrpITo3jDVWEMUL8uHqd5pU0k/U8U/eJdPQMIdhgzprB5TNRq+YyfDRUQ7?=
 =?us-ascii?Q?MJvZLpN2bRhzMgtK02iWGkA++WEQYD6mB7RcY0HShnp0TaGh9rwoAHNZYnjr?=
 =?us-ascii?Q?x3dRa4ugr8fE0QpGW63SR7ghIj/LWXAXHODkEqrbBVxH4lYHklj7WZ1qKs1B?=
 =?us-ascii?Q?E5evEGYEFfMHkLnm2nL8D4r6PgEDq2Gv/cEm4Uy3QOl21ygoUWNQ5+NCGbP5?=
 =?us-ascii?Q?+ypo7toLl4SGWYhbKaBtrIokUarTf3yWZOTwv8jzuXNSIXJlmVLGp8p7FAd/?=
 =?us-ascii?Q?LHtLs/kNfbJEh3JiHl6DLXE6a4NZeVGCScPD2nENQo9aQo1exhMKAdJOG/45?=
 =?us-ascii?Q?bZjiPFsf1Do2Kare5G9hR2IyZ9snENIfi5BU72q5R1GE/Gf7UUoVBauF7N89?=
 =?us-ascii?Q?VnNfTqlfBtxCsVQpV0zHgLRI2hr425t4X5bdquZDdxw6bnKsIvOqcIkeyaw+?=
 =?us-ascii?Q?CVKZvN8I/9bku8GDzmdqn07Si/Z5GLNZSBK8hbxG0ArGBokqfAbOyGhLMTch?=
 =?us-ascii?Q?NJG9x9JZbPZvkowh5xtwGviuOhiGTgx7ontNMAQwllVlrNM2DCniPj9RhXkH?=
 =?us-ascii?Q?aPHM+i/Dl68PLgvOCdXyVP8KE+5K1QFSmvEujSE7cg8wGLSCsHNBg9F7ieyh?=
 =?us-ascii?Q?Zp1vU62q0JTxpCY9UniYh14ZqlvNoBM1Mxy6UscUSFttOl+aGtTlScNJMNEy?=
 =?us-ascii?Q?jRvjMkR2Zt+3pEVZvBs7rkmd7fg8fsRzWQZJuGff3XAbHwXIV7jYLb0Nxk5G?=
 =?us-ascii?Q?c5R4SIcwVg68quw1ZxnzYgZQL8AkqPPP4GCb2LitzaZjDjSsBEj0PmFE+ydD?=
 =?us-ascii?Q?+5Ug2pp7AD4Q2IJB4YlIL/onfWHC+GN04KDoI3DoRl210BfqNqFws3erdF+f?=
 =?us-ascii?Q?6qKtjpanxnGyKSVTeajJbPlFG3oDzD9OaqfXBYwriUK7w8rscY/RYAfh6VaU?=
 =?us-ascii?Q?hi3UweXtRI4P7iKXdu22aDD8YqRbWFVMFGL8P62PXCTr/l6j3XHmr5yJZt66?=
 =?us-ascii?Q?bRpZi2foEJcMmYip66e2MqHQ7vZ2pY4YH4uT0Kp47Hm8SxjdONC2LzcZDD8n?=
 =?us-ascii?Q?w18sMXRvPEG0SqyrFJKYJKghd5O7UvbbxNF34vE4fzzaoKMa2hzRddzZSbIa?=
 =?us-ascii?Q?uyzWjkZkMd2MEw3AvldjN1ITvhwb0JUqhC9LRltGnOr6wgsAdFXCbIa/WoXj?=
 =?us-ascii?Q?hPupCZId2An4DEOoEN4vbc3Km5HbullyZ5zFoxSNVpykqRWarh+npU/A8hHm?=
 =?us-ascii?Q?tZCKPeLwQBwdUK6VxrgGNm5wjDr0wArXO1ZEQut0wLc6dUvg9x6wXcqZHEl0?=
 =?us-ascii?Q?3E5uJioiljAx602ePPxJY5Cmg7ym9JflIS3qIpx0VeLAsVhwS2PWDC7CdPNe?=
 =?us-ascii?Q?4+of/gEIVkt/IIlhpko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N7LXnfd1ZeeGVnp7QTVwxqQNlNrcTCLYzAblz/VghfINlARrG5hW5pIcCcE9?=
 =?us-ascii?Q?njRsKSLr+xV1xFrDH9lvZ5S9XInf7zmitN96qoPikQGuAuY88eWanhQln/qD?=
 =?us-ascii?Q?5HNrR9GOcVDHJQRd81ukEzO8jZdPH9ojYZyzftSrVK3s6EaqOb771nG+g17W?=
 =?us-ascii?Q?vhWWbc/K2lyzG9jgERzAnb+mcgdizAlj0ZIvMe6atNWTFL2KFJ6mGPPuu5Hf?=
 =?us-ascii?Q?BLa0Q7j1HpxH/8xVpqFX++RxU+pTAovn0hgaVnbSB43vHtR94+VfOOQnacHv?=
 =?us-ascii?Q?dhr0ZZ4p3nqyu0ZS+oPX5t2cp5cdWbN7VTgieUzX3Frh4sK86xuB5hSd42Xr?=
 =?us-ascii?Q?1wrQNtnCm9Q+8F3d0rYvkzMnm+P/Qea+zLw4YcmE5jsSa7G4JfBfzjgp/nn5?=
 =?us-ascii?Q?clP7PSlq4awN5Zc9WGOMD00cEOgKq8leOZhIGI9omtJJnE/Weqh2DC/mv2qZ?=
 =?us-ascii?Q?vYiK315xw/0tfWz2iLLkVjEOXDkBowPIvKL+9+k8GEMgmezMakTrxkGSiv2K?=
 =?us-ascii?Q?ICFBAu/TbUQR5I+uPsyJq7rzbSXoh97YSpFJs48RCAvPhSlGRCehqsgXXJIS?=
 =?us-ascii?Q?qbzHitcYv4OFGIuM+9qvlkVSPEFPClKv6bUH3cW3Vr2EcEeeEYL/GL01o26K?=
 =?us-ascii?Q?/8L8oWlthW0MQileDYIOvJDpCLCxuVpQScvrtM1MQrQcAIOAlUjKVRJy4prk?=
 =?us-ascii?Q?R9fnKu0BrVkjFw1+kh/yxaFtgd4EJq1L6MTCL3ZfUmMTenQxpOIY3t2OvilC?=
 =?us-ascii?Q?/+4jy7O+P0YPRM4zmqgHtjHraz3HnqQkMxMxnnRCTOYQI3McW5hpU1e7eRd4?=
 =?us-ascii?Q?J32I3KtI7dXM5wiEI4QSw3wx1GobDHPTaUYfLPRJ1wfSNeACJReUCB4n/ony?=
 =?us-ascii?Q?lVHBqNpHF0RqK1K/sIgdu6++Tf1wx1KP/nw+JaZmLDzz0nR/Bi7DXzzKGhLL?=
 =?us-ascii?Q?c1AQ1H+5h4RDPEsk+IhBhxnOnvgVB7OFc2w0cRBycs3FkrzwDGw7NhmRJ6BI?=
 =?us-ascii?Q?nzvf6tKD9vQrgynf6znicD646DdT0BGO1jR/45WCWI0cpNZP9Ht4IOgM5Roo?=
 =?us-ascii?Q?hCONZiMAFiSAmwnxRPuVSvWYmAzWb9vHgMxsfGPr4PeO4X4gnCwlKzUhbAYf?=
 =?us-ascii?Q?cFP6aHkcW4085nVAMwDk5AV45YfJz0az8E3I7oQhXsjr9dtBz2hTquEkeAhj?=
 =?us-ascii?Q?IXEW7BJjvm6ZALSPkW+0pC+fLu5MWlX3DTl7DTKsPRZjDhVExnV76l9wv/5B?=
 =?us-ascii?Q?Lgh3BZkEWQKaKqRYGI2FjSdlYfU5zEAtmPLc7Jv8vzVwZCUi79PpNib2zflN?=
 =?us-ascii?Q?7gEIPee+j9HDXckFggNPYsz9B908DRCuDARuhE9xPt2GQxyZoLSAGNSyB8fP?=
 =?us-ascii?Q?8jeu3xGKTbi91414ZfH7GrtXkM5o6YJeounMLzTzXLIxRINZ9Sv2jbCc+nT0?=
 =?us-ascii?Q?KNn0RifBuDhBNvZkjaq/mNK7IGRocx7ovTHo9ekkTDWvj7xZhfXT8lsSsNii?=
 =?us-ascii?Q?4j/MK7/qui6xMvfJHMp692xvzPgQOExduIgFDTe8mE/ib4hyJT4A6FWOQFOI?=
 =?us-ascii?Q?iI9b0I6Zvsw29VZr+mMsxI7LfzbjXTyYeuaMzi2N4f0FYjuAvKLjN9KJ6CSf?=
 =?us-ascii?Q?hM7SkwMCi732vJsFtylZ274RVInCl8HzsXTt/skW1NwwZ/49Oojnk/B5K2aH?=
 =?us-ascii?Q?G294eUGmXZ12UJhHcYNIHiEDH+sSi8sH9NtGi9CHvPWQykFK9z9VXLNCNqYQ?=
 =?us-ascii?Q?qP8MymvK2c4l9ouyfLXq+qJm3W97SsY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a60bb786-0c58-4542-a27a-08de5de92694
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 21:15:09.0777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyK/G2K1c5nQruT5IoPKgCeIoNhp8IkDflgs3hd9Bj5RON6unItrF+WFTl5W05kdO9lDVnxcrTaQw1rI5PeiiWKLXdrh/yZDvgE7V/AkBAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7022
X-OriginatorOrg: intel.com

On Tue, Jan 27, 2026 at 04:48:55PM +0800, Yuxiong Wang wrote:
> In cxl_decoder_commit(), commit_end is incremented before verifying whether the
> commit succeeded, and the CXL_DECODER_F_ENABLE bit in cxld->flags is only set
> after a successful commit. As a result, if the commit fails, commit_end has been
> incremented and cxld->reset() has no effect since the flag is not set, so commit_end
> remains incorrectly incremented. The inconsistency between commit_end and
> CXL_DECODER_F_ENABLE causes failure during subsequent either commit or reset
> operations.
> 
> Fix this by incrementing commit_end only after confirming the commit succeeded.
> Since cxld_await_commit() clears the decoder commit bit on failure, no additional
> reset is required. Remove the ineffective cxld->reset() call in this case.


Why are the writel()'s that cxld->reset() intended to do not really
needed? Is only the twiddle of the COMMIT bit needed for a reset or
do we need to 0 the size and base offsets we previously wrote?

How did you find this?  Maybe we can add test case to cxl unit tests.

Thanks,
Alison


> 
> Fixes: 176baef ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
> Acked-by: Huang Ying <ying.huang@linux.alibaba.com>
> ---
>  drivers/cxl/core/hdm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index eb5a3a7640c6..912f648a6b7a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -844,14 +844,13 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
>  		setup_hw_decoder(cxld, hdm);
>  
> -	port->commit_end++;
>  	rc = cxld_await_commit(hdm, cxld->id);
>  	if (rc) {
>  		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
>  			dev_name(&cxld->dev), rc);
> -		cxld->reset(cxld);
>  		return rc;
>  	}
> +	port->commit_end++;
>  	cxld->flags |= CXL_DECODER_F_ENABLE;
>  
>  	return 0;
> -- 
> 2.50.1 (Apple Git-155)
> 
