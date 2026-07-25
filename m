Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A53164AA
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784943736; cv=fail; b=a90qFl3sPzNUbfVYlAPWtyLMVJxXrQq7lq4R/LiNjHgePHn0uNerJerswYgbMf3HdEdFbEqYSA1hKqZLmIsC37+FgPTxWX88N/7FC7jzu1k8VqO7WnegyoLQH/XHc2ZGQGLgPJ2r8pZy6fRJ3qMjsIsReHACXHFCYlv3deXOmyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784943736; c=relaxed/simple;
	bh=sqlPb8VVEFoxwQvEnuIbpk8m05u3CZyxNc5ZpD5bp2w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cvYrJSO/fLbEom+mNkWqi41X9XmMvimlmIqZba1Gf9MGo5ed2BN3qJseLrLyU/opjH0Zb8neyuGlXoYiaFTLHQ9V++XoYSZ4gxfN99G06bHjVcxSduyxXrtKC0okd8QHX+w3yV2biPIXfghrnT9Hub5JiGKkoZQ/jXmNmAMyXAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUJQ8ais; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUJQ8ais"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784943734; x=1816479734;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=sqlPb8VVEFoxwQvEnuIbpk8m05u3CZyxNc5ZpD5bp2w=;
  b=eUJQ8aiscksRdsDyJ2hSCQ/sLwt0LjAtqTs2D0yxe29M5u/qxzI2G4HU
   lfDuR6CYdIgUBWyvb2yO7NMlx+Q4VPsdAhcYSrwUqPcly3k+WZkluIbvh
   CrIYB+goACr1eW8tm5KigBA15FcdV4HYwdLctAJ3zDJVEifRZkMlS6vpE
   KJn94EKoyf4Q+/QAPE3m+cMOH/4dFT+lCOW8WdHSeg7nYlHGUeUZbLCKf
   dsK8DW+7vdJETxJfg0HGV3WrN1AUNLzCjR/ONzhwpxWuSWGUF+8cALQYr
   AxYd4dxUlBl80a1euY+lyYod/A/kg8kFZr2DmZonF1oG83TZqg0OueUDp
   w==;
X-CSE-ConnectionGUID: sKYwwi8FTV6Iu/zATeI3qg==
X-CSE-MsgGUID: UfDL22keSuiqFBSGKtGp7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85657051"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85657051"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:42:14 -0700
X-CSE-ConnectionGUID: xoAM5k26R5G4cI9EIqBS3A==
X-CSE-MsgGUID: BS7clY3lR/mxM3cK95xXzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="259511680"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:42:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 18:42:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 18:42:11 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 18:42:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1emxFf5Gs8/GtYWl5ZUXlWkNTs5h5M1SZsGG2EFWNVYYRCUoszcFU5eJlpKz4hOPpqAv2dNj6BRUlM1gMLyo4/9r+ipyFuPHqENqsMkOmCjeIdtIhSkYnU7ViHueB6D88AxLehBMHMiCbrR4JVLe1g2JgFXqBrWk61vx2Oi6LNxJi14bFIGVNP9Os0j3B4MwKlU6mcf/Z7pRhrOlrpAdEAD84x6MndEYIfS1JfnIe5rKBh6jeujdXOkVJ40lfjUNEbn1fl/8OqMqiy8JsVi5ZO6WAze/KYP92bo/8SUhKEDWIc8v80nFgdqniiJ16Ie7f1sD97mnAuNjTbepwjJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVkGAJja0P5hmnSjzN2z93Inw4sPV2xjd7Z4ymb7F0M=;
 b=k8xOJr77ChFdSDbCE3S1+oCmrTDNAyoLK660gwkpIq8IY3Cn3ZDnWZJzTrC0wUOUGY2p9K7zaLwq5c4cfBsNw7Gu6HmCZ417oyLHRPoLQYrnjjUOBp8XlSTAcSJpSzaF+jIiPWXR4pA/UsEblGnIFf+46dYFmVyinBe0qIxtGpM5uxlpeKF1wda5Uxda9uYjNYa7SjfR3MlAonY3njaNUmZSQ4wsmaldIAS3u/fYBtSV11fB0oVgz110sHR0xPgwPLfip2ypXFTkVcXeTYUvPBUEQgLGNWKCw7yX7nBVQeyQv6UMWKqyJRbfw3f3ErdMSClCiawhBoRGBcULcaZuiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BL3PR11MB6315.namprd11.prod.outlook.com (2603:10b6:208:3b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 01:42:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 01:42:03 +0000
Date: Fri, 24 Jul 2026 18:42:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Message-ID: <amQUaL-OmYrTWZZ2@aschofie-mobl2.lan>
References: <cover.1784940306.git.alison.schofield@intel.com>
 <5b1f9970140ad1ea5924de06b7e6879e3b9deea1.1784940306.git.alison.schofield@intel.com>
 <20260725012637.F34231F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260725012637.F34231F00AC4@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BL3PR11MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc57b1b-48d8-4e28-2889-08dee9eded5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: diOyzVZY82R/n+4tDxpwSwZ7hHPyvk5EH59bsI1+6pOQ0zeTqc3EewVs6z3agOaPHlyLN7CN9SoXwzyk0l5vz28CTG2XcDUnHid1RPq+KTsxdccvb9GNwqUbQyjjNAWi9YpO50+SLt6tTAQKRf9N0FXhRnvnqGk/C4+eY1i+7lLrZT3CnpSKYUz04XGB8to1WWMbKjf8Qb02Crss0kT2ka0/PoXz1gKVPtTNpR++X2YXpFzAURu4f02nzOShfgOf0S60bftXNFVlmFdwEl2FsuQayYugo2HDkjYIdCR3gBcHkM7uIkRxFftijBUPbimGiECsUsu2CbI6N3S4tCAWJGc81LPDSHyEOo5IxcHENth4gTCXXvovtJrtU5ozXSeCp/Xadc4A2Kd3e1MPIXRw0fBWRScIKNxkn3GLHM58FYYp8qPkcwOcZNXdBY5WljDUAsfP9ieQxyRKIpg3b0yz8NQXtcynIOy7Fk2coZNztbuBtkfzpiZ9SEaJ9m46h/J+hhaHep8WknluOtjDxG7BWY1Mj9szxxceHLyoFFgYILMwczgp9Prk5cl5tKhxqW9Yo2vmhGaiKyiADsAhqLx0+92jBZNMS815fC4UIrMVEBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ARC/n24knxRE3dX8EfFYHHlo4ZZ9skdF/hnku/N/W8LmkInEjyJE+eUgj3?=
 =?iso-8859-1?Q?gZANLYt76x7K8taQgurzvWU2OaaP9XeTw8sH0QLKPYvp5+CD+fZ0UyjArT?=
 =?iso-8859-1?Q?DPwjpJxjzoKTNxkASqT/r6pTp1iC3ELUpmVmrlotjvtGbOM3NI+W7vOdCp?=
 =?iso-8859-1?Q?TOh/+Lq5A/CATDK/HMCp1r0TtpAny4CEA8v9JMQEaYq62bT4yP7lfxwhn7?=
 =?iso-8859-1?Q?Wkj/mN4JBmf3r09upuqLIEHd2IX/BM1vlHfztxyx3t0fZloawY+vSjh+aT?=
 =?iso-8859-1?Q?Sf1LsKhXDB7S4EndUXcDUyIUqMjpNH/OO1E73x2X/a0w+X+mzKIQnPchxG?=
 =?iso-8859-1?Q?LvW72qiwWN/ryNobE6f36bQHVgL8GU/OOwHEcXDCvNVGgKscO3wJmEUqmh?=
 =?iso-8859-1?Q?Uedce8ZzeUZg2KU+EQqBF8GC53PLOOQUQZtdKejIDKOpr2l4INO23I2x3y?=
 =?iso-8859-1?Q?yhshlxfedQc7QP8Tu4NLdRsOLodydiYa2FwtAGdhR+AY2EXMJDA4nBS7Hb?=
 =?iso-8859-1?Q?SM/ELTuRLOASpVLczCYJOCYUJUTWgkOSr2xHOMpzh24FU+1FokzmE99sx7?=
 =?iso-8859-1?Q?wODvh3NxUOK26YEN6OwvHTvrXIyZ5n/ilKe0j8K9nznHtooCOUJPQMpyKp?=
 =?iso-8859-1?Q?eVjnvY2spT2983wxglpUdfNG2BPUrfh/efTGTVnai+8PyqCaCkAPMV+wcY?=
 =?iso-8859-1?Q?LnEpRq/6lytrJY8ohsnqWEo5MCS/BlGq+Qy1j3TfkeG/RUlL3RQN8dMJiB?=
 =?iso-8859-1?Q?SKtpZbQnRNmjQFHz7YL8Kr1NKJmL7BVci57k7kxUbhbrx//EmI9WH5KuEx?=
 =?iso-8859-1?Q?1er77pqNqy30YC9OElfBLh6cuO+dz5yGsr6v4Xm5God4X4RHHCSFtQYF5R?=
 =?iso-8859-1?Q?qO4Y4/OlsbbHjFdmkgssKA+kywKLMAVpUDIGEU5zJQvJPwnsnfuSgQFxor?=
 =?iso-8859-1?Q?96j41MuZCTAzfwD7eKKGUgL1pawZZpTIOv+BqVx2TKB8nLY38quE8ng+9O?=
 =?iso-8859-1?Q?m2e8AxaQlX07Yqy3QFCVPuWeVfrNHknVfwO5zH5pY2p9pSRq0PFLqDS+iW?=
 =?iso-8859-1?Q?1AFFeQhthzoUzHOVQgTwkV3Imp4xA7KOFN/w6PR2cRQg5k6nobzceEncsh?=
 =?iso-8859-1?Q?q5DSn42OMUB/Ja1uHK4HNXCQ55yP5PW7n/DkwrX08qWWgIIWy0V0SEAoc5?=
 =?iso-8859-1?Q?zBzyFgHioyaogQlpWyV2vsn+PFuQndHTXRd3irrKts3xOCANir7SS1WkRB?=
 =?iso-8859-1?Q?yzX004uzX9MjJXMmdraN6tCO7hurR1OOd9VXvbm8LB7wF1JRi+R/yKfKLr?=
 =?iso-8859-1?Q?WIgMJLtg/7mQq3HHQ6cTxf54nx6i3inx3JNV0UvT64fEZzSIHI+vhoauYy?=
 =?iso-8859-1?Q?8FHA+HzZSeBP1GJ4cwM/K9hdnZe5syWrfTLrW0F8cuECNXO95iDIpXtg3v?=
 =?iso-8859-1?Q?4K7U6h4xl3YlkGjLOVRC8UksfpFX+k1+nICR1l2DtPRMd6dFY+xxgXyiY/?=
 =?iso-8859-1?Q?pOwnINEDNpXqvRN2bRSE4+wSj3/9wiDLZ7vgKuSNnT2/Ry71w6xuQrxEAC?=
 =?iso-8859-1?Q?dP6wPOTwn97A6n8Ojsq07/M9PiE+FVbqS7WoyGMhLcDVlgxqMb6yzszXSg?=
 =?iso-8859-1?Q?sQTlzdmzxV/gayemPT/B8UvOqkibUzoOiGZkulzlEb+fNzpK/BjdoFyUGI?=
 =?iso-8859-1?Q?pVitfTjtqiM529Q3BGjnX/RVZZEJsZosE16PTdqnRuhJuvYH/BM3ZVWFsM?=
 =?iso-8859-1?Q?qGGYRvHODvIjL2WHa2lPgdW37szt9cbRS2Fb7pqs8M7YZE9thi7NZ+jKk5?=
 =?iso-8859-1?Q?qKRhQdBr2V2ZZISCakNb48dzTVuvyIE=3D?=
X-Exchange-RoutingPolicyChecked: lhUGyCbtYCBJJ7nhVs4ZQ+aPh0EIMCkJWCzSlWeidF2BLRmQeGmrQNZ6HOm9hz8Gn2PCnX2F2rnW/7yQXsswrZ/Jq3oj+PAFMAecb//R5xPxBYZeP3JtGrz0NdL0hRZZsanZ003F2C/aYeOrQZh30Iwm2T12wZUNBGcRwbSBfnMQdh0oHlLIFha1QCkY2w3VTe8XQquvFzEjtmtXuu4e+2FuxIhPDNRmxlqOfKcVyr1H+5UqfM1sMSu6jD5FTr90H7bsJwpudaqfdxqO+ypY8quLmy83wTCWd/ALr+fF9fXwPsUOelSZhzRM6lKxkumUXfwHQuFw5iGO+YJgt2faFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc57b1b-48d8-4e28-2889-08dee9eded5f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 01:42:03.5069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebywEhmzswxWWIsfFsHXi5vxVRY24kfiX0aZuB0+vC+v/wrYbvHQTLR+DQVCsE/clASjvXlojGnYf2oJ43rm9xyMa8igLKtwI5Nn9yPDPaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6315
X-OriginatorOrg: intel.com

On Sat, Jul 25, 2026 at 01:26:37AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] During region auto-discovery, a passthrough decoder's interleave granularity is not updated to its correct topological value, causing valid interleaving descendants to fail auto-discovery.

Same NO as in v1[1] (and in v2).
Gratuitously updating the field is not the right thing to do.


[1] https://lore.kernel.org/linux-cxl/alKP8OP4DNT2nJnu@aschofie-mobl2.lan/#r
No. A downstream decoder can't inherit an unecodable value into a failing
check. A >16K granularity only appears below a wide interleave, and
everything below that inherits an equal-or-larger value that an interleaving
decoder couldn't encode. So every descendant is necessarily passthrough and
never validates granularity. There is no path where updating the F_AUTO
value would prevent a failure because the failure cannot happen.










> --
> 
> --- Patch [1]: [PATCH v3 1/2] cxl/region: Allow passthrough decoders with >16K granularity ---
> commit d213bad3e4cb8647e64aafb5eacaa82258aa533b
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/region: Allow passthrough decoders with >16K granularity
> 
> This commit allows passthrough decoders to have computed granularities larger
> than 16K by treating the interleave granularity as a don't-care value for
> non-interleaving decoders. It updates the region configuration to skip
> validation and hardware encodability checks for these granularities, while
> keeping the computed value to seed descendant decoder setup.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> [ ... ]
> > @@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> [ ... ]
> > +	ig = parent_ig * parent_iw;
> >  
> > -	rc = eig_to_granularity(eig, &ig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			256 << eig);
> > -		return rc;
> > +	/*
> > +	 * Keep the computed granularity for descendant setup. Only
> > +	 * interleaving decoders require an encodable granularity.
> > +	 */
> > +	if (iw > 1) {
> > +		rc = granularity_to_eig(ig, &eig);
> > +		if (rc) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s: invalid granularity calculation (%d * %d)\n",
> > +				dev_name(&parent_port->dev), parent_ig,
> > +				parent_iw);
> > +			return rc;
> > +		}
> >  	}
> >  
> >  	if (iw > 8 || iw > cxlsd->nr_targets) {
> 
> [Severity: High]
> When auto-discovering a region with a passthrough decoder (iw == 1), does this
> skip updating the decoder's interleave granularity to the computed 'ig'?
> 
> Looking at cxl_port_setup_targets(), the auto-discovery path handles
> non-interleaving decoders by bypassing the granularity mismatch check:
> 
>     if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>             if (cxld->interleave_ways != iw ||
>                 (iw > 1 && cxld->interleave_granularity != ig) || ...
> 
> However, because cxld->interleave_granularity is never updated to 'ig' for
> auto-discovered passthrough decoders, won't it retain its stale hardware
> value (which could be a don't-care value like 0)?
> 
> If so, when descendant decoders load their parent's interleave granularity
> earlier in cxl_port_setup_targets():
> 
>     parent_rr = cxl_rr_load(parent_port, cxlr);
>     parent_cxld = parent_rr->decoder;
>     parent_ig = parent_cxld->interleave_granularity;
> 
> won't they inherit this stale hardware don't-care value? This appears to
> cause their own expected 'ig' calculation to fail validation during
> auto-discovery, resulting in the region being rejected.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1784940306.git.alison.schofield@intel.com?part=1
