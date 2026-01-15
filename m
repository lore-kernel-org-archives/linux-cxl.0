Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3993BFE47;
	Thu, 15 Jan 2026 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502603; cv=fail; b=rdlVXkhzezTEZ9lYfdanYfZyyn2WSE4n8/yFmu2IjUOW+U/OJQlKRCaK8J5VxWxxCS/uYJaY6YAhHZi9WYDl9dm+sSCNuXyllXkpbzPmNH+8/Fh3PyWHgwAOaIpFGKab+Ocsjt2MQa/9Eo7MMEmJQfmAcSTzDRKzQoa9sj94LqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502603; c=relaxed/simple;
	bh=KeuzZlAZgTcJsEb9BijOkeCwGHrk50PfkR8pFDPfSNQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HQFRKHrkt1xPNv5i9rtBx9XkWDCBVqHc+K8zkpWQ4xiU5Iz8uDwNLtI8/X4+mg0/RGRCJz4n978WviEy4ZazxWEnLJs2u8WlYCIH+FlnBEJtW09jACD4ojqB2JdPLWPeSusnDjvxtMtoAJqHxAtXE5Tdyh3hsEZlMq7fIqy6hCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ielthhLE; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ielthhLE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MydeqxLUOZ00Mu/oCUr8o2FPsqjShb25YkHLNqiJHhP93jJvoFdjXBCT0w1o9LzgLtO6+sdyNtrhcDhExwX1x2tbfWrfsoFZjw9XgQXBRHxhuXmILCcCsek9g1jmdCMHfVVZKSTtvh792cgNIP6E0cclH40m2Je4jlAMlqTSpLFah5AdhYjIenXQbGHdnbKwwsfUQxff2pgdOpd/3cj+CN0gMR3ou+kvGv5VZMXQnjzfHUa8bKTDboNHPLJUifdOUfHHZA7y41rZN7TsUPoSoKU2O/kL5ykNtAWJFmR/nWFbzvSTmKHY4E247eSFrLH+wYHve7zxlRD5FpENQYBE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gMiY/dn6kY2lbLLRrfCC+catTiuddAaK+xskoA655Y=;
 b=bpQfS2i6s1RNphBGhhBuL2JAYOcURQCj4S+7Se48Tyot7WLvAmo5CxCq6CmHk7O80o83CG1GJBa8gQ+OnY54RMcSHJP1c9k2oBTJvzGRrH6fQIr/I94yd/ZNIYF6ulDRuBd9w23bO2WR81sRr7s8O2EuJJ0kgfmryZEszfZn0T41kyquI9KHTva4HFkyAKrw4I1/DapT0dTbCow0/2mRWSZJnJWHyAues6RVhJrZ7xZDiqA583jEfWYy3HwsVsOWdIPKLVf+xHCMfrCrpqVsV+X81WY+tcoQXZVo2ncTGGj6v8UU7NawWDutKL2SHfYeUshfhHxHWYJm3hNLSBHI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gMiY/dn6kY2lbLLRrfCC+catTiuddAaK+xskoA655Y=;
 b=ielthhLE4ZYylqz5lf7Sw50FgtNEQF9jh/W98A+1My3clo5yJGuTkCADDtxQhFtaq80KLrVFpoyVQDC5ruHxw8oQmZt4VW2D8KFMC1YvwHcr4T84q/4JFh7uDHmO0I8R/AZE9jrwu+BYVQqwKfNZTc/F/0xvaTZibPUeI/QIS/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 18:43:13 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 18:43:12 +0000
Message-ID: <edb6cd44-76df-4d68-8df8-2e7f3a7db73b@amd.com>
Date: Thu, 15 Jan 2026 18:43:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] CXL: Introduce memory controller abstraction and
 sysram controller
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20260112163514.2551809-1-gourry@gourry.net>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260112163514.2551809-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: db9d74b6-8733-4402-3233-08de5465efbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Unl3R0dYYXdSYmxvRSticExpU05HNUFBaDdzWmVhZE5mZlNZVTJPbVgzdTRB?=
 =?utf-8?B?Qkx5TE1lZjZXWG5CdEhpWUNKQVIyVjFkdkFZbHJELzVWRG53dVRpNTUvWUtv?=
 =?utf-8?B?dDFGWTFPS3VjRzU4WWhhaS9ONWw4aGV0UElrU084c2lJOENEWlVQRm1PM0ow?=
 =?utf-8?B?YVJQelhqeElpMmh2ZWR4RUE2TzhtNU4zU25TeS93VVlFTzVWQXNBWTVjWEIx?=
 =?utf-8?B?M1dMcUJnSGtDbmRRZUNCR084c0Q4ZDVlVzBxeU5xdWF0K04vMTN5dlJTL3dn?=
 =?utf-8?B?Ym1SKzBmSlY5MldDU2VPTDJsd3h2cGR2SXAvQUoxSGFlRUtSYlR4eUZnbENM?=
 =?utf-8?B?NDJIbUJCWE02L1Zwb01HSGV4NzNBd0FoZmdJaWk2eFhVdTk5UVZVRUdZOVhk?=
 =?utf-8?B?V2ZOSDJzYS8rdmpKOGg4M3ZGMmxXY1IrZE84djVNaHdhOG82aW9GN2lKYU53?=
 =?utf-8?B?WTFCU2VZZExMOVZlbVFlWlRieFViUE9PVlRFS1ZKVk4zQUxRdW5ZRHUvbVlS?=
 =?utf-8?B?ZFVzSmNUU3pxVmpWT2V2MjVUci9hamlrdnEzelhWWlR2bjFhK1JMN3lXYW1S?=
 =?utf-8?B?blJHNmh5amJMWENZdGFTSlNHVFJCRkdtN21wYTgvSXhyNW9aZVF0Mkg1MXpP?=
 =?utf-8?B?aFpXU3pBeFpnRXdjU01qcWUwcXBqZEU4dkpEb3ZOdFNzeEJidkNxYVpVa1FE?=
 =?utf-8?B?ZHg0MDlCcmJLbk1Qczl6NXZXVU15YjlUU2w5K1ZObGJVZDlpendSTlBrd1RT?=
 =?utf-8?B?M0s1RENPT2YzdDlBZjVZRzRKOWZOR01CcUNhMWJHRjdDemY5aGo5QmkwRitH?=
 =?utf-8?B?aXFvazlLaVdENWErYWtwT2lkcjZlSEp0WWVnc0pIZTMvVXJIcm9pWkltZms2?=
 =?utf-8?B?b3BMM3p3L2E0Wm1Id2doeU45b0cxY250Mnp3UzRNeGpmWmRmeHY1UXdhVjlr?=
 =?utf-8?B?V2llSnc0ZjF0YjhjMVFZa3ZtTk5uODdDei93eS9jcHgvcG1Oand6M2N3emQz?=
 =?utf-8?B?NTUwcFJZZVF0RFZ5SnBRWllHanBJN21iN2Vsbmc2MVhJQ0tDall0RzNhamZk?=
 =?utf-8?B?SjJTQkpMd29ZM3d6dmk3ekVTVDQ1dXE5d2dGV1RvZDE5azVqdTU4Yjd4Wno3?=
 =?utf-8?B?VUYvWVJGWWtGT05QUllKZlVtVTJGWnh2K2g2aHBvN1pYdzBqTnNrZXlCY3Nj?=
 =?utf-8?B?Vjhkbjc1aGsyZHE0b1krS3hxWUZGbGFZbjExN2p3N2hlS3NxWXdvZS8xeGdN?=
 =?utf-8?B?YWVDNU5wRXJhOWJnTWpENHc1Y0pTNmRybnNmbFc2UHR3WjNLSHk5aWZVS0Iy?=
 =?utf-8?B?R01JZGpnc0NFYkgwWnBiQ2pJQm5QODRFWWcwT0hVbG9vSXBQNkZTanZyTWZR?=
 =?utf-8?B?RWlaTzZmdEVqREpwV0prT0lyUTJFc2ExaE5zOUpIZjdMS2JtajJRdVVkbWZl?=
 =?utf-8?B?MGljSG9LWWdvMHFURzNYdzlPQnNZd2hkVDdnZ1NhZDF4R1pYRGUvWXF1bWtt?=
 =?utf-8?B?Y2dzcTZHTW9McXllcmlqeWRTRERhcitFVHk4M3ZodzYra2xBaHFObjRYejBL?=
 =?utf-8?B?ZTBPSGxFUmRrT0xPVzQvbG9jL0lZTTRwdlFjRnVyZTR3OGpsUzk5MlkydGk4?=
 =?utf-8?B?SkUxenNReWNoeXBWNDNSRStMRmd3TzBBbWtjZTlUck1oSGRSK1hKTW9Db3d6?=
 =?utf-8?B?ajljYzhqM3dZMVRCa25NcFBONXdDMlVaTGtVeDZza2IzNTg4WWNmOVA2RGhj?=
 =?utf-8?B?L242alVWV2VtTy9yUllGbklmV0lTNnBDSVZuWlRSak1MUjVzdTVDeFlYbEpU?=
 =?utf-8?B?bC93TjZsSTRIL1Z5YjdZeGxTNnRldmdNK3d1SDNrM1oyVFBTaXM1eVJ5T21Z?=
 =?utf-8?B?OWhjL1NlUFEwU3M4bnJkbnphVXhVN3RUU1FZeFhMUTkxdWxaQXAyZjlCUSth?=
 =?utf-8?B?eCtmNzJUMkpWL3p3WWkrUzR0RHhQRys0UC9BanNjVjlGRkNRQzJyeDN1Wlpt?=
 =?utf-8?B?alhyc1Z1SXVlUEJMa0tjNittanVjWmpIdEVKTThxbS9kQmRXbStYQktrQ202?=
 =?utf-8?B?blFmTG1mWSt1NWg5QWtYdUdBU0EzWm1mQWVzb05mQmxGenMzem5EWVlNR05I?=
 =?utf-8?Q?GLO8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UC9TQmVBUmRUWkFJeFJmai83VGlMOGFPRzh2TXg1cVFVT003Vm81OXUvSVUz?=
 =?utf-8?B?Sk9aMVZVVzRJTkRQakVDVFBMREwxOWNFVFBHM2JjUnk2ZDRoRnl6N3g2dkNS?=
 =?utf-8?B?RVkzOGgzYUNtb3JmeHFRcjNJWnQ4Ri9RZWF1T1VTclJTZ0lqcElOV2ZNbXlx?=
 =?utf-8?B?QzRWaXkzdnZVK3N4eVhXUVhSM0p3K2NwZFRYRjRhZjl1ck1WbHRORnFPcGM2?=
 =?utf-8?B?SFVvZHJDQ0t5VElvdWV3Z1RjbjRkRnQzaGlFRW82NUNTaDdPQ3VQeHZGdUZC?=
 =?utf-8?B?TmtzNkt5dldERG1oK0dGT2wxUGZYZmRTZUIyWG9pRk5hNm4xNExjMjJlYjNY?=
 =?utf-8?B?ZmxucmxyS3pHZnZBZ3JDT0p4eE82NWRuY0Jia2ZITnJkVmdZRHNrRGFJTWVU?=
 =?utf-8?B?d2h3eVhaM2JaN2NLNVA1UTdUcjIweGZzSmcrbkJCeXQ5OTczR1Q2eDJNYUov?=
 =?utf-8?B?REZPc0c3Z0JqSktTYWNyVVJIc2lVRXVqL2ZmVjM2TkRnaC9lck0wajZhTFg5?=
 =?utf-8?B?aThTYkRteU5BdmJzZDJEc1o0a05lL2hiakVod25mdUlLWkZJaGxYUTI0QStw?=
 =?utf-8?B?Ymx1Q3EwQ3BGZ2xaaGVFYzV6YUdGQ1Z0K2xQQXNJREpkYWFsaFM4YzBTc1kr?=
 =?utf-8?B?OWM4Q3BFd1UrZXVpbXFha2hUME16MGJBMERpUkQ1UWN6TjFzVDdOb3FxU3lS?=
 =?utf-8?B?RWE2Yk5LNU5qSTJJYmxKMEJmS0pDQjVEblRucTV1N0tSSGlhNE5nOUx1TktE?=
 =?utf-8?B?QVNNREZwMzQwcjlRL3k5eWxJbHpyZC9KbG1xa0pTaDFneWhOaTdWQzRWdm5l?=
 =?utf-8?B?Sm5Sb09kdGJqTkRxYStvWXE5UWhPYlM0SW94Qm9palllTkdMMlpFWTY2VFlM?=
 =?utf-8?B?dlZQMG5yU2xzUEY2ZnBoSlRObWhnQzYzekg3NktvbWIxdW5KWHdIRFVBS1ZF?=
 =?utf-8?B?N00xYTNIa3N0Sm1ySjlac3lTUTBSc3F2OE5yYlBvVlZha01NVFNxOU9PUHM4?=
 =?utf-8?B?NmFXZGYyM0MwdjhqZlFTL2FOMmRISklNRlY3bHowZ2FYaFdia2RFNTNHelpm?=
 =?utf-8?B?STdUSUIvbk83YmJqbE40S0d0VldBTldRYlRFcFd0M3dmY05PTXE0SXpvbkFk?=
 =?utf-8?B?dnNZZU41b1FkZlZpQnRXekRmaTE5REhYTkczcTFEM3RkUmxBN1RaZmFnbUho?=
 =?utf-8?B?L0RDVWU4T2lKYVJrWXZWcHdDbk8vWUpLeHQ2bFlyMjJFaDJsNlhnVFZTN3BC?=
 =?utf-8?B?T2pyUjI4QnBxa0lTUEhUL2E5QkFNdXg5b2JKdGtPZjZuSHVJZGlvWE1pWUhO?=
 =?utf-8?B?VllIUDVtdFZLc1lkYlBtZ0lyTkFSVWFSYXRGYVVtTDRZRm5JUFNZWjRKK3Nw?=
 =?utf-8?B?N0xOcTJmbTZDT2lqQTJDWUVQMFBlRlFSVHlPS1k0SDRRYUpJb2swOUxKU3Q1?=
 =?utf-8?B?bE1PZm9QZDBERVZxOWdBNUoyY29XSDNpb2k2NVBWQytoZTZKRTBEbFJlTHB1?=
 =?utf-8?B?SnJaU2xaVXUrcXJEYVNTdWNRbDVVUjNyRDBrU2laK2JnaXVTbEJ4QW9YSnhp?=
 =?utf-8?B?OFgyN0xuUXZQTTNOSXJkMkRubjFSRVlGUTVLZmN2RFo3a0hyYkw2YVBuMVpy?=
 =?utf-8?B?dzNIZFlQRHVwKzdXdnlMeUN1TU5RRHJNcWFZN05BaDJsc0dGOGpaYkx3VHND?=
 =?utf-8?B?ZlNaNHU5M2tTcWJzVEIvTG91cW9rc1cwM2U3Q05aMjNEbFJEWkNkL203MHFT?=
 =?utf-8?B?bDJ4UEQwa1V5amdsR2JUMHlSb1NqODF6bElnZWRjc0N1Yk5qZHFyaEJUVWFu?=
 =?utf-8?B?RG82OExDNzdNdGRwZDM5U1VuNUVaeEkveHZ6ck01bWFNNkJWMzZ5RlpCZldP?=
 =?utf-8?B?Z2R5NnhNWTZRemYxdTNBbWhqWlFjT2x2dmVqOUpESGY5YlM1Vm5EUDhVUlhG?=
 =?utf-8?B?OW5GVmtxdTJmbUhSTjBUVFlJMW4zUXkyWFJTM2Z1V3ZVVHlnZjVPNkpEbW0w?=
 =?utf-8?B?Vmh6NTRNbktOa2hYVnBBeTFhYWc3NWZOVTBRemdnU2NWTmR4c2xiOS9vZVFx?=
 =?utf-8?B?VERnaEd1ZWViNmJaMXNRcGYxNXRxRC9CdjY2YitaWVIvV0xPN3ZESVBjTXV3?=
 =?utf-8?B?MldRNXF5K1RhTmNLSWk5dHBZS1JRaEdpdGtJU2srRkpQR3pFZ2lMaElxaEZK?=
 =?utf-8?B?N05xMHhTWGNsdUxQSFM5RVozb0MyR0dsdGNVbGVhOGhqK1F4bnBibkt6TXk0?=
 =?utf-8?B?U3Y4QjN5MUdyU2p5QXdXWWxWSFFGWGRaUkpycFhnMVBvcjYxMVZOeEFWNlFF?=
 =?utf-8?B?S0w3WWdnaFFMOXh4NlBtb1U4YVFta1E1K1RkNGhmQ3lmekE0cTVpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9d74b6-8733-4402-3233-08de5465efbb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 18:43:12.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75Jfc4veNtI1+tQlpAQ/uJ4Z8oOXClmAkAGkskySIg8NUSjdpGc2FdgVSsmO+qGeDF33XWrneGwMd+9XcGbc8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122

Hi Gregory,


I was concerned with how this could affect Type2 but I think there is no 
issue at all, but I prefer to ask specifically about it.


Type2 can obtain an auto region if BIOS enabled/configured the HDMs, or 
it can create one on purpose if not. Type2 patchset does not allow to 
create a dax region when region probing and it will be the same type2 
check precluding call to enabling the sysram controller.


However, I can see the region will have default sysfs files for setting 
the controller. I think even with such a change there is no way for 
enabling the controller from the type2 region probing, so I guess it is 
safe, but I would prefer to not allow a Type2 region setting a 
controller at all.


I like the approach for solving the problem pointed out, and I think 
something similar or a controller extension for type2 could be needed in 
the future, but maybe adding more flexibility for theoretical per type2 
driver memory-handling uniqueness.


Thank you!


On 1/12/26 16:35, Gregory Price wrote:
> The CXL driver currently hands policy management over to the DAX
> subsystem for sysram regions.  This makes building policy around
> entire regions clunky and at times difficult - for example, requiring
> multiple actions to reliably offline and hot-unplug memory.
>
> This series introduces a memory controller abstraction for CXL regions
> and adds a "sysram" controller that directly hotplugs memory without
> needing to route through DAX.  This simplifies the sysram use case
> considerably.
>
> This also prepares for future use cases which may require different
> memory controller logic (such as private numa nodes).
>
> We organize the controllers into core/memctrl/*_region.c files.
>
> The series is organized as follows:
>
> Patch 1 introduces the cxl_memctrl_mode enum and region->memctrl field,
> allowing regions to be switched between different memory controllers.
> The supported modes are NONE, AUTO, and DAX initially.  Auto-created
> regions default to AUTO, while manually created regions default to NONE
> (requiring explicit controller selection).
>
> Patch 2 adds the sysram_region memory controller, which provides direct
> memory hotplug without DAX intermediation.  New sysfs controls are
> exposed under region/memctrl/:
>    - hotplug:   trigger memory hotplug
>    - hotunplug: offline and hotunplug memory
>    - state:     online/online_normal/offline
>
> Patch 3 refactors existing pmem memctrl logic out of region.c into the
> new memctrl/pmem_region.c, simplifying controller selection in region
> probe.
>
> Patch 4 adds CONFIG_CXL_REGION_CTRL_AUTO_* options, allowing users to
> configure auto-regions to default to SYSRAM instead of DAX for existing
> simple system configurations (i.e. local memory expansion only).
>
> Patch 5 adds CONFIG_CXL_REGION_SYSRAM_DEFAULT_* options to control the
> default state of sysram blocks (OFFLINE, ONLINE/ZONE_MOVABLE, or
> ONLINE_NORMAL/ZONE_NORMAL).  This provides an alternative to the global
> MHP auto-online setting which may cause issues with other devices.
>
> Online defaults to ZONE_MOVABLE to defend hot-unplug by default.
> This is the opposite of memory blocks "online" and "online_movable".
>
> Patch 6 adds a memory_notify callback that prevents memory blocks from
> being onlined into ZONE_NORMAL when the controller state is set to
> ZONE_MOVABLE.  This protects against administrators accidentally
> breaking hot-unpluggability by writing "offline" then "online" to the
> memory block sysfs.
>
> Gregory Price (6):
>    drivers/cxl: add cxl_memctrl_mode and region->memctrl
>    cxl: add sysram_region memory controller
>    cxl/core/region: move pmem memctrl logic into memctrl/pmem_region
>    cxl: add CONFIG_CXL_REGION_CTRL_AUTO_* build config options
>    cxl: add CXL_REGION_SYSRAM_DEFAULT_* build options
>    cxl/sysram: disallow onlining in ZONE_NORMAL if state is movable only
>
>   drivers/cxl/Kconfig                      |  72 ++++
>   drivers/cxl/core/Makefile                |   1 +
>   drivers/cxl/core/core.h                  |   5 +
>   drivers/cxl/core/memctrl/Makefile        |   6 +
>   drivers/cxl/core/memctrl/dax_region.c    |  79 ++++
>   drivers/cxl/core/memctrl/memctrl.c       |  48 +++
>   drivers/cxl/core/memctrl/pmem_region.c   | 191 +++++++++
>   drivers/cxl/core/memctrl/sysram_region.c | 520 +++++++++++++++++++++++
>   drivers/cxl/core/region.c                | 358 ++++------------
>   drivers/cxl/cxl.h                        |  18 +
>   10 files changed, 1013 insertions(+), 285 deletions(-)
>   create mode 100644 drivers/cxl/core/memctrl/Makefile
>   create mode 100644 drivers/cxl/core/memctrl/dax_region.c
>   create mode 100644 drivers/cxl/core/memctrl/memctrl.c
>   create mode 100644 drivers/cxl/core/memctrl/pmem_region.c
>   create mode 100644 drivers/cxl/core/memctrl/sysram_region.c
>
