Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEFA823DE;
	Fri, 28 Mar 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743152569; cv=fail; b=d8u/Q7TolLMVfmd31Fd0cSLzoj3Xsuo6C1LsQ3gd17LJcKz3/vPkWtvFckq9F8ioBMV9rAMMin8DmAUkfbD1RRFUe94RvCgVfM35QPMttg+73Y6pOEJ0QB1JWKI1dUrSFZxYle1FT9WYC/HL1uad5t6ueOkh/ZGb7ZSLO241rXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743152569; c=relaxed/simple;
	bh=5V8OFFAB70Gjn9/LN8d8BOv0qxOy3jDZS63RIY0BmKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K9unWRMH74sZMnsKOuGh+/L7DjR7BCer0j5g19AZ21IDL+VpsLfIFJOas6C2hW3zyp+lXIgHseH/Pjm1y7FYMJNNmo26PU3da1S1zxvsD779tfZGFoMhlwNQlpDuB/bMK8iXi1G77og61Hp9ulhsDZvUO07xQI0YJSnK2zPkgmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ni2vGzv/; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ni2vGzv/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4kP94jtYuw6UXheOhmoe5Z2BV5PE67D/DIy1DIH/viSdTnVZnpGQcSibFVuJb56rg3kWCwJJ9rh4UEE6Tvxntd7dJRwsab/l7MhG9QkW3fFHLXuE4aIuVS8znsgCRJi+UTKNUE922HGElENKtrUTv1w83rn+QoBo6dkRswMybCh5a6DzeJHJT0yqODKQSpYozXFFm4n3HDHbwry6r2uzSgfK3g6Z7eACpsbX5b9VWYkEzFbShg4bMVlcHLgTQJ/lYwsgHicdS4Ic4QNV/LT53GP9hlXg80lWMw3fWY0nFkvD680apUbwOqsLvPrjBmQQpgxKVNH7uaO/KCwHWhazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQtBjbpLh6t5ZEgamQIlYg5VTWOaUWCKGhVVNSoebmg=;
 b=hBgbsJcHASAOlL0KjspOYVaVev1sAWCcJEx6TsMqWKcoT5/VwQjGUlDI2sL0mPeI/bF9VnE1MAU/26QqoGuXJ3cQR2aK0CtUyNmm9pCUt0nBExHLuDQ5C/Et6BT9LTprqijCYtWc9DZVkLBLCpkfDYKd9+IWUPL9W7RCuihqYxJ3ZZYudcjaPwCSdRa/JX1fnJ38yTwdSMacua+Vomm5RTakIhcr4LY3d+91kcE0yMoTWF/A5+/K+H5PYaLJagi9kSJ201pttORVqmUPN7E0zo2YHs/i7rJ2jLWNWEudVv2diZUijoWFeYK4/UBq5Mdn+HuGiTZ+wZ5PHbsBEXqqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQtBjbpLh6t5ZEgamQIlYg5VTWOaUWCKGhVVNSoebmg=;
 b=ni2vGzv/gXTRdqJQ1cS+T7ZspV8WgXbznrgYFULZdUt29JIwjxnHdp7j9GcXc8IB8WMEvGfvSPpe5K3GGAcq78o2ubSGDXO3zEBsohtHkHB8YIMI9rMRTrSNTBnez0bdgvEKMFYA3jJSPLN062GgAV3SVgfpXmYkltB5g6PJiSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 09:02:44 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 09:02:44 +0000
Date: Fri, 28 Mar 2025 10:02:38 +0100
From: Robert Richter <rrichter@amd.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/4 v3] cxl/core: Enable Region creation on x86 with Low
 Mem Hole
Message-ID: <Z-Zlrm8emmOtQjhu@rric.localdomain>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <Z91Au5en7r6D7IsW@rric.localdomain>
 <3301434.hkbZ0PkbqX@fdefranc-mobl3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3301434.hkbZ0PkbqX@fdefranc-mobl3>
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: e143c174-9684-410a-ea91-08dd6dd74d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3BWRGNYMHpDUXJxU1JGRWlmMjQ5OTVwTE9YcWlldHhORENqdHowQm1DTnkv?=
 =?utf-8?B?L2NwTGFnYjVTYkV3b3hxZUVvSis3anNOUnF0eWdCSEdFSDMycEFBUzV0ODQw?=
 =?utf-8?B?elFQeUpwbElNOVB4a2VrMjAvdW41ZG9mRkg1bTIvQ3duQnAzZkpDblB6a0xJ?=
 =?utf-8?B?bEh5aTN0UkQyZ0NtNi96akw4YXgyV0hkU0pQQXhZWWM0aFF3Nm43eDFXR3JP?=
 =?utf-8?B?VS92VENZSmEzNHVoSHFEUVFMcDMzQndqMlNoczFPRUtaaCtFZ3dGUytaaHJ1?=
 =?utf-8?B?ODZSVDQzUDNycldFSVN0SXV2YzlncVpTVWljSldsU1VKQTZjbi9kYmVDNHVB?=
 =?utf-8?B?TElnbyt6RTRZbTdCOE9GdVdENjhvQTZhRlp5WUJlU0cyUkJaanFZTTJnekJE?=
 =?utf-8?B?c3ZBSGVoZnltcjkrZzhTckNDckpxYStJL0JhNE96YWo5S09NRDdCeU8vazR2?=
 =?utf-8?B?WUZuNXBGNFQ2L3IxYVFCRDZSZFNNZk9XWnphVVVNR2lZdEhIbmNORnFJNzk4?=
 =?utf-8?B?SXlPTjBreFRjeFhZSUNPYW5DeEhQMGdJRnN4ODVLTUQ1d3E4NTgwbDV1NEF4?=
 =?utf-8?B?TmJIM2UyeW1ZTi9vWDJYRlhFZmpUdy9IY2FyNkhSSnpKT1VCMnFHem9uQXVF?=
 =?utf-8?B?TkhlUUtrT1BOV0daVEFVWTQ1cmlYaUZ0aXRINUhONVlMOHJqaFVzOXlQR2xh?=
 =?utf-8?B?ZzhaR1MwUGV6RmxvRHh4c045T3RwdVIyZDFLeUtkZ3hHNVVUUktMcFpkZzNK?=
 =?utf-8?B?ZEQrQWIzMDgrK2ZnL3lka1BrVkpyR0pXTjFPV0xyUFN6ZkhBSSs3N1o4Z1Jt?=
 =?utf-8?B?clQ3bnJubzYzbk94K0k2Smk0d2FYRjJEYTNiaFNKbUNoRUpuTXJPRCtoZ2Zt?=
 =?utf-8?B?eDhHaXQ0ekNXbTdrSitpblo1T0dBdm03d3ZqRDhUTG92dDBaMURuSW1Bem5y?=
 =?utf-8?B?MEYydXZLR0lWNkVnV3FWM3VqREt5dWFURWpZMDBZVWJ1bnlXMjloc0ZTeUg1?=
 =?utf-8?B?QlNuZk9SK253TFZrV0VVREU4NFVFaElmN0lJZ2xpM2NBbmp0c1d0SmpESFp3?=
 =?utf-8?B?SWd1a003Znh4VjMrYm1lUEdKVWRib045UEM5RjhhZzc2dUFSSHpBT1pZOGV2?=
 =?utf-8?B?cDc2V3BMTzF1cHJaYlUvUU81VCtrbFNQLzZSLzVLRWxDYURDd1JDdUpmSTJS?=
 =?utf-8?B?RzZoVFhuYVhhemJ2VGlTbG1TdG9TQ1c4bjdyTUl4ZHJVdVNNVE9maFB5VjNn?=
 =?utf-8?B?dk0vTTBTTk1mOUpYR0tqT0ZHUVF3ZDRVNHI3SE5KNUN0RGVhWmF6cHpuTi9K?=
 =?utf-8?B?ZTJiTHJvQ09RSXdsVTlucTZySGlrU3FucVdPeHpDa1R6NGtyU0N3K29kUkVn?=
 =?utf-8?B?anp3ZHFVMU4yWGhYcS9ZMEVvQlpGcWQ1WjJzZUVCOFpFbDk1aytOTTlkMi9W?=
 =?utf-8?B?Q24vS3FSeFB1UDF1UTh5dmZwSVlBUTczSmFlYmdraG1aZjBHQXIvQ0paejlQ?=
 =?utf-8?B?WmdyOUE5bThDcXQyenlSRUxCck9lZWtpbGpsMEJsOGtTOGtjYzR3czlwU0FX?=
 =?utf-8?B?N1MraU5SOWZocW1KU1M4MnhGMENlV0JtcUUwL0s5TngvbkYvM0JTY2F3VlpP?=
 =?utf-8?B?b0h4QWNXYUdFcEhxcldtNUxDYTkySnYrTTBEWHFnTmI1Q1pmVm5rTTFZUkZm?=
 =?utf-8?B?TnZXamVTcUkza01KbWZpaXBobEl0bHBSSk1jbUhaWEV4VmplRGU2SytMWEh4?=
 =?utf-8?B?MFdPWWEwVGp0b1BSVXJyYURJZm9HYVFqOERScmYwNmNveWpuOHVlYlJxRW5z?=
 =?utf-8?B?ejdxWUJqZUhnSmM1TXRrQkl4My82NnhBVzBiNGQ5TlRWNmxZNXF4NXpwSnps?=
 =?utf-8?Q?9H6fX+pLKNtKJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHhRTExvVzVnb252YkErZjJHTkgxRWlvMDliekY0L1VXaU5Hbm9tSmVGcVRv?=
 =?utf-8?B?V05FOEJKaTdRajRYTGNVQ0pUNVROZnNQVGUyTC9zelhEMjNXL3Mrd3M4UVM2?=
 =?utf-8?B?ai9MaDA1YXdGeVNjL0hiNjUrK28waVU3cEtWSUNRS2ZsVXl2Z0NzY2dHZ3Vo?=
 =?utf-8?B?SFU2cUJ1aUtWNW45akZuTEZJRC9KcEh0UHppVkl3OWdaUXUrZDhTN29LZzAw?=
 =?utf-8?B?S1NERjJxT1IwclFwVWFHdzZwU1pEU2Nacktnc0twOVp1TElTSThtcG01ZmpT?=
 =?utf-8?B?ajBsRnhLcTBCRE5Yb2dwanNpRnFhTndQanp0R1JHNVAyWE9rZWNLYnVLelQ4?=
 =?utf-8?B?akZ2L3RQY0c0alI2Njg2UE5tUm1RZGhXRkg5TTdpMnRHcU5DQmx4Zml4Wkt0?=
 =?utf-8?B?a1QrYnk3b0w0MC9RUmJaTjM1YWFtZDJod2sxTXNHNkFKbW9BajhsMVJKTnc2?=
 =?utf-8?B?L3FYSHg2WDVVeUl2WVRqLy9BejhQR2VpOHg4NndibmdsNmFWZFlnMHJSeWoy?=
 =?utf-8?B?RTVBWlNHSDc4TmFkRnNkajV4cU56T0tHbWdzdFg2a3FkKzYyTmJJR3Yvbzhj?=
 =?utf-8?B?a1owQmJVeitycklibXlwc2dVa01ITEpRRnVlQzk3VWc0MXVWSVZHTEtuRExs?=
 =?utf-8?B?QUo3SmR5NzBQUmVLVDZaL2dMeE9rL25WRzdTYUNOajJUbVB3bG5hU1d5cTNq?=
 =?utf-8?B?MS9pa3hYOHFHbDJ3QjZtOVR2b05NSFB4cks5NnFwY1FBbVB0SFZxR3RvOWtB?=
 =?utf-8?B?TWp3b1JjNituUnh5bXp0REtqaUVsaW1WR01tejI3dkEwREdjaTBkaGZ0ajlw?=
 =?utf-8?B?cTg5RmdweHpYdGRwOWw0MGhucFkrYU5SWWllT2lyS3d6NkFsVTA5LzFDOUdo?=
 =?utf-8?B?MmJ0K2dqNk8wUUUzZUFreldPUDg4dXczcGRMU0dCVGxsQmNSVXNUdzFiRk8z?=
 =?utf-8?B?REpsejJVUXZaQ2oxWktRUG5yRmRCWmJKeUlvZDJtdUZ1WkxYUzBVcU80QW1x?=
 =?utf-8?B?MGhMQkh2OFJnRVZyWjZScWJxenZqeVluUHRxeTQ1MGNUekVzQkFWTWRNT01F?=
 =?utf-8?B?UC9TUHUrWlZTSVlPS0RjQW8zQmtYaDZUb3pObjl3Vm02N2ZlSVpoQTVMQ0Ez?=
 =?utf-8?B?eEFkSEZ1YVV0dkJFYnZIeG9reDA2c1NEczRKanJNcG9IOXlQMEVwRnpveG56?=
 =?utf-8?B?dmdWQk5Yc2YxQXZqWGVsNXlRNGQzL2NESldsakMrZGVnbXJCZ1Y0ZmJiNmRK?=
 =?utf-8?B?U25oSDg2VVd2bzhZKzdMZEJNOVkrM0E4UjEvY0pLSlJ2QkhaVUVnVGtPdk9k?=
 =?utf-8?B?RzdtTWgvVmJaeENCSm9hMGdBb3R1dTJTTmhhbkVFNTBVYmNMN2E0M0Y4anBn?=
 =?utf-8?B?bWVjRFR4ZHpSYktVL3FDL0NYRy90ZGdzRG1Qb3NQbGNDOEJqNnpsR0ovZDM0?=
 =?utf-8?B?L1lVa3JBZHlWMFYwR3J1OE1ad21XMFlzdG82VCtHd1dNOGRNTFRBY1EwS21H?=
 =?utf-8?B?UnlPbVVWV0lDRmlydTA4UjAwTGI2ZlFWaUhENHhja0Q2WXFrLzFrRDZrZDRy?=
 =?utf-8?B?d3VLWlNQTzZkTnRoNUFRaW9xWTFyNStVMi9tcU5jQmpkdDVJd3F0aHlodlBn?=
 =?utf-8?B?RjBucXgySURHanhOcnMwZkg5RytUcFlzVU1kL2xEcTBVcXdzQmgyZ3lMRkJE?=
 =?utf-8?B?SVBDSXZXUzd2MFBpR1lOaTEwZzJaMXlrTDBmUCtZVUpxK0trV213aGdrOXVC?=
 =?utf-8?B?YytqUXZrOCtFZVpxdDNEcEZuOUtsMmM3RTVXcGVwNnpwdDZWWHFmS1kyUnd3?=
 =?utf-8?B?OEVVNmsxcm1PY0tQKzBzcDBLS1lzdVpFaG5sQ2c1L29TdUJ0U0VZT01oZ0Vq?=
 =?utf-8?B?STdocVVrSi8zWVgxVU4wNHlFNUcxcnBIZHU2QXFReWtTVnQrVUFXeE9wT3k3?=
 =?utf-8?B?T2VGRW5ZM0dYN2tkU2krQjJ5U29TcDZTamE4eHlWSUFIcUR3ZnZxQUphK3lo?=
 =?utf-8?B?L21yWE1VTm1QRzlrdi9CNFJTNUJXcmZCODFyejEyekYxOGY1L0ZIL0dFZC9U?=
 =?utf-8?B?RkZWVXBPOXY2WUQ5ZUZqTlNvRjFTS0ZGL1MrOUY3enJZczg0MHkxbFBXNUdm?=
 =?utf-8?Q?aP5V8n4lpTVCDV+o8K6d4vvcd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e143c174-9684-410a-ea91-08dd6dd74d54
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 09:02:44.2344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8MMzz3J+ceVBKEL5nq/iZqRxTvNjNhZBc8WKroqNHOZl2ykqxA+zxlAQ7aoqNsDmkFwqgkMwRBVO2AUMugj4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897

On 25.03.25 17:13:50, Fabio M. De Francesco wrote:
> On Friday, March 21, 2025 11:34:35 AM Central European Standard Time Robert Richter wrote:
> > Fabio,
> > 
> > On 14.03.25 12:36:29, Fabio M. De Francesco wrote:
> > > The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> > > Physical Address (HPA) windows that are associated with each CXL Host
> > > Bridge. Each window represents a contiguous HPA that may be interleaved
> > > with one or more targets (CXL v3.1 - 9.18.1.3).
> > > 
> > > The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> > > memory to which systems cannot send transactions. On those systems, BIOS
> > > publishes CFMWS which communicate the active System Physical Address (SPA)
> > > ranges that map to a subset of the Host Physical Address (HPA) ranges. The
> > > SPA range trims out the hole, and capacity in the endpoint is lost with no
> > > SPA to map to CXL HPA in that hole.
> > > 
> > > In the early stages of CXL Regions construction and attach on platforms
> > > with Low Memory Holes, the driver fails and returns an error because it
> > > expects that the CXL Endpoint Decoder range is a subset of the Root
> > > Decoder's (SPA >= HPA). On x86 with LMH's, it happens that SPA < HPA.
> > > 
> > > Therefore, detect x86 Low Memory Holes, match CXL Root and Endpoint
> > > Decoders or already made CXL Regions and Decoders to allow the
> > > construction of new CXL Regions and the attachment of Endpoint Decoders,
> > > even if SPA < HPA. If needed because of LMH's, adjust the Endpoint Decoder
> > > range end to match Root Decoder's.
> > > 
> > > - Patch 1/4 changes the calling conventions of three match_*_by_range()
> > >   helpers in preparation of 3/4.
> > > - Patch 2/4 Introduces helpers to detect LMH's and also one to adjust
> > >   the HPA range end for CXL Regions construction.
> > > - Patch 3/4 enables CXL Regions construction and Endpoint Decoders
> > >   attachment by matching Root Decoders or Regions with Endpoint
> > >   Decoders, adjusting Endpoint Decoders HPA range end, and relaxing
> > >   constraints while Endpoints decoders' attachment.
> > > - Patch 4/4 simulates a LMH for the CXL tests on patched CXL driver.
> > > 
> > > Many thanks to Alison, Dan, and Ira for their help and for their reviews
> > > of my RFC on Intel's internal ML.
> > > 
> > > Commenting on v1, Alison wrote a couple of observations on what users
> > > will see. I suggest anyone interested to see how this series affect
> > > users to take a look at her observations.[0] Thank you!
> > > 
> > > Changes for v3:
> > > 
> > >   Re-base the series on cxl/next.
> > > 
> > >   1/4 - 2/4:
> > > 	Constify local variables.
> > >   3/4:
> > > 	Call arch_match_region() from region_res_match_cxl_range().
> > >   4/4:
> > > 	arch_match_region() - Check that region end is under start + 4G;
> > > 	arch_match_spa() - Check that SPA range start is cfmws_range_start.
> > 
> > I have sent comments for version 1 and suggested a simpler approach
> > for this to implement.
> >
> I replied to your comments for version 1. Please find my message at 
> https://lore.kernel.org/linux-cxl/9930375.eNJFYEL58v@fdefranc-mobl3/.

The outcome was "I'll think about it.".

> >
> > My comments haven't been addressed yet,
> >
> I think it's not possible to detect an LMH while still in cxl_port_add().

Why is that not possible? I have outlined a solution before: Implement
a function to run platform specific port setup. Run a platform check.
Enable a platform dependend callback. Setup the port using platform
specifics.

> Therefore, I think that this is the best way to go. It works to prevent
> the driver to fail to create Regions and attach Endpoint Decoders on x86
> with Low Memory Holes, provided that the lower SPA range starts at 0x0.

An alternative works as well, that is not an argument.

> 
> On platforms with other kind of holes, the driver will continue to fail
> as it currently does. 

And those platform will then add more specific code and more
complexity in the main path other need to run? See, the code needs to
be encapsulated.

> >
> > but we
> > need better isolation to reduce interference with other platforms and
> > archs. Please take a look again.
> >
> Interference? Do you mean that this series would make the driver fail on 
> other platforms? 

No, other platforms must deal with that specific code and constrains.

> 
> Of course I don't want anything like that. I'm not clear about it...
> Would you please describe how would this series interfere and what
> would happen on other platforms?

Other platforms should not care about platform-specifics of others. So
again, use a platform check and only enable that code there necessary.
And this requires a well defined interface to common code.

Thanks,

-Robert

> 
> Thanks,
> 
> Fabio
> >
> > Many thanks,
> > 
> > -Robert
> > 
> 
> 
> 
> 
