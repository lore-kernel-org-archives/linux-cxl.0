Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49C37F0E9
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769797580; cv=fail; b=Owj5+Wm+Si+ZuW6+3MTzQfNiJIlFFhKVs48o4w8z/LyhEL9vfkRbxYkPgH6EVmAIchzaiEfsC13kN+kjePhizzqwUQMZv1n4UHyBgvJlmBOfxUjx6nyA24cJ2QNp//d5PkPgiXBn5HZlbvBcZ/vy6kCQ0KeHMuEz1lil/ntVX/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769797580; c=relaxed/simple;
	bh=mIpABtWRk10D25yUrxxEmI8DwHUde1kU8Z8KP3hfQ+c=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=pk11UkSDa4hLJKR8gsBfmSg1X09WHwpoS+2IGfuoOsizA2aI9k78+vYrZR3ZiAeqSajw5s/rjdTl2LamVoQqv8yMh1QdYKqtEz/OsJvlKTgSNs7+6i7FVhGTgeCPo4DJFnoCw4Sgjgj8xEodD4/hHVP2KHPzSqUNyEuswgOle4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3MUgDHO; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3MUgDHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769797578; x=1801333578;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=mIpABtWRk10D25yUrxxEmI8DwHUde1kU8Z8KP3hfQ+c=;
  b=e3MUgDHOZmSV7bi2n59Fu2akhU3JRo8It4CkGQbsvXPvRjqiQiHwdKq+
   PvBqgFWvcgF6O8d8oOwMOI1l7nN230Cie4UElmIU0iYZydO7FGcPMooVC
   0jShcrFK/uyXd4ssezAd60Tt8d4lzw0e/00H4/lmaJoMsoxuB9JFdB2jI
   5tV72Mkbtr1f/HzrH4WJWbDAYSgNAHKq2eqyVpvuydwP9HOAgXbjLeit7
   gQ63AR0LI6BH1+zHwoqteqY4zGZQEo6XvPg64cpN92+0UcUN0IHDxZ2Rp
   AfwU87wnaVGLl2bSRN3L7N7EZhYRtH0qbaBRuhYxZawj5xh3Eeinpmrk9
   w==;
X-CSE-ConnectionGUID: 4Sl2niFBSGCA36+6fGIzDA==
X-CSE-MsgGUID: Ej6qQRRRTmSro9QOuFpvPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="70254458"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="70254458"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 10:26:15 -0800
X-CSE-ConnectionGUID: SCT6UY3oRPS+beSujvoYNA==
X-CSE-MsgGUID: vdyf/pwCR3m7+/odM8nR1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="213416634"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 10:26:11 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 10:26:10 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 10:26:10 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 10:26:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzPj/4TMIoLkStieDKcY7RH3eMsh8McaIij5UylqDEI4PXdeWtycU/lWRZaacasdO/3/lzxCiNGMpAVyNAml4hAc2pZdUu4e3wJXi/3mVGL+sXNUYYcfWHx66J8B5MFhcOqChMzOh7SCZn4zjXVUNSo4nvWfy/vKfHSA2F3KBkcTjiA/Wa8CGNR/9Lcx+zHKW8IpfmYp4Y6ZkE/WZwVAzo50mpZ6vmlDmAsinMjdjNTYCX/Dj+/LsAUoCl3Xqz8g27cNMpawHjwIshiOkc9jtuIeC94VkyTBPKd3HbAU1tGw/Zl7xnapUADrXKDkZlgNG9AiOJRuQeGUGCtOfdNpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP86id+Yhm2g3pk7M88caAkkVAPflZYShO7Y+2dM9Bs=;
 b=e+1rA8DmVhCfB4Ue6Y0R64NeEheYCRM6MgSy9uuAf+oGQUW6b+bqA0r3Y6V89rIJCY6aRJxxWOk5qtSspVUCx5UBZ52DXbnKjlxnMl253LrpbdiKN5cFbD0iiIVbZAsuNR438pbqsbG2tQJZL/m/KX8Z0dp2W+WjYEmenNEPfHRPWmftYv+nCXFHUsm5dedIVjo7c3lO6Qod77EPjk0iHWL7Za2WyOwVRdghCpmniKQ+FWOITrFckjSxcNDZ8qzV6dnyx/mjSV7C/Hv+kiK0xmuKJs8vQOtjQI0hlDlRFw5SWhVP4k5HaMkhBr9ghxbeBy1vaKmnkg1xv7CzaSE4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 18:26:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 18:26:08 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 30 Jan 2026 10:26:06 -0800
To: Gregory Price <gourry@gourry.net>, <dan.j.williams@intel.com>
CC: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>
Message-ID: <697cf7bed7112_1d6f100b0@dwillia2-mobl4.notmuch>
In-Reply-To: <aXztmSYih24WZgsr@gourry-fedora-PF4VCD3F>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
 <697c3a6155b46_1d6f100e1@dwillia2-mobl4.notmuch>
 <aXztmSYih24WZgsr@gourry-fedora-PF4VCD3F>
Subject: Re: [PATCH 1/2] cxl/region: Timeout auto region assembly waiting for
 endpoints
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: d409971f-1c37-4bcc-4436-08de602d096b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUJOdE1aUWNRUTV6Vm9rVHBYb0pwUU5UekZuQnRQRFlYWTNTZkxIOVgyS3Np?=
 =?utf-8?B?V2htTEVlZ2M2dHdTSVhsalVIOWhYK2hWdHM4Yk85MVFhYW5CNVlKMHhVVnBn?=
 =?utf-8?B?Sm84eXhhTGZIK3FpSFFuYXZ0eWNzV0tyZDE1dHB4Zi9KZC9jRFZsSTdlYS9Z?=
 =?utf-8?B?L3lYcllxa084TFUxcWsyTDdBWVU5eC8reDAyUDJ2em5idnlGd0tSK2dsb2dz?=
 =?utf-8?B?cytKZTFrc3hvWUxKMDBKb1U2TGlUYXpDM0ZnMjBtQ3RpS1Nna2cxZDJCYmc0?=
 =?utf-8?B?cG5ReG5NUHBQa29aeE5RalVxVEIxeFgwMWJOaWIxWEh4VktoWTNDZTlxaHpQ?=
 =?utf-8?B?UnI0d1VUelBBTFlGdUVUek41MjZuMzJMNkREa2g0Y3B6SXdnb3pveFRWdzVV?=
 =?utf-8?B?UWNOZXdlNjVEZjMvRmZMUWlaL0psUkFEVnhySXBBaGNiY2JGSmtHWUl2Mkt1?=
 =?utf-8?B?K3JEY1BWUlAxU1M5QzV6YTh6R0hSYmhNdFhPOTl5R1lkc29CVWVuYnYxK1VY?=
 =?utf-8?B?UEpVdGZSdGRkVC9KTldsQnAzRW1CRmZLZE5vcXQ0UGdRREMwOXBQdTdFV1lD?=
 =?utf-8?B?T1Y2Z1FXMkZxU2UwRHBXUTVUVVVtd1MxOVg5NUlrbjB0bnNnNSs5RkxBeDZq?=
 =?utf-8?B?a3JXQ3hyMDlYYXN2RUZyQzI0RVdwaWc4MldYaDVUWFVsUklmYmcvSS9BU3Z2?=
 =?utf-8?B?M2dvTFdmNWliQ0Z1Nm81QlprbGJpWUZaTU9sSTYvdksxMElmQkc0a3BVV3pu?=
 =?utf-8?B?WnBzZEdmWk11bGlCa0pjdEpCTUNqQ3RDaFk2M3Q0RSt2TXNVUnFoRnV1YjBs?=
 =?utf-8?B?YUdHSHIwNDU0ak9kSDd4Z0w5T2FBVmQ2WmtQbUEwYUVVZTZ0UTJPN1pJZDdS?=
 =?utf-8?B?QTJ1Um5uUFh2VWk4N0IvWk9TbWRsY3lZbTl3QWZhZGhtUWp1M01YejJhWXI2?=
 =?utf-8?B?cHYxQ2pxdklNU2lheGJnUEVLanc5OFNOZml1RVlTK1NWSFNzSHk3ZlhPbHpv?=
 =?utf-8?B?b1gyK2twWlhIZUgycnZqMFBjcGQ3SjVRQjVoVGw1WUdYZjYyWVRXclYzUUpM?=
 =?utf-8?B?MTYzcTRwSjF0NUE0ZUNTb0RVT2lkZVFaN1JQZGdWb0JtVVU2eGx0VDIwaEVs?=
 =?utf-8?B?QVp1bklBKzVtL2hvZDQvbnNheGg3a2REQUtkRHM4VENXSjFsUVRVbkN4eWVP?=
 =?utf-8?B?UkhKN1NkSTB5dldEN0hIMWlEM0REeDhtS2ZvaUcxQm1VMnFodjdNazhrYTlL?=
 =?utf-8?B?RlI2YWtpR0lncnVIbk44TzA0aWw1TGFqY0Q1ZnBQaFZkVzFXekxSRHdXajFZ?=
 =?utf-8?B?TjJqQUVsZVVMODlhbmxuUTc1dlNxOG10cFZEZlQ0YzVUNHo4WnJBc0N4YjAz?=
 =?utf-8?B?aGtkWkNHMkhBVy91SFp4VmhwTk1tM0hhT1BBeW9KLzFwRysyZUlyMkRHZTUw?=
 =?utf-8?B?NG1kdUtmWHdzR3JEaFd1V2txM0RDb3g3N043Z3h5TFJUVXlod0oyRGNSR1dV?=
 =?utf-8?B?ZW10SlRlVGpRVG9tbkR1WDE3Z25tZGR4clhqdXlmVUZBN204RGpSajBxVnVQ?=
 =?utf-8?B?K2VxMEhZL1hsbVdlT2xmVmRMb0xMcmRCckRlYXZuZzRjSWlKZXN1UGJLbWZI?=
 =?utf-8?B?dkJsMG01Z3c3eTVLaDQ1Ry8wWm42SGJaV1RtaGM0ZG9aTHVLeldwR3ZFSCtJ?=
 =?utf-8?B?bVg2QTBQblgycEhCNXFaMUpEaEhIak8yeGFTaDFDamJKNldKTDlYOEl3VVZR?=
 =?utf-8?B?TWdlT2pHcTB0enlkejdONzNtU2laSXpkSGNhWjVzMk4xcU0xczJEcnh5SGVH?=
 =?utf-8?B?Rk5jbWdzaHYyZ2gzRkVYMEluOWxFZ0xqZnFUL1NXdll6RlB0VG5ZQ2VSdUh6?=
 =?utf-8?B?MXphYzlFMVV2akZzeEtGdGZNVlJwc1F4aWF5R2NXTE5WS1B5WnUrZWdXdFlJ?=
 =?utf-8?B?OTBaL3EyUjh1ZFpjaWFzVnN2Z3NVQ0RFSDUreFBwaGRnbTdjTkNRRTBLZ3hn?=
 =?utf-8?B?UmV2aDVLcVZsUERZYmdxWGJFd3BENjViNlROUXo1MStGUXdVUzhxL0xvbVlL?=
 =?utf-8?B?UmJvZjlZcWUvaFBqd2JNTi96ei9PcXRQdC9WMGUyeFNlS0FWeXV2bnAwdHBE?=
 =?utf-8?Q?V12g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCtuOU1ORGxDbXlUMFFwd1BZMVV4VERPa25BdGQwRVAvclhTNmJpc0dqYWor?=
 =?utf-8?B?N1g1UGFhbWVIaUd3RzlBM1NTTWlmVVFFVi9CcDhKSFEwOUZBY1hmQXJwQzgv?=
 =?utf-8?B?YXQzZHlYMGNlTTJIYWhUdlJ4OTZyZnpoMDRBeEVKOG9nUmhPMlN0MVJteWdP?=
 =?utf-8?B?QkZuS010eG1mWWhBMWFEaXB3ZE4wVkN4UDdHZ0VOQ2lvazZnbmJOQnJHTVVz?=
 =?utf-8?B?bFRzejlFaUxCVDNnMnlOaXkwYWZHYTMyRG1QVjJpOGd3KzJMZHNJSERqZ1hp?=
 =?utf-8?B?Z2gyRWpiTUJmd1ZJUDRnQ3lQQWQwV3A1dno0RDBZeEl4RmJrSUlUY1FJWGc5?=
 =?utf-8?B?ck5saVMweGRCUWdzdi96NDZGOHgvc0F2ajZwNnBKR1NZMnZxU2xGNDVLakU4?=
 =?utf-8?B?OWJSVS90STRuNmhHcjUrTnl4alM0bWJxclYwOVM3OTRnaUFoRitJdlhPdE02?=
 =?utf-8?B?TUlacWxrMzNTdEtRR2Jpam9yQ29XMkwwUFZDcDVsT3RCTmZNaEtHaGFVNVZm?=
 =?utf-8?B?czZXMUtSMzJFRTZUWjZrc3ZHaUdXdTJSbjl2UTlXaWpQNXdrZ1ZrdDZnNWNT?=
 =?utf-8?B?Mk5ZSlphUzVjZ2c1N21HQnFHUVJGelRyUFo5OEpmZjRETmlDbkZkYlpXY2dl?=
 =?utf-8?B?NGw1NFd4WnZYSWgzZTZHVUgxUVpoU21oSDlvTFlWL0hyMk1aUnZvMXBqc2t1?=
 =?utf-8?B?NUJVSmxOWGZUT05icjF5ZEJhZ2lveXlkOXJEbEhnWFA0dFRVRkw5SzBkek90?=
 =?utf-8?B?S1BiZkhMWTY1VldWcVhMM01NdU5RbzVubDkxQUd5VzJHTlNyN1JpQll0ZjdQ?=
 =?utf-8?B?RDMrcnF0ODVJRlVoY1BhYWxuTW93NDNWRSt0SDNVbysrYlVIZkRqVkZnRCtM?=
 =?utf-8?B?bEszNUF5MHkwaEgxMVR4Q3JFYXRVaERLVmYrTTUzaThhcmtRdG1kWVNGaXRq?=
 =?utf-8?B?ejR2VVZYUTVGMU4wbFhCNFBJNGdoc0szdGc5cTFYUVpoL2xnZUxJaHQ5MG14?=
 =?utf-8?B?Uk85Qk9DRnlWL2xoNWk2MXkySStwTlUwblJEdnRERjQyclVaaGFMcHBxNGlL?=
 =?utf-8?B?c2s4eDYvV1pVWWtDb0RQbmMwcTk1M3NQQlpJMmljTWNmbnY2cDBVYTMvTDRW?=
 =?utf-8?B?S0xLSlpLdHJKaEZsNTVlNDFOenJCdWt4N0dvVTJ1T3prUHVFbkxEY0dzWjJQ?=
 =?utf-8?B?dkZIWmZHd2xLcFR1Nnk3a29pRzBDYVBCNmNhMVF4eW5oR1paMkt3Y1AzSEEv?=
 =?utf-8?B?b04yc05BNDY3ZmlhME5UM2x3cWdMQm0xRXY3TmtCZjJTaklvOFBaYVBMK1Bm?=
 =?utf-8?B?SVp0VkI0d0tObHdpY1ZPVmE4bEpNajJKZTgwMG94R2ErS0dSMUluRUgzNVl3?=
 =?utf-8?B?RUl1QWhyR0R6NW5OS0xFdmJsQ0NJZUtrRVdIZll4SzVIODBZQlFnNVRtSmpr?=
 =?utf-8?B?Qk00TG9tY3NJaURVVmZEM2hBODNnY0lzNFFDbUUreEc2czRjbEtsS0E1ekJk?=
 =?utf-8?B?akpubHNEeWo3SEFsZ3RidEVwSHkzb25iYXZWSjYzYll0dERjNm8vY1FGTXdY?=
 =?utf-8?B?WGZkYW5NbVJyOC9DWHEwQUM2OWFxQU1KaW1TdDdWU1FSYlIvY01JaXAwNTE2?=
 =?utf-8?B?RER3VG1ONFc2ZTRCSlNRaW9US0RpYWJZZ0lxY1Z0UkRxdEhDOU9VS3VFYXJw?=
 =?utf-8?B?bFV6MnVsWG5GSitGc2x6dHpsS2tmdzJEeTZ4NkhSYnB5UTM3eUpzODNoWSt5?=
 =?utf-8?B?VEczSnlMVjhQNDNsTENmeTlsVU1SR2FoekhKNnVwSm9QM2J5SnhBdm8zaXNv?=
 =?utf-8?B?Wld3bTMwdjYxU3RQZWg0cXZjRTRwMlQyU1dlNjhmQURueHc2ZjRJa2lQZjIw?=
 =?utf-8?B?dkx6ZmRLVkk5THVzSzV5ZEdiemhFdUkvUG9oR3VWa0RGd3JKWCtyUVZCeHVj?=
 =?utf-8?B?UlYzUzJSeUhpeUhhM2M4V0M1Y1VCcHdWOC9CU01yVHJXREpoSmxuQTdNQzFK?=
 =?utf-8?B?QkV6TFlaQjdOL28vYU1FVXZESDNKYll2NG1lM1JDMFAwSFkxY3hvWEdPbndr?=
 =?utf-8?B?VE5SU2RXWWdhTGFXdFpYenZENTFLLzNMWnNDZUFuQjRNdzRJbjI0OTRRRjVt?=
 =?utf-8?B?U1F1QmY0RUg2ckxLUlUvRmJmbjBqTTJTckNBbVhhQkJkcTV1WU5Xb2RVOVlx?=
 =?utf-8?B?VDY5amYvWlg0Ry9MVnRZazY2eFJWYWM2cUxMbnJLTnJ2bkFOUHJDSmFlVUIy?=
 =?utf-8?B?TWxRdmRpaWxuM2EwLzFSUWp3UkRoaEM5KzdjNTdWVFJUS3JPa0Rqang1NDFr?=
 =?utf-8?B?MDBQMzh5WVRRU2JsWitBY0wvTjl6UnVMUG9xRWRHSFdvZm0yM1FReGxpelY2?=
 =?utf-8?Q?R4Zf7cIPQWehzruM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d409971f-1c37-4bcc-4436-08de602d096b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 18:26:08.2884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnL6CpKImEazlYjLpBmghbQJuyqUeBtIREWqMi9XYZdlqOz0bOmnQY3gUZ2pbIm3oJtTznoFbN3uUzN4KzI3n+Ng9Dm40U9JHghWy3bR92E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Thu, Jan 29, 2026 at 08:58:09PM -0800, dan.j.williams@intel.com wrote:
> > 
> > > Cancel the timeout when all expected endpoints attach or the region is
> > > unregistered for any reason.
> > 
> > Setting aside the above, this looks like policy, and every time I see
> > policy the first question is "can userspace do it?". It would be
> > straightforward for userspace to kick a 30 second watchdog upon each
> > region KOBJ_ADD event. Each time that fires go cleanup partially
> > assembled regions.
> > 
> > For example there is no automatic cleanup of partially assembled RAID
> > arrays. So, precedent leans towards letting userspace decide what
> > happens when composite devices fail assembly.
> 
> Sounds like there'll be a nasty race implied here.
> 
> Lets assume a kmem region that gets auto-onlined
> 
> 0) Region is waiting for a device
>    1) Final device arrives and starts probing, locking the region

"locking?". There is no IORESOURCE_BUSY contention until the final
driver attaches.

>    2) Userspace timeout occurs, firing a cleanup request
> 2) Region finishes probing
>    2a) this creates the dax region
>    2b) this creates the dax_kmem device
>    2c) this may auto-hotplug into ZONE_NORMAL
>    2d) kernel page gets allocated on the memory region
> 3) Userspace cleanup arrives to unbind
>    3a) dax_kmem is online and can't hot-unplug

Right, userspace needs to honor typical managed hotplug and not force
removal.

>    3b) dax_kmem abandons hope and leaves the memory online
>        (see dev_dax_kmem_remove and remove_memory)
>    3c) region cleans up
> 
> Final state: region can't be rebound because memory is left online
> and unassociated with any device

I do not see how we get into this situation. If dax_kmem comes up, then
there is nothing to clean up. Yes, these can race, but typical locking
should ensure full forward progress or cleanup.
