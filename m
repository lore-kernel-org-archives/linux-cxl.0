Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F73C0C;
	Tue,  8 Apr 2025 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081908; cv=fail; b=jMWKZ0xth8GwLNgMHKmoBm84CfB90k3GfMlOM5HP0HpPFAP8sW/BxLIs4up8y3oLyfgsjhlGisXQy3YzD7dxxFFcfKE59Q7Syj6YW/VZNvpMGrJlS0/u5gC25Y13/oJiT5XY+TA8LeIzEFnGmklvB+UkoFtG5O9Oz8Uyj+dzFo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081908; c=relaxed/simple;
	bh=Kq4VuCrFw4rhuxuZv4sIlgXzphBJnV5Au2xofMQfFdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o/CDTUw0snuZuZ4zWBnKXky9cx+PzHnv+RdTRwlZaMPjMTQu2Ass/haXs5EkPeE0/0Bdrs+zllxTsGhvrPC9TmxbcmrCEGMSWzGlQ7NFxwZQuN+vYv6jc0UmmL67deL0JD2owATwvLrTVSqvDfRRjfqgZWypKZmXB0EEoEi9HUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fGqqAHEC; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fGqqAHEC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1744081906; x=1775617906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kq4VuCrFw4rhuxuZv4sIlgXzphBJnV5Au2xofMQfFdI=;
  b=fGqqAHEC447oQCfLfNC5TfDZFXVwvNhhT2KJ/ycp0XtyQSNJ6YkqBxNP
   oEFZeVrh3uql7/WF822LQ2JYB3tdTAhwxzR7mhJYTueTzco7ukBJsQETU
   poY4zK3Sl4NHrB4Agy6x2TriMRaIPy3KGBbOhm2KdkG2qyLep36En8fm6
   2Lgs+AEwIKgpIbC/yxnrGzszrP9iqBnvIRD/xRFOPJroQpqb7howiT32X
   9zRUdExQei1kCy0c9Jghl+Bc6Xe+oYNftXvogtmW101/5M+7pPJzf/6ub
   MPktD+YoYlA5hN4IwR5kURQHphL6xZDNzWw8ayelH9kDEYDPvqxC3MmT4
   Q==;
X-CSE-ConnectionGUID: RcptOiMdTqWOWjD7dlS+gg==
X-CSE-MsgGUID: WaYkWkwCSJCXaZwJ5wIEpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="63076382"
X-IronPort-AV: E=Sophos;i="6.15,196,1739804400"; 
   d="scan'208";a="63076382"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 12:10:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRTtdBOgPYN4uA14GKQundNYF6tp52o8jpWiODaisu6AkdCHgRHo3reYvGTr/EpYhW6ek2VTfrtUCG56HJ0umKXwcI/o9xInes1VDwyqAMm7Sr92lj0gM9kCv3z5XH8HWIL9P7K6lp9vmit6ovCHP5PZ293b+uXcyHw9Gtg1WKInYipt5B/fLhMOUKeLQ4HFD60WQz+fjpHAvHnLliPFF+gLbi+ug8ryPYJOYUgkiv0hTIKMSexFJGSeHe4XNhcDv5DLaxZBrDFRb/21kFjt/I9nDbfoGV/k0VOrLbA31x0lVs7ZZLpIHdz7VvYnFZUgKmJlA8MItRI8DhXIAyPxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq4VuCrFw4rhuxuZv4sIlgXzphBJnV5Au2xofMQfFdI=;
 b=j76XbxT/u2Vu7ILrekX3gOaiKvJDwKrpSgLqCgQOXqMlHivWVWeSqXODbLlzKJw1615LYfDkkkpHVMl8nbp2avoAAnlUhElHBmWcAAV1f0lF06fsIKVQ68/uVlFs5aB6Bb6Lctbn5Ty27MCXp8KzKhGi+27sRBcqhIPW6/UvzdWkmt6sNiJzBYVnXvHRJDIracDAeRZ07eTjRQqbvs4K0VAxbS3MM9FN3pQPwen7c7eNinacpCSq7sMLivZGtRQnIfc12T8LwitIhpFW1xWh4BBoEn7aIijv72Wf44kxPW4DsR3IoR82ba27DRlS+aNDCVX4NQ7oL3g5IG0PYC3UdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY4PR01MB14223.jpnprd01.prod.outlook.com (2603:1096:405:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 03:10:25 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 03:10:25 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Gregory Price <gourry@gourry.net>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Thread-Topic: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Thread-Index: AQHbjvNia1PhMmp5z06r6vu5ANRYCrOQF8EAgAB+mQCACLNIgA==
Date: Tue, 8 Apr 2025 03:10:24 +0000
Message-ID: <fb2e8912-9a64-4053-bb8c-dcaceb669731@fujitsu.com>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
 <Z8o2HfVd0P_tMhV2@gourry-fedora-PF4VCD3F>
 <cf7b97d8-4393-424c-89fc-aa810d907a67@fujitsu.com>
 <Z-1HPqufU7MnQ6ii@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z-1HPqufU7MnQ6ii@gourry-fedora-PF4VCD3F>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY4PR01MB14223:EE_
x-ms-office365-filtering-correlation-id: 43bf5db7-3da1-48b8-9a74-08dd764ae827
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?UlF5dmNuSUIzU3U1a2d3eXdsbFhPSE5YV3VQa3NLZzFMbzZwUjl2UFdkWlJj?=
 =?utf-8?B?U2ZGeWljRTRWeDBSVnBPOVdzdGVpWWxza0J4K1BBaU4vdSs4QVpTOFBPS2hW?=
 =?utf-8?B?TGNxOHo5NTd3ektBWnE0bjVpK3pWa24zREswWCtDUmZxc3JQYW8zUU9vblNv?=
 =?utf-8?B?bVpYd1VzVGg2eWU4TzFucHk4emxyVmk3ekdvQS9Ga3FkektqenJXU3FHZmcy?=
 =?utf-8?B?eWxJMUQ1R3cvazh2MHpTdWJvZ3J3ZktBcmJCL0tCSnd5ZVhuNklKMk5Geklo?=
 =?utf-8?B?aEhXNkl2Mk50ZGNuZE5PY1A4Qi80ODh3cmZJZ1VyWXZ2Q3ZKUm4zODh0M2E0?=
 =?utf-8?B?QzJBSVo4Y0gzYTV1ZHUrSEZjWlY4UTVXVG5QMUhVcWtiM1RieWhZbUpGZy94?=
 =?utf-8?B?cThqM0Nad1pUUW1WL3VvelBnblVaVHNnYWNRWm1EdW5aWnl0Wm9oS3B1MUhR?=
 =?utf-8?B?aExDOG5VR0NHWlRET2h5TXRhUTN3VUpjSGZrS2JyVjlETG42aW9GeDhGUHBL?=
 =?utf-8?B?aGlJYWFsZE8rS1NiYUFmQmFNVVRuVS9jSnZQYjJ6UVFPaDF2TmZna0IvWVNM?=
 =?utf-8?B?T2hGWnNBQTE0M0x2amtqRTRLYWNiSXRTYkhXK2VzejUxNVRPUFFOc1ZlWnJx?=
 =?utf-8?B?aDBGZ0ExQ0tweDlTY3Z4Z3Y3N3JkMHVxWnNWSFRrQmFCY0FNcnpVazNIRnNP?=
 =?utf-8?B?VWF1MmRIQkk2cEcyUGhHTm03bk1iTnlZanl4c3Z4N0szeUl6Z01HVTZSWDk1?=
 =?utf-8?B?dC9obTg3ZVZxcUZiZVBnZkdERWRkellETHJWZWl3eEM3c0VXbUJpRU1yZUNa?=
 =?utf-8?B?M3JUSW9vblNXZkRnWkI4YlRVRGg1aFVhcjl6NE85RWxMZ3NlVmkwR25qQjJQ?=
 =?utf-8?B?WHE5UE1odW1XYlVTTzQwNkt4RzlNazMxcW5rbWVXNHhvREU1WXl2blRtT3Bh?=
 =?utf-8?B?L0lrTWUxMjZFQU02V1hUaFhLVVFvOEt2SzZpVWVxdlNPTVdicHJVWVRmM0Zh?=
 =?utf-8?B?d3E1YkJKSGhJQ3JRaGU2eDViY1VaMEMvTmYyOFhEL3FaSFBOaHdTQ2pObkU2?=
 =?utf-8?B?OVc5WEQ0ZVVpSkxkMnUzQ0Q4WUxQNGhlME92RVc0alIra1VQUHhKRVZGRVFY?=
 =?utf-8?B?SXJPdXNUcE5BSGFMWmE5UlhUTzNhQ0VDWndOWVVwOW5hOHdsbzh5WEFrSUhS?=
 =?utf-8?B?OWNrbVVVUVpxT0VNeWppM1BTcVN0bEp3NlIrVkk4NWpnK1dyMHFZK3N1Q1BC?=
 =?utf-8?B?M0V4dnBYWU1SZnNHaFYrTU9za3pRejBXYXRQNlBqTHM5SVpWMW5XN2ZlYmVz?=
 =?utf-8?B?RmhRbG1NbDJpUDFnWXQzd01DTU92VWNkOEZnaUV1ZU5vTExlTENXWTArYWxC?=
 =?utf-8?B?VDFFV0NvT3V4ZjRoZHNiNktUQm1jZGZ4TFcyL3dvOUg0OFFQNnF6MStTakFZ?=
 =?utf-8?B?dWhDT3FpbGMydlp1WFVyVWxIUVhDajZUSnNzWEVCa2lrZkJyRXBKOW1qM3E5?=
 =?utf-8?B?WlliejdxSGgzZXlNeld5R1NRNkttYUVPclFlRnI5MUxtRW1DR09DeWxlZDJ4?=
 =?utf-8?B?dUttMVZZeFp2NHlzKzh0WFJZQkgwYnlKRXlHejFlYnBsOVVFZC9Cc3ZIYVVD?=
 =?utf-8?B?dVVET2o4empSbTBDOXFUNVFIcDgya2xyU0h3ODI4Z3VkTFkxTHloQUM0dWFn?=
 =?utf-8?B?dVJhc29qckg0MGVCTGZaRDVmbHZqRmJnSW9Oc1NINjNkcHRUbDFHdW16dlgz?=
 =?utf-8?B?eWxOdVdnWmVlbHVXZGZtV1BUWFBhWUdreW8xMHQrZ3VGOXFSL1JHOEs3UjRF?=
 =?utf-8?B?MW81alpJOUNnL0hDT0RBbEo0Z2Q1NTJSbWwyOFVoTkdMSDdFMXhXZkZrZGNC?=
 =?utf-8?B?WHliZEhaQmdmb3lkWXV6aGh4K3VYUVVIc2EyTHIxS3VXQk52VmxxQzVpN2hU?=
 =?utf-8?B?UGxZRGRWcjRHV1pSOXQ5MERqNUZEcXZlWDBkZ2crWU5kbStPeUx5T2pjZzZy?=
 =?utf-8?B?THlSRnlhOGpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0RSVE90MFdvQmZHN09lcTNMd3VXNDcydjU1SHp3aUM2NkZhMGs3VFVSL2ds?=
 =?utf-8?B?U0VLZ1Jza3NBZlNleDNTa0l4QmVORHI3WTlGN3Z1NGNEU0F2WlVpZjkwcmhp?=
 =?utf-8?B?UHNqTWQ0N2pEMTlPSmZaUi9ianFrU2Mva2FyV0ZjK0JidDhxK3hrRlFrREM4?=
 =?utf-8?B?bk1sYUhrNnBoUCsySzRId290NlYxQm8xS29ESzlyTSt2VnkrZnJKOEdQcmNT?=
 =?utf-8?B?WTdIOTlvcVdMelFWbUxxaHR3ckppODhnbzhTWTYrdjVzZ2dNcmRqa1dJcDk4?=
 =?utf-8?B?U3I3a2lyWlNoZXhaL0h2RHlRbCs1OVBsRTNvcHZmcWx0VGJqU3BoSlRobDk2?=
 =?utf-8?B?QXJsRlVKdUp6SVl3Rk4yM1hUTUE0RWdGYlZxdDE4a0xNaVI3ekZnaEJ3TE9B?=
 =?utf-8?B?MG1HZ2lUSUlmOEJyaEpjMHZJampvNW5yY25mSU9KTVBPdy9TdDRDRGEvdkFl?=
 =?utf-8?B?MlFZM0t1UkJjUzFpUHlnSlZyREl4MU95ZnZsSitlQkszM1UwdzZxRkQ3TVhR?=
 =?utf-8?B?L3NUNFd4MDVUdU1iV0I2NWFVZjlqd0JKZmMycVo0M2hYMEhhV1lrRVhxd0lo?=
 =?utf-8?B?TzZYVzB3NlcvRXFadUJaSzR1QmVIckxkb0xtd1pONXhCcG1hWkRMU1VvTzkx?=
 =?utf-8?B?WWY0cXlpcXI5UW9LZG5OWnUzbitXcW5jaEJzRTVTb2tqb1podmVGdCtLUWgr?=
 =?utf-8?B?akxORTdKK0l6MkVpQ3JFekMvcWNLbXN0OHpKcExjUWxJWkpMRlhBT3BqaEZR?=
 =?utf-8?B?ZzM5YVRMMDlUUWNhdU4ySW9ZbHRiNDhwcWVuVU14amlDUStOYlhXRld5UCtu?=
 =?utf-8?B?ZUY2cU96ZjZ4RGJTWVZoM1JlREg3eGMvUThpTmNlMnU0WHRiOVBvWWRyVjZU?=
 =?utf-8?B?aUZiK2picDJQQlYycWo3T0JiK2d0am9xK2djTHdCdm9tc0MvZHR6MWl2cGNx?=
 =?utf-8?B?MnZZK21uU2VRb0hTcU9Kbzc3ZEcwSFJvRXZZN3piS0xCTXVnU0d3QmJyUlp4?=
 =?utf-8?B?SVE0eGFEYndmYVVkQ3RDT1ltWTJWanRweTJycWF4Z29qWjFFOU95TVBqZmFJ?=
 =?utf-8?B?cEJ2TWE3T0ZrYitnb0hUZmJiNGI5Q3N6N3ViQkQzVmdMR0hkS0VXamcvcEFW?=
 =?utf-8?B?Z21jYy9YNHM4TXI0TnRreVVjNnVJaWtTREF6OEwvMmFzbUNmZjhqUVBWOTJD?=
 =?utf-8?B?QW4zWjFZeTUzRzlpeWJIWU1LWXllMzVoajg1OUtMRElFWndGRm4vajZMcWFT?=
 =?utf-8?B?ZWxadGVzeE8vWWtvVzBCZUhLaU0rdFlIR1FPTmg3b205SEI5dThOdVpTQVI4?=
 =?utf-8?B?M0FIbVhkdDhkM1c2R1ptalFUUU5QNkx1UWU1LzVDRXVvbWdnVEFhbWNtSXBI?=
 =?utf-8?B?Z05zTVJhZ244bDBaU3JaNUQvb1NGcUF0alpjZm93L3RKWkw0TGxkc0ZXTkE5?=
 =?utf-8?B?R3FLMzhoWjNJS3ArNE1jQXlPS0QyVmR4ZzZSMG9vck44WXZTa2JiT2x4dmdz?=
 =?utf-8?B?YXBLZElJeFlvOUhuaSttY1NDL2NqS3A5eE42M1pvdDF0d2xUb0ovV1VwSzVl?=
 =?utf-8?B?eWJtZjQyVEFKZE9tQ2laS3djb3I1eTUzSkU1UGNvYzNmRmd3SWIxdlNvcHJR?=
 =?utf-8?B?aWcvMHVJQVZpc2FiWm56UXFoR0N3R0xvVHpVQlVsQ3lSTVFnOHFXWW85elNE?=
 =?utf-8?B?MURvSG1kSjIvSzRtZTNKMWhjNlNwY1l5Q2lnTXgzRkcxVnBYQnVBQXhQaWRI?=
 =?utf-8?B?SUMySU9ZRGFyeWNlSklZZnVlQlFveFNLVDhSR0I1RlBDNXp3ZjdUZnpzcFRL?=
 =?utf-8?B?RHp6Njl3T0NVT1BLR0tEdS83b1k2ZHlIMlp0R2w1VFdoRHUrM2d0MWdPOTFX?=
 =?utf-8?B?WDFBbi9nK0VwbkZSQ2hEUlBFRElyVmpTWGVub0g0UW1YWW8za0lBM1JxaCtQ?=
 =?utf-8?B?S1YvOUNaSjdMSm1UaEZQNEZqK1JkQzFBRG04UE1BTjNCREJVeDdkWkFXcDZC?=
 =?utf-8?B?UXk3dWFRTWI2bHcwWTNjVDlBZjJKWldDSXZGV2FHSk1QRHFUbUhXUS9wZlVa?=
 =?utf-8?B?eitaaWFFTHkzS0VPWk9IcjZaUWlzY1Rqb3VKNWtWeEVxODhHZzRad3VRUG84?=
 =?utf-8?B?UERhdGZGcU1Wb20wNHZBSStPQVg1RkpzREN0cHc2WndvYjl6citrbTl4NlhM?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0B93885D43F9D44B709886100965918@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4LKhiw53ohqIrK92vi4K7oxdHJmRQaj8nXYDLA2/6FmJhubB4j/feasW7mXfeIT+QTeccUnp0ofiaRD+Uf9TjCFHw7G0j2uMkuCUaPTO4vpo5AZi0YUrq/+6Giz1Fo6H9eyiBSnznfjKRvMOEx5LQMb70Kal0Wbj1uXrqIAdWD4KS+LvE4OpiEDmb3pf9S3J9DwbMLEoc/RsWGLh6/K0K9NO5jQIwoD3q5vAFD+r7D3tE8u1t4FWIy8f+UnRjlc5ATnjqJ7q16UL7Cxq16+obJlwx1pozeTmYhcmf28E5xvoGMRl4ypbHgu17q01CkdH/+3GBPYHGfDMb42nGizzDGhKO9iD+wqPOU0ZAH/TiOCuZkBcqYwxPU3PMr5zdzM6JaMjBn/h5q3SozwPkkGvp0k4iVZtNAVj0T/USiPkdQrEl9nBiuPaDiX53CD8GeDNCWKxHxD8Y5NlnJB5Vhw4Ny0wG+5F6wM5q8AIf1OIF6HU31HYGD2mahYNb0gnIYSoHdrHhrZrVLzbuQAHsaI5uybNA+WPCrsia+RNFFn8Hzgc7zxcK9RBQZwuhYd9HpmXWHkVv7bigFhuI34Lq87SQUpeDBvUrvULUfzHzIGnytufMe4skbBYuGjg4AFnpDi9
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bf5db7-3da1-48b8-9a74-08dd764ae827
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 03:10:25.0463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixDeEDUqn0T+KZVT4leWqDej+x+6jkEmreo9noUxSIZH1hQsXwrXavkSw5lYy/TvpN3/bsGOO2tMYPwiHoDtSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14223

SGkgR3JlZ29yeSBhbmQgQ1hMDQoNCk9uZSBtb3JlIChzaWxseSkgcXVlc3Rpb24gYXMgYmVsb3cN
Cg0KT24gMDIvMDQvMjAyNSAyMjoxOCwgR3JlZ29yeSBQcmljZSB3cm90ZToNCj4gT24gV2VkLCBB
cHIgMDIsIDIwMjUgYXQgMDY6NDU6MzNBTSArMDAwMCwgWmhpamlhbiBMaSAoRnVqaXRzdSkgd3Jv
dGU6DQo+PiBIaSBHcmVnb3J5LA0KPj4NCj4+DQo+PiBPbiAwNy8wMy8yMDI1IDA3OjU2LCBHcmVn
b3J5IFByaWNlIHdyb3RlOg0KPj4+IFdoYXQgaWYgaW5zdGVhZCwgd2UgaGFkIHR3byAyNTZNQiBl
bmRwb2ludHMgb24gdGhlIHNhbWUgaG9zdCBicmlkZ2U/DQo+Pj4NCj4+PiBgYGANCj4+PiBDRURU
DQo+Pj4gICAgICAgICAgICAgIFN1YnRhYmxlIFR5cGUgOiAwMSBbQ1hMIEZpeGVkIE1lbW9yeSBX
aW5kb3cgU3RydWN0dXJlXQ0KPj4+ICAgICAgICAgICAgICAgICAgIFJlc2VydmVkIDogMDANCj4+
PiAgICAgICAgICAgICAgICAgICAgIExlbmd0aCA6IDAwMkMNCj4+PiAgICAgICAgICAgICAgICAg
ICBSZXNlcnZlZCA6IDAwMDAwMDAwDQo+Pj4gICAgICAgIFdpbmRvdyBiYXNlIGFkZHJlc3MgOiAw
MDAwMDAwMTAwMDAwMDAwICAgPC0gTWVtb3J5IFJlZ2lvbg0KPj4+ICAgICAgICAgICAgICAgIFdp
bmRvdyBzaXplIDogMDAwMDAwMDAyMDAwMDAwMCAgIDwtIDUxMk1CDQo+Pj4gSW50ZXJsZWF2ZSBN
ZW1iZXJzICgyXm4pIDogMDAgICAgICAgICAgICAgICAgIDwtIE5vdCBpbnRlcmxlYXZlZA0KPj4+
DQo+Pj4gTWVtb3J5IE1hcDoNCj4+PiAgICAgW21lbSAweDAwMDAwMDAxMDAwMDAwMDAtMHgwMDAw
MDAwMTIwMDAwMDAwXSB1c2FibGUgIDwtIFNQQQ0KPj4+DQo+Pj4gRGVjb2RlcnMNCj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkZWNvZGVyMC4wDQo+Pj4gICAgICAgICAgICAgICAg
ICAgICByYW5nZT1bMHgxMDAwMDAwMDAsIDB4MTIwMDAwMDAwXQ0KPj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZGVjb2RlcjEuMA0KPj4+ICAgICAgICAgICAgICAgICAgICAgcmFuZ2U9WzB4MTAwMDAwMDAwLCAw
eDEyMDAwMDAwMF0NCj4+PiAgICAgICAgICAgICAgICAgICAgIC8gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcDQo+Pj4gICAgICAgICAgICAgICBkZWNvZGVkMi4wICAgICAgICAgICAgICAg
ICAgICAgICAgZGVjb2RlcjMuMA0KPj4+ICAgICByYW5nZT1bMHgxMDAwMDAwMDAsIDB4MTEwMDAw
MDAwXSAgIHJhbmdlPVsweDExMDAwMDAwMCwgMHgxMjAwMDAwMDBdDQo+Pj4gYGBgDQo+Pg0KPj4g
SXQgcmVtaW5kcyBtZSB0aGF0IGR1cmluZyBjb25zdHJ1Y3RfcmVnaW9uKCksIGl0IHJlcXVpcmVz
IGRlY29kZXIgcmFuZ2UgaW4gdGhlDQo+PiBzd2l0Y2gvaG9zdC1icmlkZ2UgaXMgZXhhY3Qgc2Ft
ZSB3aXRoIHRoZSBlbmRwb2ludCBkZWNvZGVyLiBzZWUNCj4+IG1hdGNoX3N3aXRjaF9kZWNvZGVy
X2J5X3JhbmdlKCkNCg0KDQogRnJvbSB0aGUgY29kZSwgd2UgY2FuIGluZmVyIHRoaXMgcG9pbnQu
IEhvd2V2ZXIsIGlzIHRoaXMganVzdCBhIHNvbHV0aW9uIGltcGxlbWVudGVkIGluIHNvZnR3YXJl
LA0Kb3IgaXMgaXQgZXhwbGljaXRseSBtYW5kYXRlZCBieSB0aGUgQ1hMIFNQRUMgb3IgZWxzZXdo
ZXJlPyBJZiB5b3UgYXJlIGF3YXJlLCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNCkkgaGF2ZSBiZWVu
IHRyeWluZyBmb3IgZGF5cyB0byBmaW5kIGRvY3VtZW50YXJ5IGV2aWRlbmNlIHRvIHBlcnN1YWRl
IG91ciBmaXJtd2FyZSB0ZWFtIHRoYXQsDQpkdXJpbmcgZGV2aWNlIHByb3Zpc2lvbmluZywgdGhl
IHByb2dyYW1taW5nIG9mIHRoZSBIRE0gZGVjb2RlciBzaG91bGQgYWRoZXJlIHRvIHRoaXMgcHJp
bmNpcGxlOg0KVGhlIHJhbmdlIGluIHRoZSBIRE0gZGVjb2RlciBzaG91bGQgYmUgZXhhY3RseSB0
aGUgc2FtZSBiZXR3ZWVuIHRoZSBkZXZpY2UgYW5kIGl0cyB1cHN0cmVhbSBzd2l0Y2guDQoNClRo
YW5rcw0KWmhpamlhbg0KDQo+Pg0KPj4gSWYgc28sIGRvZXMgZm9sbG93aW5nIGRlY29kZXJzIG1h
a2Ugc2Vuc2U/DQo+Pg0KPj4NCj4+ICAgIERlY29kZXJzDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRlY29kZXIwLjANCj4+ICAgICAgICAgICAgICAgICAgICAgICByYW5nZT1b
MHgxMDAwMDAwMDAsIDB4MTIwMDAwMDAwXQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfA0KPj4gICAgICAgICAgICAgICAgICAgICAgICArLS0tLS0tLS0tLS0tKy0tLS0t
LS0tLS0tKw0KPj4gICAgICAgICAgICAgICAgICAgICAgIC8gICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCj4+ICAgICAgICAgICAgICAgICAgICAgIHwgICAgICBIb3N0LWJyaWRnZSBjb250YWlu
cyAgfA0KPj4gICAgICAgICAgICAgICAgZGVjb2RlcjEuMCAgICAgMiBkZWNvZGVycyAgICAgICBk
ZWNvZGVyMS4xDQo+PiAgICAgICAgcmFuZ2U9WzB4MTAwMDAwMDAwLCAweDExMDAwMDAwMF0gICAg
IHJhbmdlPVsweDExMDAwMDAwMCwgMHgxMjAwMDAwMDBdDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgLyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4+ICAgICAgICAgICAgICAgICBk
ZWNvZGVkMi4wICAgICAgICAgICAgICAgICAgICAgICAgZGVjb2RlcjMuMA0KPj4gICAgICAgcmFu
Z2U9WzB4MTAwMDAwMDAwLCAweDExMDAwMDAwMF0gICByYW5nZT1bMHgxMTAwMDAwMDAsIDB4MTIw
MDAwMDAwXQ0KPj4NCj4gDQo+IFlvdSBhcmUgY29ycmVjdCwgaSdsbCB1cGRhdGUgdGhpcy4=
