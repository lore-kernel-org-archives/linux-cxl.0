Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402928248C
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757464054; cv=fail; b=C6o9QPasj/LUWP74ted/I0iOvxymVmmtCDU5bqt4poUTtsF1emm6rQiXm8ixgXLoeZYphAUtP65rFFEd365NJbcKgIuIA9/+n6Uq/4xEbPlSR3c7YwNE6bbcXgwA1mJiQ/2CLM5GxDUBpfVddf35LMxWPo7++iGhwQ6+wUk1wtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757464054; c=relaxed/simple;
	bh=Vop8uJBIvDp5r0foWRBj1JPsepQ7/XFl9+pYdvXdmHo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A90T2PrEkVQ4gkAtBc+PHQOKF7kCv+FN12KccNog+9tz2QwNYqZ8HsJ3DBEh1SalKLNfzvm3vTlgw5dms45oEI9dPcwF/JGrBitTH19J2gsq1vsytwYRXiplUzA7ZWOGALnpKxUvVAYVY5MyU0gJJo08VW1A6wQ6avPDLYjUhUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSnW+VI4; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSnW+VI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757464053; x=1789000053;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vop8uJBIvDp5r0foWRBj1JPsepQ7/XFl9+pYdvXdmHo=;
  b=iSnW+VI4Z8TjR+Mhcx6HnYNF1GldO7kjQ9RtdLBQSiIbBK7UekPm/S3N
   CDnzZr2ZDkiT3LyS1J+7Qa4lEi34FnEcq7A0pWHxC94pvDmhpAxFtloe3
   z+HId2TPHj1mcuHTSQVcGORtzPyi9mJCdHLEHus0lEOzDkLYctZe70mcU
   wi/FrsK7nMl3i12+hvqw9S2vHSNkeTEKzsasa0tCRRdXALX8bimsXUZYl
   +ZbK+e1HBadPV1n8M4oBwDoAPM6vmK1DWTqoppqAIjOgKvzk28sJQkyIi
   nJ93fb9IH5il/Bn3smxeEPdJ74i4/mP8FGasfUk1MVTpiH1bGCaubztQN
   w==;
X-CSE-ConnectionGUID: QzwqhcedQRex9HWUJs+LBQ==
X-CSE-MsgGUID: RRG1Oi61QNOtXYNP5Yw2fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59715107"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59715107"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 17:27:32 -0700
X-CSE-ConnectionGUID: fA6YLROFRVq9zEUT/eX5OA==
X-CSE-MsgGUID: GvESIkJgRrO8hy+2vRsmcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="173149002"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 17:27:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 17:27:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 17:27:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.83) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 17:27:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q06ffrkAtXhZ8zj1+RzzwcQlDBnOtSgi2eQJaAZkE7Qvt191Uh2SSNLIcpATdRMX2CCHFlYIN0FaBoAJHSVvqiDPukhA9WOKaQAY1/10DISi9EQJX2s9OsQqXpTLgiAytNHvZ6RbBNxMur/RubQCw60LWHq6Oa4OhtHCwjv2aDaag3VK8d5h4V4eYHXeI2GXXPXL2EQLAdgjXeU3QfY3aiCqrKetY3wTJSCNBEKMg2icbI+IQuiY8sk+FotfkoaGeD1lEJo9xQBl+oAbqfD+jAsO6WWl43+xqeJmAGDyclM7sRBEXrFBcNlAhuaM9gOD224ra2sDZOZhVLno18YtaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qGTFAxUiLxcwdJc5KGZCByhkI+JaDmy7tnYnL5cpXc=;
 b=lYpJRTBlx02BbHiKwdBUW/Amkw/5KhGMgTB6RQI9rpUF7hAmQXIfY1cS3JjmIcDAaVb+oRbolsFEKGU6QB4SmcnCF+72gVKWjKQMD/hSE+Plg6dtYP99biUsqXmvC++8e+uqKKCznEeIRQlGxwHJH7+CzYMsyd2Gn19P77cpXF/z6rbnVMOw5PsoZnoyEwflQKHk9fs+E8H2rb/+vJMWzqCsXInm05g3zHtub7DdWW7YJeKFen0Mke4sZTqJe7zdwSrzgPdkgGq6MWUABzEtiJ+VY7Vz9lpiJ0wbyinIxLanpTC2bUA/RCSVwXNj8cLuVNv9IwJVuCQqqZqvrMRYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6113.namprd11.prod.outlook.com (2603:10b6:930:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 00:27:29 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 00:27:28 +0000
Date: Tue, 9 Sep 2025 17:27:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v9 09/10] cxl/test: Setup target_map for cxl_test decoder
 initialization
Message-ID: <aMDF7CSyYaGE6vMR@aschofie-mobl2.lan>
References: <20250829180928.842707-1-dave.jiang@intel.com>
 <20250829180928.842707-10-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250829180928.842707-10-dave.jiang@intel.com>
X-ClientProxiedBy: BY5PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb33b9a-5bb8-4c98-a98f-08ddf000d2d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c0ksMNSl2+iuiAC4aWP80JUovJ5zFwW5Cz5GY+W2Fej0CjDwjZqD3uY2Wh0p?=
 =?us-ascii?Q?k7FI5jGtCaXZN45cJLlcg6B7mfo7pVOz6g2L561a9PnHRw0fB8zV5+4a6enm?=
 =?us-ascii?Q?5hAlbl/KjGuykfeb9PH4iRXZkfyVe7dh5OWE9t2zi0X0NN8Ey8K8G6iVqiMX?=
 =?us-ascii?Q?AmZUOOMgrh5hTD4rwHLKzSCnGF6BnBRcJLbVCqBazglULBKWXzHNv5hGDzl9?=
 =?us-ascii?Q?YPEA37RZgvEEv+eSZH9ccODw7g2itNvOzVKBnNG7KUlWYsYAaVQsK6SsVDQh?=
 =?us-ascii?Q?rItVzAqUp1tIEY0tMLfvtpS3Hg3NWjNACys6zApPJyoKmYSgeX4H+pIJcIRE?=
 =?us-ascii?Q?hK10UlEb76tbdCoG4xBX5sYorXoMM9NAkvkj7RjU69xaowQD583UDfZJrrjN?=
 =?us-ascii?Q?q+j+y1MLXEIbnIRRcTyh0SyIg0GgJ6VVj66e1UPvDDHW+pS5mb5p8JzI8zSX?=
 =?us-ascii?Q?2nq0QDOHXG2kryccLuyWJGl2BLLmkJlgvIOwqLH67ELPcPmkY1QSUYPNQYpC?=
 =?us-ascii?Q?VP0mRt6lxN3ojp2qnGOqM//QJUr8PApezQZcdtPWb9iiZqzUP8S1Q/JdmT4X?=
 =?us-ascii?Q?0iC2LiARSjd65487nfQI1peJYv49UWREKsEPf2g++5+aeXYTiPNRvUmgCcfV?=
 =?us-ascii?Q?DB1Iyw5pw8Gfg7wec2qh+lrKW+8cNvb1wtR9WgEqY7B0J/PVpSQClBl1Ubrb?=
 =?us-ascii?Q?1BmcsLj+QSEzNCSI7RaRoc6DGfmd6l6Op4VU04yHmAlv6G/W/RGHnLQJH7Jf?=
 =?us-ascii?Q?Y4uAXsTIOy8l+VHFnEMSrtArMAkyM9cz/ko7Q44ep1wrFBPderd0c7sps/gw?=
 =?us-ascii?Q?7ilrcfShhUZZbKe2fsjdD0z71lUqIGSG/I5owvpk0M49GzqE3D3mGA9yBz0f?=
 =?us-ascii?Q?NTKLG2fVSCA6JSC9cEwam4pfz/+7tfnYfYM5dUnj7GK/4e6Lot9RyjhS3R+Y?=
 =?us-ascii?Q?1Z1xrlqYqEsOk2TYuzfG9IYtc6bzWYLj4deDs4OIUCOOUAbv+jvD+Dnuysrc?=
 =?us-ascii?Q?RGQcmIbb54Mgsmq1kM1g9I8fNujldg7Pzxl/Vao1ZrAU1NQvrocgb1HocDe6?=
 =?us-ascii?Q?ZJR68ER+PkYEnYC/O9OnEmB8ILMWqLiMqQ2Sc8w1cmK1+QfKZ+yNs1Y6efiD?=
 =?us-ascii?Q?eUNQHAS+KUEqqDVbIYcfrv8aKOXRCd7rgUq31KMstlxAyxUbbWjHwSL966Ty?=
 =?us-ascii?Q?tehfgtDzRp4r/KIrcoGAvWiQPjO/4+seUZ8H2vvNOSEVGJTtMm1R7dfOCw9m?=
 =?us-ascii?Q?NpNR2F/Cu9rcGL+DlYJ2900xRnSUm3GsP6vUVfN6wUugm7usQliE0ipBanF+?=
 =?us-ascii?Q?A8cGmsVmEUlFCGAn5XW4ZHa1fxnlLjOdDp3g6wnRZa3d6oAML9H6I/xJlL4D?=
 =?us-ascii?Q?lGz4qRNhb2eIgh9Z7Q9y7Rh09NMXTccV+bwyEUDYqOhD/vY1JPL3joeVNdN+?=
 =?us-ascii?Q?4suG8CSBHUs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+3ghKPsRw4dEBElNcZvlpEfDosif0jDGnXp5M0lyiMbxrv0uJP70TqlKPZrr?=
 =?us-ascii?Q?y9445u11ch1Rbq8a0ohEcQp+egbAcM8RqD/ZzAgxccmoGANN6jw2fzUXo2ce?=
 =?us-ascii?Q?mJYHVCXVBqn1GEkNGflET5zPeSM1K9Lu8POe92tl/dXdP+vC2Aw4fnNJdpwF?=
 =?us-ascii?Q?18u4FHukodDbj6enC/tGCMDBjLA+sMpI7gZuyCQCKzUJ3OQwgTpV0uS8E7ri?=
 =?us-ascii?Q?p8wKYR03SgE5nOiMZE+RMu3KFVhoEQgkggPWp4QQUjMtp321iXoE1WlVaCy/?=
 =?us-ascii?Q?kXPtMLv28AB8gftQskXOB9xztK1Fn/Ruwtfm8twJXRX1z4CKVkjsBneFrPXJ?=
 =?us-ascii?Q?27mfO8zEgLNeJViMjHhHtvcklxElWkFoRuTlvDtltlLLJT3n1QzAwBm2xFw4?=
 =?us-ascii?Q?t7deYBG+JQsj3Q/h+fLf7qXRCd4rjC9frmhBrBLzVjinl1psMCiCwB88k4ca?=
 =?us-ascii?Q?y1zhx1kWQREBoFHynalzWZEwJnWAY2Q6DravoReGSG+9bbL491LT0+XaZ9tV?=
 =?us-ascii?Q?malFEW6ctUf0a2bcGpxNh4gE2HepKJRMBfyfbHYJK1aID1op3uvqNvBVMre+?=
 =?us-ascii?Q?OR8ORJX3c1+HR/RpjQ2O1KrEHEQLYWna8pVXLC+SFMvHb+rCfFyblaO72XKN?=
 =?us-ascii?Q?GxckecYd5FBx85/EOogwW/gTT2ObEUSIxCYB6XtUgTyvl2g0Wiz0iuwqxLid?=
 =?us-ascii?Q?ehoGnK0ic4PNa3rTXoyrVCGUCrpVBw58IN0McxZTrOPoJiDyteHZzyukZghc?=
 =?us-ascii?Q?Dj0pBBG+01X5CGlZoDIk2clrWE2/qFFr62BfVxIaw2e9GywF+xY6rFD00lJG?=
 =?us-ascii?Q?rMzIc5ukgNbYv+Ip5mVV+Ph07zNrkMjsPVFvHuns8ML3KU/I/+AtY/cFc1Bc?=
 =?us-ascii?Q?2fl3uZUI/QkecH2KR0Miyo1mu1I0/cFYxerIzISSUJO/oj3NvOjh1jOs1GtL?=
 =?us-ascii?Q?ss6VTkc8RKI/YpVr2SJ5vsq0fN+Lb+6kEAR4ZGvtC0M34R/NZ3XQbangDjpz?=
 =?us-ascii?Q?aLcRLzui2Sscd2tqsUSzNINFtHEn0MMX4KSp+tSP7N68dQPQ0VCL2GK4Y+Uz?=
 =?us-ascii?Q?14MtHBIPPRvXfo41uHioPB/Ag5S4O2txeL+44923j3+pcHv3gNJGzEUzRDUi?=
 =?us-ascii?Q?+kvh1v5TpuuY8fFKMp5Bqvp6iKzp310c3cYdNwCKBOx/eL55J5TDlXc1jIsp?=
 =?us-ascii?Q?zEn1+odVcRhT9KRtZOit79JI+a3PJb2MS2aPvFh5+SJ9y7qATt4B3Nj20dB5?=
 =?us-ascii?Q?TbHRfWt+K+J4PJICYedF5OscNDVlZmReCVdMrpGmd9XEi6uIGk6sGEMpaZ3v?=
 =?us-ascii?Q?t9ht6SA/iDLVk2+WPDyvOPfFsUg8snUlj4AhP0IKSJdSHx7sHFqpJ2V8nruQ?=
 =?us-ascii?Q?rk8vvBK3OwaUZQm1F9erJGrJ6zyaSDv/KQjQSnVW57tKN0gctPI7mySE4Aqs?=
 =?us-ascii?Q?5eQjZAma56QGi1stg00Z9zzBHOxzkrLQK/A6xCgg+ONTXQ8NbBH7DUtCNP/T?=
 =?us-ascii?Q?hE0aTy2ND/Cj8HW2KsdN75CBjRL6P2CZ3Ajbjp5tYVQa4T2vzDkFHtjR/xFr?=
 =?us-ascii?Q?xSIuvrOdgt7zvRIZmXoVbAIR+KFLjuCikqbApXgcZmB/c1iQ5XGzWSvcElfw?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb33b9a-5bb8-4c98-a98f-08ddf000d2d5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 00:27:28.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlbjU55WN4QXeKoWJDSQmum/YpSzBQKWUcSBEZ1YMpBVWMtKkADnSdbVwxEaEW3OKEppVlvHw8529Vl9yTpaOsBdhYV0QEXkJfeqSqCSNbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6113
X-OriginatorOrg: intel.com

On Fri, Aug 29, 2025 at 11:09:27AM -0700, Dave Jiang wrote:
> cxl_test uses mock functions for decoder enumaration. Add initialization
> of the cxld->target_map[] for cxl_test based decoders in the mock
> functions.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
