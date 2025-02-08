Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08710F4
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978472; cv=fail; b=VwjXQnXOlAgrDwNNCC/gsVRnqJvcu2y9f7/bfMCH3Whj2OkU79YXYqVEzLGCucwFXDqCInloQuQ61V2uJMrtnzGAludNpYxp8Jzn6O3NjSo3n783RXIplDRXcJsVWtriOdXmxk2C4edzc/ec8ofVHqBtZR51VKSpN6Awu21w8kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978472; c=relaxed/simple;
	bh=+IzGFIr01xwdjuRzaIJmCbCc0WEVaTeW2+aE7VMPMtc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AEpch3wKqmhZ6VeMCfY2C1NyEsKfs4n0v4KftjnStrHlokiPOFnp4nJi9Oukh53BCsUntqX8uaQO3ZQTPc5VFelg6QHy7bZYHgUekkGnurSHu97Odxljr2edc6oqVMRO8HD+3fgoXrvLv03g6GSntS9Od/rWoD/uVizey+eST9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUi5HkKK; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUi5HkKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738978470; x=1770514470;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+IzGFIr01xwdjuRzaIJmCbCc0WEVaTeW2+aE7VMPMtc=;
  b=nUi5HkKKHLTnMHUu9EvxFfxtf1nd65HJ8+1ilGH2+HWe2Ew86teoTa1n
   9Tt7y7Br+/5DwIZyoQgMNHB1eFYHd8L6jUAywUYBZzqpTG6oKqZu7L0NP
   nsC6J8g+hsLUcpn7ZOEuPNEX4wya8L7nMTB2k5bAr3xA3tTqAROwxz6XA
   xBj+1cNWmVHTVWZ1fKA7bsgdX028QOfDU3+5sVf1QDhplcLfAkuLbx0BA
   FFgEjPBXNSGUPmSSijUpEsTpylWr7b/30qYGuAJFMlMTgZdtnVTxg+htx
   K9pvPuJXNeVgcBaYJsLY/I0StKjpdw41vKAQUrhADTBVgrPj5KXKlTR6F
   A==;
X-CSE-ConnectionGUID: GAm24x0/RHGnZcPxyTp/0w==
X-CSE-MsgGUID: ZGeW1XvERCmD8BsIF1OEaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50256789"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="50256789"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 17:34:30 -0800
X-CSE-ConnectionGUID: 3dZkDFyXQ3uyHroiMjqa1Q==
X-CSE-MsgGUID: ka4IfO+zTaiR1SYCy/KFdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112190670"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 17:34:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 17:34:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 17:34:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 17:34:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3R3ZsT+kOesjZeKBh9HrpCBql2uX9f+pK5sUloUgHV/+oTlIlBZDM+C0bqOh5DC2KxFyLfh+qyYVAmZUgoiNdBWM+NBZrc2Rjy1/uE+lB0GSbhyfogRjh2BTsCteH94x7z0t579F0WWXld1vVdN+TekZbDwHgv8YQW5bYRh29Ya1eDyv5OEjrz1XQ01OynMT0vuU9y9WmChHjpuCYTPJ6SAqdJGZcEDje7/Hm9l1SXJVliKjLpPcbcX9Ly3og49EPXHm9aRYj7XTeYbAwzFGdop1W+Q5UXh+tjgiaTwdVzJTdi9JKkCcATc9LGtD9XID03EvJlXM4ZQCcyfnDo3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH3wPTLGZNMAHq06sV68JsJS+LhSXd+qP5+KgweQ3/I=;
 b=d0xhQ8BPvmv0ePrwfPp1MmSeY6Ed+TontBn3PslS2+6YTW+dkSFG6nRLqchlvX2Nk8bh8AE8+YvNm7aHrYkmSghUDbgslsYbuRGzVnSFwk5DIlqy237UQcGq20fmrintBqgRnQhz3ci8u/FOJw3MRj4cHj3nKSG+pxRP5poulfNMl77yQ2jM3+zJgUTdb0O9JmzKPjb46r3nxJCfiVXMeUfN8FLC1Jw/i6TQ2Vy6J3GlHE2NR1mVtHRlEzAW51x7HRw9MWsdsWw9ic7qPCwaCVN3tL7+GWKJ4NXZwgzFJHJaoq9qx25xxJ0BDvYVqCQrHLBPbGiYChudcflPSl+XoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5308.namprd11.prod.outlook.com (2603:10b6:408:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Sat, 8 Feb
 2025 01:34:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Sat, 8 Feb 2025
 01:34:26 +0000
Date: Fri, 7 Feb 2025 17:34:23 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 10/15] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <67a6b49fd5d33_2d1e29420@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-11-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207233914.2375110-11-dave.jiang@intel.com>
X-ClientProxiedBy: MW2PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:302:1::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: bf60c823-7d87-401d-2520-08dd47e0b92c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qG8AsMCnBM3nglVOHZecfmS1fdAysZbxgTrou4aXJJukbkf49nQaJ4KRP2JO?=
 =?us-ascii?Q?LHdHaCQ+Ky7YKK/EKt+iXEy4ecR9YVR0Xj8gxOQ7aiocy9NPjDu+cCZopXDA?=
 =?us-ascii?Q?sD+1fccgW1KNZt2CmlCN894Ishx5/TRIVTLjWXYY4FNkC736jvn2vr86Ya1S?=
 =?us-ascii?Q?wHgpTQvhvnfgdwgpnDcvb3EAfUHVw8g3wlCT16aZlOn50y46LTv2BJzQlXE5?=
 =?us-ascii?Q?A+2CxM8fbGuEzl7i+UN/OWzm/RktxYrZ2bioweSivwMeSl0wldWw3dScxLwY?=
 =?us-ascii?Q?jCaUqyP9psJhklu07pwgQGPnnMulPgJjkRn08Qb4+hznxyss4m6Y6UtOKt5N?=
 =?us-ascii?Q?93iAvUUiXaD2cTADFXE9mztoCWJcByAVZxEmXbR2P6WXI3ojiF6lvubVq4xD?=
 =?us-ascii?Q?wqPD2A/3Z8p4b/05C+L4lRDDeBlEGb2/mxCdK/kuRyFscE0N6vlMlgDGAJp6?=
 =?us-ascii?Q?0N/1Sxo6yGLB09gL2V0uzppL9Wt6VCD1sBrE7CmUJe4ZQjhohY01bvZk4w0c?=
 =?us-ascii?Q?YpruWVP7dO80v5QmSpoYFZAQ+V8BMuIrjGN0HhUO6OwQ1SpzOEmPAdzE5UdY?=
 =?us-ascii?Q?GX9kOqUMpXRVNEQ5AYCNU1fOJn7RFfbQ0bN8fGSD0gHj7eG7ufBiEux3e+1Y?=
 =?us-ascii?Q?MWhNB8SA8L/5JKmUAcRIKzBQ+LoY2lfMt3q6dD9UbV6Yy3Fkgd1v7Fawrek0?=
 =?us-ascii?Q?GVfvCCj2GNangZ4JhejHREefjWofPTq6/NxWHw0AQrhy8AR3uooI4XQhJzOx?=
 =?us-ascii?Q?pvjg+qSwIEdyYFdtIaophNPw+Vn2GhYmv5wEoBxq7w5xxS9Zynng61Rn76GX?=
 =?us-ascii?Q?2ZJM7LF5EL5EKgVr+BFXhBV7gcZg0f6S7nAnVpGgu01Il2MsAlPVEpwwLT3n?=
 =?us-ascii?Q?qltJNgs7dwiFbjDWj3HzHaG8VPDtOwXNqL0dxjG9ZrmNMQQOUdig0iYPvy9x?=
 =?us-ascii?Q?iJFHrcMKBWA07X+kd4l6bLZT597fORW1R5qjyCT1fNCWZyGwSw2QcYvgss5I?=
 =?us-ascii?Q?MDflhwZXVnqy4FhM9wtI5tRmQX1nRzeId5jhUGkittTsFZ85469ygNfDBP3J?=
 =?us-ascii?Q?iQKS4QYXS332B6HgjrCzOqW8CfU4tA5e6dqGh2ClRz3uXAlBFtjvSbEBRU4Q?=
 =?us-ascii?Q?lHLcNrj2PU2U7MW0JB5pMvPAIDwcGw0eg2z09Vvw9BpsokMqgzdEPtMZtmUG?=
 =?us-ascii?Q?LYOJUnsR4wEeiXwN8V0UR0EUaIBzy9D/r9pjsi4hI0cJyItKN34wihzs9Fmf?=
 =?us-ascii?Q?4z+psjxfUdYQZmxJ4TjmjsszKDs1nADBJUTuwscFs8xDmKpTzpHsVM/cPZB7?=
 =?us-ascii?Q?bdslYW2xamDUpgcGlU/rTiVVMZr59tZe+IpqqA/RXdraLZy0D8LN/tTWLJ5f?=
 =?us-ascii?Q?7IIh++SgRC87DBVh8pxNS5PQTXcc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CvDnnyUHPD03WDyGk0D+xbAyXhzy0mWoqFREkRZdp/Hf3rHmdJ7tD9oodTtt?=
 =?us-ascii?Q?ogr6wyWpBCI/UzEfdCKpfuLbrOzuQjSAk/zWEYLwTTm2vfEy/1ppfTSMjaA3?=
 =?us-ascii?Q?Iq6ad+v1J9ufZx2RaWIJ2J8N3BXxWkQJha1734RbnBZ9nDEEtmHbE3f6ps9M?=
 =?us-ascii?Q?45Q7h7aGOGHvBSO3SW3S/fCOLOlBHK+UUoQ1znW2L2+yLhl1HS7Xi6/78YiY?=
 =?us-ascii?Q?8AxtARZyWpSt537//OHoYNyuhg78PdO+hAOzhf9iwrbEjNt6PPL3qJw54/oi?=
 =?us-ascii?Q?84UN7qAPMZUQdxK1ho4cqvwoZ/haO5Qwl7FW16H+yDn3kolgH6MNoiytM7KJ?=
 =?us-ascii?Q?wzV/BrvDsNcH49rhMOyFw4SAKuJsVQurjgPI9FaNu5lR1qSpEvOeQVDoglgG?=
 =?us-ascii?Q?NUtJIB7/rxpudeaSwjf/6EDX83fufq5kespLlEzs5/UOrgJNbePXD2a1YU+l?=
 =?us-ascii?Q?+t4Feo/waQLQv0KgOkpv1MfVgjAM+okb2c3e0FSBoqHHNAhSk7h03JqDwTD+?=
 =?us-ascii?Q?fniLk7Geaz8THSACSHYF1iUkKTsiXZ+N5a/2qAky8hIUyu1jkkv5CybMqYpI?=
 =?us-ascii?Q?r7/2U2Tpj1XpdiEbKpVjB4FwGx5ADHvfr6p2atlps0EhfUCSNA1EXMXimZLh?=
 =?us-ascii?Q?pQjleQJmHRKfflhFxZA4Qkd1hZLX5Ea9BXSfsewW/rIGneOcbUFwLseJqD2+?=
 =?us-ascii?Q?3uCyzFSqnzGPvNuXBklYxnB2YKggZ8bO9DMy4vO107HIZ04olpAw5/URfAjN?=
 =?us-ascii?Q?0agmjweM5sVyg4u3iXRUA5lxs8p2GCZn4aAgc4MrGCbrkPB/EirEacKHTow1?=
 =?us-ascii?Q?ZvL/gyohT9Gn/2hz5x766Lt+Z3msD/QoP3/S0ImNXDKaa7wqC2e9va4YshNF?=
 =?us-ascii?Q?+cwklgn8cbQFAt4jFOAmoVcjLvxToKXtQt8LsOPNrEh5M5j8N1HIHVSFiuA1?=
 =?us-ascii?Q?6HqwgcnJiAzlxZwuRURr3qQcK4vi/e0SX/sRt4isIEh7+GMiVgADuYhZtRvC?=
 =?us-ascii?Q?LmKqbV+WajxQvg+tcZHh4snK/sZQHabFK3UI+Nfjei5oibGTMrYVcAtbHKmN?=
 =?us-ascii?Q?wfaq2d77gn+ydw5jExAf7r5Ip8ajiIR8TNeX9SZhm8NkHTDTvS2CI6vxYIiR?=
 =?us-ascii?Q?NptzsrCuIp5fBWwBWUSQSlw+wRy9T7Jh+qLjU93nK8gH7VCfpcWDfM/4w18Q?=
 =?us-ascii?Q?2XNMBX6qjZO28upb41ALoIQh0Y5G1DTIuZgwGVZM3y0oAWx6hg6m6CWzUfYz?=
 =?us-ascii?Q?/Whi9WYiJheLC5VTvqlpY/5V7gPu/98xsDWtvIaoGPSH5rQYkQBJkH8GYYaO?=
 =?us-ascii?Q?8TPuR5I9yZBKNP2cWnkd7uABzgN67wCVcXzgT4QSHExGFI0etswL/6sH6lLJ?=
 =?us-ascii?Q?HhznNdCWISOq9LvFTocCsQebG9lwGWzzi3HV1GrSehhvUyAur5CtqtJcfTI1?=
 =?us-ascii?Q?JKH15QyE46uASI6seZRZ3hicPUlw4ZTTfV7l5emoQpZpJH8gz/gmmHwqxMq8?=
 =?us-ascii?Q?1UMPWwR5wQbx0Xuyku2UTofXCCQvxpesjVLTgJ6Efe6S/fyAi6qL7dOP0nM+?=
 =?us-ascii?Q?X9wJW82srGPAvwEDRmxWMU+9E89gOuVWmut92BwA13mOaq1EfS6W1ALLzpBK?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf60c823-7d87-401d-2520-08dd47e0b92c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 01:34:26.2471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwnFMNHPDvj2PXKezB0HpvLg5zQckQ3RQgPRW+O4HFvzEb6npng/x+uQEoGxQAiGlAEgGeMwxpM7aRgv+uPRfnTxXgwn9dnyNQ/NUz4qJ9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5308
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> to a device. The cxl fwctl driver will start by supporting the CXL
> Feature commands: Get Supported Features, Get Feature, and Set Feature.
> 
> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> it indicates the security scope of the call. The Get Supported Features
> and Get Feature calls can be executed with the scope of
> FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
> of the Feature reported by Get Supported Features call for the specific
> Feature.
> 
> Only "Get Supported Features" is supported in this patch. Additional
> commands will be added in follow on patches. "Get Supported Features"
> will filter the Features that are exclusive to the kernel. The flag
> field of the Feature details will be cleared of the "Changeable"
> field and the "set feat size" will be set to 0 to indicate that
> the feature is not changeable.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[..]
> +/* command_id for CXL mailbox Feature commands */
> +enum feature_cmds {
> +	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
> +	CXL_FEATURE_ID_GET_FEATURE,
> +	CXL_FEATURE_ID_SET_FEATURE,
> +	CXL_FEATURE_ID_MAX
> +};

Btw, these values are unused now.
