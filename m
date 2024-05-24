Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038C5A79B
	for <linux-cxl@vger.kernel.org>; Fri, 24 May 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536007; cv=fail; b=K4biv3fzanbA24djbdUoNDKRgFDlYpDudshIZ/+JcwEBjI1BYAtOadRk3tDEFKd0Vp6W545d5/8MJiVWNCh+Ii/atm7E6bLVo8lqm62FEtjl1NPVsG8GmnTWMFT+FoBCNGq5DkfRmJnVss2JHwZriQOuGe7Py5nXqcPrWC8p0N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536007; c=relaxed/simple;
	bh=jDSTBFb5gdcjTYhg9q5SaJ36YUmov5BU4uuIl+baAaA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P50SkjnAzyjC4ny5whuGa5XXY/Mk+AsKLStnbjQKa0cjp+IVpMJZFFEzdxJx0WqiFkGtM0F9BlI6lIhI61Oqj/0h0JyixBxjI70Gsvv2/fl0wTHN7Jc2tWmg0Q/KYajIPJcXXftoKSBKnLm/iUrfsZucaqbZNmXDoWcQaE0WR3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ueY+b0uw; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ueY+b0uw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1716536004; x=1748072004;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=jDSTBFb5gdcjTYhg9q5SaJ36YUmov5BU4uuIl+baAaA=;
  b=ueY+b0uwdxkj6M0mNOGE8yXqwLyCFwyDskeQ9wjt8rrs7ayiPEPKCKIB
   RvsbA1v80/qHbIO4Jh0sngmi1r/8IQfQHzIcP+MR/a7t7OiQjI3Ej1hYC
   ilQTeaiiRwo9oikghiZtyq28gU3XiwB+OZWnwzKi/aRLRXADolFvbkBfA
   tKsHWwnSSbgwHoCDu9fSOaip1n1+xuKjAo1X7+JbZ0CVwxuLN45qTLXHz
   9eIb+gnF1tph2AJmYZxVEBWu5MmNykq/3fr7cKX+MwpOFPpK2Yrtaki8L
   tKsFJx5DSgvPCWs2t/vjDXAE4zupQtsuw/6PbP9RMOPbndPW+jAK7/sUU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="120353101"
X-IronPort-AV: E=Sophos;i="6.08,184,1712588400"; 
   d="scan'208";a="120353101"
Received: from mail-japaneastazlp17011004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 16:32:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaZhxxRQo/lFbSrreY2oUDmFcjSaF8TOEx9uixyml85ZlXxhHaITen5LU3YBq9zE46ha/MaaIcqpl10AHzv7cfh08FsBswiHVGdcjMZbg7YjXDdbpL2SKKrUL33DP8zLwQGnlUTRHeC7GM5+BU4FfDPMX4YHzex6Pel9v5SCvCHNmoMdG0Q06V/9+MZFAb9Y6tiCk348rFaOH5YnZRhX93vhdrCjyPmbVhhgI+dccDcA2qpwhHdZ3N6ExKr067kjaRp48+iILBqpiKonYC1IDNFhXkgLtundaHZgfiQxVCCQtKD5Jz7luDKSSFY/KV5skGyF8OCXguizbGvYubMAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDSTBFb5gdcjTYhg9q5SaJ36YUmov5BU4uuIl+baAaA=;
 b=aMC/vXgzyC7sMOxwddR6P+BF9L6tmsgMqnrwZgkNKCovaUP99lMRilxf9qoPfTRWUumosZJRtH4bwHtsPzNLbF6NcNyHR1ubBk9LuXEjXrQ6mY4MGUOPMfrQvc4KIgEtvZy+mHNlSBkxtiuMnbsHDP5O+hGDVyNUXza2ztBVEX8hEshJQyrxUkbZbt4IRDK0LeOTt4uW2eulFW3yuOz2nn65GY0LS4m/J8Fn2c0CsMfTZ1M4E4bJwbiX3RKnoPhVebeLhrgDVysve/zRwFm77hwK9zCphH9NuabIx9Kkyqo02TgkIdUuojXPmrMYXTm99cDmr4GQkCNIPjLOaI53tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB9606.jpnprd01.prod.outlook.com (2603:1096:604:1c8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 07:32:08 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 07:32:07 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "members@computeexpresslink.org" <members@computeexpresslink.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: CXL volatile memory: How to restore the previous region/Interleave
 set
Thread-Topic: CXL volatile memory: How to restore the previous
 region/Interleave set
Thread-Index: AQHarax7vZq9IL+jF06rZcpjK4vT9w==
Date: Fri, 24 May 2024 07:32:07 +0000
Message-ID: <36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB9606:EE_
x-ms-office365-filtering-correlation-id: 145ea688-3f5f-42fc-2a38-08dc7bc39df3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|376005|38070700009|1580799018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1B5bDF0ZnpwRjRNWVhCV3FobHlzWmNwaURpQzVBUWNMSUh3QVF6VXJFWFhJ?=
 =?utf-8?B?L1pDNDI5ZUVRVlYrcUtNRkNaN2tTZzJiYlZqMkZuZGpzOGhkVFlCUHBGZExw?=
 =?utf-8?B?VjBuTFlIOTZjRzNsZnVwYVhkVmRXUkFXY3Z4Tk1kVFNoNkpwZ2JzS0RZdEZW?=
 =?utf-8?B?anJyVWFjM0srM3IxYkFWTThSRnBWczROdFFBcllncWt0TEZxZFZYTVRIS0lN?=
 =?utf-8?B?ODhlSHZMck1uUE1sT3VXZE5IdjRHdVh3cU5EdWVuZlo2N1EvbnVhaDNtY00v?=
 =?utf-8?B?YWJva0orYjd5Y0VyOXRQZ2FJa2VySFZqdGdzenNWdm43dm5INTkxNERoUHgv?=
 =?utf-8?B?UHFSMmZiM3ZvQjR3VFRTWmtPdW1XYXdOQXM5dzRZSjFGV1VsaXFBNzFoK1Rl?=
 =?utf-8?B?UXJsQ2JGNFBTcDdxZkRBeGNDWjdtL3kzUWQvQWgzcDlkSEZFRTlSRmJZanoy?=
 =?utf-8?B?WlhpbjZ5d3JRM0xkL1JrSlBLZTVMbUdmQ3lDQXVUMWlNb3A4d2x6ek1NY2k5?=
 =?utf-8?B?MENJUU5hL0d6K3BySXo1Vko1NW80cHdkOGsxYVo3REVSRzV1dGp2N0dsdW10?=
 =?utf-8?B?TEUyRnVoWktjQzhSeFJrdGc2cnlyakNqWmpIWjVKc3MxR3paeGw1UE5ZOHZY?=
 =?utf-8?B?MkZxLzhuWGNwSEJPWHIyZU5SZjljQkJUdHBhdnFQRVh4eWNKTFhWWDZpTldx?=
 =?utf-8?B?K0hOVUlKd2NnMnM3QjJNQkV3Y0ovc3R5ZTZGb0VNdzJCZ3VyTFV3N3VqOFhw?=
 =?utf-8?B?c09Zc0ltWTUwT09sQUt0ak9nNGdDdEorMysxL2pMcUY2SDNPVS9lNFgwR3c0?=
 =?utf-8?B?bXA4Ny9uVmZHM3B6aWprQWZBVUhzUFYzNXNSRjRzWGV5V09wOFUxUlE2VHdW?=
 =?utf-8?B?cVZvaFBDcFdUWWRwSDJpVHhFYitlTFZDY2lBNkhTdkVhM2xCWXVreDVUbk15?=
 =?utf-8?B?b1BqUXh3U2RIL0x6cllRMTlvdmwzdjR2UzdrbTNwTWpleTdrWGJJSForc2RF?=
 =?utf-8?B?cG9QYW02a2tCWVlLTThSYUxRWXMxMGx4TEM0VWJhSVlwaGhVa1I3WTliaGtN?=
 =?utf-8?B?dnRJY0JoUURaeUsxc2dUMGdaQkNla1htdGlhcFd4MVdlMTgvLzJ5eEZrRlM1?=
 =?utf-8?B?S1JMcGViZVlYYU15VktzOEhHL3R4Qm9QYTdOQllMcVJKK1hsQlRtcy9pbFJk?=
 =?utf-8?B?UzZHYWlPTExsTExReGVjaWtybzl3dDA0RHlWVFNmdC9uWStGVlllb052eERV?=
 =?utf-8?B?MTNVM3pSdlUyL3RyOHh4YjJPRmNYTGlBSjZUS0xTS0NOMTZFUkpqVmI4Qklo?=
 =?utf-8?B?eERKbDl6TlY4TXYxZzdtbkt6M28rS3FaZnduSlF2bjVYdkowSjhDQWV3WkhM?=
 =?utf-8?B?aytpeDNySzM3VS9zUERaamhXTC9iMWxqQ0p1bWhCOE1ydEQ5aUlONndwOWIz?=
 =?utf-8?B?b2l1SnhRdHZDMmpkdEJmaUo1dEdFYXlPM1hJSjJicGV1ZXFtOVZzUWtvY0hC?=
 =?utf-8?B?R0FobkhFbDFZU0hicDMxbStNL3Z6L2ZzcjBUZFF1NGdhc0k0VnYzbVRnSXRk?=
 =?utf-8?B?cGlWL2pidUJ1czNVKzFrblJJbTJwZTJ4UXlJVHMzSTd5SDYzWE1sa0JTa0xN?=
 =?utf-8?B?SXEyZzFXNjVkclJkSDlkM1NLeXJtUnhxVXJLeXBHUGJQUzA5NXgwa3JIbTJa?=
 =?utf-8?B?U1RBY1grNFkxSUtYaExIK2h0OTNlbkgxQUN1cERPSVVGYnhCeVUxc1E5SmJZ?=
 =?utf-8?B?aXl5VE5BTTNxZ0Rzei9qYXlaRmJRVFhURDVGK2NNeEw5M1YyT3RpRFdldFdi?=
 =?utf-8?Q?X12QUnu8afEFdYipiTG9JmzNRiXz+ruYiNXsU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGVNVGZzbEhqQjNoMFNlS2J3OFVtZ2lsR2MwR1d0QjZuNFFyOUxlZ2RLS1pw?=
 =?utf-8?B?WlBYaHVWSWkxWHZsaGRhTER3bkJYdXVHOTlKb1dVMWtlSGVPMm41VHVaM2hX?=
 =?utf-8?B?TWZGQ2lwUEZuUGxWMEJ2OFYvUUJLb3lFcGVBZW1ITHlZVVRoOU95MUJQamlz?=
 =?utf-8?B?K0t2WEhDRy9ZNVE4ZXVhbDRONnA0Tmxsc0tRY0JFYVNVaWFYOGs2RlI5R0h0?=
 =?utf-8?B?a3VtWEVtaGV0UlYvWllrRktsbGR6aVFaN3NkQUQrZGIrWXhpVmZYVjlOSGRC?=
 =?utf-8?B?T1czSnhKc1AxYlg2cnBWZkswWlZKSjU5dmhzRlVlY2tMZWsyOTFsbkhDU1RT?=
 =?utf-8?B?MlN2OHJNc3cxQjczeDBsNUZlTkhIWlh2R1NIMEFlTzVlalNMcFpqcjZmd29F?=
 =?utf-8?B?TGthakkxMDJ3bHlHY3pKMjJyUGg4WjNiYlhvT0xBaHBLNmxwb0d4RnZSVSsy?=
 =?utf-8?B?ZDlsT3k2dTVudzc2ZXlLZzZZM1RlcU83MTdwSDZGaHIvb1RRY1ZjTkhva0h2?=
 =?utf-8?B?blhCK2ZLYmJodUpnOXFxc3hmSkoyVlpoWE51L1JMZCtLK3luRVhUcHZ6dERi?=
 =?utf-8?B?K2Q0T01qWDFUZ05ONUI4VTJxTmpVSk5zYUJjL1ovRkVLRlYyQlg4NERSZ2lV?=
 =?utf-8?B?Y1kwa2E3Mnk3VmlvTlJpbDdLNm5tYlFXa2FGNEhYTlphYTNQTU1kaGNSZVZz?=
 =?utf-8?B?dWNNNUtUcmgwQWYwK29GZTF4elJ6Y1czMEpMck5kL0t1TWhpSDBtRWUrd1FD?=
 =?utf-8?B?aWdUMUxqem82dnRCNERuUEFXbEVCaEhMSWs0cTZKWmpDajN5RVB0YWlHVlpy?=
 =?utf-8?B?dmEwS0RJUVBWVCswbHc0VEwzeHQrNythWm5FRzc1NTZqNVBSd2FBRWFCa3B6?=
 =?utf-8?B?NG0zclkxSzlralVTK2VRWkpoSDUvZk15aDBlcWVWZVFqZGxNVUpJK0tIeUpo?=
 =?utf-8?B?bmhXVTNwSGcwSkE5eWF2RUFZcG1QMk5wWmRKV1FEbnQxaFhhYkREYWsxWGty?=
 =?utf-8?B?U09PRG9zazZpZHcwcVNrT2NNclBYLy9UakJtK21PaHRJZWtqTGQwc016cUhh?=
 =?utf-8?B?YmlSUDlFUFZaaktXaTRnRXdBL20yY2dNSTBsbFJqeWROcGY1dkdBNktJMFRx?=
 =?utf-8?B?SjU0aDN0NTVoWUJodmF2Rk8wclZGTmJCQ3hMMFJ2RnNOUjVnQllMYU83VVBM?=
 =?utf-8?B?bmhPVzFwcWFIbVVkNER6WTFwNE1nQ0dkbi9ON3VydzB0cVI0enJIeEVDYndX?=
 =?utf-8?B?b0Q2SElpS1phbG0xSGhoTXlTcHVFWS90dmw3eGcxTmpBYVg3UlJqWHU4cFZD?=
 =?utf-8?B?U0h4bHJyZFlXY3pkbVREWitOVVNBYTdZcFVQeTl4VWRGV1kyZml6czl2dnlm?=
 =?utf-8?B?MWZSYTRQY1JWSkhiUjNUWVBXdmxMUVZFdSs1REFFSGRTckdoS0RxeE9hbnhN?=
 =?utf-8?B?QWtZOSthL2ZKV1ZrZzQwSm5BbHhFUHB3LzlJT1h6aTBxVTl1N012Z0NOdjQy?=
 =?utf-8?B?bkpVVFdDb1ZxV0N2ZHFMWmROazVPSlkzcUs4emNPVTlWY2NsSDExUlF3QWEx?=
 =?utf-8?B?cmxaZTE2azhTNDVGYnBqSkRHYjNzVHRhdVR3empmRVVnc1hPU1NxMzFoT2ta?=
 =?utf-8?B?d2JhS2xwdklyeEU0OFdDTXJMbkw3ZEhVWnRScFRaTWdGcWt5aDRkSitjMVBQ?=
 =?utf-8?B?ZXFDb3d3OGNTcnU5ZDEyWDlFRUIwVWdmWExsQTBvTGtybGEvNVRycm1jVy8x?=
 =?utf-8?B?NkxWczlEZStBNnk4b001SHJHZTRBejlNcnJNcjlJVmpjUWtpSHd2NllCYzM2?=
 =?utf-8?B?UzU3SytaRmFORUdoNFh1Z28vdXdNdE1rbnVBTXE1TU5uNTdDTkN2andmSXJQ?=
 =?utf-8?B?VDdnVnpaNkllOFZXOGoreUFEVEk3L1BQNlptdzJpT2xmbGlGcHJ0b01wb09D?=
 =?utf-8?B?NmtKZy91YVFFY1R1M1VuV2dUL25KUWlaUVg0NjlZNEpwT0l3Tk1pSFY3b2hm?=
 =?utf-8?B?Q0R3L09mVVBxTGtvQ1lQNlZ6VzQ4bGVYVGVFc2NQZVVyKzAzRjhZUDZDUnBO?=
 =?utf-8?B?Z281dWtOa1VIajhkNFhFamx6c0ZkOVh2Rk1jbkdkV2VzM096alR3b0RPcnBs?=
 =?utf-8?B?bDBZL3I1VmFwcy9DVkx4cjNQWTFudlM1aUZZc3JRU01UVk1PVmJ5enZBSXVz?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BFD6F9378A6C5478355D8C2DDF5B73D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1JgjpcRy6+x0dcGVhst5v18+dCUM9quyu6WLe1ZNCKbw28dTiFI7o0b6KC8gKGf8csPoAc83VQwkGeMDNHOwhj+TmL3BofY/ZPhr5LRwkh8XPqxQreE5xwPek3mUmf3uRqdi1ySc9CGSeMRDkqDU7zIZ1d3SdMU1kQe7NQ6zdMDrY/FQWY0bIfSOvCjIdi560yyo1tlXfW7ffX/sgTr/dMq/G10nKS7onmLTmD3RjvNWgIOG40H2Ogg8+VVvPrhH6D2NW3ZE2ezRYpi3VZPW51QWZWl74vvShMWk0OGaj7Z3IaThYurK8eTOa18cx3318+JDbM8ToLdZbSWnz8eDiyfc48mBTSWj4fANzL63J63tt1nIqyMSLuRBhJs7GEqjtfGj0Zd4QpiKcqV3dZl5ucIvetLD894/UIXDaXSFZ4kj3kJUdgwmfuYxtPuMhX9jEYKtG6GDDd8i8MWfePGllazltt+3t6NFijTQmU8B3j21py5Hjw+sjlmylIAx97DiyA0WMfw7qK1iCKZA/v3vO24WYT7rPCIl+P+dJ0W4lkPwAhdVSAEepdTlltvcUyAjFetawok0s9kkuKbRx6DViULqJ7Q+VVXr6NyEFJUF34vskgbQq9yJhChcblRBXmE1
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145ea688-3f5f-42fc-2a38-08dc7bc39df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 07:32:07.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kH2b1s1EFCt3kUEnxt8TNKfyUvaBz98HL4v+jDOsukRDO1U6ygok9ZInaHd5SkwXTmAcxww9Nnj9CsPe6uFa2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9606

SGV5IENYTCBhbmQgTGludXgtQ1hMIGNvbW11bml0aWVzLA0KDQoNCkkgYW0gdHJ5aW5nIHRvIHVu
ZGVyc3RhbmQgaG93IHRoZSBjdXJyZW50IGhhcmR3YXJlIGFuZCBzb2Z0d2FyZSBjYW4gd29yaw0K
dG9nZXRoZXIgdG8gcmVzdG9yZSB0aGUgcHJldmlvdXMgcmVnaW9uL0ludGVybGVhdmUgU2V0IGNv
bmZpZ3VyYXRpb24gZm9yIENYTA0Kdm9sYXRpbGUgbWVtb3J5IHVwb24gdGhlIG5leHQgYm9vdCwg
YnV0IEkgZG9uJ3QgaGF2ZSB0aGUgYW5zd2VyIHlldC4NClRoZXJlZm9yZSwgSSBoYXZlIHNldmVy
YWwgcXVlc3Rpb25zIGFuZCBob3BlIHlvdSBjYW4gcHJvdmlkZSBzb21lIHN1Z2dlc3Rpb25zDQph
bmQgdGhvdWdodHMuIFRoYW5rIHlvdS4NCg0KUTEsIEZpcnN0LCBJIHdvdWxkIGxpa2UgdG8gYXNr
IGFib3V0IHRoZSBzY29wZSBvZiBMU0EuIEFjY29yZGluZyB0byBDWEwgcjMuMA0Kc2VjdGlvbiA5
LjEzLjIsIGl0IHNlZW1zIHRoYXQgTFNBIGFwcGxpZXMgdG8gQ1hMIG1lbW9yeSAoaW5jbHVkaW5n
IHZvbGF0aWxlDQptZW1vcnkgYW5kIHBlcnNpc3RlbnQgbWVtb3J5KSwgYnV0IGl0IGRvZXMgbm90
IGV4cGxpY2l0bHkgc3RhdGUgd2hldGhlciBMU0ENCmlzIG1hbmRhdG9yeS4gTXkgdW5kZXJzdGFu
ZGluZyBpczoNCi0gTFNBIGlzIG1hbmRhdG9yeSBmb3IgcGVyc2lzdGVudCBtZW1vcnkNCi0gTFNB
IGlzIG9wdGlvbmFsIGZvciB2b2xhdGlsZSBtZW1vcnkNCklzIHRoaXMgdW5kZXJzdGFuZGluZyBj
b3JyZWN0Pw0KDQpRMiwgUGVyIENYTCByMy4wICI5LjEzLjIuNCBSZWdpb24gTGFiZWxzIiwgaXQg
bWVudGlvbnMgIlJlZ2lvbiBsYWJlbHMgZGVzY3JpYmUNCnRoZSBnZW9tZXRyeSBvZiBhIHBlcnNp
c3RlbnQgbWVtb3J5IEludGVybGVhdmUgU2V0Ii4gV2hhdCBkb2VzICJhIHBlcnNpc3RlbnQNCm1l
bW9yeSBJbnRlcmxlYXZlIFNldCIgbWVhbiBoZXJlPw0KLSBhIHBlcnNpc3RlbnQgSW50ZXJsZWF2
ZSBTZXQgZm9yIENYTCBtZW1vcnkgZGV2aWNlICh2b2xhdGlsZSBhbmQgcGVyc2lzdGVudCkNCm9y
DQotIGEgcGVyc2lzdGVudCBJbnRlcmxlYXZlIFNldCBmb3IgQ1hMIHBlcnNpc3RlbnQgbWVtb3J5
IGRldmljZSBvbmx5Lg0KDQpRMywgRm9yIENYTCB2b2xhdGlsZSBtZW1vcnkgZGV2aWNlcyB3aXRo
b3V0IExTQSBpbnN0YWxsZWQsIGlmIHVzZXJzIGV4cGVjdCB0bw0KcmVzdG9yZSB0aGUgSW50ZXJs
ZWF2ZSBzZXQgdG8gdGhlIHByZXZpb3VzIGNvbmZpZ3VyYXRpb24gYWZ0ZXIgcmVib290LCB0aGUN
CnF1ZXN0aW9ucyBhcmU6DQpRMy4xIFdoZXJlIHNob3VsZCB0aGUgSW50ZXJsZWF2ZSBTZXQgaW5m
b3JtYXRpb24gYmUgc3RvcmVkPw0KUTMuMiBXaGljaCBjb21wb25lbnQgaXMgcmVzcG9uc2libGUg
Zm9yIHJlc3RvcmluZyB0aGUgSW50ZXJsZWF2ZSBTZXQ/DQoNCk9uZSBzY2VuYXJpbyBJIHVuZGVy
c3RhbmQgaXMgdGhhdCBpbiBjbHVzdGVycyB1c2luZyBhbiBPcmNoZXN0cmF0b3IsIHN1Y2ggYXMN
Cks4Uywgd2hlbiBhIG5vZGUgKHdvcmtlcikgcmVzdGFydHMsIEs4UyBpcyBhYmxlIHRvIHJlYWQg
dGhlIEludGVybGVhdmUgU2V0DQpmcm9tIHRoZSBkYXRhYmFzZSBhbmQgc2V0cyBpdCBmb3IgdGhl
IGNvcnJlc3BvbmRpbmcgbm9kZS4NCg0KSG93ZXZlciwgZm9yIGEgc2luZ2xlLW5vZGUgbWFjaGlu
ZSwgaG93IGNhbiB0aGUga2VybmVsIHJlc3RvcmUgdGhpcyBpbmZvcm1hdGlvbg0KaW1tZWRpYXRl
bHkgYWZ0ZXIgc3RhcnR1cCAoYmVmb3JlIC9pbml0IGV4ZWN1dGVzKSB3aXRob3V0IHVzZXIgaW50
ZXJ2ZW50aW9uPw0KRG9lcyB0aGUgY3VycmVudCBTcGVjaWZpY2F0aW9uIGRlZmluZSB0aGlzLCBv
ciBkbyBvdGhlciBDWEwtcmVsYXRlZCBmaXJtd2FyZSwNCnN1Y2ggYXMgVUVGSS9BQ1BJL0NGTVdT
L0ZhYnJpYyBNYW5hZ2VyLCBoYXZlIGVub3VnaCBpbmZvcm1hdGlvbiB0byByZWNvbnN0cnVjdA0K
dGhlIHByZXZpb3VzIGNvbmZpZ3VyYXRpb24/DQoNClBTLg0KSXQgc2VlbXMgdGhhdCBMU0EgUmVn
aW9uIExhYmVsIGhhcyBub3QgaW1wbGVtZW50ZWQgeWV0IGluIGxpbnV4IGtlcm5lbA0KUmVnaW9u
L0ludGVybGVhdmUgc2V0IGFyZSBzYXZlZCBpbiB0aGUgcnVubmluZyBrZXJuZWwgbWVtb3J5L2Rl
dmljZSByZWdpc3RlcnMsIHdpbGwNCmdldCBsb3N0IGFmdGVyIHJlYm9vdCBpbiBsaW51eCBrZXJu
ZWwuDQoNClRoYW5rcw0KWmhpamlhbg0K
