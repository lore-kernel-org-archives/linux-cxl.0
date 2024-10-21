Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA479CC;
	Mon, 21 Oct 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504043; cv=fail; b=qRFWVppB8B3ePz7JmmEqCbcaobQmvBne9k4+i3fj2xMpUCas9TaA2IjXYhltBsdsghWpXqMzFusN9hqlm7K9SNVPeMpBLbtPE7GNEauk5Mzr0siq55fQOgOJxUZe+vNp5LD4NSYnuQCVZRQHeaYUAy2bKrhc7yijFEi2ctbQD6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504043; c=relaxed/simple;
	bh=GEN0m4w/cIreUX+G1JiyzgRaE1VQkBX2KuKhJtrqvsg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xx+KczbvQF+k1DKTXQdHzB1mprmrxess08bMUxcI10iFbWBJDonZcMquKE5gq0p/p0lLLWptfLHe8MeRuZPQIHYHNaxNdVhYCcSSf6jjLtQksAO5kCjDop3zWoz/sy2BSLzvP4Gj+jQjkOP7a8dxKbzWCtM4B0awoqqK75lCVek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zCSg7Xvo; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zCSg7Xvo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ8IT+dshRtAw4mde1Jxj204aP5j1ipCK4mX7UPS4cA4KHA2Xq6qsUkD1oJwsPUSkhS8WyDdYF0nhq+QXkAm1h3mXLmNN6WAbCcY7nP/2Cxohl3StPrzmLcZHUB0qtMoE7yL8vA+m4LmTxCtNIufWciZkUnKvOFnlwHW4mrejkopH+PTIWO0DfY90rKvtM+W9kgfXWPpDU3oVGHxMygBI7FAiswghLkMCWmmGVESgsyGiP7BDZ+iLUlwj/0tZUuBdNDcki79SJ435Kro0upjyMbTI9fS4yS81lP2k6Ea7y268vMHmlhj3DC5eUGqKRyoM3q+oRpFRqrTlwolL7KlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQgIq2NqXWx3YONDzZ7D1/qccOv0Vc78O8S1dgfK/0U=;
 b=ZxD246b+oA0KSAyEcAMsh27Dgq8QmKIWQYWYlNVuxYoYaj5BxFZTFqHaVu1XPXxA6Uiba9z3PxtEvqa/mEDNRJAr/KlBELt/2xzdUpPkAyDDve8yJWdHiXAA4KPkIEXvq7Epw8vB+AtHltSMB2mQAmz6eywbGgcP7AR4Ch9/rd/edSUoR7K79GmA2Hb9ay0MLVqr7DfyOkA65/M9SClneeOgG3bJEXHr9adGFCh8L1XHNtdhUwef0Yoec1UGLC/zYKHD2hxL7KM/1B3NGNDPyDdW2pvxGkpLOAG/GS04l8myPvLVXFq1TeBkThzxDptcOjezlKYcmEMOEdLtDbT2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQgIq2NqXWx3YONDzZ7D1/qccOv0Vc78O8S1dgfK/0U=;
 b=zCSg7XvoPbGpe0PSy398ZZjQJ46JoEBLA1qnzm6UH9Pl0aKqAq1t+mzNXtYcUubCxgaGp8s2uHYBXB39LMsOM53OK5F7PL/elkXvdx2q6T8RanrFMnagC1oSXKeBWGZ25c6dZvqArkhLSUef/U45V/ZTgt9ErGvj+OTqobqiEJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 21 Oct
 2024 09:47:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 09:47:17 +0000
Message-ID: <2a91a62a-dcd3-7862-95a6-57f0cfd0b759@amd.com>
Date: Mon, 21 Oct 2024 10:47:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] cxl: Set type of region to that of the first endpoint
To: Dan Williams <dan.j.williams@intel.com>, Huang Ying
 <ying.huang@intel.com>, Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20241015065713.308671-1-ying.huang@intel.com>
 <20241015065713.308671-5-ying.huang@intel.com>
 <6711909cd5d83_3f14294e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6711909cd5d83_3f14294e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0016.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ac2fdd-b997-44a1-0c90-08dcf1b55968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm9pVFVkWkVHTzR3K3p3dEpHVHZGTFh0ajVFNWpmQzVWZGpBOFRFRTJFc2ZG?=
 =?utf-8?B?NHZpWHRLQkZMNmdrRGIwMGVIcDE5VDBPcmhYbm1yeXBqVzlFNC9HR1IyN0xB?=
 =?utf-8?B?WEhsYWF6T0FWYVBybGVxQjAxWSs1QnA0a0VaRVZOZFhpMW4yOVVBRnhuSWtM?=
 =?utf-8?B?ak9JVHZDejBVbU5wQUs0ZUpYZUdtaGVVODJTaHdabDdvVHVMSlNJcDdqZkpX?=
 =?utf-8?B?SXRPUXZpMTZJdHk3ekpFY2RzK3g1Sk1yOTBOQUo4MGVwM0F0T1UwWUVNeW5V?=
 =?utf-8?B?SE5sZXJvbEhtN1VVejQwZFZhTmlHcWEwaDZmVkw1a1g1S1VoZk5HSTVMZnFw?=
 =?utf-8?B?MFpNRDRRL2lHb0t4d0w3YzRzWlAxVG5idkdwUEdGb0YzQ0VTU2VkQ0g3cjVW?=
 =?utf-8?B?eENsUHIyZ1BwNGR6d0d4eHprOEsvYVdhVCt0RWtqWldOejREdEwwTExTZXpD?=
 =?utf-8?B?MThmODkxRWcxRFl6UEpPLys3dlhIZkJSRm8vR0NHUFU3bThwOWZEdlhaRWl2?=
 =?utf-8?B?YVB0NU4wTXNPOTV3WDJXUGVTQUtOWXZHVDVwcmt5WmsrWTB5WU9YT0ZEM3BY?=
 =?utf-8?B?VnkxSStJcGxJZnZEQ0NtVCs3QlJveHpBeVNPZXVHYkltdHlSYW94K3RCZUli?=
 =?utf-8?B?Z2NGZnpxNHF5WkZDUzEwMkp2ZEJWbmN2QTVWT1pVSWJUT05DNnpibiswS2pS?=
 =?utf-8?B?eTNNekg5ZXVoVk80eFQ2YzZXejF6d2RaeTcwWlF2NkNxbGhKOVFTdDN6dk5p?=
 =?utf-8?B?anhoeHhrc1RYZi9qSkFITmNMdkxmMzJhYTZMcE5QMzkraXlyUVhRMWM5WS9l?=
 =?utf-8?B?dnRGbmhNaFlhNW51aVJxbXNmQngzTzZzcld6UjM5TDJwSitSUHJVNmluUHF1?=
 =?utf-8?B?a0I0cTkxdUZrbUgyU1hVU2NacGVsQ2taN1djNXF6NUhTVUNEM2piTG5PYzgw?=
 =?utf-8?B?azRMYStuUWNhTklvMWJ3RndtaE4yc3UzUEFFTjNwUVpHaThmNEV6NE1MeWlK?=
 =?utf-8?B?VEI0ZHJhcWR6dlRqSnhpeDFiemt4S2JXb2p3bFNabnBxL0hua1NVa0kvNkIr?=
 =?utf-8?B?VW4zSzlaRUpxaTY2ZEowUXl2ZFBzRTNYS0hQMDFWaktpeVN4cXdzTGdMdG9t?=
 =?utf-8?B?VktEZGg0ZkszOWtYcytGQVF4cFFKVjJOWUdpYVlUZHJzcXo5cVV6ZTNlM1hQ?=
 =?utf-8?B?NFY2M0l6UzFycWUwNHNwSHMvbVh4anNqZUZUQWhBQ0ZJZ2h2d0dnNjJ5MWpt?=
 =?utf-8?B?d3d0S1o3aENhd0VUTFNiRUt1WWhmQmFuWm5QUFJiNTg1bVZaNTBVdFZENDJK?=
 =?utf-8?B?WFc1T0ZtOHRFRkl1dEtRMCtqWGFHZmRObWR0aDdyYk1taVZ4ZGdrM3F2eDNP?=
 =?utf-8?B?NVFhK2FvZFU1WEFHeXpOR2RjdFFWVjBCeHovV244VVhyRzZnT1ZXTU1jSlVh?=
 =?utf-8?B?WmhvMjk0a1hxVUFKVldWZGQyWis5YTZja0dhWDhCTUFjeXp1RGhzMHVQMDdB?=
 =?utf-8?B?QWhDa2hxT1E5dFovSkhzOEw2cS90WjNrcEJNRWtObStXeVN2RzRMN0RjelNs?=
 =?utf-8?B?REtGMXh5bnVRTytsWjdCWk0vclc1VjdLeXRuekJSVk1iNGRwaHQ2RG1nc1dU?=
 =?utf-8?B?NXMxQjN6ZXVDNWlZL1B6aDIxRGlScm5MOS9pWmlqTmI1dm9OTXpXbHl6UWdi?=
 =?utf-8?B?WmhZNFNMcnJQTWdwNzJ5SmNJNkI0YXlVR3Z4Tnhtd3lYZy9NQ1B5OFZ0WERT?=
 =?utf-8?Q?lkudAbNZeFRsjyxSm+U2BJOTqLuqGmYl/NMKt1a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3FwWTJURWFHRzlteFdrYTRlT0hNekwxbXdoUkhYdFJHKzEyb2MvSEFrWCs4?=
 =?utf-8?B?TGg2UXcvSGthTS9OTGdqL3d2WGxtZThENWtSd1RFYW9kY0pHVFhMMWdaY3VB?=
 =?utf-8?B?eXdUbjhaYW84Wkp3Skx5RFJkeDRrZzVIT3g3NU9QVE1QcVJ5NE14ZHhKRk1F?=
 =?utf-8?B?V3dtbG5HaUNoc3hNRit3WDdCV2JSb2RFWTFtdVJEVW0yWWN0aTZ6M2I4eUJz?=
 =?utf-8?B?T1pkZkQ5dWRXbGVSbktWdXhVWDl3eGxQZm1SbXNSSFd4ZGdCM0phZ0FFUVYv?=
 =?utf-8?B?Rmk1V3Zrak9FWVREczcvMStYT2NsT29oMUowSVJ1OExTRjY5OHpqTldYWFh0?=
 =?utf-8?B?Q1BQcVFsMnJGbmpic0RTQ2NaeDVVQ3N3aG4vRjBicFhkYXpwcTY5cjVLUmtp?=
 =?utf-8?B?V0gveWV0SW5DY3hpS0g4ZGVNUUpyNDdVWGpHanNFV3FuaU42QnhRbThYQUMx?=
 =?utf-8?B?aUNvQzBLa2hWdHZvYmZqcHFidEVpYWt6ZEFKNVhCRmpqV0FzZ2hzbTg3UFl6?=
 =?utf-8?B?SXlEWHl2b3dMaTlUd3JrL0dXVTN1cURWT053cjk3VmE3RTJTOVpRWGFjelZH?=
 =?utf-8?B?ZkRaV1B2RGpzTFRwdHlPd2hXKzdTa3d2aHA3OWlEMjhPS0Q3VGh4dkN3ZHBv?=
 =?utf-8?B?WUtCUFZWd0htNkUvdXp0eVZLMkdsTGt2QlB5aDRtcExRZjkvMG05MEdta2Vm?=
 =?utf-8?B?dU4wc1NMTml6aTdiY0h6bGNxaE13N1Y4V0luSC92d1ZSdTg0MnZqdkpOWmF5?=
 =?utf-8?B?djh6SzZFWmM4djJtNkE0ZW9OWVhiRDBsN1pnajVqTVFXWEFJRlRpWE1hVkpO?=
 =?utf-8?B?d1pEM1pYRXFtR0EvVFlGblg4Q1lVRGc0WjZvTjdvUkJrQTFXbmNobkRlaWJT?=
 =?utf-8?B?SGR3NDFhaW9Ga0FCTXdxdXJRWEJldUFKakFNKzYzWEorYW5nQ1padEhVTDIy?=
 =?utf-8?B?TElEVHFQZU9jRitKMHUvVkpBSlNDbjNiVWtlMnhQTE82Z3FYK1pSVUdmL3BP?=
 =?utf-8?B?UWFjQVpzamxIUEJVODljUUpRTVBRekUvenRLTVlvcHVLS3gxNG0zUk9jYXB5?=
 =?utf-8?B?cWxTYkMwZTZmb2lXMmpKbHVtK3pPaHpvUXNEZittSk40L2lhV3UxMk9adGFh?=
 =?utf-8?B?eUxqZnJWUnpEbGx3RnE3UkxTSFBSUWt6MEw5YXJYTDR1NzZ0blBTVitHSmlp?=
 =?utf-8?B?SzBtRDFKYW9odldSN3RJMkRVb1NYRVJxblNHUm11WVhyVzYyc1o2RFF3Wm8y?=
 =?utf-8?B?SW1FSHMzMzVsR1RMb0Z3MW1GTlNKR2o3YWU1Z3FlQUk5OVh4S2ZEWHBRZGFV?=
 =?utf-8?B?SUpXcmhOd0tRMkR3ekl6akx6V1VjclR3SnBtNzB1VGNIb01rdFFxT28xVUIz?=
 =?utf-8?B?WVVKYVBFN0pETTQwZWpSTWJqQ1B4WTk3MTMxTktSZzhyZnVqV2pzUEdjVldx?=
 =?utf-8?B?Y2YvejE4YzFUeHhQY3oyMjdmSVJJOVI0aUZ6YjFPdk91Qk1sbnZTRkNhVUda?=
 =?utf-8?B?SmZGSy9sRWdWYjFUYkhZU2ZCc0JuNVllVDZqcEJzdGREMTB1OXNrczZUV1dP?=
 =?utf-8?B?eCtqNUxHc0xGUXZKRUhkazdqd3MrV1ZPV1Q5OHRGOUZwN3I3V2w1czhEbDlm?=
 =?utf-8?B?U3N4VG1HYnJKYWFxdU52U3QxaEpLKzd1MkFkUVA0c1dLYmpJc0dYN1E2QTla?=
 =?utf-8?B?Z3hQYjFNejZlVEt2UmVpZms5bGZYWW52MHRZQTdDK21BUE5lZk1BWmJ5OWRO?=
 =?utf-8?B?eFU3K1czOXJJbngrd0w2RmxwKzk0QkQxdjIra01OeS9BM0JtNSt3MTdRUmhv?=
 =?utf-8?B?V01kellsODFnUkg4WDNiMUNvUUR3WHpwak1vY3p4U3crWkNQVExkSS9iUnE0?=
 =?utf-8?B?cjMyRitYcWRVQzBodVpQeSsyMEtRcmZTUndkb29RWmJSanNBYW1aMm9lcnMx?=
 =?utf-8?B?RS9OSTU3dHVxVEc5VUV0MWp6YmxaUTEvK2ltSjNOVUtOVUtZYVR3a0oxaVFi?=
 =?utf-8?B?dE5EbEMyUXdLbkY4K2xHOXV3UHBGd1MyUlI5YlNJQUIzdnc0eFg3eEdhdzY0?=
 =?utf-8?B?NHgvZE84blY2TEF3NWM3UUlOV3lIQ0drR0NRc0FiSFl3YU9iR3VaaWMxZWg5?=
 =?utf-8?Q?LsEqzivtACgkU+P4ASgMgFlGW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ac2fdd-b997-44a1-0c90-08dcf1b55968
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 09:47:17.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBqYSKO8ji9od/YgAosnGh49iyYM+2nX3hWKzPcckYPm3DfUfOK+C3JUhSHGE1h7gFPGCl0Ik/W/ZC6z8ecIjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875


On 10/17/24 23:33, Dan Williams wrote:
> Huang Ying wrote:
>> Current kernel hard-codes the type of region to type 3 expander now,
>> because this is the only supported device type.  As a preparation to
>> support type 2 accelerators, the patch sets the type of region to that
>> of the first endpoint.  Then, the patch checks whether the type of
>> region is same as the type of other endpoints of the region.  Because
>> what we really need is to make sure the type of all endpoints of a
>> region is same.  And, the patch lets expander/accelerator device
>> drivers specify the target type of endpoint devices via struct
>> cxl_dev_state.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Alejandro Lucero <alucerop@amd.com>
>> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/cxl/acpi.c        |  1 -
>>   drivers/cxl/core/hdm.c    | 28 +++++++++++++---------------
>>   drivers/cxl/core/port.c   |  2 ++
>>   drivers/cxl/core/region.c | 13 +++++++------
>>   drivers/cxl/cxl.h         |  1 +
>>   5 files changed, 23 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 21486e471305..29c2a44b122c 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -382,7 +382,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>>   
>>   	cxld = &cxlrd->cxlsd.cxld;
>>   	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
>> -	cxld->target_type = CXL_DECODER_EXPANDER;
>>   	cxld->hpa_range = (struct range) {
>>   		.start = cfmws->base_hpa,
>>   		.end = cfmws->base_hpa + cfmws->window_size - 1,
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 478fb6691759..c9accf8be71f 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -841,18 +841,25 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>   		.end = base + size - 1,
>>   	};
>>   
>> +	if (cxled) {
>> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +
>> +		if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
>> +			cxld->target_type = CXL_DECODER_EXPANDER;
>> +		else
>> +			cxld->target_type = CXL_DECODER_ACCEL;
> This looks broken there is no way to know the target type of the decoder
> from the cxl_dev_state. An "accelerator" can have HDM and an "expander"
> can have HDM-DB.
>
>> +	}
>> +
>>   	/* decoders are enabled if committed */
>>   	if (committed) {
>>   		cxld->flags |= CXL_DECODER_F_ENABLE;
>>   		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>>   			cxld->flags |= CXL_DECODER_F_LOCK;
>> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl)) {
>> -			cxld->target_type = CXL_DECODER_EXPANDER;
>> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
>>   			cxld->coherence = CXL_DECODER_HOSTONLYCOH;
>> -		} else {
>> -			cxld->target_type = CXL_DECODER_ACCEL;
>> +		else
>>   			cxld->coherence = CXL_DECODER_DEVCOH;
>> -		}
>>   
>>   		guard(rwsem_write)(&cxl_region_rwsem);
>>   		if (cxld->id != cxl_num_decoders_committed(port)) {
>> @@ -874,21 +881,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>   			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>   			struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>   
>> -			/*
>> -			 * Default by devtype until a device arrives that needs
>> -			 * more precision.
>> -			 */
>> -			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
>> -				cxld->target_type = CXL_DECODER_EXPANDER;
>> -			else
>> -				cxld->target_type = CXL_DECODER_ACCEL;
>>   			if (cxlds->coherence == CXL_DEVCOH_HOSTONLY)
>>   				cxld->coherence = CXL_DECODER_HOSTONLYCOH;
>>   			else
>>   				cxld->coherence = CXL_DECODER_DEVCOH;
>>   		} else {
>> -			/* To be overridden by region type/coherence at commit time */
>> -			cxld->target_type = CXL_DECODER_EXPANDER;
>> +			/* To be overridden by region coherence at commit time */
>>   			cxld->coherence = CXL_DECODER_HOSTONLYCOH;
>>   		}
>>   
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 9ebbffcea26a..d1bc6aed6509 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -139,6 +139,8 @@ static ssize_t target_type_show(struct device *dev,
>>   		return sysfs_emit(buf, "accelerator\n");
>>   	case CXL_DECODER_EXPANDER:
>>   		return sysfs_emit(buf, "expander\n");
>> +	default:
>> +		break;
>>   	}
>>   	return -ENXIO;
>>   }
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21b877d8582f..d709738ada61 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1926,7 +1926,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>   		return -ENXIO;
>>   	}
>>   
>> -	if (cxled->cxld.target_type != cxlr->type) {
>> +	/* Set the type of region to that of the first endpoint */
>> +	if (cxlr->type == CXL_DECODER_INVALID) {
>> +		cxlr->type = cxled->cxld.target_type;
>> +	} else if (cxled->cxld.target_type != cxlr->type) {
> No, the type of the region is determined by the caller and should be
> gated by the region capability. For type-2 region creation I doubt
> userspace is going to be creating those vs the accelerator so this all
> seems backwards to me.


FWIW, path 19 of last type support patchset does add the type to be set 
at region creation time by the caller:

https://lore.kernel.org/linux-cxl/4ce8cc04-71fd-424a-9831-86f89fcd7d2f@amd.com/T/#m420ea86f7b9193519e3226c377612ad3ea546633


