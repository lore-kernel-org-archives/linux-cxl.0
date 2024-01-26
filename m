Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169751EB56
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706251074; cv=fail; b=Z0+ijY8Y9pGYnwHAP/6VMSZk/k299AWoPP5y61ndSDrZzmjM/dy/VTJZDzs7vYQ02e1bvwX63BP+8IlaRq7prb2GdTHokIvQA8tYZYnHFNwIehgIxtqZTg61r4n6D9bimybMRRQF6nMP5fxmmFc8mS5iSA2njlnEQM5fcjJvYrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706251074; c=relaxed/simple;
	bh=HkU7YpOMF3ujEf6k+1X656+p/g4YeXE9ZfrKnAklipw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tb8Motj9K5FVS4uEg56a4FWgbvD8tSS9bw1jDqvZDSIam6ey7SvAnPHoHAnzdl+TFReqAoE6QsuLjWWfHVQu5RwQ/Efm28OpBGy5amX6EmF9UBbivLCEXon2w0JNgmL0artx0MWn8xUxrJSoSjlGVMPNBueCpzMp53aDKodMcR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qu0lDO9h; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qu0lDO9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706251073; x=1737787073;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HkU7YpOMF3ujEf6k+1X656+p/g4YeXE9ZfrKnAklipw=;
  b=Qu0lDO9hi+dbJ4O4dGjtQFBgDgAxisJGUrj/IWGQRadKIBlnUzfkVstC
   g9FGqnY8fW/gSuIcUkRF6FVs0z6nmb5k9XlQKQYCjY/o2C+EGYsnSez0M
   PORgOT4L2gGPKuKuFIAM4RXmxsBDFikZcO7O80t05meomu1aXWdbu10jW
   X5SXuB0xizy/IR1TDnBxk+m0QF4mwJip7lpvHspru/4yikK6XHWwbLqBj
   u7FVsf1Xk6mcrLPJF5sawZIsvoIMaCRCwvQgCM2n1PuWPEHDtjziRt45B
   2eDm8uBfVcgL86Oibb9cLslfUxNZGcWpveBKP79dy5pvKmK7I2cszfcG+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9784841"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9784841"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 22:37:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2671568"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 22:37:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 22:37:51 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 22:37:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 22:37:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 22:37:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4j4XofzZknmnitAMJ3lM1FHQxz0a1jKq/WImcV7lmoBzEWGUGwmU6tDAUIGBuhA3AHCEkITe5QvE3X4Mx4pstKfoArjMsXK8RRdIYo/FWtgITNGrWDnDKvJuOnNH8qVs9LTmt0UFvVgtjBkFLq5LOmjjp6oR36nXOLZDML+NWe9uSm+fVITa1Lf0hW8XJ3fRYEMPCKijRVPXahixu/5n6Qj6laQOLYafyHaEDeukFtRjtpCKQ+ukeyYbLR6z8USL5x1xmc52LJ1mZakFkJ8EeKHbJn6PT+pkwIsW5VtdU7hRj0mFCGDt7he/j1LkbfDM1Y8jijDktLspMwRVfYn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XKMfMLH3RVkrg+eq2f/x+5skpEhOQpUi7Ia6cgVh2A=;
 b=VnTiJ+glanlANqRzsVvmMK3NixY/yYrgOrRgpw1tfrGaCvqb954erKwxp9Ev4WiWEau3b27qmny1eLiqd7RO72TNATEjNe8ENEWdNP1rY6R3Y5/IZcPyBxMvIRoaDAqWwhEGFtCZsalUeUEML5dAI78K5Op0NhnVFTs1OrWBmKGabGrg47fkeZilIVL6lx6gEoE4VkGkKLzIW/2jMr6jQoYeRdAkzaiw3IKgjD7484GfEgdK+mGHW2vdxLr0FYxniPlPM5eC7QbgSSplz4g0Aj9O8bvQKnknAJ4r74cSNWarsUhtd4ru96GCGDchzgb3H02YZkpvdAq7ndQ/KB1Z0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7401.namprd11.prod.outlook.com (2603:10b6:208:433::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 06:37:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.035; Fri, 26 Jan 2024
 06:37:46 +0000
Date: Thu, 25 Jan 2024 22:37:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Li Ming <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <terry.bowman@amd.com>, <rrichter@amd.com>,
	<Jonathan.Cameron@huawei.com>, <dave.jiang@intel.com>, Li Ming
	<ming4.li@intel.com>
Subject: Re: [PATCH 1/1] cxl/pci: Skip to handle RAS errors if CXL.mem device
 is detached
Message-ID: <65b3533821510_293042944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240125081414.2189572-1-ming4.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240125081414.2189572-1-ming4.li@intel.com>
X-ClientProxiedBy: MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ddd483-5a66-4286-0171-08dc1e394ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAGse03Zfe04G/nZ9AL3tvetl1A4OieoxpXGi70Z5qg/65ZNL5575o1hGgU7TWFeSQv1fef+i2DI+GEZojSqyPKDwgMEh9tmUuOyvkryuDVJEfuLjJc4W/s3Ms0BGPn9YXVI1QRr7PvObC9ZF53tof+I8BnoOGfOnBPsfOEtDTSef8HcsuEjHGYTNHij7oZLPx+z8CHAR67poQ49O9CGJ0y7t+BosWhcDsBGy/Co8vgp1k/b6NG7IKAvsX73WhFxk0f2QbBXsaT2NHog300mMFLZ4izLoryXVB4RIXYVxdCrajatTCx85G8KlSFS0YmcafFDGOM4qIRf3giTwMI4XbevuwJqJaDcfW8o4dDuJg8lCxFv8Iz1ZATNtah6TKiiWmljZzxTmbdDITQUnzGMHut6T+Dgu9jPE66HTcTiYB7Lzx9f+g/Mjp2SoPLWACLC42CTRKNDDLuE6qR5HciqbHVLFJexxDSeOWdAMP1MovCHhlr6OZ/IxPKsVLm0a3MOkq2UajR5QtIcwT19EBTnYzT6EFYHrTEWypHEzQuOrE3Y3NLYiqN9Z3TCb9h1KWDX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(82960400001)(41300700001)(66556008)(66946007)(66476007)(316002)(6506007)(4326008)(8676002)(8936002)(478600001)(26005)(83380400001)(6486002)(107886003)(5660300002)(38100700002)(6512007)(9686003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZrrXoj094PLFFkoUaLH1vPsc3TdaPEOmmWm0MplCmEDyhLb8wf689R6tzTGJ?=
 =?us-ascii?Q?+7ezP1AxB0ccLMXNP/y5t/8UKy54949tvJl+votJkhFxLenueuHcUhr4IZ5d?=
 =?us-ascii?Q?fAXpZikOwn172Xv4+vFXPZmhRw4r4BomFxy1ZBJjr0RUxsi03JNgTPT58mL4?=
 =?us-ascii?Q?IdN0E4m3BSJbvTEyy4dnHCOBqaOCR5PC4yUEkCNMY+b3mh+OgkRuWlKWmM6H?=
 =?us-ascii?Q?BClNZL6eWRpRnywbMCLQGj/0IvOsNnOrOP0b71lD8GEB3LOaJWStjfLsdAXB?=
 =?us-ascii?Q?NZWx5Og/K0cBBZWK6I02ZxE1/op6huZsokwCSlCyQIqbaxlpXzZ+SyE/QoFq?=
 =?us-ascii?Q?KDpYppZ0hU2iJI1XTzIv9nIHll8Pa0Fdi24NausAX5LcZL3PBmB3dHKjjtiU?=
 =?us-ascii?Q?t6uhziRNUEYUdJ/EtVvFE5TcG8x90RXgPRu5XypKRNX/pRU2pBaA8pU7odsQ?=
 =?us-ascii?Q?bXUGX1XEXqX0AqfQiDhOEYPzZEan0cb/YlPPVSdOmucbxSt3K3+vt8jbfmYa?=
 =?us-ascii?Q?4SUv3SJnX8ejOQo5SeK/EFawtkZSAnj7Mf0/AjzknLaF721UXurKvL56UkCQ?=
 =?us-ascii?Q?9Y+EYTuUcRqKXjkQRzSuQggIZ7JiimERa2t1OBlFy8vBpvXlXNwiOOmQ05Xf?=
 =?us-ascii?Q?MSsFTEu8Udcz+k84/ooZBaqKKc65ahIpoW2gh1rI6BnAiRJQ7RbNErZ4e3Fv?=
 =?us-ascii?Q?phKetCJa16rZWlc21cwUI8tDPDiPZul2swLWEWHKaRH38ef1V9KVxYXYkw8Y?=
 =?us-ascii?Q?+bXVqQoRS7DyzmUmcqff8BVmwGF+JyF9CciR9q/9tRt7QI8i5h7Oz7hvbcfH?=
 =?us-ascii?Q?QEOm2aG6JlwTMunWGtQN5d6aQTWi3RdZMMrVCe6kN+U+NhPpwxrDhHeBVa0q?=
 =?us-ascii?Q?TYnpgRqUQtQskUBqlGE1GH6aJbyH1fOiLKOkvHViKW+8Syn6Qhzsy2Mt7Dw0?=
 =?us-ascii?Q?K/wcPoFql9m28WJ/ZAM+4N8H809nQtVsJX2e+1jY3oi/Qb+LgAX2DLD4VlVa?=
 =?us-ascii?Q?Jq6Tq4zILUpYq2vra/nKc051oIWxadsyLeotV70JwBTr1P1HO8U246nrqdBJ?=
 =?us-ascii?Q?aArThGoxKZVQ6X0Y5vYMvjcZqSKJBeWLx5emR2L/WIlDQUKeMS9Siq6q21uh?=
 =?us-ascii?Q?JeuI/HJByvCQ29/+V219W9ZoFEO4JsNMnqElZHwPm5nVMl8A1ejTxKVuWuEK?=
 =?us-ascii?Q?TiRMmEW5GGjdVsXcg+2T2aZCGK6DGuTj/bJALyIL06tKzPYAXiPAaqKW1hIY?=
 =?us-ascii?Q?zCxh8zBbP7UCZBfv2ZehideMPQJyrdkeytCXVuP4fPAEL1eQYh3Dz2bIOg2R?=
 =?us-ascii?Q?3aAAXuIM0nPjquWBMNtC1MZOyfmLB/slzTxF3x1zCKaE/PDOl68l9EZfE12M?=
 =?us-ascii?Q?CeKmG7EF5/zqo36e+88XbCTiYPmL1U1Pvar8Bkd8eDtowqY36SkpNAePxYL9?=
 =?us-ascii?Q?YJ3kWUHsT8IbwWH2M3RqWxmCeM5vCfZLL30KVgrhRxcmxH6oKumHVnMYUH7D?=
 =?us-ascii?Q?XSus9d5hggIShPnngMzuAxBKELG+nuoE3JVAUxqLRSAKv7pb51DfiGNEubxB?=
 =?us-ascii?Q?PF2YkFXskYBye/bvLfSkSJ4jjVbonaCX0H92UpNjCxmSxBwvXZ6Z+Lrq2jUx?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ddd483-5a66-4286-0171-08dc1e394ee7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 06:37:46.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwOeAwXDMajB2fpxVq34U0PUotkFtP3qtxNcarwcB6dmadNkR5CGxzaKpVeT2WVJK17OeGI2+Pfw5lEcc391UDogidG2GOsJ+yUO0sg7Tps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7401
X-OriginatorOrg: intel.com

Li Ming wrote:
> CXL.mem protocol errors are logged in CXL RAS capability, if CXL.mem
> device is unbound from CXL.mem driver, will not expect any CXL.mem
> protocol errors happen on the endpoint or the dport connected to the
> endpoint. Giving up these unexpected errors to avoid error handler to
> access unmapped RCH dport's RAS capability. The error handler of CXL PCI
> device helps to handle RAS errors happened on RCH dport. The host of the
> RCH dport's RAS capability mapping is CXL.mem device, so the error
> handler will access unmapped RCH dport's RAS capability after CXL.mem
> device is unbound from the CXL.mem driver.

Thanks for this Li Ming!

I am going to reword this to add more context:

---
The PCI AER model is an awkward fit for CXL error handling. While the
expectation is that a PCI device can escalate to link reset to recover
from an AER event, the same reset on CXL amounts to a suprise memory
hotplug of massive amounts of memory.

At present, the CXL error handler attempts some optimisitic error
handling to unbind the device from the cxl_mem driver after reaping some
RAS register values. This results in a "hopeful" attempt to unplug the
memory, but there is no guarantee that will succeed.

A subsequent AER notification after the memdev unbind event can no
longer assume the registers are mapped. Check for memdev bind before
reaping status register values to avoid crashes of the form:

 RIP: 0010:__cxl_handle_ras+0x30/0x110 [cxl_core]
 Call Trace:
  <TASK>
  cxl_handle_rp_ras+0xbc/0xd0 [cxl_core]
  cxl_error_detected+0x6c/0xf0 [cxl_core]
  report_error_detected+0xc7/0x1c0
  ? __pfx_report_frozen_detected+0x10/0x10
  pci_walk_bus+0x73/0x90
  pcie_do_recovery+0x23f/0x330

Longer term, the unbind and PCI_ERS_RESULT_DISCONNECT behavior might
need to be replaced with a new PCI_ERS_RESULT_PANIC.
---

> Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>
