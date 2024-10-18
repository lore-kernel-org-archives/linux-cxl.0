Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892918D629;
	Fri, 18 Oct 2024 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286401; cv=fail; b=ExRfLE0VfaZtujCpCMD1R7VHwLW9NcCSGIOmfpotNkSmStmDYB1PerJmtAZ60B7JTabsgrrchywXgWhgcknTg1gwCr5T7zrfzCADejYgyj+3k4vHHY493DATVt6I5gTnzrTPu1ltsSTMcICSlW249HeeyKuAkqapGLigtJRF2O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286401; c=relaxed/simple;
	bh=RIC4IA35Fy7uPxDuWRdGAjFc1wh1OrkzyQGHLcNaLVQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q5ET2OUIb6vkKgfJ3wHIkmINvxc4auHHu936v7ZNresB7z3tWK6oujTlIZiSw4f63Hmj6720OCs7q2BIEST9sb6Mlc+gu92WIU9QI0hne+kuNL2C+gkJAq0shJQVR146/8Okm8qG8hUOgvA2nhK1Nm2Hd3jIZWmSr9SrmkJ75gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGzrsmnH; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGzrsmnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729286399; x=1760822399;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RIC4IA35Fy7uPxDuWRdGAjFc1wh1OrkzyQGHLcNaLVQ=;
  b=RGzrsmnHwRi0d70Vj5yntncSt0QxI62fmz1DEi3DjLVNa8wBbuxmmoJA
   9/zq68CKHtGHTMKK8zwmDNks9A99K43dfPKDa0iTMMU9ebDqHCnSkYVVG
   9gAJ9BOwHvxFBl9L+vdgnPCOEK3er9cBFOgLs/MqqPPxm4GPyITFjXCIJ
   p6eBWYjQrGD9nC/q2wvCYsxFWueGbS4guq1nBezS6CAnPvhJGXkZja7s6
   CjrWdec1JQjQd5UCYvOk8hbGdtdheHwuG/xnbpoawPWTx+dDxKfFFfUYq
   PQ/GHLIJ4RfkHHGfCK/ktKe8mGTf31tfxxxOVp97AIo2kqtj/83c1Az7O
   Q==;
X-CSE-ConnectionGUID: MvktL9wwTbSk6itUCwvzoQ==
X-CSE-MsgGUID: mlKkbOJGQ1ilv3mr3ZzjRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="29043086"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="29043086"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 14:19:58 -0700
X-CSE-ConnectionGUID: wZ+3fq9UTIeoZ25ykNJ6Gg==
X-CSE-MsgGUID: NlneM8vISQOWykx1LcHQFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79035062"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 14:19:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 14:19:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 14:19:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 14:19:57 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 14:19:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmzHbNOKSjNFRzVGtRTHyR4h+navNetosTFR10vnC+4kYgg9uV/U4/ZoHRDeKFwliZ8rrVwT+P3HS1q5OhUzvmLeJfcRmcir0B8KFtkaVLDtLBVpUesbbTYNo1VLjv3tWxGabjh7K1xEuMSLRPx+jUPcWL7orkDW5p8ETaB6NRkqodiWr+nV/7zFZlvCQEWWfKJdO6F3YjnxZ3wd68DhZFll+cg/U9uavdLgguR+T2Q3gQcgMVjSvsUzcy3x4HjefmJ/0vKCC+sIq9mWIMoAK4jNeUatLhdAENOZ/dl4IaBhjh/crXIJjQZftg44g5jy2qu73M1HSGy+NRs+2w99kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzj1p2CjswxbRlt5P3JmoiDsfaSWu3kfIjBrn6KE45A=;
 b=OO/b49pSo0wUHxBIUrkL9mqY69Ms6avqwfBwBbqYTb/8iLDDM7fYnUz/cfNm50lfZEx6Px6b/jYz1RtU6RBB5gxZ0zagufGTIPc/w5G7vA3cXmcbls7kFFm9lBwJCyj9u+NbWE7wdv6jcltr5K4ztNIVXxPcVKAuFuOe/y1LGrA/e/hbDmprqnxbGHPR/wrd4n5CPPgJmqpSg9othNX48NrvB8Kt9bjVjckzXkTx6ea6+fFGe8seY7NiOIelJVCjD2xyP14eZI8h5BnPWCJjRatL6OqwlpEigvem2MWq4G5ipnHq6opBHu/pE0f4aMMsycdkdDts17L4NPe5lOoeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8121.namprd11.prod.outlook.com (2603:10b6:510:234::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 21:19:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8069.018; Fri, 18 Oct 2024
 21:19:54 +0000
Date: Fri, 18 Oct 2024 14:19:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero
	<alucerop@amd.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 4/5] cxl: Set type of region to that of the first endpoint
Message-ID: <6712d0f737037_10a0329441@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241015065713.308671-1-ying.huang@intel.com>
 <20241015065713.308671-5-ying.huang@intel.com>
 <6711909cd5d83_3f14294e@dwillia2-xfh.jf.intel.com.notmuch>
 <877ca57vlb.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <877ca57vlb.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW4PR04CA0121.namprd04.prod.outlook.com
 (2603:10b6:303:84::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 4deb64c9-bc4b-46be-83eb-08dcefba9bf1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?34q8ioejJl195+jhwswmljwDOIvNmC+/i7QdaXT+H687N3C69EctO+1eo8uN?=
 =?us-ascii?Q?Xd8M/0ki4BNNSD86hfaOy9KkgeTrt0q/7WpxBQVIvKSZtVnbFgnmIN3S19aE?=
 =?us-ascii?Q?qpp62HwKS6Yf+8DqlhEVcTAFRO63wTIR1tHMPWMFvSIHu0OcZR65Z3PQgCEm?=
 =?us-ascii?Q?J2Q+vs0AtTHZNcIYFdz84sNr8RJ+180JhNYY6r1g5Pmca1sSirwg8z1I9Bvo?=
 =?us-ascii?Q?v7GrrqAiAi/DZRzmwKDx766lTSD9VLcxLVSWVi2RA03eBTggVJM4FBeuRFkh?=
 =?us-ascii?Q?gmV/gD4AQyi8+8saN8yjqHTHR9qHLTEIAEe+90zqq4aIezuG13YgpClwWizu?=
 =?us-ascii?Q?NE2mmzmXHE6Ux2IFkZsjl0zqftlTlNQQmiNRKCpVDUxlE302Ym0wBzlWMNzJ?=
 =?us-ascii?Q?kck5N8GBzWvh0QpnFXNqEyKC6O/SYwRvHkYhOTXASQ3hrmmkbOiHzqiIIeR9?=
 =?us-ascii?Q?I3LA5h6km5fGORK9lyIHdl9nkprt29hXMKQIhKyVkND1ZMRfIWTlcWSYSNhc?=
 =?us-ascii?Q?UhRRwAVq0NYkf7morUZzHdo1lScZtFyisbGyVaBqUpAMExvvc9tVrGEz2XJB?=
 =?us-ascii?Q?0LqCihA5+/B7fvRglVhLksI4nv79OIkmpPmcwrVu2F3bAHyHlEs3VYnmprKM?=
 =?us-ascii?Q?UDrAqMKJ/5WVfKbOIdzOomG+P0Ic0fPG7Fo20ghZwg5MTnp5bPIhDEH3eowB?=
 =?us-ascii?Q?4ewodiGnHSK7LUBwBeTru0CgjcX7b7CqLw1hAt38noVGPUihR+CxNdS0gYdW?=
 =?us-ascii?Q?wrfrlzT79jrNCcuUPuo0+cmF9DlpErFTzSf7AvAOiM0uWtUPHaYdU4DFwKTD?=
 =?us-ascii?Q?buE/et48SplAsxZbNeVrnOmnVqUW8B/7AZOO/oHHRYK46VFT7fkb831tfd1Z?=
 =?us-ascii?Q?fceJS8gZy5I5CUnhYgdsw1fIWXBLKi8sbHytPqd5FCEsKxCJvLQzODHBaQGz?=
 =?us-ascii?Q?4h55of7Zy+7yQAd6S4iTygYXLm428JatD5H0VcL8c/PbfNdZJKqgJ8h9VT2y?=
 =?us-ascii?Q?o8OzcGlNasBHufZFwxKutBH11JI2zjMT7FJO/NOfz5BE/RysbOQH7dglPW8q?=
 =?us-ascii?Q?xORLyFwNTTDuLKWWJ5NdMgukbJ11d4sY1PDA3aive2LSwBvk1dLr0sxSezjf?=
 =?us-ascii?Q?X2YXdLB0zh00O8nI36zdPD8KQdxn396BZnLd0+15AzB7YkLKlIa+UpbDu8Bc?=
 =?us-ascii?Q?e5apCzBonLQ9ke474Dzi7VdaheZ/h3DnOUbWH+QEP7xbwQjPbM+zhGldB/lg?=
 =?us-ascii?Q?3ek6d0C31g9I5ShrnAuipGQCAdl7vVvVDIE8edoS/gdxXg2Zfe/TN7jlDKYx?=
 =?us-ascii?Q?4iu1y3Atylq2WNKJx8+49HZW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNlfgvJJ8amasERGqPTTGjbwwYxK2nUgIgNNc4vSnmcTp0HxBF8Om/qiSHvf?=
 =?us-ascii?Q?fOvMzLgYvwUUQPg+nhDQaml3M+oL0TcrApD0+OoaGTtthfW9pX+HMAA9wTnb?=
 =?us-ascii?Q?B0gV00EuNO8wglP/IHVDL6R7l2QZIjXntl936ZCWxtQR1cSVTFFJ6KNOSydW?=
 =?us-ascii?Q?L6zWoyr63bqZwuzXnmxz+/IzB1PJdL3cNko50zV9yQux3CyP3Fl48r2WY+5c?=
 =?us-ascii?Q?440Q7RhgR/+nt68oLiUVTh5LJK+yyaijJBZcT/jhfYds6nNPF5rW2FgjDWpq?=
 =?us-ascii?Q?bVC5D0Qzl9mc6+/DfGJS9ANy0MtdU+ITwgerXLRB6M3l+Yk1iZb5EW6485oM?=
 =?us-ascii?Q?dP/xkJjxL34yV99IghQFF3JBw+F0SbuAriD5cmzzKinuvhzRrj/GAE4SJ5wF?=
 =?us-ascii?Q?2VaLB1kbjavQkOtza5ZCxn7t+jqxqlWIaJFE+RG28yckJ35nUmrkMc92p2vY?=
 =?us-ascii?Q?IeNeg2Jk1koP2xnzd2niT7GdRA4c0UejU6qm3E6YqbKekbaJnl/oyRduk/HP?=
 =?us-ascii?Q?oi1Zfgst5I6Kn/1/qROTUQ2RdWolyTahYFD5I4hOZ34d36VpYZUxVJwa8EBy?=
 =?us-ascii?Q?r0CbNjr9Z6pK+UTARcetcV85nAmWKBINgSBoWEOEkid+dPKsg2LS2j5ag4sN?=
 =?us-ascii?Q?HXAYBUa/G2CT/WKqOx3xyG5iTa5Vj8+2gq7Q09vf6iLv0AXzfexQGGHm5Gli?=
 =?us-ascii?Q?T5Tm+43pXTtWEbhMEyaGfrIWmrlAcLaDlnTuMn7r5I1gSYyyOd0RHNNvWt4l?=
 =?us-ascii?Q?o/HyzusDkzYMD1qw3wHN3r8b24aHnoK9C1eA2MeXLNr/tc82TuJynalbS0Tk?=
 =?us-ascii?Q?TMmYOR5u4WrwJd/malJ4piio+ldgo6mO9tmN7pZ7amsCWHpIBgFxlRoei7xi?=
 =?us-ascii?Q?4jmzrdHfUrv34HIdMT3sCJpWqKTHHakOSHkpl5640/JgWMYXsTaLi0FiBuUh?=
 =?us-ascii?Q?0Pqg5h6tmuupteqKysKL2T2E76MnvFD27l23FHzsGABDcOdIjrSNEnOfnAAH?=
 =?us-ascii?Q?VEsJaLsQmPl6KA0pW22JqP2E3K93R9Ewkjf5c5Rx0PpY3Ibg3wcdOyAIxFwM?=
 =?us-ascii?Q?uDnOrmAcoCuBu4GiBax7VKAV2oRf7S8r/PDJyhUZJZsCyE82rXjW7F5fH3l6?=
 =?us-ascii?Q?aD1QiA57owyfw1P+yC9WEzTanVXl5u9ljhgK8TxKRYAjmSW5s47jJ2UmuMiA?=
 =?us-ascii?Q?wHmnBC1fGIsNLvJeYveRNnBgCXfxbCKfeu3N9wcMjrALwVVo3/L4S0gCMguT?=
 =?us-ascii?Q?LlXevOLSySNHvtnpJp944JPODJKHgupG+2pdQW8BPQm5QVh4W/Iduf36jYW4?=
 =?us-ascii?Q?RMFTbCxdpR4I7zKipNUPdMinBbFY/IThSSvgyMByu7H36cGcWhPwT2I6tJ36?=
 =?us-ascii?Q?/wAepenfDhOsOTdLi1Sfe+Z7ijvWnNA+7Dkzff6u6PkeyvnLlMLnXR+zSVgm?=
 =?us-ascii?Q?8wmQgoQnEmO1f3qAzaN2aL6ba/QXx7e7QuvM2diewKQcKNRk9LIt5A9S+Gdy?=
 =?us-ascii?Q?+TZaRhasjdPRy1MaLiUjxYD7uIeNUkyKG+zqwb69a6zW/wMrKCSh9uN8Jfxe?=
 =?us-ascii?Q?NkB644MEQ4jq/IM2ZEK6upxprWK1iDhAooqYBuh3jamJwFWzL0MbewfgiMiB?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deb64c9-bc4b-46be-83eb-08dcefba9bf1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 21:19:54.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0oeCpcEwSOoBonDGPVKLjMqNhKHDaTEa5c3cMhqNG5WflkS6Jl3A3stsjy0RJYNWMmp8GNM2UuRxyraVm6lQJwcRBuCBlZWKY7xHtSPkNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8121
X-OriginatorOrg: intel.com

Huang, Ying wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > Huang Ying wrote:
> 
> [snip]
> 
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index 21b877d8582f..d709738ada61 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -1926,7 +1926,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >>  		return -ENXIO;
> >>  	}
> >>  
> >> -	if (cxled->cxld.target_type != cxlr->type) {
> >> +	/* Set the type of region to that of the first endpoint */
> >> +	if (cxlr->type == CXL_DECODER_INVALID) {
> >> +		cxlr->type = cxled->cxld.target_type;
> >> +	} else if (cxled->cxld.target_type != cxlr->type) {
> >
> > No, the type of the region is determined by the caller and should be
> > gated by the region capability. For type-2 region creation I doubt
> > userspace is going to be creating those vs the accelerator so this all
> > seems backwards to me.
> 
> How do we determine the type of the endpoint?  Specify it in type2/type3
> device driver?

Why does the endpoint type matter? Memory expansion can be supported by
HDM-D[B], and an accelerator could have one or more HDM-H decoders.

> If so, we will specify the type of both the endpoint and the region in
> type2/type3 device driver.  Then, why not only specify the type of the
> endpoint?  The type of region can be determined from the type of the
> endpoint.

Because CXL HDM protocol is per decoder not per device.
