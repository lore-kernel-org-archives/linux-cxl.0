Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6C6253357;
	Tue, 15 Apr 2025 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752880; cv=fail; b=fFquxnGkiLc3hxlocm16g8gWVtT5EfDhK2usxOEGQEsP1SPAP2jX5fYfZZR0kmRZrO6nEKZOiwDIndFTtsOI82a5gMyv69oZa6f3hUHuPMm6y3833w55R0yjYYEvxcMyDtTETsKaA/jPQkaAOn9nb/c3O0YGLdpLH7v8UGSC7A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752880; c=relaxed/simple;
	bh=bL+QE9Vhzw8gaiyaPiOQyvBO20orZnOCmr7DbjlqLTk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nHEy1iIEPu6/1A2zjtyBQrRl1RSxTSy0cpTQUbIYqNoSRRsN47ZCw/OOOD0Pbf1whDoaHr5htW3OGOjO4bobxEmXefuhDUV6x3LGC4BgvymwVT81a9FPoHpGVGCR3mIqD4TQ6+MvcnC2pCqrrXQPHl0as28lbPJ5rd6JV/4VX6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2U4efDR; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2U4efDR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744752876; x=1776288876;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bL+QE9Vhzw8gaiyaPiOQyvBO20orZnOCmr7DbjlqLTk=;
  b=k2U4efDR3KJmYgqF+0PdE2S7viNiAHMbWLZMhqcxauGmjvYdncpONznq
   ia7FdWLgypuNrDGq2VvFvLDQb7j3b+lWNM5d/Se3DWiGTsteZvtXBcBKo
   SkPUSasslLh+8gZ6cjV7hUpUqrXMU4qW4Wz2Ir4/zdZpfg0h/CXNdE203
   X5ehVKX5Ztw+Q1tgRwi/eJ5Xx4wAFeugq3PfyKq4LPG/YjawM5TdtGSfk
   E/ybTX2OawUUgoo79hfcmsrRNFWWS83Zl957J5FT6KZaobRPcf6XziN2n
   bY25NmwH6R6SJbtXhwKA595G9SatOb0mtp5ZYeY0l18b2igrVpefgffdU
   w==;
X-CSE-ConnectionGUID: QW9L51ATTu+/sBsWme2zDQ==
X-CSE-MsgGUID: n1ruKbrtSKmeA9Kohwrdqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46444592"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46444592"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:34:34 -0700
X-CSE-ConnectionGUID: Qa1SbXE/QF+ltZC8YQowFQ==
X-CSE-MsgGUID: v2A+fyzFTUSwsU2HPvYSpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130780432"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:34:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:34:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:34:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:34:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olF8/vbyNO4BeAxjzjcT1R7v2K/JhDG/IItMtS5pw8Zm84ugxOv6oAMSFnKndOAhC47L2xmWTIErNzO4wNAkdGW+wKOFC5eixa3EkVBOFOj/YI8Sz+V8oRvDRdPyoJ6iekf9BzDj4VLiPVCImsSJN1FtEORNQ4gkNyM/NtOJNY6rSnSj58f52KGSA+QJdZQsaf2AdEsinpYFdVNpHPqaMnhtm6y+NBrHlVeB/sNJNdr0rhnFVEYKMTsTYGIrxK0P6zAw1JEiidSI7LXeXnpyFpN+o8hd1Y8nffdNlM82OvH2OnjsNDlq0RG3b7o1j3wkb1J2hk9aHBfqzWMaeShxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w87K+pX1PlurT9bPXRKX1wE4ZTGpOWoWd9KyLi8O2/g=;
 b=JwyRdlFwrjrCwYSct6UFy6rwNJCfxGaYGtZ/G/NwRrzzFKDzPwEZH2fgaPfYxAnO/QYh/M+zTPHjj9GgjBKdYLsd1TzLW4JpPq9DOkyQvWZ03as9+3jbynYpcZ06yaR8Av57a5ntNb0yJgnegvH8DHeYo44+aj/CYALsSqrNx1e/LbcEbmIQMt7U41WKWgnqqNOC9PizPW6NY4CKeHOxYoKRlQS5Xasx981BjwGnM6zh3K75xImquIh2AvKAO3gFZ5/jqbmz0VSZ4MueOvnIT8K1YyRYlaawVgWaZvaCqkIFLZuF8+UPV6Zr7L57yAwxY0VfpqCjRqhZWwoa12FiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:34:30 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:34:30 +0000
Date: Tue, 15 Apr 2025 14:34:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 11/14] cxl/region: Add a dev_warn() on registration
 failure
Message-ID: <Z_7Q4mgC175aD0cD@aschofie-mobl2.lan>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-12-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-12-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:303:85::28) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|CH0PR11MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e720f43-b9e2-4d77-12a9-08dd7c654e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5riDZEEvoYluB4VwMovP92uOICyeSHE7dhnENp5bNYZemI4RVf/CdmnLkqpw?=
 =?us-ascii?Q?WHQX0CKzgCN8NGIFkcjRh+HVQdu6i9n3H1CONUIvUIAD0jqSpJ0vDc/UCGjn?=
 =?us-ascii?Q?fXNnI3o5O396SwZf+G8xGaiOCvYQOkH6nBbDJsN/w+aI9Nn5okMMEV89GC8g?=
 =?us-ascii?Q?+X1rHNbNL77yOJAgzZo+vOwM5RR1sxM6OOH2k8QI38Uwz3GHA4JMEkoxqXnZ?=
 =?us-ascii?Q?Y90Lb3EqCuXThHpewdpUte0rKQWsNltqz1NPmMlKJfSAK3NeETW4BmhI14y1?=
 =?us-ascii?Q?ZVc7D6o+AWMs/v1LZUiFSaLvQZbsaAg4cHAT0/0uPle8I5GJ3/OPZQa5Pxcf?=
 =?us-ascii?Q?F5cXwsVtI/k9j/o86t8a6afXv/wEJAezsiA2QPwACaWKgXcCZYJbY+XdMCFP?=
 =?us-ascii?Q?PbT1FU0+4I6sfKjtOBJQ4Qtzb66aY38lX5uYJf7RPjM7XP3yacY8UDVhSKKj?=
 =?us-ascii?Q?KmG/eVea6wKfksjhJkKkpvp8I9Fkx7z8EGexdt//K1MYfrePBS4FQ/pNB0Fk?=
 =?us-ascii?Q?jrE5sqjF3e/H2t+pUg9SkCkGG9ZhTRHfhKTxlBvzmoT17Hb246kmPtElNB9s?=
 =?us-ascii?Q?oO/iUMlw6UhAudGzKEpooFQM0czcs7RBRHQVVpCBS+vBxMkIh/zEGP1L6Kvi?=
 =?us-ascii?Q?djOoB3iSEJlS1GTa8xjY//rHST9wEW+XqNsZFnZjAQzbKJLcm6xSyIBO6IuI?=
 =?us-ascii?Q?85Kh+mY6az6obcEJVrc2OWG6javBP8E4vZIZl8lctFEzO6mCmU+JVJ0lpWo8?=
 =?us-ascii?Q?LE2A0ZdvbNCeqF2sEBiEfE0kWMhj5zqwmHe/ln2VfBOx9+Mxy0U1M8ExAIIO?=
 =?us-ascii?Q?VbnLpntw6fL/IXm0lYJiqjr5Q8S/eHRsfjtAb4iMl5wa2P8eoE3r1fuDuZje?=
 =?us-ascii?Q?pxFKWr2/E9Tn63hYDXZ01CcjPbhPTqTPGT+RRNRZ+V1Rogdg8Jf7+8fki1zT?=
 =?us-ascii?Q?ah2dui4jLqPPzuaDUqDTnRGF4uGp6LFxYJ+p+qIEwUcCJJHvMZEzcezAC7hd?=
 =?us-ascii?Q?lUUzHkOZH0DHPAmPTI8TR4A4jlvH8TcGx/K+Xqksl0lsgT0lGXWMCqE+Ha77?=
 =?us-ascii?Q?fUZLkQTEMYod001RTtDVrnqFg7kJ2JmU8S8fiX8UWOFADZwJSDCr1bxdaAXv?=
 =?us-ascii?Q?d4a0ii4HIFAHQsFg834A8rSp5h0YWuKWoul6TcSkk6Ij4MiLdfJ6mfiM77ah?=
 =?us-ascii?Q?Pqowsim8csKD8u5q7VHur7mE9LwJRljME0g0PpPqGXD+hfjaVuy/+E+cw4X8?=
 =?us-ascii?Q?V7AqC1ld2+tdALgobFTIlcpOVl5i7R6ES+wffEt76SvsSrJ81psGrQTffn/R?=
 =?us-ascii?Q?SqQEQZeziD7qGXATAcQXssD7Xy/7xmyjeoo02W6EqQrmWCkd78l91D9uxWFC?=
 =?us-ascii?Q?KlwsJ01JuoYfFxobgTmyVHwF9xqzxMyAMbKslVQAA+7040TnpMVXNCdy8p6c?=
 =?us-ascii?Q?zOXrAT99egk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HCp0jfY/ES57B2H0snog76jEExNgDzOeEpeX0ZLYsQzDo2qXFoF9Fi/67vpo?=
 =?us-ascii?Q?D+86mpON4bBi820rirs+nbWRyhT5TMVEGanCjKn17FCm93q2JfE2wSz9MzNI?=
 =?us-ascii?Q?dLrSMw5yawiRVF/0VNo9F08T/BdlPVaXvdvJIzgswz90pXj+Fc0a5sLwUveW?=
 =?us-ascii?Q?yz+GIetZ2HcQEPPHliNbBiMX5e59qzjIM/WSWr69gBs1iOAkKJPLC6KCGa5L?=
 =?us-ascii?Q?HfUGUPVwlUKxg5tInwBS9JQu3a+5fyYel7ZsC6PiVv0HcyQb4Ic1FF7l2gVx?=
 =?us-ascii?Q?7MYdmCB8PaTZAvcEW9e/GlJWvvkkSpUW1OZGX5WBorUbExMVpmZ78qROHB2F?=
 =?us-ascii?Q?DzOm9pZrbr7f03MXdOw4irQhfms9MEIy8NQuy69l+i0ezIkcqZ5nuad3a+fe?=
 =?us-ascii?Q?KgW3wlKrl1wLkossMwp72//J563Msv/ZwEmBHIznvYtLdcm33ABbFekNTJ3W?=
 =?us-ascii?Q?75Yhe9c/PGrblYPoZpEkZc6zex74KOuaaj466QlnLKmbEsghVlQhxC2S1q+G?=
 =?us-ascii?Q?XmkaO6v8CEXH7BabaGc06LGIhsuJTR5zZflLxdM3d8tAHlPazOfKar46oJdN?=
 =?us-ascii?Q?2UFgXCTAOqVwIgJg/IcLvjy7dz2LWMHHn9Ty9YIboX9ez54Bt6ealiOi9yK3?=
 =?us-ascii?Q?1WNkGb+CcDwWMLSvg6kGcUXqbrqaQ8bjwyEXS3dNMGlWuoTeWADVDnKK0OUu?=
 =?us-ascii?Q?GW2AJ1pbcehd0qphPPOzb6Pzs6h6wz9UdLsSrqrbZPMaJk02Q89iyABM06t3?=
 =?us-ascii?Q?sVhUdPBWHLRU9OLJJnsDlc93hEzp3b34uqoRd6xGWe8tcEVf3Nwi5CGQi3aY?=
 =?us-ascii?Q?vSRfozgKD3ANYXj+uTuJyv11dtzzZt3la15y20ahv0EZ2Z9Z8aQF6m6NdIjQ?=
 =?us-ascii?Q?osG1S4arf+6YCnxREJTgBSkmjz8mPYKxmPkSi8vlIZmB7DMJDvbYIk+KLgHS?=
 =?us-ascii?Q?ajCOW7Lr/ZzUYMJZmJyL8qOck4Xui7X1xFCNs23nW2clbIwRbbgMg0zcedDY?=
 =?us-ascii?Q?p8WRswPyoBRYXhRXyTTfqiE+3jUEAAbBszyRpqaX7cV8k6dkxlapmMuZ2mvS?=
 =?us-ascii?Q?D3iEEiTUL+Ch5hq7LheJjHJf0gfqzj3z7gamRgPcLFw78leeD3NkiIeIOU1r?=
 =?us-ascii?Q?AmkI6IvtxsPDPU0IoBVRXxRqs6NIOlOuCiNk7k/hcNB7UKJ49Y26OJtLH+/M?=
 =?us-ascii?Q?rN5Th7tfdZ/UuhasDzyZb7UCSWlZIUe2xBvNIxNhnMA7x9p8bDkZvAHLol1a?=
 =?us-ascii?Q?GSeK8/1kJZZgUW8A03w6sJJmeY/2qWiWf7LB65mLSN2gcWoTqPjYiEvJmFpo?=
 =?us-ascii?Q?l4mWNxBPPp2nvtIylYlG8MDdERpeRSHVH6Yg//wfeTLRvrBfTbdoHKFWBLVR?=
 =?us-ascii?Q?7iZfywcRIwmvRYgfCaEHEG3JDPvzoQn3SL2q//KG7IJYSgJrlToHwtBYnUj8?=
 =?us-ascii?Q?2/dMU5XLn/Cx5VP+z/EuUykHxE/HaNN58RtkUhh2qAUjaGyG7KbTgrTkoC2u?=
 =?us-ascii?Q?J/Cr6PNf6KPHims6mXVorArRR2ZlUTT0DUKpdd1gZTcelId2kSICKspFqo3x?=
 =?us-ascii?Q?xKkMg+FroYiwBpVi1lVU6x/v8M/FpmSIOSMT6B6tYA506WsZqG/RnMj/V4fm?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e720f43-b9e2-4d77-12a9-08dd7c654e2a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:34:30.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFKtN2HfCCCqmjahS/HAv7n03ZfCrKpfN28FsApliORbMF2IB2uwLGJF6h/tu1Dhh4m4E3T5pR/W4hu/as/aqA1j0pr15xlmiCueHHwX9RA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
X-OriginatorOrg: intel.com

On Thu, Mar 06, 2025 at 05:44:45PM +0100, Robert Richter wrote:
> Esp. in complex system configurations with multiple endpoints and
> interleaving setups it is hard to detect region setup failures as its
> registration may silently fail. Add messages to show registration
> failures.
> 
> Example log message:
> 
>   cxl region5: region sort successful
>   cxl region5: mem0:endpoint5 decoder5.0 add: mem0:decoder5.0 @ 0 next: none nr_eps: 1 nr_targets: 1
>   cxl_port endpoint5: decoder5.0: range: 0x22350000000-0x2634fffffff iw: 1 ig: 256
>   cxl region5: pci0000:e0:port1 decoder1.2 add: mem0:decoder5.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
>   cxl region5: pci0000:e0:port1 iw: 1 ig: 256
>   cxl region5: pci0000:e0:port1: decoder1.2 expected 0000:e0:01.2 at 0
>   cxl endpoint5: failed to attach decoder5.0 to region5: -6
>   cxl_port endpoint5: probe: 0
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


