Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3E19E968
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771901470; cv=fail; b=MJwlmquI/cbDpVbDSEHZlxeU5WdDiru2vQemoHwqRDxDe/tABDmoxvmbErS37+anBJkUw41msThhXN/qLup7YhB2s0+SYZDlRe9G17Z2EK/s9DxEO+j+Jww5QHgld+vQMlDdlcxpkrfVRRnbaop8BMUUbCMOqqMX12o9rAC+Y9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771901470; c=relaxed/simple;
	bh=cecxtNBX8IpI8l0U/BAHdXQ3awYD5Z2C3AF9W8iY9PA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YijxivBoLueOB0m8ApdbvIciQghXqIkGMQQ/M0XvGpNdMoUPzrwKYDU8q8nbAO75WZEyVzXynRcMy0dG3iinp0W9fsqJ5/lWK5VP1jkBLSboIBOmZHc5UEtcl1JHOl3wfQU/5aErU87GV9P5v+jSk2Fz69CMti+eHbpdmFCdbEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0+YPnkT; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0+YPnkT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771901469; x=1803437469;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cecxtNBX8IpI8l0U/BAHdXQ3awYD5Z2C3AF9W8iY9PA=;
  b=K0+YPnkTxUY37/bCMGNbGr0gHRryFLfJPAgzgpjM9EJ6k9p5Lus3R1xe
   F7tL63nQJhMBdzvmyX3FZW3kr8SmCtprtPjfsRVK3788VdnvVFbjgtpV5
   NJYY42x2TXozo9+GzhBsYOZo6zidVCv/siUVwMVMSqyZw3V/LBbtdgz4w
   KcDABCHl967/qNja24KRLWJTp8+29ddOfdw9USdlfyh5f6DVQmLII7MA8
   3PmUMS3kMdhTX8/ZSIoTVLtkpRn9jNrUAswsUBfReqYF4f8CEhVlHhnZN
   Oh2OZ6Vv4AfwhOnUrZS9yDpwP3h2tSpLxp3QuWi4D7kXRwTsT/kX2gcf4
   A==;
X-CSE-ConnectionGUID: 0CDxSHrMRJaTIQiUg+qg5g==
X-CSE-MsgGUID: U9TWAOywSAuBaREd6m19EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="76770875"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="76770875"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 18:51:08 -0800
X-CSE-ConnectionGUID: mxpjaCH7Q/CE8VOwG97cqA==
X-CSE-MsgGUID: Yccv9Nf5S8uiWwR3YtOq+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214622188"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 18:50:38 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 18:50:37 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 18:50:37 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 18:50:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7c2HNvpUlYwbeLSEIwJDtj1BM2HlPpksLeHRCszmuD9BreKIUDjb4RKgt0nwopgQKKjREKokWG76zsNQEbRdbYv+JXexya2jNynqbu5BHoGW6J4nLLYPQJOyYdinsUH2WoOZgKOdh2hlaPSeXtGKIzK6G2ZWeje8Y/siqatSl288Z10N+f65Ga8pRAXE7sMwK5JFa0GMzqPBXFgTs2NXmrjHZ2aF0xwGIdxiuVPd0xrKHgjmcu5t+8bRVUq8KXsH8Ac196vnvePP9gPnRVaWCWRN8q5qmXHL8puxDC3Q/ev8zMKDl6i+PGQFCpGufqmPkhXjlZnqKEVmorIxNNz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HiWTfZxsZZvoxEe9TqMafBc+JijprjJqyBD66q+FpU=;
 b=Izv/fJUxtmCs/X2VLFjYzVCUxBpWce7cK05fgW61OvHH3iQUiwDEcl3MbjVN50eYw0Hr4BJHddKewL+48nIgtyvwx4VHVy4LXICYnn8WobBVp8ikkqEzEwJEXmZTIBAyg1vbu4Cqw1K8rlybARsW7CkynNFOIuvQyb7NEVfio2XwDFYtfh6TeYJDRA+QIPrtTEarROKYQFt8SZ/4hZXqluAg551Q63hlFyEjsuYYSDyOfiWsjvhxrFbew2OO+HiZN2VK2bAAGysk8eCKZXt4IIC/qRr/9zVG6ShqyQRMu2VT88TNNsrk8PUOddsMuSH2qgbvFoMZgnVCk0Z0zPPTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 02:50:30 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 02:50:30 +0000
Date: Mon, 23 Feb 2026 18:50:23 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v1 2/3] cxl: export internal structs for external Type2
 drivers
Message-ID: <aZ0R79N952TTsRcl@aschofie-mobl2.lan>
References: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
 <20260223142633.2994082-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260223142633.2994082-3-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe05b0a-0515-4aa5-0957-08de734f78de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gkKlyLNYSQsFlLrQOO8haS3EY1jnAPu4qDfQvD3TDmqR45lLq97nb8812NCS?=
 =?us-ascii?Q?WGxe7M6rjle2c2R+ADnvv4wUlWZOKeCL6cJVHVIxG+jJXVlBNXKePkhOsO71?=
 =?us-ascii?Q?4F1+kocyLBFgeDf5WK+nR2iX5MDDfzH37gSd0LZSR3QkQvvs8oJuWLdmWYSc?=
 =?us-ascii?Q?4L0QQGyCLBuuqzqkDAEWENYKzSW71cjI7dM/NjB+G+nvWs5W9Rff3kYqsz43?=
 =?us-ascii?Q?7bozkQhMn5zmAGUR61RNcqxCYecLeepMLL40gcvOr7btpfe4P5UQlz9gCiq/?=
 =?us-ascii?Q?nYmb4BA6LC7tXmMHsDAqWqr5t3918Zfan1JQUCJabLPtDyc4kpjBIn3oRhdT?=
 =?us-ascii?Q?8IiRXl6AoKlqAgp5jjQItsURAGqH44dTmYY3ZpoVdAGarYTm5fy7/x50OVhh?=
 =?us-ascii?Q?N6fcCwvasEXMiZdDrPs1lQpqeNa7m4FRuKCukhG0anlZ1KGzoafDBX1agehj?=
 =?us-ascii?Q?zaM5ul/qNFj1mIZN9PasCoObV7e81Uhtqn9b0Mir1J+L+bCMEja8QWz8KTth?=
 =?us-ascii?Q?hugrv7hMaA00sM9VY46ks08z9lRf5kUmfwNLpSJpWHBYae+J/3C8JaApztYl?=
 =?us-ascii?Q?qqU+FSnVUYv9qAv6VTU1gdDIdcfGvss3G+z/Dore9H0yzI0euissUF6IrWr+?=
 =?us-ascii?Q?XGluoP/I06z/R9qpOxaS97O4MCIYk26KHZ3HG6/b+PiJR7Jh42Q5MIkk2GF2?=
 =?us-ascii?Q?/CCO9L8HvUyqeXWFQt+0zbDywGBw83h3iwawqV1NRgNBt7/92tEyuCnmCN4o?=
 =?us-ascii?Q?nAG+AXHSdh0bK/jr35wTvMdekjvPrC+iXq4nok+Whj4w4VhhxNa07TRWSZ2+?=
 =?us-ascii?Q?h4JiTGZI05jvGb9WiurqN9gS4rhoRMfC5JqcA5LW3peutBBXuBXAJn3oRg1s?=
 =?us-ascii?Q?ER0fPywZHFRYskK7D5mJ0uLI3oZGob/X1qfDCjtX+l+VUyj0iwBVbQkhDuUr?=
 =?us-ascii?Q?047SMyggRwIyY15GbQ/mW0s325bgdj0MkNM087sEm70aT/guqB6fQzRciycf?=
 =?us-ascii?Q?aR+qXOIp3c+BUceL6GBVzFyKXyYPEze2lzHsmSubyujrgo0/d/ndry5tGmds?=
 =?us-ascii?Q?SBnzxcwW/td9NqtYm9kuuvjCtXC8WnAlwBJ3hy9pb8iAalKPYKHgLF7HsBV4?=
 =?us-ascii?Q?my7Jieupd2dBE7HuNlaWh0ETUTWGJWeAFtflcWpYHzBTMRjZLH0HXvQ7R02J?=
 =?us-ascii?Q?iPO60+y7UoB/v0gOCJVNZhnlEtewrYM8il6ltICV3X9P2aM3GqrAu/ZiFF6m?=
 =?us-ascii?Q?Xu5SQb3ly2Do2BDSV3nsgwMGxaYHaVJ7FIBWIG6TTWRUjDA8tW1r7Et97AJE?=
 =?us-ascii?Q?CqczcZMSwZXXhxpRpLfVKmavFrlZBniJ3d1U/fuXEG+27LNlNIYyQ5MrY8nC?=
 =?us-ascii?Q?c+VQ9O/GOdlvxTbMUmNIt6hQIMuGTOxkQHbD82629NZqitWJgcaVb3iSGm0L?=
 =?us-ascii?Q?vXoOhsW01KyaI9rmaDu+HlwWXOzaDhBAjed0B2N7kEGoW37wexoF1jrrIy6G?=
 =?us-ascii?Q?coIl3ebcUxkg9BlA0nTxKOxcG68OIh8Zr9iLDdqnh6IMMqYpWSDljvwmNJpx?=
 =?us-ascii?Q?6Em70XtqC2r70HO84aI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jN7a19AtBAusbIyR9gKMLxQ2sfNjbm0J3x+lp1sV0048wWeK826iot4ztYoh?=
 =?us-ascii?Q?1rK3y7PrynWAZI6dXW/XV8mP7L2mRI215Uig4TqE5h2Qer10GDWMwT7SJoCC?=
 =?us-ascii?Q?jgyYhHPNoAxlRwtt9DLmp1zpfUEHiDoLhR5/B9qLwcAq9sPFp8IyoXgRQ4Gt?=
 =?us-ascii?Q?1EbE86mxnzBmXcMZKlhIDqAC1WrSUpcV4URBQOdhSfyDtrG9Yi60R7Nh8t4Q?=
 =?us-ascii?Q?2Bv195YB+wwi2abEsiAYsPjR+CgiRWYY/hH76Xll4LqE91gK5CjUuTmj7B6U?=
 =?us-ascii?Q?AXOAJ1CNJEfqjfIOT/rHH6S58uCqV1TzltqyhW/wAx1lQXn1fDE/co+zAa72?=
 =?us-ascii?Q?3Kjbdu9bg6B8n1pwbF85n6grrtslZz5/8HgISYLkxx+pZAjxfkW8BUvQGilx?=
 =?us-ascii?Q?vJExD5FnAdfhTrfJ+U5uOoZT92rwyhSIW62Uvlo4q1m8/LGwhs6j+GowNG0a?=
 =?us-ascii?Q?SVZxfWBKsyqH4sKlLcTcY7zz1VqHMWdC77t7vzdYNnnr+Hp5uMLPClhVdMxx?=
 =?us-ascii?Q?pNC6sVTrOOWJgI/Q5ptqHoA6W3RfNbCUTNWCCbDfVXNCseCFwVI5Gke3yXTh?=
 =?us-ascii?Q?KJ8/iGMSu46INhGWxkAxxkFTCRb8Cuh2bj1EVySAXkdu08MPyChVgyr1iUan?=
 =?us-ascii?Q?GY0SdsD3RLB52k2h954Hb1fx9CSZJvlzyRl/WWniIVqQfhb2UTAdD39aEUxj?=
 =?us-ascii?Q?j8vUHGBz2te2lo8oR78ZSHmGBMJhA4brPjPiwc43l2TmCOMTs/SWk7ljhgD/?=
 =?us-ascii?Q?GPSiJlV+WUbssoCAaqqb6eHCzQAncn/F63nQ/1Ay3oXv5PRgeYfwcEvMsk8s?=
 =?us-ascii?Q?aj6ZNHVZwUWMRcospTLwOK34MJxMDsGT06xEwFVFw9jGrxYMXEP/O/Ps4cmJ?=
 =?us-ascii?Q?A5IviIFHSAgX4V3pUELIEESnjdNCljxDlKennyAOwwfSjilWX5OUJ12tm03e?=
 =?us-ascii?Q?nB7+BUcIj6CWkMN6geYhP/xRVN8SGmTnqjDkXT9l+whJ6DXKjqyBqPUaNtyQ?=
 =?us-ascii?Q?kzahGf71Ry2WXwnAOp0RkvDaTrkL87OSWmffDAUfL+kjrd8VClafUqyXNZ4T?=
 =?us-ascii?Q?5tcu079bSFwrzJX1txGyoKwcsTcnZ3Wwcv8uj1KST2l1YNCmkfjrr4TE4pYV?=
 =?us-ascii?Q?8sXe1OIQURGVbIp/xUgzpb8j/kFQpkjqm1HGSswjcvpPBv0HJ2HJWoOprpPR?=
 =?us-ascii?Q?5Vfzb/l/M//pnW+TNH0TuJLPpQpdtPzh1FuBhhy27O4ghiYiM21191uuj9PP?=
 =?us-ascii?Q?IwUFfVhFrX2RceyhczHuCKzyfl6lNFHTVo5iuHtNTmo++9+tF6TtmimdBIHx?=
 =?us-ascii?Q?4/dhSGKBgN2RkhnIcax0ZMItTKuB2qJwHhYpgcsSEVLLkWIz9A0wakLuAnTJ?=
 =?us-ascii?Q?oVEf9ZDh24++M3eBOvwQoxvro8FLWSEaRSh6ZjMTRPZ8RUY35CVn7BfbvK/y?=
 =?us-ascii?Q?g0aCCIPCwF4WYviw6NL7Qh5e+yZqiovZPONMCBoCdDmjEb6ZBvIvq5m67D2Y?=
 =?us-ascii?Q?/9wqzu/FL4A+SxFOvPkSQsrXo47x+hlofO1cq+7oDc5CpP/91DNiaHnBfJC3?=
 =?us-ascii?Q?mzp/xytdZL1VOARIGCjnCa4JObM2rvRahxPWMtpFX25SOhqZoO/93o10R/LC?=
 =?us-ascii?Q?GG73LszzaWQTzxmpEhLjSe92mRhv7k+39mOIGvguWOpz3Vt2vGJLgQtZOmUc?=
 =?us-ascii?Q?K9FKgZ94TyHe5e9K2oDurQlIYb2te2XCKTge6zWNdhdDzHAz8+L/dYFSQi4c?=
 =?us-ascii?Q?8ojyHhbq+FTr0RgVcy+G1+E/Aws89kg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe05b0a-0515-4aa5-0957-08de734f78de
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 02:50:30.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81GnQl0Pq4HneoM1Qy7lgBSUvfQ+jAEQC2n5mp07sLjJlZtOSjh+/kNlIP7uFDzAHbJwqgx/SI6dPkFptmVw592MQcKEpA5BFCUBceA4etg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7110
X-OriginatorOrg: intel.com

On Mon, Feb 23, 2026 at 02:26:32PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for type2 support, move structs and functions needed by
> external type2 drivers. Differentiate between public and private data to
> be preserved by type2 drivers.

I would have enjoyed a mention in the commit log of what was needed.
When I saw struct cxl_dpa_perf, struct cxl_dpa_partition,
CXL_NR_PARTITIONS_MAX, enum cxl_partition_mode, it wasn't so clear
why those were needed (as opposed to the cxl_dev_state defines)

I was a bit concerned that new cxl/cxl.h had dependencies, so tested
that it compiled all be itself in a completely separate module. 

Tested-by: Alison Schofield <alison.schofield@intel.com>

