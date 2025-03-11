Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E4B1DE889;
	Tue, 11 Mar 2025 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741661333; cv=fail; b=YlQkuD1HIzZMbbB06wrsXe8mLQy5r/TsiFjO1oLTjv93reH5Rxi7kIEeqLK44TxVk2POMg9bRACoWfbgmiQJOPX2jWovdRVJAUudVVRlShlXO4Eq0VCpdQ4ptkzYd1eM9UXNcbFmegC30x14cg2mDVwAtle6RVE2iyC0GcACdk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741661333; c=relaxed/simple;
	bh=OnvEIaF6euvaDV2gmSEJddwwe8HRBDUsKT1o05gSFeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tvtywimd8ITBWVdzFKBuUFZ8F+YXD6c/fcMoQJ70DTmEzeSwz+jIQmYbeDcJC8GnrIREOGsavkP+cH3UzUwvvJcZWeDKNNDHcTXVodfXqsV8reL+IZJccdA2O6brQfy/r6pMbBz4jsk9heILDxaWSyd33NKavTtNYwP/RqiEy74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=mi+LU/43; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="mi+LU/43"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1741661331; x=1773197331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OnvEIaF6euvaDV2gmSEJddwwe8HRBDUsKT1o05gSFeI=;
  b=mi+LU/43xyzB2fe+x3Fmwv2wVt55QgYawsqAL57/C51Sm+Zs9R/bxbpc
   LzlYJ8tvZL1J1M6R3FdEWFryUIa3JjWNAS0WoEM+tCn8qJ2JX3mr5ZSIu
   iqohWass8R2lPTI5kgRRes1QFSP+eKRERNoUgnPGKRfnFQvLSIilepR+Z
   OMbUMBw5KfxxHLxBT0I9w9U9Ykr+HdOziq+ytB8F9B0jJ09tBuZNwOH/E
   ApewobTUim8jxc5MCuKrO9kuK0ew/dihFoC/suWQ5NyjnDvxPhIn351A5
   e+XVrXisuhvOOkLd8DHJK1yn1QcgyBoTcEbHt7W/a9M/y61/7PFdb6nQq
   g==;
X-CSE-ConnectionGUID: UOekiYTkRxmi/HuhERpWGw==
X-CSE-MsgGUID: N+rK+NKSRhWkJW9QO3SoKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="149458884"
X-IronPort-AV: E=Sophos;i="6.14,237,1736780400"; 
   d="scan'208";a="149458884"
Received: from mail-japaneastazlp17011028.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 11:48:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3J1ji2qKjeYnUd/e2HlafnvotPW3wx43iUu/7OSh3kNwuFrmLUHP8+m1Mng42efpfa8lFrAyJUEKsaCv9BD7AMhWWWVs16qWUrrJe/4LOX5pLaxBDe8SKFk4/tPXqhxg62aQm0YE163P79aHLMCTXEn5zuGZyv3kLcMYVDmCQt6psoPCm8NtMzXrcZH+5R7f/N8IAR/h6Dc7XnIzIlWGqOj9tjldWUuOAOwefMJb8gPaVU0Hqg8LvFXOJnZD1+ctD0EnS0xl6NF7iLkYqan/U1vWYYXqLcQkrFnzi75Mrs7b6gps7clbqtxw3iLgFheMPEJtJxLuErFxNTWF+gSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnvEIaF6euvaDV2gmSEJddwwe8HRBDUsKT1o05gSFeI=;
 b=yQMaw7340Qiu1zeyb2R4ovstYtXw/5YpD6B4CTULK8WggZHtKh81XZxif4oxzSjavXdGlCCVJ7OC3Cka5amTxu33GlF9+fh0ek4vn7DrmGKtrZN1jd8kMaJOu00Z8dqdQ2jMdzGls+qw957g1svlMqoPwqNu+dAZvtomkoMDYuwvATjoLisKLoJrGe7ysJKNp11TmQG3kC0OfncZUkMXDl6yHmoowC7kBm7HP2qwAlxZbLiD0pHbdycrFq6VARqGD346oV4MTHnfCV2u/NlJ+L+UaEZHh0k91F9yABbDkCY1yMDdYz6FgJ3XFiUQKGx8ATH0h49PlnNd2qwYfEiUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB6847.jpnprd01.prod.outlook.com (2603:1096:604:13d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 02:48:40 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 02:48:39 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Gregory Price <gourry@gourry.net>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Thread-Topic: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Thread-Index: AQHbjvNia1PhMmp5z06r6vu5ANRYCrNm2dYAgADtrwCABXrCAA==
Date: Tue, 11 Mar 2025 02:48:39 +0000
Message-ID: <2cec2f4b-d68b-40e8-8cd9-283eaaec8164@fujitsu.com>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
 <Z8o2HfVd0P_tMhV2@gourry-fedora-PF4VCD3F>
 <570b18f4-3790-4e57-8d80-a5301e5d8af2@fujitsu.com>
 <Z8sLznxBkJHWeTvQ@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z8sLznxBkJHWeTvQ@gourry-fedora-PF4VCD3F>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB6847:EE_
x-ms-office365-filtering-correlation-id: df905bea-5766-475a-7448-08dd60473a74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVY4eGdmR1phTGZYQUQwTmJLSG4xNnEzYTREQU5QYVUvbGVKZXVsQ3BlcnNl?=
 =?utf-8?B?S2FiZlRFMWZkdVpKenRNWU85a25waUxsSHMwR0JNRnpDdFVUWWFnR1d4eXBz?=
 =?utf-8?B?TUU0eWZHMjRCdnpuRFg4QSt1bU5jU3FTYjUyenY1aHdkSWNCczN6RDFyamcx?=
 =?utf-8?B?Vm1zMk1mbnJJWURzR3pLUis4dU9TUTN3MTVKRHA2UVQ1eTdQVzRyS09wL1lw?=
 =?utf-8?B?aERVYkNKYTBHWVlXTmk3WW5scWU0L0tNSjVmOFUvUDFBMmJwTjl0RExiMUtU?=
 =?utf-8?B?UHhBdmRZMWU4OXRwUlN3RlY1dENUYkJzVTlzNm5lWnNWMmdPa24wZ255Q0RF?=
 =?utf-8?B?Z0llTTcxR0VTdG5BY3RwN2hKdURxT1pGaEVmQUEyZ09YRlBsY2lLakU0R3JP?=
 =?utf-8?B?Z2w0dTlHb2FyRU9kS2N6RDhmSGlEc1E3SEd4VUVVbGRrcHloQjc4ejRmU21h?=
 =?utf-8?B?ek9JdEpBRHBTSkRibVMrb1RZQXY1dWhvU0lxcWpIUnY3THY2dEpLdEF1Zmt2?=
 =?utf-8?B?akZWMWhZV0ttNXJuc0pxWVFNMTRyU0VTMGdTYndsMi9zejlla0lXMVIrV24y?=
 =?utf-8?B?dnUxMGpKeENVNHRFaUpiQUhwb21wb0xEZXdWU3ZRakVpRzZhV3NkYnNlN0hP?=
 =?utf-8?B?SUIvakw0ak1ZUEd0KzNyeHExOXRGS3NHRHJqcG1TVTlxZFRITnJIa0VyT2Vn?=
 =?utf-8?B?MG0yemdkNVJHMnBzdW9KK20yeTdGUEVDOERleTd4OFJxOWpHeVB3QnNNYnpN?=
 =?utf-8?B?YTBCSVA3ekwwOVhTTWZVT1hWU0MzSUlvWFlwQWRIcFJ6dUhTZzFoYk9NMHhI?=
 =?utf-8?B?TGFHR0duUXlVb1VqSG5HaHNaU21zUE9sWGpRRW4zWmJnV0lQdUhWQWNCUnk3?=
 =?utf-8?B?SERtdURXbGowVFFkb2s2MUN4aFZpOFRUNWVnYnJwa204U3JlVkpLejFkREU1?=
 =?utf-8?B?UUhvcDQ5K3NrVTRuOFZSMTZ3RHU1d0RMdmtxT2NleEd1TUs0dWNPVzUxU0xU?=
 =?utf-8?B?RjByeUEzS3NEN3RVU2I4dkVuYjhWb2d0Z0VkQXlUcStvQUVHdWkvblpuNGFQ?=
 =?utf-8?B?WHRRTlFFZWhsZW44UnZhZ3hqTlRycEtxVUlkUVJETXI2NTd1V0YwWWluK3R0?=
 =?utf-8?B?T21vQ2RSaGRiZTg0dFNnVnlxSEtDemdsUitsK0thZ2hnclVpQmxmR3JiY2NP?=
 =?utf-8?B?emsyM01ENHBseStYSVhRdUI5YlNJZzJJSkR1RXgweFFmbENMNnRlU0tWMjUx?=
 =?utf-8?B?UVozUkdUZ0YrUEJ6bjVXdEVHanorM3YwelJodHIwajZ2eEhhOU5UNVNvU1Y0?=
 =?utf-8?B?Nk95K0VuQTN2eWtvTWxOUlZTbjFIS3Vvcm13SzVzaWRmbXEreWdQWUwySVRX?=
 =?utf-8?B?aEdLUVlHNkRrc2M4bVdPMHo3TEZsUll5WHE2YVFKR2hqdytIZEtFck9xbEV5?=
 =?utf-8?B?M0JJVkp6N010UW5Id2dINGQxS3ZHM3BYVnpmZ1poTzFpWHpTN0RDRXdRWkoy?=
 =?utf-8?B?MVpKRnNaZ0ZtMHJqd284b0I2VUhCK0xoaFB1VmxwL1UyOG0wY09qMUphdVF3?=
 =?utf-8?B?UWZiWG1Xb2UwbGhzWkNRVUowQVVaY1FhcmVSZDg3eFhuRHdOR1ZodUllVHI3?=
 =?utf-8?B?ZGVtcWxldExWWjM1YVZBWmcvczhJTm1Ed2VHTEhjYWNGcm9TRVZpeUplZm9t?=
 =?utf-8?B?ZzFIenF5TXdWTWk1d21ZNFg3VnE2S1NQM0c4SFE4enkrWG9rMVUvMkdPMDNW?=
 =?utf-8?B?cHNFVDZyT3c0MHBZYUpDWFU5anBRelFVWktrL25aVmRVTkxxMkR4TytOUGZn?=
 =?utf-8?B?UWZWWFhab252YlU0ZVdMQlV0YVAzOGdnN1FBM1lWWTgwYjVYdzlYVmlrYkIy?=
 =?utf-8?B?WnJqZlZ5cWV3NVV4SEJVdzRZOWpHVjZsVDJEcS9Ba1hiOGpncFdKckk1K1FT?=
 =?utf-8?B?Q3ZENld5YUVEekM2SE43d2VvRzk0WXdudWJ1TVNoS2tOR245M1VvYnRpZWI4?=
 =?utf-8?B?VExROFNIY3ZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnBobk92QUcxVmdCVzlESlZFUktqTzRLWjI2b3VpVWxpVVRTUUNUcEhuUmF1?=
 =?utf-8?B?MGdCbTJ0TCtUWkJsdWZ1dEpmSVhqdmtLUUF6blVTTkN0Nkd6Ukl5OEtBVDlo?=
 =?utf-8?B?RmV2WG1yUDhuNmVZU2hMSlVITnBmS2hta2dlVjBkbExEaXJXdVNZU2NVVTJX?=
 =?utf-8?B?NDJYWmJYV1Y4bHBmSlArRDMraUFXczgvN2Y4eFRnNjBhcUhlekRiMzNsOFZJ?=
 =?utf-8?B?TzJ3WHBFOEhmdnlYZ3FPTko5S29xbnYwdU94b25WczhOb0JGb3JBMllaUkN4?=
 =?utf-8?B?SDJITUx3OUpRRUtKMG9TNVR3UGNsbGJmQ2pxcDFrNVM4TEN1WWFUYVRWZndm?=
 =?utf-8?B?MmY0OUhzdXRaYVk4cmtZeXovMjRIRDYxNjRoNklibzhJUVVGNU5ma2hneEF3?=
 =?utf-8?B?NXZRRFR4K0VnVkpwSC9qYU9lMnd5YktyZ0FoaFNXOXhuTmlSbU5HdlBCdkZQ?=
 =?utf-8?B?UFlsNDVLaWlkdmpqeU9WUWVOMUpESlFOWCtPeVhmMVgwMVdVTUY5YXFQL1My?=
 =?utf-8?B?UjFzdUZCOHNzTUE2RmQ1RmpseHcxZ3MrK3JyTXAxanQ2UGwzUVFnOUVzQTdT?=
 =?utf-8?B?S2FrdkZiaGpoQ1RhS1Z1anMrRU1mbHpnY1F4akhseDhNZURXQUNqVDFZeC9P?=
 =?utf-8?B?TkFZdmZZaXQ2bFhHbWlKdWZFVVlETUlHWGRkSFB3NGlPdHdLVzM5V0pkWGR3?=
 =?utf-8?B?SWxpQXEzNndHR1B0OFQ0cEQ2dzR5ZU15NzYzeVNmSjFaa0E2dnVHVTVaWEtP?=
 =?utf-8?B?RTZRMEZxa3oxTGVwenRjN3B5VEowMktjcGt6dHBNTWIrT2RxTll4VGtKV3VD?=
 =?utf-8?B?a25WNkVpOWx2ak9KcGRpaVkvQ0VHUWJRNDJLOUtMRGVJVGFZNExZNlZIZlNm?=
 =?utf-8?B?UzRyLzVUOG5pWkhWNHgyK3NYa2tXZCs3R09qMCt5SUg2VGpzWTRuVVVRSHBW?=
 =?utf-8?B?SDdwTjhBMnVtTkNndE1UZ0I3eHg5T0wyUUZCLzE1RS80OU5wNWpZMkNKTHkr?=
 =?utf-8?B?bTljaitNblE4Nnp3eTdVeDhkUHFyYkM2bUJaWFJSZVJ6eVBLVEVyZlVqbndN?=
 =?utf-8?B?S1FORDQ5OXZGMXNCTDNjMjdtczdyeStBeUt6NldlVmxFT0tUTGVFbTlIMXR3?=
 =?utf-8?B?T0Y2cUVzZ1JlRzlPZzU2T0hQMUdmUzU5L0l0UWhBZmF3cHJNMU1Lei85bVhm?=
 =?utf-8?B?dHhqcmIwUHJmbHlrOXF4RUVSNXdEbE9SVENlVDNUK1ZVTHYweTJSWEo3Vkpk?=
 =?utf-8?B?Z2ZLenR1SUN2bWRxSmd5OU84bFpKS1FIUFdKZnRobklOSVFFRmxNS0NCQ2sw?=
 =?utf-8?B?OHh0QlNrczhvcW8vTlV0RDJaTE5Mdm1CbmFTNTl0TzRYMDQ0YU13Q1FSVXNK?=
 =?utf-8?B?V0x6bDBnRU0zampjNmQ3bmZ5V0l2cFpITnAvQUdSODgxTGwxMFU5cU1DdW1W?=
 =?utf-8?B?NUVpRDdpYk5HYWJwTFpBbEprR2FZeU1CL05ySWFWQTZnOC9DSTB2aDJVTDdi?=
 =?utf-8?B?Qko5T0dXYnlkNW42RWZlbVFZb25TZnZWMzdKZ3BacHZHdUd6YnVFbHVBOGIv?=
 =?utf-8?B?Wkh3VEIxamJaRGloUWQ4QTN2czVKa0NMZFlya01DS0tiN3JvbVR2WGRQcGNw?=
 =?utf-8?B?Y1Y4VFg5eGhXQ0VMRVIybHpUaFZ0VWVURWtMd2dGdFJ2SVFKTzNtRzRsbkd0?=
 =?utf-8?B?TGZSeUNTdTV6ZDYxWjRTR3VCQWdLdDIwaUZzWHpuQ3d3NmpOSnVoMVZHcXFI?=
 =?utf-8?B?a0tSVUkwRGRtSXE3djN1eUhpQnBoOEJZOTVzTm5jZzNIOEFHTS91WGE2dFZ3?=
 =?utf-8?B?QkpFSlk5S3VocU9aaGVxUkl4N29sV2hxbUlqeDRaWEtNbjZ5TCtTdjZyTXkr?=
 =?utf-8?B?RW5McjFMSTVuSlp2REZZY0RoR2NnSmZvdCtUSW1yZFZHcUZoNGRDeDRZdnFR?=
 =?utf-8?B?eXVNZFdBZFNQdjJlOTQ1WXVvbWpBSDk5UjlFaUpxQndycXJHK3pURTNZbGNJ?=
 =?utf-8?B?Zm5iTWk5bXBtWTUrTWpwaHhwRFJ4RlFYQjZHWlk3UGljQ09vajZzc1BDbzRN?=
 =?utf-8?B?NDkrRkdvNXh3MXQzQXJMOUx2RHFBUTNyOU1MRk9aUFBSRndaamQ4clQwalNP?=
 =?utf-8?B?YjdyRHBXQ1lWcmxCeEtFOVlBbS9FN0NPMmtoQUNDMTZSOVAzb0JTcmNmeVJK?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B73A99327F94B142A559BFE7A29C6201@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TjTpVHgJaEl3SbtDRdKQHWrxowXjfT4ASeqEm4hOeCehUvF0lax5wKli2UM0pkJ3pwLc73luXyxS3UUYZyMbl3muwjWsST6vYJdXNLXGfOqw139ed0WBSZTQ6NIpIAiqI8Ae0Eq8qGTLXBulp6sKFluexoPlkU1tcPgH/nKlzWn48rntS3hNlWBj2Qf5FV5TQt/594N71bMOBpkFhG6JIA0LOoF79I+lE1hyWQtEenTHcGVvb+yAmeOfkr30qSGO9zFWrMRZpnQlbwt8jGgjLhP6pgeWapxscrMQDvPHLJgedOlbQ+PJ/Y8aysSzQJlubaCDGufxGNzvN3jcguWDltLlYLXrnijYG1Msym2wfOIurWZ0WWP+aHe3hJZPTQks/XtHwYnUu8HgoF0MXNjJgTBJO1tsD1EfUC9FgFlmRvu9J+Vb1XVfiB/AmFB2Ogzp6lVx1tkAKWqv/atpJ7V5IivCTtL8JLVy89K7IjMpWhMurC6hrF2VbsCr21xNdQ1cKGXrJ1f0NfuFVu3V65MKMHzdnJ2uURCOMCBWUUjx7LRQQw97JQDsuD9xgHcjmyz8mdr739y1atzX4ml2Zd1YAFveyW54JFHu9iQQ3V363GaCo2l85nDZifKGcJU9AyD8
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df905bea-5766-475a-7448-08dd60473a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 02:48:39.5872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5bbyjhUk9J9q0vIZb4r/EuG+Au5m+DkDGvqiV6HVP/N2Mc1DBxTBa7yxOK2ehVfbBcYvBJ8mdB1YEfc40V86Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6847

DQoNCk9uIDA3LzAzLzIwMjUgMjM6MDcsIEdyZWdvcnkgUHJpY2Ugd3JvdGU6DQo+IFNvIHRoaXMg
aXMganVzdCBzb21lIHNlbWFudGljIGNvbmZ1c2lvbiAtIGFuZCB0aGUgcmVhbGl0eSBpcyB0aGUg
ZHJpdmVyDQo+IHNpbXBseSByZWZlcnMgdG8gdGhlIGZpcnN0IGRldmljZSBpbiB0aGUgZmFicmlj
IGFzICJUaGUgUm9vdCIsIGFuZCBldmVyeQ0KPiBkZXZpY2UgaGFzICJBIFBvcnQiLCBhbmQgc28g
dGhlICJSb290IFBvcnQiIGp1c3QgbWVhbnMgaXQncyB0aGUgUm9vdCdzDQo+ICJQb3J0IiBub3Qg
YSAiQ1hMIFNwZWNpZmljYXRpb24gUm9vdCBQb3J0Ii4NCj4gDQo+IFdoYXRldmVyIHRoZSBjYXNl
LCBmcm9tIHRoZSBzbmlwcGV0cyBhYm92ZSwgeW91IGNhbiBzZWUgdGhlIENGTVdTIGFkZHMgMQ0K
PiAicm9vdCBkZWNvZGVyIiBwZXIgQ0ZNV1MgLSB3aGljaCBtYWtlcyBzZW5zZSwgYXMgYSBDRk1X
UyBjYW4gZGVzY3JpYmUNCj4gbXVsdGktaG9zdC1icmlkZ2UgaW50ZXJsZWF2ZSAtIGkuZS4gd2hh
dGV2ZXIgdGhlIGFjdHVhbCByb290IGRldmljZSBpcw0KPiBtdXN0IGJlIHVwc3RyZWFtIG9mIHRo
ZSBob3N0IGJyaWRnZXMgdGhlbXNlbHZlcy4NCg0KR3JlZ29yeSwNCg0KTWFueSB0aGFua3MgZm9y
IHlvdXIgZGV0YWlsZWQgZXhwbGFuYXRpb24uIFRoaXMgYWxpZ25zIHdpdGggd2hhdCBJIHVuZGVy
c3Rvb2QgYmVmb3JlLg0KDQpUaGFua3MNClpoaWppYW4=
