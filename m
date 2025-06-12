Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D55298CD2
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749756053; cv=fail; b=KEppoZ1m9HhpjLjjl5Mz29sYREsyOXkLCj3rQIByvxm+V1/5IW3oikzioe+srRHOk+PHdNMdZhixLZK1z7c7ZElwRVp4RdivfVpkBsmVtqp8yJgRIWImyJ7DR8nafVZ3iBJYYVl6pi9+DEgPhPEnLGXDxTgCKy4UfBDrAMyST2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749756053; c=relaxed/simple;
	bh=uxttTOuHZBOHYb4R9OLALYulOGyk9hGSjLykWH/ZjKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2q5sHfPL+ZeDmWHUsR8VceqPqfJG8YOo3Fv9X0nkFH4I6FRBVUdFpfpNPEPaXJQOvn1TFlqJFSnZzlHHtCCjFq3phhqpJ1sja0gpE59ZxceUyikpnFRK53TmiH1bgdnOmLcTDXi0V/MU8kVXrhJ/o6PL5cFuvyV+E8FldgrFFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lERRMp6c; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lERRMp6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749756052; x=1781292052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=uxttTOuHZBOHYb4R9OLALYulOGyk9hGSjLykWH/ZjKE=;
  b=lERRMp6caCRZmAFCQZHsBQ01V8TkxU75MZx0Hh9kgt1J5C5xNY80hYb1
   1wjIvimA03egkSrLEbhemydN0AP8fsVUborK4M4lXWHhy2ptGgUR+ukhu
   dppYRvLAjN/SKMZjK+tKrQvxXN6YWGmwlhJgbiod64dfs0v2IGsCpyopX
   ev5Jb5cerVT8jUJKBA2zSb8GaTnJj5oMFgoEtaQL3n84VBUjRFZQ/427L
   Cv/pYX4Cy0IVOGNUvSXSrnMhPgX0nRUaH5GdOBR4sTj6tdDyWPqrt8Hzk
   Wi1srI+pAXX+JwHj1lhSGjg989+81xuvOjpxmXnmBoJt1lZdc2Al62xwS
   A==;
X-CSE-ConnectionGUID: Fv5a9r+iQtqGKZD3iEhYHQ==
X-CSE-MsgGUID: ly8fo4SASF+qNzAK/swIAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51825183"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="51825183"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 12:20:51 -0700
X-CSE-ConnectionGUID: 1osNzoG6TFKO/5IzAtPUFA==
X-CSE-MsgGUID: RV/LqW1mT4mFUa08JJdEsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="151433279"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 12:20:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 12:20:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 12:20:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 12:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GG8A0cMJ55xuLDxdr7aulkP8S4euJa/bD6wonECY6TBqhrNJwunEcCDijh49dPO5dUuKKJ0UGOUfxqAjE6Hbz9+1Bg/T1x34jcT9V+a2K8bIUrMU4Gc2vHf2aPtKjY/U0CkHXs128pAuQyx1dNHN9GKZT8zE9ew4YRLutqdbcLija5Bk8C9QLbQ+ZSjO8jstLwBhA/OFFnRuFhcyRv3UF0T4eBN2e1eHaI6SpwET+396WCuanSBG6SmJQLCxJ1UtfxehdB3t5vDTrj5VJJ4f8kXOkXMsQ48dHElx4B4HTSsIY2r4sw2HaE7oOSTZy9luhy6RRHjRcP1rgzmNNc3x4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdAlzLXcjMmoOFbbB+i960/wTu9P1/TQxDXIq6t7b2c=;
 b=RiI5XEWhiBO7kXsYpleAIuoQZ6v0nQlqUnPzOadiwVQOzgbNyvkgzhbclDS/s4gHi7H4dKZHeIC1Ev/sZKDMzCZHnSrngiOWGusOs2aeQoq435BBMrP/mVOnU0T3eZNHXtqaj0UeyRaJ45ohOPEiyw0O6TCFXJp3vtxtQ0gz1DKtDfhNC2RHwbdQ38IsoqmQEqCrqndDGHQbDh+KBW5JJWjo3Wjc69I8bZY/pQwUUjqSYBD+HNHIPAlXVTA2u34W90vkUUx74qIPGea4Yz+kmb512/M+xsmuZbx86TtJCJEKz4gw1Gc8E4tk1xOPBhKSjinDff+tDCmt0NY3H7P2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6710.namprd11.prod.outlook.com (2603:10b6:806:25a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 19:20:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 19:20:46 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Terry Bowman <terry.bowman@amd.com>, Li Ming
	<ming.li@zohomail.com>, Alison Schofield <alison.schofield@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Tony Luck <tony.luck@intel.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2] cxl/ras: Fix CPER handler device confusion
Date: Thu, 12 Jun 2025 12:20:43 -0700
Message-ID: <20250612192043.2254617-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611171721.2048408-1-dan.j.williams@intel.com>
References: <20250611171721.2048408-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:a03:80::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d0f809-0c99-424f-a382-08dda9e63b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6vg8qudKewAN5hyFFLSnqEkHKrR6xNXYwbFD5gG2QM5nAv8dcQpPK3bhMq6B?=
 =?us-ascii?Q?Ib3SB+U+kcD4vJRD1FDSGoQt3QKOv9QVKxWoVYwonP/hHXXGKlBecic2JZUL?=
 =?us-ascii?Q?Es6gMaddJqql305yjMN+P/16ee2kASwpPouUM1rY9J1bqtuRu0J+pcNRY1qm?=
 =?us-ascii?Q?tayAWA8g82vO+vmZMyxYpZASEUSnYgWNsK1s41UTdyJlINuAdEUQuWj8cmIK?=
 =?us-ascii?Q?BMusEtPiry96ygoggp3ticZGkes4sBa5xebjg7bNA/qH6uAF9N9N4DFzTYkR?=
 =?us-ascii?Q?M7hASFYqtOQFrzLMmn4mkrcz3AJKM6TImX1sj3UWDCh7t7Adn9HmfuJ3XIFo?=
 =?us-ascii?Q?P8+PYq0ZUaJo+RU4hE0UMMrnFSJVlJdbrwTInCIzph0AhpH4Llb/hQC6TbYG?=
 =?us-ascii?Q?+xAS449rMP20CQbpQo4rYwkpf8JibQXsAIehLyDc/G1nJnddioPbbRerop05?=
 =?us-ascii?Q?S6cWWQgJSnCL9mRZZ7cspabNhvFPdNZF8R0QEndP85CUmuA34f6vdNKTRlRV?=
 =?us-ascii?Q?+X/NGUgplc5BCKP0KmLeTSTMGbIqlwGDcrsML2unDxlm5Mxaut6rlBQovlZZ?=
 =?us-ascii?Q?Ju0BFFuI8/a8LL0E2ULfG+XQJvri3++I7bsbgk6u4Ni5uGIpxcqlYJmG19Y1?=
 =?us-ascii?Q?738Xly2Cjdr7QDTFYSGea3UGq/adW483y4VGq4HnxsWo0eLI/viX6EaOGiEM?=
 =?us-ascii?Q?PbNxxims69/YxfiV5txJVNwrFsiQGhU9CN5VoZvWWV83chGxHvdummG83Lqx?=
 =?us-ascii?Q?QNfSTIWU/NVAA464Ah6/nTylWlBz3gdFWvXYg5H2TMkFQKOX0mtDxEUls7wV?=
 =?us-ascii?Q?Updr1gw8TFxzqQzGFTdt0SPQ3/25cwz65dpkfeiKKnU2iGO98x1Rv3eYjfYA?=
 =?us-ascii?Q?FgYWqMA2AmONNPUIdotylxY5aRO6VkZVScE/oV2aUo8I4ft3AbdO+uAMWJPA?=
 =?us-ascii?Q?ZFI8TP2K7PnZmMxxXen6qxBD2mJ4rgboOzwJEKhhI9gtRW+Y/xH9/HnNjtra?=
 =?us-ascii?Q?bSf+ED0Zgx95llMFVZqeMFkgS2IR/HKrLiy8ehwUORnEp5Px0U6s23JeJgzp?=
 =?us-ascii?Q?e4IwKQlhT4n+c33tEpe0jy0ubg9umlISRLOOVsU+m2kppdzvVVW/QIdiKXwS?=
 =?us-ascii?Q?qT9OUfWDwoacVOfJjKeMK/Tbnpd1WZK5FjbKfyB9CasfBafM9LFpDmVR4kFZ?=
 =?us-ascii?Q?+rypqBLE95H77nGPMq4mAp+PX5BZhz2PueATSH5RjRJ5Nq4gyk+OfEzx3gz3?=
 =?us-ascii?Q?UWkc9GUz3rruGfk5Bp+9TaMEIHCgrRAVop7HwAnLqIKGmPy19LRmF8SlgkVr?=
 =?us-ascii?Q?wA+UhG5nbjwCQljIsHE4AMZplat2190t1dDs+WvvmW34Sphtyx4n3t/5nh6G?=
 =?us-ascii?Q?QCmOqAR4E+UPyp9G7RdtOL9b2VieCTzT1T9reV3apBVbvIqgoWCaJ99Rwkyw?=
 =?us-ascii?Q?VLOxO6mC6xI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lephKLvkjwL6KN5oZcXuWlwnw8sgVqdBI8efIHFnUusM1XGh0vyMw00DzFM+?=
 =?us-ascii?Q?HJUByOsvr4keW0hSynuRmIL1k7M8DKJrDQWBxaGKNUyTVqYCujfzoS61zF3b?=
 =?us-ascii?Q?oKihL0TygPV3mkBOheOPRViNS0Dt5RaiemJ7Me/Sii6bdTOxR+a7SuKIyqTy?=
 =?us-ascii?Q?NAvLRFyvlDnmih2h459ch90/LiFaqS+RO/ZAbdlQKDlBx/Mr2QEgZEnw6aDC?=
 =?us-ascii?Q?VOdzhmbFqaocp88qCxuuD2U5NerGlCHlRA17yY8P+9LQ8kVo4Xz+D+6axpWO?=
 =?us-ascii?Q?AZnOJt2eWZqxiaGrzII/LmMpbkBBN7kH5PJ9BxOeosJMTgOrNbKsgc5PYMd5?=
 =?us-ascii?Q?xkp7lHO5YKqjwC9wA8zoFJ8QbO4JtGGHDLiQwXGl0UN8c2gfUpVANMq9sIL0?=
 =?us-ascii?Q?LuxuY0WQDx0Mys8xYZCgeIMlCPZAHtVafZbQ+15qw+3HltEikkztTlpEbELq?=
 =?us-ascii?Q?EhLY3ard6kNoYGlxoHssoMQZ01m2sd7qibIGaSmpmmiWKPj82wIwIqf14ujv?=
 =?us-ascii?Q?69n7dp7+5Zgb+pNRcioXMd8yQ8Vwim7Ts4uVmHzSotzLTTZ0WWHLx6GFcIDW?=
 =?us-ascii?Q?PLSo6LHfvaw4OX5jqM8UAgJH8n/0DRy3jdmBNylxBv/okgb1pGndcazgS2kS?=
 =?us-ascii?Q?9rvKY9AeniZWu4GHzCvU2UjKARKZwdbFIBCcKTNYAYPPEibGM1SPD+EBwFuJ?=
 =?us-ascii?Q?HEHUP262mEA0bPHXFROzbsvWBI4h3oz9QtDZbZGCSs3/s3C9KFLuJcph7Nbp?=
 =?us-ascii?Q?VysYUUaCixtBIlNi2jGNiAhK7W5j6rzEynHem2u62dNwKzErSV7DV/J8CSCQ?=
 =?us-ascii?Q?IWsFZyz9HrXP0kAm6XctParlsBkW34nQtoj5fr2j0qBYiNcALu7SN1JRcbi7?=
 =?us-ascii?Q?ho3mPhEQMXNehJRau5az849OcJO7fTv9Yh8LrriiX4vGjtlucLp59v2dUYyq?=
 =?us-ascii?Q?rL7JJOnJ4n+teaedqvn4WUbUNlaAiJI3rMVgMer++/clbfRg2f2y15M9PR7C?=
 =?us-ascii?Q?jNCOQDHdn9A7z4/qKsmIlNcHCioFKxlF2uB/00fyHGir1Y+ys5SxtpTkDI69?=
 =?us-ascii?Q?fZkt0JpKNHJNI2tAcoxqHBJa4un2rPkbrp+dwxC/AfUgaFSWezdGyMfNDnmz?=
 =?us-ascii?Q?w1jLFx/n6uIqF2WbKyJcCNaQw/1P4BgeBh+czV2PZAfi67hnNRxadY98J7zy?=
 =?us-ascii?Q?Qt5GMT99lEWeBCs5N11Ly+H0v12yOuUOdJWERStfhPHxM4aRqKdFGdNtTxfR?=
 =?us-ascii?Q?pGv5NVFU+f3ZHjkhX/HE3UuKWcJMEt2/4+KcLnTCCymHyhDRqn4wcm4EQYxn?=
 =?us-ascii?Q?uHkHKD5l534YAz6Y5zA3R/pPoZaw28aw7XSwvE79tv1xIrCEDlsGmOl3AyAQ?=
 =?us-ascii?Q?Pa8R0mLnA3CXlWuMclCW0vK1xubuAhU3RJDhy8UwHkVP+i76M8sTPJFDexgM?=
 =?us-ascii?Q?SInJdLdsJvBHuqBUog4oOge/fwy0Ve4vIAzOOskeqz5Dm/OJPqtFiEdT1c8B?=
 =?us-ascii?Q?5yMLAmNCpaWuPZfCOGXWue80BBh92PbhXTLGeXbnqtEo/MKbzhHQKIi8IX9f?=
 =?us-ascii?Q?RHmryJ1lBCr5oKj9+RIVZBPtpkjcpAXVe/PMYzQjwNv8SvUwbK5rEHn0yaTk?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d0f809-0c99-424f-a382-08dda9e63b81
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 19:20:46.5298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wolbDlfogNyJgfyLxPdI6TrCYbBjfYCj66/TimmF/rquhoEqPTgHXoMADLp7bxISHD+i0O0SkBFPEV5XZCOfD6TWpV5paslZMYvFXAAwV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6710
X-OriginatorOrg: intel.com

By inspection, cxl_cper_handle_prot_err() is making a series of fragile
assumptions that can lead to crashes:

1/ It assumes that endpoints identified in the record are a CXL-type-3
   device, nothing guarantees that.

2/ It assumes that the device is bound to the cxl_pci driver, nothing
   guarantees that.

3/ Minor, it holds the device lock over the switch-port tracing for no
   reason as the trace is 100% generated from data in the record.

Correct those by checking that the PCIe endpoint parents a cxl_memdev
before assuming the format of the driver data, and move the lock to where
it is required. Consequently this also makes the implementation ready for
CXL accelerators that are not bound to cxl_pci.

Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
Cc: Terry Bowman <terry.bowman@amd.com>
Cc: Li Ming <ming.li@zohomail.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Reviewed-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes in v2:
* drop the reference from the result of bus_find_device() (Li Ming)

 drivers/cxl/core/ras.c | 47 ++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 485a831695c7..2731ba3a0799 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -31,40 +31,38 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
 					       ras_cap.header_log);
 }
 
-static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
-				  struct cxl_ras_capability_regs ras_cap)
+static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
+					 struct cxl_ras_capability_regs ras_cap)
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
-	struct cxl_dev_state *cxlds;
 
-	cxlds = pci_get_drvdata(pdev);
-	if (!cxlds)
-		return;
-
-	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+	trace_cxl_aer_correctable_error(cxlmd, status);
 }
 
-static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
-				    struct cxl_ras_capability_regs ras_cap)
+static void
+cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
+			       struct cxl_ras_capability_regs ras_cap)
 {
 	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
-	struct cxl_dev_state *cxlds;
 	u32 fe;
 
-	cxlds = pci_get_drvdata(pdev);
-	if (!cxlds)
-		return;
-
 	if (hweight32(status) > 1)
 		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
 				   ras_cap.cap_control));
 	else
 		fe = status;
 
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
+	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
 					  ras_cap.header_log);
 }
 
+static int match_memdev_by_parent(struct device *dev, const void *uport)
+{
+	if (is_cxl_memdev(dev) && dev->parent == uport)
+		return 1;
+	return 0;
+}
+
 static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 {
 	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
@@ -73,13 +71,12 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
 					    data->prot_err.agent_addr.bus,
 					    devfn);
+	struct cxl_memdev *cxlmd;
 	int port_type;
 
 	if (!pdev)
 		return;
 
-	guard(device)(&pdev->dev);
-
 	port_type = pci_pcie_type(pdev);
 	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
 	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
@@ -92,10 +89,20 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 		return;
 	}
 
+	guard(device)(&pdev->dev);
+	if (!pdev->dev.driver)
+		return;
+
+	struct device *mem_dev __free(put_device) = bus_find_device(
+		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
+	if (!mem_dev)
+		return;
+
+	cxlmd = to_cxl_memdev(mem_dev);
 	if (data->severity == AER_CORRECTABLE)
-		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
+		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
 	else
-		cxl_cper_trace_uncorr_prot_err(pdev, data->ras_cap);
+		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
 }
 
 static void cxl_cper_prot_err_work_fn(struct work_struct *work)

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.49.0

