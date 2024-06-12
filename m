Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD9617DE25
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201837; cv=fail; b=PUAZ+K8mUBAo5e2b5p9Q0l3yE2VuHjLg/SzdJf5WAuo7httJQixcy+Mdpo5T13JmvQ0BEoxn/xl55LEnETfmFx+3Fx+ec0dFl+0URgd4vAyiT7l6fFe/OBAgN066VUlh2O01KWQQ0FchoscXfcDfUt4BcIM0BaZVs8OMvT+UT5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201837; c=relaxed/simple;
	bh=Pn8F0giGn6dZDWeMOQF2YHuEoYyAg1ITAMv5JzKifes=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O3DZ3w8J5AY58NNbCfG8iDEYZxLR6baXXvouQj/B1zcRN7jY0rYTzupnolquHW/Nz1uTkNS8NvPqa4lOqUeOn8vfGjQDLn5cPOvgC97a+oe+XEzvYPH+Tbeyn7LNf74mcLShGTiVjjdbA++eXDZ7bhlFGUL48l24khuOJoo+zv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l+JIXq9j; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l+JIXq9j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0DOObTCiflk+mc3JNBbUDaibvg6MUNUqobyjZELmKE6qBO77NDT1kAF36q6z6FE6XnkXE1ggXOVmXue+j694sRK8Yt2YFUMrgZXPq9cDuduudvYIBl+HrjVA/7h50BTAxRAAvUKOHGOUJb42YVZYPybcXFVGRnBNDCEX66aUCNeXHNodaZ7WOClXcH3Qyo3dusTUfyTimhPOnarn/2Uxg96wIX71zw8U5Gjn0ZVo8TCgt/V68rxfCd9pSe4oBJZS5vx+C44gHSjnC7RScy9mSxjn1AcPrFPgweUOAgVtcd5UN9Zactx+nLDa1fpopf9lmFsvTFwLwKbYOPhpFN6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOxolCbZSuGlV9+eaQXVecC0UJ9TXzDwrC/cI9tfr2g=;
 b=gDFBTfuMMzdhIY4VYOvxD9E9/YGw+PyCR7R0DOSxwUSCnKEI3Kf39VdCZKCJapgMFZqU63i1YP9tLPa53WUfkT9/AmXjSFfGFTKDi6BDflaf+06HMdFCNjJhFjajlV3dopbZMrZa1+ZY4HzHJ5lyUSAQlhzz8ArrZE+7t9xHvUNqfErviswO4Gdmj/Mt7b5cfXDwKHImPCCWmnO3Xnr1TXcI+XWKRgqm00a4xocPk7F9nMSExv2IBrEET6t9DcMt3tgtca/hzxVXJZYIn2ugHjNFN34/O43i9Io8xJSJH5DgYGRtX+6erju8OqVXoBavhzMfKtEhsqA6sjHdib4t9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOxolCbZSuGlV9+eaQXVecC0UJ9TXzDwrC/cI9tfr2g=;
 b=l+JIXq9j+D0LoEkhkkjC3xrfIrOG/XGzyoAf6UDUlPTlaEDp0W8LAHSyNipqflphxx+KvXFPOqL0AGLT6uK51KE8YbvD/3vUykgnP9QNa22sLbzPf7DRdeRNNIvvhTy/K/n9HDS+hLjJupfXMHgOPxOGmW5mYNgDoXZgdeASTbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 14:17:09 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 14:17:09 +0000
Message-ID: <6b062c90-e220-5e1f-1ef6-f1bbcdc8fb6e@amd.com>
Date: Wed, 12 Jun 2024 15:17:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 02/13] cxl: add type2 device basic support
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-3-alucerop@amd.com>
 <6669278d7fea_3101294e7@dwillia2-xfh.jf.intel.com.notmuch>
 <b48e9bf1-ccf2-2ac9-3389-4175ae872983@amd.com>
In-Reply-To: <b48e9bf1-ccf2-2ac9-3389-4175ae872983@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0170.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6b08bd-cb76-46ff-b58b-08dc8aea5828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmZsellHK0czMS84YTA3WjJ1ZXB0R1ZXZnRnMUNoS21mVEJ1Tm9MbitwamhE?=
 =?utf-8?B?RE1tUnRmU2ppdnNUYjV1eWNCSCtiNW55NWhSNlZTRTc1S1I2U0RmaDl3VFhq?=
 =?utf-8?B?QzhYM2w1OG9Mbk9pNXpUN3YxbU1JaGVINFpNRlJSOEI4cnNybzJCUUxFSnFo?=
 =?utf-8?B?eEFGeFlCS1dDbGVYdHMrc0ZYMmxpbU9ObURKcUZrYVdreEVMN255MkZUL1JQ?=
 =?utf-8?B?K2VHQ01tT0ZDREs5RUVCdWFyT1ZpaFRndlowdG9aaVlyQ0xHV3QyL1NXdGpi?=
 =?utf-8?B?dzlGZnN0SGpLdEpXd3lMOGFIMW55OUhma3o1SEpQSGpubUx2MFRxckFNWXZj?=
 =?utf-8?B?QUZLeU41dnZVL05iamVYU0dHbjVkVm5FSVErS2lZVTBLNXI2cFViR1pvUDZj?=
 =?utf-8?B?cklYSXY3dnBld1NBQmJVWFhrY0hOOEE1WFZPUW9xajYrR2ZVRlIwQk53RGpR?=
 =?utf-8?B?ZWNBYXJheklqbjZBWnl6YjZiV1V3cFkzcGdYSlZlNTJqZ1JlWlZ2L1M4Sk9i?=
 =?utf-8?B?WGJxNmpkNjRQendPM2dKK1hoK3NZMUVxdWJONkczRFFCMGVGNnduSDJIUDRE?=
 =?utf-8?B?TW5jb0ZSS3dWaFZrLzd6ZEJSL293dEZSa0llbnFQS1hmRzRDbUszR3pobkcw?=
 =?utf-8?B?eUhKeHJBVm81Njk4ZE9nbkRNcllPdmJoenJ0VU9JMS81Q1BCS0ZRWUVqVStG?=
 =?utf-8?B?RU9KWjdJMkcvZ3JhYVVySEFvMDhGUXpscjNNZHJFY1Yvc1d6dGRMa0RPRDk1?=
 =?utf-8?B?bWNsN09mL1JCRmxzcEZwYzdzZjgzVkRXb1dPWWMrYUdoRWZndEtmUktnZFda?=
 =?utf-8?B?YlJDeEZZRnpjR2Q5ZVpsSGt2Z0NabWVqZFF5bW1kR1hMMXBFSkd0eWhab3JH?=
 =?utf-8?B?NzRNNGhqWWRaY3JhamZSdGxpZVUxa1REZWFtejAvSWdqWE4vUVpXdjNXTkVs?=
 =?utf-8?B?cW9pWkJ1MlpJVnpQNVpTYnZtaHh6WW1sZ3RBZjNXYUN1NGRRVDBSMm5tbHlB?=
 =?utf-8?B?c3FjZldLcXF3dUtvYUpzRUVDbXpTT2VSQ3k5ZFRsdHBnOTBNdTRQSituZFo0?=
 =?utf-8?B?NEh2emNIWVJ6VzJ4MHJmd1V0RlU4NnJaRmRZWmJXdTlLU1k0Qzl3d3VpV090?=
 =?utf-8?B?TXZNckdVNFRvU3NCZ3BKL0F6aVZlNk1YTTZpWWRTaXFIY3JDOE4wUVBjZG95?=
 =?utf-8?B?ZW9Sd0lRM1pBV0lZWmRRNHpZZ0U5SVhURlRvbldMRndwK0xoTlBOWVJlcXpG?=
 =?utf-8?B?eTNOUUVrcyt3ZXJ4QXA5bGlHMW9tY29OU2lnZC85YjZaV0c4S2RMZisyWCtL?=
 =?utf-8?B?UWlyV3djNC84VklYa2x0T0RHaGpBT0xXRHJZQ1Z1VkQ2WHVLeUNPTlpPc244?=
 =?utf-8?B?aGJWdHAwTEQ0c0tlYkluSG5yTjIzYU11VEUreDZpcy9NUXJXZU51TUF5K2pG?=
 =?utf-8?B?QVJXUWhDa2N1VS9zNzUxMG9YYnl5RUJuVkIxajBnZE95VVpTMTVCRWVpUWt5?=
 =?utf-8?B?NWRWcnVGbXhrUjNJdk5va1ZrMC9nMEM0Z3VkQWc4U3UxMDgrRDVsUklZSlZY?=
 =?utf-8?B?cVo1eE93ZUtHemdSVzZ0czloc1h6T2hNVjlPVkpkbjlHV0FRL2p3eW9Pd1Zy?=
 =?utf-8?B?WkVaTnc4cGhNY3pPLzVNc0JERnZ2Zm5lYmh1T3NMNXBWQjdLV3Z5NDBsRGVW?=
 =?utf-8?B?NUdTWUZCQ3VUOGhFR1Z3TXlJaGJBOTc0cnVuNmI1bHpWQUtIcHh1QU4xQjA2?=
 =?utf-8?Q?fYCurr2uWuKZIrz+jmr1dqgWXytiwBEIyyY1BPj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXZMZkRHQkhJTGlDdExoaGhRU3FGU1NBcmpFbEFQNjN4R21nanRpN09yS1Ny?=
 =?utf-8?B?UUlYaW1CM1Q5TmFhL0Y2K2d6MjNTc1FmU21VWnM3Q3lYTzFHOTBSYTdtMHFP?=
 =?utf-8?B?MDI5U3oxbEYvL0dmQzdiTjJXbXhmaHU5cGExVWJWeWJZWTh6QU51K0NmWjFm?=
 =?utf-8?B?TGR2YTdvSHpUbHp0Y2FVL1o2OCswc1BNV2xBUkxuMGNNYzU2MzVXaTBHL2NL?=
 =?utf-8?B?NVA0N1lqamEyK1l4VnA5dUt3Mko5MFQrWmswKzdBaU9pZ3R3Q3poRnJVL2Jo?=
 =?utf-8?B?Rk04UnVVdTBXdG94V09pb2ZIelF1akVwUnRsdi9HMGlSQU5JaE1TMTI0N1Qr?=
 =?utf-8?B?TThIazhWUTVMTmNYOWJlRWxkSGt6dzgzMWpaWGI0ZkZqbDZMNnZnOFNzZ2lo?=
 =?utf-8?B?NXlOZnlabGRtZEdTTE5oQkFFNXU0Q2N3Z1haa3dHeUpWQzZtWjZoQVNiN3Vo?=
 =?utf-8?B?dFFaVlhGWVY0NHVObThhcjdTU3JPcXNCQlJmWEcydENlZ3VqbmJ4MVFzNmlw?=
 =?utf-8?B?YUtwSElBOUxJRFhXMXcxRFNsT1EwdVVoNjhSL1JLZzg5OVZYSnoyWTJON0hS?=
 =?utf-8?B?SlF3dGx5MHR1aGM0ZlUzQ1JIM2UwbUhaaVkxUzJqN2l0ZkhvQjk3MnJMeWFE?=
 =?utf-8?B?YVRDS3RiT0tOSE5pdVlGd2x5dHNsY1FZT2lqd1c4eVhsNk5QQzN5Yms0d2xr?=
 =?utf-8?B?Mkw2N29IaWEzK1o4cUlBSk5GaVBpK3BWQXNzcEE2WHlsUHJxck5SZ1E0MWFB?=
 =?utf-8?B?YWNodjBRVlptMVVFYzQrQkpiMWF4Ky92RHNlNThtQmtRdTJQSWxrZENGbURx?=
 =?utf-8?B?cEZUTmtiU3dNRDhrNnJFR0pFUFJvUmVxWThkMFIxU09XYlRlQ2pwQVkvbERa?=
 =?utf-8?B?b2JXc3pidmt4djNUNkJFNEFldit0dFFEYWE1Q1lGWmZWK1RGa3EydFRvL1hq?=
 =?utf-8?B?MFlhMDIwR2Q3dlR5UERQenRIWTRzSEdtQks1blkyUEZ5S0hPY0JXcVAvYnFk?=
 =?utf-8?B?aXI5NmNmVW5yc3dRWkk3RG85Vmk1SHBkeklBQXVKVHlkR2t0VGJXQ0V6ajVN?=
 =?utf-8?B?SzNLU1NjN1R6Qm5JOTNjcXdidThLdG1pMnNwR3loN0tFVG1mVHlnNnJKK2wy?=
 =?utf-8?B?S2t4OXlac2pUVUJsdnRDRmdmbVJtZ3BOTCtXL00xMGt0MkUyLzVDNW5aRXVD?=
 =?utf-8?B?L2NkVURWQWl0Smd0SGgxekdVS2t4bWpDbk02RUl6ekRRTnRDdkNlS29JRmRE?=
 =?utf-8?B?d1YzTEpHdjBERi9qRW1HMFdmaFRoaHFCMTkyYVR5OExjZjhZNVV3ZngvUjda?=
 =?utf-8?B?cWRGVzg3VmhuZjVuOVhabHVWaUlGZlcrbG9QaG5WZ1M3Mk1QRzVBZjRuUlQy?=
 =?utf-8?B?cW9HT3RpSm50d2V5WnFRc0VXd284QnFFM2kzQ0RHTG1JVUJRN2tNQmJUYzdv?=
 =?utf-8?B?T2lpMW95QUFQdjdqcXp1MGhMVHRkNkx3Z0RMV3cyZWxYYTRtZXlraXE5RCs0?=
 =?utf-8?B?TlBucTYzVnJHVzJONkRnRVpqbm9WOXB1TTBSY2txaU1BWW9zR1RmU1IyQ2po?=
 =?utf-8?B?citzMFR2RU9ueENaUWduMWlvY3VOcFFaR3JlWXZ4MUUzcUNBc0tvWXVCRFFV?=
 =?utf-8?B?di96M0FOcDhyWi9MUm9CVE9jYlZ0dUl1a0lOUld3UTg5Q3NFYUFmbnpSRE1q?=
 =?utf-8?B?VCtMN3FtR3djS1VySjZjMCtIeFAwYWhKaHcrUDV3UnUvaWtwdlhCTmcwdWF2?=
 =?utf-8?B?ZnJvZkZETk45SlBGQnUzYW9sd3o0TVVJdzcxMXNJSnBTOENtQ01XVnd2L3dM?=
 =?utf-8?B?TndFS0pyUWZjVVRabHlMcnBLOUV4aUtWcUZvR0FCYVRMd0NvcVlSYUd4U0Ix?=
 =?utf-8?B?Yml3ZGhBeXF4dXJKOTlDTmQxcWxIOEZJNmJvRjYrSG4vcVozWC8xWXMrM0VZ?=
 =?utf-8?B?cVRLUUc5NHcyWWdCUFBxT0JtN1pNOW5PNzdwS0h5em1YTmJ4WUtVZnluOUNu?=
 =?utf-8?B?d3Y1TkFtSHFqSE1uNzlXQUtGcERxcURCR2tFUHlFZ2dXbnVwSHAzN2lzK2hm?=
 =?utf-8?B?SHpFSGg4b1Jic01hWXkwaWZ1NlE3NXZQT3lsOEtJOXdYMDBTbmVSbTVGY29n?=
 =?utf-8?Q?5sk26cRCwwhMnX21VxvBF1ALv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6b08bd-cb76-46ff-b58b-08dc8aea5828
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 14:17:08.8194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KX3Mug9lNes7+2d/Tn+cF/9T/G5//w+cjkP+rYARdj+wpSgBi3gVSEhj3bNBXnXA/XnVJRtqmyh6QS6fUxr6SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665


On 6/12/24 07:04, Alejandro Lucero Palau wrote:
>
> On 6/12/24 05:43, Dan Williams wrote:
>> alucerop@ wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Differientiating Type3, aka memory expanders, from Type2, aka device
>> s/Differientiating/Differentiating/
>>
>> ...actually to make this imperative tense don't use gerund phrases, so:
>>
>> s/Differentiating/Differentiate/
>>
>> This "imperative tense" preference is borrowed from the x86 tip tree
>> patch recommendations [1], which reminds me that CXL should create a
>> document like that to make the grammar expectations known.
>
>
> OK.
>
>
>> [1]: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
>>
>>> accelerators, with a new function for initializing cxl_dev_state.
>>>
>>> Adding a type2 driver for a CXL emulated device inside CXL kernel
>> s/Adding/Add/
>>
>> I will also note that ChatGPT does a decent job at converting patch
>> changelogs to imperative tense.
>
>
> OK.
>
>
>>> testing infrastructure as a client for the functionality added.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> It would really help me out if the changelog mentions what you adopted
>> and what you modified. With a Link: to the patch where the code
>> originated.
>
>
> The patchset is mentioned/referenced in the cover letter.
>
> I will add individual references as well for any patch needing it.
>
>
>> I will still review the parts I wrote previously to see if I still agree
>> with them, but its taxing to come back to this patch cold and think "did
>> I write this routine, or is this new?". Can you repost with the
>> changelog commentary fixed up to reflect that?
>
>
> I'll do.
>
>
>>> ---
>>>   drivers/cxl/core/memdev.c           | 15 ++++++
>>>   include/linux/cxlmem.h              |  2 +
>>>   tools/testing/cxl/Kbuild            |  1 +
>>>   tools/testing/cxl/type2/Kbuild      |  7 +++
>>>   tools/testing/cxl/type2/pci_type2.c | 80 
>>> +++++++++++++++++++++++++++++
>>>   5 files changed, 105 insertions(+)
>>>   create mode 100644 tools/testing/cxl/type2/Kbuild
>>>   create mode 100644 tools/testing/cxl/type2/pci_type2.c
>>>
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index 07cd0b8b026f..0336b3f14f4a 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -659,6 +659,21 @@ static void detach_memdev(struct work_struct 
>>> *work)
>>>     static struct lock_class_key cxl_memdev_key;
>>>   +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>>> +{
>>> +    struct cxl_dev_state *cxlds;
>>> +
>>> +    cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
>>> +    if (!cxlds)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    cxlds->dev = dev;
>>> +    cxlds->type = CXL_DEVTYPE_DEVMEM;
>>> +
>>> +    return cxlds;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
>>> +
>>>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state 
>>> *cxlds,
>>>                          const struct file_operations *fops)
>>>   {
>>> diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
>>> index 0d26a45a4af2..e8d12b543db1 100644
>>> --- a/include/linux/cxlmem.h
>>> +++ b/include/linux/cxlmem.h
>>> @@ -859,4 +859,6 @@ struct cxl_hdm {
>>>   struct seq_file;
>>>   struct dentry *cxl_debugfs_create_dir(const char *dir);
>>>   void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state 
>>> *cxlds);
>>> +
>>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>>   #endif /* __CXL_MEM_H__ */
>>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
>>> index 030b388800f0..a285719c4db6 100644
>>> --- a/tools/testing/cxl/Kbuild
>>> +++ b/tools/testing/cxl/Kbuild
>>> @@ -69,3 +69,4 @@ cxl_core-y += cxl_core_exports.o
>>>   KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes 
>>> -Wmissing-declarations, $(KBUILD_CFLAGS))
>>>     obj-m += test/
>>> +obj-m += type2/
>>> diff --git a/tools/testing/cxl/type2/Kbuild 
>>> b/tools/testing/cxl/type2/Kbuild
>>> new file mode 100644
>>> index 000000000000..a96ad4d64924
>>> --- /dev/null
>>> +++ b/tools/testing/cxl/type2/Kbuild
>>> @@ -0,0 +1,7 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +
>>> +obj-m += pci_type2.o
>>> +
>>> +cxl_pci_type2-y := cxl_pci_type2.o
>>> +
>>> +KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes 
>>> -Wmissing-declarations, $(KBUILD_CFLAGS))
>>> diff --git a/tools/testing/cxl/type2/pci_type2.c 
>>> b/tools/testing/cxl/type2/pci_type2.c
>>> new file mode 100644
>>> index 000000000000..863ce7dc28ef
>>> --- /dev/null
>>> +++ b/tools/testing/cxl/type2/pci_type2.c
>>> @@ -0,0 +1,80 @@
>>> +#include <linux/module.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/cxl.h>
>>> +#include <linux/cxlpci.h>
>>> +#include <linux/cxlmem.h>
>>> +
>>> +struct cxl_dev_state *cxlds;
>>> +
>>> +#define CXL_TYPE2_MEM_SIZE   (1024*1024*256)
>>> +
>>> +static int type2_pci_probe(struct pci_dev *pci_dev,
>>> +               const struct pci_device_id *entry)
>> So to date, tools/testing/cxl/ has been for cxl_test which skips all the
>> PCI register emulation and just runs based on mocking core-kernel and
>> core-cxl interfaces. I would like to explore how far the cxl_test
>> approach can go and leave the PCI integration to when a driver can
>> reference real PCI ids.
>>
>> Otherwise, I feel like too much development effort can be diverted to
>> this "proxy" and increase the timeline to seeing the real thing.
>
>
> Fair enough.
>
> I think I could add the real driver in a new patchset version or maybe 
> a completely new one.
>
> From my previous comment about potentially using something like 
> auxbus,that would obviously mean a complete refactoring.
>
>
>>> +
>>> +{
>>> +    u16 dvsec;
>>> +
>>> +    dvsec = pci_find_dvsec_capability(pci_dev, 
>>> PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>>> +
>>> +    if (!dvsec) {
>>> +        pci_info(pci_dev, "No CXL capability (vendor: %x\n", 
>>> pci_dev->vendor);
>>> +        return 0;
>>> +    } else {
>>> +        pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability 
>>> found");
>>> +    }
>>> +
>>> +    cxlds = cxl_accel_state_create(&pci_dev->dev);
>>> +    if (IS_ERR(cxlds))
>>> +        return PTR_ERR(cxlds);
>>> +
>>> +    pci_info(pci_dev, "Initializing cxlds...");
>>> +    cxlds->cxl_dvsec = dvsec;
>>> +    cxlds->serial = pci_dev->dev.id;
>>> +
>>> +    /* Should not this be based on DVSEC range size registers */
>>> +    cxlds->dpa_res = DEFINE_RES_MEM(0, CXL_TYPE2_MEM_SIZE);
>>> +    cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, CXL_TYPE2_MEM_SIZE, 
>>> "ram");
>> Especially at this stage of the driver there is nothing that require
>> QEMU emulation versus cxl_test mocking.
>>

I did use a slightly modified qemu hw/mem/cxl_type2.c for adding 
CXL.cache bits, and planned to submit it for anyone interested in Type2 
development ...


>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void type2_pci_remove(struct pci_dev *pci_dev)
>>> +{
>>> +
>>> +}
>>> +
>>> +/* PCI device ID table */
>>> +static const struct pci_device_id type2_pci_table[] = {
>>> +    {PCI_DEVICE(PCI_VENDOR_ID_AMD, 0xbabe)},
>> Real vendor-ids should have real device-ids, also that particular
>> device-id choice is not appropriate.
>
And this is the PCI IDs used by such emulation. It is emulating a 
non-existing CXL Type2 device what I guess is more problematic than 
emulating a memory expander.

My interested was to test configuration and not any kind of emulated 
acceleration related to CXL.mem writes or reads, what could be a project 
by itself but not sure if useful at all.

If this is valuable, I will submit it. I think extending qemu CXL 
support for helping development could be really useful for all those 
things hard to test like interleaving and sooner or later, complex 
fabrics with a good number of CXL switches, plus x-FAM support.




