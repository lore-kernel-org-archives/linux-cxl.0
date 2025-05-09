Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0466237186;
	Fri,  9 May 2025 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808401; cv=fail; b=H5ZJP9x0JHC/0B/6PcxZ0lzA2USbpToXEmq0xZnGYgdIAUD21jK58P/Tm9g0i2hK92FzlkMXSoHAK7kBR5UNjVLpzifxN1v0vAhXm7O+aaA+NR1lyu1ZBf1TK7B8IXOa1yZTbtxLnHJcL+6m3gs4eBzov/cV2Liz6AiASrOe640=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808401; c=relaxed/simple;
	bh=Oe+qtByctAADRJGqJij9l75NmseAND4RMVH/afaQN0U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QIFl+yqRS4m4Kh0tABHQcPQN0eIXQseWCI+xkyHuYRqvz92boqoAtmNTxHuGzJ3KjpvbS1GlGN3bCyyT9Om8WhX8ZtoPb3acDSNQygl+QLLgb+aoQPUAlHx+hhMSX05EQFy798L94GjcgizbvMrTvNSl0zaG+KYfTbHsY7sNcuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxEyZR4D; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxEyZR4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746808400; x=1778344400;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Oe+qtByctAADRJGqJij9l75NmseAND4RMVH/afaQN0U=;
  b=DxEyZR4DEWUlHTJ9Hl5LEdh+hgtQ9BKr4DpzgsetizoxCaNY6pQeHTqF
   4c1yCq7gY4EuhZw9m5jWktH+QvinV9n7fSGvjL5mWr0TLw5l88PzM81Am
   9dbvMBtPgDbbfTeoWhHaflAm6b0G5ez3HN4rVS5M2LQLJXnk+H8ahJ+ne
   vUX/jbLMtJIdZ+Azqh/AB3/lbLwUajt3XDGydYw61vmXBrLzz5pTvkZrL
   wfkb6Crt9BIPaW9B1Fk1arLjQYhXXZfdNDo6rabBLDRdH23jV+WasY3xR
   /okPG14eNK3xZL6lsLFOrBk+V306LPKRl+3ElNF8isEOsqxdq36w3TAsL
   Q==;
X-CSE-ConnectionGUID: Fp/tA45oTDKvsbIaSN5AQg==
X-CSE-MsgGUID: v6Ng064BSGGlj3QgfmLLkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="51303680"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="51303680"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 09:33:19 -0700
X-CSE-ConnectionGUID: Mc64XjUjRRiB7a/uXgZOXA==
X-CSE-MsgGUID: kAm+8NAZRLqDkDZPVzt5Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="137172777"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 09:33:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 09:33:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 09:33:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 09:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/G1cXOz/0sGigtFOuT/3ZZuHQauWDlaYPg6VWoj7rK7ld2aHrtrZeY1xnlld6+bUgmuVkI1CHSB7NGbq4VZAc83lFJAUC19qW63ukRbpe4nhTsJSR446ZcG334zag3L5DFSS+WW4gFciCBwkqDDTQCT2NphlWavsChENFufKLDwS/7wohu5I+b2ZQvywJTIuzwGv05djY4Zjct9LVXJ1y8lx+0nTuQ7SQti8bTFbalUJ5hoWitBY7kdde1E9H4cEEKrNFNTYGC1JuLcFHuqOpD5mTL4eebhAuWrYVW822YSwZprnhdRdcSHp9KsQMvRug/5xsw+EwZ6LqczvYSLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1/zCw76k42Z3q2pq5iuoZ6z+GxysnVe6YcRM9VNnWI=;
 b=XkIqxNKQHT4rLjsiaZO9CQVzY+y/+bS5NfcZeH3aUHMSssg4AvVhIg/x5Iio3Bzy5UxIVCEFlkzZLZzePG23GQAOcLhHJYTXNjnVvqnN/iSzuE79jm/reh7n0GlCW9s+tVljer2CIpC1Jw1SSFVH+7hoPqLHEWj0BBMsyAEP9EBShjhDmrVf7/+rtgss8gCgk91FQ4oPFVlEUexceNEcZbLkR6bLf95h1EwOaVRrz9LBciiHD7kX3qSMTJAWwqg5M0/oKpivKDDMpuo463DT3Qs+5sLfiFv0yz/in31K5xgp54u+NAxbLpThqMmbaN8HGgP7IMtlMnqYbMU8oJuw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7761.namprd11.prod.outlook.com (2603:10b6:610:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 16:32:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 16:32:48 +0000
Date: Fri, 9 May 2025 09:32:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v6 00/14] cxl: Address translation support, part 1:
 Cleanups and refactoring
Message-ID: <681e2e2dd78d4_27eca029482@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250509150700.2817697-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250509150700.2817697-1-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8599fe-2e89-401f-481d-08dd8f172286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UbMoo39qwrGddzP95DnRsXlA11Qdp/wyE3NxDKWE7K1MQkC6NCsH+Ee1H30R?=
 =?us-ascii?Q?TRtyADXgeOJ7rT/oZAIpGN3tU8zi54AP5VwbMehWwCPuTJkZrtMTsopFKTfH?=
 =?us-ascii?Q?afRzuLjEUEsEr4q/0xvE18kpJtwaaTAj3k31XMpkEpQXGfLwmV2K3MfSjVUO?=
 =?us-ascii?Q?HoXyGKVLYviKRMT0c1pbf/XaiBu8VwGDBr5xk1i5c2o5t1YtqBqHLHdFlD8i?=
 =?us-ascii?Q?ilYloEq1ZrlliauXdvS4dTE7DYbO89pShg+Me9yD3auG7aoSX5Ae09wuPziP?=
 =?us-ascii?Q?a/fY8svD9tYFQ3kWX0xO3AhbEWD6ZagcE6EClIxAAkv6J5VUFEAkQ/mfpvNC?=
 =?us-ascii?Q?rZDubvqfMNnszjwmZzE0a5BwtR1hfOMv1+9Yl2hpLvk5ZXPsFYSANeoCxV3l?=
 =?us-ascii?Q?JS2dO6XacxkXV/rZW98P/aV8QdtWl5aXBI3t44ls9ImQOOwJwafL0DcL0ghQ?=
 =?us-ascii?Q?zaab59r8wSjPVSLWt7l/9D+VGOb5d5PBGLI91Xpawpf8qKIOMZgSp98aMc8p?=
 =?us-ascii?Q?3fVQwtzGF/HsH9C+uM1D4EWduIc/vRGH1fDlQgw1rw1rGN+fG4/yQob2IKLp?=
 =?us-ascii?Q?EWncNcyvJxY1V7Gs01UOHnS0p86ECXN3ivUO9qrcrhJilsUhhP3q+ZZspm4T?=
 =?us-ascii?Q?bwkNJ8QZAD1jmy5Qq+nduI8VxqGVfi8EFQwmLXDTXS3H3uzS4EgXaJI1cPTa?=
 =?us-ascii?Q?f3ppKDWEQnKmHmZLCef7JudrMZyOkllGkXHYUlTFYvxkG/mBAoszXYDMP4cB?=
 =?us-ascii?Q?qRJE0CI0gw7xgnBjKMUscKKs3U5DFyyu3umnRZYV0VsYCnXxcIhEBIXLZ9TN?=
 =?us-ascii?Q?W/oDDfkOssB4Eqq/BHJVj/nU8AiktKaj8z2zuIHYxt+rVE3HJwFFy3s7/6mP?=
 =?us-ascii?Q?SkrKriSWPEyFaXk36ZsY906wECeiIrIMGfTz61EvpL2RQzwf6VtVPHiH4mnE?=
 =?us-ascii?Q?OolTlCo0lnkLIGKuK8UlaDlpnD8QQnNjeZvSqwtCp/QbFGFdu+7RErgdK5hf?=
 =?us-ascii?Q?7GOWyy4cXgAlu/QmkMSLeikyFzn0kw2NsG/BFNbpY/cmRGEkynqgxuDq9T5m?=
 =?us-ascii?Q?oxuIRUwoZZDSHd+qpLUnRZjSybWnehR+PftzUE6b+Mih/HCwmzbu5bImJcta?=
 =?us-ascii?Q?lY/tvf8oCtbYbLyMfoja59M4czh4f1fbLdlagHj1IJlh4rQKkhxVKSY7Xp+m?=
 =?us-ascii?Q?JinitSzZ3LLWxTiQopaKi5nFWg8lel74YzQn2GWESM/QRZ3/Urj3UoEMfDJe?=
 =?us-ascii?Q?Upc4yvYr2ObuF7AxZJ8gGZ6eNFTlVp6Fv1OWUGghGPXVpws/p6BVnJjheH1k?=
 =?us-ascii?Q?Un1hWvYsXqqv0Ka4fODg931hwck3LyPy/5uOZEGSz5ZoFBCO3T18Jr64CRZH?=
 =?us-ascii?Q?qcYuGa4o97xC0jarR71wu3qQEgHc1hk4hkEctAxSVH6BkdDlKdofxB9wU0Sj?=
 =?us-ascii?Q?F1JH7mEmuJA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6YoeIN23ieeMwzFY540whlAadNB3NTZw0KeK3kQdbwQW3krfvZmKhvcQCt5n?=
 =?us-ascii?Q?4jtQ67dQBmnqIlsGPeoDqVUelkomYMOIE3mC4cDEBovpwmSv3/mvMoJiQVR3?=
 =?us-ascii?Q?DpNGKuei2fVtYbnkVHOgHnW8a50vMmt16kVrk6NIFFUTwU/1ZA4WwhtTCo5p?=
 =?us-ascii?Q?01QiJchwI2xu7Gr7rRZd5G0j1ycuMm39NqvUe6o9t3TfoQ+8+5rJNRLyluf0?=
 =?us-ascii?Q?lc+NDIRbz3uaVJoCj8tPF0DYfkA5NhfZe9J6kfHQfrU135XNxwbQqHCIDdB5?=
 =?us-ascii?Q?J7bJBd4sguXEyCGULWfYeea8C1VHXlXHjaNTZ5rv5uA/Dynnzf3s942oYTBN?=
 =?us-ascii?Q?cyaOQf6yqXkcyMOJs52/a5OSmf0QlE7sr3H7Xi5n9Uy/g66jpCrgRTtiCl16?=
 =?us-ascii?Q?ma3A6K9FRsnNC6aXPFhDszHd78tvDYHrMPDOWbQLlLC95mclL9AYED6Ch5uu?=
 =?us-ascii?Q?STqxM+tKcAo8tAdQDViaPWn2LUaLDZIYYIl1th77F4w3G4c5CWQfpuWbo/7x?=
 =?us-ascii?Q?sD83xMn8F3EwEP9GJijQ+nqpFDYTpQwp8ZFvhtmXXrMd+j47Sw2rxaEfmB+B?=
 =?us-ascii?Q?B4YFntGoW4MqemUYd8/5Uku+mfxcj6WFEslWRcgxSovNqkdOSe5R3JFDZvF4?=
 =?us-ascii?Q?/mlvE8Wx6DMRofOfkymbsQeAypgUbqDzSwptI0ie65EaIIMgN7sl/e1eQ89u?=
 =?us-ascii?Q?llusurzSo6Xq+R73zWnLDP71eeMKdVOWAmwAxZ4qoGjFPEwmzFY/j1yKuZHp?=
 =?us-ascii?Q?ckn208fTfiT908dErhvPE0Xxk2yxjTMGp5TxEglZiMT0MkP2Q4ngpYc6A0m4?=
 =?us-ascii?Q?EQmkhZ9Ven5tlAUb7nnlltYPhuhZvEk8s5713JtwHFLPpbr/aiLRigHOQ+9X?=
 =?us-ascii?Q?LWUG+rsvOzkLiVv6t9wpYQ5ZA30VGPm6FmUyUYRulNfs5jrlgPU5hu/7FZtB?=
 =?us-ascii?Q?dAhYaQzxHIjNOYmIb+mGn9EvRTic401GisuLt1kTIA0a4JhmxACXXrehaE/0?=
 =?us-ascii?Q?6bYfQY2mjncXznm5wWfJzHu4OikKIA1lUhYZXjaSncnqAZMHOUwhzFO3A5pt?=
 =?us-ascii?Q?MMw58XshemcPN5PLJZRp0wAIcA/SK06vlmQ0bqB6FgjgmkG4gZXW3rPoqSQT?=
 =?us-ascii?Q?cSlSGchrEiG7K6ur8IBIG49/e6zCHztzWqIJ+w1vAFT9N3EnvF1hqorfKA0M?=
 =?us-ascii?Q?yWLUeSQvinsy/OV4eP7vXaMhE/osckHWffCUgpoTfXXJYlrX158v20PVo8n1?=
 =?us-ascii?Q?uNANm1GPeHVwVgqc3vH/l8PYnuif+M1ZNFliJ81auRIauDfAl9iJA12XZI5n?=
 =?us-ascii?Q?utruvbgwCkvNN7vwd2ymLbxw1NN4ThwkjEvJoKdfNjMoSmRE+/uwIqiRdmfA?=
 =?us-ascii?Q?kCf8aAjM8ATsHgrSQTLfd+XRd09L7CjS6GEwCqH/AvWr/o/7UooJzQBmD+ZD?=
 =?us-ascii?Q?0vyNlpUYhwqWrMrf/POmKLBi9+dCh97ygtByrRDXh4oFrzLRZ2EF/nt8q+KX?=
 =?us-ascii?Q?S8O+higqvBIzHGE3a+ca5cDHMm/DMCqD8TWiP8H9yT8Nb9W0zV+0HwoPa6xy?=
 =?us-ascii?Q?o45eJm4FUZQLU/o1tWUqNndwEafg/paIYHr8tWth4/2D1ET+uMQXuAxtcwdE?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8599fe-2e89-401f-481d-08dd8f172286
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 16:32:48.4129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sXFhbHWO8lUkI30EzsP65kxMzYkByF67A/oYk+QmGxz7pVYQopc+FXT6FkI8PEAWidDvZ7uQAJjkZS8DYefWYMNwRSFOboSXrviwtS8N1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7761
X-OriginatorOrg: intel.com

Robert Richter wrote:
> This series is the first part of adding support for CXL address
> translation. It contains cleanup and code refactoring in preparation
> of the actual implementation that will be sent in part 2. Cleanup and
> code refactoring have been split in a separate series to reduce the
> number of patches of the series. Even without address translation on
> top this rework improves esp. the region code, cleans it up,
> simplifies it and adds debugging messages to better analyze region
> creation failures:
> 
[..]
> 
> v6:
>  * added tags to SOB chain,
>  * added more occurences to remove-else-after-return (Alison),
>  * updated description of cxl_port_pick_region_decoder() (Fabio),
[..]

Aside from the "obj __free(...) = NULL" anti-pattern to clean up, for
the series, you can add:

Acked-by: Dan Williams <dan.j.williams@intel.com>
