Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952492BFC8C;
	Tue, 13 May 2025 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162359; cv=fail; b=i0PJjRMQAtHyDfx0Y96S6qzVR+RNx/JGpRHegDOzvY0gKgNhkQImAYv3O3e7Ox/TOJRji1CRNpj//pGMVmGSYYopTKI+eIModgZScON8U++I3yDM+B7b6xq+DJPRzA2kZFQ4+torJNlOccefLplbdoTddm/E3c8Ue2z0yD7+S48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162359; c=relaxed/simple;
	bh=i/NLdbjozKetBh/0M0Mh4ob8PUNjtmFLYkulaulGT3I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q3y8EOIMn2H11KBPF5VPfVvdfHScWGEb6dRbWS934AilYKtGl2RbxCLMOyvsk3VQHpBifiN1ZaUNCzeqB5QZUHhqv3+qRyhacEexLu72b+rl9E/NoJPixe1CIzJ+psGklI2QWdGmX/S3i98QofXjaHi0OpoFF2vbVGbrvqMwOik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSu/KX9z; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSu/KX9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747162357; x=1778698357;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i/NLdbjozKetBh/0M0Mh4ob8PUNjtmFLYkulaulGT3I=;
  b=ZSu/KX9z2sOeMgop++8q9vJGwlByuzyUI4CJKDc5v1RUAO6rHA6035S7
   bs9RLI7bGwTIJgXjrhJNjVCYQ2nEUDkJNfJudg6xvEV32i3Hf9dk1GAxn
   GgF4cZ5g6gy2jfQoPLL62fiu1wxquD/lS9vqJf+L0dNEVFvLd9YB84MPH
   3YYo3N4k6zejgCVNrXmzpH2goCMiD1efyprSCV9gkoYkqA9R4dDrR0VZ2
   He+u6iAwU0Ylrp0gXzmgYf/vrB4DezDR7O4AZmvrozvg9Eo0q1MXOVdX0
   5tcCaidfXuaZiBzzBv5p5QJXBW3nXH/90d0HC2Y5gOFr+mS+rcOUfWE5n
   A==;
X-CSE-ConnectionGUID: 5XDqMNdtTsKdZI0PvvwLZA==
X-CSE-MsgGUID: iL7AARLkQIC7Qtgg0+CXKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="74425713"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="74425713"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 11:52:36 -0700
X-CSE-ConnectionGUID: aqOxTUHFSVab5g7NiyiB5g==
X-CSE-MsgGUID: tOP4KAGqTfm0NHNmkNIahg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="137525590"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 11:52:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 11:52:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 13 May 2025 11:52:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 13 May 2025 11:52:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErZCdxvzh56jIc36VmDXSs3nCKFU5rzHlpSrg3NRhoOTPHOva1g8b5NU8dIqMKHMS6T8WpYLI42TsWvU1TES/9n/lD4530lubciA/6UgM7BqcksTBbZ5obaUz1JBwhEfz48uM0HXKCvhpy3MDoJH20SDNiMRc3bKoRJkJIKNXqLtFGHXcS36BHh4pUiwIqkoDvhQ/Tbh7UnDBLRd5tLXwRCISLmkAyVoU2FSf4LwrR+fULxd+3b2OaVSj3aEVznoUPS3Js1ldBEBRNqAxftlpQdp74roRjSbojtq9a8/SJ64TGNBtaTxkWITgcnAfIAft5fApqBlgUzY3h4rOJx4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRwfCO6kh6bF+8gsISNi9JgjvAJj7ehmU4xDDDlOyoc=;
 b=rQ4uaPKCUHuMK+OyBwAQv8ZiXHxrmVe/v9xh9RyPFDccUyF+ARpqyxAkH/WhBL+YB+/ZbLZcwt4ZzBWF/YgcSU6PMl5cUuDrZLOlaL3sKT1+VDiDzhCn2gtBYglkF+ekRy9GoUdbyTkum1N4S+RsAC7mZPqJ2Panq86LFjKh9hxbcNuA+fsm3oX3mQGpqIJisDP1/eIOC8UnbfIphqogWCQFWPB1Vop2ndFieGf7sRpNT0FkNztI1G2NAG8dK2bJtAtw0cmY4Hx0yuGUtQ9rJfTEE1QBKLJoXpMGsncSfiPFpxrUCQe2W9DpMFLOjyl91RPJSXMsHLzz8Hm66XcZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by CH0PR11MB8085.namprd11.prod.outlook.com (2603:10b6:610:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 18:52:33 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:52:33 +0000
Date: Tue, 13 May 2025 11:52:25 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Purva Yeshi <purvayeshi550@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <ming.li@zohomail.com>,
	<huang.ying.caritas@gmail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: core: Initialize eiw and eig to fix potential
 uninitialized use
Message-ID: <aCOU6V2mece-gjWz@aschofie-mobl2.lan>
References: <20250419203530.45594-1-purvayeshi550@gmail.com>
 <680682dabbd09_71fe29462@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <680682dabbd09_71fe29462@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|CH0PR11MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed547a3-98a2-46b5-f25c-08dd924f51f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DIQ7/5q++V8LpYFFPhO1lYldwv/X8Oe5BMR8RDlfLpnGBIAUCqhSWDOM+EKz?=
 =?us-ascii?Q?wzQke2stOIxpb7Q8Je7teATcjbLA5dxfWDt12qZGj+DWkrmfCbhcgPWgVC3B?=
 =?us-ascii?Q?V7/Aa5e96jOBwdq2ZKBBN47Xd29SAlg66vKq9Z0qZjt4/M/pQisQN0EC0XF9?=
 =?us-ascii?Q?9yUtL/K+MUHUfL77Tu/XXGdBy0c/ZK87YIcJdNKMYgTeZJaGVuxLr39U7Vpa?=
 =?us-ascii?Q?3FsXU6ZZq5KS+0zCJmOyjgIEs05cVK1+Ubl0z3mPIP+YQmNFH2CDnB64saM+?=
 =?us-ascii?Q?pINxPyBZ5GQvb+d3fv5xO/U9IBWT8rZsaTvZPzOiZI8tBx/F2OWQk8n5bsPz?=
 =?us-ascii?Q?ANVpwTBrM9+JjqKUYDoKcTCzxCjkNgOxosh+BNKYX1XKSjRWj4TQFY2PVSXL?=
 =?us-ascii?Q?S8XwN0cz7C9nuOEYq6bnYaH+o/gw1dj8ZnulbUmCU+ZNstAEOx0ltqC3rqOv?=
 =?us-ascii?Q?wCA3ebUw4niQ3sbIpnNRB9ZgZroe7JcrJS6s86do+XTaBldiWXod/s2OzUVT?=
 =?us-ascii?Q?au11wjKZJkyGrXRctsvph54wvraOk/GiFHfWrr4IZdtUv/dxZu1HU1CmW2wZ?=
 =?us-ascii?Q?b56CrNvrbcsjc0M9Y+dWIs96F33gTMq3K95QQwKeeiezirjqY7NbMhswXVEd?=
 =?us-ascii?Q?UyEMeUcnhmUtFoNiH7xnxLHjEnUWKFnDMV5gc/SU78e17e2gNX6HE9Yl1jIp?=
 =?us-ascii?Q?nJ2l7rRbjjhsbkzttVCT8VH+NXQybbPdqXmLzBcNAk2Lx1Z4dsvLHxE6y9+Z?=
 =?us-ascii?Q?fIo+GX3y1TRWEgRYGx5n/XvwYh0l6qUnCIVFMsZVHNfA1z1QeVW4CF5WyDkB?=
 =?us-ascii?Q?+zQhl4VcF/ih3ihZTUCws7Rld3BjlaMjNHI9ST18fhv/0Tli4WK0YaSX2TQ6?=
 =?us-ascii?Q?RvcdlON7sk8DDfr0DPI4ZM5lHUz0ynZWk+ftaFa5MtMcbXZ/N+rrfdjeNSJX?=
 =?us-ascii?Q?Vsz9PceYdhkYIfZl3W2SBauNLMYoEW/rhiRUF6nCIwIIZy7m+e5uDLeuRlIp?=
 =?us-ascii?Q?L0l+9k1T3CSoy5rAXSv+nrb46dDDfuWTWqTJi2cQxOCP9xJ4EWfkuSB3cj7e?=
 =?us-ascii?Q?WexiXD+mnCP4xEQXFvgz1vZM+c3oLOXJGMiRvzOn8hRLJFXAXoXMtRgZKVIY?=
 =?us-ascii?Q?A7lv1lpfLtOzVSWj1M0aMYA7IGkChyPgHEykWvWhqq9Sl26J8+cUpRegvbwK?=
 =?us-ascii?Q?ME4VWwTCV1gDYwzECE5hOSlibGJOtrO1bvkCz3rrNy8duJpU3u+x92ye12cp?=
 =?us-ascii?Q?SNQBmRUVUIrevPr/eAxgeoyGLI2QjzBFqhaSzeSo688b+LNHa7lg1e5L3xmK?=
 =?us-ascii?Q?JdecCDgo9vzxCIvypxz6fbqR8lcXWyQKJo/PAUruZHACf+pUn/Bqk+taq5W0?=
 =?us-ascii?Q?4VGrR0smGRrEgF4l5YJx1qybxX5a8j5143wKxoLf9U2pU8dbsve8SEJ3jlRm?=
 =?us-ascii?Q?S0TSQwXGeBE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Q3VuCFBl9M5CUacQvPcG15WG8pGcP6YlCO2+pzP8dciHnwwEgUXePbR7Zw4?=
 =?us-ascii?Q?i3WKZ+YokxfXxaqInVDJILINb1R26Pdgzb998hxg9GTp9li2jBbM+CFn+mL5?=
 =?us-ascii?Q?SHEqzWxbbi6rJDfRhqsboNhDNQCPuCx/obxQ3iTerCxdfFmQ4Im2J1vy7Jwc?=
 =?us-ascii?Q?ETV+UV/BcYi94Ddcp0u/MkVcH7zAxIizo09WczqsCmhg+tcZJMpVVB1WTEX7?=
 =?us-ascii?Q?f+vD0NsFyUkDXk/254BGmRUYJ7lcdXr6WWkSLKU8LHTZua8s4CJKIBKS9XRN?=
 =?us-ascii?Q?GFXZ1J90JvcREQeIwS1Kd0SzwDoMVI4v5Tb4jvQNvmdoa0IXb1iep7Wk0c5B?=
 =?us-ascii?Q?S8CTlJAhfe7V/Vi1XmHlaUUXbsisKVIwf+RmC4bpwegcc75WGeLB8PQTsnTB?=
 =?us-ascii?Q?/xtcvCd6LgZxy5z07rmqKncJriZ8Rt+/F9ZVJWsrcKb9qqtU6L5LhokbVN8G?=
 =?us-ascii?Q?gSpi9+kUlovihNhIQ+T1oolib17e3BepSfC1kfJ7cDOADh5xIs5TCbuPR6Xw?=
 =?us-ascii?Q?cZHDLjgTn72P1yh0jphFNsdOX5XnVnfrSWXKaB6VXm1GzF8zAZIIlotlTYz/?=
 =?us-ascii?Q?IqhKatIMn/AKu5H+aWdBUjOE2YVCMnNc1M82fgKknb2vXPANKFEFE+G9HGOi?=
 =?us-ascii?Q?3CixJKA8hL6FjA96Nx9kMOjbumeAY0nofDvfPau/KdcWwwQb4N1S+8V4yMOy?=
 =?us-ascii?Q?JmAFUX3cdT5EjQfWCpziNvI7oKGuOIJx2rW5YgbWDdcJWafiqmt1P0RSiQCB?=
 =?us-ascii?Q?G8drOkb3lTPq+nx9Ecj7lZzUXdMgm49dC/Pr1RT9u6xyUAN6/VCwxFCxF+ip?=
 =?us-ascii?Q?TmeIypy9vi6gG8j+uADv6QJsIchNyfSv5PtSZ0BEGyTeaG6FEk58Bj0tao8/?=
 =?us-ascii?Q?CW/BkykN7HiXk/So67o9zEbIT4UuP/tjR+ykmlMxdDaOTP/nxuwKLhj9VcI1?=
 =?us-ascii?Q?pIsz8EHrkuCDN4ZebL64TzIwM349erhpX6aSUNIEkauVoa6Y5BA6d3LFv4Cv?=
 =?us-ascii?Q?AC8rJbl9kv1icDb+QRIafwx+29j7YmO2bXb92O7QOBrQ1ra+kxgfhqa1GGPU?=
 =?us-ascii?Q?r1A55Jv9+TiNTbAls+suONOmMDh/2GLbHTW2NUqU0WWEFp7JO93dhOaT0Pa+?=
 =?us-ascii?Q?T3XgtrO152M6zz+5mav9UvyCX6aqrrOTtt6l95CVCjJZDP3m5zCypkwV2psX?=
 =?us-ascii?Q?qhF1k6fAOwSWM7V98YNlETbs5fc/f1H6VTNFMToPjP/4jJ+NPohMRFxl37cz?=
 =?us-ascii?Q?V75o1xuNuDfmYI//VSD0N05cRPz2Kll80SH9S9L2K7VZnK9zyHbPHNTCw9Wr?=
 =?us-ascii?Q?uVNbz6zHHJwBSMBKUrSSBgDL0wNBUlDB9oesjkHIcM/kvXvu1wX4Qq0Bf3kv?=
 =?us-ascii?Q?wDiTPYAT0cJNgQMo4ss/h1bs1peXnKGcSuvbFaDbheHs806e+/J5QhUYvU4P?=
 =?us-ascii?Q?Dw6MteXRpLsII7fB6ZaKLXgWRvfp1dpJOWOqUsl8PccOzUdJSnpO/3sEkvKy?=
 =?us-ascii?Q?G3fBK+L0n0FvprcopEfnMTf8vUjwJOra04zlnCmpxJb0pTNQX9zvcZLZqJPB?=
 =?us-ascii?Q?idUDTjBJUu391L+Ye7RO9Ork5+Zy2j6LfsdWkqFH5RVkXFBYQ3ITMABPScMu?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed547a3-98a2-46b5-f25c-08dd924f51f7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:52:33.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjh+7Ymw+SkH2nTvwXmD0BBWIX9157ij1oJ2VGc2XQEywDK6i9GrOQiORmdihXrOvU6eH88/o1iQHeVW++hf4ZzqP0+A6WWL9KRnEkk9yS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8085
X-OriginatorOrg: intel.com

On Mon, Apr 21, 2025 at 10:39:38AM -0700, Dan Williams wrote:
> Purva Yeshi wrote:
> > Fix Smatch-detected issue:
> > 
> > drivers/cxl/core/region.c:1292 check_interleave_cap()
> > error: uninitialized symbol 'eiw'.
> > drivers/cxl/core/region.c:1297 check_interleave_cap()
> > error: uninitialized symbol 'eig'.
> > drivers/cxl/core/region.c:1299 check_interleave_cap()
> > error: uninitialized symbol 'eig'.
> > 
> > Smatch reports possible uninitialized usage of these variables if
> > the helper functions ways_to_eiw() or granularity_to_eig() fail to
> > assign values under certain conditions.
> > 
> > Initialize the eiw and eig variables to zero when they are declared
> > in check_interleave_cap() to prevent potential use of uninitialized
> > values.
> > 

Hi Purva,

We'd like to see this patch revised and resubmitted. It is a
good cleanup!

Go ahead and send a v2 with Dan's suggestion as the solution.
There's a couple of options for the tags. Here I think it is
good to add this tag: 

Suggested-by: Dan Williams <dan.j.williams@intel.com>

followed by your Signed-off-by tag.


> > Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> > ---
You'll add a changelog in v2 here, below the ---,  something like:
Changes in v2:
- init eiw and eig in their helper functions (Dan)


Thanks,
Alison

> >  drivers/cxl/core/region.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index c3f4dc244df7..edf8636f190a 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1266,8 +1266,8 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> >  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> >  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> >  	unsigned int interleave_mask;
> > -	u8 eiw;
> > -	u16 eig;
> > +	u8 eiw = 0;
> > +	u16 eig = 0;
> 
> I appreciate that this quiets the warning, but it is leaving a trip
> hazard for future code refactoring. I would prefer to make this scenario
> harder to repeat in the future with something like:
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index be8a7dc77719..5f20919207ae 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -107,6 +107,7 @@ static inline int eiw_to_ways(u8 eiw, unsigned int *ways)
>  
>  static inline int granularity_to_eig(int granularity, u16 *eig)
>  {
> +	*eig = 0;
>  	if (granularity > SZ_16K || granularity < CXL_DECODER_MIN_GRANULARITY ||
>  	    !is_power_of_2(granularity))
>  		return -EINVAL;
> @@ -116,6 +117,7 @@ static inline int granularity_to_eig(int granularity, u16 *eig)
>  
>  static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  {
> +	*eiw = 0;
>  	if (ways > 16)
>  		return -EINVAL;
>  	if (is_power_of_2(ways)) {
