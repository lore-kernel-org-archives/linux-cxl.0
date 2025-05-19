Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A5621C18A
	for <linux-cxl@vger.kernel.org>; Mon, 19 May 2025 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747696182; cv=fail; b=Oct/wl5itStjfre0wIuujgaWWbiCDnT63Z144V18mCIlWQ2+V1Kuf3gvHlxHthAoYW3JM3fYyR9NYdONsA3BN4GTGidxV4I32tFCfSzhYGAWAA5BI4dhqXNDAgew8QqrFJltJosPrRQVuk/LelrX+A/6eRL5hvvG76OjeA2O67k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747696182; c=relaxed/simple;
	bh=9mr8xI1JrZbpCk5MfgTnhDu3YVMFEJlUVWiXZfVoHBs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RngsP6s1HPQbCKQ5qBrk/ldJGJUPNn4IQ72fx2AMC3vhYtPf6N8fru0mKE4OHI0M+pdhcvNOfdwOODs+2Ov0AM4EnYOzJa6R1lNPif6lQMEfPSD2O0sce9XZ7hcMSE2UCQwv7v1JLcu2GtR3evMZvp8S4Y+6iIsgu59nv73B+s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ha7KdsB6; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ha7KdsB6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747696181; x=1779232181;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9mr8xI1JrZbpCk5MfgTnhDu3YVMFEJlUVWiXZfVoHBs=;
  b=Ha7KdsB6SJJkZFmpHStowdk5W/GCM4KW95nwqqX0bE88AgVqIQbBsvPo
   GsGZPCdWx52wHFf7ecRYjlenKu8OvFkuLEga/LHUmQOQjd7L29bO3r4Yj
   Wr3cJP9xabdJh/Y57zsV0kpPTfffq8GXJw4dkuB9g9eI4zcCuyC7DrlPh
   YzHv9ACwCzOQNeUSRuWP67kDObaMBztZloc2Sffoia28N5djJgJy9SNxj
   pHaxmWQ7KjZhOo4gv2THoqPzDnN8YY4KObFM2AwBzssL7FgJQURQIaMvH
   kl6+yQODh+swv7w+w/psO2a6vp4I3z4e7S5htlUHP2E2QTUS9KmiGsUoe
   A==;
X-CSE-ConnectionGUID: oL6lPOzhQX2TmE7ENdnpeA==
X-CSE-MsgGUID: k0TIAN1FTY6XfuA9gX8D8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49310965"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49310965"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:09:40 -0700
X-CSE-ConnectionGUID: qmOhS5RmTveQ9JeYZ4QcrQ==
X-CSE-MsgGUID: WSvNrjktREqOuT5cgx+Yrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="170536350"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:09:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 16:09:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 16:09:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 16:09:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KElokKevg60DEcA+vLBdt9KcA3/AZkTXr5kNngOW1OEcd/bVA3BqVt/VE69ka3sTuUp00fB45V2XTCg8oYDjZswvugr75RAb9LiGy6Fifxbmyn3GkNSBns5tg9GWIBf/qcn/JPeGWZdHMxKVV91xFRyszlKdofXcjGmvBzXy9SUxDAR7Hlm9V/LJE5KliWAANI8Vd4Hx6sk16o/QxyTzw+TEJlsb+AhDU/6V/MVnNNYwZsXwGug8IPOWBpREr+UpOTlabQenUmoQi8K/stBerzp/f6Z6CWGpITHRn3wPnoKlZLydP0aRF2DBIHQRNivHnir8b0ActuIBEV9UEAVtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVVR/T5P1xVLREUqGEfLpb2FK7JjeA6wxryVvQMhZ7Y=;
 b=sO8glwQIlR7t0EHHDkmuSCBJar3fPNfwWYHEF7PAET3nYv/YoP2k1L3YWO5rUmnhhe2G/GUNRWNMRp1bCjHPUsfkWfMYKaE0ydkwQ/SYqPIoguSE6d9AWrUGeiNx5SStcMtHFLXaBpmtEJlIjCimTGLPVDN8w81+gS52kZbWJOyKWJNaA5Cs16quzcdeyvSDcgpsKMZbYb4NIZK+6WIEDzDsDyQtOtObX5AtMYiSNx2SEuQKTV3Dy7tx9Rdbx7H9j2rL2JaKOms0NvW602IHoNsuZgIH0CYTAVn+rvC1Adb4H7PtEpSHSbk8tOXNWPawl3P7Fss9gBNWB5DL+iXF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPF4B53DB4B3.namprd11.prod.outlook.com (2603:10b6:518:1::d1d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 23:09:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 23:09:37 +0000
Date: Mon, 19 May 2025 16:09:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Marc Herbert <Marc.Herbert@linux.intel.com>, <dan.j.williams@intel.com>,
	ruansy.fnst <ruansy.fnst@fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: <vishal.l.verma@intel.com>, <sunfishho12@gmail.com>
Subject: Re: [PATCH] test/cxl-xor-region.sh: remove redundant waitting
Message-ID: <682bba2f9ce2b_1626e100dd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
 <6827d6e591443_4ba8f100f1@dwillia2-mobl4.notmuch>
 <3f7bd5b0-4c1b-4a55-bc9b-2b6e75ab9a39@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f7bd5b0-4c1b-4a55-bc9b-2b6e75ab9a39@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPF4B53DB4B3:EE_
X-MS-Office365-Filtering-Correlation-Id: efdb8749-9d6b-4512-3e13-08dd972a3a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SsKNjS59Cf74MxRmB7M4Uk5AAXI5uwZXoxCMDxo/VMxKzjplp84vU5zP1e7a?=
 =?us-ascii?Q?PfeNReUbSYl0/0xN3ECVNbLmtLdToJ9kw14b8P0jS7QKzWGctkaGptt36/lj?=
 =?us-ascii?Q?OXiYZWjf9VILveyS9ubwxrXgAGUO7xryeC0A6E3J3czv1DDLeMtnxz2wP4H2?=
 =?us-ascii?Q?z0hMDl2x8ZhW3OEB/6SPA7CLJSlz4lbNPU4d95CwlP1p8oRG456F6BX7Hc6N?=
 =?us-ascii?Q?8UhermuApNqBrDXGeAAwmeangzIhREdPhYCYtqfapHG7RZnfzKXy76OMIX4B?=
 =?us-ascii?Q?28tPpGEsdrNB+LDDzraNpTc2d34P0keULzWaD2kswR8ewIvj9r5QBFRsomGA?=
 =?us-ascii?Q?k6a0GElXYI403P5kr1VhTP4gWG9TJKW/rhmqbpW5x6emAoOP6ApwUDcJi6OU?=
 =?us-ascii?Q?0j3CrSYGoJ2cRorBMs4w1gJKVa6cgQLILCNTv0X24faz7sSxCQX/+19c33dG?=
 =?us-ascii?Q?9WTLpS3ovv2/B8r53CQZVzqJWSDtCgJ2oG1Um7RHU/sC/ASGKS5zqxKAFtPx?=
 =?us-ascii?Q?fYdJjSy6FsyuvspTToPUbCLEnFPchAug+A0WGOpe7gae/toBvrmXMU9r7LEI?=
 =?us-ascii?Q?t1qXxK9Cbt5PLnltgrdMcE4LveSc2pzTK6Sar1e1EtYPKtuUx07j6n1wsdcb?=
 =?us-ascii?Q?whLmrecqTSV4eDPq74xYQkIvS2J/5hcIIBQtcX+d+ISQanrnnBdLS3u27DWd?=
 =?us-ascii?Q?+schyAvJuygfEXEsN5rpvpaS4HZWG+H24uC404Z52Y34HBbNLVqAjj4nqtW5?=
 =?us-ascii?Q?oUFXl1EYhlJi8A1uLPOps3McKwIQHKD9PpiAuCb+ixDO2Z2+n0VccAaoixai?=
 =?us-ascii?Q?zOSgeqcVtwhaXO/emzOhdfQwiSk5ou7yrTDYAn/2XYPji/ecY3XaNCS8MbnA?=
 =?us-ascii?Q?GTzHWSm7YK6Rg02pNDAoLwdvfEV9frnVd9izXQIoGWzM3DSFTHiEP4O3FdOH?=
 =?us-ascii?Q?fgRKssa582l86CHOMDuUX1bZOIybDqlCYwyDszNRLx3u9SYX5SYyPpki/1V6?=
 =?us-ascii?Q?bEk/L4kZwWckghzrf7B31+MOPuIa5R7FGumwcTxDcLXg4Q5yZzwE+g3thrUm?=
 =?us-ascii?Q?LIiasbGMSdoVugLyeQxkns0dK6KShnSji59Dv7M2vTIqefOf1BrgAeJO4Z+b?=
 =?us-ascii?Q?spXrZ79JaFvItGwJtX7fMHK/u0k01YvIlQlw//UCE7TmES5FqQMWDHpB4qWd?=
 =?us-ascii?Q?37E8QSgMg5Ey5JhXp/uzF2fSdpIsqj4qJU1B36DOmeEnUyVfOu+EgwpDLeTR?=
 =?us-ascii?Q?4WKh1kNtoBKZjPEE5UcFnKfMrgwfTD8pUisLc37suc3XsXecZsvBQV3DWHUP?=
 =?us-ascii?Q?HDdSwOdZobQHIpsAGk4K9k/cmEX7ItauvRcRw3toalmj6M+3wiIjSNboIQOf?=
 =?us-ascii?Q?Ec7x2gYzph28c3m3P+66b0Auuf321+mMcBEGozBnpwSXZkhhvNqPOhuqmURj?=
 =?us-ascii?Q?jwaHkeh297Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nbz07bYnO8SwDaERMLJUDZafc8U7mQvlo+FlfCmPl9clzo/bvzSaNoVAL0Vd?=
 =?us-ascii?Q?6SLpBPa0QmNzdt3iiWWuy29dqAqm7u+oxutnfk4321usm0kk5bxA4Rw38r8+?=
 =?us-ascii?Q?hxxNd52rKuoFOxDcApN8PAbtxFx1OVYIUOwXCEuuQEwQIqLUBAEMz1WHSeJB?=
 =?us-ascii?Q?915fTxvX/0DBXu/QLKj7bTa7IE8nENzj5kdd5MvUyfw9FJHSKZGYxTZOAeqF?=
 =?us-ascii?Q?hpC/Oojpt6iyORRx8D3Ocsywnfzm+N2J+p8dIr7pIPRfBJlPN90gS2EOTFx0?=
 =?us-ascii?Q?6erOdRznlASvCCo9fuLbcgbr/8U5+puoQlBc2AwmPSByEb8wIqiLlas4po/R?=
 =?us-ascii?Q?oRPLTijlHQVSNn1YNWr4Zns9nevGImY+9LmezbZMSf3dPAZnrgfUGcNpscfc?=
 =?us-ascii?Q?5kUw9B51Q1ZbuHgKTmyW30f5VocP38A7xo3SpCf/2A76Z7qhsvnck6ClwDBw?=
 =?us-ascii?Q?6wqRsb1m3ZXVxPvi60c78GVorgMOe9Yjzfzhsjo8qZYYxyfkjWjhDKFQV37X?=
 =?us-ascii?Q?WhTH0vZB+bWGCcSZ0c+pw2yXSNoAydCRa8Ld0P7vk/4SpLEtSYUHPXpUb5vR?=
 =?us-ascii?Q?P4EUrbgj2EwBdiAr+SzU3avVPsz0I9A7qFh+HIojR7znzYV5MPotDIHSSrUN?=
 =?us-ascii?Q?TmPKPaIhC3e6J/VRJDWKt6RPlBZ78KIHuZbNsyTEEqOUx9tMiYGR3Zl+7q1i?=
 =?us-ascii?Q?P/Q8mfBaidK1e0weM5XKR14wx3qqm8ZF9tL34JmR0EeOWboI4pOXIx0lCQGv?=
 =?us-ascii?Q?eUg3zAlZf7446OTNDcOZKJgToLBfu5K7Zm484vzNq7jey3shS+/PxgW7KazO?=
 =?us-ascii?Q?kMq4Sw68olq7LHnqENySz/Ks+e/OPCLo9P9eDEU/haNMVjfQ2J4YfnBfQUcC?=
 =?us-ascii?Q?QB2AWiPxZBtQtXh4ntXubUIp9JzQI5cQ2g1plgQrM5QylwnlXr/EC9uIMpr2?=
 =?us-ascii?Q?LMZgAh0cKbppcbljwDRsV7yWW2H0xtZBY3wmjL4EN7AaYdfKCBIxJO5PMx29?=
 =?us-ascii?Q?VQpsVoZT9eFfoi6N5pLUHeeoZHl1OZ0rin0i4MWxszeqsEY9DCr4uUD/WO80?=
 =?us-ascii?Q?I0zgzA0m82A18C2xc6l9oIlQt9m5x4HKqnXLnJRKdlvGVBCpa97A6M7TpUW2?=
 =?us-ascii?Q?5rUT/X0xBkPcuPvg1Ww8us/Y0d5upxYoWqMtCf81/LSBo3VrkK8yBKm/yvur?=
 =?us-ascii?Q?whzDBOJnSl48KjmKlaH9c0T4REtXwpa8swRTXqNfHpjUadRiC/HFTO4rhnT+?=
 =?us-ascii?Q?SOiWCGEUQTTajj3qvXODKnP7euEtjMKPjQl3PI57v0OKZZSyoOo0XnNvE6kj?=
 =?us-ascii?Q?y7EBh0Ryq6fK6hqfXnav6100GQ/OCbrD+puTBX73Vi2+quaCEUstQVIuCHvF?=
 =?us-ascii?Q?ru3cQcvw8piikXTcF//hhwrM4NsivSsH3A3wmZ6ls9/uBAHl7qIHmZK6FJb+?=
 =?us-ascii?Q?eSgYOOqxQQckb52yJxw1AsbOajUi9mLp+7zxja/fgHJKRXah6FFn4mu4VmYb?=
 =?us-ascii?Q?9S4ROgkcufnl6ckARaMLlxKbwFbBMWNMlexIlHWeBEljfd/1oNTPVI0bJUA5?=
 =?us-ascii?Q?pSND8loVyIV/3gdXmWuGT4BVLksjniEekjPoVdTCwNdqejN0ArCH+BpGiwjV?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efdb8749-9d6b-4512-3e13-08dd972a3a00
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 23:09:37.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fr+HuMBIuxMXoLyOADUaZeqLvA+8wEEs6b4t4zV1v6h0sbgOd9nyeXpB5OpV3NJ6LYT13ntli/V0Y61fQYb/GkgY4WeVqDxnxXYrgJVCwFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF4B53DB4B3
X-OriginatorOrg: intel.com

Marc Herbert wrote:
> On 2025-05-16 17:23, dan.j.williams@intel.com wrote:
> 
> > 
> > So the assumption is that interfactive invocation of cxl commands should
> > arrange for a stablized snaphshot of the topology state.
> > 
> >> Now I am facing a problem that cxl command takes a long time to complete
> >> when I run it in a udev rule(do some configuration when CXL memdev is
> >> added).  I found it is caused by this function: waitting for udev
> >> queue's endding but itself is in the queue.  The cxl_wait_probe()
> >> function does not seem to allow me to do that.
> > 
> > Yes, that is a problem.
> > 
> >> So, the 2nd question is: is it against the spec to run cxl command in
> >> a udev rule?
> > 
> > No we need to find a way to make that work, so I consider this a bug
> > report. My initial reaction is that when called from a udev rule cxl-cli
> > should honor a new environment variable, perhaps "UDEV_CXL", that
> > disables this waiting that is only meant for human interactive mode.
> > 
> 
> If the distinction between two such "modes" is indeed desired, I don't
> think the name should point at the first known use case (UDEV) for
> it. For instance, you could also imagine that while some parts of test
> code want the current, blocking and "stabilized" behavior, other parts
> of some (other) test code want the currently missing), "fast" and
> unstable information without waiting. There could be other use cases, so
> in general the user interface (if any) should describe what it does, not
> who it is for.

This can be a surgical UDEV specific environment option for now because
there are no other use cases identified. The command line arguments can
always be extended later if need be.

[..]
> PS: while... waiting for such a fast/no-wait/unstable option, I see no
> reason why systemd would not work.

It does not work due to circular dependency deadlock.
