Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFD32D5C8B
	for <linux-cxl@vger.kernel.org>; Tue,  2 Sep 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828675; cv=fail; b=ee1NmDnzEMBt1apxfBwCE+osRdfTKcQWStSQtidbzTGdCcSH1vzxGbrIKYoDVuZiHWyDTGWTElhD2cX2Yhj2l2MK5Iw3z6T/p+M7UHQ+1XLnmt8Yif8AjCGQqM/E3C70I6che5u8F9lmdX5FNgTSP7GfYq6u87c5fQ+dLd6xkWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828675; c=relaxed/simple;
	bh=0Dy06LO2mGdAvFlCwBABTGYSbrwjh+iv9b3xA991QlQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TF+JMcsYR/ChMUpi0lQx/WOUazzJm4gTHSIVx8iNO+f+fZ0tHEVWIeIgKIwEqPOd0f3IlskKVU/Ntleoav+KgnTYH6C3kN5/aNOUv2HRvpOMwMKtrQrudRwSqqyWYL1/fPTUnQlpfVPUk12mOqGD9SolwAP39mxRXEtgJZf/Uv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AeSZWzcq; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AeSZWzcq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756828673; x=1788364673;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0Dy06LO2mGdAvFlCwBABTGYSbrwjh+iv9b3xA991QlQ=;
  b=AeSZWzcqDGwY8PpkWa2LuINzIhIB/mASchTGgwpmiT582kq55n92ihMe
   LfX4F7azgLC2rqr8SRtScAd+9LeijvWTx4+r1bIxtX73LXy6NQjvV0NeB
   zNylfX02PJZg5whRfdkxPTEmysm4xsYrBsfShVFdyMZi7fLOIt2Xjm+8t
   beMl3dE1p06TNTzmyGpbuKym8hshPD2WZ0+h43KFwbgrYzlrrxEmsk1j+
   N2WsoYKvz7TIKRRJObZf/gGlgNrpBH5hu8v+Ukoi40jUAXvylHjV+0OcQ
   odHQ4kIM6gYsMIfkYVRR9LEOUT235dECJ/gpE7ybDqkQFALJwrHcFgNKv
   A==;
X-CSE-ConnectionGUID: TxUS8q6GTLqJJJAYBd6yOQ==
X-CSE-MsgGUID: 1KxlQjf4RIuigZJxGR97iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69720744"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="69720744"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:57:53 -0700
X-CSE-ConnectionGUID: lPggtp/gRDq4N5UimWWitA==
X-CSE-MsgGUID: eaQ0mHIgSbmgzlaNlkYNRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170603264"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:57:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 08:57:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 08:57:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.41)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 08:57:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hz5YZkxVfzR800BekR8z6gkmupnvOy5xUxsNjKrfakq1yFTmkcpR0qJ7lBJypnmqlunPOEdQiV9Pml0jgeVxJsO2wtf9UTSmWblDROIb8+EkXhvAJcSKNi7FqQoyex6jp4LUFJ2U5BkTAmUWF3esOSVXMt290wF+LWXI5BzB2cgib4gBKE8kx40N9dU0FWWAjceQD3PUszHCpns98Tnwnn3/RsW1CQWfhckTp/msxOWMGw/bsNGV3ZDlhw8Hk2i6rlSDYrPbpbodXmoUTbMoGS2Kp2sA3zOH49wUcEM2zu7D6uMNzh49ibLlhZCr3WV6V29WYMUyqKTPbz0uqHT0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GUnBrPAPpSgum06hdebN553IFr+ftxnTCcOB2I3nLE=;
 b=AKQc9+pavraw7n4yiPwa4xxKRf9oEknhWWeQqLxNuJb3u/3CHJhmZTaTIzGzVSdlnDQJ4WBj21V/O8gWCf39w+OBOkcdsyfotN+C1hy6QTnOIELPDPz3QeIOyDhqA84ozKuAzZ6O9VPSpCFknNRuvIrmvSi6hSLBmaU+N1A/Xn2/LU6qiYqt1gKasg9upyyF7t7LiUhAMjHtw+k/J/hQVtrG99b7aZtJuWr/w5OlAzxmcH7REijDPyH6K5KIIoDv1etgezQYtAaicmprzwoYL3iAW+CXrwC222xB3prshW+wSC/M+HAVUb52s1aP4I5S1h8djGYAEXn/CgSqB3kKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA3PR11MB8047.namprd11.prod.outlook.com
 (2603:10b6:806:2fc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Tue, 2 Sep
 2025 15:57:48 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9052.019; Tue, 2 Sep 2025
 15:57:48 +0000
Date: Tue, 2 Sep 2025 10:59:35 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>, <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>,
	<armbru@redhat.com>, <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>, "Svetly
 Todorov" <svetly.todorov@memverge.com>
Subject: Re: [PATCH v8 11/14] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <68b71467b850a_4bae529418@iweiny-mobl.notmuch>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
 <20240523174651.1089554-12-nifan.cxl@gmail.com>
 <20250902113915.00001fbd.alireza.sanaee@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902113915.00001fbd.alireza.sanaee@huawei.com>
X-ClientProxiedBy: MW4PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:303:83::35) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA3PR11MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1e27ce-4feb-4dd0-ca0e-08ddea3976be
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D+q3RkvZ31hA+fNCz4CkC3WzPe7HMHBv8Ty8P6pLFfbOGsYR5wldkV0usVEC?=
 =?us-ascii?Q?/qPAfmydGvvvvORfAyKf0sw7U+QxKqPiNCogZgFwEuomWMF1S5rYCS1cPMBP?=
 =?us-ascii?Q?kDq2Wl1Zf2UmpPmXlC3MNHU+kZWdnMMocctCcsLQI+rH+yFxwRDNQtOdELWc?=
 =?us-ascii?Q?xw5U/LHu5ReckEXxXMKHEAnz3aHpqnAnDBkV/iBWaI713pKunzelQWBnmL+V?=
 =?us-ascii?Q?knXc3Zl65TbtYjKdk6z437e+fPq6D2b2yq6I6LJkitmz8MFPtTIOgQbtphXd?=
 =?us-ascii?Q?OySgHf7qmjCVc0KUSgr2xKbMdJLuTAuEdSI0kSBnci8miJq61T8I0T91QLqD?=
 =?us-ascii?Q?eyNnK3rwI5CVPbJLtGQKmxV2rnZIMa+lXGqULJJP68tC0/BOh0TcbK8x6pfi?=
 =?us-ascii?Q?3cRLTlmTv3U//HTmIGQJJajrdPnweQ08yOUPG2pcCReMd6n45kU5pJ3tVaiF?=
 =?us-ascii?Q?yu2LLXLkfGsLrjPnZitgh8KJaiY6uCmbt1ipq9hY7ZYzbgy3Kot/zyfUuTbS?=
 =?us-ascii?Q?/tscPuzZdLdFL29fSrauroJPu8hTaqMxcIBMEZaxmIROU9aopg7Sch0j9ao+?=
 =?us-ascii?Q?R4NsUtkyGiIWtX4lKIdkhOaIxdtbjW9WDY1cspBvpr54B0Vg8Bpph5dyxdj8?=
 =?us-ascii?Q?bTVvEVJw7cxVD7jLSNZbzsvudjHW+JWdi3H+oHgBe++bZgU5cw2V8mSxeyzb?=
 =?us-ascii?Q?aEgLdhKBRNrV/sI3r5t9vE7B1F+LqNJMyPzW+y/h6E5hYjVMfMtG2HDY68VO?=
 =?us-ascii?Q?MShxJLdiLFFV0KRHizGU6DNYtacvmj7kD8f1RnkgHkj9Z7a5lJKfY+MY03et?=
 =?us-ascii?Q?BMF4GZgc2ScUQtEmTaPt1W4DJrdffS74l9ablM+NZReYe/qfybHGmkJk4sG4?=
 =?us-ascii?Q?XYKMmJ/LEc7rcCxFB8QzR1jg2ssZF447QM1J3vJIBLg9nCShvLtow30nyliq?=
 =?us-ascii?Q?XXSkLndsVOwADyEajJ+DoFadA5aeZqaPnTPwTWq6KpcIAnYP1ipHPy8943oO?=
 =?us-ascii?Q?cVgqLdIRVpunAX7y6wVCne1vUpoAWrYxy5Al7j+QmFuh35JgDjqkHJnxqdwG?=
 =?us-ascii?Q?cBUigThBkCjnYCsaZI2JVdl9nZv3hV0MwIUT9W8024cCFPe/+r0syU0KG0N0?=
 =?us-ascii?Q?eQEeyELU5HQ5pyQrvgk/rurApmE8UQsLSvjRm9RQH0rE9Xjt8nXTZSHIUw19?=
 =?us-ascii?Q?z2p+0ERLuinnmA8o+h8qJDBd+QEiLDe0nvtalxdqPnxhcZ2XfstT5hLmp49O?=
 =?us-ascii?Q?/LumGX2cbw0kS8nx9qV5a2iYGR3Yz1brIPyB0BjiASKixqwgJbCaC/YoQLv5?=
 =?us-ascii?Q?1nNvYqGxvou8nJVXskdGJ9nWcVtLWOsQ0Qnbo+cnaSkGbwRNhvmFtZ3xVDKd?=
 =?us-ascii?Q?k7M0ogODj1pYVW+SBG/bcm8a92Vnz9eqS4tQgf/q+gE/DeF8IhFz+27heGbV?=
 =?us-ascii?Q?dIJs7bjuBYQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ghI2z1NwhvW/m9uSfzJjZIsgZ/5eDBxzF6ryVyXWOsa11n2dYwQWrKSeT1Ku?=
 =?us-ascii?Q?mOT49R73cs2cQnqykTncpuj9amx7Dek9pcGSao1QKacCFm8Ma6KxxdKJMh/A?=
 =?us-ascii?Q?L0IOHEsWvWA9f0cse2KQlbalFiN0GIsHZec80zXIUu6B+BIVK/2hdfEmBWxx?=
 =?us-ascii?Q?pdBCduw5h5G2ParbFYhIJHUWYpbsGdwgB9jnCWlTr6RHuRb/mJ3gAG0fF/zj?=
 =?us-ascii?Q?IiHnoOqNmTYcWmOGvjyDLtvUbq3hffoUPtyS1ZJcEnIVUNoLa4yWDXtRTZw4?=
 =?us-ascii?Q?0L1nOkjfP4FAL+2UhfMLvAsNVsUtUPch3cQjgjhoef/fCaCs2R4T5/u+XFZ0?=
 =?us-ascii?Q?B5JmTElNkjWGQ4rh7tSIeMrw7q2Qec35kvsZvcDz2HYjxmbx2hAHO0E8kev+?=
 =?us-ascii?Q?88OrEiLG/iOFb6ToJWBQ3dFJHABBIfJ9ew9o/qkJ6baCe7uvm7T37uqrdXdU?=
 =?us-ascii?Q?iRZpPa+CmuMTJR4B7D4dtXR4BZgtIGAag8lWbHJyTaryrUGdjPUsSKeTHlzU?=
 =?us-ascii?Q?fQBjUShRIcCwq8uRKMjY8YoJ8h1gCSyohRIJDHMATbmyKkipl3qw/mWlUKWN?=
 =?us-ascii?Q?voErExtm6X49jFeAelJRSZa+8C0WByrqiJ7wj4bVSBRuzKZ8QoSdz6Dy6xyv?=
 =?us-ascii?Q?yOpJivcMvCVDqkpOpKpCxFpRmw/QyOtM1OoOEbyH1FwupL/dDPTMyq2cnhev?=
 =?us-ascii?Q?9ywgA0szuh7xiWYr94Um/0mymrp86gyfDhP45+lzopfS6YkbruLZZoDsG9aV?=
 =?us-ascii?Q?YkucLfn2+qmtgV6D4gPUboOjjVOOq4UhfK21ATbzkR8TVWS4dzpczH9kSLIX?=
 =?us-ascii?Q?F5FU+6fOdroD56YSrrvvV3WiL6fWEv3JG4BOhaTduwIrUOlUw0ZGuK8yIP+4?=
 =?us-ascii?Q?SBLccWkzkRtVj0mE/v19hVwRICwmwKaT3Eef+iAlKvCatTl5BBfiVOsuGcaa?=
 =?us-ascii?Q?kLJp8q3zxXF3Fv7UKMpKpxYa5ewDgkRIijYS8pmDFYFjH2j5XM0jmXDjd06C?=
 =?us-ascii?Q?eQKq4I7FOgKMvnI1wLpAZWNAQ0pC2tacFVUyNfMjAUXRDFJQen1OFckeR/MO?=
 =?us-ascii?Q?B+d6B0LdCsN+JsSfXiVlNJv44jfxV3zmPRaC19ZnFL4iOEoakDiWvGySvfz7?=
 =?us-ascii?Q?AMSgLoq8WZcgKIItI0aahZk9/yw94gTP7I8GlZNEKipb9f72+vTyIuhGzX9b?=
 =?us-ascii?Q?uYXlCWD9HAfUIXINUHJNUnc0jAfALbMmh+F9SBkvXKlq/QZyu9JkgdVUe8lp?=
 =?us-ascii?Q?4m/YubZWJqW+JalU5vSLe1KTCPAVqUkI5G2gtgs4ZZDP/qRRDkZZud17SdjC?=
 =?us-ascii?Q?iEqylG8Wjz80prhMefc0J7LYw/Vbf6hLaIUDyqWIfV0ZcwRD/UYAOgEdFRGs?=
 =?us-ascii?Q?r5JCqi8CVyHgAnOZ1os+orrz+9cl89Y6gsJsY9/dZJEFuMI+2pej/bxT97wM?=
 =?us-ascii?Q?t5heiEhsBfgOBGLJjYErVPdr7bBH/H2wkjeKRVtBEiEMIEhyHOBBbDUK7zpt?=
 =?us-ascii?Q?RLxZ4dPYs3F0KSiX8yAGdQCfa2eKv3LTRNRFdEM0RZMzxf2wv0B0J6096hPj?=
 =?us-ascii?Q?hEhs0xCxJqPHzHgXBYSOb+kyk4zKe9x8v2POVm09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1e27ce-4feb-4dd0-ca0e-08ddea3976be
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:57:48.4563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MtaUTjrsoQcZiv11x77l2bwcEuNnuvZiJ5wNmE6EiDHq/lZWWoJUiauiHdxtqbDg4/OiUiCprvyLmOC7spIDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8047
X-OriginatorOrg: intel.com

Alireza Sanaee wrote:
> On Thu, 23 May 2024 10:44:51 -0700
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > To simulate FM functionalities for initiating Dynamic Capacity Add
> > (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL
> > spec r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces
> > to issue add/release dynamic capacity extents requests.
> > 
> > With the change, we allow to release an extent only when its DPA range
> > is contained by a single accepted extent in the device. That is to
> > say, extent superset release is not supported yet.
> > 
> > 1. Add dynamic capacity extents:
> > 
> > For example, the command to add two continuous extents (each 128MiB
> > long) to region 0 (starting at DPA offset 0) looks like below:
> > 
> > { "execute": "qmp_capabilities" }
> > 
> > { "execute": "cxl-add-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "host-id": 0,
> >       "selection-policy": "prescriptive",
> >       "region": 0,
> >       "extents": [
> >       {
> >           "offset": 0,
> >           "len": 134217728
> >       },
> >       {
> >           "offset": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> > 
> > 2. Release dynamic capacity extents:
> > 
> > For example, the command to release an extent of size 128MiB from
> > region 0 (DPA offset 128MiB) looks like below:
> > 
> > { "execute": "cxl-release-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "host-id": 0,
> >       "removal-policy":"prescriptive",
> >       "region": 0,
> >       "extents": [
> >       {
> >           "offset": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> > 
> > Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
> > Reviewed-by: Gregory Price <gregory.price@memverge.com>
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>

[snip]

> > +##
> > +# @cxl-release-dynamic-capacity:
> > +#
> > +# Command to initiate to release dynamic capacity extents from a
> > +# host.  It simulates operations defined in cxl spec r3.1 7.6.7.6.6.
> > +#
> > +# @path: CXL DCD canonical QOM path.
> > +#
> > +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> > +#     Table 7-71.
> > +#
> > +# @removal-policy: Bit[3:0] of the "Flags" field as defined in cxl
> > +#     spec r3.1 Table 7-71.
> > +#
> > +# @forced-removal: Bit[4] of the "Flags" field in cxl spec r3.1
> > +#     Table 7-71.  When set, device does not wait for a Release
> > +#     Dynamic Capacity command from the host.  Host immediately
> > +#     loses access to released capacity.
> > +#
> > +# @sanitize-on-release: Bit[5] of the "Flags" field in cxl spec r3.1
> > +#     Table 7-71.  When set, device should sanitize all released
> > +#     capacity as a result of this request.
> > +#
> > +# @region: The "Region Number" field as defined in cxl spec r3.1
> > +#     Table 7-71.  The dynamic capacity region where the capacity
> > +#     is being added.  Valid range is from 0-7.
> > +#
> > +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
> > +#
> > +# @extents: The "Extent List" field as defined in cxl spec r3.1
> > +#     Table 7-71.
> > +#
> > +# Since : 9.1
> > +##
> > +{ 'command': 'cxl-release-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'host-id': 'uint16',
> > +            'removal-policy': 'CXLExtRemovalPolicy',
> > +            '*forced-removal': 'bool',
> > +            '*sanitize-on-release': 'bool',
> > +            'region': 'uint8',
> > +            '*tag': 'str',
> > +            'extents': [ 'CXLDynamicCapacityExtent' ]
> > +           }
> > +}
> 
> Although tag-based removal is not implemented yet, but still just wanted
> to leave a comment here that exact extents are not needed for tag-based
> removal and `extents` should be an optional parameter here; this is my
> understanding reading the spec, so I still might be wrong, shout if you
> think it does not make sense.

It's been a while but I think this allows the removal of non-tagged
extents as well(?)  If so the tag would be NULL (or empty-string) and one
can remove a regular extent.

But I could be miss-remembering something,
Ira
