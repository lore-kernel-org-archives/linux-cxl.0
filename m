Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD92199223
	for <linux-cxl@vger.kernel.org>; Fri, 31 Jan 2025 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738367669; cv=fail; b=Ygb7D1o6+L+HJqhtiBEvCssB5cOgQaQCe2r2n1UugrO0oFIsN/5aBiXIh/39Gk85x3+L7/Lmilu2anS4KTb9a1YeKj5BhZPDVxit+WOYS9ZqO/LY/WHdmjKjetgy8ykC4OUbu2Jo0EIWXVD8m7GjwBcjnAVCm0dkjvA93hpuOvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738367669; c=relaxed/simple;
	bh=stwEZC6MeRHjbc7Gw6j/TgeBMftOtsEomca93hmLwFM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jk8VY5TFOXWFQj9qCQP3X/SzC+62ivoII0Lff6Kqj5h8GharSImm6/FftyIF5prjJIzIoJ2ULyoCy1mrmZQzzjwk60Oeh/VIQ3ZMGFl9Ko+P6wtuH+q6JDsJKOhob0BPOYLPvlfRzNnfWjjzrmVgXOSg2iQkpSb1jK2rOmRvOjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7veFejt; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7veFejt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738367668; x=1769903668;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=stwEZC6MeRHjbc7Gw6j/TgeBMftOtsEomca93hmLwFM=;
  b=M7veFejtUgxYWT1zw8EI3kS7COt4ukrQQnlh0oCZ25cx4N6xHnr0tHyH
   75VGV3DcGimaqt7/BVfv4qWHC3r0mqpbHDaC8GpgdOnTx/82A1SAQkZWR
   gGEWjGCmoa+mojZiifRJ2/uxyDPlP8Dbz1WGqGF0C/clnpUAM6aC3Z3vU
   yzLzTXZSR6D0KaSinokMUVxWjn275rfuvoVHpWPaotViWZ99LFTxUnAzM
   o+RU/NpoBH6oKgB9LLh8HaDOeU9kzTlo5bjCZO2hfR580x5Z/FwcDL0cg
   nu8/1bEQiIEbiIMm80ZhRW2jg5Sr+ZlZwFtGTwVMaQCa4pRVl8FgB0NYe
   g==;
X-CSE-ConnectionGUID: Gj+zhXy8T9iT+s2O+ySElw==
X-CSE-MsgGUID: wwJ/79qWROmnqQRQzGfALw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50363822"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50363822"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 15:54:27 -0800
X-CSE-ConnectionGUID: +jt/iXhJSvOONkx/6xGNBw==
X-CSE-MsgGUID: 3RmOUMT7SyKu4tbJiLuHHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133017145"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2025 15:54:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 31 Jan 2025 15:54:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 31 Jan 2025 15:54:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 31 Jan 2025 15:54:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/xVb2+oK1YpursO+mFm5exmAS9ICmSxqar+olTTKjUCjWvdJRRZmSoM3xU1WZrkvizzrbQeKNSobaY8yg97HRpA5cB2GFDN6DwKhy1lhUwOopzNszq8PZikUT0Ea2oZF04qcW9ZV+kOFD/V4H2rS6JAXpoc/oia0ld3GUUpHcRrU+oWC5vQG5fDAG9ZoDj4cRJdolNfYF9eCW/k4l25NdG1xPS/jQUSsihft6wgJO4iR96GVOoI2gSpLwTRKyr0gv747Kf5w+Dm3sDiMP8FF5iIjn+JoB9b66Qe+mZWGUQV5X3K8b8vN4Al9mNOl694GJx8tsM+GVKudw3TrFvFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhaTDOjx16hQtnzS4Mf2YQ+T6Gcr1ev++1kvtNXeqX0=;
 b=G2VRyunDhYS0fgJ7igyxdFhSuacLguXcNiMDF5Y3QYaFtv1ON4Z1On+49fzQ88STasxrv2j1leoICQTmR1du1Y/kj/PjVKadlsCoVkNQu0B5pEiiNe3G/OzE9VUFBSVQQyHoPItVyyPVaj8WDShg7jZyHmSDz+t9d6tVZoZNdb2QaLt80TcpRUfL1YywehEHDYq+IytnFsYRKLIhezeLMH5CbsBMOmVxVb0Axuuqg/7+RzFyFH1iOb/7v/STW88P7DDOATsT0ZCoXlCCamk4cPsUa3PjXJlVgDNu/pRg8ADqmcJTiRijFeGoytTEfmGAP4XjHW3ewAn5X3heoPDgFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6381.namprd11.prod.outlook.com (2603:10b6:8:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 23:54:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 23:54:24 +0000
Date: Fri, 31 Jan 2025 15:54:22 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <679d62ae30f0_2d2c29475@dwillia2-xfh.jf.intel.com.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
 <20250117105254.00001dd4@huawei.com>
 <678aa0381324e_20fa2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <30ba3e11-0ba7-6bc6-38ac-1ba0c577f651@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <30ba3e11-0ba7-6bc6-38ac-1ba0c577f651@amd.com>
X-ClientProxiedBy: MW4PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:303:6b::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: b2683ab7-8faf-4436-2d98-08dd425296d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Eb4lWrFGb/PlxCjvLilEvG4Q7x/Ppfq2bCF22LQWWyEARdS85pLANMfQVdk3?=
 =?us-ascii?Q?zTIFV2yxeg7KScdt87RgFQOj5AgcjPsPQG+s+2WBAOhhhdXJOx0ALvJQvPQI?=
 =?us-ascii?Q?VgPOxNr3tnxyMvtuu9aQ45o7yUDSQMitq7aFliJAnAvzcnSQZnTHkLWYIREx?=
 =?us-ascii?Q?V9CgwBADbldSPUn14thQa3kXqeyr8M6snupmz9r5OQaceapN3PbdDwZt2loN?=
 =?us-ascii?Q?oAFS+7l+MsVlPxCdfRHu6qlbdSY7otZj73TdYsB/yWA4qJt42vz6sm6brzCH?=
 =?us-ascii?Q?R6CxcrH55c3620Y5Ng2idwnxlIwVyrRTZcaNe7DmoQm1pudf/QPcFdqMPT2b?=
 =?us-ascii?Q?E2eWVqL5dg4R7KzQKwwmBh84Vu4Cjr/UHYKyyx8Nzb35gy7UU3PK/I1Oxb9z?=
 =?us-ascii?Q?TR+EFVXHrXaE231RlU9DUWhDo4DfhgDJjH+Levqo1zLrUhR5r9cCEonrlRvv?=
 =?us-ascii?Q?YpMmbU9zFEYDVC14YsZLVPfMjoFcaezmCGpg900MpehGOms36J6Ul3piFz6L?=
 =?us-ascii?Q?T6M6LOqAYphbQdvTxaDn9gACSQJo6eW2bxRoWEf2ugh8Asj/ccpdxN6tUcnc?=
 =?us-ascii?Q?of3ikbB5Rs6ptb9JwyOM9QEBKOnh1FoZcJ+gHRNHvuthFP5dR3UhwaTMf4wW?=
 =?us-ascii?Q?RzUkPzk3AY7PqEnMR9X7My79v6QRiIbqr6bfuPPyLyxFtq9v31l52cJLtAZ0?=
 =?us-ascii?Q?MXq6ZM1Eqe+N9/2QHSHwvp6dfcxh0yUINxR/o3plxK3dXIZ8Nvp1siy+UnpT?=
 =?us-ascii?Q?k02HB4nefCLbFiz/RpSDt62CFOcIOIGBpiFUdLtWqvGd8npkgm2Kl7kYAvg0?=
 =?us-ascii?Q?BKUHRCp07FTGDvpWZxtqsoHua/jhUwjooC7y3DdcmKWe9I2QUBFcG7QpZTfT?=
 =?us-ascii?Q?nS22/sCjDT8PbJN9gwsimiR1TeXhuFHos5gFWrvIPDiFhEAgLJlySzQ5UOOv?=
 =?us-ascii?Q?/0zK2yb0oaDp9sqvatQNzmibfrbeE3D62cHdq1PYy0aCgXuRoSZ7MP1ertzk?=
 =?us-ascii?Q?vGxZm2cHs0Ngu1zapZhN/XoqwOnmnSjXYS4xX5rFE7ie3l1fsyvqHwxOY2ol?=
 =?us-ascii?Q?lMJiEdIYcFJpVEb/5Tpqnrh7YY2dEb/T+FH+ic8AUzs3AMSvlDaa0v0rbABK?=
 =?us-ascii?Q?0AMHpBeBjaMr85ncx4cGthYFQIccyaG4XBapkY8Qmv/fxpjIWvIDxTwP8O67?=
 =?us-ascii?Q?dLT6+Z5sPk22kW8gyV3C/j9MeqJPSedF1aCcL+Dlu+mjr45wOcobipWZEvUq?=
 =?us-ascii?Q?IheD7hIE7damR1CUtgqtwYq1yRbpLv/Qny/BeatEhiLih8wtChiwekh3As40?=
 =?us-ascii?Q?cUdwM4uZoUQqJKBcip+9YKszNkqztIgpbzxY/4Yuy/cqOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?adV1l+Ecvyqp/dFBfM83IIUgSqGPcTFVyG4TUognQS3WdDTeQW75uEL2FKPf?=
 =?us-ascii?Q?ZoTi2YHEcxIGRsdcLDr7Y6DZgVgei7vopt/hFYy2AuLfhbIlCSb0OjSH7ssy?=
 =?us-ascii?Q?vY4+bHv7eE8yhy3lrgvNJM8BtsC2DFlGKkjILdcnv7LtGU8GEh82m6avUIYL?=
 =?us-ascii?Q?GFkczjJHsp3OmpUzOAg3DrRlrbzPZDWCA+ruxoAJsLQ7ZJU8J9j9nlsAyEpC?=
 =?us-ascii?Q?2re+0IGToSwNvDBRo1XGyDhZXWDwG2v+A282AXmVXoDLLEto86tZrrs6K/pg?=
 =?us-ascii?Q?paSPY+UgaiK3/nGbA3koduxq8+iKyVAdpsHMGtMhIhvuXs4kStzvs29URtE4?=
 =?us-ascii?Q?gQlBltPhAf1HAGEjKVz6ANLx2N5Rf00pjkxkn6BZy6cq7sKW17VHhIn7v6Ff?=
 =?us-ascii?Q?x4teTEV8rD7LGzBZFBlZBoXFV1HQlCEY4/cvXDqCewMZgOd3h2YV32a1HjhT?=
 =?us-ascii?Q?anRv4gjSNlLqlFuHoyXqGXpLtqPIRsWo16XdWmO4RMK5i1iQwxmivCr73WGW?=
 =?us-ascii?Q?12CFVxseHhyXVAp+enBEAH0f7jyjFwcGxhXfO/s/avopDasJQImd4HJQFnyJ?=
 =?us-ascii?Q?iZ/U35ZtIV2LUvyf8Ug235MuDZV5HC8iGLSd+2YawtwFmrLiGsqbT7Sr0Tlg?=
 =?us-ascii?Q?kHUR3f2cH2DYZ91dqywU2ARxVj0nfTPhnBdGe0Ws4dAUrZ/Go39gJ9PCRaAN?=
 =?us-ascii?Q?J08QULrDtsCo0tRDZc/gVjbUpyL2WkgsqbFucHH6dFHERChLlvxB75rxwA9r?=
 =?us-ascii?Q?gv+Wk0NRSIj9pE+dyLgzyRomxSqqUUzJ+YzfSt35WYFSnltvMaxQ1wvCZKw+?=
 =?us-ascii?Q?+kLIR3n3Qs0p0PeaMsY1K3oUWoBseeEfcRziNKL0jejVWWWE7tmX5kG0R5HR?=
 =?us-ascii?Q?sQV+IeQFfZYCbIxWG7MvLY4TbsoI8tk3mYX209RqEYzP6MJI4KIxfXk79MDT?=
 =?us-ascii?Q?YD4jkEqZcteMS4U/UwyBhG2z6sBPL2tb01skxiMiBHeJkvmP98rwCyUUdWUV?=
 =?us-ascii?Q?k2HC99II8sEFx2Bp5ar5Ev5MaVpXwuoZ4as4LWD7oTXXdx3jMIjA3kResrt6?=
 =?us-ascii?Q?031Y4/6/R1MJTJXdjf9Y29Vus9egU59Vy3mIykt5he/YvgFV4c3DC1xlQH9O?=
 =?us-ascii?Q?voAWj77IG35QHy0myzM1MmBLy1MFMyekGqLYKx3D4xgX+nbzKZPqc+hBBiyy?=
 =?us-ascii?Q?+G2yqAR/QX/cimmZsXjF0eOeaGhuLyzE9dT2EdDGuLb36cjzYE7oK+a+q4fa?=
 =?us-ascii?Q?EUVKwfdhar1Im/yWjqJwclg13fR7RzHlsZMXA9Isgfntq+mwce3ffdRy3Ck+?=
 =?us-ascii?Q?WtvTwmrOZCCV3GKvMOdiPys90Aj6ykFaa6oPQewq+mJ6mEvRDBk/A3T6v+ko?=
 =?us-ascii?Q?pF/hMsw6eSObdrdx2NuDhqAmcG5xqvQvbJjLwzVeXgtoMmnQRe155a9uZEfn?=
 =?us-ascii?Q?Q42v6rwFb5HxkeqUeE64Asn4VTgwPZfjHa5IYUk/CeVdqu89orEHUe7Z7MXP?=
 =?us-ascii?Q?YSFltnaIY2RrQVEHTZ5N6JLLcYH2NbMRgEqT/rE6LFdWS19KqfoqOG7YzJvY?=
 =?us-ascii?Q?cu1OW7Tk9PwSSP55HC6AgFvn/m9TINStispuZsYx0bxWaPJT/ae+Iweqyn1y?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2683ab7-8faf-4436-2d98-08dd425296d3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 23:54:24.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT7w4WvBGQOc1UOYmfCKcR0ed9pP8tVYJCnSe1F05ZxdEY8Jt/KytZEgWrHVoHR2CY2fH6cm7oM0RHRQEoUlHwVECuEVm8V2PXNZpR6ZbTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6381
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/17/25 18:23, Dan Williams wrote:
> > Jonathan Cameron wrote:
> >> On Thu, 16 Jan 2025 22:10:44 -0800
> >> Dan Williams <dan.j.williams@intel.com> wrote:
> >>
> >>> The pending efforts to add CXL Accelerator (type-2) device [1], and
> >>> Dynamic Capacity (DCD) support [2], tripped on the
> >>> no-longer-fit-for-purpose design in the CXL subsystem for tracking
> >>> device-physical-address (DPA) metadata. Trip hazards include:
> >>>
> >>> - CXL Memory Devices need to consider a PMEM partition, but Accelerator
> >>>    devices with CXL.mem likely do not in the common case.
> >>>
> >>> - CXL Memory Devices enumerate DPA through Memory Device mailbox
> >>>    commands like Partition Info, Accelerators devices do not.
> >>>
> >>> - CXL Memory Devices that support DCD support more than 2 partitions.
> >>>    Some of the driver algorithms are awkward to expand to > 2 partition
> >>>    cases.
> >>>
> >>> - DPA performance data is a general capability that can be shared with
> >>>    accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
> >>>    suitable.
> >>>
> >>> - 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
> >>>    memory property, it should be phased in favor of a partition id and
> >>>    the memory property comes from the partition info.
> >>>
> >>> Towards cleaning up those issues and allowing a smoother landing for the
> >>> aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
> >>> array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
> >>> way for Memory Devices and Accelerators to initialize the DPA information
> >>> in 'struct cxl_dev_state'.
> >>>
> >>> For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
> >>> get the new data structure initialized, and cleanup some qos_class init.
> >>> Follow on patches will go further to use the new data structure to
> >>> cleanup algorithms that are better suited to loop over all possible
> >>> partitions.
> >>>
> >>> cxl_dpa_setup() follows the locking expectations of mutating the device
> >>> DPA map, and is suitable for Accelerator drivers to use. Accelerators
> >>> likely only have one hardcoded 'ram' partition to convey to the
> >>> cxl_core.
> >>>
> >>> Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
> >>> Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
> >>> Cc: Dave Jiang <dave.jiang@intel.com>
> >>> Cc: Alejandro Lucero <alucerop@amd.com>
> >>> Cc: Ira Weiny <ira.weiny@intel.com>
> >>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >> Hi Dan,
> >>
> >> In basic form this seems fine, but I find the nr_paritions variable usage very
> >> counter intuitive.  It's just how many we configured not how many there
> >> are, potentially with 0 size (so not a partition).  I'd be happier if we
> >> can avoid that by just prefilling the lot with zero size and filling in
> >> the ones we want.  So zero size means doesn't exist and use an iterator where
> >> appropriate to skip the zero size ones.
> > The PMEM-only device case did give me pause. Is that 2 partitions with a
> > zero-sized first partition, or is that just 1 partition?
> 
> 
> I was wrong about the code being broken for this case.
> 
> The code would create two partitions, at least for the case of partition 
> alignment being 0, with the first one having 0 size.

That was the feedback from Jonathan from v1 => v2. Drop zero-size
partitions from the tracking.

> This is all based on data/code based on mbox commands. Without mbox this 
> partition info needs to be hardcoded or created somehow by the accel 
> driver by its own means, so it is good to know the code expects such a 
> 0-size partition for the pmem-only case and the nr_partitions should be 
> set accordingly. Not what my type2 patchset needs now, but I bet this 
> will need to be set properly by a coming accel driver.

An accelerator does not need to worry about passing in a 0-sized pmem
partition, it can just register the one DPA range that it cares about.
nr_partitions means that the partittion array has entry
[0]..[nr_partitions-1] filled with non-zero data, each with a distinct
operation mode, and in contiguous order starting from zero.

The only place Ira and I identified where this potentially runs into
trouble is if a device places a gap between partitions, or if we want to
skip over "shared" capacity in the first round of DCD support. Might
just need to mandate that userspace skip over "shared" capacity for now.
