Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D9418365;
	Thu, 24 Sep 2026 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280894; cv=fail; b=upVW9JzioPb9yN8btKZ1MHR/24SfLgIRSk7LtUowEODQbscyXXLx7uqBSVqlnrCRtCdpBj34wdqVrbhFSOhKjNe1jFYuJhwb9HiFQqX57ASYwd7jE87dXh6xwAQSsqj58dLxFKZGJGyyBruS0xhJ2copDCSGpwktKjy/Rq6XZ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280894; c=relaxed/simple;
	bh=zfNYQGmw9EhiZfOr8T38+bfsATK3X4F5Nze7T0GDpR0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GIhOFzfITb8Wug/7Bp2VgZROpNKBsj7dYlEsUs32i4QmVJGOPSp6+iHQ6PTI9CPk1b53Dk9iCmjdSLQSTfaZwiT6HxdqmVrbk7H5KbztCypFWkVZMQ8kwif++1YOMwBWKh+rBcZi94zqBPzj5OvOE1goipqQl00CAav1QKGU9Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJV2wG7l; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJV2wG7l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790280892; x=1821816892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zfNYQGmw9EhiZfOr8T38+bfsATK3X4F5Nze7T0GDpR0=;
  b=dJV2wG7ltrqaCgRsOsX1Y8vAEHS4rzX7UINRTA0hpD0gxzRZUksyWdHk
   0gMBKnB+3YzS0BOjg+uO5jd87kBBiybnhb8eDXSN6mNfek5d/Y/9JF0Nx
   gl6zhPDGjC+qe4LryhajxSmh25Vf7z/CP+sHPBoJ0q/qpuZkbFxR9W6j+
   SL1ktJdkQ4UmwqGg2VVI6JXsDi1Wnv0UvZfYXcsbFecFllNAbZ+GvtR3Q
   fkk7gMsp2/eZtuXk7wWS/0vZ01Kk8vFGqyT0y4EhvMZUctS3TMJfUjjuh
   AidllrJOKfSPikaOD1rJPcwjmueCbRkF48+FkWMlKcvwueOZIQ0lJF+0D
   g==;
X-CSE-ConnectionGUID: paM3zGO+QS2Zwf+nfdDsVg==
X-CSE-MsgGUID: pG05chaHS3uDl78RTvM4hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="112852539"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="112852539"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 13:14:51 -0700
X-CSE-ConnectionGUID: zZBl5KrlRWe+wQrVOO7OgA==
X-CSE-MsgGUID: LqzCbEhlRpWqxnIivcgCJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="273228620"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 13:14:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 13:14:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 13:14:50 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 13:14:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJMLBvAbXk/7fryqt3Km2At4gQHzVaH5PhcrGZW5wbS6YD6qCbaDvpSLhhyNFf0HaMZLgGlx3dQzi/NbkyAFnLfEqflPzmTPrTASGr2wOwpaL5pLUZORFbj87E+n3bp+N9BTTc5dAo8y61tduq/nOD66G3/jlY6/AM7D4LIAfCKaiyBT1VIE8pMs6VtGRK2Av4LS6zFDZ3SmV7Wep8HZFJ5VAWTLDhgK6GRR3rUYp30M73EPFlGBcA74RP9FeamLPJtdvIe8ICyFA63DcJvPOBP0DATLzd6QAuQo8T/97qexHYeXQ/MEb65tzdV5JLlyMHMknqlbIyoCX2kW08/aFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCrOX87mY8Agvo8RVxrYLzNtqX7+PXBQlSOCnhwYRjY=;
 b=d501zj3QhkBpli5EaP1IFJB5I97yNziax/CZOkPH2SWUeBYufeFZxYUH5F0Yz8NVp/+VvByX85R6RQPxJMg0zshjYJ1rdQwXnAdGFiZA700PAyjv4DIthEubFMjuJY02QTa5r0yb1MpuIxPchSbU4vIy4ajtvZmyf7Vz+Ww6RgTshPG6CmkH2e4t87y03Co+2CZA9FrSSAkLRgeOP9kCs2aP0D0Onz7Xtvs5JKS3hbOs9Yexxw1chOVuh7aSz9TJjDbDQodAV9/11hbwMPs6HOyHEFQ3n5fqbtDfeOdx25a0yTGvNVRfBa3ygIGfGdip3wxBLQufWf5p28kwvmnOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW3PR11MB4697.namprd11.prod.outlook.com (2603:10b6:303:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 20:14:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0428.018; Thu, 24 Sep 2026
 20:14:41 +0000
Date: Thu, 24 Sep 2026 13:14:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] checkpatch: don't flag ACQUIRE_ERR() assignments in
 if conditions
Message-ID: <arWErJvkQtZkGXlK@aschofie-mobl2.lan>
References: <20260924033923.4140210-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260924033923.4140210-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW3PR11MB4697:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7a202d-0472-4aa5-61fa-08df1a78772d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Gi91ShYUkKLTeqTZCdF0KrqBszMPd+YKPcO1r2lp6Hoc+xCzVhtqhK54FUoOBdnuoUMIbfaeb1HidsS8U27FjxuUritEqKoIsJ1LLdWllRqpSjAKZAb5KE6l7Y2q5WlS+BOGEBcLBEd2mTtea7+m/68hiTCnJraWCyLNRdfEbcAwOZJswMzgn6OfQk4P2O00lhQDJT9bTItDcjsnnGhuO1xFniJkaxtP06KLdujHSJu3pg6GDvAlIDLwITgF9QTww/70Pq0IyLfJT/OxYb84/PjW3hsUedh0hlQCvcV45OuEEAHnuScJMYMP6k+riZ+3ajz98Y4Lsetevryax5KMAClJCtI+jmIbagyceYLs0Xb4O8JX6+4Bmsur9ciBOyLk1Hfpo4Qht06o6oGM/s2iVXGP+dNxu9dtWCqLZgwsw7TG8AoV+nC5+PvoIosc9YHlpueJqY4u17ahOePaMD5OfbfpN/qxEadzxD7DyQIPZKA9XqV4rC1vtplXj+n9JqEVP0PWyF19tnChmxWVWPMVduYBTX2bkqOqg0I4T74TpQcLgnScE2uvJrWjV56BM4dbHXjiueuZfl0ny5rFEBExaKNMpym74bo0m8pb8ZKMYeMwHBnhWvRXcXE6QD6JwAEkSKIdSNIcKi4SerDgyWytUHLIgeCGWIZArP/QkftEGFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SipY4lytUIa/lhBIjJClKjDxYDQMFhIJN3ALFIHZe8bDlSogWz2Oam3+F0tL?=
 =?us-ascii?Q?YQQuvc8gyadbjLfNyTNpoNehvM5Ln9jI+/Qu2+kUCMrUIt6i0AZXWoddGrr8?=
 =?us-ascii?Q?6WiYhTcX4rKXysy/E0djPUPEa2uzZVsELGQtmFMd4KXWOYQYHfa82TISVBNC?=
 =?us-ascii?Q?MSOaERZ876nUjAdOfyBXhVT+AUp9/2BzrAJdAQZa22m7EJKXJRPzZz3SYGjv?=
 =?us-ascii?Q?JYKjihQLNNMtmuMePI8qbgPL60HGYO7XY8LEZ0D/K9+Q/3JT1dcFfgEyLAV2?=
 =?us-ascii?Q?cc5pAjdPVvQ4FbZgPMsH67I0schH+0Ra2m4S+KGIvchLAHhYhsPv0G083Aly?=
 =?us-ascii?Q?oEDJW6l01KJouDxZBOaO4VxQPp4wWVmQcYq6EHVYJqnAca89CeihfKkB/41m?=
 =?us-ascii?Q?8XSaPnMWM3usmX3Ag73u4LEDrlVUdBV87FU0PHubrrAIox/RM7FVwRpxtCxJ?=
 =?us-ascii?Q?OuY4gu+2yO7JeqzLJ2mCiKKqE5P9T9JjAwAprbIJvOCT5GVzKvpDD6cmVQX1?=
 =?us-ascii?Q?Qw+RVY7jNSZIEbzYWOaEmr614g0Devw7Flt5PpQWYrePsGV092TfTWEojSGd?=
 =?us-ascii?Q?4fa8p7573MSefHIcDT54y+R4Q4vMVrOXdmpnHQNPNNIOIGBIPo0LXX2JGB7N?=
 =?us-ascii?Q?aHY3Kdyig7D7W4rCtMG6NjhXUrofx3aZXHfKUfH3l5dFd6QIHRPlcLIpzHNu?=
 =?us-ascii?Q?GL2Ep0b9blusuOUZyl0YgsKxqloJEC51QSQE7bMgnls73Bn+ZNWNnz0asogf?=
 =?us-ascii?Q?zzdqzBZyVk0iBg1LbMtcNzXM+Z6/KHBNfW/qBNnCt0PMiCpFx5PH2OvJISCh?=
 =?us-ascii?Q?Xl7w5qebqNe9oiOu4akZf3QNQO2TVsC53RnCNt1ciiCxzJ+zcylnieFNqnfg?=
 =?us-ascii?Q?euHfx2WtLNf28eCF2poY4z/EGIaTT+CJs/dfps4V51dMWoPi9tj8GmFxe/61?=
 =?us-ascii?Q?4n3BXr8zFLdrQ3JbY1SAGh/kL+1Sr58gV5+p9njGhmuxNJff2dfC6Z9CqMK8?=
 =?us-ascii?Q?/6+lhf6TLVYx4k0QfAA6ufxkAgn7IXEeMcE1kgcRe7sb7jAncCsNa3DtWiBb?=
 =?us-ascii?Q?tCEwUIchTC8ivwlcY0JDry+GOGgu7Cxy0WcmO/cbfLy5h8S6jRtnjUo1qQYf?=
 =?us-ascii?Q?WnjV2nKYbO9cbvs7+Id31l7ynMrConYqj9qKvrixEOqtGSJa0gS/Hsf4Uzel?=
 =?us-ascii?Q?Vl3F2N8nnMO6ULJt37CZCjWPj9/hep64KUOmaVHkk7ReUOOY+fxpRqsvyhHA?=
 =?us-ascii?Q?pd8ANnprSqx1Wobo0QXahPCGbfax9GzZkpm9RQbqjzYMHoJsYXQVcqwqnKcw?=
 =?us-ascii?Q?pdixKGj+qTAVXte/FULFM9U1HGLul3xCnBERnU0L8nTfzU3eY/tc1edV7oSa?=
 =?us-ascii?Q?n5+qeGn6VJ9ReFA2yA8fhg4K6+M8Edao5NXqLMi5eVOeZKlVdG7YwAPE5hq0?=
 =?us-ascii?Q?+vlayzAY1h4uGmuag79qQix0QpfL8Vym5ZokmoRBcjNrd1QQIwZ4flcgnXLj?=
 =?us-ascii?Q?r/+4BlqzBnk5AOEBSshjrxGBA8+WOniMRtm/uIuNW4vBX9nvBr51+0VOwFq0?=
 =?us-ascii?Q?e/69qExywtM8PgNcTyqdzv1ueIRHAx7rbU10SPvT8ACFUZZmqdo6YwVVcSXz?=
 =?us-ascii?Q?6MDlV86PVGlwE81TJWYNctXPiCnFUf0FWOrptnvkg1W4KQO1IbD5IKBWW8yN?=
 =?us-ascii?Q?JOL/Hba3afPBTTMp2kzd6FLlnJYtwpchiJ4W6LzRJt/e3w/f4fOIftI6jDT4?=
 =?us-ascii?Q?EozCIHp7a98lUagDgKfqoeJ1C3EKqwE=3D?=
X-Exchange-RoutingPolicyChecked: MROHc39S+nbxbEwmZlOz9nDMDZuy+dC0bdaux2cRG/vIVev61COqUG0RkCWC4fp0USz9ruhNecy9IkMSi6Tf8350V1UjbL5fIgdinhPuJmkvH/QnEi/YbQmshEaYeKng5fl1RT9UAAjUgnG7SxNEIr2pbdS1mqLd1yvboyVEVVQMy5qgWWFsi61cDEiOTBAog8tYbnqR50aQhLunpN0Sm6JY0fm1L3Z6c6RSzKEs3ur71SCuNzsi7t7v4+JDQu91T+p1gCfKCBj+9anDCe8K3sLegLmsBkPFEIzCKq+gKei58hLYhhDuCelJnZWVSPvJPheGv6HldKakWsy47pTZPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7a202d-0472-4aa5-61fa-08df1a78772d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 20:14:41.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUnnczC63tZsZLWKsoZBug3xVMgEA1ikv6WIgr9gq8ZvbGRdW8Bej19fnYRwmN/jMutJv2WMyB9AW+KglMK2NrW/71ovCVUbdbe2vUOIS2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4697
X-OriginatorOrg: intel.com

On Thu, Sep 24, 2026 at 11:39:23AM +0800, Guixin Liu wrote:
> ACQUIRE_ERR() and its wrappers, PM_RUNTIME_ACQUIRE_ERR() and
> IIO_DEV_ACQUIRE_FAILED(), report whether a conditional cleanup.h guard
> was acquired, and drivers consume the result directly in an if
> condition:
> 
> 	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> 		return rc;
> 
> That combined form is the established style at the 49 in-tree call
> sites under drivers/cxl and drivers/pci/tsm.c, so ASSIGN_IN_IF fires
> there only as a false positive, and every patch touching those lines
> carries noise that reviewers have to wave off manually.
> 
> Skip the check only when every assignment in the condition assigns the
> result of such a call, matched by the *_ACQUIRE_ERR() /
> *_ACQUIRE_FAILED() naming convention of its wrappers. Plain
> assignments, mixed conditions and near-miss identifiers still get
> flagged.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>


Reviewed-by: Alison Schofield <alison.schofield@intel.com>

