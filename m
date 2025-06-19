Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F8242909;
	Thu, 19 Jun 2025 05:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750309484; cv=fail; b=pmhtQvgIBVmO+IksnPdrqIuTCHw4/8RuBrmrLLCSMLHXcZisDI5pTk3NOma1cO/K7zfaikukaYPllWHBya5digWQovi1UnX4dwGp1Z+LhQ/3AS7dYHU6s8aqbzGG6luJYLyACtIsUnxzehJgXs+tNs1w3Zfg5cUOFCQSZo9b9Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750309484; c=relaxed/simple;
	bh=pnQcwtvjBxa9RhuYul1e2b91s6N5YrFoqd5GpbEBFaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G0YXnlOCQudmSFj3pS+4kk/IBwA3h8AUfbyXOUDdC8qMr/NEpVpwa/DrTj3KiAFgb2xMxJ6tmSb9WIRxgU5OGu0wDwlECTeEOs6qgLCE3zppM96t7m5Hm+URygS+S3sN1RWf1ErEBMrVS/LDAbmn7DT+JNvdPrje9lDjPrgCtPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQec2hfy; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQec2hfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750309483; x=1781845483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pnQcwtvjBxa9RhuYul1e2b91s6N5YrFoqd5GpbEBFaY=;
  b=bQec2hfyJLnpJIf4+dUBXwY4wRjCFRefUU4IpztftSVu3R8yQeEzt+T8
   kPsV/rezbP60ffxF6D1LK2N0iffhZUtwWXRbRcE4MAbcE8Ww8PWJLSjgp
   EELZlieGeMM+Yiui2NSlcCQUyBLNq7CxyFB1bCB5Nxa1JaExFuS8ilyWA
   sl/w5mbzCOCrmLobvc9SFAY6Msvp9ziyK8oJxBHLt5S/J8yYLGa4X+zpn
   KKQekGyJIlZ/r8T7Zji2mo4zpgzlOqFb5y+46yv0HArI45v8LgMzw3siZ
   riLxYmGzYZ4hm0OhWHIF9ZciDVZgPLW759FcJu98pIOtWhXc5UDZMmExu
   A==;
X-CSE-ConnectionGUID: bvxMLNrnSAyOi0j91GrSJg==
X-CSE-MsgGUID: bicGt+D8TX+WYWR93O7xSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52702219"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="52702219"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:36 -0700
X-CSE-ConnectionGUID: JE151PNvRtmWbDQhItWxgA==
X-CSE-MsgGUID: fyu2aZMtTvmAByeUcrOoJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="154413123"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 22:04:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=besEmmMquqLIharruaE90NptrAArPmnTTuWm5A9bNSuGruLW/I6iBxsnG5FCLuyYHCH6XLy5vvEmxPchxIZUoeDd4PE78SyQBhLWYbqU6rJKt/KAzv0e3DotfMIIFkK+1XEZmRmi8tVYrmHahOBeIEyn6EqoY8boZsVySBfkjqnmQHH2vgkIata4BvveCjk15GBzWx3licI+LARAfQ4GSLKH5ZDcIW5504svQLUi9KIMdhW/6YT4ra3aBpMMmHfT26Cdh1Gq/6jfa75TaulHmeJx7QrCkjnAB4GGMSpLROJpuk6TvlgsHot+y/iT1b/yup6hayuiiBJb4nhtHHmFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Erti9SVioFgVrvcz7zKlktZcq1LFHx3OHBo0ntneSXc=;
 b=lzA50NujKJdHeuqHsU0eWY1d+WHMAPrXsUvpUR2b91T1ckNFelh5wvmEY+ld4BNlPwnIOc1/efweXmDtLZYQ4/2YI/S9Ukoe7s1t/T4wocd6S47xKktEDY0nmlIOUuf4/vq9Hx/2A3yaVvQ9xAzjHUOU4AftM64YxSgOus9dwfMlSdqNVSYGPmPt0Fo9KhInxsrIQo+U8KvSxYQC/kKD1l5rU3Ai9sUTjNJM6EZFtQXEy5t5+Xu9rOV1lhHdVxMOFoGkqS2XexIQ9tEzF7Ynt1C3diuYCoco3/ezgJtxaBHugEjfi1Z/laQ5jN5onrp8o6W43GrxyeZCmJJG0OxErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 19 Jun
 2025 05:04:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 05:04:27 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 7/8] cxl/region: Introduce CLASS(cxl_decoder_detach...) consolidate multiple paths
Date: Wed, 18 Jun 2025 22:04:15 -0700
Message-ID: <20250619050416.782871-8-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619050416.782871-1-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 6307bcf5-b1fe-409b-4192-08ddaeeec3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JvhqKt30iJmwWbnvARUokj1hU7WHjjsZ0Dlu0qH7xWUjGyXMOiOJGeOM+Jwo?=
 =?us-ascii?Q?iOpVLOm42q5eGdD7IQrFGmXAemZ4hQXayYEg2pu/poErA24CzDze6SRARpFE?=
 =?us-ascii?Q?LI7r+wbKqb/rSGBnfYEaH6j865OcPrnD/k64sfO4E6nipifsqhQmJD1rI8Oa?=
 =?us-ascii?Q?rGECZOolHqN9hJaJRj4J41AEiVmOgS+6ZR/UaAlUPhS5z4gliG2nwopx4Vp3?=
 =?us-ascii?Q?3eaDWIv54LxX2LDlqtGckGQwPGND85bpHYApFH/evV0rRF6fVUV2eInG2ymn?=
 =?us-ascii?Q?o9m7U2TG5wC+Ir3vrE3PlO9WHo3gagyaOE1l9h3PEtmUUmeW8FOEClJz7Rme?=
 =?us-ascii?Q?4d2wxlWcIY4sSEJcXAFY1DSf66CjHsHJcBnCUzhI0PUb+dgDNhpvnEAfWNh+?=
 =?us-ascii?Q?bF7wnOVmnXgKGGCAfOMpIwWCga4gw7ByKxIcz5of1nhUgxmMsnK2dkJ1WYd2?=
 =?us-ascii?Q?8/ZzvIzBm8r4LA/50UEWH2AE69TugHZKPBTsXdWBg1eDYcxpMjiOLUgqNhVh?=
 =?us-ascii?Q?0YsFgPmj6FYvNNU/M9c0re7t3e5yl7iPN5GOcumJpzLTncgGcPoaDvPtzwFD?=
 =?us-ascii?Q?XPRtWKRsYnfOAgEdrnaNFq7Lj0hMBKXaoFBnAZuwicR7AVAiTs9V9SKvlHnO?=
 =?us-ascii?Q?Uy1PbtrbmNUhanZ3Xt3q2WdHlB65afssKaJ7fAQB1VkzvERaz/2EKeRPU7Ft?=
 =?us-ascii?Q?r0PY7u6QP0EDcvEhcvRXEf5CwJ4h27W/uOsccfZJS202F6pAm3iGHKwCvz/2?=
 =?us-ascii?Q?LW5pGyzYBlgpXm5VHRg8/aqW9BOtUX/N+nuHZOInTC6htL5wWj/xq92fNXbv?=
 =?us-ascii?Q?SfmPp/RBgh18H9KUubbuMaN05DFnwgsABgYBSGUZJsPHyFP+e2H4nHX4V+7M?=
 =?us-ascii?Q?nY3eYoeJzCEI45S+Vwh3IL/JvYpq43Cj5kShqFuY3PPIf4uaBAbPSvPMrrT4?=
 =?us-ascii?Q?vbM8HhmRV7VGa6P+kSS29B2pKV/1fQKYlk8hV0lcLOcWjRFj/ArWmBQBHscH?=
 =?us-ascii?Q?3hs1KnX/k5FVT6Z+2KfgqtD8UZG2RbDX0Z9OD7EFF2MyCMAlZKsl4ZUjQTeA?=
 =?us-ascii?Q?XLKB70bJ/JNiuvTqGplrdhwjwyWnW4dBbmKi/FjovrLnMrhAfaUb67Br3Bag?=
 =?us-ascii?Q?90r20FlPQi8qfzQc7cqRAeDz9ZMXHRh0K2hBsI1LC1/G4LNCCqV//8Lld/TF?=
 =?us-ascii?Q?9yxaIjZeHqP2uL/Io6dCY3bpriWmbeNAgclo1/iF3Ld/2/D0yKfyVd2ytWje?=
 =?us-ascii?Q?oVqXGTYdjzco9pywKRKLu+Zl0sYXPutta/JT9Uw5M5lb+0JmG35AJclG2hn2?=
 =?us-ascii?Q?d8LXGBd0KDVGfXDbV+ArKm4E51NVrEru4eg3jxR9i/I58iuGNRMwo5n8QQFv?=
 =?us-ascii?Q?ocnymADGw2haHfyPdmK+Fz4IDDE4E6LJXpBP7qHQteM0Fp6dULNsLMSYeRve?=
 =?us-ascii?Q?ock/eBh9z1k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CSA6vRBvhdKdoKMPcVU8SQx9Gu2Nzu2s83AURTo3cOyjAMEgJl+hoaACa1tQ?=
 =?us-ascii?Q?25khIQ2N6g5IV6OaaxnvS+5YS4XC6SYuR8DN7GcLx+ApueDLNfb5ZMBFrwnz?=
 =?us-ascii?Q?HDgvu2oGl1150xu2/TI9uCj8RZvLQrTKuVZgKxGFlJk9c+u567aQDuuaLnzx?=
 =?us-ascii?Q?2zxx0quTsIDUzwYyMui1Gz3woVm2uA2DQpCp/OqoWp0mbBollY+tB0Ma881R?=
 =?us-ascii?Q?HcSZP1C2UR9hB1D+BtvfCSKSrAANbEd+GkqpArYcz2qyPimhS7yJyEDi968F?=
 =?us-ascii?Q?mTZyITc3NHpH38w+rr3vTbbp0uXq2wSlT/zfNUrbqGFhc5q4hw0rjX2ZxCTv?=
 =?us-ascii?Q?8g14D8hpq67zpkd63s7sxq27NCmLgmfPuFpeMN5RCkGQI/WrygQlXL4daKE7?=
 =?us-ascii?Q?+hPb8Fn/nptLvK8nguA42EHdmtMlBaVweMgWpoY7qyyjmgVc8wnvMp+eEGrw?=
 =?us-ascii?Q?HHCp6rjdlSMEr5xbxAT1+pgJzXyG/LVb9FJGSGPloG53S+Jc+hLaDfSUibTq?=
 =?us-ascii?Q?rvXf6h3UbcU6L/Uflz3tQi9CpoxsavKgZQ2V22TGBMunHjZy78vQ0dODu4i8?=
 =?us-ascii?Q?Y4kzCMwIgboQz2YoTMxVZ/E/TGYK0pET6tm56HCvJ/cohsdWP75del2o2W6Q?=
 =?us-ascii?Q?4Fsm8sIKVZjMzV4x9WSyfGp6e4GvypL2eEJHObqUIwA+eWCy/GnpJWzO5Kwi?=
 =?us-ascii?Q?4fepIrsEefcUlh3UVQ0hFEMCzzvvSjZTiPkB6EY1BCir0g0ve+CwF8N0hhs4?=
 =?us-ascii?Q?RWPHSC5H2mad0PFg8TBam0u1i6OIMtSIpcNIi3jX2Kw13m6sNu83UOy7eq6d?=
 =?us-ascii?Q?Y2Q0uRP9M/EI8rIThvE3BczHMFhp86rgb1AjpXn1NlC52Jt6C+Z5uG9xQmVd?=
 =?us-ascii?Q?w3Go4r7k29c7hh/GblM+itKhwvfOkkZgGEkFD13VBKEHmGRQd/7eQTEbYtqE?=
 =?us-ascii?Q?IqGS1Wbhr6ameHadlYye3YjX0kzA5Eks3Q83e2LWL8Z34UouY9da3ZGPH184?=
 =?us-ascii?Q?V5ueB7bLghVfQyNS7AW0HiVPsqahaLToaMGc+hd3PFvLRDT/u8B77ERXlxxU?=
 =?us-ascii?Q?mn2ARQO5aKdL3T78F8Cb6fKnrqTFiUUkO+n8Oajto9KdPufeIgtbnu2uYUgj?=
 =?us-ascii?Q?Q6FV1d3vVu3dbjanhUsU9Qdnk+o2PDxxFYOhIeoUkFroPdxaHXQhuK1uE+Tf?=
 =?us-ascii?Q?dKzOLGpyXoPaMURD2KMhmkpGjgG2Pswh7AWX/7FH7hpkKxPLsAm1dtrBEyvA?=
 =?us-ascii?Q?g/SeDUut2zJZpF/cepyFwagmHe5MrZn6ABNG0gmPgWb62j+q+J14yVnqwBQP?=
 =?us-ascii?Q?pisb7+oIOQXfT/8C8ltWeUf/0LH7qO1SHQ0PiIpDne/leBoWN3yEVOCIqbZm?=
 =?us-ascii?Q?epiQK/Pib49NLZuZ/kI6LHYOI83VKY+wR8s3xj+3BxeRNEMepjpmq/Vxnjh0?=
 =?us-ascii?Q?WjZkePkWkXKSsmG4oVmhTSF24Sz8S1y8QvS/svyeYvE/o67A2gab4kkR4366?=
 =?us-ascii?Q?IYFe3upGJEPas3Bft7URq7j2YvpQNwqRO88lYs/JUCUcvVgNa5XYoUrp3jOX?=
 =?us-ascii?Q?yggFphGe3HSoMBIFowjSlh+QswSaS3UEB1KqoN+fFNc0ZVAsrlFavuMj8ppI?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6307bcf5-b1fe-409b-4192-08ddaeeec3dc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:04:27.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOSsXQxbv4Kzp6/U7ADW1c/r5m/4vlAJqtLfcPOHYmRhNUpASvv+0tA0a1OU25umBBhhraOlmmWUFU2uCIo6qujLq8vmalxFZ5xh8QEykKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

Both detach_target() and cxld_unregister() want to tear down a cxl_region
when an endpoint decoder is either detached or destroyed.

When a region is to be destroyed cxl_decoder_detach() releases
cxl_region_rwsem unbinds the cxl_region driver and re-acquires the rwsem.

This "reverse" locking pattern is difficult to reason about, not amenable
to scope-based cleanup, and the minor differences in the calling convention
of cxl_decoder_detach() currently results in the cxl_decoder_kill_region()
wrapper.

Introduce CLASS(cxl_decoder_detach...) which creates an object that moves
the post-detach cleanup work to a destructor, and consolidates minor
preamble differences in the constructor.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h   | 43 ++++++++++++++++++-
 drivers/cxl/core/port.c   |  6 +--
 drivers/cxl/core/region.c | 88 ++++++++++++++++++---------------------
 3 files changed, 83 insertions(+), 54 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 29b61828a847..8a65777ef3d3 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -12,6 +12,11 @@ extern const struct device_type cxl_pmu_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
+enum cxl_detach_mode {
+	DETACH_ONLY,
+	DETACH_INVALIDATE,
+};
+
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
@@ -20,7 +25,11 @@ extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
 extern const struct device_type cxl_dax_region_type;
 extern const struct device_type cxl_region_type;
-void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
+
+struct cxl_region *cxl_decoder_detach(struct cxl_region *cxlr,
+				      struct cxl_endpoint_decoder *cxled,
+				      int pos, enum cxl_detach_mode mode);
+
 #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
 #define CXL_REGION_TYPE(x) (&cxl_region_type)
 #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
@@ -48,7 +57,9 @@ static inline int cxl_get_poison_by_endpoint(struct cxl_port *port)
 {
 	return 0;
 }
-static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
+static inline struct cxl_region *
+cxl_decoder_detach(struct cxl_region *cxlr, struct cxl_endpoint_decoder *cxled,
+		   int pos, enum cxl_detach_mode mode)
 {
 }
 static inline int cxl_region_init(void)
@@ -99,6 +110,34 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
 extern struct rw_semaphore cxl_dpa_rwsem;
 extern struct rw_semaphore cxl_region_rwsem;
 
+DEFINE_CLASS(
+	cxl_decoder_detach, struct cxl_region *,
+	if (!IS_ERR_OR_NULL(_T)) {
+		device_release_driver(&_T->dev);
+		put_device(&_T->dev);
+	},
+	({
+		int rc = 0;
+
+		/* when the decoder is being destroyed lock unconditionally */
+		if (mode == DETACH_INVALIDATE)
+			down_write(&cxl_region_rwsem);
+		else
+			rc = down_write_killable(&cxl_region_rwsem);
+
+		if (rc)
+			cxlr = ERR_PTR(rc);
+		else {
+			cxlr = cxl_decoder_detach(cxlr, cxled, pos, mode);
+			get_device(&cxlr->dev);
+		}
+		up_write(&cxl_region_rwsem);
+
+		cxlr;
+	}),
+	struct cxl_region *cxlr, struct cxl_endpoint_decoder *cxled, int pos,
+	enum cxl_detach_mode mode)
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index eb46c6764d20..0f1629856380 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2001,11 +2001,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, "CXL");
 
 static void cxld_unregister(void *dev)
 {
-	struct cxl_endpoint_decoder *cxled;
-
 	if (is_endpoint_decoder(dev)) {
-		cxled = to_cxl_endpoint_decoder(dev);
-		cxl_decoder_kill_region(cxled);
+		CLASS(cxl_decoder_detach, cxlr)
+		(NULL, to_cxl_endpoint_decoder(dev), -1, DETACH_INVALIDATE);
 	}
 
 	device_unregister(dev);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2a97fa9a394f..010964aa5489 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2135,27 +2135,52 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	return 0;
 }
 
-static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
+/*
+ * Cleanup a decoder's interest in a region. There are 2 cases to
+ * handle, removing an unknown @cxled from a known position in a region
+ * (detach_target()) or removing a known @cxled from an unknown @cxlr
+ * (cxld_unregister())
+ *
+ * When the detachment finds a region, the caller is responsible for
+ * releasing the region driver.
+ */
+struct cxl_region *cxl_decoder_detach(struct cxl_region *cxlr,
+				      struct cxl_endpoint_decoder *cxled,
+				      int pos, enum cxl_detach_mode mode)
 {
-	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
-	struct cxl_region *cxlr = cxled->cxld.region;
 	struct cxl_region_params *p;
-	int rc = 0;
 
 	lockdep_assert_held_write(&cxl_region_rwsem);
 
-	if (!cxlr)
-		return 0;
+	if (!cxled) {
+		p = &cxlr->params;
 
-	p = &cxlr->params;
-	get_device(&cxlr->dev);
+		if (pos >= p->interleave_ways) {
+			dev_dbg(&cxlr->dev, "position %d out of range %d\n",
+				pos, p->interleave_ways);
+			return ERR_PTR(-ENXIO);
+		}
+
+		if (!p->targets[pos])
+			return NULL;
+		cxled = p->targets[pos];
+	} else {
+		cxlr = cxled->cxld.region;
+		if (!cxlr)
+			return NULL;
+		p = &cxlr->params;
+	}
+
+
+	if (mode == DETACH_INVALIDATE)
+		cxled->part = -1;
 
 	if (p->state > CXL_CONFIG_ACTIVE) {
 		cxl_region_decode_reset(cxlr, p->interleave_ways);
 		p->state = CXL_CONFIG_ACTIVE;
 	}
 
-	for (iter = ep_port; !is_cxl_root(iter);
+	for (struct cxl_port *iter = cxled_to_port(cxled); !is_cxl_root(iter);
 	     iter = to_cxl_port(iter->dev.parent))
 		cxl_port_detach_region(iter, cxlr, cxled);
 
@@ -2166,7 +2191,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 		dev_WARN_ONCE(&cxlr->dev, 1, "expected %s:%s at position %d\n",
 			      dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			      cxled->pos);
-		goto out;
+		return NULL;
 	}
 
 	if (p->state == CXL_CONFIG_ACTIVE) {
@@ -2180,21 +2205,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 		.end = -1,
 	};
 
-	/* notify the region driver that one of its targets has departed */
-	up_write(&cxl_region_rwsem);
-	device_release_driver(&cxlr->dev);
-	down_write(&cxl_region_rwsem);
-out:
-	put_device(&cxlr->dev);
-	return rc;
-}
-
-void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
-{
-	down_write(&cxl_region_rwsem);
-	cxled->part = -1;
-	cxl_region_detach(cxled);
-	up_write(&cxl_region_rwsem);
+	return cxlr;
 }
 
 static int attach_target(struct cxl_region *cxlr,
@@ -2225,29 +2236,10 @@ static int attach_target(struct cxl_region *cxlr,
 
 static int detach_target(struct cxl_region *cxlr, int pos)
 {
-	struct cxl_region_params *p = &cxlr->params;
-	int rc;
-
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-
-	if (pos >= p->interleave_ways) {
-		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
-			p->interleave_ways);
-		rc = -ENXIO;
-		goto out;
-	}
-
-	if (!p->targets[pos]) {
-		rc = 0;
-		goto out;
-	}
-
-	rc = cxl_region_detach(p->targets[pos]);
-out:
-	up_write(&cxl_region_rwsem);
-	return rc;
+	CLASS(cxl_decoder_detach, ret)(cxlr, NULL, pos, DETACH_ONLY);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+	return 0;
 }
 
 static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
-- 
2.49.0

