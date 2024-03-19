Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E92D051
	for <linux-cxl@vger.kernel.org>; Tue, 19 Mar 2024 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872744; cv=fail; b=HzUX6TSIgWux95FTF2DF09xupHzmvmg+Uc47wkZ7gyUL6WW2tZNKX5Cq5Xes0a8LudDFWNnNMGvvY6E2NVBgcY0yZz/s4eAIYyCHWqE1M/Y1Bh30t0CDBcYZsYYYqlBvNK9WGis+vMznCIlTsOZLUfYjfAc7rMsdteNPkFM3UPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872744; c=relaxed/simple;
	bh=whvVu+LdFuCMsrTGhNQ/VB0hkc0GVrWj5XJUwAYOtao=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nsqyu0TQ+5YRyddBs2871XhSNJVypnq8VWv9jyFo1uOqICe28tdUD7fl5Mi5pmjyqTA83jBiQ5IOT7qcYTmHAkdMvcbkDs+uvSH2vjyo+hVIWBjAFuSXtXj78oUCIrUOsWdhNHsY3TszyHBf2TVy8Dk9GyWcWh8Pn5quYDqq7Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vqrjyec8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vqrjyec8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710872742; x=1742408742;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=whvVu+LdFuCMsrTGhNQ/VB0hkc0GVrWj5XJUwAYOtao=;
  b=Vqrjyec8t2lHU97F9YMviSI7kR7yNI3MVi5mJOHVVQbBOEgMCAl9onuB
   G+O2dstcfLxcAbB6hf7b0IVCt8ntZhG5galViV8tcnX3v4L7q9tlV9mLx
   R0hPSp9a9P78btsY7d+vWDbNAUHLIHdj8hJ2aXsbTCSv6SjNApJX7mIfY
   Wfk6XSortAPWSwxcBsSu567J0SWJiDhNTcEr0yTd2Nq050TN6vxhLrXc/
   vxXJ7Z5LsoLeIl7Fr1AL694SGVB0ktRZbAlhbnHwXqckgSa4qr52DYrh6
   AQWLnm1K5rmqltuMN4vYYQN54gpKSAguMloQy5NnFb59RHgcnzDbZTawT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23269118"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="23269118"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 11:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="13792690"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 11:25:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 11:25:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 11:25:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 11:25:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 11:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne2wm9phqHN3rKZ1nx1SK/AQRE6QIn5hMjaB5Qpcw9YBXctfOQL8UPkaVSrBvJPspSjiumLdYWFhzAFvLOctMDWE9CR0zx3zrSwExjH1h446VMWLM6msAIGyVsLoz4jc+hDQM1/x1Z3gDTbpK0q2h3P6yfrd2aFTHNTdnL0DVYcs6hQ1Guxf+Owuezt1C8q1LVKG+wD9hsmzheR5m2TaFg0DQwBJQ0KGI3EIqU/Tc1d+FNPsrZXKox3s/CawcrSe5OKVaU7DNbtZSgVu0efN44aMd9JlrwjKOMC0RwXunxTa467nPuDSpFIbw0J9lkYD9FaxSyyWKkNxQZKn5HAyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gI4eoMbDtIBHVsUOqUS/2EEvziPQ6Ir9rq9tMPOZzU=;
 b=eaO61WDLZ58/dlCuY+wSqXMwhAslYH2eoSqExjLRVz0ke8P+gSCQUgg0pDZWOULy6wd2q/MXIvMjn0ldbOF2bmn38t0/PLedLSR5XCSuF07MHoQVyqKvfBpWn5rIlIZS0hVNTSwdY4DYYxwk8lyEvXVCTZ2AIsI0UJmogxTJKStNrEWZh7i+aCnC5Ma/Euu0W1poLUSrwKWxf6KZwXiH+xr88kiK/HjyPCQMZXLhUgRyfMuRCRcBIMV9yuDTYVNlDPFD/1bkWDJrGbadpGEfjTIP2ZLgxBvue/74NYRAS+CXBb1uH0rQ0xxUZkjrl/eJh8W1c2m/H1MQCiHn6YFqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 18:25:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 18:25:36 +0000
Date: Tue, 19 Mar 2024 11:25:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH] cxl/core/regs: Fix usage of map->reg_type in
 cxl_decode_regblock() before assigned
Message-ID: <65f9d89db59c9_7702a29480@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240319181508.690837-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240319181508.690837-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:907:1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b9095d-a9cb-47a0-bc50-08dc4841f87c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6c7JtZ9RWcf4PNFAAM15Em0x8N4EmmqnD9Qh9BtiPXtH+J2qN6Gb8Rjw22ItS+swzzC4ksmvAei6ubakD42RcQcWhZ6XrY2a/7UB/zUVmYgx2xbtU3p/eMJcMNvL0x3psLDn+bBxRAAgmyWQR8x7KugWfCFkwOXn6mpwY732xKe9H39u7E9x9gxrYsWUB+U7N31pAmxwD01qcha8XhXKtUXp/+3+6JxSRHJ6F65B4ROGKywhffZ1NcbEsyfBkkYSoanBMS0FBu/RvEosWT9ilzVRrWsvBP+L0VcfqQbAOV2VogqCRdDKasOYX3qJfY1OI8eE880CRRbQ/qf5hBMnFhYJdZN918Nz/R6yaC/eDHXQqrHs9dA0CoP34XBnl5BUnxzvjdvySS2irtPoPk4aA2L4Kaz9/SxO/40bkX419WZS5OFZ3ox7WjWriJ4usyl89PhWYLIYryh4YqXLpusVfkW4V/i7Hyc/BluAwFvSI+QIkLxCcKi0Wd4yqYlBSGk1+tKMydJc2JQeycLOLBuikf8Dp0gMbwDHgYFH9Hu6zumQV+xw8inOl7qLFQIPNKxn8LAoeqGaXkn7a296AEmvQK9x8QgS9yDJyYtgCR0qv8ZCppbUigjJg6CiPuWai1NNqI1NCRqygBGnQ1Z2tVB9Jvbvm7uBOimXlRGPRCQWZBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7qaxamY3uYcz8JIYXS+aoQr+FbdkkKNFEJybWAc/2uK7x/1ww4TzKzNhN2JN?=
 =?us-ascii?Q?iIouEaNjcKi5QM+TfGVWDNSLeL5gW8VhbLnZzRoboOIndd48dVwdCdBsMap/?=
 =?us-ascii?Q?LT84wnDabuAVLm6nGeb3qbIFXRCUlXzsWhCSblCouh2iXh4VDE9AQ7G1ZhIC?=
 =?us-ascii?Q?FANDwiVL+8VoXEVR1s+a9kSVswoVN6a25lIyqQYIwoF8tw4H8YrlVQAKdrOk?=
 =?us-ascii?Q?WtV3uk11+1fdcvdg5M943akKkdtKfKD9KhJyxH/GMXR3soPMlfYNhkIWlQiA?=
 =?us-ascii?Q?YH4OyDKIJpVKM7vWC0NiYo8lIQzkCr+PhOS3OiRRZRXANwAIvthS/Y6ILvtB?=
 =?us-ascii?Q?I6mOnti9zrdgviIT2d7KuHwlOHBr5g5zE6v6Rw9215fWNvuA8J/q9xAtqJIX?=
 =?us-ascii?Q?YjBojR79kBs8DfGszT1o4XnU36dT8uDYjrZuJYE8eSitiMYBjZFvDBJMqYIj?=
 =?us-ascii?Q?Djwpy3kPO1W+VKa3eRKm0YhkgPrAVLurGB2OS/iuGPBdNbIO+cRPyV+KK2Tp?=
 =?us-ascii?Q?d3n6z3/Sou+ePuseLKA15w8vj1/lY4te4V+G3S964nKd2uvXb7TZI+AMJnVk?=
 =?us-ascii?Q?i+Rsn0QHVxEkR07Bd6GXAogIgauqVhYeYAeB+SkzQoONMUjzDIzlnMmKHjn2?=
 =?us-ascii?Q?RYSLMdb4xFQ7xXSzdOc0PSr/+0T+bMzsZV4HpOn0prigBEjL/v7WmGJthRQW?=
 =?us-ascii?Q?NBYCugAWXe3diCBhfBtTjRIotFp6xtpYnNBTUfP/KPIyo15jjzkyMl8+SWA3?=
 =?us-ascii?Q?M86zIasxuolUKHyE84huyHBZWiOYpxy/RteHWKZl1YFfhRnImanGbTfLHEb8?=
 =?us-ascii?Q?C7JYkrXCiUODDSij6ftPjc71UYbRt6K7iW+fjPw5XNheHCRsN6jNKmHR7Oe1?=
 =?us-ascii?Q?IIMNlB1eaWcaQP8ZIZHBCxjYL4lVDHfXA/GuXmIS7PynFJYsfMTg/Rzl1wKg?=
 =?us-ascii?Q?VVMO8N9dSKMIejZB4PBH0xvZqEVj6ip/8oa7ZU5ztfPd5ETGwrBYtgbK7D2g?=
 =?us-ascii?Q?AMkVQ9/ojTt8zkI3NZzPVuYE0hRfK44OfweExdi62H4UBwPWqMTBdNiyFbav?=
 =?us-ascii?Q?XTEmMVVgJ1DqG0SQo1Qf4CCpHNqFO3/JOWlTu/DGLEKumcMk/0j15VIyIXAO?=
 =?us-ascii?Q?tNDO5HQqTCrO+pX8Xy4QlNhNuAlaOL8dnLPGVfS3fv7XBPdEQyZcr8Im9uMm?=
 =?us-ascii?Q?A8rmLPWo6dKQNWsuvMxBa6C17pOsZCV+2OC9Aa0RwhU5laoan9ada9T4XR1K?=
 =?us-ascii?Q?FVhP5Kx8GUjgblHaPqLDwGiwzQYBdivojHQGTKXlm+aktMTKVZPLEeI2jmfe?=
 =?us-ascii?Q?ZmEpV+foLj+MuywZWkbg3eV6aqXA7iVZd8tgFvSQ5jV/PGckURBMA0CXNT3v?=
 =?us-ascii?Q?nrAHCPhrrjOqghLp9DAsusBkLaegkQP2E9EYGnsNlSvB4IHT0tinRjQaovxf?=
 =?us-ascii?Q?ediBpuAQvu8YU5of1JSAsD3lHsezQLYZvnO5FyIiuLJ5kyDRkjXKG9Gc5FD8?=
 =?us-ascii?Q?nUK2xynPix+vg/90mXcTtk8uXi7ySqx9TIKEx9Ii9AGEchM+QI1ZrTD27imM?=
 =?us-ascii?Q?PAKdVEjL7B8817ATmUPkL3r/mRNNkHr2fAMLBdTamRuKN365XU7CPqjukoxZ?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b9095d-a9cb-47a0-bc50-08dc4841f87c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:25:36.0225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJxv22MQbXXkuscbEGt23pSBwHZR6s/L8VueleEm+0ObS2QwP9JM5SYeRyjdPlxBEA8WSBgLTyoT2Fg8TFxddcptThywuvrUJLDlL/RWxAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4882
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> In the error path, map->reg_type is being used for kernel warning
> before its value is setup. Found by code inspection. Exposure to
> user is wrong reg_type being emitted via kernel log. Use a local
> var for reg_type and retrieve value for usage.
> 
> Fixes: 6c7f4f1e51c2 ("cxl/core/regs: Make cxl_map_{component, device}_regs() device generic")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks good to me,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I also agree with not needing to flag -stable, the impact of this likely
to never trigger bug is just an incorrect print.
