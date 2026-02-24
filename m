Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BA3A4F47;
	Tue, 24 Feb 2026 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949745; cv=fail; b=ajDHiDG3iis0klpsaTvhvjCd0pyK7kTqIlHILUL21kn/Tt+Y2riT7qOZeVdf3RbdyEly0oBUTZ4i7DJZtDVfTKifSYJ0F6VEN+pYcVMDoJMpkOXwvsHzmKnDbu/uOOeprM20qtQ1utBuKGY/fJA3z+UTNc23deKRgvQsZpRpT3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949745; c=relaxed/simple;
	bh=Bqjs8KujZIwWadrt9W1q9sFCvPZB2QkTUHV/4TPJmdU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=umkcziUHk+AjUjhv29cwyU3ZwRB7A+DnjO3f5xpCu5XHZa76rtA8u9Fgy4po8NscyhLs1AbjTiuUiMpfhaNz5UZjZIQBoVF9VJAFVRQvQKDOwZ1JiWdbC8I16QbiMYzcY5rqym5NjzuXsH+jm14x7LA7ls8cFDDs95RDY10eidg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IG+Jz0gC; arc=fail smtp.client-ip=52.101.62.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IG+Jz0gC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pl4lKcCbYnIKC23uVnaJrBzWyZ5OwbP8DiUz7n+jMeXEJAY/1EqCpacLMS3KwhY8meAr7YYvnQUB213P9aNE/4RslcwhOx7xUkNrLrVG6SjjejsWJo1vL9fyNGjnHCBYv9y8QSrA2+qjrd5Ffi5Hyj1ohPX30V6Yil9uyjyO59qqBVfFcCNvtLsB3J1UoxgOHvREnK0cQWnK6+0YHVfD8P6Clwk/qm16efQcrwYegicbPcI3+5zf4dUwxFqeDOJk1j/eT42W/xyl1YiHctl2ceWxKAj6yVCIvz2e+stf+uEbph2oNgE1oth34hPIOBGBUiwlRjfJOwpO2qvpXC06nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGfl4LTI5qNE2fRaL06xBHCUL9b7GNvKP+kkt5ZgpTY=;
 b=KtptDewny+QSk8h8FYbjTjBeijK7p21zv5np9L1oc8OfDN87qOzMtLB3MbqgeJx3DLhl+uwjD79BZEgq1T4dAFvkMf5lrqn+l3VsqrCr7sfNfXPoCdtMqqBoiSikOuvWf+gGAaeue5AU/A+7+lIbRenkzErBRifU9herJTQ66FjLn+T1myObpCdkQYFxND9eRdByEymdQyqNNE1fUb8sOROO0MlMvyWdCGsc+AzmdJdqaRa60YBBKnxD0RWm8W+FTsabu+j/YipwxtLgyaPtr7IZo9KLt30md9lnM0hgeRr5wiZ81pmpoXRxokp9O7auHS9lzxZD9vFJKWj+NcSK4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGfl4LTI5qNE2fRaL06xBHCUL9b7GNvKP+kkt5ZgpTY=;
 b=IG+Jz0gCT6L3w64dSzYmmLAesVuUi9ZdtD/V1qBSLlr5rTaMUsGoFXGJKFY0UrELaZ8Y4aZ+XxG+RhpH7/GkS6MFDZot2xy5crXEprERluaTOZRe0RYRYAudNxvqAVB2yc5//XNHJu5XQIqyJ9MskEXQEwom73mY3pbOkEVpD4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:15:38 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:15:38 +0000
Message-ID: <87347db6-6838-4a60-ad1c-037f526f16b6@amd.com>
Date: Tue, 24 Feb 2026 16:15:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cxl/region: fix region leak when attach_target fails
 in cxl_add_to_region
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20260221043013.1420169-1-gourry@gourry.net>
 <aZk_9iYMh2QPYNDz@gourry-fedora-PF4VCD3F>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aZk_9iYMh2QPYNDz@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c7ba40-e3b5-44d1-2a84-08de73bff29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFM0bnF1NS82N3RUNy93WnFPL3hmTHdUQzRNeStqaWJRTTR0RGJXN1VMK3pK?=
 =?utf-8?B?aUxhcEV3RzhLbjRNNmJyL2hxL2N0YUlzYzVjSmd4UXE2MnRoQ1ZvVVdTalpS?=
 =?utf-8?B?WGZIN0Z4UHpLeGRMWHhjeEpSMms4bUFaNnZjeS9CL2F1bjUwZHNycEpoTDRE?=
 =?utf-8?B?NUl3eDVIQzkxQ1Vxa1dKallyamhSYTBRNTBMc1BHSC9Vd0NORjkvZjZ6ancw?=
 =?utf-8?B?SkZ5L01KSzRSQkNUSGFpZkR2YmtWTFFCV09CdithMCtzNFEwSTRkS1BWcU41?=
 =?utf-8?B?MWd4UTVzbHhMZ2I3cTN4S0llcEpYcEthNWErWktCdTFqN0s1SkxmZDQxTUJT?=
 =?utf-8?B?ZFFHQXJYejk5M080VWVaSGFyVXNiRmZnV3NDRnp4Q1pKallYbjVJUHo2QUVV?=
 =?utf-8?B?YjNSMlB1eGNERlF6K1IvN3lkSlhHbHd3OWVUL2JTWU43Q0FnMzRSTDFneFg1?=
 =?utf-8?B?Wm9CVjdBZzg4K3V0U2NZUHJVcy9XZnhpNzYxSDg5NlRmOStEM3QxbTMrY2No?=
 =?utf-8?B?eTBWQkNJd0EwUzVwSUtsbmg0bzJBc1FpYmNvTlRXN0YzMEo5SFdNZG1MRHVt?=
 =?utf-8?B?N0lDVUxteHFpOHdoc3pMNFIvckJIZXNzQ1plV2E3MnR4WXBZY21YYm80amRM?=
 =?utf-8?B?eUtHMWNIY0YwNkd1aDAyK05ZVWFwRXhzVFhOb3NJQ0hOUjNrS3BtTUdzYWdW?=
 =?utf-8?B?eVk3bTR2K29vOG8rYVZDSWZqMFVNd0U0MTZHWjJiTjMvSEUydVJDU05zSWkr?=
 =?utf-8?B?Zk02dHJSQlV4dTM1MERUb2ZUb3NhTHR5d3MwWmhjQWUyMUxJM1NLSGpzSnV1?=
 =?utf-8?B?ZGdkc282RTdTbjAxYnVObjJjYXhtRldOWEx5ZTZJbG9ncGZjbzdRVzlqYmFx?=
 =?utf-8?B?dUlkK1l1cG0yY3lwUGZvaElia2FEbWlJWS8xVkhDWis0TWtIZVFRNFI0QWFs?=
 =?utf-8?B?eVU1K20wNnY2SEZkT2NweHR2MTB4bjNQdERCZmw0M3NKWnJnNWtieGsyU2pT?=
 =?utf-8?B?anlmUFEwL3FyQnBQeWJ1SkJkWm5NNVJDckxkUlNlWWJnRlZNM3h6V2xhRDdH?=
 =?utf-8?B?K3BxNGtKWFNocUdYSmdXTHZPQ0NVMWtiYXkyejFaL1REQjlBWFFISjZJN3ds?=
 =?utf-8?B?Q0R3TUcyVVJ3cHA1MHBKQnRMbjlXcHNXSHJLeHF1bnBjODE2WG8rNnRFdXJD?=
 =?utf-8?B?NzQ2NGg4bTdJZ0ZlcG9nM2g0TUI2MXpCRGIrQVVQelRJSWZkVUpLWUFSMlFH?=
 =?utf-8?B?QkdyZktTOUNRVExZRysxRnFDZWRiMTJFcFhwSjlnU3N0K0NlMW01T3liWnFt?=
 =?utf-8?B?WTgwYm9SaVFJTHp0eXluRmVVY1BSYVovSGtlQnN3WWQ3Wi9BRWVvOHBIZUlH?=
 =?utf-8?B?ZVpXbTgwVlFSS3g5NTVGeTVNMUlmMkRkOFlybG5vUnhnRGx4NStMWHpNQkp2?=
 =?utf-8?B?M3gxc1RGdCtFNldWVDNZNWNabmM4dHVlWDNiVTQ2RE5WTUovNGZjVWdGOFln?=
 =?utf-8?B?NkkxR1JDMFZNM3FwRFZnNCtQMjd5WHpTS0I0NC9pZ1dEOVhPNVJPMlkrWVdx?=
 =?utf-8?B?MlRzdWJzS3pJK0FrQUdEVWJMdzBHWS9yKy9yd2F6QnFFMU5VcDQzVUZYNmRB?=
 =?utf-8?B?c2l6MENJaEpodHEvZ1BUVHdHWWdNempHdUN5dHpQNnVDZkc3WnVNL2FTMzdP?=
 =?utf-8?B?YzcraEhVcDB3SGxjbVkyYWMzVnBsZ0NDZzNJaE1sZW9FTXNYNTUvYitwakpr?=
 =?utf-8?B?NUY1UTlRWm9xd3BsM1p1aUtET1ZyaVNRK0tDOURoNTVMRVpHYW1DbWUxenVS?=
 =?utf-8?B?cmJ5dGdZOTV1Z0VpWVR4Y1g1QVZIRjYrQkVmKzN0NzUyamFnTVdzNGFkRDJY?=
 =?utf-8?B?cTczYk8rTDlNVnIvMWYwQm5pYTRZdkpRcmJYcXdlVlhQaGdNbC9HRm4vT2g1?=
 =?utf-8?B?NG15cis1TS9iSWlub0NHeXpDcW1NUlVCa1VWSXpZMDVYdWlHYWtib1NXM3J1?=
 =?utf-8?B?U2tiWG5aYWk2dGZDaTI4ZEpWbmRNcUpJWWRDanVkQkg4OHBDMGxScU1zNUpH?=
 =?utf-8?B?SHMwTVBvM3JndVVtY3poK1dFY2hManRJWVQzYnloYXZoVEZVbXRkbXJ4bXo1?=
 =?utf-8?Q?BmV0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVVPTFRtWkIrV2w3OUNLZ01PYVBBdE9UdVVSNzdEQnlLMm1HS08wMmJQODVT?=
 =?utf-8?B?WWw3WE5ndXl0Q01OY2lyN2oxR0xBYmJIT25GTmJkNm9pVHQ4NkVWaHVoNFFJ?=
 =?utf-8?B?b1o1RTAwNnoveUNwOTVIblVTZHMvL05aRktTSFRqZGlvZVlOdHgyQURGSW00?=
 =?utf-8?B?bXg2OFVpclM3RmIvME5HT1JBWmpubXYrd1dDSzNnMzRLMy9Dd0tLTVhsN0dP?=
 =?utf-8?B?WDRaTlNzSTkxanNvQ1MvRkhseHNRRm9pcGN2REZZMWJibVVzQnRBV1BFWVNh?=
 =?utf-8?B?OU9lRjZQK29BT092SXExZ3FLK3F3L2c3OGJ1SEdMSElOeGFLMmdwVkFVT2JP?=
 =?utf-8?B?VFJBN0dGQW9RR2tpdTEzR09rc1dJNHlmbzhNY3ZobWhoWnR4c3hKR1NBNkdU?=
 =?utf-8?B?SEkrZFdzTk9GU2lEeG5NVFRTdGpqa25ueW1TVXZ4dUtRWHFXV3Z4Y3ZEamVV?=
 =?utf-8?B?eFZuWHh1OHYvR3RXOEVwSzF1aCtSTUlrQ09LV3p0bkVlZCt3UWJQSUlzS24w?=
 =?utf-8?B?RzlPdG8yZUREU242cUVHVGRReGVsNHBPazUwNnZZL0ZCT2FFVDBjVURwTWVw?=
 =?utf-8?B?SFVZMnRGT3piVDVWamVnQzVhS01WdXVYOWdlT25GMm5WbC9KTHM4K0s2NmRJ?=
 =?utf-8?B?MHRrSGl5eGZ3WUFKTDFQK3duTVZzb1ZRSGlNT2FLQXh6aVRMY05QUGI0TzZO?=
 =?utf-8?B?akdidzVZeFhXSkZ2UHJBZUt0ZXBOdXlsVlZWWFIxK1lTM0tRaWxEdnJydW5C?=
 =?utf-8?B?SUh5L2w1N0tTeldHZjdxY1JoWkkxUEdLWS90bSs3VkgySnFZOFNzT0pKdkJY?=
 =?utf-8?B?M0dqTWIxZ3ozMVFDU1hxckZSS1pUOXRaT29KbVE4UnRJalBlNmRIMFZQWTRV?=
 =?utf-8?B?MzlKUU42NWFUaVhmM1ZRNDNZa1E2MFhnUTExbW9LZk45MktONDZsRXU4bWlK?=
 =?utf-8?B?eWc1RFBuV2owb3dKNUc0S3k0ZFhiMlV4SkJZVWhTVVVKR3JPaVExQUMwRWcx?=
 =?utf-8?B?KzNwZ2tYY0RUSGFySkdFMDJoV2VLY2k2TFlJTnArQVlyV1c0UURvN1JEMGFw?=
 =?utf-8?B?M1Rid1EvSkg5YzhNNEFxdHNBalV4TSt1UXRZT3VHWTNJWHY1U3BOdkJ5NGVR?=
 =?utf-8?B?YlBLYVhEVFBwSmlSTzl3WXJSWDZYcS9DNzRZclBoY2tGVWtKamtlQjg5U2Y0?=
 =?utf-8?B?MzBlTWo0VjIremtXRDNFZFlMRmc4YkovRDN1bVc4aHRwZnc2M0ZiRTUrZ3Jy?=
 =?utf-8?B?Y1k3NjRjbkJReXpRRVZoTzJkWmp3R2QwVkdaUUlrRnRMTk9aTlpjL2ZDVGNp?=
 =?utf-8?B?RlpUZCtDcml1elNieFlucVpVY3BHVzNwbzhZTXM4a1FFQkoraUdoY1Q5R09X?=
 =?utf-8?B?R1k5d0NRVWIrLzFIMkl6T2tNd1RIRWJWdGVpcTB0b3Q5SUpiYkFJdktxT3Fi?=
 =?utf-8?B?S0FVeFdmSHQxMUpOQXkwU2pUemFuTmV3VXh3UlV1NFRQZ3dKMy9sNDRiLzFK?=
 =?utf-8?B?Q0ZMQkJuZ0VDa2t3YWpSc05CTmEyU3BXWkpKOWFCZzUxL2lad3Y1WjZuVnhG?=
 =?utf-8?B?YUpxK1ZTZnYvVVVpd2x3V2w0SUhIVFNvdDBYMVVIdnovY0kzOTBoOTdNVlJu?=
 =?utf-8?B?Zkhwa3M3Q1l4TUdUUjlnZFFOcDVrb0F0a1ZidFhZTUVNL1UxWFVGWjVPOUk5?=
 =?utf-8?B?VUI3ZXMwRzV6KzU0aCtudHBqWFl1bVgrdmRMYXc2UEFYRnpDMFNhOTRWRExk?=
 =?utf-8?B?NHBnS0hxQVQyczFsL3gwKzFwSUROY2NqWDMwbWlsR21sbXkvMm81Y09pZ0V3?=
 =?utf-8?B?OFFrbkNIaXVzSmlhYitqNTQwaDVLUitENlFQYm5vamJBMHN5dHdyc0dVSzYr?=
 =?utf-8?B?VFE5QjJ2ZFVlMkNKYjB6S0RRd1NFUFNoeVpUYktLdHFlVk9CaTZHbUxOdzZm?=
 =?utf-8?B?VHg5VGJQaVdCQmxoRmVIZjZJQTExMWRaeHlQTUNmdFB1UmYwWlVSZEVCWW1F?=
 =?utf-8?B?MW93QXhKdzdsOFN3RDNuWmJIbTVzanlhTU90MmxLUFV0M1hxcmNvR280Mmp6?=
 =?utf-8?B?RjZxdEp1K2xqTU5xVnB1bHpKSmpkMHVCZGVxWll3cWR6MHJtc1RQRyswV3lI?=
 =?utf-8?B?OXV2akJCcDRNWlhXRW1tNis0Mm1KdXp1MUFlOFlQVXVFR3pUcHljK2tvVFha?=
 =?utf-8?B?VTFweGxYazUvVWwreTFLdzYrNUx1ck5JSDM4RVppTjNhNWVrZlZJQklhM1dZ?=
 =?utf-8?B?b3loTForZ1BTNTlyMzAwclZRZ0Z5a0VIbGMrMy9BTTJxY0xlbkg2WHNIUFJj?=
 =?utf-8?B?c0JlNTJYUXdxRWpUSnR2K3l1dW9MS05ORkdYeFozRmRDOFVvWGd0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c7ba40-e3b5-44d1-2a84-08de73bff29c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:15:38.1680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VWqDA0LhhAxZO05JAQ70l+virknzeWxtjgpvL7qeeJYZoGDCbhoEmQWRP2J7gArAWO+kavDIiZhLBrOJrd3rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475


On 2/21/26 05:17, Gregory Price wrote:
> On Fri, Feb 20, 2026 at 11:30:12PM -0500, Gregory Price wrote:
>> cxl_add_to_region() ignores the return value of attach_target().  When
>> attach_target() fails (e.g. cxl_port_setup_targets() returns -ENXIO),
>> the auto-discovered region remains registered with its HPA resource
>> consumed but never reaches COMMIT state.  Subsequent region creation
>> attempts fail with -ENOSPC because the HPA range is already reserved.
>>
>> Track whether this call to cxl_add_to_region() created the region, and
>> call drop_region() on attach_target() failure to unregister it and
>> release the HPA resource.  Pre-existing regions are left alone since
>> other endpoints may already be attached.
>>
>> Signed-off-by: Gregory Price <gourry@gourry.net>
> BAH - disregard this patch, it uses drop_region which is introduced by
> Alejandro here:
>
> https://lore.kernel.org/linux-cxl/20260201155438.2664640-20-alejandro.lucero-palau@amd.com/
>
Feel free to add it to this series. I have started to send individual 
series as you know but the part changing the region creation will 
require more work than the already sent.

About this fix, it looks good to me, although I have to admit I'm a bit 
lost after following the discussion Allison points to. If we want to 
keep the state of failure for forensics, not sure if the 
debugging/tracing or default error info in this case will be enough.

In any case:

Reviewed-by: Alejandro Lucero <alucerop@amd.com>

