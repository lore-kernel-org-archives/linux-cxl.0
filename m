Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7CA2836F
	for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053791; cv=fail; b=CCv7Y7UOOa9QqBdgpYh+t1g4e10a8LjJDdYrh6Mq1Wlp3Zox8+w69W2TJ0P+t3+l3ve6xHaggj4jYast3n6hMnxZtElVyfTgf/2itJWIltf4IDOJEPFDhgJ1ehzeUwrKXBkyf9VE3yAplfxB5/PSqqMT70SOGA8EvikQua63mlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053791; c=relaxed/simple;
	bh=n7cVCHkY8r7KNiiKZrctyC8amAEa3x6ZMv8l9BcOjYs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=k1ay2++jhmt7G5/5jVj1gZn1BZtBgq3ncPZn6P9gxC8fe9pYH07E6/THoKPICboqYe6JJmZ3g8e+16JDmqSv8qy5JCWWEsdir1AnxJNdkyat84xlt4jdJ2lJbNJBFaAsANZCEYyHjS2FF+W/mTLbPflmfjhM4lYVNIRtETqETyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhuW0s0H; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhuW0s0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755053791; x=1786589791;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=n7cVCHkY8r7KNiiKZrctyC8amAEa3x6ZMv8l9BcOjYs=;
  b=dhuW0s0Hwe9ecqOGFql2vwbfWKuA/3n3TsNbYZQMFQX7YV2Itf0MUCne
   0dPsG8qWv/FEjHqs3c4OZdGnI5sLqqtt0P0aUOi/cYRT0MXPxm78WSZuu
   Oyl8lk1Gjd/RvCqTTEmf+JEqrrVRtKFNr6z/RDDWn28x5Evt0ugVWY8PP
   awU2UwWEn5kxQlPYo3Cx3IY3UaIPwmtpN5Iu6TrMV9n7nznLnrj/1pc9w
   c9rmD8OyiK5IHFu+VOFwlpLFDJUNDhG7tVL3AvbhFoLv+nBWyCwNPW+Iu
   Lo0dUTZ8X67hwiq+M2KMf+3nekUvif8OssVl7XQIk4ZMtLb4JyN5YaUj1
   A==;
X-CSE-ConnectionGUID: 5kqScFsMTe6bxkPzEMO5WQ==
X-CSE-MsgGUID: /r6bi0y6Tj+MUScRlP8aVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="67602803"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="67602803"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 19:56:30 -0700
X-CSE-ConnectionGUID: gMcNHVWMS1S3alViiCDw/Q==
X-CSE-MsgGUID: GMHMNIFDTG6lmqT8HZOpUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166723325"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 19:56:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 19:56:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 19:56:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 19:56:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhONvrSKCN/i3G2ShwiOUZfBev0JZ/G+GLRi90xu/LVHjSoDU6u8CFho1idNSzk/uwvK8jIaiSSyY0PBvjip3F7abtLoKrmbpORgUtvuj4hirgH24VS3GVd3yKzmOz+harJ1rmr6jmRUYXK/SOdk07SMm+LrMKdrcIQLBCi33ZfvGOK3H21IgpD+eIbbmZJAzxAcWRVL3yawGSdwRMEOtzR9KGqvaCy92Bj+l6VyMaoD5cxXXNnwES+5ddIh9vYUc3d4E8RMBcQ1iiaMudLh41/zxMBqom52A9AsN5202WYw4Yujv+AhP7LZZqGU+ls6z1qYOR+DHRvEEVbnoMnr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG1n/s085+As5VqOA4lwRIhr3xofzdhmCRZWZinL8GE=;
 b=cKYmsKflfmU7GaGTce+Nb+rjfwI9gEpSuifhrv6x5vCtvcAt5yjpJ5VUkeekozo3ZnDPNRkw8MAmM3EIDg5LHqhTqX3JJb+ur16VKcT119rXIcTATNK1g/khA81fMEB1fMuiQpZ+tnM7JpJu3QWV9mE/BuG4StQ2cyXaD/bGpPnJcOoqrolmw04uUuknC9Cr7u8doD3uyqOIhGk7U8DZfZkSmypctRMFjAYypwGfVlJUmYtF9qL2Qy5CWInqFuK+mdcXuCotajZ5beauijtQVKS++AGk2cMmrCaVEAFAKSj+Nc96ks/BXXx6EGfaRH3Q/1OD57ljSIucXubV3RdRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 02:56:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 02:56:25 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 12 Aug 2025 19:56:23 -0700
To: Alison Schofield <alison.schofield@intel.com>, <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Message-ID: <689bfed7a59b7_50ce1004b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <aJv2ZYOOw3EftLGQ@aschofie-mobl2.lan>
References: <20250804082357.2590809-1-alison.schofield@intel.com>
 <6893a593bb584_55f09100bc@dwillia2-xfh.jf.intel.com.notmuch>
 <aJO4PiyliQiJpMjO@aschofie-mobl2.lan>
 <aJv2ZYOOw3EftLGQ@aschofie-mobl2.lan>
Subject: Re: [PATCH] cxl/acpi: Limit XOR map application based on host bridge
 ways
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:a03:331::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: f1591fb1-e659-414f-f19d-08ddda14fe4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkM1RFhNcEdLdEtuT21IMjl2ZUZPZW1xV1JjK2h5R3lnOWJmWUk3aDQ2eWwr?=
 =?utf-8?B?WkFjRmpnTndtdEhOUEczTU9wZWxKOGJhU2lqYkY1MC9zNDMwcnEzVy9XV1lr?=
 =?utf-8?B?b1RtWXdHcjFrSURpemR6ZllmSXZGUnhJS1hqZkNoT29wQmdkOTlUT1p4VXlS?=
 =?utf-8?B?L1ZvM2RNL0FQQ0FpNnoycmFmQ01pL0p3d2Y5V1BmVWdEMER2dDI1VjdWdk1U?=
 =?utf-8?B?aXhYWmVoMk92RlV4dmNZeCt6a3pVYThONTZuNEFaRWJlRHRSS2VSS3JIQndZ?=
 =?utf-8?B?WHkwNUEvSzJvTGoyanFuZThsa21SU0xIMUUyajJwNXBKY1BRMGswSU1oWHVT?=
 =?utf-8?B?L1R5dmh4RjV5aXVPM2RkYnlwSldtT3pjcTh0TlBmM2gvM3owemlkS3c4TkFZ?=
 =?utf-8?B?UDEzRXpVRWVSS0lCcFJ5TzA1cUxieWlnT0hjemxjUTFqMCs4Q2Vmb2JKSVVm?=
 =?utf-8?B?a1JEVkN6Nm8wNW43WUk5MnllZ1htSHFZSWhXVk1wRDdEbHl1Q1o0THIwMWg4?=
 =?utf-8?B?amlKZFFiNzBjamxRcGVPN0lxTjdScWJqU0tBQ3QvTkhqSElPUFJUREpFWExS?=
 =?utf-8?B?SlhhbDV6Q0FIcnlJNGZ1M1JjbTdodHBSMExVcUpVWGo5em1iaWhNazFuMTEv?=
 =?utf-8?B?UHZFbnp1aGY1MHVuZWtnb0NnVUE1U1h4bTZPQUlTVXVOMmlnU2pKMS9MRTJu?=
 =?utf-8?B?UXBrSXNmVUZvOFN5YlhJTS9TQXZ1NXE3NElUVk5DSlFPR0pqaE9OWGZ0b0sv?=
 =?utf-8?B?OWtLVE1jM05vUEg1RURRekZUYVk3TFhScnNra2t5bDRyVElzSEZ0a0RIS29u?=
 =?utf-8?B?MXl5TURMbmpjR0FZMVpybGJXT2NHZ01JeFZYV0hWczdjTDBoQUd2a2xNTS9J?=
 =?utf-8?B?QTZycFQxYVR4eVhtSGRMdTlucW5IRUliMW1yOHplczJkSVpjdzRVZFdTVVN0?=
 =?utf-8?B?ZFk3UGJXSWZMRkFGYnJXS0NPMGFjcDg1VXQ4bkx2NHNzdlFqM2hJcVVQZnIv?=
 =?utf-8?B?a25LejRvc0pOZUEzMkVWcXJxTGNETDdVWWtpVUQzYnlwZWFwaWtCUEVkOE03?=
 =?utf-8?B?R201WlZYTWgrRjA4ckxRN1Y5bS9ZVU9laWFOelZiNlh2Wk9RR3ZyVFJZQVZG?=
 =?utf-8?B?RUY0Zm9LaGg0OXdCSDREVWZ5MkZYb3NQblhtMytDMkRrMTdyZ3lnWUNzcC9n?=
 =?utf-8?B?ZFcwN3RadElSNWtkb3JIeXRsdEF5bnF5VmZBYnpLS09IVjRBQUJOQ3lCRWgy?=
 =?utf-8?B?bGZKVGV6U0pmSkFOYWRzbWVabEhuNTA5ak1jODRFdFNlWUhKZkR6ZzFkV0FO?=
 =?utf-8?B?bXlSVFR0d0ZLZGo5eG5iZGpCMjJjemtuelgyMWhqbmNTQU52b1VmVFJBMklC?=
 =?utf-8?B?eWx1L25hZmZvaTY3ZnZ5L3Z2Z2pCQVJmQ0J1czdBQzBhMzJreUQ0UkNZODdv?=
 =?utf-8?B?Z002ZWhZMmtxdXZYeitrdDNIZkxkOVloei9uYUdidnNkM2xDeUZrb1BReFND?=
 =?utf-8?B?b0FJdTBwVndsRW1BN3Bnai91MGZKbmxpUWFDaG5Sa0hDOFc3b2xhM003YXlO?=
 =?utf-8?B?WkgzZ0RZbXAxMk1jaEttSDRYMlJRdG9PeHpyTnBmcTRTSnk1LytnRDRrczdF?=
 =?utf-8?B?a1VpVUhYbXRkb0c4Tkp1eFQrcDQ0b1NzWG96M2k4WllYVi9zaXd3cFg1WEI2?=
 =?utf-8?B?SjNKS3VtZ0wrVC96eEV2TmFwSWNjbjh4TlhaT2gyTE5xa2FMRndEdFZXMmp3?=
 =?utf-8?B?Qk52Z08wbHlZWDUwSW1PalpUb24wZnAxSXNJQW9samdlVHhYSmo1MU9MeTdD?=
 =?utf-8?B?MW9sZ09lTnJpT0N3d2xjS3NtZzQ0eGU0Z2xDZFlFMnRzSFhxc1loTTk5QkVj?=
 =?utf-8?B?SUxXamE2ZkFPdmhiZkJqb3NydEJmYkh4R2NnNVFkcVNtNCttVEw5M1pRWFhs?=
 =?utf-8?Q?YjEFpRRNO4M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTk0dU9BZEgzTVRRTWlkd2g5SWVZeU94T2dDc2hDL3JNVVVuTDhCVEJ4a25h?=
 =?utf-8?B?OEd5YmZYUjEyaU15RHZ4a05TTXpJNGIzc2QvT1h1NHdmaXgyYW00TnoxdjU2?=
 =?utf-8?B?bjhBUWhlTVpIUmptK2NZa0ZqNUh6UTloUUtGTXZGVmRlR0VDbTc1ekhhZFVI?=
 =?utf-8?B?TFRzOGlEWHF4RkNNdlFlR3h3bXJxWXAweWZsRUZtZktkLzdGN3IxbGc3Zmly?=
 =?utf-8?B?Tlo0bFQrN1FrNlNpOWF4Tlh6R2NxRGJoekZFN2M5R2pQUVdxN1FpanRBL1Nv?=
 =?utf-8?B?ZGxhcUhWd3dBWmZIWlVuSVpqZ3F5NTRLajJ5V0hBemQ1WC96OEI2T1hEdCtu?=
 =?utf-8?B?ZzhCYXJRdFpWbUNMUHZ4ZWo0TXgxL3Vxc2JKaTdLTkJFWDR4UFZGQkhTTzl1?=
 =?utf-8?B?ZGEwb3o2OTQ2aURkZkUwbk0yQXlXYXFMMDBVVFBxS1NxZU44bXhrTE9DRDF4?=
 =?utf-8?B?a2trcmNTdWNDRUg2K2N6THlsZU0xdTFFK21kSm5EU0lmNGhMZXpPUjVzdE83?=
 =?utf-8?B?VSthOWVGSytFaFpRN2t1blB2TmVXTFl2dWNYRTg2cUdCdnNwbVc5ZWhPelVE?=
 =?utf-8?B?TmxYRy8rc1E4VWw0bk4zTEYwRzlmRGxwQjl0Z290Y1ZSRVhnY1Vmd0pNMG9C?=
 =?utf-8?B?d0VzVW5LTEdxd2RRUmdTUVNVdXkwa2tUSkJDbGtKRzdmSy9YRDFsK2Jyd2dO?=
 =?utf-8?B?QjU2NGhiQUhiQnhBTStOdjM3WTRVa3JYbHF1dmd4STZEZ05GSXlvamtwY1dE?=
 =?utf-8?B?Zit0dURmRjNWVFhHWXJmcGRORVpORVhKZlpnSHM0WG5VVThObUZyelJSWkJH?=
 =?utf-8?B?NTNsVmEzSlB0c1JEWnhMRTl5Rng4ckRvQXdtaTVFMjBnQ3FUVStYbW5hUDh5?=
 =?utf-8?B?ZWxBNzBqMlZmTzI1dndzTXlRTTMyV0sxWGtTS29UVDZhdzJFZHh2dFhTVHFj?=
 =?utf-8?B?MTY5WG1yVUhyZWIzTVVzMXZuK0ZTb0x6T1F6ZVRFMGt0akpZRlFSZ1E5SFVH?=
 =?utf-8?B?cjFNQUt1NjJBRHdzSVhhRlZ0SDQxUGZ4M0sxQ2YzUjdUKytYOElWcHh4MWhS?=
 =?utf-8?B?WStMcG5JWS9GT3RCWlFXcVA1L1VkazRkc3VKdXMzNnZZcUlndWU1MXBQakhY?=
 =?utf-8?B?UU5TM1EvbkY0WjhqRE4vVlF4bFVJM2ZDakkwTVhZWTdqdHNRTmhYZ3IyQnFa?=
 =?utf-8?B?Uk8wRVZySG9vc1FwdzNHbVZlM0pNMW9obFFPRENuVzdGM0pkNmI0eUtoTmF2?=
 =?utf-8?B?MENhNnB5Y3V2SVUxMWJDaVprM25XdHo1bG1OY0lZb3BxVkFGS3kxZ3FUMWRa?=
 =?utf-8?B?K3lzd3RweEpDYUtYUGRPcnlmQk92eUpqKzA0WnQra3hLTEFQRGxoWlQwd25x?=
 =?utf-8?B?TEwvOUwzbFo1S0J6VWN1Y1Y5NjdNczA5OGoySXViZWtVMC9lWUlpbXdkd2NX?=
 =?utf-8?B?L3pnQy92WDFJaHVkMzBsZllweVZJajFaWVRuWmszOHVRMFp5Z0Z1VlhhZlM2?=
 =?utf-8?B?REhneUQ1dUo2OE9vZy9GZFpWcXFIZ0NONGphY3hsVXZKak02RktJMU9ydE9V?=
 =?utf-8?B?dldNWHNqK0JDdWtFV2xRTy9mQjNFZ2xSbkZyR3FFbkQrWTN6TmRuYzJHUmty?=
 =?utf-8?B?SDRKQzNtcWJldDNQL21icDh1UHIyVHBFakdjcDZIM01LUE51NzMxaHhDNUZN?=
 =?utf-8?B?L2VMbTBpc3NJOG5EUlFTSDdqYnkraW04OCtsUUNYR3lySzJtK201UGtrcm9U?=
 =?utf-8?B?dkZINnBxUkt1QnpOdklrTVNxS3BqbXdqUUw0WmlibnBDUktQdVk4cXRxMXZz?=
 =?utf-8?B?VGFLQVErQ3htSGpjYkZVa0d5citZVVFPclJqTEsyOFhhb0ZLdEszcFFsSzRP?=
 =?utf-8?B?TUhxSHBTelkveVZZMzRETktZNE93bTNjL2pVdlQ2RjJoSGE0VU5NU09tZmlM?=
 =?utf-8?B?bU5yOTNDa0NBU3BQZkQvbUEveGN4b09DMGhuU1Joa1JDK282MThhRFRuSlZD?=
 =?utf-8?B?UC9Yc1lRV2dkcTRXb3NmWnhaWGxHWDlzSkFDT0tGa2FBaUp5dmIzbktybExQ?=
 =?utf-8?B?N2lrYUJFYlhuZXpvc0hhS3RpS0lINTE3c0ZCQlJVWmN2UExaM1l6cHBGQm92?=
 =?utf-8?B?Mk1CNjIwY0lYa2ZOQmdPcUdSTUh2TVd0RHVqSE8vTUhVZ0haOGRRT3I1NVRl?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1591fb1-e659-414f-f19d-08ddda14fe4c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 02:56:25.8243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwdA9NrK7bAAvintB5ZhV/FSW5YH01z8JyH/1IlChNtEJpv4xpElaqI+QT5WqgLRa/Cb5lpsiB5DumdJkBTUPaHynGcrGxmgDoStpHpVTD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-OriginatorOrg: intel.com

Alison Schofield wrote:
[..]
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8f36ff413f5d..2784255e7811 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1777,7 +1777,10 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
>                                    struct cxl_switch_decoder *cxlsd,
>                                    int nr_targets)
>  {
> -       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> +       static unsigned long const nr_targets_valid_mask = BIT(16) | BIT(12) |
> +               BIT(8) | BIT(6) | GENMASK(4, 1);
> +
> +       if (!test_bit(nr_targets, &nr_targets_valid_mask))
>                 return -EINVAL;
> 
>         cxlsd->nr_targets = nr_targets;
> 
> So - you'll see further checking when these are refactored to support
> the test module. The above fix to cxl_switch_decoder_init() seems needed
> regardless of this patch or it's future refactoring.

Sounds good, and I assume this validation will be a helper shared by
cxl_acpi and the cxl_core. Seems small enough to be a static inline in
cxl.h.
