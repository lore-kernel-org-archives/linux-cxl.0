Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F34C9F
	for <linux-cxl@vger.kernel.org>; Mon, 12 Aug 2024 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445398; cv=fail; b=C4Y3FYdzMeVCtq1pWH24Ew3VcczPS4NZq0bVrmEH+yfVuT8YmGLTrCn9LKQ96kRpXCyEj2iTAn/A5/b4OCNIOJFUbI2QtFMlyv+0lF+yEFh+uM2MAfEEniyDpkt4L/v0j4DoeqG7HSYiTPsTTdayGtMNys0A7eCDmJbDPJMfrxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445398; c=relaxed/simple;
	bh=UhJf6CzE7HqmK9ZePDVqG/Pz/yReTp2TCsyuPtq8Ik8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oWzcZxP7ZMQoPL/DD+bs+7DWjWylam4eOt3m/FVzdGlUJpHP3OTbyxRp3+AHZRhfM2Yo5zO0DHj4FLshov3lfG2coEbANYrSpm+8y/A7hrQAFLMQIMRwQKAToIXOAIwqB4GkYq1ssVRR21Cdear76fMf1e4nr57NnPTTNwQrsqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaTRPJy2; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaTRPJy2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723445397; x=1754981397;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=UhJf6CzE7HqmK9ZePDVqG/Pz/yReTp2TCsyuPtq8Ik8=;
  b=kaTRPJy2D/0hl15Z8Dg45OWJ0LgpLTXY8ksP6FLbVPzEzep3Jbd8XeRS
   OQQi/iTCovWMb0ibV6H0di2YyRwjWwgLpIRJ2x+z911MUPzYVwk/9oTuS
   O9/sbJg0twCfw5li9hYd8Zz5p+DADUCo8FZIcrDBGotDbt3ciiRo9MbB7
   kIGODZi/gKrv6bKRwcQ/yHT92U7WlUDJwpvQWkzQBR6pYkmqPI+isGt8n
   Vrqebwi4EHp6VnBjYsMqLYYdjErUT006kUPZ/aJg3rjGFfh88xARKotFJ
   mDWsl1tsTXWobkiSVR2C1QbX73cqo1FH1nh+7FVScXtrQtu2MlOKeibk0
   A==;
X-CSE-ConnectionGUID: Yvgux6aJQ3Oz9XBOAV3psg==
X-CSE-MsgGUID: X0heFMsRSta4mg0k+ijE3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21708001"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21708001"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 23:49:44 -0700
X-CSE-ConnectionGUID: HkKVEp1hQOC2lEdh6vFrcw==
X-CSE-MsgGUID: pCELjOegTSq+BHh0Ggxaew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="63015693"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Aug 2024 23:49:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 11 Aug 2024 23:49:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 11 Aug 2024 23:49:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 Aug 2024 23:49:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ae+Q+GKLsakV32J9zhxJMrrcxEcY1gpcx3JESBers/fcSwZs530rLa4cINcEMRXT8sqHV5rx4THP3/24wtvEbr0TFDq6r2i4mLRAvVwRQ/BZy5p5xhmu8KL9oTSH3Yp4VXpuj0es6V4+oNH5mfcwnJGSUt9fTe8hu/H2g12UpXnXWEcykM4+mkyQpMbuD7K8ewo2+P/rhjNMs6MyvRKYD/f793o6Rf8ilQWV9RPV4dMVYmkNY/5yJ3hFu9SHnGiZnDdWmvHFJLQM7VeHUFFl1ttrbcrezJFfhjAGf4cS0H5XzQcAHUFyqozufp+XRetDn0YsQVAOIm5Ng91xwpbHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuExEi56qF0Bx7O/sJlL8MUeLYcGjOmNz5vJTPenPU4=;
 b=uioWe143NTfpW++GnjQ8+UdWHSpqOTufgBOhvRWy9ZYb/WquYxgmj10OumA3bfjYSMnQGdAt3amXJidM9E2a0jawAPdzy5WY/07QfPEkUqwfPhbFaf3iikoXFUmLnpD09Zleg07VJtbrT2V6mt/4LXN9HuaOAB4Pmj6PgM7IX/bhmyXnBFg6TsUI7ILAlj8dpqVjBSa0sPlcWYqSuTtVv4ZOZ7ufYxlbUtoMjoUPXikdJQmUa3yYQ2k5VUQq9L1Wdc60CHEKVRPleDZ2D3rxZE4LQcaMd9mr3NtonWbHxzIS1PKk0ZyuFkU3dOHjGe9D8+SuY1OeI70HrSPM0gD4Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by CH3PR11MB7676.namprd11.prod.outlook.com (2603:10b6:610:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Mon, 12 Aug
 2024 06:49:25 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7828.031; Mon, 12 Aug 2024
 06:49:24 +0000
Message-ID: <5df90d43-fd1a-49b1-a1cf-1838499c26de@intel.com>
Date: Mon, 12 Aug 2024 14:49:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix get a wrong pci host bridge in
 cxl_setup_parent_dport()
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<rrichter@amd.com>, <terry.bowman@amd.com>, <alison.schofield@intel.com>,
	<pengfei.xu@intel.com>
References: <20240809082750.3015641-1-ming4.li@intel.com>
 <66b68bce7fb41_2575294e4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <66b68bce7fb41_2575294e4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0138.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::18) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|CH3PR11MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: e151aba8-8b81-4845-67f1-08dcba9ae6a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXFEeEd2b2NmVWJYM2JEVUFmUVVkdklpTVNNSDJ3THRwWkNSSG9YMlJtYkYw?=
 =?utf-8?B?U3B3bmw5SDNrSDNtcGx2RzVvMUR3c3crVUJuWWJSNzVIM2d3VFlaVVdkNEdO?=
 =?utf-8?B?bkp5UDBZaWV5YnJJc0FrNnYwbXZydzVFbEViakUybnpsc3dVS21OTWpqY3hm?=
 =?utf-8?B?Q3BoUXRlNm53Mnl0dEpjVVNyR3VocGF4VVFZM2YyRHByYXFNcXZwZkQ3REw5?=
 =?utf-8?B?RG1jMEUvNkJNRWNWRjRVVGpXU1JRd21ZREZWOUNNY2J1c29VTE1UN1JBMnE3?=
 =?utf-8?B?SzlNSkFmQWl6S3duOHIwUC9MQjllOUtLeWhrUnFQMTRiV2Q4NFloQmJoeGtn?=
 =?utf-8?B?RktoT0V2ZHNhWS9oMGxnOXlBaks2UEJqQ2ZNNEo3Vlc2c21TbFVHOUFlMWJs?=
 =?utf-8?B?T3FSaHZyYlZQcWNkNDM4akEzdm5JeGxER2k4M2c3aGxiYkMrS2ZOWUVHTmdH?=
 =?utf-8?B?RExtVm9MSm1VVE5MeUo2SFVvMWNGWXBuZ25EZ0hFUi9zOEF6blE5aHRiWXp4?=
 =?utf-8?B?MHdlY0Y1UHIzVll3ekhGekxsQUVEdVkzWU4yek5UNGlucUgreW5jdVJ3SEE1?=
 =?utf-8?B?ck5JelZjd0VhV2liS28wK0hkTVVCN3FaWS9IKzA4bmVCejhINUsyL2h2Q0xm?=
 =?utf-8?B?a1dhT1Jsd1NIZzNFLyt1WndsRHNJOTcxbWpMbUVlcnphaEhLOWdRblBkNm5x?=
 =?utf-8?B?ZE9Vanp4Y01yYW5CWmpoZzlldnpxZTNUeUk4bkFhY0swOFRobUtRN3FGa0lw?=
 =?utf-8?B?SmFvcU9uQkN1MktsazVncHRJa1JzeE1zTlFJZDdCZXllS1N0OUZQYk16SEp5?=
 =?utf-8?B?Wi81ZFZ4RDM3OUFaeUVnNk51UHpXeTg2TWNvS2hqeFF0TWdOT2VrY24vQUV2?=
 =?utf-8?B?bEovcnV4VitucGlXSlhuNldHakFpRkZsYm9iZWZFWjB6b0k3MTNlRGlqRnls?=
 =?utf-8?B?QkpOOVBwVDVya0FaRnF3T2ttN0MwRzNQTVpna1k3QTFBWW9NTFlnWDFEZmhz?=
 =?utf-8?B?ZUJNVFJ6RmU2ZVNlQ2kwRTR5VDVLeGxIYjZacGg3S2U1OCtZbklyR3RJTDQ5?=
 =?utf-8?B?aHl4ZGhFQnc3Z00wNHZEVE5BV2ZVbUNIWDFOeTdIdE1sWFdTVm5oK1ZOR2JY?=
 =?utf-8?B?QlhwcmpmQmFRYUhJZmRwQlFuOXhYMkkzdE9xRFIvcjVMT2ZBN1pMcVJzNTNK?=
 =?utf-8?B?Vlh2RFFMS3ZaRlJ6eDk4TnM5ejlsaWU2aldPUFhPM2NCaUJqNWVMUlJXb2FE?=
 =?utf-8?B?ZkZJTFVXbk5SajM3U0VOZFJPTlBReVRTcnpCTHB6T2lQbjNPL3NCcUY3dUlr?=
 =?utf-8?B?K1BMR3VlVFNQRTFTeWNFdWVSaUV2aVZZdVhWV0RWSFRWdnQ5VFhpNEJoM094?=
 =?utf-8?B?RE1DS0pQYkh1WU85VXZsenEyS2NWZmpXdmR0bmlibXBuQ0x2SUJLYUgvWjdM?=
 =?utf-8?B?NTR3dHFuZG11MHFqL1pJZ2xKd1JhRzVCQmQ3NFdLdVlKK3lVR01RaDFNVWgy?=
 =?utf-8?B?dmVYbTJSUCtac0NiNGMwNnlVV1NESkplVVlZTWFoeWUvaWRWL3hwUjQ3dm5o?=
 =?utf-8?B?T1dYUXNmU2Zpc2hLQW1DT1dvT0RkelA4citJK21oczc5UDFkQTdiS1dRQ0R6?=
 =?utf-8?B?b25MazBvWjYyN0tpQmxtV0sxTlR6dmlvN2wwTngvVW4xM0dMZklUcjNEMmUx?=
 =?utf-8?B?UVd3citNUzhFTWNiQ2NseGZjS0JOcTBVVTErSkdXUTBlaVd5eVhzamZ5elEx?=
 =?utf-8?Q?U0ExJ2eSOcr4wBfFko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3U5dmZia0Y1dU1hcjYvQmxnQjZIQlhob092dTc0Yi9GUlJISGxtcVR2WTkw?=
 =?utf-8?B?Vis2NWNTaXVNRmVjVUZxazNLNHFCUFh2RTVXWG4vSEVjVEdOdzJ0NzdNekh1?=
 =?utf-8?B?ZXNjQUY5NDlkWXhaTlVXbXduZkZldTgzYndGbFJmeWNSbmpwVC9vY1p4WDVE?=
 =?utf-8?B?S2YvZ3RnbGVyQkJWelQyd0E5dTZxejFCdWdjbzVPbVNGS2RUZEhJRlVMYW1P?=
 =?utf-8?B?VkhRdHUxSEV0SGFITU1KUktmRmpGMGNDQmpSQTlEdi9qU1dCeldabHl4OVQ3?=
 =?utf-8?B?M3FmT05mczVwVWZINW1Oa3oyVXNWa2FXZGxpNDdnc1hkMmswcjJGNXRpbG5E?=
 =?utf-8?B?ZXZmRUZaYWdFd3FHUk16TXdBZmZpckZHeldKenJpR2VTYUhvY1I4alAydGdh?=
 =?utf-8?B?Qk5HZHF0RVhWMVFPTEx1Tjl6SlBBOU40LzBhTThES3FIcHdCMjduM1k3NkJD?=
 =?utf-8?B?U1pzUHBkWEdiQzMvTktWQjFLT1h6RTJDMklJcVlGWW56bTZiWlN5WTZoU0Q1?=
 =?utf-8?B?RDFFRmRxbE5LdXBEbEZkdGZ2REFLb2EzYmlHVHlFM2ZZMDlnQzJYNU0yUHJz?=
 =?utf-8?B?aC9EeUxVTkFkclAvYkFVU2tNSldiOGwweVJJOW52ck5MWC9qb0xYUkQwWTFi?=
 =?utf-8?B?SFozcHRQekNjNEU3ZVp2aHNvZDBXNjVPRDM5a3BWUXlZQTB4S2lHUnBBajdU?=
 =?utf-8?B?SUkwM0hDRCtzNnYvbi9RUDE4RkNXS0w3MmRrb1NQTjZjTWVzNThNT0kxZk5v?=
 =?utf-8?B?eWhHNVVFamR4ZkFBTUEyQ0grNVFXRmpXckVlUkswYkRaRGs0ZWYyV1FxOXNi?=
 =?utf-8?B?NWUwZmxIVStJVGRGVEk4MVFnZHhUOS90RzV6U2M4Rk54VHhJQUQ1c3RPOXFR?=
 =?utf-8?B?S0FCV3kzSmRVemo2NkwzRkdLUmFiWnd6OGxtSjlXSGtkWDJiU0RiVGUvYlJ0?=
 =?utf-8?B?ZzFSQXJuR0xlTE5tVGRFbTQ0QmZhUk1lQWFrZ0hzdy9lVkExSkJ6bkNkcEtU?=
 =?utf-8?B?SS9sNXJFbnUwSUoyS21aeVlRRGRGU21PbkdtcnhweWJVRHRwV1p5MjJsayt0?=
 =?utf-8?B?N0lEY3R1SDNBaXRoYWxGLzZiK0ZQNll6Y3A4RUxOQ05lRk83NzF4YkJicWNo?=
 =?utf-8?B?NDF6RE5pN1A1T1lQM3NUTVhJejVSQnBmOTNzL1pQRENYTExtdDZIYVc2MFNz?=
 =?utf-8?B?QjhJMzlYYjlkMFJScVJpdDAxTi9YQklKWW05RXNVSkJ6Uk5GUXdNWTN1eEtT?=
 =?utf-8?B?MC90L0orMEVKbi95RlU3UExDS09VYjdpRDAvSENvZGlkOVBEK0tseUtjaEc5?=
 =?utf-8?B?OG4zMWJMMU5oV0Z4R3Z2Sm9GUVhLUVJIVDlGVURqRFF3Q25yaXhDNUZRTHMy?=
 =?utf-8?B?WW4zcGZzZFlaV2MxdjJ3S2svbVlOamJIOHRCNjEyZTUzcFlqVjAvUWI5MWtU?=
 =?utf-8?B?NThKUnQ2YlJRY3ZVdzVQU1puU21SbHlpSXFiTXN2MWtZbWx2L2krZEU2MU9h?=
 =?utf-8?B?K0dZMmhQOGVxNmJ5ZHFvd3pvWTdrT0pnaXFUVW9CVTVJcCsvZGJhMEF4VmdJ?=
 =?utf-8?B?TEdGTVloZnUvSDdrMGZ3ZEFGdXdlbnliS0NudlNzWDJLRjFaWmtpazFTUk4z?=
 =?utf-8?B?UjFSOTA4ckIxTVhjU1dRNFpUaW1MU09OZ1JidzNIbFdwRlYvQnZBTXNPa2Q4?=
 =?utf-8?B?b2pOS3pYYVQ2Y2tGV3p6MEp5QndJT3JReTdubWpWR2YweFowbnlaak9qR0Nv?=
 =?utf-8?B?anNtTzNUaVFMMWpGRjdySlA1MCtCQWRjTnFnSTFCL0dlWGlWcGJhQ2c0ZHpx?=
 =?utf-8?B?MWphMExTeFl2NzZ6T09wWUtCT0VqclZ1NVJNcy8xNFlwVk1MRjVSUG1hQjl1?=
 =?utf-8?B?YVc4VTdKRldQblZhUlViTUZCYnpkcnR3R2F2RXYxV0M3clRRcUhQSGZUeFpD?=
 =?utf-8?B?K20vazJ6eDNHalBOWllUeEVqVmJxVWpZL0x2M2JnUWIyN3VCcjQxYk1TeFMv?=
 =?utf-8?B?STIyL1VTKytDc25TRUhlWXJ1aDdqcm01N2ZwL083ZHJYMlNPMWUrS2lHRUVv?=
 =?utf-8?B?NjhqYlVuUng4N1ZldEpoeFppenh0ZXMzUzVub1dLSWVta1ZQcWFHMTVraGYr?=
 =?utf-8?Q?+lTonMccDvnsFoEHc6U2CTpIm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e151aba8-8b81-4845-67f1-08dcba9ae6a2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 06:49:24.0421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfsq7kHGiEuoXtFZ2G3MAf6FZi5gqWJUwmU3sxqJ3bjRIPayZnrWnfDD4WO/bNKyS04EltFyD0WzvvElgBjBwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7676
X-OriginatorOrg: intel.com

On 8/10/2024 5:36 AM, Dan Williams wrote:
> Li Ming wrote:
>> The cxl_test unit test environment on qemu always hit below call trace
>> with KASAN enabled:
>>
>>  BUG: KASAN: slab-out-of-bounds in cxl_setup_parent_dport+0x480/0x530 [cxl_core]
>>  Read of size 1 at addr ff110000676014f8 by task (udev-worker)/676[   24.424403] CPU: 2 PID: 676 Comm: (udev-worker) Tainted: G           O     N 6.10.0-qemucxl #1
>>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-2.el9 02/14/2024
>>  Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0xea/0x150
>>   print_report+0xce/0x610
>>   ? kasan_complete_mode_report_info+0x40/0x200
>>   kasan_report+0xcc/0x110
>>   __asan_report_load1_noabort+0x18/0x20
>>   cxl_setup_parent_dport+0x480/0x530 [cxl_core]
>>   cxl_mem_probe+0x49b/0xaa0 [cxl_mem]
>>
>> The root cause is that a wrong host bridge was gotten from
>> dport->dport_dev in cxl_setup_parent_dport(). In
>> cxl_setup_parent_dport(), it always calls
>> to_pci_host_bridge(dport->dport_dev) to get a pci_host_bridge structure.
>> There are two issues in the implementation:
>>
>> * to_pci_host_bridge(dport->dport_dev) should be used only for RCH
>>   cases, dport->dport_dev points to a pci device rather than a pci host
>>   bridge in VH cases. The solution is checking if dport is in RCH mode
>>   then calling to_pci_host_bridge().
>>   (Patch 1)
>>
>> * In cxl_test unit test environment, cxl_test will create a emulated CXL
>>   topology with emulated dports, the dport_dev of a emulated dport
>>   points to a platform device. to_pci_host_bridge(dport->dport_dev) also
>>   gets a wrong pci host bridge in the case. The solution is implementing
>>   a new wrap function called __wrap_cxl_setup_parent_dport() on cxl_test
>>   side, the function will filter all emulated dports, make sure only
>>   real dports can be handled by cxl_setup_parent_dport().
>>   (Patch 2)
>>
>> v1 link: https://lore.kernel.org/linux-cxl/ZrHR+0w3bwM1Ik8h@xpf.sh.intel.com/T/#med6200e54ec12f09fdcc04571516adda261c9561
>>
>> v2:
>> - Add call trace log into changelog
>> - Remove 'dev_is_platform(dport->dport_dev)' checking out of cxl driver
>>   scope. Check if dport is emulated in cxl_test.
> I am suprised we got this far without this being a problem earlier.
>
> For the series you can add:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>
> ...can you also follow along with a rename, documentation, and cleanup
> patch?  cxl_setup_parent_dport() tells the reader absolutely nothing
> about what the function does, and that it is specifically initializing
> PCI AER operation.
>
> It should be called something like cxl_dport_init_aer(), and it should
> have kernel-doc associated with it. The cleanup opportunity I see is to
> consolidate the ->native_aer check for the cxl_rcrb_to_aer() and
> cxl_disable_rch_root_ints() into one location. It is a bit silly that
> cxl_disable_rch_root_ints() needs to check if dport->regs.dport_aer was
> initialized when it was just setup a few lines above. I.e. there are
> just too many helper functions and it all could be consolidated in a
> bigger cxl_dport_init_aer() function.

Sure, I will do that, thanks for review.


>
>> Li Ming (2):
>>   cxl/pci: Get AER capability address from RCRB only for RCH dport
>>   cxl/test: Skip cxl_setup_parent_dport() for emulated dports
> This is the right thing to do whenever possible. The usage of
> dev_is_platform() only makes sense for scenarios where a function is
> called by the cxl_core that needs to avoid getting confused by cxl_test.
>
> In this case, since cxl_mem is making the call to the exported
> cxl_setup_parent_dport() symbol, then mocking it for cxl_test is
> appropriate.


