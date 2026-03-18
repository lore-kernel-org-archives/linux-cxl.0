Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7726F4A02
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819729; cv=fail; b=ewiETzztSGyenp211kshM6/HgooNG0TJeWfaQ1pVIycFgXdlG3wMGmKS3ZHCnBhJ6k4D5XqxIXZJnUOuqXcmtCx92RxOlPAWjqVnRduVHXp+kLUuiu7iXs9eNpQe632U13/Fr6SQDzu1EIu7wbOOZXehm/U37u272bqQFxJulNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819729; c=relaxed/simple;
	bh=2VG4W4fQ5hwoJNAizTKp7YiuATNAUdPeKjGNX2mEWIU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uXCLAix0AS/pjFDpcOroaMx1uLk2zeDcA8xYo9uT9OWMRHRiq6t9y9U94TNLzZt70bLADhuBH6vfjzuOIFaoR2vNEYxB/VdPTNTJbgbdNAauVbG4DcuYTgFXY+LOpitvYEdJ2GrS2E8lXY2qKMWXwErCsDXyJXB0RUrP2ep8Aac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mAB50G2Z; arc=fail smtp.client-ip=40.93.195.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mAB50G2Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/Js+42dKPS+PMLsqUJ24xZHd5FMKg8b2BxENYS+a7/BUD12jc1EtGNrhxzmM1bGWqL4LKOQgkSbhi3bihNrnm31GPP21/Enftrgnnrhkb4YS1zKU5IoMYp7uOsZU/20wcwckXfTznvPLaHbdHqfem9tvwtM4F0if+6pg7hWJw0ssRIBAPFUG1Dlc057gQlHt0U50RJrBOlV9QLIgou3hid4UI0Rqk9vc77gg0/9pjyntUdCyljgnMp0dLwYEwHnaN31228cmCqe1GO0l4R4zVBpBQ7TAy4ySwo8gVdXq/FnDBvS5wGxlmb77M6Uu8tQ8HMSjScInW5OVlwpfIGqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPRlEnqGhsArgu27W+G/W1WT9FHCjWnjq8/WtB4pwfk=;
 b=opsC6z+lcVdeGhp4weZZMPN96dgWqo2MOiqYUbVTqap5Da+x3Un1LlDd6ImKjc4lGiRwETM0fSQDmtl6CkDwfUKIvoFeWX/hac3/CV8WDDZfJTuhBOd0DXvjmmGgDZtuJnV5MBsP+8IHSL9pdA7HoQXRyzxPznfyPUmppbjTfXzsISav7KgJcmmkKbWg7QG4jP+z7JUB80BZdRld+bFqpFUnu9KGKBMrHcTGm6W9UszL6glmSpgxFtrDwnv5TNm5nyq0X46GAEAHbnYhMNDwYbrcuKnG2SRgKjkLwdQnYoRGkwaddTof7uJm4pE49+Tko/9652g96IiPeDOevGt5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPRlEnqGhsArgu27W+G/W1WT9FHCjWnjq8/WtB4pwfk=;
 b=mAB50G2ZchO6IB6FzqCpLf/poX+lPgnWnjD2wF/+REcign8BpzK7qh7vgEJf3aw0b2hJ9JoDBrsrvsEmNHTsM/kQKZ/ZwpRlcfpSrErh6gxLBkvKzZv3rD4e2YiFBWE/Sew1tgVENjJe0QwRoSwPAVTrZS3DHQAt5eDoHJ1Qd8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Wed, 18 Mar 2026 07:42:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 07:42:05 +0000
Message-ID: <652bacbf-6985-4bec-b973-684f2702765f@amd.com>
Date: Wed, 18 Mar 2026 07:42:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 00/22] Type2 device basic support
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, dan Williams
 <dan.j.williams@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <177370560728.3363103.17662978404400921244.git-patchwork-notify@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <177370560728.3363103.17662978404400921244.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 967003d8-3fdf-48de-32d9-08de84c1da1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	U55e8em3mumV7D5AVT/GR1AzZREQl1iSBdqFr7gCXPXHlHx3J+/ZNM3b5oSd3pV5eqXTQqEIq7kVSU0iYp6y5EwGHl109Sowg9+UilUDI++6JN5lXrUUs4yD6x8+ZAV4XbPCQ+4rWMEl61WwLQpdhT9NSfwpbbQIoNi199c/gXB+fAZ1blUTXj5Q5Yuo8Sz26ka5Vcp+Z1bGXZi3sXiDfg8RdxVQLR9QKcggLqilTFKM7njNkOFhq5GlUQ2xv0JN0lpl26jzAOUKJPjZjmDZr5Q/3qnhjVOuhUw7MxE37TS6QQ7WgSf0BZl1ToyoMw+8x3Tw+UVEcp0PjOUSsE/43HJaaOZTG2AFG2NRFnx0ItC01dxWzYPMu+uIk1R/AXH8fiebdL4umupWYrNT+cfSdhgvOKvJk/ADBuIqlCTqK8iL2E59cE8gAmAfk8Qg+/83IcMRf1jI2MvYr59SttYj2bNjLCDd8U7NCalgDfkpysD8yFQRTGJIGqZjP2S/0vpUtFn86+3uIBcVflpkJARpfLGXdHeecc2sY1tXEKRBavKT68Wd8mWgEtZJz6XYgr3kCayI9Ed81Oi9L/F8vq4lIjBtWpEfh1zWmrKACXK3L3jYtTeULZMZzq2n7aHt6xHycCMtxA/esxGA9wfKU2+5hhlxd0LyAhV7wVgyrs3d2TxCnlw1jmc8kHhK7eUBdwOR4fOFBv2J68QR9XdkR6zyPqzaOQo+/X2Cz6Ef43WzpfY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWFPZDE3YTRmRFR2S25XdDJRK0V3UnpBSHpYZ3V5eGpzeTRRRXU3UXVWMW9P?=
 =?utf-8?B?OFNkTXBockw5bGFzTzY2Q2ZFMUV2Vng4Mmw0Yk1lUGwxU2lTN1ByRjZNelFh?=
 =?utf-8?B?WGM0eFJmTmp0Slo0VzFoaTFpaGs4T04wa1hhOHYyTVR0UnJWc0pDNDJXS21p?=
 =?utf-8?B?eldrRTlLV0FjaU1jODYwWUxkcGhkSkk0TExlV2IyYUZNOFdZUSs3WWpnL2ZE?=
 =?utf-8?B?Y0VxaSs0UHp6eC9vOWp6ajRnY1VvaSsxVjdFR2ZKYnpIRmNoSEhUdjRVUjZE?=
 =?utf-8?B?MDZva1lnWUVoRnR1NnB5cUFKWXRJVTFyK08vYlRxSzVUR1Z0MTFxNlpWRGpz?=
 =?utf-8?B?Tk9ZU1BvaFRjMmFDQXgrdmhHdXczWTZyZXFnQWcrT0ZiTjdMeHBibUM5WWZD?=
 =?utf-8?B?RXBlbTVSOTdRNjgzYzRmSHhDVWlEMGsrMVFIYW5vYllCUDZuYjVzalRaQTg0?=
 =?utf-8?B?OTU2SjFySUMzNnNFUTdDOWQ0LzBnTy9GTmNzcE1MUFMwS1gzSEg3cS83QXRt?=
 =?utf-8?B?MDBQT1lyMDV6alpVc1BIMmYvQlhKeWtCUHBiZWFHOWp3M2szaTRBd2h0S2Na?=
 =?utf-8?B?ZTluZHBKc0xBZGpRT2RkTjQ4anp5NEVoUjl0NDFZVzQvNXQ1S0F0Z3ZZaXVV?=
 =?utf-8?B?VVc5b3gyRjcwWlYvcnhkbEU4dFN6M3pQOStISEdFVDlkZllDWE9DZ2Fqc254?=
 =?utf-8?B?MzQ1b25xZ05oSHpKM1N3Y0VFS3VMbWp3alpzMlN5YUJiZjhnelMyM0hnMXFN?=
 =?utf-8?B?WHZQamRvQ0lHRTY3MkttZCt4YllLcVl4c2xMVzF4SWo4VEIzZWwrT0JlSzM1?=
 =?utf-8?B?QjNySVNXN3VkRWpoVDdYT011VmFMNVFEMG9rVlY1Vi95bzFFMkVZUndKNkZ3?=
 =?utf-8?B?Z2x4TkFSSmZodVVwQzh4VFp1M0RlYUlyeHgrRWJOcFFNZTZrZndIMUI4WWlY?=
 =?utf-8?B?S0RIRkxodkw3UE9UUlVXdjdOSmNUTERlTTR6bDYvM3BJL3BHVi9RbjFkakl5?=
 =?utf-8?B?cHp3YjJlQlk3SS9lVXFmZnZmOUpwREhPeW5lUjY3ZFYxbTdYRmlBNVNCaGV6?=
 =?utf-8?B?cmk2YzdrWWtKTG9JeE1ONFMzcVd0NHJDdmxEdU1BL1V1dHVVK0xCY20xZDEx?=
 =?utf-8?B?VGJoWkg4S3VLYTBEdGdaajVIaUhhQWtYdVRrZXd3TmdRdXYwUmJHbGRUcERr?=
 =?utf-8?B?bHhsbmhRejZuSHpLT2h5K2wyZ21LUHdJbXBRNU45ZVVmWmVmY1orQ3FCek9Q?=
 =?utf-8?B?bFZJcEpWTVIxcUFKZUlDV0ozaVh3U1JmYTVkWTlzSmtwSWErdStWSkJKRFlY?=
 =?utf-8?B?N2FRV0hmTGw1c29PaW9XZmk2ZjZHL3MxbDFpckxFOU9jOHFQL09lbFFma0Fa?=
 =?utf-8?B?a0pFY0hweUdUb2orRkwrc0pOWjRnMEFrRlE0NTVYU3JnbDAweCsxdE9jd240?=
 =?utf-8?B?M3JkWHJUUHVNekdHMWptckNoSVJQcGJZNVR0MHptSlorM04yaXNGSXM4UUlL?=
 =?utf-8?B?UE44SE1mNWdUUHJrVFl6aWg4dWt6SGxRU3JxOVN6dTZ2VDZUTEc1QXR1QWsy?=
 =?utf-8?B?bWVPUnB5NGttdGNZY3Bpa0I0MWdLVDVmbE5GRmlBd3NxNXRrV0czdE4xN2tW?=
 =?utf-8?B?QTV2NFFBcGkxU2dvL2FXcEZneVl4SDBlN3BGbkhtTXNnTGhKN2pqTndta1Zh?=
 =?utf-8?B?eVAzdUh4dkROcDZyc3NaVlRhUVNWZTJxeEJEQUhpblNaMXBZdUQrR1dhZFhv?=
 =?utf-8?B?UjFLN2dkYzQrOVhiMXFUbURUa2ZzdUZiRm9DbzJXbVQ5NlU1ZW5rM3Q1WE9M?=
 =?utf-8?B?TDdXOUtrWVlFelNLRUFaVG1OVStzeXlWOU5YQlR3MzJ2Sk00anEwc3ZBdlpH?=
 =?utf-8?B?Yndta2xWQVJrTzRTdzRvMnJtNnNOZGxLTi9vejliMGMwb1hvRE1KZXU1aENr?=
 =?utf-8?B?ditBMDgyK0dId3dKYWlQMThXYTJpd1liMnd0N0tFT2RmSFkvaDdBUXJSKzRN?=
 =?utf-8?B?cHowREFJcWM1cklrdG1kL1ZpYVN3ZGdPMnlKZlM4bUUwUkV5dnhjVWNTSGhD?=
 =?utf-8?B?azBmSlRiLzNFdkZLbktlQWVjZUNoL1Vad1Z3OWZqclZXazJraHpORjMwVDhs?=
 =?utf-8?B?ME5hYjY2QVFkUVE1dmd6YUE4UTlkcUxBRGJGdFMrMlRObGpRMkhTWUkrUU12?=
 =?utf-8?B?UUdBZ3U0cjNKOWVDZmZLWGpMaFAxOUtrTUM3ekx2bksxUWphbWVWSys4bkNn?=
 =?utf-8?B?NEJEblNHRUpTUnZUK2wvZTZSb21xVFBNSDNpWnlCK1JiYkdTWDBRQXZYK0VW?=
 =?utf-8?B?NC9SOCtXcUlQeXZDeW8zYVkrWTZSd3dBdldNaGJGTE1mdlkxaGNpdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967003d8-3fdf-48de-32d9-08de84c1da1a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:42:05.7849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1KrO92SsiA3Nn/KDC53iWoSANFAHswZ2LXrGLjBDzy6LpNn8udqCztLs1UtG12Qxdz7WBtwU1g2IWYjtGCs1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272

Hi Dave,

On 3/17/26 00:00, patchwork-bot+cxl@kernel.org wrote:
> [You don't often get email from patchwork-bot+cxl@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hello:
>
> This series was applied to cxl/cxl.git (next)
> by Dave Jiang <dave.jiang@intel.com>:
>

I'm confused with how you did the merge. It seems you applied first the 
new patches which deprecated some from v23.


I'm afraid it does not work when trying to compile the sfc driver and 
some files are missing like include/cxl/pci.h


I will try to give you more information about what I think is wrong. On 
another note, sfc changes are not included, what I guess is fine, but 
did you discuss this with the netdev guys? I remember someone asking 
about how to applied the type2 series as it crosses subsystems, but it 
was time ago, after the first versions.


Thank you

