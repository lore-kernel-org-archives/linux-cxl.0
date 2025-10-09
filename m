Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A523D7C0;
	Thu,  9 Oct 2025 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759981943; cv=fail; b=CTTjZVJajxNCkQHtc7GhXr/bCj5xcm/Ek0ncHAIDo9MLnGv1EgtziAp4M+Ng6zvLh/2g54oSsBOxyr1+t+2aM0FyvPj2Nxw8F9QSQfgeVcmnL20cTvn5kYry5ch4xVDLBDftP23qK8vjfpTcJrSrdFaErAxeZ9vT1Ne+YqjbOiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759981943; c=relaxed/simple;
	bh=W1J4FC1+sYm1abopGKADdrPuXot/SqismkoXAge6vII=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fGb8hA9PuLzlUt2kgCToja4KWu3uU6nenUWRDDFmTBmvBFiNNeDR5FJAdEXQsZsaGZzzyflSPHCUgS/zmdlYx6dnHWnRoXpi+YCTcdsk5VK59hQnjutE84l0RhSk6NWPj27K7v8Lp2+QOCf6Ak847rwGfhDj0AvsLH7i7cJIdI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIUewJf2; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIUewJf2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759981941; x=1791517941;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W1J4FC1+sYm1abopGKADdrPuXot/SqismkoXAge6vII=;
  b=AIUewJf2kSHz9m1ZWb2BfI7f9GlyuMXMHpfsGKnWDTEQH3U3+oYkZCXt
   t6aPcLl3qYtAPvaxr384UJ8nqQGKorCp1Cj9xzEjAYuNvbZPUMOVPr+DG
   ANT6vvIsO/Lrz8gMd7H+XqgE7I21HJJEwwVzN2swLhxXsx8JGPo71tRsn
   pWOY0FKRi58dM3YTqtSEuVjQ601sul1WWv4SOqqr/e2iMJ96ARSYBnxQi
   eSs+xlTB6sbJ3nHVWsRJuCRjDksYfvcOVB2p7RC+S6dzcVl9frjqMB3QB
   ymuceuPJhPZG2HIQkhV5bV4q/uxLhrRr7zjytctqjz45ICQT1gfblEhpe
   A==;
X-CSE-ConnectionGUID: k9C9l+eQRZGVBlkB1se7Wg==
X-CSE-MsgGUID: uxKdkdnnT66i2BSjqoicSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73290468"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="73290468"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 20:52:20 -0700
X-CSE-ConnectionGUID: d2h/AozxSoeFPGVV2wnhfQ==
X-CSE-MsgGUID: G079dmm9RpexVAkEU92IZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="211552347"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 20:52:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 20:52:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 20:52:19 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 20:52:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmTHp815sIsDTjIQjWSGgKMZBNQV7EyXTCVQ2lVIoBKg4gs5qPo7Y0Yx8x9IiSb7BOz3TrHx3yfWhPz5SE1fEKtXjZhKIPWagSOQzIU3XGtnLQfItbtbuZ0/SgzRhRFU+ENeK387w8mOgjO/qsF1ebM7+anxRJJR2bCIb4q9Y02t0Nd8r5+WpIG7+nraydQ6BySAbFrZtN/iKLvJuYfWAHJiRj6UPq/QNPnYwq7njWQXBJIjWYnryOtr7ELmfa62HPd60Y65nuOuDk1yjV0XCyYF5DQloTyjtopBXIDdUur7JdepFbzoFivNKRmM4XWgiPwZ5/ryNYq08lyhqJBe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kcivl2PyPsdqxwtOygyRsiqZPuiTVHPYQnG89V+Ous8=;
 b=QsGVUdKSNU9/8PdEBq6vYUduOBUzQv3R68QGd/UKxkfLvDfVzGwtR6o67y3frY1lz3XlTReztp1wfsbpMTNwlQSlk3PQa+Fkk3nRTgeLVEOZJRqpmlYi2U9qbcAjg3RxffkFT0nJX4LxQdSx2pLZW54bJPlrfJseOHbt5aM3mHs5+pHSjaU6iHxltfvVzImFQ/tNckY8VArlWRgP1JGrYxtzK/Ut6fElsvPpUjRNz6fmOkETxy1a6LI74dtEBPoojjXVUbSRGlV1CAJab2iY7R7AlJ229lvzoR/LiMyT6LM47aU4TX8eGWieQBRe1tyz4YkzSpk3OulEnOQmw28uTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:52:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9182.015; Thu, 9 Oct 2025
 03:52:16 +0000
Date: Wed, 8 Oct 2025 20:52:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Dan Williams" <dan.j.williams@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, Robert
 Richter <rrichter@amd.com>, Cheatham Benjamin <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 4/4 v5] cxl/test: Simulate an x86 Low Memory Hole for
 tests
Message-ID: <aOcxZ1ju0FmB5Xi7@aschofie-mobl2.lan>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-5-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006155836.791418-5-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: BYAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::36) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV2PR11MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 572090dd-a216-4305-9418-08de06e73cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mtjU8e0UlEpXzkv/RGBXrAco+pRM1rbWz8hD8IUHLOTjbeDWl0PlwG+5rFLU?=
 =?us-ascii?Q?HF080OVIOyMLEqHp6241/tS9o9Y9dhWAbMsMlBEuL0ZKDeiutTNxuGuF5D1T?=
 =?us-ascii?Q?7+WwjTs1AftwxAzYTZglDA1ALcQke9aclZhhGeetFbXRBJuVdHbOUdg6kuxl?=
 =?us-ascii?Q?1O730Yah3YLc10j1jpQMrF+oqh4XreMT4GBVIbSEqfHsNabSWCuVmal3yPuZ?=
 =?us-ascii?Q?1BS36HuY7ubCmPhPb2t/EbnDAtnRnIS14JlriwtbawobApOT2NneYy0tj7mD?=
 =?us-ascii?Q?f6Bxh9R8GyVEwRO/3iVQGwn4or0mU27/JrrYx0Ipt1oNPhgOegzvCDz3fYO5?=
 =?us-ascii?Q?kfLbykR8XfKfu1NmqKZqOSAFrer0VlG23n7rQ6aNiNCR1KZpRaeLAbi1zfkk?=
 =?us-ascii?Q?U5ylqjGIGXEiCUhXbRpxr+k/n/o7mvN5v/oDV0bO9TzTh5SfycQynJXTKOXd?=
 =?us-ascii?Q?7hg8w6/hHmaQUM397FLz2l/tctJjAgsOK7UkxZgrxTQtI9YDFyRDS623iGgn?=
 =?us-ascii?Q?TmZ5ELITVAS8jcK4RrCtbeDw8h2Sg5R9xNfAvXXOE6GGnBDdCanB5Mt3Fvlt?=
 =?us-ascii?Q?hsJcZo/HG8uvQHovRL4kq6nxpljoicEqrHJXiibsKfyNEvei8NGjeOMqXmH6?=
 =?us-ascii?Q?/RBiDCBUXiKlJe+V1B7AuM6w0Dj24odHtBvj97P0ZYiQlapx1e1cQxU7g1WO?=
 =?us-ascii?Q?3io32glbaiTlDEtKeH7+1NOtcjfrrqhK5ubLEY2SsQ7OBTGCGh1yZzUNwC0g?=
 =?us-ascii?Q?PRuKKKmGhhsyu1ZdbicneCV+P0/C9WJ2QwGqUHM9v5pbreDUuysOqOZfReZ1?=
 =?us-ascii?Q?tPxcY7rzbH0dewKpO29ic2frNUnJjC9PtWkFX6yPEOr3gxlKMN6JH94UXeWo?=
 =?us-ascii?Q?Ek0Hyv8oDbbBes7PNRA7/wN4Ea1SXlZOHhPG67QxYZQvbx+nvm+QGhrZ4Dr8?=
 =?us-ascii?Q?IHyParW8dtcic3KNZvGliKADCu/2WBKr2dlGlVICBAEopI35lelEsU2bKaz7?=
 =?us-ascii?Q?rsS4D0Ts7BtcllHn0LJKJn5y3HsiLk51T+Dz1mBi9a1QWH1ZTtJz7EZJGCJm?=
 =?us-ascii?Q?PN4JP6bmGsdxcKhEjgUd037UFhTFGhygYB+JZYn/s9i3NB7JMNPhClCo8W1h?=
 =?us-ascii?Q?zteRBUQWXSB7SLgD21laobl3px0zlk96oaYDHW/2CabUalo6kf8+AUEHjajV?=
 =?us-ascii?Q?CXab99WgKwUFlFjZcp6s1Dg462kSTc7+JWuwnbRG1asGKZpk3bywoAP11Klr?=
 =?us-ascii?Q?i+V9381YkpAfllUVbzY9TM6qrGMn5pU1YyeK4f3qKS5csZgh+D3ke7A9ALtd?=
 =?us-ascii?Q?vONu48t94My0TSRr4Y4D87hvri50dHP8wXrV2gLnLYnNvUwtx+SLPwxYjIJ9?=
 =?us-ascii?Q?tbC6anjEcB7YRaBE9z3pvWo/bjG9IXGls4vWpGdR1B1voTbX++WU8JyYsoT2?=
 =?us-ascii?Q?R5MTztvOPuuZO+QGoGPjHKIwuswKl1qk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E5z+Umliu8yZFx3hmcgLOvs+VepLMm+bdgGFY3/+LooAqWZwzWsCDLPxUwUk?=
 =?us-ascii?Q?7Q+dKNZtKdRgR/XRyAhPEpuCMVLGnni49ACm73n91VasI0Ds9OfKRdEWq19e?=
 =?us-ascii?Q?/rNm01W1doi0cbmXz0YKYv44QNWnQgPUsjHiH9HDZ+mq+EL6ybK3YO/WYZDH?=
 =?us-ascii?Q?G8FpL/FHnrUg/YGBywXvsW5DaX2rGXVJ7yAtFK/uDEvj8PZhO+MvlYbVC6ht?=
 =?us-ascii?Q?uFhhSQOoRrza7cT9a8VPNMazbgMYldmNbB7ygfmT93TaIKPE97Lb2ad+oKvo?=
 =?us-ascii?Q?lydKw2mJpz7JOa6ke2sFUU8pvE7oGX/DLomNwKOc2QnqAfRhQB4a1xyngmGU?=
 =?us-ascii?Q?fHh/D32fBnCtfvnGYn+nj0bC8xZ2S3CAM+qGm8RFvDrDaB+GB/7qteba+1Gg?=
 =?us-ascii?Q?30uiJM1qcm+Mzh+SDClOlGKsIo3477hqEZuis0UObYVJOt1Tdo1Mi1BGtTXR?=
 =?us-ascii?Q?hMkHh4wSKroPm4xLR0xdj+F1KhbX3BNIGtA0Jufbb2GHj6MfI4NoVcMcMbGv?=
 =?us-ascii?Q?TTvrhkHsypXFQRJgy6K7EX5qLfyfUKbsln/qOJW2omiSKUBiHD2hYccNzuMv?=
 =?us-ascii?Q?zHlopgw8EMnEtlw/DErg+/G7zT16ZXW71Zvzl5jS2KPALDcWiPvlnLJ+Yqmi?=
 =?us-ascii?Q?Xz0J3pokxWSDyqgDHJ0BgBYyi21BrcQUhO9EXusjd+HOttLvHC7U5UDQ+6iU?=
 =?us-ascii?Q?GzQIszaVPsdNlfPMhbKHAvzOR0OTHsH0FfTtHr/IKq28W8Xfv81DLZZYkGmo?=
 =?us-ascii?Q?wRP7TBskSufiAj3GuRogRxHBshslpO+TGIsly+xFZQgxUHmWhCxHywprslJ3?=
 =?us-ascii?Q?LeTg7Y6VD6u5uJkgA199wMy3Lu8t6C8eop1aTUi+Tn0F8lHkZwABKmgsDLMg?=
 =?us-ascii?Q?wyroya+A6hgd+g5sciBBOYfMXFOTmtLa5XdstAvCgid46TKGbTsT10ymhQxH?=
 =?us-ascii?Q?pyPfibtTiZKdH9oLwDMWuw9n4Rk/ZC/sdMbC9lfm82WXdi37EgVS3mO72pY9?=
 =?us-ascii?Q?A4cm9XU0QINVLH+UX9ngBpwuNd64Fs2qZUiiYoiFQbu1r978nUFNpINcLhaO?=
 =?us-ascii?Q?0Yy3mEyQpbT0JNVt6XBY6wLsocPRUNUeZYLS6RlFGWQ2DCZauWDg/RqDm0qm?=
 =?us-ascii?Q?+D2hwqy/UZvcPBDt451DElprwUH/Y7mmxtJKw3xibnpNgdAcebuYvy6CKGMu?=
 =?us-ascii?Q?JCjZTYbfbdIgjZowkaRXgqsLQt2yBexMv6++unKmPX9my34Qavmo0lKxzur2?=
 =?us-ascii?Q?P6GSdL0WsEMLmmSfPLiLgukG4Wds//i83u0mmI0j1qRcFfe0jNH/xwlm8CXL?=
 =?us-ascii?Q?zYJCaKc0UC6VCwQpHF5ibIvrfV1xDVIPglpjTSD4lbZLq4eYIjNgFdw4t2wL?=
 =?us-ascii?Q?QWmAcUXQkU/p57pkoGS0d2z2E0bMbIM5LSNw4WG5mNfz59QJ7Fr4GGRfRqGR?=
 =?us-ascii?Q?wx84lZjfLKuIJfY92310prispqXW9xgkkL/jvnqbIneNsrwwicBySb7Oznxk?=
 =?us-ascii?Q?UAVvVFRixVsoO+UnzK7JMGpJsfSHxzq/YGQ3QRJc0ohBDWZdZMGDluhpm4lE?=
 =?us-ascii?Q?PSxkcbmb0TlfX++IG4/WRoM0kOGkoSlgts7P2TZgnZ9+pAHUlNiCiOa9vdkB?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 572090dd-a216-4305-9418-08de06e73cea
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:52:16.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZqRW3xa317xUZ3Lcz5TrRTLdsA+s4kflo6WOEkajFVUqK2VTrIZCaTKeOSvnhwm2q4IiDLCXMakS2QW+jOcsm2lLkHLcC6FHjRm+EpaUDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024
X-OriginatorOrg: intel.com

On Mon, Oct 06, 2025 at 05:58:07PM +0200, Fabio M. De Francesco wrote:
> Simulate an x86 Low Memory Hole for the CXL tests by changing the first
> mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range
> sizes to 1GB. The auto-created region of cxl-test uses mock_cfmws[0],
> therefore the LMH path in the CXL Driver will be exercised every time
> the cxl-test module is loaded.
> 
> Since mock_cfmws[0] range base address is typically different from the
> one published by the BIOS on real hardware, the driver would fail to
> create and attach CXL Regions when it's run on the mock environment
> created by cxl-tests. Furthermore, cxl-topology.sh, cxl-events.sh, and
> cxl-sanitize.sh, would also fail.
> 
> To make the above-mentioned tests succeed again, add two "mock" versions
> of platform_*() that check the HPA range start of mock_cfmws[0] instead
> of LMH_CFMWS_RANGE_START. When cxl_core calls a cxl_core exported
> function and that function is mocked by cxl_test, the call chain causes
> a circular dependency issue. Then add also two "redirect" versions of
> platform_*() to work out the circular dependency issue.

This is some amazing mockness here !!!!

Please make it easier to review and maintain by making these 2 mock
functions match their core counterparts exactly with only one exception:

s/LMH_CFMWS_RANGE_START/mock_cfmws0_range_start

Doable, right?

>  
> +static bool
> +mock_platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> +				  const struct cxl_endpoint_decoder *cxled)
> +{
> +	const struct range *rd_r, *ed_r;
> +	int align;
> +
> +	rd_r = &cxlrd->cxlsd.cxld.hpa_range;
> +	ed_r = &cxled->cxld.hpa_range;
> +	align = cxled->cxld.interleave_ways * SZ_256M;
> +
> +	return rd_r->start == mock_cfmws0_range_start &&
> +	       rd_r->start == ed_r->start &&
> +	       rd_r->end < (mock_cfmws0_range_start + SZ_4G) &&
> +	       rd_r->end < ed_r->end &&
> +	       IS_ALIGNED(range_len(ed_r), align);
> +}
> +
> +static bool
> +mock_platform_region_matches_cxld(const struct cxl_region_params *p,
> +				  const struct cxl_decoder *cxld)
> +{
> +	const struct range *r = &cxld->hpa_range;
> +	const struct resource *res = p->res;
> +	int align = cxld->interleave_ways * SZ_256M;
> +
> +	return res->start == mock_cfmws0_range_start &&
> +	       res->start == r->start &&
> +	       res->end < (mock_cfmws0_range_start + SZ_4G) &&
> +	       res->end < r->end &&
> +	       IS_ALIGNED(range_len(r), align);
> +}
> +
> 
