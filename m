Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1819B5BF;
	Mon, 24 Jun 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251249; cv=fail; b=YrcZztzBFZVXvTy4ycvUO+Zag/LiEu0WWrFkZr8W1q+20G4VIb8XVlftY3PdvUBk9co3oQA9sepTNryEic+NWMN2fVKVvZHusOGLO78bAqEnPbvuYzpLmaKCdyjTXhYHMIewvPQy2tMK2I9hRy3z2H+nqH6ZU+KqYxsccwPeB3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251249; c=relaxed/simple;
	bh=W4h7teomfFqI9X69KNjzuanTHZ55Ee2OxGyuElDCCJY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ge1MwxT1SY4BR/kSrItiPlvS7No5Zdwr2japOMgYF3kewLoIVyMm/HpQohSxuwrqv2fSZaybd87JSBDDNFtuqtYqI4NBcjz0jGzK8rG+HDKsqugJE+2IBjmF51EyQtXE9x318T5srTImHMD+T9/cZ3ZeGRqTCaSPuEuK+5g18hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0OT3HwX4; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0OT3HwX4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtCJFGXSRTvqMQFEgscHK5hJxg10kpQGd3RTutXtnzNKUFFGcCFjx4e6q1B9nsLqNla6krWG2H/utc4qD0J3il99cz9r08B4B9kYDNibHiU0ClskzsebxUNa1lnzFHup8cxHpPpldBSGp6+YdngqzaugtHRyjiWk1Z6ddCUnCNZcUJ5nySdWy+6sYWD6nTpGW7coz9VQnemOIpzHC59dxW79HUAHsXkQKOWxOOKgzne71Hn2ojVbxu/j8bM0mA1/x2NZ1o/ns7JlORajdR4GkQGSoBBMhFWPcANkvHkIwas42EFPgmvs7VE+QVlf0hAl4f7hxIm4K8Q58W0lu3KDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAp/FvTVjmGp8VC7aDGd0DfqhLy3h/nIU4kCd1y9jvk=;
 b=N4FL644oyszfXRueSs0jAuYjwLHmooSV3OTw3xNk06ztxIc43rzrPc6jxV/WJ+3D7Zf+u24MYtTAZnEMtqYzshl63t2xgGhpOKFbhV37DyBsdRbcaCtE0GeZNRYBBF8UFUcWYXB5Kr6pLVUDeiBjYzjFuEDKhrSBEXbB/yekgtYadkMMWR293PECglbJxySYfCEUvrqNg9OHZDPNHrngdQoZuyA8TtHkjEiZKVZNf6k16WyqqKuswOyVRKNC/kSNSzL4ovGAKMmnrnm+wC69/CS8bb3gFps5knAvKIZdKhi4wSbI3ymPjD7U2797L+Nx8/vG5rIxuGs8p4IdU83Z6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAp/FvTVjmGp8VC7aDGd0DfqhLy3h/nIU4kCd1y9jvk=;
 b=0OT3HwX4cwoUVcCISpZapbyuOww49tg+9UtL8W+u2mNsyAH89LX82AwOE1O2PUDY51a9K3ZLpaVRejIeW+DUIHzw8qW45y8xRg+8gW68m/yeUKwN5RNwEQb+FV3WRitoB+f3BZj0m0bzSjFaA65RAK3Cl/y95wyglUZw7WkGP6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 17:47:22 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 17:47:17 +0000
Message-ID: <f4dffe22-b383-4118-bd3b-a3afb2df835e@amd.com>
Date: Mon, 24 Jun 2024 12:47:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] Add RAS support for CXL root ports, CXL
 downstream switch ports, and CXL upstream switch ports
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
 dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 ming4.li@intel.com, vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <6675cece52eaf_57ac294ea@dwillia2-xfh.jf.intel.com.notmuch>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <6675cece52eaf_57ac294ea@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:806:6f::8) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 63209b86-6da2-4a5f-5f85-08dc9475b05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|366013|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnI1K20vZVNvejI1eG5yL3NSNDBray81aFYrdGNCaDlncFk1d2JGVDFBSW43?=
 =?utf-8?B?cGhPYVRhYTMyUUZxWmIyVHRRc21pSXNoZ0poWTQzOUNpSXAzS3QxaFNOYkNB?=
 =?utf-8?B?Ri85TVFJRXA0dGlKTjkxNVFJVjAzUFNrRjJQZEhyOWt2RDhpR1BwRE14UDln?=
 =?utf-8?B?Wis5RjZ2Sm9Qa2RsbWgxM0JxL0lsaHQ4NzdFeHJFVXB1ZTlnZGdka2VDZk9u?=
 =?utf-8?B?SzFGTXV0TVBLV0JxZ2dLQTRpVHBlN3BXWmZBVjY4a0g0cmtjM3BINEZaOTFp?=
 =?utf-8?B?TEk5QlpJazFPQVFNRVVqS1dzL0RraW0vTk5ncFpWcjBRWVNMZ0cxbHBOQk5q?=
 =?utf-8?B?VU8veGVXRlUzVWdaZHRIVUNNWlAzQ3pKQUhORHlIc1B1QnZZdGhDK2RldEQw?=
 =?utf-8?B?ZTh4aVV1Y0RhUzNOSUdQbkUvd3BVVFo4WFpaNnVHRCsybUh5OWNsQkNJby9B?=
 =?utf-8?B?OWREZzJoallVS3oxV29LNVlKOGNVN0hMZEIzZXlXcU5nUXlPM2dxZmFETEhM?=
 =?utf-8?B?a3RNUk9PNlB3NXZ0RXZwaFpHQUdCT3FSTzdRU0RKNkN5OEp0d0RWTHE0Wk9W?=
 =?utf-8?B?bmlLdkQ3QTVseCtUcWxJMFdXcTlTSlRBUndQQ2hrYjBHTWlqT3U0cjhHWmQr?=
 =?utf-8?B?Sm1mOUYzZnV3YUZQVTdXb2N0MUs2RHRMUm9nYjVPcFhBaFFyV1h2Z1l1SjFh?=
 =?utf-8?B?Q0ZGMUJ5a25GQmVEUTdoT2QySFQySGRmMlJ2MmZmNThqS2F4bE5kVmlabFF2?=
 =?utf-8?B?MnVhSllYVjRQYTArZUFyNGRKeWlYTGdhb002Y0N3bFhlZDN6TXRqZWRzV2ZU?=
 =?utf-8?B?OUJieW1aV3Rob1kxaWd3L3VhSW1jMmlLT3N6RFlESWJuaFhTMVNNSm14U2dB?=
 =?utf-8?B?U1cyZHE0OHNyYjRvcFY1ak1uempKcmVEQW1NcnhRQ29XREhTSzhseEpDcDBh?=
 =?utf-8?B?bXlESEpEYVB0U0JjM2dHbUdQWGlXK2hoa3FOWDZWZkRMdUV5eFNUSVVhcWVW?=
 =?utf-8?B?N05YS3NrTDlkMmlsbzQzM0U1R1VSc21qcERjUHo1NS80eGx3UFdJRVIrL3Yx?=
 =?utf-8?B?aXpSdVpFTk0yR2JXVDdJZlJabTNQbGxzYlR0Tk9TYmtFYnhnN0JoZ21YZWpl?=
 =?utf-8?B?TE44NlM3YXplOVE0enVNT08xNFVXVzFXVzlVS2EvaXZMYTFqSkVZdmg1V0I0?=
 =?utf-8?B?UUtaU05YQ0pqN2ZkNHVqcVAxMXRyYitQTU1BTmNWd1NNMGRmMjUwTE9vQ2l5?=
 =?utf-8?B?SEc4azA3QURsZUN6YzUxVnFraUdhVUpocGJQakIwNE9obnhzQUg1YzhxQlV2?=
 =?utf-8?B?b0kvK3Y5Nm56QThOczRmSGttK1B3ZlJKTG1aY2xTY0FxSGtoYWxxZ3U2TUlY?=
 =?utf-8?B?aDJnV2R3SXIxbE5vT2IwM1lMREZUR2plVk8vc202cWhIaUFPVVNkWkVlTHQv?=
 =?utf-8?B?dDRLaWxmTnAyV25kV0pTUy9rSTZYcElsYlRwQmJyOUFHK1ZvdXRFZXhjRXZS?=
 =?utf-8?B?WDBWRUdQcFg0c3p6RFZaakplQW15dHZSbWo1QkNGMkVaRUFmUTVSWWpHYWVK?=
 =?utf-8?B?S3VCRTdrZmVsMENkUG1QaGlHb0ZzYzVabHRSSnhnUUU0NFN3bG9hWXczU2FE?=
 =?utf-8?B?TGpkSklHN2RRUlB4R3RIQmNvOTMxYVRpN1lvOTRWckw2VHFhTzZEcHRTZ2tL?=
 =?utf-8?B?M0Q1TEF5MUZBQmd6dFNFNm1JRDdpWDZuMWFKV0NkN2pMby9KbjJEMUFYYlNz?=
 =?utf-8?B?ejBnY2piSW5BL3ZEU0wxNjJSM2t2ZWNKNDhkYy9ZMEQ3MkJjYXBjQ1hwL0Fk?=
 =?utf-8?Q?52Kd3pLqYMrXoxfBYtuayevser8x97dAG63CE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkZyL2JrdlZhZ3J1MGNrVDhGRnBHQ2Rka1dkYU81a1BQbythekZQdzk0WE5m?=
 =?utf-8?B?OG5nQjd1Tm51ME5jY0dMc3ZmTFBzRjlpL2tJNTN0dlR4RUxYcWJVQm52TkJu?=
 =?utf-8?B?OWVJeTRtUnhsbzVKU0NaSE5lTUNhUXBvS3B1bUVwZm83M1pMbHRReWpOa05k?=
 =?utf-8?B?QjVINnBiNmJJZmJyS3J3R29QSW1yVE1uZzhwamF6eXVSdGk5SnVZWWh2L043?=
 =?utf-8?B?ZXhNZUxLZWtPVC9zdUppeTNnbllETDZOUThxVWNBV2F2Z2ZvRzlmaHU5bjlF?=
 =?utf-8?B?ck4vS1REbmwyM3FyREI5MjYwaWV1Y1BqdjYxamZrRWNKd0pmWEFXOVlxTG85?=
 =?utf-8?B?VGkzN1p1ekNKM0RDeThEdEhnUkdTcjhDekczNFRWRzc5WlpIamJhK2RQU1dK?=
 =?utf-8?B?dHlDb1IrbktMam1aQmduM1hqUkpPeFFLblA5OHZJZlk3YkFKMnd5UXBvdXNw?=
 =?utf-8?B?T05PQ01la1JRZUplS1hFczBBcjBzNVcyZjZYKzdZYThBU2RHQkQzTFo3RGpJ?=
 =?utf-8?B?SWFIcWhsTzU0akNlZDJzNzlyTEU4cjdZeDU0cUpzOFZpZVZFV3hZdWhGN0Rw?=
 =?utf-8?B?QThnYVAwdkJwS1lqYlVpcGU2N0tnOGp0U0ZndHo5TnJVb0RFNm5EYlY3Vys2?=
 =?utf-8?B?UjQvTnhZZ254V1ZNaVhXQTd3RHZqT1FuN0VWY2FTTFJvR0Q5UVpwMGRCVCtK?=
 =?utf-8?B?Sy92VGd4UStQT2k2anJ2N1ROYWx6NW9ZNm42a3ZHbWpVNkl2aDVNb2crb2Rt?=
 =?utf-8?B?eUZweWdadTlhYU1MQW9tMWV5MlNkZktuSnJLNUgxTXRPL1VvOTJwQ3pkMDdH?=
 =?utf-8?B?b3ROck9VVXBBMmgzMFVVVzVscDNzQm9XWk1Kcm9SbHM0Z2tobVoyc3IzTGY2?=
 =?utf-8?B?bE9XV2IxYnNKWkdTVXNRTFFuUTYvRjRqdGZGZk5uRDArNlhmZFR6TWJTK05s?=
 =?utf-8?B?YnlVM011aTE4NTcveXJqK3EvaG5FaCt4YlRBVDE5TmEyMkFQVDkvVUtjaVpY?=
 =?utf-8?B?MTJ6by80OW1oQy9rMzVvU2lLNHRXZWg0aHVTeUN1RlFpQjZqZnhyUjZtcm4r?=
 =?utf-8?B?WlAvNHA0N1ZoUkZHajltdS9UTzlHTm9pSmpOL3hFcWFNTzRhcXJIWUI2RGgr?=
 =?utf-8?B?dEExQkpVeXJvVElQMmNmQ1EzZGNFNjFNZDBwcHRLN3VZY25RQVNnN1E3eGEx?=
 =?utf-8?B?N29RSHZmQlBlYjBZYU10RFJmMlkwUHB6My83bzFVYW1WaEFvNFg1NGhTUHpl?=
 =?utf-8?B?czJEd20yNC9yeFhNem01bU5oQUw2U2htY2lIMTdYdktad3ZzbUsxR2VKUDF2?=
 =?utf-8?B?Znd2RVdyd295MmtmUEhqQjhzN2ZNWElMNW1tT0kvWDFqSzdRSWZOSy9LR2ZP?=
 =?utf-8?B?WVRORXJZcm0wQnFENFZzL1J2WHNCR2pnejhtREI4SWo0MmtBcW5mSERkeUhM?=
 =?utf-8?B?cTByR2ZadlA0NmtNUmplK29nb1ltcWlvNzRtcVlZMXQyNm1ENzk3Zm9TRHFI?=
 =?utf-8?B?K044RVU2aE1LQWVwSXBwUU54V0wyNUVmTkNGYXJYM1BkdkFFSTNWSzV0Z0cz?=
 =?utf-8?B?eWhiOUNoTkxNWlpMU3lHamhYT1p3a1RkQlNBVXZ1YmpxcWQyRHlsN1dURE5V?=
 =?utf-8?B?NnVhWFVKRUdvVXAybTJEcFFCVHRGQStUejJqRG1RRjJTOVBUWmdZdnB4UVdL?=
 =?utf-8?B?U3pKN1NiZ1lxN3h6aTIxUXhQajM5ampTZGZuaSt3RXJvRFRodVRyWUNCSUlL?=
 =?utf-8?B?OUo0Y1Nib1JEYjNrV09yNGVIRW9BdytTREx0aSszeWNSZmVhUFFXSXZaTUFX?=
 =?utf-8?B?SGZKV0hJV3lFYnkxZW5zWFVDV0FJbkxOMnh0aWJ0c1ZtWHFYajY2dDYxN2pK?=
 =?utf-8?B?TjE4dFkwWnRsT0JGWC9kbnErSGJiRzFHMSttK2QxVllUang1Y3VZNTh0N1Vo?=
 =?utf-8?B?YW5oNnlhOFhQVHRubkRoS2ZwSWdSRXRua1FIU3F4d3VwQmM1Yk1US2UvT3pP?=
 =?utf-8?B?d0U1ZCtsTlBidmx4Yy9EVWhQZUtTMm01L1VCZ1JmL2EyQUxZTjQzbXZXMHg1?=
 =?utf-8?B?WWVLdlJBcDJLUWhBdEtNcDloRXJYZXQ0U0pCTWYwY1g3bHJFd3ZZSGpKblF3?=
 =?utf-8?Q?YjcO+Vj+zBa6OExK9jP/CLG4R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63209b86-6da2-4a5f-5f85-08dc9475b05b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:47:17.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsApvQJd7ktLytHZ4t2GGU4Is4zavxhrTNmlffFLmrDjNkklscuIrw6D9IlGo2VyoJxOT1FHRdnq2aBz37jGlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

Hi Dan,

I added responses below.

On 6/21/24 14:04, Dan Williams wrote:
> Terry Bowman wrote:
>> This patchset provides RAS logging for CXL root ports, CXL downstream
>> switch ports, and CXL upstream switch ports. This includes changes to
>> use a portdrv notifier chain to communicate CXL AER/RAS errors to a
>> cxl_pci callback.
>>
>> The first 3 patches prepare for and add an atomic notifier chain to the
>> portdrv driver. The portdrv's notifier chain reports the port device's
>> AER internal errors to the registered callback(s). The preparation changes
>> include a portdrv update to call the uncorrectable handler for PCIe root
>> ports and PCIe downstream switch ports. Also, the AER correctable error
>> (CE) status is made available to the AER CE handler.
>>
>> The next 4 patches are in preparation for adding an atomic notification
>> callback in the cxl_pci driver. This is for receiving AER internal error
>> events from the portdrv notifier chain. Preparation includes adding RAS
>> register block mapping, adding trace functions for logging, and
>> refactoring cxl_pci RAS functions for reuse.
>>
>> The final 2 patches enable the AER internal error interrupts.
> [..] 
>>
>> Solutions Considered (1-4):
>>   Below are solutions that were considered. Solution #4 is
>>   implemented in this patchset. 
> [..]
>>  2.) Update the AER driver to call cxl_pci driver's error handler before
>>  calling pci_aer_handle_error()
>>
>>  This is similar to the existing RCH port error approach in aer.c.
>>  In this solution the AER driver searches for a downstream CXL endpoint
>>  to 'handle' detected CXL port protocol errors.
>>
>>  This is a good solution to consider if the one presented in this patchset
>>  is not acceptable. I was initially reluctant to this approach because it
>>  adds more CXL coupling to the AER driver. But, I think this solution
>>  would technically work. I believe Ming was working towards this
>>  solution.
> 
> I feel like the coupling is warranted because these things *are* PCIe
> and CXL ports, but it means solving the interrupt distribution problem.
> 

I understand the service driver interrupt issue but it is not clear how it 
applies to the CXL port error handling. Can you help me understand how the 
interrupt issue affects CXL port AER UIE/CIE handling in the AER driver.


>>   3.) Refactor portdrv
>>   The portdrv refactoring solution is to change the portdrv service drivers
>>   into PCIe auxiliary drivers. With this change the facility drivers can be
>>   associated with a PCIe driver instead fixed bound to the portdrv driver.
>>
>>   In this case the CXL port functionality would be added either as a CXL
>>   auxiliary driver or as a CXL specific port driver
>>   (PCI_CLASS_BRIDGE_PCI_NORMAL).
>>
>>   This solution has challenges in the interrupt allocation by separate
>>   auxiliary drivers and in binding of a specific driver. Binding is
>>   currently based on PCIe class and would require extending the binding
>>   logic to support multiple drivers for the same class.
>>
>>   Jonathan Cameron is working towards this solution by initially solving
>>   for the PMU service driver.[1] It is using the auxiliary bus to associate
>>   what were service drivers with the portdrv driver. Using a CXL auxiliary
>>   for handling CXL port RAS errors would result in RAS logic called from
>>   the cxl_pci and CXL auxiliary drivers. This may need a library driver.
> 
> I don't think auxiliary bus is a fundamental step forward from pcie
> portdrv, it's just a s/pcie_port_bus_type/auxiliary_bus_type/ rename,
> but with all the same problems around how to distribute interrupt
> services to different interested parties.
> 
> So I think notifiers are interesting from the perspective of a software
> hack to enable interrupt distribution. However, given that dynamic MSI-X
> support is within reach I am interested in exploring that path and
> mandating that archs that want to handle CXL protocol errors natively
> need to enable dynamic MSI-X. Otherwise, those platforms should disclaim
> native protocol error handling support via CXL _OSC.
> 
> In other words, I expect native dynamic MSI-X support is more
> maintainable in the sense of keeping all the code in one notification
> domain.
> 
>>   4.) Using a portdrv notifier chain/callback for CIE/UIE
>>   (Implemented in this patchset)
>>
>>   This solution uses a portdrv atomic chain notifier and a cxl_pci
>>   callback to handle and log CXL port RAS errors.
> 
> Oh, I will need to look that the cxl_pci tie in for this, I was
> expecting cxl_pci only gets involved in the RCH case because the port
> and the endpoint are one in the same object. in the VH case I would only
> expect cxl_pci to get involved for its own observed protocol errors, not
> those reported upstream from that endpoint.
> 

The CXL port error handling needs a place to live with few options at the moment.
Where do you want the CXL port error handlers to reside? 

Regards,
Terry

>>   I chose this after trying solution#1 above. I see a couple advantages to
>>   this solution are:
>>   - Is general port implementation for CIE/UIE specific handling mentioned
>>   in the PCIe spec.[2]
>>   - Notifier is used in RAS MCE driver as an existing example.
>>   - Does not introduce further CXL dependencies into the AER driver.
>>   - The notifier chain provides registration/unregistration and
>>   synchronization.
>>
>>   A disadvantage of this approach is coupling still exists between the CXL
>>   port's driver (portdrv) and the cxl_pci driver. The CXL port device's RAS
>>   is handled by a notifier callback in the cxl_pci endpoint driver.
>>
>>   Most of the patches in this patchset could be reused to work with
>>   solution#3 or solution#2. The atomic notifier could be dropped and
>>   instead use an auxiliary device or AER driver awareness. The other
>>   changes in this patchset could possibly be reused.
> 
> I appreciate the discussion of tradeoffs, thanks Terry!
