Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9199C7D096
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218722; cv=fail; b=jZxYlqXh3mT4o9vhsaO1fvmcX/miQvgLrfr9R6kXJURMQBj91aKYYpP3+D85FOZl/Z7FEi1MsVzHUV4Ax86QJ3v5j8utqba9FICkGfzUv5bR12slj6wFwbBZaKnZb/aH7OMiPFHjzdEotAw6Qpk6tB5bFnGlEp7QBm9TuJ876AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218722; c=relaxed/simple;
	bh=FMA2fiLg9x4GCmT/24ieLJrYnTQ4gZG9IZf0asjG06c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ug1GLm26Wvc67vVWbxbXU/UaR4K4fgpZIyTEkG3Ooi4zoUI6LyPgus+0QH0qgoftym2LiC6hopPAVrt/A7m2arkeVi8/IQ2GoZLH4kMumvVTwIeo8Mzh1XF2KyjtbHDtTUYImlrhlpnwTR7gGTIhNAV0YCxSdhnvFDUkixguONI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsAjMRA1; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsAjMRA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718218721; x=1749754721;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FMA2fiLg9x4GCmT/24ieLJrYnTQ4gZG9IZf0asjG06c=;
  b=AsAjMRA16FTv3jwdstwX+ZkU70ouGCL+jb4hhxTMkFhc38/aS8CO8iFK
   0pbVYoj3nWdw8TD3ShyXXXcCEKfJb8lw8kjQGRTbFaCmpN1vlwfJ0295d
   veWKn4ZUXz1uoQYYBctSCCBZxFzBk+NRGSMoj+F0SSTjye474aq+54mAO
   rIEvt5+gz0jh7E2hAKOUD5isSb/+1ASDyfQgybMiQqCjxSIswi8f3MuoT
   zN9AnqFNNrpR5T8q+rU3eyntF8XVG2FCMgjakK9bSeETkBeMrZTHEPPyP
   17uFNmAYo7GONpgwbKj1J7zf1kMzQbp1W2eQaG+IIqKNGVMnXBLRXiRp3
   g==;
X-CSE-ConnectionGUID: iqLtbbFDTa2Fh7Nu03/xFA==
X-CSE-MsgGUID: 3crPtgknQ1it9vfZljxmTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15156486"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15156486"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 11:58:40 -0700
X-CSE-ConnectionGUID: 7QXdgcSfRgaRY7orwjwZyQ==
X-CSE-MsgGUID: 5xyrVdqTRKW/tlNfKQUb0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39997112"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 11:58:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 11:58:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 11:58:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 11:58:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 11:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVFPpqFPF80hMBxOFH5LE0E/w8dcC03baK8bhPctZqk2cTfdSRtooARqRyjs1FFCiaDyoyjPxVdDoPDU+L2InFLDVTZXsXDi+rpI/p7nXsNP0kmJFwsG5jlUvoH0o4poHnozrl9zs4uB+cOrzFcd9Hiyrr3kbQmJpZ+AavB9i6VN7vxCvsWePCOGKXhO7NRVcDv30BlMcEuZ0ILIsKXMuuiVIOed69oEB5U8mBewg46tKc9fW2huenhfQz9G4gpcYAaJ5f0lcHTeQx9HvAULh7KI4uSANp3fmqdd1OdUZeLuaFX2k3g9jlxqtgp3nDrPscNneR4C5wLUAZH8+Puz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8m5AkrG6Vz2XsmrM18oThn59KsRj37pvDwRihuq620=;
 b=ofHVGtxdgcOIVl8+SgCXhWAabJXyekR3OuOGwMAvIffnSDkEX39DiHUXHQrec2FHYslLCY8FfhWhOjrrD9gTdW9V6X/FI5JINzi9ZHtpQ68N3OCqpraHCnsxHa5ysjUHWp0q9wxVwAi+4LuQ/hll+fdYiBsn1wBwHGkPut4VyTbjXQ+ZW5whOCKOG0hMVfCNnFQnegaIQuf9Gzq8f07H5+OPq46DXiZ6rBFPrweslhTN8tx5/xWYYo1eUhv4XgreDy6tnVYHvx7MARepJy7oc9l8DE71CPYszUl9QXZw6bmYJjdGNHV9YFK0sOMXfFob539H59dAj69CtqdqzX4GXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 18:58:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Wed, 12 Jun 2024
 18:58:35 +0000
Date: Wed, 12 Jun 2024 11:58:32 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
Subject: Re: [RFC PATCH 02/13] cxl: add type2 device basic support
Message-ID: <6669efd8a46a5_1fcf29492@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-3-alucerop@amd.com>
 <6669278d7fea_3101294e7@dwillia2-xfh.jf.intel.com.notmuch>
 <ZmnpDD94rMsfkOQs@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZmnpDD94rMsfkOQs@aschofie-mobl2>
X-ClientProxiedBy: MW4PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:303:b8::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a812b13-7138-41f9-546f-08dc8b11a925
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R0yXDvXkxpCk+nTyt8DO6w919mC1ToUtpeHJs2alg8u8j9t1t7kSk2EOTeZS?=
 =?us-ascii?Q?rmyQTKoXqqqPVAvozcscCb5IPrBAsDzaV0I0z/2bl6iMEmjVbubZet5kRnJT?=
 =?us-ascii?Q?Qe571JLxZa0ox9zaZd2XItaGcAD13mU54m8MK2dcve728O0KfvIQ1+cm6D1k?=
 =?us-ascii?Q?/FLQr36LiFx46bIynmA4zWm/AVGkYPRclSRQ5wJnbFh9T3pg08G9oe3y1aUB?=
 =?us-ascii?Q?rf4lXhPfNQ0+75U9dy6BYxVClD3KsHlI6vt7lIMr7bKO8/Ew0048iV50veTd?=
 =?us-ascii?Q?6IT01vOg+eyeRMdZTIPlYOWTbyl0dUCO7ADkoaNb6zpUnrkZqexIrty+px4s?=
 =?us-ascii?Q?phh8ir/VTOD763LdpJZh7nTGlzGsVT71rMvy27WsmcXbXA5186MouoJgFvz5?=
 =?us-ascii?Q?d6/ZtqVhz+8cgw4TnBts6XeLKNirNQaDxZ49AXgYgNiKV8jZvFn0EJkl1JF4?=
 =?us-ascii?Q?6e5vwxI/S/PyCJZUk+em4OiC3d414QL8eWRvO1gjf6iIzJTOuReavsJEVchL?=
 =?us-ascii?Q?OKQ3Hk7m/xdo4VA62NTw4BblZ0SzUgCwB+GAcOkJVsz9cYJBbzfKzDd4l9qN?=
 =?us-ascii?Q?2Ura2VPNTMB4pov+SO7+oWzwh8WU0Il0zheW1FP3ILxrgWBprmBnNkzkyt4n?=
 =?us-ascii?Q?K/tm6J3g3/6N+x03D5wXUHEjFf+eRu7fXDMac5QxQAyDdZ1mou6VNbl7yi/O?=
 =?us-ascii?Q?Lj/LB8CWIwYAlK8u2umh5DgnNgwouFrDvhGPPSHJhZyuHjkHmL20xDsIXkih?=
 =?us-ascii?Q?8tQxRUDmYf9uuCHFprJ7LCBUxnTvQaRBKfyY7iFLKnvNH9mmANxl54W5JJ2+?=
 =?us-ascii?Q?oWBd044qAaJGoaUYLFQNk31lBeuyca1rAYWDNVjS9f7jsGEp6f1zhltUiNRQ?=
 =?us-ascii?Q?q8TnWWUQdzWT3Ds6IcyZG42DBmZfIcgZhQ5GsENOzsHp49okl9y0PptOcowE?=
 =?us-ascii?Q?Y+ODt/R8pmjJGKMrnWgQxeR3n8LnClDmn9aYQQDJUECygf2UPSOUC89wExtN?=
 =?us-ascii?Q?FPznndWfpiRNhOBPP+xH1RJxWdckMxt10leATwRH4UpCJU8qX368a32uD0X+?=
 =?us-ascii?Q?0HjEKMREca+8x8B23VDYYdp0ejDiNLjDPXOCC/Sv2z0F9aLBiHy0ja7yw0op?=
 =?us-ascii?Q?56TpoSa/RR8WdADDWdd/9v2nEpWIFzYyaInLVfFGfA8sbpJjhYgJePrwZhIq?=
 =?us-ascii?Q?8EMEpxLz60ZZ7SYlq+9nnbhtFkJJ042/mR9XvC/DlrSJ2KSItF+SXNFJIPPD?=
 =?us-ascii?Q?8FpEq1dxMEdZ6xEo8jUi1iSf2k48WQQ5Yt+jsgtiPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZNf33MsxbLK9dDhSVVv6Ul3UF99aTYHgBO5M2GQFmkocOUi/Hmu7ij0Lopg?=
 =?us-ascii?Q?8cg7YJvNi5FDPF5VgR31p5G0bEGb8pHSaiDlhk1XbiRiOWdljHw8enpBmdMY?=
 =?us-ascii?Q?g/BaSuK8w8XFBT8yUh6GxvuhyzH4yMMqQEKEqdix/7j5bqt+BIoOND351uqU?=
 =?us-ascii?Q?I602hmojKIHqBqQP3n3hDqhxllzdkBoyluvi7Z3ZrB4Egd9v5MiKxaegkrkx?=
 =?us-ascii?Q?weOoem6O3mzL+MG5n4eh1xxoEvlYxduK6HmlWe/ZzjTS+VymdGoei9/hK+SS?=
 =?us-ascii?Q?dKlu/MxsA5C/vXqssi9WGIUmDswdv2Xx9ChDQ8IQ5dcpAs8Supcw3pYKzXRK?=
 =?us-ascii?Q?czZSMzM+kFrhPn4iaYi1cB7DZscCVXOI3BVsdzj7vON7Di+jKp5R4HXq7DQw?=
 =?us-ascii?Q?0S1c0/DRaamFR2upx1SnKhKTLZmYcsHwKQ4QsMXYLb6Yjh3HHpkpeMrknVcr?=
 =?us-ascii?Q?LlDU4zFDXP35yNErtDihakiZ5FXFK4zLsijfnzkL7KNivv8gJB6KsN9S+3H8?=
 =?us-ascii?Q?sJoK4UGoibx9du4YXShyYEhsBHL25J07qJV2AhK457m3JuwN6ybWgWRQRK9p?=
 =?us-ascii?Q?3vdJDvNHSeTpNpReKcg+a+Fh+AQtvwG4jzfoNPejNcrEgFr6zyB0Fvog8Qyj?=
 =?us-ascii?Q?P8AU549YLZ+WQRwqdQA+XzEGvLNS+MtjV3L6XxL/S+hphiNGMtyNIlasy48n?=
 =?us-ascii?Q?TWLF3JaMHpbTgJFY3ACOiog3e90HhcdN5G7MM7OAeASNBurXvpDCCyFxof+w?=
 =?us-ascii?Q?kDJ2H2dpiFRb2EsL3/HlxM6TqzugH52D1APy3r2AxeK8Z1kvMgTbJuzOcEvN?=
 =?us-ascii?Q?FzxtdWdsdA7jw+MxSJ7HnPOqellNhPCWmFIl1n9jJ4obMmUII/pBYcRZJj+m?=
 =?us-ascii?Q?V2sPakDZ0mEUeLSgl4BvuojgQWxJPxqN0cKuld92k9iSl12VhR2f4OJH9OnG?=
 =?us-ascii?Q?TsHRSwyek/dHsCicocgbQbhuFt0VbyF7Wt64N0k8xcB7Xr1bwJ3ftDIie3UR?=
 =?us-ascii?Q?lsDOH49O0ktESEKR6cBRFCsh7EWq+NKVyQMNn7oAGR2jqxETAWv7OcLnGJz5?=
 =?us-ascii?Q?MchBsRm3Qbs5EsDxBscdBmMV21hl/N2lJlP3YUZrd1O9QflQfCYjiXiadVbW?=
 =?us-ascii?Q?Pb0UeeJcB2QuZkSGSHvalwGMND4GfD4NmTtctbIq6vZ4fxHiGVWBV53xpWNV?=
 =?us-ascii?Q?UWd8zdX38ECxaBXtwYigxegDSJ7HiPdh27d4a/iBAKKmJfHYcJMVBSJIKHx7?=
 =?us-ascii?Q?yHJDmRyC3/oJUf/xmEWOLHJZa8xsvi1oLzczhLJ9vy1itQG0AwPfuucH80A3?=
 =?us-ascii?Q?BODP99n51hMbCQwhQatGiNaOQzvj0JdovYNzmM1lNmLJlt9+0k4CziZ6Fqmx?=
 =?us-ascii?Q?nRMBj2f4TZW89WeFf8a6r7GulnuT/zXWYhjSOq/FM+2z+h04PUNh/S1aWPt7?=
 =?us-ascii?Q?VifpNRXk4WgaaCI90/g1K95Axe73l9R4q+5HaOMlXCuf/gQiDXN+E0kqcJFQ?=
 =?us-ascii?Q?HsBGwHO0akODV/oDnQ3/YI8zbcqJ0A9/kNFd4xpruxAcpIRQIXXska2zQr5r?=
 =?us-ascii?Q?8JSm9GpqOwSulERqWVPm52aU0Y2dtXJZ5GB/2HsT/f+qXNAyEkG74U1yh04w?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a812b13-7138-41f9-546f-08dc8b11a925
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 18:58:34.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RKc0p10k5qXn4HrovxvJytxNj8+hL9JZ5hr/lV6r9FkOXiYRhUFEEGxh0CJD2NufANwzpPR7QfhIBAa8xYZGJ3qEmBSEEwWyKqDqVbhrcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Tue, Jun 11, 2024 at 09:43:57PM -0700, Dan Williams wrote:
> > alucerop@ wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > Differientiating Type3, aka memory expanders, from Type2, aka device
> > 
> > s/Differientiating/Differentiating/
> > 
> > ...actually to make this imperative tense don't use gerund phrases, so:
> > 
> > s/Differentiating/Differentiate/
> > 
> > This "imperative tense" preference is borrowed from the x86 tip tree
> > patch recommendations [1], which reminds me that CXL should create a
> > document like that to make the grammar expectations known.
> > 
> > [1]: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
> > 
> 
> Hi Dan,
> 
> Imperative tense is the default expectation thoughout the kernel, so
> 'we' in CXL don't need to create any special rules around that.
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Oh, yeah, forgot about that, thanks!

However, the motivation for a CXL maintainer-handbook entry would also
be to convey subsystem-local details like how often to ping on a series,
when the merge window cutoff typically lands, what baseline to use for
new patch submissions, do submissions need to worry about
reverse-xmas-tree variable declartations, etc...

Sidenote on that topic of formatting, I think it would also be useful to
declare "clang-format is good enough", i.e. even if clang-format spits
out something that could be made to look prettier by hand, the
auto-formatted patch is good enough. If someone really cares they can
update the clang-format template.
