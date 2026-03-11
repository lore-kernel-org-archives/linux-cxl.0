Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47157248873;
	Wed, 11 Mar 2026 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194409; cv=fail; b=YX3dOLpnZudoGIgNeMg/VUTmJa81KbwhmrJDdoWc9RM/msNo4gUBwki2nrjhH6mn71DehoL9BaNru/ntzsnOtE61jm5bdW6M9UGjAF4vP6Ub7PRuUkcU5GK9iKfSnbzVS0EDSWJlqAFdLNBmrj1ddAKhA3SkuYxOtF58OMI/zMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194409; c=relaxed/simple;
	bh=l8ACoz2eNFwn+P8MM7ixGY4WxfbIoPan2UKjEzJLm2w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lSBA7GtNnSRezgV58u1MEH2dTKzKntL/O+jH5cZqqzy9dwCqEPXz4asYGLeMobQT5q4HdUOmzp7O8qljkzm+2p0roZ6Go47+F1VG633x54svRKknWQdCslene57c6TFr9JFp8U6YRzKuv9QYg9Z1NNdIqs+zC/bLgPRs5lEYkFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9ynbqN2; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9ynbqN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773194408; x=1804730408;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l8ACoz2eNFwn+P8MM7ixGY4WxfbIoPan2UKjEzJLm2w=;
  b=e9ynbqN2SqMyzYYEWRnfsGESuGge2XafIK6rlGtxKUc9ZvFkFEs8fbjO
   mIjtVziKLDkERnsttHpFBVcQiHH72Taf4esH/6iOq4EKaDJy3turtyED7
   fEAg0hpWwcUvA9mNerBDZZBv079cwosKw0LBJJLuud3RblHZHNo6jifSY
   jyprJH/fY/LW7GcP/zw5KE9bAaesQUfhvrdRnuS27Bat1RH9JBUb8t9G0
   E95y+wM2ITcqHXjAEqGtgNa5JYU/8uE7y/Ms5i8IARWfS0OXeCuhrJUje
   1xZRoyuNRMsYRKuSOQr3jbW+jF3FcobnAifWcrMxlgi4yr+9FSWaHr4Zl
   w==;
X-CSE-ConnectionGUID: f4XSgIqLTlOL6kySkVbbhg==
X-CSE-MsgGUID: g2rFN236SSugmL1U86BPuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="99720824"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="99720824"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 19:00:07 -0700
X-CSE-ConnectionGUID: jlqHwznUSM6XNHt3iUrI7w==
X-CSE-MsgGUID: RvCa2EBfTxWiuI3ura/X7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="243319285"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 19:00:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 19:00:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 19:00:06 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 19:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2jrZAEf9SlcL6AIzOoV3KRAxTWtgCP0j+6Vff2eQjw32x4msqGQ+D5x+C9SuETwysguWlM31zCaagTH+dvMYRNCkLvyuWnTQNoUvqc6qije8WbS8rkImy4EiOILZgs/8qd7CjcrXDdYSE7dJfCcyOxMt4YEhPa5aBiEo/rQC0V6lT189qsbMBgz8qcfS1vl9T9VTY1/o7F0QROgn3TMnhnO/iNxZYirKTDyrEe3ZIzcLtg+HhMzdN3mRSI9XUqcdsMplE+r13WTqV3s4g1DzWNHB/p48+5ZUjojVHOKITP02JDRZORbRzZkcOf9LUlH7BJYQYBQ+rw7icQGy15oDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jb6/B5BCQMW65FmfV/kVVWQMtpj9DLXic0+bPsJO5s=;
 b=v+CBZ8eHRkcmNcLV3WeUfrmMa1gwCkJG6BR0W8KOm6eWKMQCpTEkwqAJLV46+1Yj4O8GXF8rSNjCvUWNj7Q8KoU57R01XB+g3kEu7wav+ftLw98VEVVvLM4OrnVCphipLw+Uait1YApZVQBkMCINC4y4x9nOk+tbJCKM20MmeDyQW+scrJPNRKNdMFh8oMJ8FODOL3b4SuM/eiZlr3j3bjqg4QETP17S+Hu5VPb15zyUp0ujVOO5hyqAW5o1OR6mpIBN9bbge2jJAopLH7EUqZu5Lmiio6nsAHKS9tI30IDFqh1zT7Mbw64IRrszlH0surXXaqSxwz8kTnO/u98d4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB7341.namprd11.prod.outlook.com (2603:10b6:208:426::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 02:00:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 02:00:03 +0000
Date: Tue, 10 Mar 2026 18:59:59 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH] cxl/hdm: Avoid DVSEC fallback after region teardown
Message-ID: <abDMn0EP_o6NYi9_@aschofie-mobl2.lan>
References: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3d2ba4-9cb4-4b1b-d801-08de7f11e8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: TQfm4oUr1iVT+YpEwXPxrtk59ucyKlliWoaUE5Kjoj/fSzJM/vs/Szt1Z09vTpLoNeVLnLQy/F5uM+Sn3PsNO6aduMPBUaFaAgCmHXxzK4Ipro0e1DCIkDW1f45WjCYU7bJlGqPhL5QdGVw/AynjH60TEw40bsptXd2HiDHrg0l6VQduE7opZEaqFZ4M7dufHCCez5RYOwEkvkZOkLrkFFYDFMYrHJ0TjZQD3xkrqlztBewN3lCNTDIJKmlW0UpVW+bCBIz3DVUIgXoe6zkLp/T7j8SE5YzDleL/rn0QBGZ1ScTnksAFyF2XQVe462kLOpkyvF5LrJ7nYBXypAfaXj/osZYaNvrx++0Mvz/qHOfC8fjR5LG4gieck3GLyvUbsDV2IlprM564TjgRdnHaazYj3xbdpN9L0qgGqOF9C2FY63oLWsb0IIKPnT0TeYr2j9i1fUAxz+8KrYJ1lKMcFkjEQ2o6si9yYyo76IvM5xx1xfYkev3m3TyumCeWROCJC47Lzf+wn3sh1MiMKwC3V4lwcQ+J9VkauJNJ+iXOfT6SXcyyRiL5WWRbwVjET/VUV6eBmFdyk+1YG/04hfBw27GxFZ3Iz8Y25l6DkoiZVYFcKXqqwjrX3L0o1h50QEp4of1B8sF7RI2fyfIVLOKjOT0q3Bm8nsPqCkpnUFkz7+vEhutPiAu1Y0Xsn9ze6DmWtYLUC4XwwRNiBouj+BPvciSvZ39shUtgvAJlW4xp5IE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CHCT0HNh6hwIJSm9mTsi/gAhYeZRHOLqHLozikuPkazBGU6dtjv79lhWho0j?=
 =?us-ascii?Q?vUBqDVyg6LMzRKm8cnB1KU0inTbIZVix14nHZpajZHIQP8JIVcuC/nk91tqS?=
 =?us-ascii?Q?RE2tA+F6LMwfVUHxDmVNLV3PveWP/2w25sF+ug2pIKKEDMMp89SCHXr0ylBg?=
 =?us-ascii?Q?CFoftCs+ro8E5NQk5j45dEVbcNkukswQE8cJ8A4GSDIRYOqODwrIv5ltSzAi?=
 =?us-ascii?Q?FsV6ZAtu5XswOXwD5X53if848+RcxFsp46rvVLk3+tKuOs2UQmcODWxOH+iv?=
 =?us-ascii?Q?hNQ5jdM+OlHxLntsWMpWF1zfFBp2pkKfviL4wfCISbJV6+wse7GSCX7++0uu?=
 =?us-ascii?Q?lBF2J/znIrunF8ch0WjeGTJ/R4ax8Me7e1nYZH0zedR6ZG1P+2vyLx0sFIO1?=
 =?us-ascii?Q?T5eFV3w/vf4RTtS+DXVmHFobHo29XZvOyrm+qy6fFv9op47UlBx8aw9L7ywP?=
 =?us-ascii?Q?auB7DqNuVWwzEQYVNMHqAUYHqeoh/KgjqXaLOflHZht7L2BQqIxPOvRBLV+W?=
 =?us-ascii?Q?JAZtETfFkpkKNwY7KlJ7UG+bJ32VFBQkUwfZQUYaIdWN02Uz6W8N7Qd2u4BY?=
 =?us-ascii?Q?D/uoAtoi/9M3b8rSXCb6PgXolhEf2cMgeOboZ1QzpWxucAZi+JzZdRLNHKjv?=
 =?us-ascii?Q?PwTz3pJFTUEHhmkP0qWm5H95gWTkGYAYqYrN6NFjTM+FLmn0SU4pzb88OoNS?=
 =?us-ascii?Q?KRfRj3r8sCTqEnGESw5II5mE4QPOJMRfDX033QbO4FOhTKmhhAI8o5LLRIhR?=
 =?us-ascii?Q?b/N+BgetvFNY6y+5+umhV3DosHC3gsKGfVitvapWnjnjGRs0tQWy2RdPp3G2?=
 =?us-ascii?Q?A3PcTELoF3r12M5waYj3DEI9QrIKQmxUMx8k/Lft90sgSnnAdcluKtrpk9sD?=
 =?us-ascii?Q?EQ7+MC1oSHKfltBtmgSIFHLIG2PoMPMC8TNzWL6UeGfIkoaM0Wo50S9izJHM?=
 =?us-ascii?Q?nTDpWmp3Sif+v8pXCtZA8thsvWKpxN7ck659f/st7LkBBOEfd3EStNNPqgcV?=
 =?us-ascii?Q?nzkglJN8wFbGbDf/4afIkLrGxa2nqLqI/ZAl+q3vT3+weyUzu4M4IdXiW2BR?=
 =?us-ascii?Q?Syp+SvY71W3KWDM1t42q0NZ372FhAQ4HRkz/wIavuH5dlobCzXPvfQOU0Qba?=
 =?us-ascii?Q?RJSbYTr+RIxVcdRyTeuW57iw/G3T/dLrI7kfPT02xcWNi3dk8klJZDa2xWNZ?=
 =?us-ascii?Q?MS+IiWgC+14MX2ZW8k6HtGbcF3PWJ4baDUXBL305bVamHHQI89X0We8CUO7C?=
 =?us-ascii?Q?O+ojdbaktKIRNLd4H0AeLlHoMmAwzQWC1AhXZykH3qlPSt3YDUfTs1WtUuPU?=
 =?us-ascii?Q?AuRjQb+cb71VPkGJfUluqMgLyhhAzG/mOWPWFhqpKNLiuHatw5eRA7uLVH4/?=
 =?us-ascii?Q?eT3KAOUmPJUBcigoBrqVzoM0nKcxlV77VYE8dZdOtM1KBBQvHr4nuzzjfHrG?=
 =?us-ascii?Q?B7yHfDO+dmYPN02ernmmz0Gu+xgtOWhHvDkRxhuTJ2i+/0XTp1Go81pEL+la?=
 =?us-ascii?Q?CZvV5GFe7Y6CaZ4RXwyzHobRTnOkbRfdvpRW4ZGogXXql7wMp3KcyRshzg0J?=
 =?us-ascii?Q?0W8glnLYNE48siw4fytNFCF6PHBRrEzhk57o41r+imucFPfHUaQQTjADPElJ?=
 =?us-ascii?Q?jyCTNSXVSkQ0ljYmwkDyd99zgn6ci2fS3emX9oehp1SXCFzBgcephT3yJeJ0?=
 =?us-ascii?Q?WfGjsar8buodrcdMYj4NvfT9WhodVdD+QEIF3eAn6oAVO8Wn+xrPjeLf3CeT?=
 =?us-ascii?Q?VBTFF5eBdroKuG6YtJCfTPdgppOEy9I=3D?=
X-Exchange-RoutingPolicyChecked: hF98au7jXhZpco9jMhC29Ja1XfS7umcKRGoUWjj1/DvufmpCbG8n4Fs4Df1av+MdbVzUClS5YmtAlCc8Af/9pBnQdPLvbr9Ot14ASg2qLXK2lF3Pdw7g2yzOwIoKfznNQb02GDZuUd4st5XMt4k8IZK1pCDVAMC0YGahOeEwRQwWweIu8W31hef/rxa4IcJQyxp54C+O2NwLK1BtJPNzJQ3sqcdaVTe2mAD1gLSA1EATi2QJpn453SedqvsObLtCkhNeqx7yFIY14lQqSlZpzGF7HRwQ8XLfJoTC18Sw9r8bxM0aYqWxUAA//WsUK0TZswtKLBbaI0JXok53iVoVRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3d2ba4-9cb4-4b1b-d801-08de7f11e8c7
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:00:03.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlERyV65SCGcijYdASP9ME1tODOYAPZ1plLWhk/3D3hIqngwfCjnLczbEF2ePQsbDlW5sKU7RLen+jlUxXe7g3xAbAHWIg3ED1+ec6ouQ5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7341
X-OriginatorOrg: intel.com

On Thu, Feb 12, 2026 at 10:38:00PM +0000, Smita Koralahalli wrote:
> After destroy-region, cxl_region_decode_reset() clears the HDM decoder
> registers (base/size/commit). If the memdev is subsequently bounced
> (disable/enable), port probe re-evaluates decoder capability via
> should_emulate_decoders().
> 
> The existing logic checks each decoder's COMMITTED bit. Since those bits
> are cleared by region teardown, should_emulate_decoders() incorrectly
> falls back to DVSEC range emulation, even though HDM capability is still
> present.
> 
> DVSEC fallback marks the endpoint decoder as AUTO, which triggers
> cxl_add_to_region() -> construct_region(). That path copies the default
> interleave_granularity (4096) into the region parameters. The resulting
> spurious autodiscovered region consumes the CFMWS HPA space and causes a
> subsequent create-region to fail in hpa_alloc().
> 
> Use the global CXL_HDM_DECODER_ENABLE bit instead of per-decoder COMMITTED
> bits to detect HDM capability. If the HDM decoder block is enabled, zeroed
> registers indicate teardown, not absence of HDM support. This prevents the
> unintended DVSEC fallback and subsequent region creation failure.

Calling attention to this one again.  I'm debugging another issue in
this space, failing to rediscover a BIOS region on acpi unbind/bind.

Can we consider this one for a 7.0 fixes pull request?
I think it is important.

Alison

> 
> Based on cxl/fixes.
> base-commit: 8441c7d3bd6c5a52ab2ecf77e43a5bf262004f5c
> 
> Fixes: 52cc48ad2a76 ("cxl/hdm: Limit emulation to the number of range registers")
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index eb5a3a7640c6..a0718cbcc355 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -94,7 +94,6 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  	struct cxl_hdm *cxlhdm;
>  	void __iomem *hdm;
>  	u32 ctrl;
> -	int i;
>  
>  	if (!info)
>  		return false;
> @@ -113,22 +112,16 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  		return false;
>  
>  	/*
> -	 * If any decoders are committed already, there should not be any
> -	 * emulated DVSEC decoders.
> +	 * If HDM decoders are globally enabled, do not fall back to DVSEC
> +	 * range emulation. Zeroed decoder registers after region teardown
> +	 * do not imply absence of HDM capability.
> +	 *
> +	 * Falling back to DVSEC here would treat the decoder as AUTO and
> +	 * may incorrectly latch default interleave settings.
>  	 */
> -	for (i = 0; i < cxlhdm->decoder_count; i++) {
> -		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> -		dev_dbg(&info->port->dev,
> -			"decoder%d.%d: committed: %ld base: %#x_%.8x size: %#x_%.8x\n",
> -			info->port->id, i,
> -			FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl),
> -			readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i)),
> -			readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)),
> -			readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i)),
> -			readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i)));
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> -			return false;
> -	}
> +	ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	if (ctrl & CXL_HDM_DECODER_ENABLE)
> +		return false;
>  
>  	return true;
>  }
> -- 
> 2.17.1
> 
