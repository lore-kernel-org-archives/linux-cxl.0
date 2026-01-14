Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAAA25A640;
	Wed, 14 Jan 2026 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360683; cv=fail; b=EYqq61liAykCAQ1cr+yUQ2HamGYFRHB27164W8YpjBBCc2ZDmyz9ul/gjRU9b9K48bgu7vq/7LvBfj0iso6dYHrjUqomHDY7dWUkx/Pq13CH3EbPZHXy7633WtYPX2J+Qg4PGjVFRQRSflhz0J0EQ+8SQwpO2FWiwGR611P41cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360683; c=relaxed/simple;
	bh=S/2czUbReCHo9TOkzxTMLD+m1VQMvQzoRBXWErAvAcc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=khrroOuauUulcZha3MdIhcOKVRbZ4GlgKwpc+eRDIvfp7fTAyjFMqav/20etqFRT8nKjF+3k/0nYhFfkgoV/zLWEI8NGe3A6hVrnhLPkfRRGpT1nLByOVXD3ZUeKEl+2O+lmbnD8sroCCZihx69Js8nMMm7BqUYYQT5+dh1MDp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9SrV8It; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9SrV8It"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768360682; x=1799896682;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S/2czUbReCHo9TOkzxTMLD+m1VQMvQzoRBXWErAvAcc=;
  b=S9SrV8Ityk9Ku9EhGwlXmwoMu5qx/FvqehmcsguYW7413aWhb4OVmESg
   LePgPI2J7EX3dQQxCQ4XuHIAweTpjnHal7peeh8tt/PrgjKsxeIBFpYRN
   9JSYmuPy2KZHTvzcaDk+YZS6ZZseH6agixrb8ziJTIRcnRBj4HmArhCMR
   G63CuIgIcaRHZAMWwJSQo76s0Xk/9ca8/QUDHI+qbaqnDYb8Zl0DvH2aU
   ADYvBu6frT9m2DENZp3AgPk2akcKi21uMPshOb3nXyDnXmzMSe2pcqK7e
   8TB5aQKhtjbDCmm0KkrtOA2jAfpCVtSUEn0fv+8MTKOnbyQMDHq/GiNaa
   Q==;
X-CSE-ConnectionGUID: K4E4GA4CTnymJwfVH5GZlg==
X-CSE-MsgGUID: a70NgH3vRQSa9gq+C2VZvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80305537"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="80305537"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:18:01 -0800
X-CSE-ConnectionGUID: qMZNPti/Tm6Omb/1Yhvzhw==
X-CSE-MsgGUID: DDFR0F31TmqRBnU+cno99w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="208715430"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:18:01 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:18:00 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 19:18:00 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:17:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXct3C3lbFAdJgSH07c5EPFvqutu/yqqOrIIO+BoUibOs1psJaOsIlkg/iNzUAnBbnbADxoKXhGljVCnohmQa5QssbYiIefF6GDDxRi8ly0S3JSYtZStXUH8SWne8JU3oMmoX9aWt5VpRlEqktMUTY3h9xpBvekkcPn5vcEf2QgMXhh6UmFwXn9c6llCjn/yiO9KnrVQ5HLzzz2SOsiBDRxyyJkcDToQCpNNo6rv32+WuoGutqmrnFYBSzeyGtz2yNnAmGq0vyVsGaap1c5+kNBc8Zl8iDmxN/Z8c+aIFyDo1Y8HsgMr1XyDhmbe3KHST/hyBms1/6l5d2ITVuqdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZzvjGm7JAkS55whE5jaAwyI29Bg7h/os9t7GK2D17A=;
 b=jujruFht0rPioNtdg4bfrxLt2Ey+BG7gOUFZ6Mvn9WYtxZnCQ2Qj6qOZ+dUOLd56pGMKahnxjR1lKrtUjVVSF4QmbTCgo6a4Lq5ZgYPViWnz3sQsULlZzxT1pDtFAvsdOs2S5NIMhu5E3GvlzG4vFNdQJYJFlWyd2jLQZiLEu18ZFUqjbvjqIGjDbSku16gdVrlY5Y16WOn48Bx6Tkx6qS+CrYiykX/FHLWRe1bBdMpAlNOIXN+3BSrMu2hTKZfy89u4cZX+wbv0csoh0NMPKBYrl5rR2JIaDQtg7CDdL+yWdTmvJyub0zdiO+i+vik3KeZEP75YNZQBlum33Zrv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by PH0PR11MB7166.namprd11.prod.outlook.com
 (2603:10b6:510:1e9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 03:17:58 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 03:17:58 +0000
Date: Tue, 13 Jan 2026 19:17:54 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 06/13] cxl/region: Add @hpa_range argument to function
 cxl_calc_interleave_pos()
Message-ID: <aWcK4lS_1OpR8V7r@aschofie-mobl2.lan>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-7-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110114705.681676-7-rrichter@amd.com>
X-ClientProxiedBy: SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::24) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ae1611-2acf-4305-09ea-08de531b841b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EqYII9QxL+MEzURviBpllYxDLg8BOQ1UbhTB0dH/GE+8ooeXi2zJZglu1Ehq?=
 =?us-ascii?Q?k0PlFtkIigxgbPn16CJffT5T3PRE8FMX6g2d/3vsLnteWfMesMNfeUajqWzo?=
 =?us-ascii?Q?x2q4kN90ilcn9RL5VSR3Cu5lG2TiqaaPA96v5Ty/UPys/Jxr+wAoxVzIswCf?=
 =?us-ascii?Q?cjKq3u8UNZ1HkTn3+7pP2697bWKvHzS8sciBwMO2rZ6m8+2UJ4at3d7WZbSi?=
 =?us-ascii?Q?ImCA7aY92qkEufD4m35GG+WfSDos3l0BjBtgPjrKQgARyW17a/gLme+i6MRQ?=
 =?us-ascii?Q?Fy2LUXfYixvFCE9Fj32mww/3VAd5AaagCjY8H/WqpSKirsFLJgsQm5DH02x+?=
 =?us-ascii?Q?5sGvHhRxyoaxbPi5qEU26A0R/ESiDmRHcoyJDbKvYOT5x6FgZHuiQcfJQe/c?=
 =?us-ascii?Q?ZLJV9p2Td73S9coOoLmZ/ytYiWgx2pg8qU40wmZzjyrWFSq+KSfZSTbJxbRK?=
 =?us-ascii?Q?cphKSso1jr3KmhF+MrzptAfzoHnG7yazEJxet/hVRXJoPyZzaZgU8TLC+P+z?=
 =?us-ascii?Q?GiJrNSOPVNUtKAM9mF0C7ijaQ3TYFMK3+cAgEiF8MIwW2CFwnBSBgY+WeSnL?=
 =?us-ascii?Q?dtRugALMTklswg30V5fCAEE0ghArC8AOb4rIYnjJHZzWZb2j9lbAgewo5lqF?=
 =?us-ascii?Q?pi4mhkd6DcerNJsjSmGu6DWOna17uIGymOfcK6cYS1wrCeOD5q6eh3A7wbjI?=
 =?us-ascii?Q?6t41AWezNmK3q89uoc/99XskS9RCP0lks0NY+KPyZgF9EUMtlpvuD4WrjJYx?=
 =?us-ascii?Q?H+koNYhUQS5y6v36vonzgQV9z11IyyTh70OrNyv/tKuLfE7/OxRflPj4XXvW?=
 =?us-ascii?Q?BNONcNqO5kMATXLr5FIWptSASvS1RAS4iIK/lLpm5Zde4UaRT3p7x5VEKOxJ?=
 =?us-ascii?Q?S70myQrtlJLNoJbvcAY1jDqcKOx9i22q5mpuTMEdkEsgvbll73mYXBFc/4et?=
 =?us-ascii?Q?UAlZm2Ut6ltEGiXA2rtGW1IirY6sAnuGxKUVWHwcPU+RY2kvtPIFulrcnTES?=
 =?us-ascii?Q?OH4R5MkNQ+WG9h8Q0MOHHraU38efVlf5PhsT45RCJRwCDls5YfqgRyQqneE7?=
 =?us-ascii?Q?CcKRO+Esf8zMgRY/let9DFhlm6ZmNtA1R1F5VgqnwSsfG8Z1UQA+k3D25tKI?=
 =?us-ascii?Q?Dao9bK/H472i/+Hy0VH+0ofnY9pb8sfD8uggPHcLnGmehb3r9GZ9gFLu0OnT?=
 =?us-ascii?Q?M0YybYSL/a+uUXidLn1PBpu5KDGekvHgEXhVsENY0EAWo5gargxGL+ryLT5+?=
 =?us-ascii?Q?73Jydnp7u3e4sG1wx0nkjZkRigzyU27Hl1XD1dkzhu9v4Ixlz+NLeSK0OZE4?=
 =?us-ascii?Q?qS8tNoHtPBsNyw1MtOHJkc6uDOvRiNGCcyaDagGlkQJ1b3PgnhUkW93nA+J0?=
 =?us-ascii?Q?I3FEcP2xQUuei+jxFAatLci3cf8TFgNThid93G4Dp06XZJotHHGsjdCPM5sv?=
 =?us-ascii?Q?xUDmjsBpfHqG0QEwmnz87qWwkKgUkobQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?okOE7Y3GQm3xeoGtB1rLzHrARZXSmqJf499YiT6w8T8sEMieS4n5O98gzOah?=
 =?us-ascii?Q?sAQ/RSb3+nAyq8u9E8xNd3YbZU+/mxLt2mMY9h4gWWGKycIaLdxhSfUanRHO?=
 =?us-ascii?Q?5XwwKgRr/OXskMGFNbgvCQGQ4SMjLacWHI3fof/tVo0lL4K8PbanjfFWYQNy?=
 =?us-ascii?Q?yT2vmaZPtcVKI1kFSXNl+G36UkJV+PZWBEeZxRVTWb8M5A1ZfPaDPW7MUNSE?=
 =?us-ascii?Q?qQultQAzIOeecyLbS8VyOiOcerlhJoEZbwVun3Azp1f8C8qG5nY/9hngNfum?=
 =?us-ascii?Q?OQq8fiTz/48QO9Z/qwqyz0qjv8TJ4ROIHJqBaFL6RowIeL+IoAZFEaF7wyCf?=
 =?us-ascii?Q?DmZBgTaHtft59jmXQWtfF/wp8Ve6tMsZBaxukwX3QnmXfeoZfLlmZXBfOshW?=
 =?us-ascii?Q?gxhMvrg/TJkqcq7GjZiR/K3QYXcWm7x/gtq0Hl6p4KFKXla9TnlHjejb290x?=
 =?us-ascii?Q?iTq1qxpbDQLdEbM/f/jLo0ysOvfJupQHzE0ivaxso+CJjhzj09Ri26uGNa7x?=
 =?us-ascii?Q?MpgEz5nXnDtdDUaDIT1G/LNhF6b4nHmrh3bH0soWR+57swJZGuXlkpuFhijE?=
 =?us-ascii?Q?JDCy/LVpwWp1GJYkKlDvelM5Smo0WqRUcw2zgARrZUCSi1bl4ZtPKUCKiXT1?=
 =?us-ascii?Q?e+fQ8OKu2UygfiIsaXDXYyWInQ49eRUcGm0oBoEAqosp7CwU8nVU+Q0qp+gF?=
 =?us-ascii?Q?GE9csK05d0zjk2cmaZlCS0X/EJB1pT2PnSGGSFPSUF/ta7hHMGNwk5lkoQFe?=
 =?us-ascii?Q?2XKmfKZHRsg5mB6VE7Pe3edM6zkUO7oMZISv/3VSzvvd92x3z0/OTiN1XUXk?=
 =?us-ascii?Q?vXBhPvJQQkLt9XAAPsc+JXnAdFjRf3S/swwxNiMvQYE2rJxCwyDJd4R7vxT9?=
 =?us-ascii?Q?74sxOSmulj0Tv9dq1L273sqcE/By7BFiptBDER7APYVwdSZlECkFWftv7Q2d?=
 =?us-ascii?Q?p5Y8Gc9vvuGJlVeMAO4CX9Kq4/uhZF9bB51nNK0IRTPNxYSF4SUpP5g7fdZD?=
 =?us-ascii?Q?mo1hOq/6Ni1W32JV+tWp0SYLySsSW5tHeMyzlN0oaBZjNpWZVxxk8d6SlKPb?=
 =?us-ascii?Q?ABVX2Zl5gl1G8ZPdTX/gP62nOIimMjk3dS2UWwae+LBAWwHifweoz/gckVRe?=
 =?us-ascii?Q?N/qwSJZp6hLzI8prxOIpdTpnWF0x14zgDHw6TWe0kTDteBJiF0zEFKIdT9b4?=
 =?us-ascii?Q?J+11oT1UVKjWKwPW7SxCxU61O/xU6IX+QU5F8Um2ywded++vUPzg4UohhVIt?=
 =?us-ascii?Q?/gNZvgG6Y1HfNZ48UDJYSKYIpxCfkiXX8dbo20EF3dxqRZv8Wy24yc/73+cp?=
 =?us-ascii?Q?tpv/B1Du/gwsUEngARfiHT0s0q1uJpmGI8/7ryBJoBQ6w+YPpYMBMT76hdZA?=
 =?us-ascii?Q?tl9vuhJPxM66Y2306WO64FUQCL0WRVaEWGEnCdbnDMKCaGP4ycBwXumFHTCJ?=
 =?us-ascii?Q?MqOoV5uuXvk/j1IaBl3eFVPUtiezragsvHUMG9aFk3uzYbnI29/Ow0ABnRvi?=
 =?us-ascii?Q?9b7s3zz+UkLL1X5UB+Mz49sUEmbtCucqVV6NiXFD+kvpS0m6uY4ekv9lQUe7?=
 =?us-ascii?Q?DXg+R9qjgYJKxi/GDy+bgt8ij3rm9bAagejJqkOAAGJKJ+HWI9HwsyvXgp7Z?=
 =?us-ascii?Q?zIP/lFwNheet2TL1SiZtP5Dh3lGOXzT8NJe+BTK5l8Y2jjteTy4p4Hds3flr?=
 =?us-ascii?Q?K3rJOqrtv2+9q/DnXF7oozRUFRQWa8p/y4Yq5pXDadcNW9g4mEMbmXAtyMpm?=
 =?us-ascii?Q?NB4M+bJf7FjfuZoYPZtmYrTl0GutGr8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ae1611-2acf-4305-09ea-08de531b841b
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 03:17:57.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1sHT1JTPJcEA5XODDUVmahK4u/XY+GK+QVnujmBm6hpBxnYhB8KgUXq9T0CywWnYWM5ez2lax6R8fpsD3MLaaOMsgFTIZ/4f0lwqJKhscw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-OriginatorOrg: intel.com

On Sat, Jan 10, 2026 at 12:46:51PM +0100, Robert Richter wrote:
> cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
> determine its interleaving position. This requires the endpoint
> decoders to be an SPA, which is not the case for systems that need
> address translation.
> 
> Add a separate @hpa_range argument to function
> cxl_calc_interleave_pos() to specify the address range. Now it is
> possible to pass the SPA translated address range of an endpoint
> decoder to function cxl_calc_interleave_pos().
> 
> Refactor only, no functional changes.
> 
> Patch is a prerequisite to implement address translation.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

