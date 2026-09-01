Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266FE49B21C
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287088; cv=fail; b=ocNhXS1gDsV02JVDSgvngERC/cmeS8ygu9dPjZf3B+xdr/7nZQBABBnffnVgC4Qn9F0ieO1FEd6wx3QZ0ZHwu1yY+2+yIv0yRlg6aAjHYRuJwMLG5176atQ6bCiX7EXAfCNw/UnGaWsY5Oqa901kTFDV8DOeizZ7sh1l/dMdmW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287088; c=relaxed/simple;
	bh=lOXD954Wg1x8uq0sL1qYABaF2/QSjndcxYWv8JqzDik=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rpAaTNMcNx6t21QSa/cf0lhz3H2pbnC+AHUIWnIrsYu9UVhRK4qZcyeSBtVGlQS0idqxGmlZFow2Ss1YjqA/tQ/GUnR1x7SXA3r7gLe2/epVuf+l5Iznu3ohrzVnkcKOr7SbYhMnh98O9/H6fVR3FZZYQHNLkVRC/t+AQskWlfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8s4qupb; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8s4qupb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788287085; x=1819823085;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lOXD954Wg1x8uq0sL1qYABaF2/QSjndcxYWv8JqzDik=;
  b=O8s4qupbtr5X/1EybWFdDpSAVzBt6Zx1wZq1WlYJ724/HCjhDrUZ3y67
   FFl+Wm2EXv2z0D61NYvVBie8G9rPBuHD38X8K8iLnIlqIIYuPpHwlRgbF
   DZJ1Avkhb41NUROltSTtOkatn6qzKZ3Tk+5QYKIITgpehAukGb6Z6jX9j
   PWlOCk2Kwl34cOyxo2bci0FlF4A/yO3Fj/I+M7ZP+NeZpTRvsrsIBBla0
   bBVwJGRgM7AgkHScfCwpQ6bOdLTFQIUr56AhiFLANDLNRGCHypjjMc17I
   rbdtfDp59VwH/9+hp1j4RBt/Do6uX2NvUWRBZ3hJAdQaL40AHAriSOK/b
   A==;
X-CSE-ConnectionGUID: wzzrzDbmStC74C9ziWB19g==
X-CSE-MsgGUID: xxcoaO2qSHaHDq46a2oQ0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="99391460"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="99391460"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 11:24:44 -0700
X-CSE-ConnectionGUID: 7nt/6Ym2Rliuc3I0Kztymw==
X-CSE-MsgGUID: DU/DEa38TauHojHlUPF5Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="269766749"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 11:24:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 11:24:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 11:24:43 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 11:24:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1BOqdD6Q9KT8/qSsSi86Eq+HYyHUepH3SoVr7FE19ipllTllAXpwOBM60J4rMCW1YAveCSz9IC4MPoPJarU1ArtIWjmw2LSUj+6B7fuo+GFbwg9rU/85xngwWf6hfitN2esQOnFDpDzqF2glxup/XTxaj1vx2shob2k+Sxil9mczOHNeCu1boJPkrpzNNdj+b5tMpPmgmttF6G5wLB49EZHvhJ3utQAr1SLrz6TSsjRcp1/sqp0wjLbIzbILM47zTMhjQYFNuq3qaSoaBPP1zTCgt+lNFaAu/gxTCMQi29TIIbgT7dGqXJs5uyxrqNQN/ao+Rze7vVaBGWWC7CcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXWLfQd57mrCcyphTLJHq9dP8iUkWOYE5XocX0mjtm4=;
 b=PqMMZCKkENANh7usJDMq/4DudcJ+qS3nNcdp3w65kxs/GWQA1pJlaw8Aeq9SgleVIKxRW8KzlVmzHOMUrTxp6VrSlOxG7/UfipeRSzVqXGa/SO81wx2dHPOdrB9mn2vDpEhY7bbmXFh5uDpVZB5wZ3o57ca2uL4Sbypd1qbDDwRRM27JdfwPMvKVGZHAxCRaRyOb/FyJcaMAg0OxjfJXX7kQEwV28tbF5qmPjfFryi4V5alnD9ejqrk9RBvn3d+BqM93kvh0w6VIi3ckd4uH+nrMd+xerNLRkaB1j7Kig5dLgS5BAoYNCuQuqUTaOInmHfdtbFrEy1QmEViy3YZgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 18:24:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 18:24:40 +0000
Date: Tue, 1 Sep 2026 11:24:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<ming.li@zohomail.com>, <terry.bowman@amd.com>
Subject: Re: [PATCH] cxl/ras: Pass the PCI device's struct device to
 match_memdev_by_parent()
Message-ID: <apcYZUpLDuet1sm_@aschofie-mobl2.lan>
References: <20260828215726.1077498-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260828215726.1077498-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 27775804-5eb9-445a-3a4b-08df0856499e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: SmF9Wob1O+WpxYg76/hyoLCohgvtNEtAdfeCm4YBV3peh7pljuejmiY2emX0WmJIWz/OK63nVzxfdD5KCuGWWMYJWN1qBn/z+AfwaQgfGwFMN1YGdAxYnU8bQDUaja7q1c2rDAEH0i43p9qLKRdihNMAflhBDdUHXPxlV4VyJWhLw5hI87QRVJFrVnEDyer8KECf2fpMC5ZA7DKYrzGYa5U8lnklrDydHl/5LkMWBgidOBDmfCBzNejX7siY8F5JV8vv5/8BPanDMcmRzk7JozKkffa4/yIjUNjDeVohw4P+Z6BmISIzAxlIbQzcoYWs0bvZ5IOb0j4aNgMtLZ3arIbEv/dZGQHR0h0jWdhjE5TAMww0F3dRMwUXBbso86c3bG3a6R1tCxUL4DpXoF13bQ9UgQwNkBaMTKwuCYrKI9wkWvgRn7zrdRt6ekYtED9yoV+E2GJPVPiFbVOQJ4ANqss4YZZ0qDtVkZ38c1xWR5xKzc520ioccYi+bCZijhgLkBvXTHI7083mWPTnFaXw4ODBuHPqdwrgbyu9NIvt6WCiQXuMCCxD54E0qzOzG0J5vqREVYpo/1JhkCaCqqXECnN4i9QBJJ7IR8VUN6xU6E4J/i2Qn0Olry/mmJ8Gglw7mVKFJfBORzno3Noq5mXQm/f4twSJaCXhnkWx6G2iXCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J+xVqiTMcI2fkcamga3D3CskZ3pWIyH5xiOLycngK+FhZjpX6mJTRgY5mvfS?=
 =?us-ascii?Q?3snnGQke/GciCulGCJPrt+uD8Kq8cj8VmqK+OG9DOGV0M9aMxg/C9HaYrZU4?=
 =?us-ascii?Q?BopM+ZGTnyrTKYM5tpiHGSah+mRcj4LP7zXGNLvZ5SUS0h5HsWNeTUVYFm/3?=
 =?us-ascii?Q?GHouQlsOoU4to4OCP1aVYy3clBjM6jMk1feGFmthjizTFDcbTmeNTu0uGJSL?=
 =?us-ascii?Q?8+70tdB+ZTlBuYE6WdBN0E7h7WEJjqjWVDXMT5r5sehVBi0DvbtsD/mWEJlk?=
 =?us-ascii?Q?C3/Bg8EMCc1hb5sV/c68SY8HHD7mB+fg/FjzZsygxd5sNwf3Fn6jzjfp2FAI?=
 =?us-ascii?Q?BjOasR9w0y2+2XIgN9LeIGXlj1kgEX6ndddWDLKrBJHomRxspeDMPFMyOFau?=
 =?us-ascii?Q?ldxMBsR6H07K+6Gudoab52+qaoYyCXwxvpmWeoCUtdN5evkXMJCq/ErquJoh?=
 =?us-ascii?Q?wUSEw1Uz/Glt6LPB95HQhEF6CUPcB2yGFTC46LPIPGHDeAJUi1S1mp1Mn12G?=
 =?us-ascii?Q?Zy+yXVbtngo6lOc3lrMH9A6vMgSbjjv43wVlRPRKOqs5SzUib83qlX6t/ggv?=
 =?us-ascii?Q?f+JJvS0ARe3vZR+NZ/Gtj6vsV5tUykwYBzhU8ZSk+8hsuZqtO2YKdW+iiqzV?=
 =?us-ascii?Q?JsDM9Z1kvclCIeKb0jmHIkK8TqY3CsxAfmMGwypA91naQHouCKE2CRsyXqMV?=
 =?us-ascii?Q?mMb9Mu4hCCFMP5cA5ASukFA4onajfctjAy3gJ7puGIsC5ETffZGQSAPHcab0?=
 =?us-ascii?Q?3piqRFcMESDbR1wW4q3tjLVqcLOvVzmIK3Ap8SNYNtGZLPLba6665l/l66q5?=
 =?us-ascii?Q?fTUKrhbC87Gt5/vTuqyrHVGLTQPK3nkC0IU8Q14o+z4kFA8vj/yUtFzcS7Qy?=
 =?us-ascii?Q?/1sZSDsmeYhe4cUCezAU7wCnTTcvvPU53cMVV2rKLYFm5/32xa28zniN/Id9?=
 =?us-ascii?Q?Q2TeNx4nxk+0nruxcl+BVyOwK0ilSrKp4edkmbWFSG+/3APW8mbNP2fFkNzM?=
 =?us-ascii?Q?2PMMoXSFkDrcd+u+RgLnwGZw/euIfj8Nr0EeI+qYYSjdLB3ZdDyXMCyRmjYx?=
 =?us-ascii?Q?mjUKdZxCRngF7jYr7BEf85i7F5MeLVL5/SojS9oWdtqcwzEgf31mFpgJojXW?=
 =?us-ascii?Q?J5B+cEpnCvp3Ddp3mihx0IJs79V0nlKPKXnbEitl2zGgLYHFPwIkOj+3yS2O?=
 =?us-ascii?Q?ffKVVLa3Kte4J1EGq2s0dzkXsEhZoMqk29v66fOV9LCEhwvOuxMfejmBDgSe?=
 =?us-ascii?Q?8+T8c7I+YkawTbXg6FGTmdz9+oGYhu4YCvqQmqmBVIBNcIGrm9l+GOwqNWFr?=
 =?us-ascii?Q?5E7/h4924kY1WqRw+cznPKdl1QTJfcu5kKG9rlwqskB4MBEM0AUf8/KMKkUN?=
 =?us-ascii?Q?PuVC5J8f3C3bo7oe0kLjkffLlDiIujTQM7VmmswWaGlMfr9irkiTXRqzg5TB?=
 =?us-ascii?Q?R5anIrZWZspewnICqMN38eSuOPBV1jnHlYGSrRHmLh0qUtGdpacGyR255jGZ?=
 =?us-ascii?Q?1A++Bueq+Fp9wkBWq0GNG94NKEm0hb6849kIVHBrIrQsGQnPfvMfxtJXKmzk?=
 =?us-ascii?Q?YgIYUMhYYwX8yXI8ckfdQwCuzsMpvgFpYCjjdq2xMWWQkFJmoNTWVyw3gXdj?=
 =?us-ascii?Q?LQGgbKDyIvgtjX32O77sE7DsgakDERjSRPA5+M1FZ68qPjW8AG+Xllz9s5o6?=
 =?us-ascii?Q?tCmZaI9QF0HO4tWniLSG9plPJg8EbUrMR/frwo4FJq0cpkKtgKYbxxm8Me6B?=
 =?us-ascii?Q?zwJywC6Nl/hOABM3ubImDtWxmuE8YoA=3D?=
X-Exchange-RoutingPolicyChecked: 5sHkIrXAg5BHbCO0aBvMmPXOboVlw2G3nkuA0uERvEuPBZSvIxvvnQsL5MlqiiNh3BxnS7VZhFDRz9WqE+HpDkLT0K02WvNhW/KzOiYHYdQ2BtT7mnyqGWQ6W3c5zU7zUSYgs4TBG6UODQ3qUfZbsLXXpt3ukJ+QCQXSCWVBrZF532wHzjxuZ1W2POay5VoBex7wIU3btheMD63M1Q1xw+87RDK6vfveZjbmfQD/DpoB21VmkVnMOGC1mZlMRJ7ZIGCtGiEKE5BqOzf5Jl5Tgd4iwIRzhksTjyGkGf2KYv8S/3xDZ6OvaUl0+CX2pPv7AHxlrx6hE7b+ThCWLZYjsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27775804-5eb9-445a-3a4b-08df0856499e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 18:24:40.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFv4ye686yfuQp013zA/OLKvmdYMrBkoUJ2twobE/0zmi74XuPWdKQoOYkW/5DvifChqdlWQKPwuK1DiULPepQS8jrOxJ3B8HMltImkbpw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

On Fri, Aug 28, 2026 at 02:57:26PM -0700, Dave Jiang wrote:
> cxl_cper_handle_prot_err() hands bus_find_device() the 'struct pci_dev'
> where match_memdev_by_parent() expects the embedded 'struct device'. The
> comparison never matches. The lookup always fails and CXL endpoint
> protocol errors reported via CPER are dropped without a trace event,
> leaving only the root port, downstream and upstream cases reporting.
> 
> Pass &pdev->dev, and rename the callback parameter to match what it is.
> 
> Fixes: 3c70ec71abda ("cxl/ras: Fix CPER handler device confusion")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
