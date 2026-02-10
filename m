Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A0265629;
	Tue, 10 Feb 2026 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752449; cv=fail; b=LShccUeJGheLewvbw5wMC1PvT2MrZKBaRB4kfcWNiT2GGJHmy/SK1nNqFcMlRxzKf6LUevk/uftaZ+KzEoJss7IJNUL2z/UlRRi1iMcON94tqNezho8fjO7QJo8SqxxAXrCYwlD+CTsCnY3PumXEFBq9YijS+5EOxeqmAMi9uFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752449; c=relaxed/simple;
	bh=/oZWPYI2XBWVjB2liOIimNtkxSPzUrJrLPVdOfth5e0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FsoX9g3JWKOWh8MvreBy3Qfi5O3cvVPkRXjoUI5l5p0D3oBZmfyxDDEVY2tfQm88aUbOkhqvygLJDZSpClnaZc3X3OKUlMc+VC0jPM26wrooSRTLifLWAM77NG6kWcK4+1MHcGw/vLcgEZwXVVoIEzCI/HwYUD6hDLd2w68GAPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+XmGO+O; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+XmGO+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770752448; x=1802288448;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/oZWPYI2XBWVjB2liOIimNtkxSPzUrJrLPVdOfth5e0=;
  b=k+XmGO+OPbmLTFBAhfwtljUBkHNsB5wsLHFUGZqyt9qSw07Lk/pHc6nN
   DZVYUd24yLiND7XiLun5Hk5cjXtF/TQt9qBWd8WCUCRYKZlO3T8/ciCjC
   EVujgBwWmOsq7q858uMh6ImkQ1HDcLFH0t+ZV4ORXBXObY+Gnepkdogo/
   K6fObl1pk5SKCibcq5Dyerwcp8bcdOQ6qNycvFfup4BgsqwJODcbT+Vie
   rYOoLSr5/dreuhMsMwfgm4lNdFWeGVerMY6DJZLXydGONQKmT+uSjbal+
   PDgmt0IqjZFfsh0pU8AyZ2umf+naQ26wptyHgaaUhSSF4JfqT4EW8bDT+
   g==;
X-CSE-ConnectionGUID: Wm9AGfy7T+yQ/rc8+jT1kQ==
X-CSE-MsgGUID: 2aMao9GlSMq0UR4AhM5rFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75519546"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75519546"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:40:48 -0800
X-CSE-ConnectionGUID: hwzRqZbaTLWFk06O2D4PVw==
X-CSE-MsgGUID: B6N2/UJ1TL+/3DjKJZn4UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211845520"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:40:47 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 11:40:46 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 11:40:46 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 11:40:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOWpPbDHOQjKR96nCtBTwg0PN5808TGUkpD3/5mVP3bbkudFxUgWEgZI999uRAMpbL2QRn9f16JHXvcZsB1onUDU1t7/tOnFUgQQbAKKGUPiQnBXqXP1E4/JGbRXxi/vUdJtZV381UrsVpk5BnYkc4rwAZRDOIm3fmsBkAJe9XuvMNpczcjnV//hjYJRwmKSJ5Z0UQJdVAkeXIuRwa0c9RjCe5jjVBBD0vZW+UGn/ZBURmpC8zvpOzywW4Woc3Xop/cbrD27SdTBvnoH4jFoE3spsoGj7srP9ab1MiyiNPO9ozUVxQXSsWKwq/iDgfUH9JMYlOZ4Cmb2icij0HBv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XStZLZt3xpivWoMmdAzdcWjk7Ygs69ipIVq208osvg=;
 b=uRAeAHIUOmicCtkiXa1SNE8u9JvdC8xoBy9be1nJhdqZX2Z3dzyL6YanWk+kJMlsmSTs3+lVbrB8dNXDjuM6LVUFEHt7Vd63DYblABI23GkDZ3zftN0sTA1YD0LABUvfDMU2+eRKlwAeRAQMp6B7GvAfN3AFviyR8BGmRx0Tslhfmoa/PyDdNACOnVI9f2JTX/CotGW7VDwudGTVUXbgmG6TecD2ZNJUwJiXujuGI3ocCW0ReY5QqhAyghomzJqOZWnjQnANt8nsBAZ5/wb1zm24GcFxYVojLgKcaNgNC+dz7DqTBTYEUSaMh7fB/E1tiqLs7qpsFmaoYZ6dtx/6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SJ2PR11MB8472.namprd11.prod.outlook.com
 (2603:10b6:a03:574::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 19:40:42 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2%2]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 19:40:42 +0000
Date: Tue, 10 Feb 2026 13:44:06 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/memdev: fix deadlock in cxl_memdev_autoremove() on
 attach failure
Message-ID: <698b8a8620f2a_dce1110074@iweiny-mobl.notmuch>
References: <20260210154320.1748223-1-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260210154320.1748223-1-gourry@gourry.net>
X-ClientProxiedBy: BY5PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:a03:167::22) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SJ2PR11MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 851613a8-27b0-479c-a254-08de68dc469a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uNQWgKd3CbV8xAnXKhyiGyT4S1zLL3FrOdQIH4hHAupS/sRGIjaI1e78eywc?=
 =?us-ascii?Q?VgLSTtxWALQ9aqtRV0Dse/w8NFilLP5EV4eIkGoGZBG/afOKmTCjz1p2DLql?=
 =?us-ascii?Q?o2sPJAMUGPuakIRIk6HRtqjstqo1H2NoZq2ZE55NTOxpFEmR+aotMLGl5V6A?=
 =?us-ascii?Q?b5slspwXZuNAGLrrtOiGoN5JmgwvyjCSyE7ezYZimEBpK81VQVYbnP0Fywkw?=
 =?us-ascii?Q?OY9sgUr+uAvuP3bpdJpy4ZJgKpjXu8jAJURd4trX6lHcDrWZkRCKy4qD5lA0?=
 =?us-ascii?Q?hNB6gn0+i4KPtApqDeidJBh55ZbNbitm0UngGACsx2iJ3+3J1Lcyq93KiAEw?=
 =?us-ascii?Q?7480qi09PkyLnk/vGNErPvbfoeCkOzyomu1boNLXQSszTm656OFUugy3mb5N?=
 =?us-ascii?Q?ASt3Re23oUCL1mBsRYcI71Nqp1h+EhcgB44CCipmZq+DLLvh9Wz5PmgELAcJ?=
 =?us-ascii?Q?+VNkpvaniLZA5D2EopMmykDIuDNQ2f40W/JwtIVo0yREkf+V6eso2E7nRjTt?=
 =?us-ascii?Q?WiF1sjaPP6RikuHz+Mu+PwSc1CdGFZ2dFlUH1s43wbqOObW0SfBQCKS7Bsb4?=
 =?us-ascii?Q?91bGRGdp8R/b/hA0cb25L4JA7NT6Qyz2JdEixsicVQBxnMVYrf6LqpMSUMV+?=
 =?us-ascii?Q?Pq1AV4Jkppu3mih3JrIv4O0OPwrPprsNyT5161+C/KraykvGweFKLdOaz8tZ?=
 =?us-ascii?Q?n1+QbumAOnRaQrEEc35/2VmJz7A18lYSXmFaSf4WYX/fK9a2iCHaRPwyFeyg?=
 =?us-ascii?Q?OD+a3g9ft9fnIVvDtPKW9okZphEzrILgUWe0yMmnEFjm6tj6EvwaBH50Qpz7?=
 =?us-ascii?Q?mTLOi7DQOIMJv/iVFKvpEYphkoS0oPHDc5UjYRKYj4Ak/dlmfxdjn1VxYtE6?=
 =?us-ascii?Q?WufYP8SHGXNmmEn9neJKmVMu7lzPIZD5vCaVGQEhTVVxZZw6oFOy2JMzbdt0?=
 =?us-ascii?Q?2tOyBbdzM8dqYgXNoXRM4G1DayZwMZKqnkUd8oeZNNwwuT6b7Q8CL4vycHq8?=
 =?us-ascii?Q?Io1ANCQZ2f2DuEA3OqdwaIxwRv7+SpBsXMOngOKWOxd1koIyRD5IjvAsmW4e?=
 =?us-ascii?Q?ka50DDLiE6RCz62n+KP470zWdVpTFu+fifwIpKCM1vJo3xV5Q0byNEHc2Dek?=
 =?us-ascii?Q?PywLD2uAQlNwJzgqRGwxh8M5iFe6d+69OTG2UDZw4ipSVpO1CcnTpAYIaIKT?=
 =?us-ascii?Q?jTrEMmZqOjNzdXsiZ4GtN3t0yt9/IljHB8z4JnFa4nJ0vedYc1xmpZfstrqM?=
 =?us-ascii?Q?RYLq7Odq+OR9ZpC9KUE1nUWSSYk0yVa6pUlLREnzCKyAnHF+59nS6DB3KMZ4?=
 =?us-ascii?Q?ctqLbyhnsJn2N4SkWI6nbFZFt24KWepgsuBVQmQZ/ABJdC6AKw9YnTthr7LC?=
 =?us-ascii?Q?BwWrH+wKL5sXx3WdqTy5JcWFy5et6wz3NtvZs4eHrEtahvFjtFqYjKZ5UNLn?=
 =?us-ascii?Q?IJcvuof+7t5Q6j5OYFtKSIlKIKSHwGU+2a01VizT5qNd9835XTcb89fVCzar?=
 =?us-ascii?Q?pnaZk3dd2LlzWtCNt29/mjYoaeLWtCJl0VGin9nILeO62HNBQ6DAgzdA+rvP?=
 =?us-ascii?Q?F9LjtHGuR+itWU6OQ7I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qJK8cVjvNNbXMk+PLkf2Y98QAgeID2sG10nqddg1cpLbNyVrTQkcOaVLZSKz?=
 =?us-ascii?Q?t/TvuPPY6LZ/tNLie+QWSQrNtUjOVCnxnpuQTiY2wNxKmysVA4T7kjwa7eZz?=
 =?us-ascii?Q?wdqcJCx0wy7XjtD/YeGcUKtlcxBupw9R20LE5cax4udzT96GvepGqy1CCTa5?=
 =?us-ascii?Q?YRMS6vsrrexx4hR+mR+fSijqHt59ibsBxldrfW9l+01InpI/2liQMx8guPAO?=
 =?us-ascii?Q?9QVEWJlcSPnQcN0cfnOY3Bz6xTNFOWotui9dqw7AL3q4IhuuYLRfbyGg6dyE?=
 =?us-ascii?Q?XeWpC+u0a/k64mqW0FU1/DQTAMX6l1j/6ML/pHiMzSoIriBRiC0tYDmVG/kt?=
 =?us-ascii?Q?ntmmkbXqHPRQrqWvx7j5Q+EWMVI8hdBmWbBaX5xKkv25S5WHg7A/hrMH6EMu?=
 =?us-ascii?Q?Hk0sBbrhSeG6j4egf5KMJJh13JiBa3QeEIsDVGhuAeYIKWdlQZPG+Gjq5hOM?=
 =?us-ascii?Q?QTmE1rQCWuTaoHVTzdFzd6uLNL5nT6/b7dJhe3qk+Kr2smGKAuGHd77Ni7f8?=
 =?us-ascii?Q?yQ/q6MFuGaSJ1ziJul0RhDcEU8wIx+um1zbQdq/D7Mgvuimc2dD0bqfIdeNz?=
 =?us-ascii?Q?eZHUfGZhKekPLYOe9hq/rD/Rw/jsOkYWrSfn8LYO3JT+r4sf4O8N780dkFGS?=
 =?us-ascii?Q?Pvw+WP5aEMLVFCCxL3hT02ZjRKUTTDjCO1++CmEa2m0txhfE5ppnuoKOBTK9?=
 =?us-ascii?Q?NZRZ8N+JGX079sJEUtXqbGhUUew8CGx2SeP8pB0OboYIvx2+1XnOOVeBcKac?=
 =?us-ascii?Q?zbb9u1MMGygBkbE6aHpTGo5aBJ5QmFHSLxuhYH+Qk6Hzs+4PXUzoxKR8B3Uq?=
 =?us-ascii?Q?IGgerVo65ddKWindJTIyqCxURvmLXAH4lV9w/ZfkhWVPt9jztKdqjMDfjAJU?=
 =?us-ascii?Q?CvbEioovGPyusDy79fDLVjNIXlKnXLZogJ8UAI6cugiQWud14TCeMdc35XJO?=
 =?us-ascii?Q?pUETTehWL4FA/7s/QUa8M/2TDgVxkBFPtsZagVZUPZKW2ErqPZBf0n4CGxg5?=
 =?us-ascii?Q?ZTeSRW8Hd348fQLRjcm2Hj9HCRGEtXZRohqungIAO/oMkJqgf/pqjp36LArM?=
 =?us-ascii?Q?aYzytBzxQN6wi31qJjFxmEoj60X7AuYAn02nHwnowF1OY696UHNFmSSJDEi2?=
 =?us-ascii?Q?BxX27iMQ1pgPSDbrqeF2Lcyca8HV2/YGa9HY2yG0xUcxZzoOQ5ELbHumkCv9?=
 =?us-ascii?Q?XgvaSHPm+wA6CJbekDGcjX+N5on93RpCLWqKr3jnjifXohc8hnEh79ou1H9A?=
 =?us-ascii?Q?Sn7p33Q2luAsSnW3j2MLDtN28I3m9aDK+ril7CM69m1mFumgkLNrd1ZxoDtI?=
 =?us-ascii?Q?lmw8ox1osEzl96QtPFMQ4ftvp1UlHG9td5XbsTMjkAzqtHqF5mJlTSSJmHtH?=
 =?us-ascii?Q?0Su5duG/x9xO/jn0SekmBMAepr8lutjJwq1e23qbjKxw1uX73s5CQCsTJZ8L?=
 =?us-ascii?Q?SbqoZMO9Kb/esA8vtmNvp31KelJsaf/CH/+qvMESAATqMsZKLKGJ6aNIUYBs?=
 =?us-ascii?Q?iAbirCklb3hVl4QxJV6d44AjrB30jO91tPWbPuqLjYoi/HXOy6JJcYRFWPeA?=
 =?us-ascii?Q?IORkbt7YVBY9vEW9DcdwfxMQd9dpL/LwKMuPSSb1sOAafsGIPA8e1JSVa7np?=
 =?us-ascii?Q?ZyNw5Fhy4I69WN6gX5B7OndQPEXhA+OmlIrPd5nGamY/IK/LEfveFhk8vl9P?=
 =?us-ascii?Q?43RKj/mWeqzsG16yfvA3xyHe8w2Hpvi7RiATaRuJGwe3FY65f5clwXgfW3IF?=
 =?us-ascii?Q?6wY3jk/Q6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 851613a8-27b0-479c-a254-08de68dc469a
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 19:40:42.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3BRoOUeytH/sHjPDIgydFMoOJi54HFBuVQh5nSaU1unfNaqv3SbBmTMs1PTAa/mpwlyCfjwYnyhqwweJxknAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8472
X-OriginatorOrg: intel.com

Gregory Price wrote:
> cxl_memdev_autoremove() takes device_lock(&cxlmd->dev) via guard(device)
> and then calls cxl_memdev_unregister() when the attach callback was
> provided but cxl_mem_probe() failed to bind.
> 
> cxl_memdev_unregister() calls
>   cdev_device_del()
>     device_del()
>       bus_remove_device()
>         device_release_driver()
> 
> which also takes device_lock(), deadlocking the calling thread.
> 
> This path is reached when a driver uses the @attach parameter to
> devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
> DVSEC range registers decode outside platform-defined CXL ranges,
> causing the endpoint port probe to fail).
> 
> Fix by using scoped_guard() and breaking out of the guard scope before
> calling cxl_memdev_unregister(), so device_lock() is released first.
> 
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/memdev.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index af3d0cc65138..c0de767b24fb 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1098,19 +1098,22 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
>  	 * return. Note that failure here could be the result of a race to
>  	 * teardown the CXL port topology. I.e. cxl_mem_probe() could have
>  	 * succeeded and then cxl_mem unbound before the lock is acquired.
> +	 *
> +	 * Check under device_lock but unregister outside of it, as
> +	 * cxl_memdev_unregister() will also take the device lock.
>  	 */
> -	guard(device)(&cxlmd->dev);
> -	if (cxlmd->attach && !cxlmd->dev.driver) {
> -		cxl_memdev_unregister(cxlmd);
> -		return ERR_PTR(-ENXIO);
> +	scoped_guard(device, &cxlmd->dev) {
> +		if (cxlmd->attach && !cxlmd->dev.driver)
> +			break;
> +
> +		rc = devm_add_action_or_reset(cxlmd->cxlds->dev,
> +					      cxl_memdev_unregister, cxlmd);

This kind of threw me...  Won't this deadlock if
devm_add_action_or_reset() fails as well?

Need to use devm_add_action() and drop out of the guard on failure.

Ira

> +		if (rc)
> +			return ERR_PTR(rc);
> +		return cxlmd;
>  	}
> -
> -	rc = devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregister,
> -				      cxlmd);
> -	if (rc)
> -		return ERR_PTR(rc);
> -
> -	return cxlmd;
> +	cxl_memdev_unregister(cxlmd);
> +	return ERR_PTR(-ENXIO);
>  }
>  
>  /*
> -- 
> 2.53.0
> 


