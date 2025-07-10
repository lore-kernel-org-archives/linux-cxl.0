Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E046D220F37;
	Thu, 10 Jul 2025 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752182139; cv=fail; b=AumGVLbskn19TjnmEjg93wGZIwXuAeX3gjf+7K+bFtb5tSZ4gnKhZqXlAx7b6MBY+Yp+Kzug5PpVRR9mqzJueAQUM6GHkfQIjx0ybsODmNBOw0Apo280+8RTuz+SDA7HTE+k1u6GadvdYitooHIYPX2fVyTB6dAZ1J6NqCzEEMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752182139; c=relaxed/simple;
	bh=ysruLu0LzN4G+Hw7uvc5EQTLzL4f1GvQJ1fy/y3huho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AKwzuI4mXe4F3sQVuxef8qoyy9+GRHgHSj1iYAnzKOPQaYHGiwy3oOQeduoih9+jyZC8iqOvTNmB9mtdwox+LZYJCz30DXQsIOWCKGSGXSUar2NPlMwpf1RKMtYuWWsWxsfcJy6Qp+RpbswcvofEyn1+jlcAw96VxvxGJfPs7O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i5AbvNiJ; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i5AbvNiJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETXQhA3BCkBjSRge+LBg/AsT+0MsCviafKmHgN7U8fk77rSGtQAILBih8WXytsVTbZp3Toud74JGGyT5waQ1mz9UrII5oIs9H6l3StJv5Ixm0gr2Yk1ExIct2kdnYW+dVBubZkNgL+gnCFyg3XHvrERL4lIEbuZUnaI7g9b+GIdGXrWEwFPtl4paIPwvHA0vVup+m+OxUsNiAtwQqAqE/LcTFbm+/UZjHudWK3g5fnOs40LJnVcyOvDuojmHHwv6waFQijGOOeMOnO309eQ6ql1D8WCu9JrFzduzJOCVWaGRk1L6hkvIxnkSX5Qwfvnx7rqIPIdCBkl2WbZKZgTd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt9NDaOOyctuuy8h24Rza9sPh3qyMJ2W5JEj4e9d7JE=;
 b=LBYILsczroOvG71TVKvHAf1sOLhHr5Sr/K5QCmFXfE7AA7YaSMhMRfQS9I0Ct/9ZXGIpaNG1QU5eNEl6yK1o0AGNI1jYMFYqYaIkYC7Pnd0JWuPxUsbwjFOBxlwsZ/K0zn8wwyI299uaC6IbLoz1nR4oZx28u+70oe6bxcJZORlj2CtTJGnMCaeR5YVMxQZV+utV3fz8ObzbZUBTuq/Ip4iCGDfL76lOlgJF2wiqpf0dt7dFPk8oUVMHo0S3e52xiWq2S51bZWGSNG4UxxZJDTw9SVRXsbwTbSI0DqWv11dQTNE1pkN0YKbnO9T7q3uhCaASX0A0TooS0+RhhHM/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt9NDaOOyctuuy8h24Rza9sPh3qyMJ2W5JEj4e9d7JE=;
 b=i5AbvNiJPZBMCe1vkVgWuGcGkScC5hwm/cZI2j7IdTo1KCtm3JvySmxnAnssgVh7sFW1zgH4KkA+DIaEV52HNO56+M1TF3fTnmGJNKLdcTyerQHrousStJ40/bkyPWod237zr5pSuk7NiLxqqv0VlKrb80nmill9ZMwinGSS96w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 10 Jul
 2025 21:15:34 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%3]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 21:15:34 +0000
Message-ID: <2296acdf-de5d-4591-a165-d59f9f432dee@amd.com>
Date: Thu, 10 Jul 2025 16:15:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] CXL/ACPI: Remove overlapping Soft Reserved regions before
 adding CFMW resources
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "Koralahalli Channabasappa, Smita" <Smita.KoralahalliChannabasappa@amd.com>,
 "Bowman, Terry" <terry.bowman@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 Robert Richter <rrichter@amd.com>, Gregory Price <gourry@gourry.net>,
 Fan Ni <fan.ni@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ad410c59-bf0f-47ae-aa65-c0d845e6f264@fujitsu.com>
From: Nathan Fontenot <nathan.fontenot@amd.com>
Content-Language: en-US
Organization: AMD
In-Reply-To: <ad410c59-bf0f-47ae-aa65-c0d845e6f264@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::33) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b612887-90a8-4863-20c8-08ddbff6e88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2VNY3BTaStiZGRTNTZncW9vN0kyQU9aV0xNREpQaWl5RkZhMklsUDZYWXd2?=
 =?utf-8?B?Q0UrdFVtb1VZd01yQzl6N1pjY1UyN3h0bEIrTUNLZVFyQjZVNDUyeXRNU2kw?=
 =?utf-8?B?ellCR0l2YittR3I2cDQvNlV4MDExODgrSWVRcG9XRlNhOXVUenhWMXEyU0c2?=
 =?utf-8?B?bWdzb3ZVZ2lPaUpyMWJ6VjRBTVFYWnFEU0hmUkhFRy80L2dXV3RnTFFBcW5p?=
 =?utf-8?B?TUtjL0N4bkFycy8weERjSXlrMGljVXJKL085SmY0SjhNelMxU1dGL3FRMVRF?=
 =?utf-8?B?U2x0aHdsSUVZLzJrMlNCUk45cDdNNXdWeFJNUDhhRm5vajkvaHJMckdsMDJW?=
 =?utf-8?B?aDRqRnZUTDNhQm9nWjQwbFJjTE9DMHhDNElMSFBUMGhwd0IxUkdGU1VRZjhs?=
 =?utf-8?B?UHJiQlFEV0hzSXkrVWVXMG91enBvclc1VXIrQUFSYnZURG9aMGFPYmZqaUZF?=
 =?utf-8?B?ZU1yV0d4dHdIUGZiV2x2dkZXTDBZVUxZcGw3K1NxK0c4YWRVQXo1UStub25H?=
 =?utf-8?B?UGVVSm5WU1hsdnloQzhnazN6b1VPWDZ0SzMveE1VN3BOcSthUDN0Zm15MUl0?=
 =?utf-8?B?VDdkdlZySnRtUWN1OFpwRytsdHhvMEw1WW1pVmdtVlovMXVnNW1rbXRRZ3hn?=
 =?utf-8?B?NDJkcjZBU0pwOXZKU0ZSR3dTVk5ramt3czRvVVZvQjhKNnNMTE5rdTFVMUpR?=
 =?utf-8?B?YTdvZ0xuVFdzYUc3Zm9JZHc2eS9VRmorQlQ4VElqUXVreWl1NktmVUxacm11?=
 =?utf-8?B?S0cxN0FXWWtpUm5KejJQUEZaejN6YUxycHd6ZlVtd0NOSk82MFZkL3AwRnlp?=
 =?utf-8?B?T1FFM296Z0YvVjlJckt0bFFJVUJFRWtjN1VrbE1NZGhoS3k3ZWFQdVZ0ZExY?=
 =?utf-8?B?SXlTcENEbnJmZk9hWm9JeFpodUVZb0xpVm1kTGRybkJNYlpjSSt6dE1kMzlL?=
 =?utf-8?B?Q0gzSVpscVh3RzFrcnNZVGxtOEZBN1RHaG9zTzI0dFVXT0lOd3pGTWxiMzd4?=
 =?utf-8?B?ZGtPT242ZU9iU0NwWFRBZTl5ZXhPM0d6ZTV2dHJtcENjSWtacnJRTExseVU0?=
 =?utf-8?B?NWlwdDhzYWdRVUJJcTEwZkZ2R3d0L1pnaWhTZE13WEQ4dmc5VkVMN0Y1T05Y?=
 =?utf-8?B?M3ptWnJ6ZXJpYkpmWUNVY1hkRisxKzRhRWM1bDNkR01tVmxRa0NtY1E2YXMx?=
 =?utf-8?B?QUJSNlNiRUZOYkUwUVlyemFONC92WlJ1ekxjZnlrQTZKc1hQQ2l4OW1zYkNP?=
 =?utf-8?B?dE01cG5EWm4vWGM0TXJtcGl3enp4U0JRU0ZYVVYvcGtBdGxkbXFBbHNyNVJ6?=
 =?utf-8?B?dHhIbUVadnA4cUFJN1JmUzVnM0xVZ3BDL2NVNXBHbDZkWU52UWVDRUs3TTlp?=
 =?utf-8?B?Mm1iNmxKNVF3TnlKTVQwTk1LWlVBRTJrbjJQbDEyaDhtaG9vbUlkNTFPUStj?=
 =?utf-8?B?dHFhV2NVUnpEbDkrTVRjR1VMajVONnJZUUtKSHZlaDJlUjJhVlhkWE91Ujlo?=
 =?utf-8?B?dUdOTXRnTk5Qall6cDZ2UHFzNit5N1lBN2VUcElmSnB3bEhNUjU3RG5mbDVt?=
 =?utf-8?B?NUpKajY0aldBSHowME8vQzBFTWMwMVFZamcrbzBqdUMxNVE1TmxLWUJLUDB5?=
 =?utf-8?B?clk0ZEJJZ0RMOTMyUnNqbm1GZDBjU0ZPbUlYa002YjN4enFMTk1RV1Z2VEJ1?=
 =?utf-8?B?OE8vbTFFZkRTbkZsQzE5MmNDWXZZQ3NEMHhVZm1PdE9nbzhXVmtSQjhvdEFy?=
 =?utf-8?B?MUxQV3hiWmtzK01PaERObnZzd09JUEFRUXRZOU1tN1VOOWJYQmZKN1NaWCsv?=
 =?utf-8?B?NDQ3OENpWnJLU2lvZWtaN0dOWERma2hrRWFqNURRV3NobDhIZnAydi9lNFRB?=
 =?utf-8?B?Y05BcytMbzg5WERXeUtjdXc1bndDRDBjTjVDdWtDcE1zcldmVzlEeWtOT2wy?=
 =?utf-8?B?NE5FSVNkaloxVmcwNVlYUDVPNTc4ek93dUJiZE5oR0hNU1dsY0xoRllySDNi?=
 =?utf-8?B?T21LZnhaTVZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGNIcnRCRHQvWFhZd1Q0dEFiZFNsclhZa2lLYnVNcitlUUhzZU92MGlTKzJT?=
 =?utf-8?B?emVFU0hLQUI5WHIrWEVqQ0QzRm1lOXBzaUZTOExNWlBWbFBNdnBKbTIzU0NJ?=
 =?utf-8?B?NXo0aStMRXFXNHRJbXU5MTBsUFNFVVJqVTdRaW9wdmpMQWxFLzBFU3l5eEFn?=
 =?utf-8?B?R3dDc3BtYjdZRmdRc25PWUlIUGNaWUthOENnY2U0eTBRc0piMFI5N1cvWG4z?=
 =?utf-8?B?YnV2ZCtoRVVDaG1qVjRNd3dUZkJHckc2MHprMk9lUnc2T3hIakVRMTUySkQ0?=
 =?utf-8?B?YTFLMjlXdE85NnlGNEpjWWhFOWxxVnhaMHo5RzRIZHhXcTk1OGVKdFBqUGVq?=
 =?utf-8?B?a0NKVzNpWTdLVXNNU1NxZTZicFlPRTF3eDlDaHJpNUJ2amp6aXJGcTZZb1hS?=
 =?utf-8?B?U2psUnVIL0ZrdnlNSXNLMnhQMGMycTRaVUZQMGRqRnVpQXlhODhybEhJU2I1?=
 =?utf-8?B?MzFMaVJtMCtWRFZHZEM1dGVjbEs3T0FnK1B1OHQyTEFtWEhGZTNMd2ZYdFJR?=
 =?utf-8?B?cVMzYm55ZjFqOG5JeVo2cEpOZHdtSTg3VHRjOFM1MUJZY2hqb0phTS9uR0NQ?=
 =?utf-8?B?bnc0NHFmNmtaUS9hQVp5VzRpSGk5NTVlYS9JMnhHQmw2TlNZeGdUSzhpMy9q?=
 =?utf-8?B?bjcxSVFnbWhqVndBRitkOW5CZWxkVHl0NEFtbkJjcUhRQTgzTXp3UG5aRWpw?=
 =?utf-8?B?UU9qUjEvc0d6L3RNNVNOalU5WjVTOUtmS1ZmS00vcmVtQ0ZuMkk5OEpWTlRv?=
 =?utf-8?B?U2VBOTFxaCtHaEdRSDVnVlZDWXJ4ODVicVdTMUdmSkJsOENiYzBrR3dJMVdh?=
 =?utf-8?B?N2wwdlhDaDRvTXJsbWxJbldiMTAyNlFwWlFSSTNZUDcxenZodGw2OURRamhZ?=
 =?utf-8?B?U0hkRWJTaWYwTHVsUHRYdkUwMFdpa1l2eElzZ0hjZXZxbDAyazJTRlFUYTRC?=
 =?utf-8?B?b3Z4S2hvMklLNzhNNktUM2JlL3RlOVA4Sm9hcFFhdHRzVW1ITW04YlZBTms5?=
 =?utf-8?B?VFJXTURiaDNKNldDUHdoNUE5UVNCd0Fob3p1VWlaVVVJUlhEb1U2U1BaZko0?=
 =?utf-8?B?UGJsU2RFRWRCdU9HTnU2TmtSOWdsclBBVFY1REpibmdNVWxRWGJzV2ZlVlVL?=
 =?utf-8?B?Zk5qeis0WUlScHR4Z1dkUWluVWp5dnh6Ry9yWjcxYmk0VWxrTDZwRUtsVDNO?=
 =?utf-8?B?SC93blQzZzcxbmUwdzRLVXYwNjJhZFV2ajVVMXBOcnVVNE1oV3RSbVlxN25l?=
 =?utf-8?B?aElmbFFBM3VPT2VMdmErcEhuTUE3ckttc0g3TnVUOERrTXFQUmJuV3RwK25x?=
 =?utf-8?B?QUZoM0l5TFNhVkFMZEdCQ1J2b1ZPWUVZWmlLN2JxK2dDR29mZk52WURteUg5?=
 =?utf-8?B?V1JwSmJDTm5hcm92aFdDYlFtNkNBUXYxMmh3Sks2ZG1udm0zNnJXRHI5WVpN?=
 =?utf-8?B?c2dSS2JiTDhmMyttdTJLbld3ZXh2QlQyVW56S20rRGw3NTN5RkJQdGUyMFFW?=
 =?utf-8?B?eGRpODNnbzh0RHFlZU1uSFdFRDBSM2o4dmFhdXRzNUZFc3hTUG1UcDZJTVZ0?=
 =?utf-8?B?Zll0dWgwcUwxaUhkczVpeGhBTnA1cXBseHZFYU9TS0crWHgvUGt5UVRJS2hk?=
 =?utf-8?B?NE9sRlpBd0VqQ2REOVZpdWQ4K0pBTlo1SkVwS1g5QmIzQjgxczJKT3BkMDZT?=
 =?utf-8?B?RXVPbnJVdkpiVldlbEFmNnkyU3lQVVdybEZ4cGE1RGlLSVBqbkVxZTVNYWhI?=
 =?utf-8?B?TDgxa0RIR0NieFM5TWFLalhQY3hvQ1ZvTUdxeHpYMFRsUnBBY1RoeVErU0Rz?=
 =?utf-8?B?MmNMd0tTTTVRV3RMVlBKREpaLzhzdUZ6VjZmcUs5ZHpsR1QyZEhwYXZJWEVp?=
 =?utf-8?B?M2pGeWdzMlpiYmMwTlJ5N2Q1Z29IZEI4UndBUWFoNlpWM2NDelEzOGM2c1dD?=
 =?utf-8?B?c2VjeGtZZDU1QnNwcmE5UEF1elFqZktDWDl0ZjMwUEpSVFRpa1VrU0JHWldS?=
 =?utf-8?B?T0piUWFHZTRXVDZRMStCRS9KQjI0eGUrSzlZVkJGcEFyVDlpU1pkQy9KVm9M?=
 =?utf-8?B?OHlJSmVBcnIwU2hwQklUdENwQmY0SkQzbUZIQlZYdDZ3Nlp0MVdSQktobmtk?=
 =?utf-8?Q?hWvWSN0N4yq8wxME7NQtgzUAp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b612887-90a8-4863-20c8-08ddbff6e88b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:15:34.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbE0avEt2X+b9xRcgX4fhtmel+bi/rx2LYkSJDVCX3YxlRN7ElpZZra1dwp6rAtfDwsKv0CSu5OG6P8lxpqpZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821

On 7/9/2025 9:30 PM, Zhijian Li (Fujitsu) wrote:
> Hi all,
> 
> This RFC proposes a new approach to handle the resource conflict between CXL Fixed Memory Windows (CFMW) and "Soft Reserved" memory regions.
> 
> I've been thinking about the "Soft Reserved" issue lately and went through the previous proposals [0]. The existing solutions are generally centered around CXL region management. For instance, an early proposal [1] suggested removing the "Soft Reserved" resource during region teardown. The current approach [2] has evolved to remove it after the CXL driver automatically constructs a CXL region.
> 
> I haven't found prior discussions centered on removing the "Soft Reserved" region *before* the CFMW resource is even added. If this has been discussed before, please point me to the thread.
> 
> My proposal is to remove the "Soft Reserved" resource at the moment we add the root decoder resource (the CFMW) from `CXL_ACPI`.

A couple of thoughts on this approach.

If the device_hmem driver loads prior to the cxl_acpi driver this could be an issue. The device
hmem driver init routine makes a copy of all soft reserve resources into hmem_active. It is
this hmem_active list that is used by the hmem driver to create dax devices, this could possibly
create a dax device for a soft reserve that no longer exists, or has been split up.

Perhaps moving the MODULE_SOFTDEP("pre: cxl_acpi") from dax/hmem/hmem.c to dax/hmem/device.c
could solve this to ensure the cxl_acpi code runs prior to building the hmem_active list.

One other aspect that this approach would prevent is the ability to use the memory covered by
a cxl region if there is an error in creating that region. In previous approaches for instance,
if during cxl region discovery we get an error and fail to create the region, the soft reserve
intersecting that failed region would still exist and be available for the dax driver to consume.

-Nathan

> 
> Here’s why I believe this is feasible and more effective.
> 
> #### Background
> 
> Currently, CXL memory can be exposed to the users in several ways(1)(2)(3), depending on firmware and driver configurations. The diagram below illustrates the flow:
> 
> ```
>                             +-----------------------+
>                             |                       |
>                             |   CXL memory          |
>                             |                       |
>                             +----------+------------+         +----------------------+
>                                        |                      |                      |
>                                        |                      |                      |
>                          +firmware---------------------+      |            +---------v---------+         +--------------+
>                          |             v               |      |            |                   |   NO    |              |
>                          |  +----------+-------------+ |      |            | enable CXL_ACPI?  +--------->  HMEM        |
>                          |  |                        | |      |            |                   |         |              |
>                          |  | expose to E820?        | |      |            +-------------------+         +-------+------+
>                          |  |                        | |      |                      |YES                        |
>                          |  +----------+-------------+ |      |                      |                           |
>                          |             |               |      |            +---------v----------+                |
>                          |             | YES           |      |            |  iomem             |                |
>                          |             v               |      |            | CXL WindowN        |                |
> +-(1)-----------+       | +-----------+-------------+ |      |            |       (4)          |                |
> | iomem         |  NO   | |  set                    | |      |            +---------+----------+                |
> | System Ram    +<--------+  EFI_MEMORY_SP attr?    | |      |                      |                           |
> |               |       | |                         | |      |                      |                           |
> +---------------+       | +-------------------------+ |      |            +---------v----------+        +-------v--------+
>                          +-----------------------------+      |            |                    |        |                |
>                                        |  YES                 |            |   CXL region       +--------> (2)  dax/kmem  |
>                                        v                      |            |                    |        | (3) device_dax |
>                            +-----------+-------------+        |            +--------------------+        +----------------+
>                            |     iomem               |        |
>                            |    Soft Reserved        +--------+
>                            |                         |
>                            +-------------------------+
> ```
> 
> The problem we are facing occurs in path **(4)**, where the ACPI-defined `CXL WindowN` (CFMW) overlaps with a `Soft Reserved` region. In this scenario, if we try to destroy the driver-created CXL region to create a new one, the operation fails because the underlying memory range is still claimed by "Soft Reserved".
> 
> Here is an example from `  /proc/iomem `:
> 
> ```
> c070000000-fcffffffff : CXL Window 0
>    c070000000-fcffffffff : Soft Reserved
>      c070000000-fcffffffff : region0  ### Deleting this will not free the range for a new region
>        c070000000-fcffffffff : dax0.0
>          c070000000-fcffffffff : System RAM (kmem)
> ```
> 
> #### Proposal
> 
> The fundamental assumption of the CXL driver design appears to be (and I believe this is correct) that once the kernel successfully parses `CEDT.CFMWS` via `CXL_ACPI`, the CXL subsystem is designated to take full control of the corresponding CXL memory device.
> 
> If this holds true, it means that the "Soft Reserved" region, which serves as a firmware-level hint to prevent the OS from arbitrarily using this memory, is no longer necessary after the CFMW is identified. The CFMW itself becomes the authoritative definition for this memory range.
> 
> Therefore, we can safely remove the "Soft Reserved" resource from the `iomem_resource` tree right before inserting the new CFMW resource.
> 
> This approach is simple and highly effective. It decouples the "Soft Reserved" problem from CXL region management entirely. By cleaning up the resource conflict at the earliest possible stage, this solution should be compatible with all CXL region patterns, including scenarios with misconfigured or unconfigured HDM Decoders.
> 
> I haven't spent much time working out all the implementation details yet, but a quick proof-of-concept (PoC) shows that this approach appears to work. A rough sketch of the code is below. If this direction is ACKed, I will prepare and send out a complete implementation for review.
> ```diff
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -780,7 +783,9 @@ static int add_cxl_resources(struct resource *cxl_res)
>   		 */
>   		cxl_set_public_resource(res, new);
>   
> -		insert_resource_expand_to_fit(&iomem_resource, new);
> +		/* Remove Soft Reserved that is fully covered by this window */
> +		claim_and_punch_out_soft_reserved(&iomem_resource, new);
>   
>   		next = res->sibling;
>   		while (next && resource_overlaps(new, next)) {
> ```
> 
> And the new helper function in `kernel/resource.c`:
> 
> ```diff
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -364,6 +355,7 @@ int release_resource(struct resource *old)
>   
>   EXPORT_SYMBOL(release_resource);
>   
> +/**
> + * claim_and_punch_out_soft_reserved - Claim a resource region, punching out
> + * any overlapping "Soft Reserved" areas.
> + * @root: The root of the resource tree (e.g., &iomem_resource).
> + * @new:  The new resource to insert.
> + *
> + * Description:
> + * This function prepares for the insertion of a new resource (@new) by
> + * resolving conflicts with existing "Soft Reserved" regions. It works as
> + * follows:
> + *
> + * 1. It iterates through the children of @root, searching for any resource
> + * that both overlaps with @new and is identified as "Soft Reserved"
> + * (by its name and the IORES_DESC_SOFT_RESERVED descriptor).
> + * 2. For each conflicting "Soft Reserved" resource found, it removes the
> + * original conflicting resource from the tree.
> + * 3. It then calculates the remaining parts of the original resource that
> + * lie outside the range of @new. This may result in one or two smaller,
> + * non-overlapping parts.
> + * 4. These remaining parts are re-inserted into the resource tree as new,
> + * smaller "Soft Reserved" resources. This action is akin to "punching a
> + * hole" in the original reserved region.
> + * 5. After all conflicts are resolved, the @new resource is inserted into
> + * the tree, claiming the now-available space.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int claim_and_punch_out_soft_reserved(struct resource *root,
> +                                      struct resource *new);
> +
> ```
> 
> Looking forward to your feedback and thoughts on this approach.
> 
> Thanks,
> Zhijian
> 
> -----
> 
> **References:**
> 
> [0]
> [PATCH 0/2] cxl/region: Improve Soft Reserved resource handling: [https://lore.kernel.org/linux-cxl/cover.1687568084.git.alison.schofield@intel.com/](https://lore.kernel.org/linux-cxl/cover.1687568084.git.alison.schofield@intel.com/)
> [PATCH v2 0/2] cxl/region: Improve Soft Reserved resource handling: [https://lore.kernel.org/linux-cxl/cover.1691176651.git.alison.schofield@intel.com/](https://lore.kernel.org/linux-cxl/cover.1691176651.git.alison.schofield@intel.com/)
> [PATCH v3 0/2] cxl/region: Improve Soft Reserved resource handling: [https://lore.kernel.org/linux-cxl/cover.1692638817.git.alison.schofield@intel.com/](https://lore.kernel.org/linux-cxl/cover.1692638817.git.alison.schofield@intel.com/)
> [RFC] cxl: Update Soft Reserved resources upon region creation: [https://lore.kernel.org/linux-cxl/20241004181754.8960-1-nathan.fontenot@amd.com/](https://lore.kernel.org/linux-cxl/20241004181754.8960-1-nathan.fontenot@amd.com/)
> [RFC v2] cxl: Update Soft Reserved resources upon region creation: [https://lore.kernel.org/linux-cxl/20241030172751.81392-1-nathan.fontenot@amd.com/](https://lore.kernel.org/linux-cxl/20241030172751.81392-1-nathan.fontenot@amd.com/)
> [PATCH] cxl: Update Soft Reserved resources upon region creation: [https://lore.kernel.org/linux-cxl/20241202155542.22111-1-nathan.fontenot@amd.com/](https://lore.kernel.org/linux-cxl/20241202155542.22111-1-nathan.fontenot@amd.com/)
> [PATCH v2 0/4] Add managed SOFT RESERVE resource handling: [https://lore.kernel.org/linux-cxl/cover.1737046620.git.nathan.fontenot@amd.com/](https://lore.kernel.org/linux-cxl/cover.1737046620.git.nathan.fontenot@amd.com/)
> [PATCH v3 0/4] Add managed SOFT RESERVE resource handling: [https://lore.kernel.org/linux-cxl/20250403183315.286710-1-terry.bowman@amd.com/](https://lore.kernel.org/linux-cxl/20250403183315.286710-1-terry.bowman@amd.com/)
> [PATCH v4 0/7] Add managed SOFT RESERVE resource handling: [https://lore.kernel.org/linux-cxl/20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com/#r](https://lore.kernel.org/linux-cxl/20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com/#r)
> 
> [1] [https://lore.kernel.org/linux-cxl/cover.1691176651.git.alison.schofield@intel.com/](https://lore.kernel.org/linux-cxl/cover.1691176651.git.alison.schofield@intel.com/)
> [2] [https://lore.kernel.org/linux-cxl/20241004181754.8960-1-nathan.fontenot@amd.com/](https://lore.kernel.org/linux-cxl/20241004181754.8960-1-nathan.fontenot@amd.com/)

