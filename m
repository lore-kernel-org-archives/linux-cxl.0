Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BABB264A86
	for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359767; cv=fail; b=ob4Ag82Oox64se4UkOBYKUABapI9Bwr2SJitAP+Khy6vLYsFetci80Mg3sN87yQ6FvnSDhp6JbP8V7r7x2VzVHLIYFPtwkt7InJExQNdFcCY3VpMIYbxHk3xDlvq7zkYMwu02lI2/UdJ4k4ELiCThtM9ZDter7vRecvNuVb25jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359767; c=relaxed/simple;
	bh=mljJldwZk0Ybl/om5+uHECgi6WSua2WZV2Sxej4LPGw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Cxfb9QabD4eeao3j0Rnvi/JAFzdUoEcQkksXVggtJ1YiH+eiMz5DBZ8dqUpXol89JeLRZQSV9l2r2FJ7TjpFPeSKYueM23CO/rcXmUglAiqT9fPZ6Ci0XepVwfFEZrsTDL/6Hizg0USWr6DVQKopxQ6+jUTLzIrcoX/C4vNkBqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UoXOIBFC; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoXOIBFC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773359765; x=1804895765;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=mljJldwZk0Ybl/om5+uHECgi6WSua2WZV2Sxej4LPGw=;
  b=UoXOIBFCOTno6yX4ehNAImDX3dDhHxjnkw7XcXqUdqpPYHbtbE2BZUit
   eOFMtrotx4VKNbZ3Os0s9y3D8buzhnGWQw5NBLwJIelmgQJ2auV5V7yzE
   rHU4b+3uhUj2pVD8mlc8Fi+DZZtuNY4rFm4XXIo8vkpaJL/aahjlXaAz1
   JpAA6Gm+jOfnDzZw928z0Tbsyy6+OGhS9iE5WALFdyNSOXtDUDTXF2D3r
   Z++H7K1F1SQqBVRiFhpIZ2U3mVciFq3RZLWjSU5+rQkoYvoAZkrsuou2P
   oVhDzvbce6kD+rQYJBbLRNd1a1wIG24Vaa0fNDxmfdoFPf7vKSgtCIYDe
   A==;
X-CSE-ConnectionGUID: wcY0hRJfTr+8g1JN3mzbew==
X-CSE-MsgGUID: a04YfZOYSxGp1drwdmDnQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74347928"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="74347928"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 16:56:05 -0700
X-CSE-ConnectionGUID: 8yXt0HbHTxSUWzEcwwMTzQ==
X-CSE-MsgGUID: htPiFm4JRzSrBKl/ne3ybg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="218752250"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 16:56:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 16:56:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 16:56:03 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 16:56:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFHWI0vBmEX6y5IME9/wwGh0U6XM9KWrnEVfn6Yid6dsYqtSQRU6JHpxmvFYiWgVsC66JF+nW0KXUxldCExg5Ea7XEyrvb3CLnBEJNLPQ7XLx3kJMXKOOnhgQAIkjj1mI+oFiAuEfTAEsuy0FxVT/O1jygzD9QzZ/yVGZTAAXUiVkJyClcSLf/I1CRijMMMkwX9qPqurvyKQuByNB6j7AR/i+f3fYe5x+9TSPHj+6+1JjDLD6QHC/FN/y/BejWbCnPfOe9uYqoS/g2YexTKOnPwzjH9L2Z0rvrhuZst4EopfdxIham8nGLVwZB87TLcCidSYS6zmtpB7uHh5PWMaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+AO9wdbhvOfmufDV+Yq9/cZhce84FJFO4+TAqlgWnw=;
 b=ifR3SavQ/CgddMqX+99sDHuryoEukPThSGt24Jfo1Nxk0E68uo9OxgvTD9WRBMXQC1JiZluY2R8M4+laqr8+EBkm710aEdLIBmXGVE4WgRMeajdGcROcRzIhKzayPDFWQwPzLHbwFYiw+/p1VMiO/FTUvi1LeYPsPcBLYlTl/rElzRuxUE2KprSIfGGKzckdGy+CTmOBuxHVRR8SyySLUE7Nhyrz29S/ywMyGvfFc0RpTFJZKKnpuETaDA4107D9wgtmLtCAiQx9EUoNQFeVtMZ5k4uAHF7UwkvW0juxoYYjz/MASXkClahlQKVWLkMn8cjtQbe1pZEZyvF7leAtLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 23:56:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 23:56:01 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Mar 2026 16:55:59 -0700
To: Alison Schofield <alison.schofield@intel.com>, <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>
Message-ID: <69b3528f80285_b2b61009c@dwillia2-mobl4.notmuch>
In-Reply-To: <aZzF1Hw6tZu9QXbS@aschofie-mobl2.lan>
References: <20260212062250.1219043-1-alison.schofield@intel.com>
 <698e2a0041223_8c32100a5@dwillia2-mobl4.notmuch>
 <aZzF1Hw6tZu9QXbS@aschofie-mobl2.lan>
Subject: Re: [PATCH] cxl/region: Delay inserting iomem resource until auto
 region commit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0197.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d36e1b-667b-4171-8534-08de8092e9a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ygKRGL1aGcktMUVLI3eaCbE7wzUxOHTd2La88XVsfA5d9ra0SFObJEnp5JdKfJzxbzDggWNWqPeVznif3vd5jpTsFcCY+KQ3U1jkCW6V/Mrz63ROKAUPerUfKZKZFrhm2/VUKTIdqYV2A0/95GsqTQZP3bzYNpS/mCqcOcqRU/FI6Cv1RbukqCDp2eZw2Dxz7Clx6/kbwNcYH5abxbmeuGKg6fo8nJlKbcLEDhT3SpLsB5DqukOiIsJNqnWjhvfUkTU0GTiMVs0babyUIu3e2mIP3AM8qOEn3Un28Phj6vFq0ajY8JanoN1IwUJgVVNR2lL+02LvdA3MkMpFczePhwi/MeF+ZUX9OYR2RXs8RBbCAhE0kDWLPLDk3ZtWC1+xHcQwFOZ4DCYnAal3Z18EBju1zDhx8v+fV+PrNJ9gBr9fEn2Mo0oezttXtavNfn2bmIQZdupIjjmtvNachd1TfP1qffFDjYMxxCnmiPXiR88DlfsDua4cW8RcTmKQ2ziEoiYYOJeuMXMSr1hyA5cc9i/vwJORG8rHvcDcaKV7CuNhnGqWUR7os4iAl2RO3CTH9f4/eOCxeIAuVmay7AM6MTC+q/75/UPGMu6chvKtb6JIkBwOpbUD9tF9qRPBnlv8lGieQHkHVpa7JayZbMt3GlC7NshZgUHGeaMHBoPqNe5dfo8weudf7Tuh4hC074s8VPbFSAZ/ziM5NPeu1/SEsCQq3IDPIzW8XMiskhznxls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEE5UWV0OE5jci9ZbzJwam0wSklJNmc1ZFlJSnJOeituQWl3Q1pWVnBzRXUx?=
 =?utf-8?B?Z1kxa0lhaVdhRXNvTVdoSGRpQnJ6eFI4Z2ZvcDlDQjVpRWI4TjFnMVJyK1Iz?=
 =?utf-8?B?NzJvQVV0TXpDQmtKUm52K3JmRURwVXlMRjFLMHAydXlIbWtFR1ZwMVFSa205?=
 =?utf-8?B?dzViNHg2RWRBSHdwcThTRDFEZXBCNGRJNElXL0ZJUjBvVkViL0NHYU51Q1dj?=
 =?utf-8?B?SWlPRHVBMkp5TmJZOWd2cTJIT2dIaFh4Zm1wSSt6U1ZVME0zMXNmNndZRzhL?=
 =?utf-8?B?aUZUOERTNFRoR0dlVWxxTkkzcGhZbFRIeU9nQWpHeU1odGxMTVZSbnJTbXFo?=
 =?utf-8?B?Z3NiRmxkR0Z5RkRzN0lrQktPM1dBZk4wVXpPNEV5c3BvWStRTDhxSVByTmxV?=
 =?utf-8?B?SWtKN2lQK3hrZXk5NWRWakdFa3VTOTdpRlExNHAyYXQwNXhlS2FpS1l5SjNY?=
 =?utf-8?B?WEFLRldIRHVmb1NXMEtXTS9IREFKVjdiQVFQMjJpL3MrUGRBMTBrM2taK1Ur?=
 =?utf-8?B?c3AwaWN0bkVRSGFMekk2Rm9vNG1zMmx5dGdPZXBsNENvdnFpOGhqdDQ4cE92?=
 =?utf-8?B?MmY2T3Fvd0xGd2JOMXpnWGl4Y2plQ1NnOC8ycnBwWFFNSXltaUdXcG9DVlRh?=
 =?utf-8?B?TU5BM1RKVGhncm1ZMjJGc2EyRlVxNmFhcnd4NS8wUUxxRkRDcFNGNlFrR3cz?=
 =?utf-8?B?WW1zUmJoS0RiQXJVVVJzZVg5UWEyN0xFTEU3RGswWURORVhqL3ZOQ1Q4YThr?=
 =?utf-8?B?OW8xTEFGTG5OWUVHbzhPTWV5YmRxSTBUSVpHaW9GbzZWTDQ4M3pJQkJDZm40?=
 =?utf-8?B?Y2kyQVlMQjFaNDFjcGs5ODYzTWNHNFFVS0JQWUJlWDZ4bDhLQmZBdlJFdGdC?=
 =?utf-8?B?MzhKaERqZXZXTE1xakFrT2ZDMm9MMW15bVFsejNBYTN1UUxtaCt0S3c2RnF4?=
 =?utf-8?B?RDJnaHZqb2tteXpiVzZIU1hLdmlpYmZvMjB1aWMwRjJEamZKM2FUZzdVZDIz?=
 =?utf-8?B?OEw4VUJTcTNOalk5akRUT0c1OTZQUURvZmgzRnJ6bittZ21qNnpobTlZUnll?=
 =?utf-8?B?cjlsMEorYlc1QmtoNzk0UlEyc0dPSE00c2JlTHlRY2Q1bnlYQWJGcmRxL3cy?=
 =?utf-8?B?SXVoTmRER05vNEt2dHZlM1lOVUhaZVBlQlZCQUhOakpMSWc5WGhlUlBRSzJa?=
 =?utf-8?B?YmxwalhHb3FZOFprMFBFREpkRVdPSFE1K1pyQitJc3BaQ09pMUZFNUJpcUl0?=
 =?utf-8?B?SFBSRWJ4T3dUeVptT2Y0QVZCOEQ4dmorQmJ5UERKWVFIcFRnYVIrd1lCYlha?=
 =?utf-8?B?aEdpQndOendLQ1ZkRmQ2TkhwcmdiN053QkVZZnVUZlhKRlllWFVKQXZTclZy?=
 =?utf-8?B?dnZRMWJMeUZzeFJMcTVIQ0FkSFV3a3VFbjVkMFZhMWk3SWF2SFpvb0VXNVJl?=
 =?utf-8?B?cjN2MXR5U2czTDJxbkpTSEtYYUtuQVFSVkdOazZleDZkY2pjelJXNFZzbkJ1?=
 =?utf-8?B?Vll3Qlh0dmZZRjF6MndiT2RpWFI1aVh6NExReVhBUWhpVGhDR3FweDJxejVs?=
 =?utf-8?B?c3NWQWpabHd5akQrQlRkL2xPSFNZWjNnU3B2RDNXT0wrNnQ1RW4yQk5XOE1J?=
 =?utf-8?B?a0lEcStQZE5KT0kzM2xCVHkzbkQ5SEFNb1UrRTEyUWRudUE3b0NBWUhyTytm?=
 =?utf-8?B?UnBKNnFwMDUrRjdJMWNrMWFibU13blp0WTRBY0dqL0pDUkUrcWp1WUZlb1Fv?=
 =?utf-8?B?RE96b2JNWm14cmZuc0FRWVVyYTV6YWRLWWxUWXJtWTdiMVY2QTZoQVp4UE5i?=
 =?utf-8?B?aExrd0NWc0RUVXo3a2ZVcE85eWsvMGpaV2podXVXbWtNM0xEMEhKSTE3ZWlC?=
 =?utf-8?B?aW1Ec0Q2UUZucTJESElqblo2UnNYY2k4eHBnblhyZ01saWZLbFRkT3I3MFR1?=
 =?utf-8?B?NFZ0cmREc1VEY0lLZkRxcUh3azJrR2wrc2NGTndTZndWeWExUlRlZXlTbU9N?=
 =?utf-8?B?eVgvRGZvUTNqK2RnVUovdm1hdXZXcFJuYWhzNFI3b2ErdGpMbFdmL2hnQlBT?=
 =?utf-8?B?VlNlQkxDRGI1Q0lxZkwrT2VBTEsxd0ZLRWMvNzk3YkpCSzBKN1U2TTVQUk5H?=
 =?utf-8?B?YU56am13YXFtZUl6bTIrTWpZaTJTQ2NpUXo4blN1OWRmVXNnSkJ4cVpxWXV1?=
 =?utf-8?B?ZHhFSjkzSnMySGZYcmM4MHZod01OcUlDK0lkdHpSK0YrOURJNTFBaGdaeE1X?=
 =?utf-8?B?UnRkSGFnRkRMMUJRemtDS3VZWkovZ3VKd25qM2tXbmltY2huSmNBd2ZySVNx?=
 =?utf-8?B?YVBNdUlrb0FCRHNXZVMzL1VSZisyaEpSbHR0eDhLYlNGQ1haVmJZc1NPUTdo?=
 =?utf-8?Q?IfGD6kCa3m5PEii8=3D?=
X-Exchange-RoutingPolicyChecked: jP1WJxnnCheirhT3yleGAHhANfyWckfvLZGGXiZUXiJytghZaDgDj27Si+pUQVkskRPTMiO8CkUDMsL159CVH506ciCeBJi3S/02IwH1oWVVmzUYpkpyEGPPdUsNnIuuVEjbJNRO58rh68D++4AM4osCZGF1TkxuFnq2QG3detDW5OuATjeGLZNmVmgfMoi/U+gNtGZ6QIm0xtS7AihxdK9Racj5/b7UPpG2Mx+OXKXzJ5A+0gG5XHcbJu3FS5ip/DbWRjvcYs2QCPA5XgYsAWrCfos1wODwBxDxy6sley8BzQxTzPu725sZDd6U05gtiRLu4ZBfWc/BlpSnNHRTrg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d36e1b-667b-4171-8534-08de8092e9a7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 23:56:00.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heLvj6Bii8Qwg31HOgKUgYEfDGHB3FPCEdBUOm02yk2CcSUkxg806UQmhfXeYk10qT8UyCpZSkLVMFYJqHwIgeZk2Y+I7/IUF27ziRm6yfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7772
X-OriginatorOrg: intel.com

Alison Schofield wrote:
[..]
> > 
> > The ambiguity of iomem resource parenting can be resolved by looking the
> > device-path for dax19.0 ("daxctl list -RDu"). It is also resolved by
> > noticing that the CXL region and the DAX region are using separate
> > memregion_id values (9 vs 19).
> > 
> > The extra effort for incremental precision is not needed, the contents
> > of /proc/iomem are accurate.
> > 
> 
> Incremental Precision?  Isn't it just wrong?

I would say it is "acceptably" wrong. More below...

> The region driver does not have a claim on that address range. It
> inserted the resource before it became a decoder owner. If it wanted
> to place a provisional hold and then drop it on failure to commit,
> that would at least be internally consistent.

When I say it is "acceptably" wrong the user created region flow also has
an unbounded time between when size_store() inserts the resource from
alloc_free_mem_region() to whenever the region becomes committed. In the
same way that the kernel can not know that "cxl create-region" crashed
and is never going to commit that region it started, the kernel can not
know when some wayward device is going to finally arrive to finish off
the region creation process.

The determination on when to give up and when to clean up is policy.
Kernel is allergic to policy, it is a userspace responsibility.
/proc/iomem correctly shows that CXL subsystem was interested in this
address range for a region and can decide "I am done waiting for
regionX, let me go clean that up and repurpose the devices and address
space for something else."

> In retrospect, inserting the resource prior to commit was a bug in the
> region lifecycle. I can re-present this as that, so folks do not get
> side-tracked debating how users interpret memory topology.

I do not think it is a bug. It serves exactly the same purpose as
alloc_hpa() for manual region creation. It says "CXL subsystem is
interested in instantiating a region here, stay tuned...".
