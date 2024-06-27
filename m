Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEDF2139A4;
	Thu, 27 Jun 2024 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450641; cv=fail; b=u9cLspOfGEFkO8+aupIQAK5FtSAmPnWtqHi1SsZs5EEWQE0B3T3MpWy3VvutOO9J5REnm8F2btblwdqa45W+5r/CCECntDd0XIyg5xfsPum5ZB+ngNZOBKY1qhU4prNe42QM4cFUjQaK75TflKJmVomvlooUldhZkTZoI9nbuqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450641; c=relaxed/simple;
	bh=FasSzAz2bzD7eaQ+PVA89UH+iB6R65siEDMrUKGbeLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e8am6LHBpTmjrpS+A3KunaqR06xPXSwmwqyjtiqATmxAR8qVKhVaB6mAfvXTxu1wwjnx5pslSmIutGjnLUlZEW+hxSFRW9gfZWDqeh+ZlvDzDxsMtDsqc6u3JfYxFMe/bVYlXUO/iacnJ1t4LIcERuqaiqNvS+QfoJL3vP/+/kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4v3ASqb; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4v3ASqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719450639; x=1750986639;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FasSzAz2bzD7eaQ+PVA89UH+iB6R65siEDMrUKGbeLM=;
  b=i4v3ASqbYkENifhpks5mwhUkiflwJ6htEeBDF02wRR8/isogd4lzeQhj
   +86yUPg+EFZmMZIxMXXYVMeQSSzTA70xX/N2aFjOagLP5TZT0kFdJJHI8
   B1tCCePw8zGulVLpoqBZ2jTcOxKv5EGMK843p2QjjVWOYLE1mb7j7EjSH
   4Eu1ncGrQrINAREDvVnTXHtsjuZChUWgXXlKLLasrDJMeo9YB5GWViqvZ
   wOHJ0/j1sBSYyDunAePSygpWH2Xk2uchFkvI4XuKerf4nLzvRayjLgpP+
   bTz/7Ev1xmpUPa/n6jSC6LzGe+FgQvae/XH02KylYejx+T2aA2b8xDQcE
   Q==;
X-CSE-ConnectionGUID: J7+jZvJ9STaAhMfc4KyG8A==
X-CSE-MsgGUID: QB62wH9nRX6ETiJ12yxElw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27691111"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="27691111"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 18:10:09 -0700
X-CSE-ConnectionGUID: gfjwlbZ0QmeQC5ycel4I6A==
X-CSE-MsgGUID: 7pg+DiOvSqmf6E3gWNHXxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="44097591"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 18:10:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 18:10:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 18:10:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 18:10:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9qCVW61LxexqNMChFBvqcZIa97tmdxJZND5+xKMr2miadhyMCaFijnn+ZIH7NTUH73AR1YZ2WoFMcJK9aJcF944PGqAzqngXxT+LYLbc188jjmx3XeNbchNCAEueTEihTubi72j3goNsnKviYaK6buPJNmlXBTrjprKLDPrvP4I6HyGvbhjRwa96jK+VhGu1QiDXrxcHe00cZ/h4E4if2LM4wdItN2dNdUQweF4k9YQ3bcp3olz33Tz5I+UWUFCkQksH+flwZuyHVYRoEQQuKMCC8++e+6cv/cM0jQT2l4h2e//nXQlEAhatlbVX6DOp6UXrqBEEVR5cO4h54Ih3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxbTKtOHN9PMLaKhGpptaTDalIc2o32YS/t2Lobcv/0=;
 b=GofsIzr9OKp7FOl5lbdBKqd9WOkr9uIgwOs+5kCisPoz2acN3L10vIT0WDWuHCXIsNo6HIvAfepyuYxdeePQFOpjt5FThm2X+REExaWuFKeLMu4VrM+9lRhipQknE3AyjJJ+fmtovOdCtDpYVoIHRM+1bVehAi2YNOQt3z9hCBkbtjKRgko3l+72hAILXpRDCncpqZidYchgXodJtQIl2bzMhP3eiuCEm8kQyUAldgeqV923jb8pLlmF+TCZVp0KI18BwT6PSgGFfD8K/foQq0FTUUaf32oFNwbwbvyixofWIwa+yBQCGunnav/wDjn9FsFo7nS8Tn0GV/YjH6K64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7124.namprd11.prod.outlook.com (2603:10b6:510:20f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 01:09:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 01:09:58 +0000
Date: Wed, 26 Jun 2024 18:09:55 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Warn on unsupported platform config detection
Message-ID: <667cbbe3139b7_4fe7f294b5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>
 <ZntcWQ7pMtOpuT4a@aschofie-mobl2>
 <667b649a3a2d_5639294a3@dwillia2-xfh.jf.intel.com.notmuch>
 <5714543.ZASKD2KPVS@fdefranc-mobl3>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5714543.ZASKD2KPVS@fdefranc-mobl3>
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cad4c50-70b1-42bf-6f7b-08dc9645dc9c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDczUlA5WGErWTRmdGVMNzRVejQrU2RvUldJOGVLOW5tTzYwSjVRcytqcWIv?=
 =?utf-8?B?eHpaS2RCdlNTSXhSY1J2Z2oxQ0IvSndOU3pTQWhIWktIU3E0RU1vL3pOOGJ3?=
 =?utf-8?B?Zm5mbEs0MlU4Mit1SERDSDBOZGhPZnJEQkFxb1dZNWVHRllUWUVBL1FLQUVy?=
 =?utf-8?B?MEtFeDgydS9xQTg2emVmRzdjd1k1anVQUEFDUzdlODdNbG4zelYvVGJYY2lx?=
 =?utf-8?B?aDVxMWhLck1maW1TUmJaYi9ublZJdGFtK05JMEJ1Zm5tZGFMdVh6a0R4QzlW?=
 =?utf-8?B?ZDJkNnhsOERIck5PakhlOXpBZTJwQlo0QWJZUTN1WHBZcFg3eEtrVW5CVk5D?=
 =?utf-8?B?WmJhcjRXNUFCZGc2dmF1aDFGMUNkbzRhV201dktwaUorVVhmN0IyNDltZVFi?=
 =?utf-8?B?SkNKMnB3ZjB5SEx4a01naDJpUXVFU0ZQRlcra09Wb0t4alRRWHRucmNOWG80?=
 =?utf-8?B?MlB2eGVlVXMxanhlMHhIa3VHVytEWXdUQUFjamRsTmdFMWVkYkpWUmNoZTJZ?=
 =?utf-8?B?QkY4S3N5RllHbVROaklCZ1ZBOFp4cFZUb25wdlBvUFFpWEJiSmF1RTY3aDBV?=
 =?utf-8?B?ZVI2VlNBcTUwYi9IQ1NwN2xXYWtvZDhTeENONExnNTNGZzFyUXk5LzZ2enNk?=
 =?utf-8?B?c09MOFZJVnlvbkJSRDNDaEZsTU9NMTR5bXlUK0crSXlRRnkwYkNBVnpvQ05X?=
 =?utf-8?B?c3Fwb0YzU3lZVEQ3VS9FY1BpQ2x5VGRIUDVVM2hINXBKZDR1cFhwUEtIMmt4?=
 =?utf-8?B?SlcwYWRwQjIyS0l3MFQydTRQQnc0dUsvdXZtaWtpNWgvZGMrRExSS2k3Nkxj?=
 =?utf-8?B?N0FJUVk2amZOcTBUZlhaalpRdEFGRGRDT3VlczRXQmR3VWJrMzF0NGFSZGkx?=
 =?utf-8?B?YmhmYnNwTFdKS2VrdUI5Z1BsdHdRNEpOZjZvZzY1T1k5UHhLMlRlK0RxWng3?=
 =?utf-8?B?VFc4SUdzcm9YZTNZTk1QamVEdmRidXRHemxDbG0yVEpYQ2t0Zk9DZ2RtaDFi?=
 =?utf-8?B?US9FWlM0QkpqTVNKTFcwWVUwcldyUHBueHR1dGFybmo3aXlHY0kxTXZnSkxv?=
 =?utf-8?B?ZkRwSTNBMVg0OXo5aGlQZXJ4ZHVtN3lIcEhLT3hmVHIrNGxCa3dpYTU1QWlo?=
 =?utf-8?B?Z3ZraUZvNklQQ0poMWttRUNJTkdLV3JlNkZFR1FiSTVscm1lV0tQMTRXTGU5?=
 =?utf-8?B?Y2RTMXBEWTB5TC9sVzUzZWY2bnpaeFNjeEFkWENac3g4K29TTjZ6VUVkcnJj?=
 =?utf-8?B?YTlsKzljZEtzZVNJeE1xZ25DZXRyZFVLallHLzVmdTR1UWtnZUxhRnJ0YllM?=
 =?utf-8?B?ek5SSDNaMnlXSjVHRUJzVytWMHNaQWl1VzBsaHdGSTVPUGxQdkFQYkhDLzNM?=
 =?utf-8?B?UC9qVHdEYm1wcCtxZlNYa3BMVmNXY0xOQ05mU3RRQ1FlbmVQcVhYWVM4Z0p0?=
 =?utf-8?B?aDVIRU0yb3hhN1N0QlNMcUZKTENnRUllMVJhUHZKT0o0MC9uUWF6Q3NmU1FY?=
 =?utf-8?B?Q3FNeUFmUU1GUVlyRE56dFM3dTFEYXZ0SitxS3kvaUVJWlBSa3FWQ1I1V1kr?=
 =?utf-8?B?RWxyZ2NSOUFlS3QxSFVQZkpRMUN2bjZsUHdwRXMvQ0JUUEFabzRVNVhuYnBz?=
 =?utf-8?B?enR1aWhuRmdVYUlna291dEFoR3c5bEppbGxIRzBVUzJJQkN4NXhPU0lyQ3Uz?=
 =?utf-8?B?RXF2MmwvR3NCTDRoUW9RdFdhRVFnSGNkaWJvRlhmcmtJNjl2MUtDaUdWVVVN?=
 =?utf-8?B?M0Q5SHpsWU0wNFo0aWNDNXpLTVYzZ1dnTE8wTmxrT0hhZVUxeXdUcEN3M0t5?=
 =?utf-8?B?R3p0THVtYTlPckRPdk4yZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anVlTnFlUGJpSzQ1b1ptVFlLOU85YmYwcGlnRjk5bmtvYyt5NWh1OThmaEZP?=
 =?utf-8?B?OXpBNEJ1K1JweUd5RXVudW5CWW9obVJLbTlTY1IzdCtQUnZab1A5QnBsOXgr?=
 =?utf-8?B?TWM3ekt6TjA2VVdpeUM0R0VSZEpEbUR3aWZXL3pNZHN5YTlMd01sTkJreEJo?=
 =?utf-8?B?OW4ySENNLzZjOWdhbEl1SEZoeEpJSEY1MVMxSlhoS0dpcXhUUm9VSmlBV09U?=
 =?utf-8?B?cE1STGNkazFjaDlGKzJJOWFjWENtSjg4cVZ3ZmRLSWxaK1JWOGpvYlpxd3dz?=
 =?utf-8?B?eWRsU25lMEsxUU1vcnYwdEJXeGN0S2d3Q3V2TjlqbU5vTDB1aDZWZmVwU1FI?=
 =?utf-8?B?RHczNUphTC9jc1BUejlvTUpQZzF3NDBnalhSNTBUMVV0YXhUdXNDSEV0RGhY?=
 =?utf-8?B?N1BrR2lmQzNaU3oxY3AxcnZGL2tYZjNJeUtMSWtqZHZaelRNcmlrZ2ZaVW1m?=
 =?utf-8?B?dUdHQ2N2dDNDS2V0WCtLWlVGdzg2WUJqa2pSSUwrWG5sdFpkeFB1cHZZRXNB?=
 =?utf-8?B?aEdqN2FqY1c5bWJHdFRWYWhNT0VOaE9LMVZMNUdYOHNCaS8wL0x2UG5ZblhV?=
 =?utf-8?B?aEFGTVQ4aURPR2dtbWx2VHhCcnlFUU4zWGhvd1h1K1M2djY1Rktha09FU3Zx?=
 =?utf-8?B?MzZ6b0ZnWG5aRE9rbXFkWDhTU2dtZ0kvSlE3ZWFJSUxXZGliYmhTS0ZtVlk2?=
 =?utf-8?B?WnpZWGs3Q2F3RTR0bEdWRUpXNWl5RjFOcFRJOXVNRld6YnNuWGFnQ3VZbStB?=
 =?utf-8?B?YytEN0lWUWZvY3pLemVIeUp1T1IrdWN4Sk1IVUtBQkdsVjB3cm5pZzAxeW9j?=
 =?utf-8?B?ZHRyUHd3eFkrblV6UU8rUmw3MjhPcVRWcG5Wd3M0L3pDWUxWWXBiR3c3WThE?=
 =?utf-8?B?RU4wR21CbTQxeVRCSUlNa2V2MU83MkUvRUEzUmpBaE1hQ1ZRMHB6TzgwY0Nq?=
 =?utf-8?B?SVJIa0NpZ0NDamJRUlhodEp2VlJKSzAxNEYrb1FjY25KckRNczhzOG81MHcw?=
 =?utf-8?B?ZHhSZDJ5Rjc0ci95eHFhd242N3hOU0Zsak1uK0tSZkFzdkl0VlpRRWRob1NZ?=
 =?utf-8?B?aGNYeFRQbWVVQisvK2tnZ3V3c2xtN3UrUURLOVN1QXNiR0Z5QmVzYS9wbHRS?=
 =?utf-8?B?Z1BwM3hpS28vazVQbkxZK1o5bkVkQWFOb2ZLR3ZUKzZYL3lxaE45YXNVdHIw?=
 =?utf-8?B?cEQrV254YnNvZHV3emNBUmU1akpKZEtrSk5oa2xmS3pYYVJLRjZka2xCZzBv?=
 =?utf-8?B?N29LQ3pDOVZUSHVNTFRBQlpJZXNVWkN5S0NIOS9kdS9Md0QxMlhNVEF2Z2tQ?=
 =?utf-8?B?ay9UU0VWV3I5VnFMR1lHanMzUnBZMm94U0xiVGd1QVJVdEwwdDlnSnZ5N3Fp?=
 =?utf-8?B?Umx5SlFCUUhnQ0t4Sk1VbVh4M2Z4QnZIa2lURVFEZzdic1Fuc2ppTWN5TGRu?=
 =?utf-8?B?SFhRQUt3NExsNko4dDI0ekw0YUhpaEZnMU8zZXdCNG5Gazl1Z21sMDRaWENU?=
 =?utf-8?B?aDZ1cmdzNW5sejBkWUZJRk9RRis3UzhTR2xaRGxKQjNIM29pbGZkbEIwdHRK?=
 =?utf-8?B?VThCUkVJU0RWTjY4ckhId2h0YXFsTS9sMEVXREpnTmNoT1JTOHZ1c1c1cGJJ?=
 =?utf-8?B?b3Qwc3ZNQmVYakp4V1pYdFBZdUtlallQalVLbWVFZmJ2WXVHTGh1R0RaRVhB?=
 =?utf-8?B?RUREVUlZQlFyVmFPY3hPNGRJay9CMHNVamhYMUNsWFVMMDBiUkxQRUxyNUtz?=
 =?utf-8?B?emoxdm1NeDFQTHE2SW5LdkUwaUlTa2R0b0hXN1hHOEpoYkttNDdxa3NKZkxN?=
 =?utf-8?B?UjRVaUtreHU2NHNnQmdla0cvV0xPSWpFczR2QU9acXVJaC9kbjBISU1kOXZv?=
 =?utf-8?B?TW9mL01KV1MvZWs5TTkzUXZUZEdUNjBOa2lZOEtZcXlmNG00cjdpUjNqQlBZ?=
 =?utf-8?B?eGw5eHZBbjV0a0JMWWN1QTNVSkF4Znl5Z0F0T2M1bVR5ZFJPdjVydVhjSzU4?=
 =?utf-8?B?dnBOcTRYOVRVMEVuSXBMTzBBTjU3NWtmTXhIOHBub0l2QVlmck50cGpqaXRT?=
 =?utf-8?B?eDU5RXd5VUJwVGh3OG8weGdLUmdFQWpDdFJ5QnZnMkc2T2pibVRwZ09ROGx2?=
 =?utf-8?B?OHNBUzI0bUtBSm81SDlKdGlESktGMzIzcEdyam1wMDZhNzVnMVcvSkpWeEVY?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cad4c50-70b1-42bf-6f7b-08dc9645dc9c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 01:09:57.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3PSaHSTfLVLtW94+NvlvW+STjjFs0ROXx5OPd7mY2qitFq+YIFVnt6DM67F1hhUBiBnNdAe4ok8sa9bYoWE3aSOc7UP9wIP3/Fib1F0wSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7124
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> On Wednesday, June 26, 2024 2:45:14 AM GMT+2 Dan Williams wrote:
> > Alison Schofield wrote:
> > > On Wed, Jun 19, 2024 at 02:59:41PM +0200, Fabio M. De Francesco wrote:
> > > 
> > > Fabio,
> > > 
> > > cxl/acpi does a lot of platform config work. "...unsupported platform
> > > config detection" gives no hint that this is about CHBS's or an eRCD.
> > > Please offer something more specific. Thanks.
> > 
> > The message specifies "mixed Virtual Host and Restricted CXL Host
> > hierarchy" as the conflict. The relationship between RCH and eRCDs is an
> > exercise for the reader, and CHBS is an ACPI detail that really should
> > not be emitted in an error message. So I am struggling to imagine what a
> > more specific error message would be without paragraphs of backstory.
> > 
> > All that is needed here is just enough words for when someone posts a
> > problem to the list that someone savvy can go "ah, you fell into this
> > specification hole where CXL 2.0 root port registers are difficult to
> > associate with an RCH config, thanks for the report now we know that
> > Linux needs to worry about this case".
> > 
> I think that Alison raised a good point.
> 
> If you have nothing against it, I'll change the subject line to: "cxl/acpi: 
> Warn on mixed VH and eRCH hierarchies"
> 
> How about that change?

Just, s/eRCH/RCH/, but other than that looks fine to me.

However, I thought this comment was about the error message not the patch subject.
