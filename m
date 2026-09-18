Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155935226BF
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761001; cv=fail; b=tSgD6v/7X/zSTMk1UbqHF52f4OHP5Hvv9gTOYck6J2dduEc2HAsztuwyAfwn8OlG7OY/g3Qs+gFgwMCYr3XKggOSawfDOfBedgvB17UJEPJqE/jGDrFnoD2SvINiOfd+JvXhH+dAXodiRr+wemyD0kIyApYO0DLczJeVieiTPOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761001; c=relaxed/simple;
	bh=noAxTq1z2q3pqOSEx6zCGB4Pi2Sn9QIjA+8QXJ5UDVY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RPUDtw0l0aL4w5nCXf//ACltMCJivmvEqVAsHsmRgCeyJHiqIENcRzH2jbAmwrLdO0tfpYhomeu1MC7AnOwFXQXivJQzFOSV+O3Ewf9y48dmGdLkRJuaK0VZNblh+O587ovai1dVfxFOsuwR3Jbd03oE/7Ii+1PBZEDMKaajTRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkawDf8H; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkawDf8H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761000; x=1821297000;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=noAxTq1z2q3pqOSEx6zCGB4Pi2Sn9QIjA+8QXJ5UDVY=;
  b=XkawDf8Hs9QAQ7Bg4EDTGvDBXXNtXaqavTQcVdFiu5KIX09cznI36WXT
   uKR7c95ZAh60L1sk1SnPIGEjjH05upBBDl655mrMVGsfGt4yjeRZRNRwD
   dyPSxNitVqRvEQzlCHF205Wz/1prkhaFyiqS9hoba0iR8fmWLsBn2huXW
   W6JWVhvoQOk1YJuh7ABlx5QJ+NsQBruC6+IPGNgsFcKXaW1jkEZ3MDXn4
   arxVCxGPUkuqfFuHw6EP62ENrqhAk9lV1ingLY53D1nAjKY6OFJY9lnbC
   +EWYKYaUZmj9hGNIhWAIjgl7GU6N9rUEcqVPEV+f0tFLu93yNk1Tmxwbi
   g==;
X-CSE-ConnectionGUID: se1eiN0HSYSfnLn9A4KYTw==
X-CSE-MsgGUID: F2FflAXFS0euLAEt4+qBBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="800200"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="800200"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:00 -0700
X-CSE-ConnectionGUID: YDcVSNElTpmndQSEF0zocA==
X-CSE-MsgGUID: uQUvdwTZRB+JhxHNQrPO5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="299657347"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:49:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 12:49:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 12:49:58 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 12:49:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gL9x9xtsLOYcD/COsvsG3y+VjQ3uIwLT2Zf0VIX+0nzszmDn38pVlSkfQpsarkicxQFaLruL2LMKsrAL49BtD1Rsj4vaXaMozu08iFB0w1chqI/qLkZH2GIe0WID2IQiuj2ElnUVzGNO8foMMfjthqGmZaBU0kNt0w3qOe4bVlSBXyP8MruWCEG7D1lxm67BcCdzMFLI+pEXIlF+Syzv3XpHeA+K+v6LzSERtcI/6xgiDWveIvFbmoNHLb6cOnp8UNXHAdmCU4FPUJFO8PN8W7a/E8CxaIQFqK5dyWRvPBc4fV+lJzrg4JEyAq5+kVdeJQVlTaWEfmzyGv0z5/edXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqnFncSjqWWWLyqY91Am/8gAa4f/rLPGQR16lfq+iSI=;
 b=jdv9I1ADFQ8un4P9rfOoH4MztlezM2lxVeTHqnYv3QzjZdMgIXl35zkJnXKH9Cf+BNK4T5sHWZkx1aNxmbqFzBJkiXckZrfaoqomkCenXk/MJqwB++lJ8ZDmCbPTl/qpho9RW99F+/2FAQTTipVnN9/uNIpY0EwdTrXeqBw6bKedN7y4V1QATvddj2W1nfHZW8X3orXLD+AYvi0BP/FmszIgStg1Q0m4n6VEUOxUD0obMlfj1EItoX3IfreaFMWMS1ZBvGpwk4+Lovw3Lecx9P+IrtslAZ7LcziWqjsYyeOeBilwZplozWDy2M5eVnjWIPn+R0N4EGC6ODFqCFcoHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB7731.namprd11.prod.outlook.com (2603:10b6:930:75::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 19:49:54 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 19:49:51 +0000
Date: Fri, 18 Sep 2026 12:49:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 0/7] cxl: Support mixed-granularity region interleaves
Message-ID: <aq2V1L3K-JLCK7O4@aschofie-mobl2.lan>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <aqrdldrW4T1H79NL@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqrdldrW4T1H79NL@rric.localdomain>
X-ClientProxiedBy: SJ0PR05CA0112.namprd05.prod.outlook.com
 (2603:10b6:a03:334::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: f5743a73-ddea-462f-2972-08df15be010a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: o0M5UcVIpgYkmjDc94Sh7wbSXK4dCGZnNkGPD9Y2EymI4A0yZhVfEJ2frgnDkv4BgEPc8lbozS5/o6G54gaM4wq6LqXCjhntXa52pWCaPURrG9AH/2whJELBwzs0pHR6xizxoBDhlsrv1dLg6O0uas9W75WT9VCHmb7XKb9wflGQdjreDoEqAe+Ay5WLxr55ea3uxVrYX/mzHIM/d6wMT3gk2YyNebWJkhMgcchWEEqSAffB5OBN5FRAuda8fRVR2wvnkUKHeaeBDiWlfYkKneQguH8fXB7NcGV+2J2Wb95+4PyQ8lYIOKWHpMaS2Ed8oqAwFuXsibYiSrFd4Q7ELdU44Pfigkh+2LroxnJ3AUK9IE6qDJxHv7Dg99Hjn08jh7WRmnS5DHSuhB6rRBdikryL5/rl6UdfnRg4ixh5eBVQwItGqN6WvBIzshuq9E51IawaLUn1rpzBVHAk2PiDyh0nYhOvCqS/T+y4ru9rVnbLGlHVNBHKKMB208819DzkgwGpgQiMQFqAaq1bW/PO+kmSY5Z1QbRhvQiMG73XbEKinnOazuaPDfpRukOWgPr9r73J6KIVG9ypnml1QwYvOLG3oWbu3QT+XPbI1HyV72oVXOgbUDmRgr+hZGEozN8LrUMfIfFwGhhSlojHQjfi/tVqL7iYJdUzLLBkmLgWD8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8laDQ3WfQh6ME83uxdHHsyqaBzq5Pbo8CA+a+p3/oCEIpsahxDRlA7T9hbt?=
 =?us-ascii?Q?MpvFpvxutiTR1LVdAPPGc2W73prqcKBi602PmhsycmM+dd4OEDMAiOxyWRBc?=
 =?us-ascii?Q?ddPqOgdrLnGh/hkNNOC3oT8C0URJXyEVvKKxkiXQ5HcxsIauSCs1Ct3R8EKG?=
 =?us-ascii?Q?o9QdCydYAA/aye5k01HZ8iF5mwO2BdqRFEEVgwCH8lPViPt85t/jnPFxLGoD?=
 =?us-ascii?Q?qpIyKC1uiH5M8t/6sM/9hqZlhdG7XIuUqfQDEEuDRBo7FZ3aDNGd11BNfdts?=
 =?us-ascii?Q?B4F/2+V6TZkAIZqGjK+fv2qhzVzrAtfItc9HAnYYW1MZggVtEFXc7gyqftop?=
 =?us-ascii?Q?B7JNrmzdk+HqUhNtpv5iyWLbel0Vh9TQP8BE4GhXVc88WafeKrcGuP2aDJpe?=
 =?us-ascii?Q?lzyUBsldpCUoxUaY84R10bdYyf6ELhKMjlRbrIB/jQvWjE3omsrdR8fVYHkw?=
 =?us-ascii?Q?+JC8/s3vTvKzQgUlcmXpOit9LqS83fVUNkFofwc1h/Ju72+5Av5/3jeDnNYw?=
 =?us-ascii?Q?qwB4up7A4wMcblXCoI9/CUZgCsQstEjDRHOduC81wD75Q7JmtHKfUdQHHQLB?=
 =?us-ascii?Q?eNLDQaqxl0yVHUKe8SvaOiQ/R4E273cD7FJrCM8qNHFjvIIcXlnFFCjr/b7S?=
 =?us-ascii?Q?P/5nIUhqbKEcUPDnfV4dBvNrdJS9gsskqAc8QDsy5QS/gRiQyKbyE0bVkn4m?=
 =?us-ascii?Q?HrjFrLtCw/bH9OGJowF4fsjF4kfNPWccpj7VvRMagBtqAtY+PaDlRDwhA8W4?=
 =?us-ascii?Q?CsccaTKt1HU7oSLQgR6atVP7uBjv40TRsmRWoH/sDHHfeFPIvDCPyzThwrV5?=
 =?us-ascii?Q?orvUPm6BOgx8K6rHMe7BnOW77fK6RvwI3pE/NJ0QNgbiwX91OZJ+c/d0rRvk?=
 =?us-ascii?Q?SQi+1qtblxwK4COYbWvBi65m0D4WP9PTCOuQvPCbrasxJ929h0G7rf92OZYZ?=
 =?us-ascii?Q?v48OrGzqrQqeyiKf6b2eQHi1mFkJ43qcQ912u9TktUUFz3hL5POB8IxaGM5E?=
 =?us-ascii?Q?/Wk3/kN52Sm8n7iSA67ZU5Ke+DLaHisxL0QvlcwToqnlfzV7LGCWwsZUmVtZ?=
 =?us-ascii?Q?/zRo4zXuYmGLzT90O5OEaFDalg8ud0FnONVLi76fR5OrGzRr6YETsR/idPLq?=
 =?us-ascii?Q?5/1waEKNAJ7KIc55Iya+Z7m7zCuAvGkXq82l2kaWlsFFniUwaf5VZrzXEXsh?=
 =?us-ascii?Q?C1gHGsFja8cNhwmt1VHLZY2I84q/Oyj73wEWIX0cYhmi7AuUaRgMqi0zSuZP?=
 =?us-ascii?Q?Rbs0MA3qWO1Nr6Cud+hE+5zkHzXc9ymBUMNh1iC7B8JkmbXiMC36pMQ7TVts?=
 =?us-ascii?Q?wWbmTah6xyIgnyzTh8gdHW7/L3enHRYp6GW5xnabPJy1HQ7rPlC41BpUttw4?=
 =?us-ascii?Q?LGwzEvJ9rmFruveTIjCOIE520jXfBPQH3g4ouunu3vZlb8fDps+0QYTKvtAD?=
 =?us-ascii?Q?QOLsdpoF2Ghc5pOvXOSJIcW7VKZ0fhno67ZG+Tk67tS63shyD3hzwuZQC26F?=
 =?us-ascii?Q?G/DrOgYjW86UaIKTCLfZgdtSBvEbAYENJo9kMk3C5MesFJI2ay5O1uOT+331?=
 =?us-ascii?Q?HyWjriTVcbYsqtqn++th/pfs8O3b65c0tUVTEoecHEaJHSrjxsWU7Na+iDPH?=
 =?us-ascii?Q?bjVpUpDo0AqrDGGBxY2okghgHy553mbDNCmZ7KmrunzACDP+jYWaghx0u1P4?=
 =?us-ascii?Q?oY3LRI2o/uIsh5QU6jHGQKxWFJ+X7cAgP4B94+Y7Up6c3e34C8wh8s6lp75a?=
 =?us-ascii?Q?+mx6pRX7Ev9pPYEr9EctohtfZWbk90E=3D?=
X-Exchange-RoutingPolicyChecked: cv/F058K7EkFNCY8RI/jh04ZPpnb+SU6qo8c3kldhHDvOIgRUtWGn4jBqg/kf+X+Kf9MR5qR58Fhbkxrc7smVR2bdhLLWdh4kduNNo9ggJiMhIjPmANIJkp+R5gb6YfPIegn1Ly9Caxza5gCIzOx+MXeJNK1yU6/BsanszYADnH0zLmWvBImf4oMHShVPUV7GFq2qytU7dEa6ZAXXo4fr9Ge2Comop0X/HvWfRdvWZRWCvB1gqHBfKbCOm/z/9ep9QbzToKUPH3uzg0pqKx6aCGkBo5lisSJpKWnb79vv2vOGsSABxsr8AcE/NJrG/8W9ZuQ9Y5F7sD1h/l26acLTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f5743a73-ddea-462f-2972-08df15be010a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 19:49:51.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqxAPqnONFTQKC4D5Av3dIMQy6pJT3/VkcUXDifaSaudNB8/V71vNS5zruM7QbLIC2DXu67I6wEdkKABIPV4KqSPru/bG5RZONP/MkR+2dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7731
X-OriginatorOrg: intel.com

On Wed, Sep 16, 2026 at 08:19:01PM +0200, Robert Richter wrote:
> On 03.09.26 16:23:42, Alison Schofield wrote:
> > 
> > JonathanC, I kept your tags on Patches 2,5.
> > 
> > RobertR, Same comment as in v4. I've dropped the Originally-by tags since the
> > implementation no longer carries the selector-bit approach from your original
> > patch. Let me know what authorship tags you'd like.
> 
> Fine with me.
> 
> The series is much simpler than v3 now. Though, I believe the selector
> bit approach removes the limitations described, makes implemenation
> easier and removes additional checks needed. Will take a look how that
> could work and also give this series some testing.
> 
> Thanks for driving this.

Hi Robert,

Thanks for reviewing!

Yes, the series is much simpler now. In v3 we explored the more general selector-bit
model, but as you pointed out then, there isn't a single decoder granularity to derive
for the general case without defining stricter assignment rules. That led to making
the restriction explicit in v4 and limiting support to the monotonic coarse-to-fine
configurations.

The actual use case driving this series is 6- and 12-way regions behind a 3-way host
bridge. The monotonic power-of-two cases fall naturally out of the same implementation.

The CXL driver does not need to implement every configuration the spec permits, but 
rather adds support as use cases appear.

Do you know of a platform or user requirement that needs these configurations?

A few of your responses in this set appear to expand the supported configs beyond the
current scope. I'll respond to those individually, but wanted to raise the general
concern here first. We need to bottom out on the requirements before adding more
cases to the series.


-- Alison

> 
> -Robertx
> 
> > Alison Schofield (7):
> >   Documentation/cxl: Describe mixed-granularity regions
> >   cxl/region: Warn on user region position mismatch
> >   cxl/region: Generalize endpoint position mapping
> >   cxl/region: Name the interleave locals in cxl_port_setup_targets()
> >   cxl/region: Support mixed-granularity auto regions
> >   cxl/region: Support mixed-granularity user created regions
> >   cxl/test: Add a topology to test mixed-granularity regions
> > 
> >  .../driver-api/cxl/linux/cxl-driver.rst       | 153 +++++++
> >  drivers/cxl/core/region.c                     | 247 +++++++----
> >  tools/testing/cxl/test/cxl.c                  | 410 +++++++++++++++++-
> >  3 files changed, 698 insertions(+), 112 deletions(-)
> > 
> > 
> > base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> > -- 
> > 2.37.3
> > 
