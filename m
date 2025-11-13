Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBE3376A9;
	Thu, 13 Nov 2025 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031665; cv=fail; b=LXRrRXsboFaSFNxfdCG/AaWekPS909Z0v+BWbNyTAswsZ7P6rhN9v0XpQjdXvIb+BGR41Kto0nJDM7lunzEjTyRMDTqrv7Y8vKtFoZ/GeqKFO6T0nDBzrDVANI2HeH1cxYjKHC0Uvlc9FK20GV5qOLRL/oqAmEHmuIMuTxr6+JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031665; c=relaxed/simple;
	bh=CFBrvkdpcb8OAnwJdCu8UlFHvyiJjIbnvPqsesGvavs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EFtCY5/IsxbxYsoJB2UotF1V3XxIl0pPMcDzhBSVdUd3g9bI85qIs3CNjoAlxowhHr4i368KtRIg9Gny222ksO4z+J6sTTcBRTjBokECyX9im4unHHc85od413CrTE4Kk0ZrvEzrGKlxskfHs3PsXwJMeleK9cebmD2HIve32Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PX8L4XRM; arc=fail smtp.client-ip=52.101.46.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PX8L4XRM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8Fvz+wzX/mpN/6JmdtPd8d3L47VB8y/HYJw95tJVQNYAPsvXh3RArAcCDqOnMCeFSS1JSMcPeTTDjrQJYWD8z9mpjHPpsp/01gaGYYAady3htL1RmPL1bPx/dpIlItyk8kcIUDd3kAalYHp4qbD47EBhOpia5jMIOjh21RQPu+qUt5EIRsOlW5v7noG5Ur4ShfKFi+s3/AfNDe//yqeYfoHm9U9psExCl+pE3VsMHXo0FZd8nYSvsrkf6V2SgKiC2h6iAGCKoL1BcvOjFwWeNWIhuWYQ489RAaDcCMuGfTwN6R0CCGc+o9LTWFHl7rB1P92cida23cbjYKAS7o5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRLmLcsQCCSphsc6YOfsB20Zo/nnzxkdkzaAH7Lv4oQ=;
 b=A+ZoVUMJyu+p6yFDA28K3JVKTJnNS7p8OwrQoWyO5uoQrrvYe3PVwNBhXSsLA/ZvfcooWfAtIWD7U04GuGiZS+CJwoK7VGWRCCZe92SuDNYmU5wS3LGJmZ+boTzXVUi2yo7G2R3wESt2Dm9fyg7gJc6ZuXIT2lET0t1FMhXSNujgK/STm6+jX+tQz7KXOIjp7leNW2EHXHVnfMQbxrtXvD5s8BGixaSLKfSE43FB+RfokYqvvIiiESBS5Oldbqwn+xDxgd8cgcHO3j8tQE5IZLTM74fDuyX/c2pMK/rjx7bXoPcJ5M4vlIww4AN2l+G9J5QMCSA2C1NsLr9NvOlLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRLmLcsQCCSphsc6YOfsB20Zo/nnzxkdkzaAH7Lv4oQ=;
 b=PX8L4XRMO5qUW99q7YwfP3jjDR4vqa8ppOLRADLq91sqvIBaZdJQbQ5m1nzI28EmRliFLqF6HTcb0LWwkO+2iIz433o1gXCdKdXGtMAhFBgLZIRTdTAGW+Y1LJsfS38amNtebFWPMV87RWEKdwQC5S9qdZXf9sWMZu+YVZX2JpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 11:00:58 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:00:58 +0000
Date: Thu, 13 Nov 2025 12:01:27 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 0/3] CXL updates for v6.19
Message-ID: <aRW6h127k5Tzns8R@rric.localdomain>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 8812d2a8-58d5-4110-bb8c-08de22a3ecf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUR2a3pzN2h4Zms1RFFPcWJzY3EzcmdnS1hGMmdCT3h5MTBxWDdOYXhMenhL?=
 =?utf-8?B?a3ZHT0NBdm1vUUhQMkFZRnp0bGlXZ1MrTzcyMXNyU1dxdEhyNEVpa1YrSlRn?=
 =?utf-8?B?VmxFbDlzSG5vanpnd0oxRWRSY2M0OEtpMGtjNnAzb01HbkFzWTJuSS94RmNo?=
 =?utf-8?B?cDVPcEUwZ3EvYmFXcGRaU3Z3UGhPc1Z1dXFsQ2s3b1ludkdnZ2UvcWl4OVhQ?=
 =?utf-8?B?VjhrUkNIaEszbFp1VC9ieGIwSnhyUUhFQXFpQ2cxNStrdkhWaVdZOUljbXBZ?=
 =?utf-8?B?WkNPZTdyMFRXV1UzRFQzRUZQdy92NTdwb21lcURNeUpadkxhTTkzZlk1dFFr?=
 =?utf-8?B?R0JaeXNPdFg3MGZEVWZ3alNUalliN2xZSGk4Nklpc2tCdXF1bjFQWWFCNlBQ?=
 =?utf-8?B?aW5TaUZUYXlZY2RpcnRDVXJGTzNOb3ROTC8ydzVUS3E0cDFtV2JqTEZsMTlh?=
 =?utf-8?B?bCtVdVkzTTdQbXg5OFlGdE9HKzhKZVNCL3I3TlNFamJHOE50bUVJbTIxK2k5?=
 =?utf-8?B?Nm52T3BiWG5ERmk3ejZ4cHdyeHJucmxlY1VLYnU0eGd6ZkRjTm42b2xWWCtJ?=
 =?utf-8?B?Mm5FQ2NyU0JkNTk5OTJ3TXlpMFZPOWxSMi9xWSt6U25KZGNRZXcwY2JKQjJR?=
 =?utf-8?B?aWoyZUljV2ZaNGsxVWZZY2NodVNtTEJudnJUc1Z0bUNSaTM2SkhjTCtjSy9x?=
 =?utf-8?B?ZmxBdFlOV1lRU0pueENnYXNBK0U1R2U5dHdIWDJ1akZKNXpjeXdpSGw4T1FW?=
 =?utf-8?B?K3MyTmFrQ1ZjMkF0UUdrb0I1S2R6b251c1ZobzhEZEhrNzdscVVhdC96TmFa?=
 =?utf-8?B?NkErYTZsc0JySS9SV1Z6VDJwcllxdmVFTlZob3hvN2hpVS9peENXZndSTis1?=
 =?utf-8?B?czBUUVhVbnp5a3pjeTZtQ3BYV3FTUWd3N1RuOVF1MGZ2OWZkRmZYa21PR0FZ?=
 =?utf-8?B?d0JJSitwOUJzMTg0Sy9yK2NCNnpCN0tXellZazk5UlArUDhIaDBVZlZEZzN6?=
 =?utf-8?B?KzQwTjYyZUhtNGNKT3N2RVc2L3gxUVV0RktYanN0ampWVCtJNHFvdWdpZ2Nz?=
 =?utf-8?B?MTgyeTFKZGpNem5wZEtheDNITVo1Y0E5Q3RLbGtNWDZDcmlOU1ZhZFdvZjNz?=
 =?utf-8?B?aHV3cytISG43TkQ2THdiWjJ6K1JPY1pjMGNhYWxDaUc0WDlqc2lhQmdscFdW?=
 =?utf-8?B?VFJDeWIrRjhxcHJlN281N0xoUG1uSTVtcStvbjRHOU9OeWxIRnRZVkQ1UjVK?=
 =?utf-8?B?ZHA1REIxYUNUQ2t4eTg3Ynk5aXg5M2tlVXZyajB1eFJQOWVSN3NqYUVYcEhw?=
 =?utf-8?B?bjZpVFFXcC8vN0NPYXF1L3dldSswQ215NENnaWwyTGZFSlRxakhlVThEa0Jm?=
 =?utf-8?B?a0p3U3NnaEZxNGVQOVR4ZHp3a0JrMHdMb0o3VHRicnUwYmJScDJ5VlQ4MFh4?=
 =?utf-8?B?YXR4VW5aVDN3WFlqWU84a1hDT080a2xFcjVEVmFnb0NCS1pBR2NTN0JrZ0hm?=
 =?utf-8?B?aTRHYlQvMXFGTHQ3VkxqS0xwNUNRWG95U1ErUzRGR1dCS0gySWludWpPa3Rl?=
 =?utf-8?B?RjYyMVF5L3E2MkZLc2xiS25jMXVSS1hvd1B0MlNSaFREakE5d3dQNVB3eTVE?=
 =?utf-8?B?V0VrbE5JbmN5SGRFZm9paXRLRlpmcW5IdUVsVkwwT1R4S0tqR1MxblErRXc5?=
 =?utf-8?B?RVQwUnorS2NDbmVDTVorWG9scE5JbDFHRlJRSDdpYzhnSTJiK3NnTm9pd090?=
 =?utf-8?B?bGlMRUZMSmR2S1ZoUERxYWZRMEtJVGtvakoxSysyelJJUmQ5OFdoTnBoTkxn?=
 =?utf-8?B?YlF4cnR5dXNtMTJtcDM3cjl1WUgvTmc5VW5wcm1QVXQrMHRWaWl4UC9yTGxr?=
 =?utf-8?B?SFpObW4vcWhWejA4UzJuWll0WEVHR3dHWDRYOG0xb3ZrUnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3lUSVJsbkE4S2VpZG9VUnhra2RwSTlWWmx2b0QrNkNmeDVyOGhWQkUyMSt1?=
 =?utf-8?B?QlNxbXJ5QldOb0pXMk9JeGlFbXI2dHBhcW1GMGNaZ2tJWkZIdmdCb3dxWFJY?=
 =?utf-8?B?OWYzUnVQbUtKeVdPYzNOOUh3NWsxSkxreW9FWlVzdFdBZFhTaVJGVEVLQklp?=
 =?utf-8?B?Z2tnNXRHeVFJQUlrZUtsd1pMR1JIeEhjS2hMN2lXNFpINmgxRWdHWlUvc1Bj?=
 =?utf-8?B?dUp4NjhzT2M0amQxR1pjZWpzaUZmWSs0c05kYVV5VGNlK3pGMndmWkYxcWRq?=
 =?utf-8?B?VStiS20zNVFwZW00OFVmdUwyVmtMNmd6S1k5WlErbXBPamRqNDhQUkJQMEs2?=
 =?utf-8?B?SytmdkVVaWhtRkR4VFNIeXVXY3RCUkpCOC9iR0o2NDJmSmlQSEZjRkxwK2hC?=
 =?utf-8?B?QlFieEZBRWh0RUFrQWFJaFRld0xzVzM5VUEvcGRVMStybkNKWnRkY01UVEFH?=
 =?utf-8?B?cUZDZzBsaEdLenMrcXcrcm1sMnpZWEFuTmRoQmR5U0VucUtnUWhJNjc3UVg2?=
 =?utf-8?B?UjdlYW4rTU5rakg4emJxVDdtajBXc3JxRy9WQ2JJT3BUZGd5Nm0wQXNMRzFH?=
 =?utf-8?B?NU1Td0tFbDdaRkJNSzY4YUFKdDZ2Y1NxdzQ5NFRaV3FyOVJwMndEQ09RU3pQ?=
 =?utf-8?B?cGhrWmZFcU9KNTd1NTYxTnBOVjdqSFVzU2RzaC9KeUF3cjNSUnhXY3ZPMVpN?=
 =?utf-8?B?TmxOYmdwNVFqcFVQelRoVlV0eHBOOENLcm1WSGRoY2tiVFcwS1lUcWZMcWNS?=
 =?utf-8?B?YVVvLzFzeFhUc09hckxzNXJIYW1sT3J2S2lJUnpWNHVnNncxckFMc3RtUEdO?=
 =?utf-8?B?bWtURG9FeTVDZ2JGRXZqUWNZS1VpdWdSWEdjQWVPNGE2ZFJPZnpjYUc5UTZq?=
 =?utf-8?B?eEpBTitpLy81dFRIRFBobFl1b2k3V2pubFAwbEk5R3M1VjhLcEJHYlo1OUlt?=
 =?utf-8?B?WVJYd3RhNzRWVTBVa0o2VEJOQWpHMmNQYTRydm1kaXRGbU96bVJYR0k5ZWdi?=
 =?utf-8?B?YnRsY1hneFNXWHFxUThrenpGRTljait0ZlNLTlFGaEYvaWg3SEZCaXhhTm50?=
 =?utf-8?B?T2Y4VWltbWtoU0pzeEduTGZQaFpKTEFIbmE0VGlqa3RGcm53Y0wxSkdsRUZO?=
 =?utf-8?B?SVA2RTQrYTB6TWp1T0ZKTmxiSGlVd1phbFJ6K2dnNnNyOEZNaUVDQ2F3ZUh6?=
 =?utf-8?B?Y1czV2Z2V2ZzYW5aZU96STZCQUF6aG5qQXo5Mjc2Y3FQL01qOFp0d2FHRWhx?=
 =?utf-8?B?NHBQUWptdlBNWDNLYytTRHMzMlM5aGxYTWFEaDdDUVhITG9NRHhtY1liYi9a?=
 =?utf-8?B?Y3lMcXFjNkkzS2RtTmowenFzeTBoU1hRUHl1Y1lYWlNNSXFOOEZkMUJUUXIx?=
 =?utf-8?B?dDFkRUtraVZHNnNZa1d6UzFZbVY3cEg2TUV5akdYd2xlQ2phMlVGYlVDblJi?=
 =?utf-8?B?aHJIaGg2WUo0WlMyR2ZDZUozdWJGVkxUTm1qM3MwR2hXdmtTRUNxTVJkY0Rz?=
 =?utf-8?B?SklxU3U3UEp5L1VCcDVtTVB4SGFKc1FhSmgzZ21iaElzWHBzZU0xL0RDRDlu?=
 =?utf-8?B?dlNLaTVKQUtZT2t1SmRBSnZxUTIwVEJuSkhQd1R4aS82OTFTYjZwZTdxdnBh?=
 =?utf-8?B?REhLMGFCTGxKWjI2K1VSRkpWa3Z3RDI4OFRkQzBIWURUU0c3cmFabkZLOEQ1?=
 =?utf-8?B?RFlXU016NkdaaklsMzhVbDFua2RyRnllL050NE5saS9JOVBHTnU5cFcxYVU5?=
 =?utf-8?B?UGU4eHNWbDdwU3FIZExCNXlsUEc4VFJtRjFBdHJQYmFFNHJhelM5TDlkV0Jp?=
 =?utf-8?B?MnZtSlhkd3phaGJHQlBySXQ3b0JoWVVlME1VRk5ZbUd3aW1YMHFLSXEvL2xS?=
 =?utf-8?B?ZkpyZlFlTzRGTUpmUU5KeXlORDM1ZC83QkNrWkZKMmk0cERVeU81OEhpa1hQ?=
 =?utf-8?B?dHczRG1vRWNlYnd3UVI4SVF6aFluOVRwMnAzTkZuTTZYS0grQjVzTG5CcmRK?=
 =?utf-8?B?NTljQkluSXB1c2Q3ZzQ0TXVNbmkyOVdtZUdkVjdKYUJUUUYveE52WDBIL2Nu?=
 =?utf-8?B?WHc5UWRUQnowdHBhclJVWXpST042ZlNCNFhBQk52U24ydVUxM29hUmE0T1Rk?=
 =?utf-8?Q?4EKpr6+AGZZBLrVuIJZlJVybo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8812d2a8-58d5-4110-bb8c-08de22a3ecf5
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:00:58.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfqEOlnMer05Rb6V68rtzgGkO1h6qxrXZ8MeQGFE1ZsPnx+ODj4+nXtrpoQ1znfCN/YGne84vBjzAQBtDoSm+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

On 12.11.25 14:45:28, Dave Jiang wrote:
> 
> 
> On 11/12/25 1:51 PM, Robert Richter wrote:
> > Sending optional and rather independent patches from v5 of the CXL
> > address translation series [1] separately in this series. The patches
> > could be applied together with early pick up candidates from the
> > address translation series (namely patch #1 to #4 or #5).
> > 
> > [1] https://patchwork.kernel.org/project/cxl/cover/20251112203143.1269944-1-rrichter@amd.com/
> > 
> > Robert Richter (3):
> >   cxl: Simplify cxl_rd_ops allocation and handling
> >   cxl/acpi: Group xor arithmetric setup code in a single block
> >   cxl/region: Remove local variable @inc in cxl_port_setup_targets()
> > 
> >  drivers/cxl/acpi.c        | 15 ++++-----------
> >  drivers/cxl/core/region.c | 25 +++++++------------------
> >  drivers/cxl/cxl.h         |  2 +-
> >  3 files changed, 12 insertions(+), 30 deletions(-)
> > 
> 
> Hi Robert, I'm having issues applying to 6.18-rc4.
> 
> Applying: cxl: Simplify cxl_rd_ops allocation and handling
> Patch failed at 0001 cxl: Simplify cxl_rd_ops allocation and handling
> error: patch failed: drivers/cxl/core/region.c:2958
> error: drivers/cxl/core/region.c: patch does not apply

You need to apply it on cxl/next. There are conflicts otherwise.

Additionally, patch 3/3 (@inc variable change) of this series also
depends on patch 02/11 of v5 (store root decoder in in struct
cxl_region). If you chose to pickup some patches from v5 first on top
of cxl/next, then all this 3 patches should apply cleanly.

Since 02/11 is one of the first patches and it sounded to me some of
them will be applied as well, I would prefer that order to avoid
rebasing and resubmitting a v6 for that. Let me know if you want to
handle this differently.

> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> 
> Also:
> ---
>   ✓ [PATCH 1/3] cxl: Simplify cxl_rd_ops allocation and handling
>     + Link: https://patch.msgid.link/20251112205105.1271726-2-rrichter@amd.com
>     + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>     ● checkpatch.pl: 118: WARNING: 'existance' may be misspelled - perhaps 'existence'?

Will send an update and also update the sob-chain.

Thanks,

-Robert
