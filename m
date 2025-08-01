Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E0D239E95;
	Fri,  1 Aug 2025 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092316; cv=fail; b=NI27ISWUfqQ3MK5rM2m0LDNN7Tc3SWmBumwOzEFQbk2Dn6kRwJ7m6FlDQtBJwpZkhiTawICcjSEjkk8R+f6mhEdb7j1eYGvyvzvAWE9nt5Ju4O9TP0FTb7At8rfNWP7eBzE+l5lwIv1A7dhjTO9jI2HVRF1VeFS0l+FQPP2k28A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092316; c=relaxed/simple;
	bh=0yTU0qzNCwMyyqxbTOqNGH1bscZGqWnKVqHbRNmWgdk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=GWBuNSkTzUCKmYqRwdGDkgJG1/OLqphZR3dnlpil77ftgJfecyfD4G7jSYc1te9+31yUxSue29sx1iJB2Ob8W/7YziymcxkQTKbRZZnz5BxHx6pYg2b0e0DdkaWxSLCC2GaqBQ4nPnxwmvmI134vVMXlsDTReLP7u6z8DD22PI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRSreDed; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRSreDed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754092314; x=1785628314;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=0yTU0qzNCwMyyqxbTOqNGH1bscZGqWnKVqHbRNmWgdk=;
  b=SRSreDedn5cqDgD7Gs8gYuJwQ5AtZCN8r/DMtow1wdmUhaaWpCShzRs5
   Bv0G0N/ko5a3GzY20Ha5bqZcDaiDhGgLvGOjHel9Jg9+Zbaszdpqx0gW3
   006JY1/0cyB5XSERYRa/drqHaWAFry5MUnY8YEfxjwOM7pFLl17ehgO1B
   2Z8XBX2bw2rFcPSGxXT+PBvpNjUnYyiXABQ0pt6c3GgZCzfmmdRbQL62d
   YahN1GiL5ZgBcM910sd4ybEeQMZC4gbYwCtRiZsfh2qWTkGqoW7JOWWpE
   79KNTpbkSL+j2cQ1SER6LtdF33MiR6BW4ZWUwXKWjiouSLubGqJDgPga6
   g==;
X-CSE-ConnectionGUID: 604WNaEqSPW61GSZiPo3Kw==
X-CSE-MsgGUID: Cn/7ljn4S9euCYGk2tLq2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="78997393"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="78997393"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 16:51:54 -0700
X-CSE-ConnectionGUID: 6XO2O1hhTsK3Q6L7nppv3w==
X-CSE-MsgGUID: 1AT+WC+tSniqebGP3wEwKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="167894277"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 16:51:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 16:51:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 16:51:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.54)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 16:51:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B32d1LZkn/azOsQe32AOHaSV4TX2zjoPU3hzOAe1f07T2NIOdgKfP/8nPtaxXD5JNdC6wJsODRwd9p4ORQFEIKXHhONsMJHZDsLYuLxLhIw4KNHwp79N/DNOm7v+N1AnieImGtQoX5V8uDVkCo4URrcbLPGnqLG4CPdbdbuW6+DIiGECnPMziTuGBgT7IrcxRUdN35FjVGIMteHh0GhiYabW3fqMzQfrddNw7rS51mMHMljXG+sxB9SHKnG15txIjU5ei4ze2u2hFZl7k49qz+l50l0sPbq47SydzZTjl/z74S8kSKoNtWjWeLqE0bv8e0pj8KWuhlAI104w8AST3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l7VIBMZ/0YfzOXw8iaoZOHTkV6pGNS+WtrcmLrctJ8=;
 b=cbUpeGImNxaI8KSVm+Y4rNA2zTDZ/SYdB0hnkVPQuvw5+vwCkdgZD0esaQz8rd5ocgKnlXVtnfLGHNOW3iFIR2pPoWfwnTi27MGTwRbx8goiB3wWROAPTxArI+QMRn19lp9Mhr3FTQ2xGVJs1eTioB8B5KED+j6K6DRuZDktawKUUNhqQJ/CFkqRFjQUdPDf0oXgWfvv5yrcDJowNyQ6JS9N0oD+a1+SccuxwjI518KXeSPxeADF8qEX/NMZTRt/tByUusANtB43OGmJiK/wJgk0Hk0+gh2WAShHFeykHlfVw0ujd5WlqzbULPXBlb/nyEsoaTkEoP6JrDmMN1LO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by MN2PR11MB4615.namprd11.prod.outlook.com (2603:10b6:208:263::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 23:51:51 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 23:51:51 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 1 Aug 2025 16:51:48 -0700
To: Nathan Chancellor <nathan@kernel.org>, <dan.j.williams@intel.com>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>, "David
 Lechner" <dlechner@baylibre.com>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio
 M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Ingo Molnar
	<mingo@kernel.org>, Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Shiju Jose <shiju.jose@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>
Message-ID: <688d5314c0e82_cff991007c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250801190203.GA939298@ax162>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
 <aIo18KZpmKuR4hVZ@black.igk.intel.com>
 <688d0c322cdd6_55f091000@dwillia2-xfh.jf.intel.com.notmuch>
 <20250801190203.GA939298@ax162>
Subject: Re: [PATCH v3 0/8] cleanup: Introduce ACQUIRE(), a guard() for
 conditional locks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::33) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|MN2PR11MB4615:EE_
X-MS-Office365-Filtering-Correlation-Id: 651bc439-5efb-40a3-37f5-08ddd15662aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2tWZi9GdmIzMzJjNHVPK2JVSDhTWS82eTl4OUNvUEhza1lLZm1Ealpvem13?=
 =?utf-8?B?Z3NJalVuS05BTUJEMGVobG8wUHlDTWRxR2J2L25OMzM3ZllyMjN1RVBLVzVq?=
 =?utf-8?B?M0ljeHpBd2cwOXNtOWt5aTBxQ0o4Um5vQ1JoOEtodmpsbHBiZWJkUFVuaFNN?=
 =?utf-8?B?bEszb0N4SkNzRnVReUM5N201NElWcitWcGc3Z3NrdlpkRFJ1SW9hR3VESU1P?=
 =?utf-8?B?VGNpV0QzVFBlUlIwWXc5K3FaSHE2eWZQZFdlOHhMRElJeWpwY0pZNDRFc0Zi?=
 =?utf-8?B?N0R6VnJuenVkYUZoNisyRFdxWS81aGtZWW5LL2w3akt3azRGTXlOYUJJT0RM?=
 =?utf-8?B?SCsvMDNPYk16Q0FZMTNucjBaamJNQ0d3ZDBCUzM2Y1FNbWp6Uk5iNGpXSFZw?=
 =?utf-8?B?WUVTaDBBMDBKWm4vZXU3TmcwdHJlRE1wN1E5ZzFtL1dDWThnS1FRcmEzMngy?=
 =?utf-8?B?cjUzYUZGdDdwT044eXlBUjY0R1FoSmY3aU92aUVZRU5SS21KUnh0U3lBNXVK?=
 =?utf-8?B?WDBjcmM0OS9qQk1MUU5rQ1dES01SU1gzREU5NnRPRGRUUDNCcStTLy8wajEz?=
 =?utf-8?B?RkQxQ01Oamw4eTF6Mnpwc1h2d1dNS0lFRkJ1UkhHaEhSOUVEb0duS0RSTlo4?=
 =?utf-8?B?UjJqc1ROM3I5MVRVZWd6WGsvRjRnNExlTGtzVnRBREJxVHU0RmdPdVJQK0FN?=
 =?utf-8?B?S2MwVEdqd0hTYm5oQ2JPVHRLYW4rdllXY1VwN2s4NHNjakUwTVlvcmQrN0hy?=
 =?utf-8?B?TFJlazhrRVlvczhWNUk2S29xcEQ5bVV2MHh1cUhvd1VoOHljS05FZnpjalJy?=
 =?utf-8?B?ay9yNlByYXAvV2dXNExoSHBBZktGR2tEL1hibCtlSGY5N1BxSE9zSmhuenR6?=
 =?utf-8?B?cFlnNkFjZkNwaVAvc2Q5Y3loMi9MbWpGSFVoYUpDN1BMWHdDZjdkNTcyN3dY?=
 =?utf-8?B?eHBUaTBBam9RRzdRYU1OZWVaRmNIcVZuRjA3K29YUGhpMjRPazJUOExHYjFu?=
 =?utf-8?B?UnprSm5aSkMxVTBzRGI4MVlhOHRQbktCVlNlQWtoTzZGWENXbUd2N0JXVWZZ?=
 =?utf-8?B?QW8vV0VkSUUxZ3JsZ2xwZGd4K0g1YmExR0tadWoxMys0VTliR00zalJTWE9N?=
 =?utf-8?B?ZWp0aElwbVAxMDRrM0FPZGxTVlF1SkJiZGpXRUhWbDEzbmdpVzg1NXVTbDZT?=
 =?utf-8?B?Vms2eEFXZ21rczBLZUQwUFNzQTh1RnZPQjg4SDMzSWpSNkJBWFN5WDdHWWc4?=
 =?utf-8?B?aGVLZ3RZYzlvenR4VEZOUnJxMkppdjA4Ry9xMmRSMU9uRTg2eHBvMkpFb3Yv?=
 =?utf-8?B?bFBKaElVeE9wVW1mV3BlQi9RVm83YW05QzIxVk5mVm14RHgzRHg4N3d3Snl6?=
 =?utf-8?B?R1hyT0ZYS1F6eWxLMHRZL1VoYnV4ZFQzTEd0NVA4QWFLUEFudE02TlZDeW10?=
 =?utf-8?B?SDB2MHlYckprQ3dwbVZ2aUlQRWYxWXJkNDZoZ0dpcGlhNWs5SHJlbjZEeUhr?=
 =?utf-8?B?WDVJTkRUY2VLZTdyVzJLaElGUmVxT3NwYk1rSVp0Uk1PL1JWZUxKYVRLUVNZ?=
 =?utf-8?B?aDJDL05POHhPZUdMeUc5d0RCcVNjUlg1aE9sQWdxaWVRRTc4bUkrRFdyTGly?=
 =?utf-8?B?NGgwQmpVSUM2R1M0LzBoalY2YTcweWVmcEordUpBMjh3cnRtWk1CbThORmM0?=
 =?utf-8?B?SlVYRzNTU2xIU3lDKzhFbG9ROEVKVFN6UVc3Nm1ZYVdsbmpSTjJDSExVNGJU?=
 =?utf-8?B?RmtIWlQxMCtuaE8xOWJHbHl5dTNoSG0zbjFRODRUbHk2SzFhakY3L2hVRElK?=
 =?utf-8?B?SHdISWNFL3JHVXJzZTUvaUxOYW5IbDY0Qm1FWVB4blB0cFNBbDRXYWJyZWl4?=
 =?utf-8?B?RzdVMFE0ejNkQ0pkMXFkN0RyTUlZNXk3cytlNXZNR3hDd05wUnpoUHV5SURL?=
 =?utf-8?Q?ZU9GDztA+8Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG5ZSFd0Y0c2ZjZvQS81eGc1L0tOTUtDNy8yVXFXSnhwMlVSUnJiVTNBWTRT?=
 =?utf-8?B?TjcxVUduNTBHY2ZNc0F1WFh3UU5IRlpEbWVUWTVpb0FwRDE1NFh3QUY5T3dU?=
 =?utf-8?B?cEtSVjJHbWZQbGRESzdvRExiUjlqc05jaGhGSEhZY3dMRjhGZEFWdWpYTGVQ?=
 =?utf-8?B?VFFjdFk3eVhCQ2RSR2E1a0p5RWhKdWcyL3ppZVFpa284U3hGbk9aMVpIWi9Q?=
 =?utf-8?B?azVoVHlhMTRvYk1nd1MwNU50T2RNVmxUbzZnZUFCWnN5Z0J0TFRsWlZRbEUy?=
 =?utf-8?B?T0orNDBGVUxtd09tZ3hjMk9rRXNtSitPeFBWSG9ack5aSlRWSmc4THR4dWdv?=
 =?utf-8?B?UncxZGVZWjhOeXgyMlpob29qWk16Skh2SUVhN0tia21WTUpjQVd3TkNCMWpq?=
 =?utf-8?B?U09JUm96SnpYWVRyZWE4SkUvTEp0Vzlpd1FUUkcyYjdHTEVxWitmUWxlWThI?=
 =?utf-8?B?ai9WeVVpN2prWmtlTE9VWjZ2MThqbWZ5K21hNHk2bThqRG1CQnpMTzFaSzRJ?=
 =?utf-8?B?ZDNpb29IdWJ0YitrbmUwbG1wVDZQNll5NnpkdnNkZSswaElkR2xXQ3AvSU1H?=
 =?utf-8?B?K0h0VVVZWk85ZDhzdzlBQTY4OUd1ekdNc3M2UzZ4UStzQXh1SmpYRVUrUkZs?=
 =?utf-8?B?Rnk5cTZEYk8xbHY1TlRZcUYwYnhPc3U4cnpENkwrOWJOR081RkZJVERWSXdD?=
 =?utf-8?B?TGVnUDc3bVhZZlVXcUt5c2N1Ynp1dllsOXpKYzBQeUpoNzJ2cXpUZk96OEJq?=
 =?utf-8?B?eWdjbkZKNDJ1MXljRWdNekhuYjNiWEhJWDEvak5pbUZIWmR0clRnZTlRK2xJ?=
 =?utf-8?B?eWo0Y3Nwc3poRE9KdncxSEhYekFrSnhaUkFMdjNpeWRQUkFIQXZiMDdaM0Vk?=
 =?utf-8?B?RHg2QzlXMG55N28xNytaMTV4VEo1MVYwOS95TFNoZEtvN3JrdTdlM2tJUlhK?=
 =?utf-8?B?OWdsalRNc2k3Q0JpMVlWOE9BbXd2dmhNWFZ3YzNzdktRTnYvdFdWbGgzemFS?=
 =?utf-8?B?eFFkbys1Vmh2RzFYeFdRVXVBQ2NudTNiaGZKQjBjVGwrZzBiR0xVU2RLcXRy?=
 =?utf-8?B?WStnWkJMajg1T2pCMzg0M3U5WWdPNEVXQlR3YlVxMmw2cnhMbWFOZUsxN0dn?=
 =?utf-8?B?SFJUZ201RWhEZWtWWlljRkhsMDVkMjZYTG5qMWpsREczN3hORXVYRlFWL1Zo?=
 =?utf-8?B?VkM5NE80WW5ZMUZWRE9IUEM2MUM1Ulc1MUJqMkt4bjZ4V1BhcjFhakIwK25t?=
 =?utf-8?B?RlA0VWdkY1h2SFNqSFdBMVJPRUV5Wi9VNDRlWGJzeWMvcC9SMUVJV3QwT2tJ?=
 =?utf-8?B?ZzBzSU52VTBHKytTRDU4QXFaTWJSdFVXZGRVSVNadS8wRnRqUFJ3SzlndGU0?=
 =?utf-8?B?SzFwaU9NT2FLb3hsYlNvZ2JEaDcyc0xFNjllb0taNGx3aEtNU2t4VnBKOEEw?=
 =?utf-8?B?Rm45T08yM042Q0RRVCswdVd0T0didXJ5SEttcEtuZHR5Z3BuWlRISmdxZmRY?=
 =?utf-8?B?N2V2L0VNbmpocXoyNmNrRVQzNFd6ODcxbjJYQnpWdTBGMWdiZHB6TEFZa1cv?=
 =?utf-8?B?RkNKYzFDWER4UzN2VVlSNUFkSUx5MStMT0R2c05BNk15WGdtUTJZRUxTS2ti?=
 =?utf-8?B?YTVoMDZSMUdnVHJ2eCtBczhCWHN6MWR2STlqaHFJRXY2SkdRamNJUmVveWo0?=
 =?utf-8?B?WWtMS3ZoSlo3MFg4eVJEMG5QS0R1UkJQamg1ZVkwMWFzdUdSdTRoRjBPNWRE?=
 =?utf-8?B?V2V4ZUJqZ2h0TGpXMTBVcmhacVpKOUEwU3gvd0o2aU54eHp1WjlWQUtNdG42?=
 =?utf-8?B?cnNBNGorOWVHR3BFZWYyVVZnMTAxNmx2WmdEWXc5WnlQNjUvYzJMcHFTQWlt?=
 =?utf-8?B?dHc0Qk01cStFT1ZuRldGRlZPdEFYU05PN0NxcjVhdmxWUXd6UGRudG1xdWtT?=
 =?utf-8?B?Z05qTHU5aU5iOVowVWxrdDJaSVJOdzdDZ3ByVWhRZWw4cFlnYUR3OEhSOUQ5?=
 =?utf-8?B?Q2VtblNYejZhMUpHbnQ3VWlGVTgxNjRjV2ZraloxdWhNQkZSMWM2VU9laita?=
 =?utf-8?B?SVJWakkxTU1NbEtxaG42d054cklGOTVGcDB2SGM1dzlTNGtCUWJtNGlUK29U?=
 =?utf-8?B?enpBUSs2NWxXRzlWS1VOV0pVWVNpWEk3UTdabG9qVllnTGYwa04vUEhDSjhH?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 651bc439-5efb-40a3-37f5-08ddd15662aa
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 23:51:51.1308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqI2Bn6+o9bTT6kXR6IhKxcu+5kOjdp4kN4k1xT9JYsqsl5F+4BZEq/hY97NX3xV/6l7AEfb/XZVqNkayaqQvMLx89aXnDCgG66ZOIj7Jh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4615
X-OriginatorOrg: intel.com

Nathan Chancellor wrote:
> On Fri, Aug 01, 2025 at 11:49:22AM -0700, dan.j.williams@intel.com wrote:
> > Andy Shevchenko wrote:
> > > This series broke `make W=1` build vor clang. +Cc Nathan.
> > > 
> > > Par exemple:
> > > 
> > > /kernel/time/posix-timers.c:89:1: error: unused function 'class_lock_timer_lock_err' [-Werror,-Wunused-function]
> > >    89 | DEFINE_CLASS_IS_COND_GUARD(lock_timer);
> > >       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > /include/linux/cleanup.h:376:2: note: expanded from macro 'DEFINE_CLASS_IS_COND_GUARD'
> > >   376 |         __DEFINE_GUARD_LOCK_PTR(_name, _T)
> > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > /include/linux/cleanup.h:358:20: note: expanded from macro '__DEFINE_GUARD_LOCK_PTR'
> > >   358 |         static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
> > >       |                           ^~~~~~~~~~~~~~~~~~~~~~~~
> > > <scratch space>:24:1: note: expanded from here
> > >    24 | class_lock_timer_lock_err
> > >       | ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > 1 error generated.
> > 
> > A few observations:
> > 
> > - This is odd, the inline should have been compiled away if not used.
> > - __always_inline does not help
> > - Seems to go away with __maybe_unused, but that seems more like a
> >   compiler band-aid than a fix
> 
> See commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build") for more information on the difference
> between GCC and Clang when it comes to how 'static inline' functions
> behave with -Wunused-function, namely that Clang will warn for functions
> defined in .c files (but not .h files), whereas GCC will not warn for
> either.

Ah, thanks!

> > - This locking pattern is not immediately amenable to the ACQUIRE_ERR()
> >   approach because the unlock object is the return code from the
> >   constructor.
> > 
> > Given all that, and that an ACQUIRE_ERR() would end up being messier
> > than the scoped_timer_get_or_fail() approach, I think the best fix is to
> > quiet the warning, but maybe Peter and Nathan have other ideas?
> 
> Yes, this is what I would recommend, as we never care if this function
> is unused, right?

Hmm, it would be nice to care. For example, if someone did something
like use ACQUIRE() without a corresponding ACQUIRE_ERR(). It would be
nice to catch that, but that warning would only fire for clang builds
where the lock guard is defined in a C file.

> You could probably outright substitute '__maybe_unused' for 'inline'
> in this case, since the compiler is already free to ignore it and the
> attribute takes care of any potential unused warnings, which I think
> 'inline' is primarily used for nowadays.

Oh, true, good point.

Another option is make scoped_cond_guard() use the lock error helper.
The compiler should always elide that __guard_err() call, and in the
meantime maybe catch a true positive unused symbol for
class_##_name##_lock_err.

-- 8< --
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 4eb83dd71cfe..534723b14d92 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -421,13 +421,14 @@ _label:									\
 #define scoped_guard(_name, args...)	\
 	__scoped_guard(_name, __UNIQUE_ID(label), args)
 
-#define __scoped_cond_guard(_name, _fail, _label, args...)		\
-	for (CLASS(_name, scope)(args); true; ({ goto _label; }))	\
-		if (!__guard_ptr(_name)(&scope)) {			\
-			BUILD_BUG_ON(!__is_cond_ptr(_name));		\
-			_fail;						\
-_label:									\
-			break;						\
+#define __scoped_cond_guard(_name, _fail, _label, args...)        \
+	for (CLASS(_name, scope)(args); true; ({ goto _label; })) \
+		if (!__guard_ptr(_name)(&scope) ||                \
+		    __guard_err(_name)(&scope)) {                 \
+			BUILD_BUG_ON(!__is_cond_ptr(_name));      \
+			_fail;                                    \
+_label:                                                           \
+			break;                                    \
 		} else
 
 #define scoped_cond_guard(_name, _fail, args...)	\
