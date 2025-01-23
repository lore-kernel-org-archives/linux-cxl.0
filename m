Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83D3F9C5
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652653; cv=fail; b=R72w6866UAZ09oYSl9ghDJ693W+ehVOAmkaC2sZPwweb65IMYKcz7KjX91fMdzd5ffjmZJTfrNGQybjwFCxlQmpf4OpMRbJjFaZ9cWDlIKoKI2KTExCKqhpSecU3DOaxVEaDOqKDdOfPClwP4DT8KfYYAkL5t9EPuU8Vr6r4V0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652653; c=relaxed/simple;
	bh=1LMU8iQ4PpWbEhNFVozi0sT8Mx07gTFSRDks8Gz2LmY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SW86knOkzHk2eLhegBBaN+m5n/RWETKJW4mBLtnJCrtQ9ZEInREQYE/ofbbJvxMZ6q+Rc5E1FyEO7lBrqElD5suTbm8l4TYgMXsyi2m3i1gTsq11ciwDtslI847+Ti2hGaOgb+tRYXponCmQHA1FtmMXi8Y4qPlSwLagzrJ/ALc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EKWZcnF3; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EKWZcnF3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/Qbj2x6vmDGfQXybjrgrLn4kyrz1aCRveSCs3dDoVDpwDG2Aja7YehmAibyvfO9SOuhHujArFIAslrbI+lOHjJMFs7Si15JTPffW8vJJJGrqEjVW5nwOCNO+wHdTv/Crtz11mvF7/7VsScuqmkwsBxMYJhCxos3ePGbBhPhfvG6eHmiOSRkty1+1b7X/Z/gYM56GRb5GqGRQ9B8CdF8qJznH03uPsHZ2rMDJ+ty0d9guKuFtlRIf3h7oBiPYCzeWpWuaAlUIUpPBuZWcGIv8weWlLzygFjBjhUtNem1CirTBTXZWR6+IdQOmeeVijtScLjFWzoRKaFnRt8nfRd6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k74KVxu24IBSykzamoh2hbeRFgR/h2gQzpHnt0fBYoM=;
 b=rwT48DQsLsC7hdpioHFP2kIM74wNeW8jFRrGb38uMaBRn2sqmeKmFk6CB8WHzGVMRV+rowT1xpBqT8iiN8v01Cf1Jr0Sj4+ap+U6tmSCeGNImPIUElCwZAouI/QlI5+syqve3sT7CkIewwc6khaHulH3dm3AOEmPshAUa9SV4x8Vz1I6tYisscAOabzUoxWO42CneVFuSl/R7+kPVuUBndi9XbQo7sJ1JbdkvuzKAaIebvrXHEHzEZYTWr2lFkcxsCNCLxCC4PDDkk7ibKLw592fWLpnqKH8fgd9aB5jwrBkYR2oE5Mjf+5WZahxLmieiXm4tE23EQgWszTOofn8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k74KVxu24IBSykzamoh2hbeRFgR/h2gQzpHnt0fBYoM=;
 b=EKWZcnF3q0DDgrBhUBvfISELqEC+SXRXy1YEDFy2tZxHJvM4mPo6SZj2ozwwDJD8gAyOy7INA/cLT1gJDMDDfzx1lCd95PEf+Gv7Nyo6yo5OzHOSeHMDME8/WcMExhBg8zQwxj069Wv8F7xoShdFtRD6YjDvua4E0kZq2SAp6K4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 17:17:28 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 17:17:28 +0000
Message-ID: <0020a489-5002-33a9-fc5c-58e46f581199@amd.com>
Date: Thu, 23 Jan 2025 17:17:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 36abc83b-0dcc-46e8-5c9c-08dd3bd1cfec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVFiaFVVQkJlbVZpZ0V2TnBicjBTV3drb2VIYXFuRnk1ZFo5MEh3aWx1Y2ZN?=
 =?utf-8?B?MHZ5MDliSTJyL00yVjZjUTc0K2JDYW0yQldkeHJuNW9JRTVXY3RGbGFJOWNN?=
 =?utf-8?B?UDdFYk9tcDk3bVA2cm1zdStsdjBYSlhxWG9ydHprMTVlcGhyUXRBWGFqZ0FV?=
 =?utf-8?B?SllHbmJMeHh0d2dHWDhyR1BBb29wWlI5MjcrMTN1WXZwT2UyZnhIRHl4SFRH?=
 =?utf-8?B?Ni93bjhWemlER0lqb0NtWldOdUFCakdtbDAybHhWVmh4TXBoanVNaDU0OEIy?=
 =?utf-8?B?OURSeEtBVHF5VjExQm8vK050SFBEeEV5MnpZbk5ISjdxSkpubUs0TVV3Uk80?=
 =?utf-8?B?Q2IwYTUydUhHUHdmWkJ6NURqUG5SK0phSFBWWldiYWZxY1JrMU9rN0ltOXZr?=
 =?utf-8?B?SG9sd2VzWHE2YTVrSFlKRFcxaTYydGorT1ZJZjMyak0yMFh5emw1ZDlVYVo3?=
 =?utf-8?B?Q2Q2Z1pjL2JYdDEwM3NuQWxnakZiekl3TTZyOFNkZmpzNlJKa3l2WFdkWjVr?=
 =?utf-8?B?d1lFZUdsMlNQdkhicC9sUHM1WVNGa1pNTVlXMHB1cDdWL3AzbVlEcTk2a1dv?=
 =?utf-8?B?MTJqeDBlUDdVbWtjMWtPM0hvbHN5dSsxYnJkVmNKK0w1djVVZkhYdXI2Vk5S?=
 =?utf-8?B?Ui82VkRHU3U0NWRWRW93Nm1TMDhNcDYxT2hGNmFYNTh1Y3JIWVRSRnlTZUox?=
 =?utf-8?B?WFpmRUdBUm5SdVM3eENvRHVLRUV0YXV3enhuVzNTNmt0U3J5VkJBMUE4RHJ1?=
 =?utf-8?B?YlBsb1I4eFpKZnl2djJVWExPV0VkZm1jek45bGdyc0xlVjJnOFVad1BhQnlU?=
 =?utf-8?B?WDhJSElPVkhrd0dROTBFU2JKazJBTEVLSUFPYjVoSExwT2hDT0ZrQXZPZGg4?=
 =?utf-8?B?UFBkbXJDN3RRNmoxQnFUbVFhN1hVYmpjcUp4d1ZoblF3STJoQ2lxOWJKRHlE?=
 =?utf-8?B?blY5Z21DQndLUVY3dHh1VFdwWlJJY2REUlkrVXcwblVicENqZkVzUExFSWZn?=
 =?utf-8?B?YW11bVRLNlhobWVSd0JzbFBvMnZYQmRyUzcyc3RUZXcvTU1KZllnQTAvaGh1?=
 =?utf-8?B?TkNRdmVXNGRLaTU5bEFVYVp4blBVVWxVNVFKWDVocEp4S29FSGloS0lxVk5j?=
 =?utf-8?B?K09mek5pblBnaElpem9oN01RTFR1bWRDTGl4OXF6ZEwvaVJzVjhIeWlZK05x?=
 =?utf-8?B?aUtyWGlxMWUzUUIvQnZpN0lCblp4TkZOOHVZSXVYV0hlS2VlYmJHOHZoTUh3?=
 =?utf-8?B?Y2J6YUNnYzE4aHBWakdON3Frc1NtWVJuZU0wUktVMkNpbWR0ak9xUkdkY2E0?=
 =?utf-8?B?cjBqNWJkR0J1cDJqWGEvVXlKRk91SDNhNC9EazFyYk8zTTVZU2xUdGxFUVdz?=
 =?utf-8?B?T2xBbk5hRjk4RVdCakVjdHZMby9JcEE0QUcvNFIwSXRPR3BnZ3N1aXNjRFBj?=
 =?utf-8?B?c3BJeUZmLyt3MHBFeUdFK2wzZ2lmaEdEOU1CWjhNdTJad2lTaFo2LzRqRmIw?=
 =?utf-8?B?OW9ZeCtxNmpBeGt6UHFtRGF6bnBZL1IvWXdpUEYvaVlPQkNNNFRUbWlKbFF3?=
 =?utf-8?B?cFNxeVZkU09QRGdlNUMzU0Jmdm5BWm93aFJNVjgrSk9vbFdQYk9jM3JKcTZD?=
 =?utf-8?B?TFNEVVAyVmhXNmMvbFZLbWhpWEo1Tlp1UWpkcUY1MURGUzlwbE9Kb3JNanBp?=
 =?utf-8?B?S3ZvRGtsUWlsOCtEb3VzQlJMNzRrZzRyUG5NVW5NdWhyYSs3aHM1cmxmeXlQ?=
 =?utf-8?B?SDJ5Z1dWMHdPclFQajVYZ2dlekZoc2cxSWVjWFIrWWpScXc5RXhxeVh0ZU5V?=
 =?utf-8?B?Ry9FNzdmQVdmSmdDOWpUdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTdFdzZrNmNNVHN4ZU9NMVZ6WmxRdlhWN29XMlN6aGlqdGErZFJNa3F2UnZW?=
 =?utf-8?B?VGgrOEEyd1lzS1VWV3crQTBSYXV2R2VXNU8zZURWOGRsckVMa1VoaHRkQ0Fq?=
 =?utf-8?B?Y0lxU2FtRWw2bUxYeER1RU1WVU00d01iemx6bFN0SXZZaEl6NjZsMWxGWHJQ?=
 =?utf-8?B?WnFvZ1hNOEFYMjdMWUN6VEZVVlZROFIya1V2aXozR2RQaDZGWVMybHBmdjhS?=
 =?utf-8?B?ZEhoSTEra0xjSXdyR1dBcThrTGFJVW5CNUJpMDNpZ000VHVJZXE1c1FnL1B1?=
 =?utf-8?B?ZTJKUHlRdjNRMktWQzZJZ2VCRGNrMjd1UGNIRUNiKzhDNGY5a0MyTWRzYjRr?=
 =?utf-8?B?WUc2KzdENTMzY1d6SHd2d0lWeFBRaCtEYW90VFdkbklteWpXZFB1WXBmdWZv?=
 =?utf-8?B?blRtRHNFUU5zTEhPVkFPRTlDazhLa2l1QmU3Mlp5U2NIVmZNZ3VJMFd1bWEx?=
 =?utf-8?B?SEV2VUpwUWFxSjF2TjZoTUdXYlpUKy9lZFpxQ0xrZGFQdyt2aEVKSlNpWkt4?=
 =?utf-8?B?TElWZHBhM2JiaEwzZEowSU1JVDJPZm1nWlV3elBoQjhHVk1RT1RheTZ3dFBQ?=
 =?utf-8?B?a0w0VzlWYWk3ZFk5UHBNRlRZRkxtVTFmMytxWlhja3ZuOU9mM3hzdlgvY2Jl?=
 =?utf-8?B?MkpIM0xzc2FzM1pEbkszaVdYU0tBVEV5TzY4NHFRcVNkT3ZndFRmQWk0YXFL?=
 =?utf-8?B?SmlyUHpkeHZnU1UrY3FVSzZ2WXJKT2h1ZmNqdVhMUk9GeGQwSDZCb3B5UU1y?=
 =?utf-8?B?Ui9KbUFidGloNnVYN1hxYnkySlBWQWY1WmZsUUhJTmtUWDRNQzlVbFpKK1ky?=
 =?utf-8?B?cmw3SzluMUwxWDBKY0FjSlVWZmtadFJiZStBM2E0NEs5eXVOREdmOWJia3k1?=
 =?utf-8?B?cGx6V2FOS2Ftejh5WHJVUGZjQ0c3bENsdEhJWWtlczZmSHI2SE1kalpHdnNP?=
 =?utf-8?B?VndmbzlwakpzWk1xTzdOYUhNTVpyREhEN1pVN0pRaFVEb0hkRktLelQ2Wm9k?=
 =?utf-8?B?SUcwOUdxSHVvQ1MxZUNNZVZSNm9kSUlpRTF4TzA5S1kxZzZTb2FCUzNlcWkr?=
 =?utf-8?B?cVJTVEp3TngybklWaDBDcklOcG1yQ2dTV2RYSEFCQ3k1M09lbDBaTTdwbjhx?=
 =?utf-8?B?SG9zVVlhZmR2ZWVGdnRlSGZ0Tm9ZRFlMNGdoMVBCUXJaSnZkRGdmWlJ3V0cz?=
 =?utf-8?B?STFXWHNGcG9VUVRMZWJDYmhEckdKV29BbVF3SW1IcThJZzVtSkxlNVFRYW9n?=
 =?utf-8?B?NllvWTBuVzh3bE1neE85MHllZVhwaGJGb3lwdEZZL2tNMXZIRE1KZzA3L280?=
 =?utf-8?B?U056aGxSNDB4KzhKSmx1UHZLQXhzM1M2Y1gzcFc2Y21ROUErTjRLeGRzeEUv?=
 =?utf-8?B?VnBCVDdyeUtXUTljSG40KzJNUS9VT2czLzNGa21LdUtmQmlBL05EUjVCRjlH?=
 =?utf-8?B?eWRtSTd1aDZIdzA1Zzl5TG11NHNvbVE2bDlHeDUwUzZyMWlXREtSSE03UG9R?=
 =?utf-8?B?NW5GQkxURGJoSFNydk9DWlB2UFV6VERIVDBUZCtiZnhISHJGeG9mVXZaZWZh?=
 =?utf-8?B?WlFBaEpQUHJkZlNXc2U2R3A5SEZmTDhWTnJNZUxGdGlVMnVXbWg4ZUZhMGc2?=
 =?utf-8?B?a1NJZzN4ZERwbGRLekFGdXU1MWNIQzdISjBNaDBCcU5tbmo0UUozc0ZHTzVW?=
 =?utf-8?B?NjR5T2ZuN1g0RTAxRzNxd1hFSFdqZzUrRHVtYmVDbU12U2JnWjhEMUNOS0pF?=
 =?utf-8?B?S3QvSVNxQVhUUzBHVU5sSjRBWDlwWGJ2Y2pSY2VmS0NoWUJEb21pSm83cnFt?=
 =?utf-8?B?RU04Vkh4YmEvZ3pGaTMxYkRadmR1R1BUSUN6MFZUbXd3d25TZkRZVjhXRi92?=
 =?utf-8?B?VTZhNTh3QjBiNitKN2FtZSttZHp3MTZlT1JNMnU1bjZWN3BYZ0FEVE5Sd3U3?=
 =?utf-8?B?NUNlSXlQZ2pDbzNZcVpWS0IydFJVVCtMeXF0Z0NWdjdlMzNhV1QrV09tTStn?=
 =?utf-8?B?ZUxFMnhxVitQK1Z0Y1dCRnQwSFhoN0cxWHBSOWx4bUpFRzcrT3pub2w3QXp5?=
 =?utf-8?B?eVZ5QVMrQi9KS0dPNUZzSlNYaGNWampLeHFZZjZxWVNvTVloQU53YTVsRVpk?=
 =?utf-8?Q?LVp0DINK5SK4A73XMn8TBVWv9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36abc83b-0dcc-46e8-5c9c-08dd3bd1cfec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:17:28.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLk+2ghCfP+QHieQnnVMkl8dt0e9FhuThxisWxy5wWcnWzrsTDxXdOg/C/DnwXISYNc+YUh5wOjUZUrPXX0Mhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890


On 1/22/25 08:59, Dan Williams wrote:
> The pending efforts to add CXL Accelerator (type-2) device [1], and
> Dynamic Capacity (DCD) support [2], tripped on the
> no-longer-fit-for-purpose design in the CXL subsystem for tracking
> device-physical-address (DPA) metadata. Trip hazards include:
>
> - CXL Memory Devices need to consider a PMEM partition, but Accelerator
>    devices with CXL.mem likely do not in the common case.
>
> - CXL Memory Devices enumerate DPA through Memory Device mailbox
>    commands like Partition Info, Accelerators devices do not.


Forgot to mention this one. Mailbox is optional for accelerators.


So maybe "but this way is optional for accelerators, implying 
accel-driver defined/hardcoded enumeration".



>
> - CXL Memory Devices that support DCD support more than 2 partitions.
>    Some of the driver algorithms are awkward to expand to > 2 partition
>    cases.
>
> - DPA performance data is a general capability that can be shared with
>    accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
>    suitable.
>
> - Hardcoded assumptions around the PMEM partition always being index-1
>    if RAM is zero-sized or PMEM is zero sized.
>
> - 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
>    memory property, it should be phased in favor of a partition id and
>    the memory property comes from the partition info.
>
> Towards cleaning up those issues and allowing a smoother landing for the
> aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
> array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
> way for Memory Devices and Accelerators to initialize the DPA information
> in 'struct cxl_dev_state'.
>
> For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
> get the new data structure initialized, and cleanup some qos_class init.
> Follow on patches will go further to use the new data structure to
> cleanup algorithms that are better suited to loop over all possible
> partitions.
>
> cxl_dpa_setup() follows the locking expectations of mutating the device
> DPA map, and is suitable for Accelerator drivers to use. Accelerators
> likely only have one hardcoded 'ram' partition to convey to the
> cxl_core.
>
> Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
> Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/cdat.c      |   15 ++-----
>   drivers/cxl/core/hdm.c       |   75 +++++++++++++++++++++++++++++++++-
>   drivers/cxl/core/mbox.c      |   68 ++++++++++--------------------
>   drivers/cxl/core/memdev.c    |    2 -
>   drivers/cxl/cxlmem.h         |   94 +++++++++++++++++++++++++++++-------------
>   drivers/cxl/pci.c            |    7 +++
>   tools/testing/cxl/test/cxl.c |   15 ++-----
>   tools/testing/cxl/test/mem.c |    7 +++
>   8 files changed, 183 insertions(+), 100 deletions(-)
>
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index b177a488e29b..5400a421ad30 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -261,25 +261,18 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>   	struct device *dev = cxlds->dev;
>   	struct dsmas_entry *dent;
>   	unsigned long index;
> -	const struct resource *partition[] = {
> -		to_ram_res(cxlds),
> -		to_pmem_res(cxlds),
> -	};
> -	struct cxl_dpa_perf *perf[] = {
> -		to_ram_perf(cxlds),
> -		to_pmem_perf(cxlds),
> -	};
>   
>   	xa_for_each(dsmas_xa, index, dent) {
> -		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> -			const struct resource *res = partition[i];
> +		for (int i = 0; i < cxlds->nr_partitions; i++) {
> +			struct resource *res = &cxlds->part[i].res;
>   			struct range range = {
>   				.start = res->start,
>   				.end = res->end,
>   			};
>   
>   			if (range_contains(&range, &dent->dpa_range))
> -				update_perf_entry(dev, dent, perf[i]);
> +				update_perf_entry(dev, dent,
> +						  &cxlds->part[i].perf);
>   			else
>   				dev_dbg(dev,
>   					"no partition for dsmas dpa: %pra\n",
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7a85522294ad..3f8a54ca4624 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -327,9 +327,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   	cxled->dpa_res = res;
>   	cxled->skip = skipped;
>   
> -	if (resource_contains(to_pmem_res(cxlds), res))
> +	if (to_pmem_res(cxlds) && resource_contains(to_pmem_res(cxlds), res))
>   		cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(to_ram_res(cxlds), res))
> +	else if (to_ram_res(cxlds) && resource_contains(to_ram_res(cxlds), res))
>   		cxled->mode = CXL_DECODER_RAM;
>   	else {
>   		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> @@ -342,6 +342,77 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   	return 0;
>   }
>   
> +static int add_dpa_res(struct device *dev, struct resource *parent,
> +		       struct resource *res, resource_size_t start,
> +		       resource_size_t size, const char *type)
> +{
> +	int rc;
> +
> +	*res = (struct resource) {
> +		.name = type,
> +		.start = start,
> +		.end =  start + size - 1,
> +		.flags = IORESOURCE_MEM,
> +	};
> +	if (resource_size(res) == 0) {
> +		dev_dbg(dev, "DPA(%s): no capacity\n", res->name);
> +		return 0;
> +	}
> +	rc = request_resource(parent, res);
> +	if (rc) {
> +		dev_err(dev, "DPA(%s): failed to track %pr (%d)\n", res->name,
> +			res, rc);
> +		return rc;
> +	}
> +
> +	dev_dbg(dev, "DPA(%s): %pr\n", res->name, res);
> +
> +	return 0;
> +}
> +
> +/* if this fails the caller must destroy @cxlds, there is no recovery */
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> +{
> +	struct device *dev = cxlds->dev;
> +
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +
> +	if (cxlds->nr_partitions)
> +		return -EBUSY;
> +
> +	if (!info->size || !info->nr_partitions) {
> +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> +		cxlds->nr_partitions = 0;
> +		return 0;
> +	}
> +
> +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
> +
> +	for (int i = 0; i < info->nr_partitions; i++) {
> +		const struct cxl_dpa_part_info *part = &info->part[i];
> +		const char *desc;
> +		int rc;
> +
> +		if (part->mode == CXL_PARTMODE_RAM)
> +			desc = "ram";
> +		else if (part->mode == CXL_PARTMODE_PMEM)
> +			desc = "pmem";
> +		else
> +			desc = "";
> +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> +		cxlds->part[i].mode = part->mode;
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
> +				 part->range.start, range_len(&part->range),
> +				 desc);
> +		if (rc)
> +			return rc;
> +		cxlds->nr_partitions++;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_dpa_setup);
> +
>   int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   				resource_size_t base, resource_size_t len,
>   				resource_size_t skipped)
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 3502f1633ad2..62bb3653362f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1241,57 +1241,39 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>   	return rc;
>   }
>   
> -static int add_dpa_res(struct device *dev, struct resource *parent,
> -		       struct resource *res, resource_size_t start,
> -		       resource_size_t size, const char *type)
> +static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
>   {
> -	int rc;
> +	int i = info->nr_partitions;
>   
> -	res->name = type;
> -	res->start = start;
> -	res->end = start + size - 1;
> -	res->flags = IORESOURCE_MEM;
> -	if (resource_size(res) == 0) {
> -		dev_dbg(dev, "DPA(%s): no capacity\n", res->name);
> -		return 0;
> -	}
> -	rc = request_resource(parent, res);
> -	if (rc) {
> -		dev_err(dev, "DPA(%s): failed to track %pr (%d)\n", res->name,
> -			res, rc);
> -		return rc;
> -	}
> -
> -	dev_dbg(dev, "DPA(%s): %pr\n", res->name, res);
> +	if (size == 0)
> +		return;
>   
> -	return 0;
> +	info->part[i].range = (struct range) {
> +		.start = start,
> +		.end = start + size - 1,
> +	};
> +	info->part[i].mode = mode;
> +	info->nr_partitions++;
>   }
>   
> -int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>   {
>   	struct cxl_dev_state *cxlds = &mds->cxlds;
> -	struct resource *ram_res = to_ram_res(cxlds);
> -	struct resource *pmem_res = to_pmem_res(cxlds);
>   	struct device *dev = cxlds->dev;
>   	int rc;
>   
>   	if (!cxlds->media_ready) {
> -		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> -		*ram_res = DEFINE_RES_MEM(0, 0);
> -		*pmem_res = DEFINE_RES_MEM(0, 0);
> +		info->size = 0;
>   		return 0;
>   	}
>   
> -	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
> +	info->size = mds->total_bytes;
>   
>   	if (mds->partition_align_bytes == 0) {
> -		rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
> -				 mds->volatile_only_bytes, "ram");
> -		if (rc)
> -			return rc;
> -		return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
> -				   mds->volatile_only_bytes,
> -				   mds->persistent_only_bytes, "pmem");
> +		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
> +		add_part(info, mds->volatile_only_bytes,
> +			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
> +		return 0;
>   	}
>   
>   	rc = cxl_mem_get_partition_info(mds);
> @@ -1300,15 +1282,13 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>   		return rc;
>   	}
>   
> -	rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
> -			 mds->active_volatile_bytes, "ram");
> -	if (rc)
> -		return rc;
> -	return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
> -			   mds->active_volatile_bytes,
> -			   mds->active_persistent_bytes, "pmem");
> +	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
> +	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
> +		 CXL_PARTMODE_PMEM);
> +
> +	return 0;
>   }
> -EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>   
>   int cxl_set_timestamp(struct cxl_memdev_state *mds)
>   {
> @@ -1452,8 +1432,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>   	mds->cxlds.reg_map.host = dev;
>   	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>   	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> -	to_ram_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
> -	to_pmem_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
>   
>   	return mds;
>   }
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index c5f8320ed330..be0eb57086e1 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -80,7 +80,7 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = resource_size(to_ram_res(cxlds));
> +	unsigned long long len = cxl_ram_size(cxlds);
>   
>   	return sysfs_emit(buf, "%#llx\n", len);
>   }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 78e92e24d7b5..15f549afab7c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -97,6 +97,25 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   			 resource_size_t base, resource_size_t len,
>   			 resource_size_t skipped);
>   
> +enum cxl_partition_mode {
> +	CXL_PARTMODE_NONE,
> +	CXL_PARTMODE_RAM,
> +	CXL_PARTMODE_PMEM,
> +};
> +
> +#define CXL_NR_PARTITIONS_MAX 2
> +
> +struct cxl_dpa_info {
> +	u64 size;
> +	struct cxl_dpa_part_info {
> +		struct range range;
> +		enum cxl_partition_mode mode;
> +	} part[CXL_NR_PARTITIONS_MAX];
> +	int nr_partitions;
> +};
> +
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
> +
>   static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>   					 struct cxl_memdev *cxlmd)
>   {
> @@ -408,6 +427,18 @@ struct cxl_dpa_perf {
>   	int qos_class;
>   };
>   
> +/**
> + * struct cxl_dpa_partition - DPA partition descriptor
> + * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
> + * @perf: performance attributes of the partition from CDAT
> + * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> + */
> +struct cxl_dpa_partition {
> +	struct resource res;
> +	struct cxl_dpa_perf perf;
> +	enum cxl_partition_mode mode;
> +};
> +
>   /**
>    * struct cxl_dev_state - The driver device state
>    *
> @@ -423,8 +454,8 @@ struct cxl_dpa_perf {
>    * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>    * @media_ready: Indicate whether the device media is usable
>    * @dpa_res: Overall DPA resource tree for the device
> - * @_pmem_res: Active Persistent memory capacity configuration
> - * @_ram_res: Active Volatile memory capacity configuration
> + * @part: DPA partition array
> + * @nr_partitions: Number of DPA partitions
>    * @serial: PCIe Device Serial Number
>    * @type: Generic Memory Class device or Vendor Specific Memory device
>    * @cxl_mbox: CXL mailbox context
> @@ -438,21 +469,47 @@ struct cxl_dev_state {
>   	bool rcd;
>   	bool media_ready;
>   	struct resource dpa_res;
> -	struct resource _pmem_res;
> -	struct resource _ram_res;
> +	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> +	unsigned int nr_partitions;
>   	u64 serial;
>   	enum cxl_devtype type;
>   	struct cxl_mailbox cxl_mbox;
>   };
>   
> -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +
> +/* Static RAM is only expected at partition 0. */
> +static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +{
> +	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
> +		return NULL;
> +	return &cxlds->part[0].res;
> +}
> +
> +/*
> + * Static PMEM may be at partition index 0 when there is no static RAM
> + * capacity.
> + */
> +static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> +{
> +	for (int i = 0; i < cxlds->nr_partitions; i++)
> +		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
> +			return &cxlds->part[i].res;
> +	return NULL;
> +}
> +
> +static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
>   {
> -	return &cxlds->_ram_res;
> +	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
> +		return NULL;
> +	return &cxlds->part[0].perf;
>   }
>   
> -static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> +static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
>   {
> -	return &cxlds->_pmem_res;
> +	for (int i = 0; i < cxlds->nr_partitions; i++)
> +		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
> +			return &cxlds->part[i].perf;
> +	return NULL;
>   }
>   
>   static inline resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
> @@ -499,8 +556,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>    * @active_persistent_bytes: sum of hard + soft persistent
>    * @next_volatile_bytes: volatile capacity change pending device reset
>    * @next_persistent_bytes: persistent capacity change pending device reset
> - * @_ram_perf: performance data entry matched to RAM partition
> - * @_pmem_perf: performance data entry matched to PMEM partition
>    * @event: event log driver state
>    * @poison: poison driver state info
>    * @security: security driver state info
> @@ -524,29 +579,12 @@ struct cxl_memdev_state {
>   	u64 next_volatile_bytes;
>   	u64 next_persistent_bytes;
>   
> -	struct cxl_dpa_perf _ram_perf;
> -	struct cxl_dpa_perf _pmem_perf;
> -
>   	struct cxl_event_state event;
>   	struct cxl_poison_state poison;
>   	struct cxl_security_state security;
>   	struct cxl_fw_state fw;
>   };
>   
> -static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
> -{
> -	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
> -
> -	return &mds->_ram_perf;
> -}
> -
> -static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
> -{
> -	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
> -
> -	return &mds->_pmem_perf;
> -}
> -
>   static inline struct cxl_memdev_state *
>   to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>   {
> @@ -860,7 +898,7 @@ int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>   int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>   int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>   int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
> -int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>   struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
>   void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>   				unsigned long *cmds);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0241d1d7133a..47dbfe406236 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -900,6 +900,7 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_dpa_info range_info = { 0 };
>   	struct cxl_memdev_state *mds;
>   	struct cxl_dev_state *cxlds;
>   	struct cxl_register_map map;
> @@ -989,7 +990,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_mem_create_range_info(mds);
> +	rc = cxl_mem_dpa_fetch(mds, &range_info);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_dpa_setup(cxlds, &range_info);
>   	if (rc)
>   		return rc;
>   
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 7f1c5061307b..ba3d48b37de3 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1001,26 +1001,19 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
> -	const struct resource *partition[] = {
> -		to_ram_res(cxlds),
> -		to_pmem_res(cxlds),
> -	};
> -	struct cxl_dpa_perf *perf[] = {
> -		to_ram_perf(cxlds),
> -		to_pmem_perf(cxlds),
> -	};
>   
>   	if (!cxl_root)
>   		return;
>   
> -	for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> -		const struct resource *res = partition[i];
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		struct resource *res = &cxlds->part[i].res;
> +		struct cxl_dpa_perf *perf = &cxlds->part[i].perf;
>   		struct range range = {
>   			.start = res->start,
>   			.end = res->end,
>   		};
>   
> -		dpa_perf_setup(port, &range, perf[i]);
> +		dpa_perf_setup(port, &range, perf);
>   	}
>   
>   	cxl_memdev_update_perf(cxlmd);
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 347c1e7b37bd..ed365e083c8f 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1477,6 +1477,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	struct cxl_dev_state *cxlds;
>   	struct cxl_mockmem_data *mdata;
>   	struct cxl_mailbox *cxl_mbox;
> +	struct cxl_dpa_info range_info = { 0 };
>   	int rc;
>   
>   	mdata = devm_kzalloc(dev, sizeof(*mdata), GFP_KERNEL);
> @@ -1537,7 +1538,11 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_mem_create_range_info(mds);
> +	rc = cxl_mem_dpa_fetch(mds, &range_info);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_dpa_setup(cxlds, &range_info);
>   	if (rc)
>   		return rc;
>   
>
