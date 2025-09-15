Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733B2E8896;
	Mon, 15 Sep 2025 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960844; cv=fail; b=I9rA/TeIiCWMm94Ca4XGc1QaPJ8tSRkqemva1CqbT3SYImI/No1Y/pY5pFZRzc667x3UaRmaSSPBZLhh6eYlVxiu3uT53mABHwZ7PUDPYgSn1CFaK8Bbql7u+Kykr9IrLvpfbpcqnw72xnvAFsXc+2Y1B4TVv4JcTWb77M+aYI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960844; c=relaxed/simple;
	bh=GL7cF1vUyV0Dl1T85kHp+1/WJ9Km6ToXd0iLsk0B0Ts=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JC4V7PuKrxu23y4QQ7Ez9wnwr7DgXQ8iTzxvuRNnWlC2DFB3Wg/9LlX8C20R5GK05dpqLcZBnlqzMV19n+z5VsVMK0MYsU8vzknOQUk2oYaXFoaNBJoY8KNCYpIfo0uVeIsHJXpHOfiN9Itb8M2rFbOVReNYfRK0DMfo7dOIsho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQKfvWE9; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQKfvWE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757960843; x=1789496843;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GL7cF1vUyV0Dl1T85kHp+1/WJ9Km6ToXd0iLsk0B0Ts=;
  b=IQKfvWE9yMbHXVNc7nat0gS+meYPNEva7YticDdXaxxwkDyPNT0IdXI9
   huuNmh8z5lJuJS3Mj+de9yH+Czg0lX3tehfvImjYXI/a1gFgC4OLH/QVp
   4Tvm2+rg0M7SC5HwleTuE+8Wyae9iJMbkDEAV8SSi0XA2YFZdW7r8IiKE
   zC8IPpSMjV5AQBdYN/Li75vTh6RLhJ7JZrCvzopfHYNdOFScpWy9+PJEr
   7nNhPS9DpyPWqIUiotockvkYJzz2ZL3rrpWV8RjpPJnOuOtsYyiXqawr3
   EeTqGtkijcpHyIP8WhEA+LCCsRsqk4s7ItGr/y/u0RBy3W+rMbz7HW3zl
   w==;
X-CSE-ConnectionGUID: zSWRfKrqSH+Qm2AmJla5Xg==
X-CSE-MsgGUID: PMFC7fzPS1O+wigYqn0+ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="71323046"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="71323046"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 11:27:22 -0700
X-CSE-ConnectionGUID: DFG/BhpiQ32SHoh0SGxQqg==
X-CSE-MsgGUID: 03zGPfwEQZiDieEJPrLBQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174015137"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 11:27:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 11:27:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 15 Sep 2025 11:27:20 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 11:27:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=La8VZjRLiv76S0b2mAGpmAZt7ebZvfYBrIriPuEhV30I7SE8lMrPyzPu3YLAIJZm56ju25+OiVeagwhs0ph3KoW40j3qv0I1R2PnpyNEKQGN8UMCB4+xTNIuJqWnepO0gLETK8rHeBW6PAY6YVADdqMqJoJH4ZMZDceEDT+vJ8wKaiyQLyTHPTeEzp6kMlL69vcctuyZq5QGNcOwm+i42EXnkasbnwsz+X2e/e8EiPAe0b5PDauhiWiQPms3XWrNeatkFRZycnvWGoHtabgSvyfUD5PVidokv1zPHPVkdXrQZwwKXF0lTIlIWiCzj5PvVi3XSOOksn/9CEbVsM2D6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3qlcbBYK6MwE399tJzjuOUzRXcHuwkwuCLzlt3S6Tk=;
 b=B7qPr0qRAoELFnjc1kPXz8GZWdambjzTrASf0atmPFAbFOCyOPpJgTEcLNjLXf201p6+AL0Ztj5n4hL7a3PcBcDQ6dcnioYyGLCRIkpPD5Ocdi6ALPBd8nSzygUS6QM47ZGYgkrMAwxlhNNYY5LOsPPiy3yd9yxJdV6tet24zYpRYW/WCcvTNKIQyTFG2RIyO9yqbsZN5GNvuc6Wsc2t3Z5xGyyh126yaqXTN4O5pAca3LkXpcWc3llHDkCaggprQ7gceX8PwqG8m+PbEDWyS8wlQb4Ttir+FypjW+dhX9O1jddWXaXoEYNslFGJ303JZPs5trSwPlaIDx4ftoD+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 18:27:18 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::4df9:6ae0:ba12:2dde]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::4df9:6ae0:ba12:2dde%8]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 18:27:18 +0000
Date: Mon, 15 Sep 2025 11:27:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Dan Williams" <dan.j.williams@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, ALOK TIWARI <alok.a.tiwari@oracle.com>, Randy
 Dunlap <rdunlap@infradead.org>, "Gregory Price" <gourry@gourry.net>, Bagas
 Sanjaya <bagasdotme@gmail.com>, "Robert Richter" <rrichter@amd.com>
Subject: Re: [PATCH v6] cxl: docs/driver-api/conventions resolve conflicts
 between CFMWS, Low memory Holes, Decoders
Message-ID: <aMhaf-SF9YvUXwfX@aschofie-mobl2.lan>
References: <20250915145810.16872-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250915145810.16872-1-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: BY3PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::9) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|SJ1PR11MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 49344ecd-04f7-4cce-5a0f-08ddf4858060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZHn8fUREY3P2H8F0P7vdmdfzpq0QoCx4iuPXUmKdwF2q27yu8sRjOv0sbIx8?=
 =?us-ascii?Q?N59AQ4jbzB1fERQ2lt6LiOBUKfDkzE2Q0ajbManK2vmlKDPI0I/tbWStjH8q?=
 =?us-ascii?Q?SkqmopOxDjG+JEGqsTUoekIQUgcJ5eGgf+S08Wmdimyupp9z8AdSsTcCEEYL?=
 =?us-ascii?Q?/LwlycsDvCJfOSXZeqCKBeoTCvZI5jcr5H/j6PQ4lg25kS4FAaT6fzuvEKUZ?=
 =?us-ascii?Q?IbRSLnwKeVkVXQcHtY1qSh1Nr8jaQSRQBphCH8QQzxIm92RSLyCh9w71CM93?=
 =?us-ascii?Q?ns9msOj7+vOKYwtt0dTsM6Lfn8u86mXqui5CKpC/7GJqfEeT16UHY0hcW+Ro?=
 =?us-ascii?Q?/+Hv97QmEU0A3AVtowh3iohfRFXGnAgwvyTGVQpeUQ1dNcQ5TqHIPhiWWveI?=
 =?us-ascii?Q?2ZS6FnUaH319ZeQypSEIUA+sd/sB9D8Q4/WjFhE8B3F2AGHpMG39TTvz6YwY?=
 =?us-ascii?Q?ENKnSb6928IcwafOYUoOtlCoU043Gb7d0Bet53Jfw2I7qmpRfins8GivtCLi?=
 =?us-ascii?Q?EHcHSi3XgkHH4rJ0c9RPITP/ig81z/qfjak3cim7OP5nfOSSlQn8goHqkan1?=
 =?us-ascii?Q?Cc2Q3c9+oFb6zWKPlnAoJnzSW4r98tPgkgX9ng0aO2NrlidY3Sbyjrs5TQvF?=
 =?us-ascii?Q?OMBsvBnu9ppYUPDJOUAwxXVv3P6HnRpxZ/hGLPIqW0V1FnpXwKIUVjXTimEY?=
 =?us-ascii?Q?5F2XmwZ2g2rVK+77TVY7TB63srSYfUGJaS9C0ElCvHGXFHFj7prVW/A0ojrg?=
 =?us-ascii?Q?QWp1C5zjxis4g6zKl8QgWhnbhho0gJKy/GgfnBSJrQ7xa8mfmS02yrN8eTaK?=
 =?us-ascii?Q?KcWHCFJvnd3wS6ivWNRtMBMPDdc5a0ya0d5dSYkYazdGZF+AptNr4yZ5Z9gV?=
 =?us-ascii?Q?wy95l8xmSZdKAMx+hnwzTeU+0hRZqbE2f0fW0MemFugonb3rRKb8GQPQkXlo?=
 =?us-ascii?Q?g/OYqTfFL0SRPde7VUabHhfWE2+YR52KdYkYtOP+Sf7mjuPsw5nWXvbMmwKe?=
 =?us-ascii?Q?Ep/jVAaXd3lYa6LsmLmbLQrpfr3GOoXFOZ+gNh148r93E51vjuz4eR40wL0W?=
 =?us-ascii?Q?QCanQO2/KI3gyIE2szyEiyGetZkBOS5S3DKbmWbpxzo5PTq6N4ivxXU9mZNC?=
 =?us-ascii?Q?U5zgaDuKMgTpvAopS4G0wj8EijcDZROOnQKTWfwybKM62EAh0TRTX6TphJFM?=
 =?us-ascii?Q?W7Ty9TUPiBu/zpRs4ORWek7grSvTx+4/AaDUC8CKzVj01ePSZMoyqc+/y7Cu?=
 =?us-ascii?Q?mDaWe8oYVTCeHcBQzRAASjtawZZd+pzHwNxPxFVxHI5giuHBHjOgHWFZeLrZ?=
 =?us-ascii?Q?RbIsK3SXrLZNQ+mFboAkQw/NovTqhBqYoaRbLBOvXtQkB3ihhDWOM7tI+wdX?=
 =?us-ascii?Q?MWF9BYXcuWVhAX4bOLTVRw2KYRJaowTNBXTjM1iQZXkjStR0MyC5mEzYf8Nx?=
 =?us-ascii?Q?nBoe6E9YSAM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dM5WHxB09FMDOMZyt3Ao7qIHPBEideHuXoktWzG201TU1KTnPh15zNW0DUws?=
 =?us-ascii?Q?CIJQh/7AL9w7YHgc6D8smuFSJvCwx2iIoOAPyYtncKSt/Ji5d7fXxMG2ypAz?=
 =?us-ascii?Q?jrWpefdzhS1JT2JKU8IlhB3G3C+sIkab5XS+qJ1Kvqjg6laZ7K5Ydj7Mc8Cl?=
 =?us-ascii?Q?AvrwbRhSE//HhczlogG1xH1uKBypZxoMlEjYQsoD3ow0OleEyJ/DmZIHRoe0?=
 =?us-ascii?Q?DOnz5jkU9+DwuWDjpurB2SkWhv75tFvO8X9827cFjEQ8ZTSm3QDGf78laZKI?=
 =?us-ascii?Q?g97SdgcxLKa9XH/RIzDj1c0TSZ2zyf1Vd1+T8o1dpjcPmY5bMFcOOzwicxD4?=
 =?us-ascii?Q?Yj/Pnt4B005ATvSmKdB853BORI5orqPrzqZLL/kbvIw3fMNHxVLXN9JTz5xR?=
 =?us-ascii?Q?s1ydLR1WbIXQN5veFQutRMbUs/j77DV/+OPCVb52RS3jAAXkOwgM+s8+PK3/?=
 =?us-ascii?Q?TDRxnJ2qjaSBeDTvo0Y74WcOR8UeaVcaY7p2KwcLc6F93WCRx8hf5NUvrTcU?=
 =?us-ascii?Q?TUsoC5RLtg8coiF72VnKJzEYaVvWQUsYRU/nox3aXCfi9rRM/DJV7SmEHFwZ?=
 =?us-ascii?Q?hHPVuKZyshAC25XZ5Hx+MzIMt2FLNkkamyLdlTzfBMB8DY5kmo4JWcvR5NHv?=
 =?us-ascii?Q?Ez591gZVN8CZwo5qUpWKB4r0jQDgbinAbQhNvy/xGXkKHyfIXstJovjWxasM?=
 =?us-ascii?Q?FJUcMy9HaYR8wtjtLPi1byUKatZMc16MTvox5s5X6dBFE9Oh2PszqlwkH7vH?=
 =?us-ascii?Q?Eun/PhPn8i6zBDAqZ4Pa/J7GrYG92kYpdEXk37Y1AhFKOC6dh6HLDx/aoQFy?=
 =?us-ascii?Q?SPwItHKW6hlcLLGezNmU0WIy2IfKHHSy0Hl/SbsC/hIVtNAQhidK/fj6op0M?=
 =?us-ascii?Q?ZlTYv4K18yy1tLJw425ccBh25Rqk5PUHy/plqGR+jfkXy9UL1bkTI2jkdPEe?=
 =?us-ascii?Q?+/bCEyKMa+Nbl4g/zy2mbtHPOvapqEAtZ8pY+MpFNJAzeo5Yab7PENSRTFVA?=
 =?us-ascii?Q?yvYLyDVg7zbEti023xzz23eAHtq7TK2n2I7MlV+FjBXRIWE7FQCq/1IDI4UL?=
 =?us-ascii?Q?Tz5PNNZBY+AT3O+R2acLpZfpQO+nCQlIJdEd3wDUGBTpKiKhsXtKVlfx+DIr?=
 =?us-ascii?Q?pKSFPmMUjfufILMAEBisrifCCeAItNesD5b1ATLzosXVcbjAMvjkouY7TvEh?=
 =?us-ascii?Q?5KVOhDN+6XmF1Cxc98AZAf2qJiZATjGjRx1xquUGZeK0P+JpRVkLoWo33gBw?=
 =?us-ascii?Q?lpaXyfy0mUijb9/8co2SVtPuN+eBtLm7xgeIB68VpjSd5x/jAP+fimyUcBFF?=
 =?us-ascii?Q?NfCQW+0nU9VXVLhDR5jumPoN2+iHFN2SPe73MhuraCioGDw0strmyHsezyjH?=
 =?us-ascii?Q?cv//p5ULJ8+EK07x9+e6RFe/1U6TN2yE0LqbW+eR5oBH+fI5rjhvVIJWEpDv?=
 =?us-ascii?Q?Vj3Tv/ERP0tgfVKI1u/qOkAFbJvvFFJISZt/d+ACjTdf2LXRwAm6R7a/grmo?=
 =?us-ascii?Q?qo+9hl18h/2BB6EblT5riiiyT7xxBb6hTcEwRAI4C5HWzkZEZWpfDKYtlT1u?=
 =?us-ascii?Q?qsCsHI4og+LtAVI8AdYre5zoS14ztRXrAZxLwagB/qtpTIYyMEK3SkKl9MiO?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49344ecd-04f7-4cce-5a0f-08ddf4858060
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 18:27:18.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhODB23xc39/jEcHnza+bvwk0QRSfNlSFmTUWaDbbit/8xF2PZi5YEAQpl2QO/PYxb+XjGwy7aWbAxKUubSW3iAOZHh0IAfkP+3V+fitkDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6129
X-OriginatorOrg: intel.com

On Mon, Sep 15, 2025 at 04:57:20PM +0200, Fabio M. De Francesco wrote:
> Add documentation on how to resolve conflicts between CXL Fixed Memory
> Windows, Platform Low Memory Holes, intermediate Switch and Endpoint
> Decoders.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
> 
> v5 -> v6: Extend "Summary of The Change" with detailed explanation about
> 	  the mismatch between the Root and the other HDM Decoders HPA
> 	  range sizes (Gregory)
> 	  Clarify that this change is exclusively intended to enable x86
> 	  platforms which map CXL memory under 4GB (Gregory)
> 

Following on what is noted as Gregory's feedback above, and considering
that the conventions document exists to describe solutions to platform
quirks, would it be clearer to state the platform quirk in the commit
msg rather than generalizing?

Replace this:
cxl: docs/driver-api/conventions resolve conflicts between CFMWS, Low memory Holes, Decoders
With this:
cxl: Documentation/driver-api/cxl: Describe the x86 Low Memory Hole solution

That also aligns w existing format for this files commit messages.
Hoping DaveJ can update the commit message upon applying.
Otherwise, LGTM

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

