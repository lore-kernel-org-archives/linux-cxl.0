Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA5E1DA32
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813670; cv=fail; b=MwSjlxv9633t/hlQsWKrUqjqoJNlmp1ENQBRiRlxCslLGrbRJ7lMd10NTCaSdCL9JUnBBaK2wUSAjaBVqKYiNi6I+4bsV8sQ/VM9SbgbUOU8gLNOfFGdcoC72NEQ+J6epPXR80XYRBtkZObZWWfNEJtnONBe6+hTe3gW0kDGTZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813670; c=relaxed/simple;
	bh=1qx+QcE05l7e8hHBV7airHVlVHrs6UaWxuVO6vWpjw8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=klNi7eqwnS6O6gShesAfQFJFcPnYCOjC/puwEA49OmIlJnazP94KKIje3WLPagSc/2kPgIb3b4bm8ExQTDiTfAZVEemb3XG8SvgmSWRGlXJCubP07Bh06NPLCR6Bp6LEocdf9TbTo3XclKufgMfSv0dnhXjxSc8mhsyp6uj+tuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFEgLuXT; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFEgLuXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724813669; x=1756349669;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1qx+QcE05l7e8hHBV7airHVlVHrs6UaWxuVO6vWpjw8=;
  b=bFEgLuXTocaqD710AQgHdcsxTI9lW6av5CfnLoicJ26r8wg1oUftRtCk
   jQKDFPHwyxYuW+vHr/UR5UoSGG8X8ew4RJDWQYBOpE8LecTjd9xTwgp80
   vKQrx8RhxNkUgPrAx2p2tIODLH8kTQbSWBWY9fCTEm3xgBDJPeNJgJIEK
   BoLuZ453636YsB4Mhhyip/p3XiVs6kTSl84tls9UsZMnX0imNC/VF6T2h
   6qKDgyx30oR7HmE+lUqJLyeIr1imncWfIvDqvpvOtyLdh0GOY65HaaOHE
   cji4s4aoaIVjNjAYwF1llu27oaa6O4V5f6Tm5dXNvKGvjq9LZvBKIBj/x
   A==;
X-CSE-ConnectionGUID: F7bcPTU5RyyFVuxUVeyIQg==
X-CSE-MsgGUID: Dxxc3XF4RpesPxSj+yOCog==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23198236"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="23198236"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 19:54:29 -0700
X-CSE-ConnectionGUID: hw9vv1wKTvqBhhkxb/5fpA==
X-CSE-MsgGUID: 6CfhDbhnSu+KpNJWJyQn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63420500"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 19:54:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 19:54:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 19:54:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 19:54:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 19:54:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaNNUErgZdIBjhptnGs1HhEzA9L5w3cabdSJfheNbwA7bug61o0MmBMQdL2LJITeOcZENJ8Cs+KzW3XKuX8hFLZ37MAsoDvyM4c7/EO08bp+Fczqg/FP1Brj5pgz6gkXgkZLc2cxt2MGvpv5tt/VNvS3QubnB1+SIsJxshroff4NGmpTeH4YPOYH4OrLCcGvb9fsWfyfwTGEN8lhtnVhyMEQqlcWZzhrSvBCxL6LKvm43ZLfEddzAyArgQ5f3dMteglXyPPnPLwlT++SeZVYbh4HisPGb2C/hhvGITJcbN7WpYN416rozq8jf0IIovAIcXJS848daqEP2HNxVWRnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkoNFqy695wFKjmxD3/pa8iExC7D0yM+ENe/nI5ueTA=;
 b=JiTYfZBx2nFoE2UPoOEcMYfjkiyARzCk2Z+h/DHVW/7jakyabdGjCMfhO+sW032Slzi9xgn8oW5STtxpyVPG89WuWFeYLM+nVCm27zEnAleXDtDZDF4xBl4umDpSMSs05ZSuXwm7LIvkVU0+9ybMeG+5XFFWF2DtX6E4vBuQYE3txlPKCTPo/PG0IZe5TrfrcqNwWC6N3OxCdNOEn83AQQA1X6YNFO3Fa6I3NDRZZppkd0IBI7hcwbSHRV+mGHWXltLJ6s4Jl8vazUuDE8YY4QC+Qdle3agaaLvEehYZmEgyF4I3z1enqtaS2vOOO04yUiIwHFt0maH5PIBA/dw8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
 by SA1PR11MB5921.namprd11.prod.outlook.com (2603:10b6:806:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 02:54:20 +0000
Received: from SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67]) by SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 02:54:20 +0000
Message-ID: <42548dc4-5b88-4d68-a46e-540027fe015b@intel.com>
Date: Wed, 28 Aug 2024 10:54:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 3/4] cxl/pci: Check Mem_info_valid bit for each applicable
 DVSEC
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <ming4.li@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
 <20240813110532.870869-4-yanfei.xu@intel.com>
 <20240827172228.00001207@Huawei.com>
Content-Language: en-US
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <20240827172228.00001207@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB7110:EE_|SA1PR11MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4b8f91-094b-4a68-5f7b-08dcc70cb6a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0RLTjdJTzNJMUJzUU8wNmIrZ1Q0TGxGZXpUWmlKbEF3eGJvNytxaTZkMXF3?=
 =?utf-8?B?NTVkeUw2RE5GTStCcnc0YVo1aUlLa1RKQ25jcUJUYzR0OEpBMFEvNzJJenRV?=
 =?utf-8?B?NDBiSnA5bmhuTWRXZGs0dDJnc2REOFJPZGEwV3ZFSjB0SUVSUzdQWTBxcWln?=
 =?utf-8?B?OVNlSFV0c1ZIVG9HV0JwemVKZTI1WThmRDJJdnMxUUE5eTVWMnBBbW1CS0Jk?=
 =?utf-8?B?N2NZYitDalRuSGFQSGZNUGdWbVAwQTVFWXJaVzk3Q0pYY05LL3BBUEpvLzFv?=
 =?utf-8?B?ZTVMUjBqY1ZZeGF5WHQvZ0dyNDl2MVhFdEFpRWhmb0JZeE1KVWVQdWR4MWVK?=
 =?utf-8?B?NjMrMFZob3dVWThkMWlxcmRjZVZwWE9UcEE2dGFRK2VSazh1T2kvTk9LUnNV?=
 =?utf-8?B?NU1DbHQzWStvN29leWpHMXYyNVdQZXVhRnBKbk5FM3NFeDB4K0Z2S090UGd6?=
 =?utf-8?B?M2xEanRud091SjVxRXNpUU84OGpKVkpKN2hSdVYvYUc3NGpmT0k1WXYvR3A0?=
 =?utf-8?B?YW9odTY2c0Vyck9OTWhraDAvejJGVyt3QnczQWE5eGIyUDhKY3l3b2FmZGxv?=
 =?utf-8?B?dGJ2WG9pT3BKL2pTNnpoTWhoZVk0K3oxMlI0QisyVjE0cWorb1BQTUVEZzRJ?=
 =?utf-8?B?a3ZDK0JvejFXbkhFWUt5Rm5OcVFPRzNsOUtOM1UzalBmN3l6YkdYdDRaaEs3?=
 =?utf-8?B?NnZXVFBDd1hWbTFqSllNTjhHQlI2VDdQYXQwb2FybE1IQkxsT1NWWXFzZEhm?=
 =?utf-8?B?V3JCNTJtTmJlWENPRlRyRzRERDMxc1gxOVJEaVl2cjdDYjBab2hsQTFya0Ji?=
 =?utf-8?B?ejd5RmgxUFQvek1GaEl4YUlZUm9QdnY5S29iTDl6clZoTmt4NGI1a0dCcE14?=
 =?utf-8?B?b2FtRFFvOSt3NFZhL2F2Q1dPT0Q0ek9YMklwcVdjRUVmczAwZkZYaXBoZkF5?=
 =?utf-8?B?UVBQNmtNaXc1eDBNSnl4Uk5NcHJnck5IYU5IUktlUXJvN0J4MnB3OThOckg0?=
 =?utf-8?B?ZE5yc2tpSXIxRlJBUVdLL2xrV3pIVFgxeEE0eUpnZGRTeFhENHlydU1lcGRi?=
 =?utf-8?B?M0pnMVNkaVpiK0hJZGdxMnhPTkxiTkZUUVdHWUI1NFA3YUc1emF3SGF2aDZT?=
 =?utf-8?B?bmZMK1o0djUrNEc3cmtkMHkrbFM0Sy9FUkNKSEVmNjZQQ3A3bnphQ3NkMXFE?=
 =?utf-8?B?SFdkeFN1bzNTR3JlZElnUnIxYTVxVzlGeE9hKzVuYStqOFBMemJncUFZcDJt?=
 =?utf-8?B?WFJETGZGb2dwZUl5SXRZbEpNcGdZREloWjQ3eC9EWFZhV1FuSEtIc25pVEpZ?=
 =?utf-8?B?YjdoRkxQYnBwcHlIVW9tQTZ4c0JjbUFOL2JHa1ljY1RuYkNWdzFZOTlXdHhS?=
 =?utf-8?B?MGl4UmFEL2U4RjB3MmJNbFZhcE1kamdRWUQwaVNzQklPVkNnMmlsMldyemtH?=
 =?utf-8?B?aGVUNFBPWEh6bnM1ZzJEQVBOcVFpSnd5RjJMeklYbmY1WEUxaFNBaWJ1WW1B?=
 =?utf-8?B?ZkJWNGpSNU5jMGppN0V1VHVuK1RXWDFTQkxmdEpSK3BXMzk0S085N3RHY3l2?=
 =?utf-8?B?RmRrR3FmVHZ5NmJrWm9YZm9vczRGWjEzK1NTVDE0dmh0eTFuenRxZWQvU1I5?=
 =?utf-8?B?dktyVWhkb0w0N2NOKytSMzg4U0J0aGdSc1UzUGNsWGRCMVNDK0JjY3JwVEJr?=
 =?utf-8?B?cVFzalUwWjNjUG9EbE9PQ0FtY0w4aU5Fa2tQOXJKQ01mVEtWeXh3YWJaclAv?=
 =?utf-8?B?Qi9mS1RXdXpWS1Y3YWNtSVBYRnNZNFJCRWVQcUR1WUE5OWRsdm9IbGtja0RK?=
 =?utf-8?B?ZjFud0xzNWJEMFZuYjVJQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7110.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9xeWlrMUhuYitwSnJBNXhCdThFcU15cHMrY210T0VHajRtVnFwbi9WUXNT?=
 =?utf-8?B?OUpKamdSazRndE5UN3FqUjNLejh3bFZpdkZWUnAwbDllZkFyaWQ1WDJTWnc0?=
 =?utf-8?B?akRRSFQrenY3SHN5WDMzWnRBOEtNNG1uRGp4c3VqQ0JBY00yNlhzVElnVjkw?=
 =?utf-8?B?VVk4d3ZYQ1lPRk5CTjdMOG16SWFYQTN4MlRwQk1rM2hXV2prMTBzSVNzcDhv?=
 =?utf-8?B?MEJMYUN3dEhncDZGMEYvRVFvaSt2bENQZzRSSlcwbzJES3pYN0U3TVpZMDEw?=
 =?utf-8?B?cFFWZ3ZVSTk4QStwbVlmK1JraktCbFhsMXJtTkVYcTE3cllBT3ZnNnZmZnhl?=
 =?utf-8?B?NzBsS0E2Nm5YVWZiSWVadzE2Y2VIaXFoWXQxVE9SOWE3aU9ITWZUZlUwSmR3?=
 =?utf-8?B?Vlo5blNTMmgrMXVVeTlqcmlKMHRLWGk0MzhQVW93RGVHNkE5OTlldSs3eFVE?=
 =?utf-8?B?TGdnamlKNGpYaUZMenl4QnA1M3dVVlhGRHBqL2JnVHlmaTFlV0VCcjhnR1Aw?=
 =?utf-8?B?UXN4RlRmSXg4ckkyR09SZ3VpeUE2SHRiY0RMSUFScFZNNEs5aUx0anh4enNn?=
 =?utf-8?B?TERwTDFHQmxoRWZoV0VLUGk5cEhlQ3FlalFMQTRKNmxvenFuYmZmNGp4clg5?=
 =?utf-8?B?TVBDYkFlbWRvbUFNQTkyZjk4Q1hmT21tTVlIZ2dURFd5YStnNzNNVkJ0OGZM?=
 =?utf-8?B?L0cwQ3krbjRhRnlVZVRybk9DcGlzTmJMOVNPcjQvL3MzRnJoUDNwNEVKOEFP?=
 =?utf-8?B?ejVPZW9OQ2V0WWJMVXhUOG8wRzFVSWRXTlpSUlpNMUtQU3Ivam4ycWJJcGN3?=
 =?utf-8?B?cGFtUjNjUzZtL29yMWxNdmFTREExZ29YTWx4Q0J6VGxwUENTUzZCeXFXNFls?=
 =?utf-8?B?OHdTQ04yQUhaSTZtbzFjNTZhRjJ3R0ZuTVB2MStOQkVWVHR5S1Vma1dTb1V1?=
 =?utf-8?B?eUxJbGNJKzdCVWpHbVdqZTFoV1VlL1hRYWFZZHpzQ0NYRlNlb1RjWGFuc3Nx?=
 =?utf-8?B?WFpnV0lWZGJjMTBQSkdid1IrWDF6aTBVY1NtaERpZjJ3bmllYXpCbmZ6akVj?=
 =?utf-8?B?dFR6OXZYWUhvWkFZZ3Z2elM4bUhPQldlVmdSbXo2NFVQaWs2UVlYcjFrSncx?=
 =?utf-8?B?cENIMXdkN2htRjNFR0NlNjhGRTRhVWEreXZERm56dnJaZ1B4WDJlVkRSUFNt?=
 =?utf-8?B?V05uak5MZEwraURxMVIxSTFzZjNyMzl6N09rc2V0azNKaStjN0dBQU8zaGJS?=
 =?utf-8?B?K0pBL2U4SjNCQ2FlbnllTXMydEliMVVOS0xZcHJIMUhzelc1Mm5JS1I1T2JC?=
 =?utf-8?B?aTVtK1VReW5NUVZQZEdNalE5Y08zMVl3cG9xSWRnV29hSEdYQzNNbk1kRUhH?=
 =?utf-8?B?c1FHOFp1dlJrQUZqU3VIeFRMZ0g0WDRIZE93aExXU3NRbG1FK3RPQ3FzWWhh?=
 =?utf-8?B?UHJqbnN3VFFpM3ExZlFsTEV5NWNrRC9zNmhQWjMvTkJjVEVFSmVJVVM2a01F?=
 =?utf-8?B?c0V0VHhhNGR4L3hydGRkUXR2MEFCdkxScVpHbFZ4dkd5Z1pIYU45R25jNjk3?=
 =?utf-8?B?Z1o1QlVGd2xBUUgwTU1PUXljVmdpOVBDSnZkTE1VRCt0U3ZTUzdSSE04eStx?=
 =?utf-8?B?WmZsMjhIczFaZnhyVDJ3cUZrZGhSSUJMTzkrYWZMV1RSVjF0ZHlqSHF3SVpZ?=
 =?utf-8?B?Yis5aHNYei9VZmxwNSsyc05pTFNWazIxWkxCL1J0QlhnVEd4amRkU0hQYjRO?=
 =?utf-8?B?Z0tuR0JvdVBpWmdlaE1ZU1hmdHZvMzhjQ3RBSEhmeER3eUNoTVhEbW1zOXM5?=
 =?utf-8?B?VDJNdkk1WmNKVGJMaXkvMjR3UDRoM3E3cXdFdFJHSzVzVjJkSy9ZRnJqSURx?=
 =?utf-8?B?WTdrbVU3aklUL1JMUFRPTzdYdkYxLzVzbitGWmdMQXpuaG56OWhBcXYrNzJV?=
 =?utf-8?B?RjJGNzRrSmNiTVgyNUVjTTZHN255Umd5NjZEeEtWMWcyWkVDeVJGdnlmOVVy?=
 =?utf-8?B?K1BEQ2plRkxsZlIrOUhUb003US9SdUhPTEV1L3BMZktZYUdWZnR3NUhHR0Jr?=
 =?utf-8?B?R2U1RFRScFBwUXA3TFZOZC9CdlFBK2ZadloyT3N4TGJxSktVbnZxaHlMUGpK?=
 =?utf-8?Q?s5KnBh1Bb4rZZDqIktSc5c6N6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4b8f91-094b-4a68-5f7b-08dcc70cb6a3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7110.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 02:54:20.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgCrVMfEHob2nEQsM8SjpFY7zON//vmjgyW/+Knzst1IvD0Zkw5RmqPOxwyGSoK71lwqPpIDPsb7zXp2G+L0pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5921
X-OriginatorOrg: intel.com



On 8/28/2024 12:22 AM, Jonathan Cameron wrote:
> On Tue, 13 Aug 2024 19:05:31 +0800
> Yanfei Xu <yanfei.xu@intel.com> wrote:
> 
>> The right way is to checking Mem_info_valid bit for each applicable
>> DVSEC range against HDM_COUNT, not only for the DVSEC range 1, hence
>> let's move the check into the "for loop" of handling each DVSEC range.
> Say why it's the 'right' way.   I agree it probably is, but more
> detail in this patch description would be good.
> I assume it's as simple as
> "In theory a device might set the mem_info_valid bit for a first range
>   after it is ready but before as second range has reached that state."
> 
> If so looks fine to me and with that additional detail,
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Make sense, will do in v4. Thanks for your review!

> 
> 
>>
>> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
>> ---
>>   drivers/cxl/core/pci.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 38c567727dbb..519989ada48e 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -324,10 +324,6 @@ int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>>   	if (!hdm_count || hdm_count > 2)
>>   		return -EINVAL;
>>   
>> -	rc = cxl_dvsec_mem_range_valid(cxlds, 0);
>> -	if (rc)
>> -		return rc;
>> -
>>   	/*
>>   	 * The current DVSEC values are moot if the memory capability is
>>   	 * disabled, and they will remain moot after the HDM Decoder
>> @@ -345,6 +341,10 @@ int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>>   		u64 base, size;
>>   		u32 temp;
>>   
>> +		rc = cxl_dvsec_mem_range_valid(cxlds, i);
>> +		if (rc)
>> +			return rc;
>> +
>>   		rc = pci_read_config_dword(
>>   			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
>>   		if (rc)
> 
> 

