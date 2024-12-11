Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5113D8B1;
	Wed, 11 Dec 2024 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935648; cv=fail; b=oJiyXP/xWZKU0y6y2FyPpxD0sjbFrTemr+WBSTfXoie+x5VXPW8q1Uk8HTSKN0aL6zZoWPoaD//9juVslVwQvgow4ECbxxpUvdRB4ct9i9VTSDBWIFWNyZIC1opj7oDjuwJVxQ4nA21zXfYo6HKdYDf6dWNNJOEjO4+8sA3vL2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935648; c=relaxed/simple;
	bh=Q3hDSepDJSN6RyWE9hMohKDnpKlUfCcQNfgEoc4IETY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lKABzgy51MdaJXconWy9/LO0M7/pbyff4fS5cfyTP8YVAauXvCcSTx1z3KbVZFr/FIzYjipUwmJ/7y2LjCnuBgUdwdHexiJobg3iNPYGKhgTBhB2GQCO7xpKilL7HYi2vmRPnUaYo/jvpD02ycrYy14G3FPwF2zJhXcCD86FfmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0dXXWFsW; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0dXXWFsW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmeUcAgOTS22jKbFT0RzONv4zMxCzR7wRal1xbAkC8YtUVOS1dSBTGmu5linxmPQIJULhPFD2cuMahdKZMZ6drBSKE9Kabc7JlHDoyIbGVZz20Spni3pTAkGMeOu7vfnSuwbN7daGZY5xjO4Pv8le4yiUDj7OyaooZKDraFfP9knfAONKb6wn/dns3/WVetoQRBW9eO9UXOef53Nk2llGWhgfahgGeEkl+QyL2mpYIpo/rXAbtD8Grjve4n/rnUSyOIkjTfDXSBnQIbfQqrJTx6OaKhy2C0Ta1pkD4Btxu94PNbo0xVbEHwFtVR9nTB0Ahqy5ebyrahNv3YhH1QWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XybUHJKReJeknJWb7C2QXjLlicbDohs5oDrVH+eXc1U=;
 b=sSnP6/gvPgL2vGl+UsicVgSuZ/7lxdFlA9Fz2XVcxeQ8r0lN0RtroAoQ577Cu/DdtCHTogCpd7OhajHiD615BRyfXRoRMoADxwRufZ8NFY7fJ1CL1x6pIj97qnIfkh5sduAoWifWw12vDlEZP1vmZAnrOwrpCWq4iqdwkpKIuTpGk0GYye0VI6/Fkg1M8Li52mwwqJktEZ0uW8WEuBBL7T4SlN9z1NVa3rBsttXNjNCRK37X+mr3mzNDrv36escM/2i46yOFuYkLvcEbMEAitUQDZBs2sehcg7bXIwQ5a5uTyncuYAwfXnB7QEvSfAgjASsRNzwhNk6oGQyqXhwwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XybUHJKReJeknJWb7C2QXjLlicbDohs5oDrVH+eXc1U=;
 b=0dXXWFsWk0LzFx4smnMBlcN1xfUrklUsGNQdO7f2yNzAEJ6XEv61PZEhzY0Z3hI7hAkZGbCLh28DaxPOkEB4493D8oFVucUhtktCJ783KOhTeQGkc5muvj9t1loflADGNzgbiHfsOg6tVqoKE1ZfJtnGac+ZSJbrkAPyX/0m6Mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SJ2PR12MB9189.namprd12.prod.outlook.com (2603:10b6:a03:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 16:47:22 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 16:47:22 +0000
Message-ID: <d8d2c310-2021-431f-adbe-71ad0a17896a@amd.com>
Date: Wed, 11 Dec 2024 22:17:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
To: Dan Williams <dan.j.williams@intel.com>,
 Raghavendra K T <raghavendra.kt@amd.com>, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
 ilpo.jarvinen@linux.intel.com,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Fontenot Nathan <Nathan.Fontenot@amd.com>, Wei Huang <wei.huang2@amd.com>,
 regressions@lists.linux.dev
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <674fd2b4942f1_3e0f629420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <33b4b93b-5ab6-4a3b-b3b2-c9b3cbc9d929@amd.com>
 <6752acd92baf0_10a08329424@dwillia2-xfh.jf.intel.com.notmuch>
 <2b5bb8d8-6a7d-4a58-bde7-ce42d0a23f61@amd.com>
 <675918b414c17_10a0832943b@dwillia2-xfh.jf.intel.com.notmuch>
 <de22dd6e-00a3-4183-a123-15cc7c53980f@amd.com>
 <67594f90a7b87_25073294f0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <67594f90a7b87_25073294f0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001AC.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::12) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SJ2PR12MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: d8443de8-a882-4105-dd57-08dd1a037ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW1vWVltMENlbVB4a2VLRTFzRlBWdGU0cWE4b0JUaHg5ems5Ly8xdHhJcTY5?=
 =?utf-8?B?SjNwWVdDN043cmVOVVRDOG1vc29aN29pMmMvMWN5QW8rRmxzMWNqRVpFSnJC?=
 =?utf-8?B?OFZqbjZ2WVdqbEtXdlBQcUhkMEVEamdQMUpCK24yL3kvUDZZQlhoYTdtWitm?=
 =?utf-8?B?MVhXSFNJOUZvQldNZS9qeEp2Ri85UFlITGRmOFA0M1hVanFWRHVJbXVVcmpS?=
 =?utf-8?B?cVI1RndqN3hBTExNekduQmtZRGNxYzNPTXlrOGlDQmFIdkpwVDY3Z3J3VHlX?=
 =?utf-8?B?Y2pidDBENHQyQ0Fic1Q2bFRyK3R2TlcrdlhPclhVR0VVVytycVVoTThDYThC?=
 =?utf-8?B?Q0NYdmg2WkFidmxURk1NbkpWblNyVDZ5NUdheEM5WG9NeEpWa09ENTAvWkJh?=
 =?utf-8?B?TC92anF0NXJ1eUpkTlhrcHc1VUJEQTZ2ODgyMkVSa2pVK1lqSno3WWlnYlVC?=
 =?utf-8?B?ZitybUxwb0Q3M2pqblJOUW1qK3pTTC90S1U2V0ErMjNvNXJWSEJxQ3o4Zm45?=
 =?utf-8?B?N3RwU2lIUWFObGdKNFZoaTQ2aDAzNGJSR0liWjl0dWhaNVFWVm9MUFdzbDQ2?=
 =?utf-8?B?WkxjcDN1VnpVR2sxVGtSL2NvcnZOdmhOamVXNXBlenV6WlBFL1RTUXl0dVNY?=
 =?utf-8?B?Q1VILzVBMUpZdXh6MDNPR3JGZWY0K0U4WjZxRGk5cTE2Z3FKRjlta09GYXl2?=
 =?utf-8?B?U2gvSzI3eWVLMW05UUdlOXBMczExc0VHSUlkTitraGJUaitteXUvcW4vZ2Y3?=
 =?utf-8?B?S3EyUU14ejM3eStTaFdNM3dKT2FidTVVOEJuZGs4S0FFbFJQZEd2eU9tMnBl?=
 =?utf-8?B?TGFxL2IrbFJXb2h0eTVVOFl2cE9IaW92TXBrd2o2REFtUUV2YWczWXpRb2lw?=
 =?utf-8?B?Sm42MmUzZVgvUzBQOFUzTEx6R3VkMFM4WUR3eVB0N1hqRVRnTWkvV28rcFp5?=
 =?utf-8?B?dlU3clVtMDY2dVBML20zQnpocmVZcDRjZE5DQjNBb1g3YjFGUXlpUW5FcmJO?=
 =?utf-8?B?a2NvMjByNVY2S3NLaHlmTyt4cFJTUDVZREIrSkpvVE95dEdsRmZzNnNmZmtm?=
 =?utf-8?B?MVk2cENrN3hrckc1RnYxZXY3THFjTGViamZ3akdLTHFZd0hjS1l1SHpRdlNY?=
 =?utf-8?B?a0NiK0F5ZS9EeWc4YkJnZmZsYmhORnFUY2R1dFBBT1NvVnkrT0ZiZ0NoM3oz?=
 =?utf-8?B?bE5WZWxIMmhTSWFvVEU0UnBXMXdFYW01Y3ZGY0ZYWEpPWWdmZ21CeUNMb0Zl?=
 =?utf-8?B?ekVKZ1VmYlFtaElLa2h6dnRsVHFBYlBQazhPYmNjVjd4ay9DRjcwUDBqdG45?=
 =?utf-8?B?eHFROGlTYkxaNUNpb1dCdlU0TUF5YjgrTEN6MmlmSFdneS9jUnlGL29GOWRv?=
 =?utf-8?B?KzFhVzBUUGRWRzhkSUtkV01sMStWdXkyWWNSc1RLRTl2bzZGYzdyTjNqVlBC?=
 =?utf-8?B?ODhwZ2V2ck84aW44YUlrRDJ4OUtMVGszY0p5Uk13WXFGSzFYTzU0RGxWMS82?=
 =?utf-8?B?OTYyRmlsSGE2M1hPSVhPL0hqSHRhemh5Q2RkTjBQM2pUbnp3WHVWbUJIZ01u?=
 =?utf-8?B?THp0RXpnNkdSZElBRGpxcmNJTjNwbVJkenoyNThaWEVVQUkxTVhwd3JnNDdk?=
 =?utf-8?B?N0FzSCtXZk5NVlNLWk1lR1EyRXlQWlBPalBBWUIrS1B0VjVzam1zclRobGl2?=
 =?utf-8?B?T2NzR2IwcU0vRG9ZUW16ZGgyb283USt1NTdoS2dhZ1hrWDhxSCttOXlmUmxl?=
 =?utf-8?B?NGREd0t3cy9RMXhyTlBVUGpoYnkrMGU4Tk0rSld1d2dyZjhDeXNQYVh4R1pz?=
 =?utf-8?Q?iI6kDP5AZO39YHbtubNz3l4lddozE6mivqLPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlpXY09adFAyaWRTRk5YOUgvdzZaa0tLTlNsNXpCMC85MDJnOUVxTlpwVUM4?=
 =?utf-8?B?QjBvbzh5S29OenpRQ29IWG5BREljMmU2SEhRZWJ3THFjZ0hKQ1dEcmoyemdO?=
 =?utf-8?B?MzdTeHNHNTBKSnpvbGNMRGNsUFh6MVJ6dzQxR2UrMTV5bTk1czBkMmlvTm51?=
 =?utf-8?B?bWg3eDhZVG94K1pjbmgxZHpFenFkTDlENmV6N1pJelNoa1B4ZjQzb2xBL1g5?=
 =?utf-8?B?dWs2TFNkZnRmTGFHZHBldGt0akFpdkh6b0Zzay91YmhETkdRTDgwUFlvQWEv?=
 =?utf-8?B?bjI5cjNqRisrc2JQaEhPY3cwNnU2ZktCdU15bzlPRVdFUSs1Sm1DOHNiMmFI?=
 =?utf-8?B?RGVGd0tpSG5aT2w0TEp0eUxMMUtXczN4K2VBNENBelk4U0kvTXlkMVZKZzh5?=
 =?utf-8?B?OVlyamhLWnd2SXNmOFQrNXpCdlZPUGMwNkJaL09jRlBpdTNkUTdDczFKc0pB?=
 =?utf-8?B?QjZvQ2VRN2s4MFh0ZTdhK25qSkJTaG8xbnVmeGk2NnF6Z1VIaFU3RkpnUXZS?=
 =?utf-8?B?V0JQQ1ZpdHh0WFREMSs5bVFGYldpRWp6Y1ZCNGtMYnY0VmRvWENlaDNiN1c2?=
 =?utf-8?B?VldrYkJvRy85SVc0bWJSUDc1cGE3ZituWmFSN1hFNEdzRkdCUWNHVzI1anpy?=
 =?utf-8?B?RDZWYkRkQVh3UVhnNHZMeWNPeS9NTi9KV1RuVUNxTGR2ZjBIZ2l6WVdCVWZD?=
 =?utf-8?B?bVJCemo5aGNXbFFMaG9LNzVqSzltREZUOTd1R2Zmdlcrd09ZdENGS0VIRmlT?=
 =?utf-8?B?MGhsWDZTVTVWOW85aGVhdEhCVnhmZCtGOUp0bGtRVkpRNi82bjJvNDZsOW9t?=
 =?utf-8?B?S00yaFpWZlY1SU90MDQwMWc3ak00VWRPS25UOWN1dllEV1JjcHEwVnFkeUFU?=
 =?utf-8?B?RGprNW56aGdVRGFPMU94TUl4R0JhSXNPMW5GOXgrUmlIUmNKZmVlMWFReFNW?=
 =?utf-8?B?MWg4K29QWlNIaXVFMVFVZ0dPMkpFTk9iSElpV0EzUElhUTVlMTNNVTE1R1NX?=
 =?utf-8?B?UysrbXJtaFFuZ3EzRUtIMW5LVDNzQTFURFZ2c3dueGl3b21oSmhjZmdDUGF6?=
 =?utf-8?B?OTlhbVF5SVpSZ0tsOUVZeWRWWStvUEh6cVFJVFpVaEpsL20xL0U5eGduSmRo?=
 =?utf-8?B?R2kzTUQxdlkyanBKS2RHbitSWkNKT2lma3ExQmg4WmJtWTdIUjc2MHBYZU1E?=
 =?utf-8?B?SEMwUkJSQit1WndLdG95NDRQaDBHSW5lbzdDQjdDbnU5cHhxMWdRazFkVXcx?=
 =?utf-8?B?ODZVU3dGR2ZEM3ozRXhJTVh5UlEyeGVSY2N0TjFrc3g5amh2bFRzb0gvSFdN?=
 =?utf-8?B?ZWI3dWZEaS8zdCtBNXVIdUN1V0lBaWhLa1J6VnYybVVQS1hoWUpaZEw4OXBN?=
 =?utf-8?B?ZzM2NmEzZDBOZWhaVEVDQXUvTkgwQ1UzTjk4VHk0UWt0MkMxRlNveWMrOElR?=
 =?utf-8?B?UEkwTjk1Z2JQVzQwbUZ2NHV2ay9RbWE2VlU0WU5OUCt4dEEvYklxK2pHWjdJ?=
 =?utf-8?B?S1VHeXNKcHdOcDlJUDBHbVRmSkxMUmxQR1FzOGhub0ZLaXlzUnIzTGxtM0R0?=
 =?utf-8?B?VkNCR01MUzJKSUIweG1idWRvVDNuRnZudmFiSXR3MWNMR1VZcHdOclZhTC9S?=
 =?utf-8?B?UUhkc1paQjJ3Mmp1S3lvbXQyMWRYZEsxSGhMdzRHS0JQcEg0cGVNZHoreFlB?=
 =?utf-8?B?L2JscEx2TGQ5bXl3b1kyS3Q5eFBLWnRmMGNNY0oxWXVEbDRRZTltTDlFYk5v?=
 =?utf-8?B?UWk4cVAvNHlxbTlSa05iRm45WHJLVklDZjlsTmUvc3ZVVFp3T1pvMjJwY0Z5?=
 =?utf-8?B?ajQ2K0dvMytkQXJxNy9kTnBySE5uY2VmSHkzdW1XVmRNa3psdGQ4eWJGcW5h?=
 =?utf-8?B?bSsramp4SXB4a0ZhQmVIYXFaeUxyOWpudzlWbnBMVmRqLzJqWUlaeDZpZ21q?=
 =?utf-8?B?UGhRMHRMKy9sWHlGZFN6ODBZVDdyMUtzc3c3RVFGK2hncG5SOFFvWm8zTzRH?=
 =?utf-8?B?enlOSjlOWDlMYnBsbkY5eUg1LzJ0bzF1dlJ5ZHB6V2h5SHVacTU4anJsUzg1?=
 =?utf-8?B?NmkyYVRweDN6K3JjUTRqbzFOZmo2TDY0bXJhQXhTdmVsU2dpSXBoay9NVUI1?=
 =?utf-8?Q?3/qF2h2A8Zxyv/RfMBIvx+Nv8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8443de8-a882-4105-dd57-08dd1a037ba8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:47:22.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tm/oiXQC5+jhUWA+0GvwlkEEPeGvfdIyu3KbhNhfE55U5+sO+DgKEWGz1M4ZILGsxQ+ozvHIh6SdaLERhodaWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189

On 11-Dec-24 2:08 PM, Dan Williams wrote:
> Ah, thanks for that!
> 
> So, it turns out Ying's patch is working as advertised. It is traversing
> past the top-level entry of the the iomem_resource topology to discover that a
> Soft Reserved range is described by CXL. Then the expectation is that
> the CXL subsystem parses the topology and registers a dax device.
> 
> I missed that detail in my repro because I was not testing the HMEM
> handoff.
> 
> Now, the dmesg shows that the CXL subsystem gives up early on the
> CXL devices as they do not appear to be meeting the expecations of a "CXL
> Memory Device" as described by the "PCI Header - Class Code Register
> (Offset 09h)" of the CXL spec.
> 
> Specifically these messages:
> 
>      [    4.449072] cxl_pci 0000:9f:00.0: registers not found: status mbox memdev
> 
> I think this situation is increasingly showing that the pace of
> non-standard quirks being deployed is higher than CXL subsystem is able
> to keep pace.
> 
> The immediate workaround to this problem that Linux discovered is to
> disable the cxl_acpi driver. Can you confirm that preventing the
> cxl_acpi driver from loading restores that missing node?

Yes, disabling CONFIG_CXL_ACPI gets the CXL node up with the memory. 
Thanks for this workaround.

> 
> Longer term the urgency of Nathan's patch [1] needs to be escalated.
> 
> [1]: http://lore.kernel.org/20241202155542.22111-1-nathan.fontenot@amd.com

I didn't find that patch helping though with CONFIG_CXL_ACPI kept enabled.

Regards,
Bharata.

