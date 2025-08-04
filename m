Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F431C5F09
	for <linux-cxl@vger.kernel.org>; Mon,  4 Aug 2025 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754336822; cv=fail; b=szFXIMKMR4/n/3h3xRjdO4CduiibGXxpEKvhrYbBADeSSxJkh9XGj/Li2Fi7OvbvAa4uut1SqG5DEyCbkZ9gjK7f5P8/kAxjJcl52ICWTBu3sXy//e63nOch5fXOL0Ogg859MJJ5eIroWYBhhlgKheLWonFmVr6/D+3q8NZYdRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754336822; c=relaxed/simple;
	bh=F77DEKJR3PFBQKlc+Dw58v1xxdr3vPGalvHlbiJE2Ik=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iyY3mBuA73AlxOmLC0KIbCOZVlOY+3VoFm8hR7crm3UWYkgQLp7ABzejhIHRrOQAtaYw0Oi1XY+FNuc5jYmiFDH9G98jd4E906f/yPpj/YdARgZqX6rB/h9BmdUmd+B+BoZ6CA0H3R+ZycR6+wDxPRzgnt8skJuExa7+nUec9QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ohSBJYmJ; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ohSBJYmJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQhHsn8YnLS9e9bZ1hxSiC3vPD3Z5Ou2qn0E3aFO0K4gmlRYN1OKr3myo+BlRt/xZXKhS+BeiOTqgNiwpBZO/8Bs0Zi2dW4my3D/TpChvR1X0zXaUewXZfOLNYfjgfgVURCGr90y1MisaxWEbZOdM1eIK45LqLV5M+tVN1/Hl3UPF8Z85hhOk29VLUOCORMjr6xpKphUDr7M2gKJ1e40PQt7DaIdBXwvLRvWIkribu96vTkND+KgwXZLRiES6gPTWQLhGg9ulPL2l1BCo4TTx3qUM0rn38ExFnTU8CnkWKfG0sYDiSKWxnTaDc7HFDOI9r4bOanJ8g377PjOuIZXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7zkTgc5E1UpGrtMKQGjEzAqpyoSziGpyZkpwYYliM8=;
 b=CGBoPv2ZC8Mhp4iThVE5vNTF98AvpVsI/csiMVSIXEn7Mvkdr0kyQYJWRc6D/jYqu59+8+aAAgxFiaiYHqhitT1EXoGYO7exMRLkGXonKYiqjllsCoGB8/avbVOAQQ4nSDPsldumt9xalEKNRCTlJE6hdvFIJhJm75w/LYd3EvSGK3VHNWjy85mIJ41BDsErEcjjTZBnh+GqmdqFN+723JCx8scDpehWQTMeKtfb8f/VYlpJ37Y6NYIiNyV1chpdFr5CiOX/icJ7ghS4OsmrsQEquFfU4OMv9TFbLiXaZ9tj1z52Py5vH/xcr5xl/saCRyCoPJ9E2HcMWl8iXnU9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7zkTgc5E1UpGrtMKQGjEzAqpyoSziGpyZkpwYYliM8=;
 b=ohSBJYmJInsYA2TOwWywv9xLkafv6Ag7QTp2C5+J5f2dXDgRarxWgRi2TYoFkeyAyQqc7GJ/Y3mXlTIc7Jsjr5dJGOUiJ9va0fL33hU6HH+NQbGWDWElZTPdWB9BFF3SSZ2ax9OVYJM/gnsVhA894GE2HDFeR20EF9F/wgtM2Ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 19:46:55 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 19:46:54 +0000
Message-ID: <f921b707-f7d9-4b36-9f15-8eea099bde72@amd.com>
Date: Mon, 4 Aug 2025 14:46:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Robert Richter <rrichter@amd.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250730152519.125601-1-dave.jiang@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250730152519.125601-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:806:d3::6) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 87648c17-47f0-4a96-5561-08ddd38fa9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djdHZkloMTA0YnljZFFwZSt4QzIrK0dnUm16QkViOG0zZkpmNlpobXAvU3lH?=
 =?utf-8?B?cExuanpxeURyN0dONmREczd2cTBFcWFQZU8xSC9NTXZLa2ZKYjBDUFhHRktu?=
 =?utf-8?B?K3FrTnpDc0NMY09Md2ZOREt4OHFTVjROdHZCQ2w5REViRVRKU2NXWE1xRFIv?=
 =?utf-8?B?elkzWVhyclpPdStLMStLMTg0K0V6QjF3a1hPZ0pmcFRuU2xwZzJaS3FPUVJj?=
 =?utf-8?B?cXlkWUhYSnNZU3BEbzFWQUhmYnZDdDZDdHBGU2gzTFk4UzF0YkNZWjg2aTVI?=
 =?utf-8?B?cTh0cVkrQS9uaW1nOWJQYmk3MmZiWnhWWG9Dai9GSkRqZEFrUmVqcFlRZ29n?=
 =?utf-8?B?eTJQbFV2SFJDT3VYS2UyVzc3TEZzcitSdzVIK1VSVEY2dml1c01nSTVjSUhE?=
 =?utf-8?B?YWdua1NmSnNUckdQOUFFd1BwK0RrYUdrdTVUSzYrRFdmNDljQU8rdVVhekEx?=
 =?utf-8?B?YnYyZzRWZFNjTzFTallQL21peVo1c0NkR0tmd09kUWg0eDNUMlBEeHRCOFBx?=
 =?utf-8?B?RHhodFpHZDcrU3BxZEp4RVZuUHRMUXV3cWFJVzQ4Tkt4QmRjd0tIRGF1Z0NT?=
 =?utf-8?B?MFFUSDhXaE1BRU9mWFBOTnpTaWVDVEZJKytoOWhzOUZHMWRpNHdBTDhKMzgy?=
 =?utf-8?B?dW5XY2xEYlNhL056aE0wRENTWTI3bjV1OXJocGkrTHVTK1BmYWRlSGJZVWNa?=
 =?utf-8?B?QWJJa25UVE5yZGJXUGZMVCtLMC83UGJyY0tKMWJYdkhzY05qbW9LTEhPNlc0?=
 =?utf-8?B?MTNVSlhGOWp0QjREMkErNy9XQWRGMk5BTmNTcUdvRmVEbERYQkNCQk1EdS9I?=
 =?utf-8?B?K1dkUEt4NndUd2c3aHlITEhEMGJhNVEzaHRTVFBXYWZCK3Vtejg4UHJScTJt?=
 =?utf-8?B?ZHlqVTQvSkVhVjYwZXkrL1VvSGdBOFZ2dEl3WnhrSVhCUVZoLzd3aEFmVXI0?=
 =?utf-8?B?enJzUDNEdGhEdHdyZE9neDRhR21oZk0wYmdIb3FLeGtzalZ6NjhhWGhTYlVT?=
 =?utf-8?B?ZHhzazN2NmpqQ3lMMmtvdm16V0puc213MGhBTWd0V1AwL2liY1lRZXd4TzVh?=
 =?utf-8?B?YVRaVnUvcXlnZnhleGZEbW9Wd0orMXFzTHhpRnZVYktWUTVOeFFPTXZLdzRL?=
 =?utf-8?B?SVRLK2l2ZlRmMEVhRVVIeEtKeXdRdUlieWVhNFltdmREMlp1S0JmcmpNeHNt?=
 =?utf-8?B?MFdkNlVRaWtudHlhS3phTGtBeVlKakVTdWxnRU80L2poSGMwbXFRcmVJaTYw?=
 =?utf-8?B?MEtMNXF2MGtBbld0VDRCT2VucVYrYng3bVJ0ak1TaVNHbktsbUNyOEFVOHZS?=
 =?utf-8?B?ei9QZTk0anNnWDJsS2hsSkRKWC8vbW4vWGU4Z2JqTjM0ZFZLNFZKS0psNDFC?=
 =?utf-8?B?RjdpUWtaMlluRHB1czhoYjY2ZDJrVUpkUjNqRzl2RkNQTlNzTXVsK2NDMVpL?=
 =?utf-8?B?ODJYV0xCamlVYzA5VDBoR3RISkx0cmxTRzJKRGJDL1dwL1dTejNpbGd2VDZU?=
 =?utf-8?B?SDJxdXpiYXEyYTRCc1VTZm1kRWN2WXRaenE5eldQMG1oTC93SDNyelN1dng4?=
 =?utf-8?B?bnhyZyswT0xmYzFsR0hKZ1VRbyt2S0R6cHMwRGppYStoS1ZaME5Ec1RCQ1J3?=
 =?utf-8?B?aFJ1b0NhRHRkZktZeUNFbElXNGVNV0o5T1U2bTQvYmFMTHlaSytkTHo4WjQz?=
 =?utf-8?B?eGVNaWZteGdvUnl1ZzdqY09lVmFLTEJ2V3ovYVhwSG0wNXQybE9LQzdZUHkx?=
 =?utf-8?B?ZkZLME0rV2lRTnNwYmg5S0t2WmhwRmFyaVlxQllmdWd3YkVGSTZRVVlEQUxu?=
 =?utf-8?B?MkJ2eDVNQ1BnOGVaclNqQ3l1bXpFVThNNncxZ1FkRWNjdFJLa1p3SUl0L3J1?=
 =?utf-8?B?T2hYbXU5U2g3SEE3WWY1ZnVUTVZMOVdSVWgyZllDdWNGQ0EwMXR2U1g4d0Mz?=
 =?utf-8?Q?kp+dwactWzc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkpGblp6MmdmUnRmM3BkZ1BQM1prcmxxNFhsaWU0U2RXLzlWUlBSS0szbHdL?=
 =?utf-8?B?SG11T0dHOG9UYTUwRXMyVzMvd1NrSWtONzhiOFhwazgwODNWVlhSY1Qra0lj?=
 =?utf-8?B?VGdMVVpteHlsK2Q2NjRuSHhMbk1RNHhmYTl4S3ZBdHFhcm8zY0ovbEhEVG1M?=
 =?utf-8?B?UTVZTHgrUGlwWWExdHgxS2VseHBjYUR1QjFYR3ErbzVXc2VtWUVCWFNnWERq?=
 =?utf-8?B?S1RKQzV3MEZUMlJBMjNqQUpDSDB4MlB3UWQrVmlMSkd6VXdtcWdvL0tlcVlN?=
 =?utf-8?B?ZUl3R2Y3UjBKNzZzSVIrRndVT2RVaURMSTduQmdMUjZSTEVaZUZyV2U3V09B?=
 =?utf-8?B?WlhFZWZOQ292ZTdORU9aVUxMV25HbnZuU1ozUXppbXFWNE5tTEpXd2ZHeHEw?=
 =?utf-8?B?aGFxb2NLcE5nbkhjV2VyZEJsRVJWY3RqR2lBNFZ3R0hJYUlmVE5vNEtJMktK?=
 =?utf-8?B?UUxaeU9melA5NG5kdGYwY2dFSURYeHFEZG5RM1Z4ZzNwTW1Sa1ZBQnNVSzFO?=
 =?utf-8?B?Z2tuckFhTk92ZjNMMUtwZXZYMUdvSWRPeWJ6bncwUzhsOXlDRG9CMUVyZXRh?=
 =?utf-8?B?VzdXcG5CNllnNHJ3c3I2d2srbGFmbWlodWwrNnNRL2Y2SnNmbW90VVk1SUR6?=
 =?utf-8?B?aVNHdXBlUUR0eVp1OW1OKzgyR3ltYTBKV2VHUFlmRjNjZFRsWGJIbUwybTF1?=
 =?utf-8?B?cXR3b3dHYXdLMzE0WEdBREg5L25BMElxaytmemRDWkZweXJ3OGJNNUF0R08w?=
 =?utf-8?B?aEhvTHFXeVpPVTlqWVZVNUhjbDltT3ZYaEl1dHZLRVRodW1QdlY2WEhxWFZl?=
 =?utf-8?B?WmVaT2lzaElYOGFqeUcwdFVmdVpGZG5RcUlNQmZVVEoxNFRpVDNITjh1MU04?=
 =?utf-8?B?Zm8yZlBTcnJRYmtQZE9HdmRMY3RvWjRETFY2SEloM0d3OUZXUXhsdDA5a1k0?=
 =?utf-8?B?em52cHE0MFdOcU9LM3RESVh1WTZ4ZmZJYlRDWkRHTFUxOE9vVWE2ekxMdUtG?=
 =?utf-8?B?MUREZUJ4blVlNUpUeldtOHJtVHFHVDlTRzdMOUk2Sms0ZWNodnU3RmxwTVRD?=
 =?utf-8?B?NVJXOEh2cUJVM3g4T01Gai9iZXBGV1F0bnlXTXB1RURINkJGQk1mN0hEa2hI?=
 =?utf-8?B?aFpYd0k5VnlaYWU0U05PdXR4L1FWU3J1S3NwNS9UK2toUGlBM3N3ZGJlUUhN?=
 =?utf-8?B?SmZXTjE4Rk5HU2NxazR3dnRpT3RQd3JVZjdCTjRiSFJoY0doTjJBSHg3WUVS?=
 =?utf-8?B?TlB4b0JlTWRIMVczeE9ZL3VtSktKaTFndGJoZHVzbng1a2FzUVdkclFvQksv?=
 =?utf-8?B?VTlTMUZZKy9yTEVKdlRBUzlTb21zY0Nadnd6NkJZQWZ3Umx4L01ncVhFZ3NO?=
 =?utf-8?B?eHdZL3VoZ1hFcUo3UE92T3JPeDdyVWhIYmhQelJiNGcrcFpXakJEUGtoaEdu?=
 =?utf-8?B?b3JMQS96TU5rUTB1ZmlETEhxbW5aTEJzNDdCZnljVkd2OVNjWUdvZzk1MURl?=
 =?utf-8?B?dDBvak5zcmN1M0xZK1ZaelVpT0lNOUZ6MkswME5SeHg3Q1dPMmlJRGp3eUdU?=
 =?utf-8?B?TlRGT1V5ZndXaDl4L0VlYmJ2dHpNMndmU01DT3RLM1VoSEdqVlRpTi82eG9v?=
 =?utf-8?B?d3Z5N29wV1hUU2M1NjU0OVBLN0ZVSzJLVkcxVWIyQytSem05dHdxdGJiQk15?=
 =?utf-8?B?bEZvc3BoV1lyZFBxWUNZSkFNaDZabEl5N2ZoQXVaWHg3THNieDlPWHdCM3ZY?=
 =?utf-8?B?YjFJSERML0J4aTJVWlBjdi82WXppZFFhUDN1V1JkYTdFTFF3ZUM0dkdkbjdK?=
 =?utf-8?B?d2EraXdEMm1BVnd1eGN1ZDI4R2RYcFRHeVhPZFh3WnY3d2kxaFlVaEF6MmdX?=
 =?utf-8?B?Y1BHbFdjYmpJNlBGT2ZKU2d0d1V6eURVVXRLVGY2V242Z1l0Y1g0VDJjYytM?=
 =?utf-8?B?Q2ZtN2JHRTZpcjhZREhnSnJ1RllsNmRNaG9ReVN1VnlZTERWcksyV2Yyd0VE?=
 =?utf-8?B?eVF4ckxYeDl6NDgvVkVnT1BwcnY0QkM1eEdqbVFqNVhLTjJNOGQ0V3dCK2sv?=
 =?utf-8?B?ZXpWSGxZTDlGWmdlVURGQlVHaDN2aU12c25qejR4QmFRVlpLcEd2V1NaeUlN?=
 =?utf-8?Q?Qm5Ksyt55hlWx0NQiPiBiwtiK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87648c17-47f0-4a96-5561-08ddd38fa9d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 19:46:54.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMq3+fLDbWVeAYn39zGAZlEtcVofI/yI/53LtIKvd6oIOw7nFleATkEhxUukzJZmy0vlCQ4WQ/6o4lJeTSiZmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986

On 7/30/2025 10:25 AM, Dave Jiang wrote:
> Create new config CONFIG_CXL_RAS and put all CXL RAS items behind
> the config. The config will depend on CPER or PCIE AER to build.
> Move the related RAS code from core/pci.c to core/ras.c.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v5:
> - Make cxl_handle_rdport_errors() static. (Dan)
> ---
>  drivers/cxl/Kconfig       |   4 +
>  drivers/cxl/core/Makefile |   2 +-
>  drivers/cxl/core/pci.c    | 319 --------------------------------------
>  drivers/cxl/core/ras.c    | 312 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   8 -
>  drivers/cxl/cxlpci.h      |  16 ++
>  tools/testing/cxl/Kbuild  |   1 +
>  7 files changed, 334 insertions(+), 328 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..b36bb0cabe58 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -233,4 +233,8 @@ config CXL_MCE
>  	def_bool y
>  	depends on X86_MCE && MEMORY_FAILURE
>  
> +config CXL_RAS
> +	def_bool y
> +	depends on ACPI_APEI_GHES || PCIEAER_CXL
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79e2ef81fde8..1c652e575aaa 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -14,10 +14,10 @@ cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
> -cxl_core-y += ras.o
>  cxl_core-y += acpi.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> +cxl_core-$(CONFIG_CXL_RAS) += ras.o


Hi Dave,

By moving ras.c into conditional compilation under CONFIG_CXL_RAS the 
cxl_ras_init() and cxl_ras_exit() will need conditional definition stubs. 
I dont see them here but I may have missed.

-Terry 


> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b50551601c2e..a3aef78f903a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -6,7 +6,6 @@
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> -#include <linux/aer.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -664,324 +663,6 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> -				 void __iomem *ras_base)
> -{
> -	void __iomem *addr;
> -	u32 status;
> -
> -	if (!ras_base)
> -		return;
> -
> -	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> -	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> -	}
> -}
> -
> -static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> -{
> -	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
> -}
> -
> -/* CXL spec rev3.0 8.2.4.16.1 */
> -static void header_log_copy(void __iomem *ras_base, u32 *log)
> -{
> -	void __iomem *addr;
> -	u32 *log_addr;
> -	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
> -
> -	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
> -	log_addr = log;
> -
> -	for (i = 0; i < log_u32_size; i++) {
> -		*log_addr = readl(addr);
> -		log_addr++;
> -		addr += sizeof(u32);
> -	}
> -}
> -
> -/*
> - * Log the state of the RAS status registers and prepare them to log the
> - * next error status. Return 1 if reset needed.
> - */
> -static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
> -				  void __iomem *ras_base)
> -{
> -	u32 hl[CXL_HEADERLOG_SIZE_U32];
> -	void __iomem *addr;
> -	u32 status;
> -	u32 fe;
> -
> -	if (!ras_base)
> -		return false;
> -
> -	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
> -	status = readl(addr);
> -	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> -		return false;
> -
> -	/* If multiple errors, log header points to first error from ctrl reg */
> -	if (hweight32(status) > 1) {
> -		void __iomem *rcc_addr =
> -			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
> -
> -		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> -				   readl(rcc_addr)));
> -	} else {
> -		fe = status;
> -	}
> -
> -	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
> -	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
> -
> -	return true;
> -}
> -
> -static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
> -{
> -	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
> -}
> -
> -#ifdef CONFIG_PCIEAER_CXL
> -
> -static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> -{
> -	resource_size_t aer_phys;
> -	struct device *host;
> -	u16 aer_cap;
> -
> -	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
> -	if (aer_cap) {
> -		host = dport->reg_map.host;
> -		aer_phys = aer_cap + dport->rcrb.base;
> -		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
> -						sizeof(struct aer_capability_regs));
> -	}
> -}
> -
> -static void cxl_dport_map_ras(struct cxl_dport *dport)
> -{
> -	struct cxl_register_map *map = &dport->reg_map;
> -	struct device *dev = dport->dport_dev;
> -
> -	if (!map->component_map.ras.valid)
> -		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> -		dev_dbg(dev, "Failed to map RAS capability.\n");
> -}
> -
> -static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> -{
> -	void __iomem *aer_base = dport->regs.dport_aer;
> -	u32 aer_cmd_mask, aer_cmd;
> -
> -	if (!aer_base)
> -		return;
> -
> -	/*
> -	 * Disable RCH root port command interrupts.
> -	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> -	 *
> -	 * This sequence may not be necessary. CXL spec states disabling
> -	 * the root cmd register's interrupts is required. But, PCI spec
> -	 * shows these are disabled by default on reset.
> -	 */
> -	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> -			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> -			PCI_ERR_ROOT_CMD_FATAL_EN);
> -	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> -	aer_cmd &= ~aer_cmd_mask;
> -	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> -}
> -
> -/**
> - * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
> - * @dport: the cxl_dport that needs to be initialized
> - * @host: host device for devm operations
> - */
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> -{
> -	dport->reg_map.host = host;
> -	cxl_dport_map_ras(dport);
> -
> -	if (dport->rch) {
> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> -
> -		if (!host_bridge->native_aer)
> -			return;
> -
> -		cxl_dport_map_rch_aer(dport);
> -		cxl_disable_rch_root_ints(dport);
> -	}
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
> -
> -static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
> -					  struct cxl_dport *dport)
> -{
> -	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
> -}
> -
> -static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
> -				       struct cxl_dport *dport)
> -{
> -	return __cxl_handle_ras(cxlds, dport->regs.ras);
> -}
> -
> -/*
> - * Copy the AER capability registers using 32 bit read accesses.
> - * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> - * status after copying.
> - *
> - * @aer_base: base address of AER capability block in RCRB
> - * @aer_regs: destination for copying AER capability
> - */
> -static bool cxl_rch_get_aer_info(void __iomem *aer_base,
> -				 struct aer_capability_regs *aer_regs)
> -{
> -	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
> -	u32 *aer_regs_buf = (u32 *)aer_regs;
> -	int n;
> -
> -	if (!aer_base)
> -		return false;
> -
> -	/* Use readl() to guarantee 32-bit accesses */
> -	for (n = 0; n < read_cnt; n++)
> -		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> -
> -	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> -	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> -
> -	return true;
> -}
> -
> -/* Get AER severity. Return false if there is no error. */
> -static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> -				     int *severity)
> -{
> -	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> -			*severity = AER_FATAL;
> -		else
> -			*severity = AER_NONFATAL;
> -		return true;
> -	}
> -
> -	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
> -		*severity = AER_CORRECTABLE;
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> -{
> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> -	struct aer_capability_regs aer_regs;
> -	struct cxl_dport *dport;
> -	int severity;
> -
> -	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return;
> -
> -	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
> -		return;
> -
> -	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> -		return;
> -
> -	pci_print_aer(pdev, severity, &aer_regs);
> -
> -	if (severity == AER_CORRECTABLE)
> -		cxl_handle_rdport_cor_ras(cxlds, dport);
> -	else
> -		cxl_handle_rdport_ras(cxlds, dport);
> -}
> -
> -#else
> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
> -#endif
> -
> -void cxl_cor_error_detected(struct pci_dev *pdev)
> -{
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct device *dev = &cxlds->cxlmd->dev;
> -
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return;
> -		}
> -
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -
> -		cxl_handle_endpoint_cor_ras(cxlds);
> -	}
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> -
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> -{
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> -
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return PCI_ERS_RESULT_DISCONNECT;
> -		}
> -
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> -		 */
> -		ue = cxl_handle_endpoint_ras(cxlds);
> -	}
> -
> -
> -	switch (state) {
> -	case pci_channel_io_normal:
> -		if (ue) {
> -			device_release_driver(dev);
> -			return PCI_ERS_RESULT_NEED_RESET;
> -		}
> -		return PCI_ERS_RESULT_CAN_RECOVER;
> -	case pci_channel_io_frozen:
> -		dev_warn(&pdev->dev,
> -			 "%s: frozen state error detected, disable CXL.mem\n",
> -			 dev_name(dev));
> -		device_release_driver(dev);
> -		return PCI_ERS_RESULT_NEED_RESET;
> -	case pci_channel_io_perm_failure:
> -		dev_warn(&pdev->dev,
> -			 "failure state error detected, request disconnect\n");
> -		return PCI_ERS_RESULT_DISCONNECT;
> -	}
> -	return PCI_ERS_RESULT_NEED_RESET;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> -
>  static int cxl_flit_size(struct pci_dev *pdev)
>  {
>  	if (cxl_pci_flit_256(pdev))
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c7..2e203a07786d 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -4,7 +4,9 @@
>  #include <linux/pci.h>
>  #include <linux/aer.h>
>  #include <cxl/event.h>
> +#include <cxlpci.h>
>  #include <cxlmem.h>
> +#include <cxl.h>
>  #include "trace.h"
>  
>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> @@ -117,3 +119,313 @@ void cxl_ras_exit(void)
>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>  	cancel_work_sync(&cxl_cper_prot_err_work);
>  }
> +
> +static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> +{
> +	resource_size_t aer_phys;
> +	struct device *host;
> +	u16 aer_cap;
> +
> +	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
> +	if (aer_cap) {
> +		host = dport->reg_map.host;
> +		aer_phys = aer_cap + dport->rcrb.base;
> +		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
> +						sizeof(struct aer_capability_regs));
> +	}
> +}
> +
> +static void cxl_dport_map_ras(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	if (!map->component_map.ras.valid)
> +		dev_dbg(dev, "RAS registers not found\n");
> +	else if (cxl_map_component_regs(map, &dport->regs.component,
> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(dev, "Failed to map RAS capability.\n");
> +}
> +
> +static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> +{
> +	void __iomem *aer_base = dport->regs.dport_aer;
> +	u32 aer_cmd_mask, aer_cmd;
> +
> +	if (!aer_base)
> +		return;
> +
> +	/*
> +	 * Disable RCH root port command interrupts.
> +	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> +	 *
> +	 * This sequence may not be necessary. CXL spec states disabling
> +	 * the root cmd register's interrupts is required. But, PCI spec
> +	 * shows these are disabled by default on reset.
> +	 */
> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> +			PCI_ERR_ROOT_CMD_FATAL_EN);
> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> +	aer_cmd &= ~aer_cmd_mask;
> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> +}
> +
> +/**
> + * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
> + * @dport: the cxl_dport that needs to be initialized
> + * @host: host device for devm operations
> + */
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> +{
> +	dport->reg_map.host = host;
> +	cxl_dport_map_ras(dport);
> +
> +	if (dport->rch) {
> +		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> +
> +		if (!host_bridge->native_aer)
> +			return;
> +
> +		cxl_dport_map_rch_aer(dport);
> +		cxl_disable_rch_root_ints(dport);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
> +
> +static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
> +{
> +	void __iomem *addr;
> +	u32 status;
> +
> +	if (!ras_base)
> +		return;
> +
> +	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> +	status = readl(addr);
> +	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> +		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +	}
> +}
> +
> +/* CXL spec rev3.0 8.2.4.16.1 */
> +static void header_log_copy(void __iomem *ras_base, u32 *log)
> +{
> +	void __iomem *addr;
> +	u32 *log_addr;
> +	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
> +
> +	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
> +	log_addr = log;
> +
> +	for (i = 0; i < log_u32_size; i++) {
> +		*log_addr = readl(addr);
> +		log_addr++;
> +		addr += sizeof(u32);
> +	}
> +}
> +
> +static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
> +					  struct cxl_dport *dport)
> +{
> +	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
> +}
> +
> +/*
> + * Log the state of the RAS status registers and prepare them to log the
> + * next error status. Return 1 if reset needed.
> + */
> +static bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
> +{
> +	u32 hl[CXL_HEADERLOG_SIZE_U32];
> +	void __iomem *addr;
> +	u32 status;
> +	u32 fe;
> +
> +	if (!ras_base)
> +		return false;
> +
> +	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
> +	status = readl(addr);
> +	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> +		return false;
> +
> +	/* If multiple errors, log header points to first error from ctrl reg */
> +	if (hweight32(status) > 1) {
> +		void __iomem *rcc_addr =
> +			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
> +
> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> +				   readl(rcc_addr)));
> +	} else {
> +		fe = status;
> +	}
> +
> +	header_log_copy(ras_base, hl);
> +	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
> +	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
> +
> +	return true;
> +}
> +
> +static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
> +				       struct cxl_dport *dport)
> +{
> +	return __cxl_handle_ras(cxlds, dport->regs.ras);
> +}
> +
> +/*
> + * Copy the AER capability registers using 32 bit read accesses.
> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> + * status after copying.
> + *
> + * @aer_base: base address of AER capability block in RCRB
> + * @aer_regs: destination for copying AER capability
> + */
> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
> +				 struct aer_capability_regs *aer_regs)
> +{
> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
> +	u32 *aer_regs_buf = (u32 *)aer_regs;
> +	int n;
> +
> +	if (!aer_base)
> +		return false;
> +
> +	/* Use readl() to guarantee 32-bit accesses */
> +	for (n = 0; n < read_cnt; n++)
> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> +
> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> +
> +	return true;
> +}
> +
> +/* Get AER severity. Return false if there is no error. */
> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> +				     int *severity)
> +{
> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +			*severity = AER_FATAL;
> +		else
> +			*severity = AER_NONFATAL;
> +		return true;
> +	}
> +
> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
> +		*severity = AER_CORRECTABLE;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct aer_capability_regs aer_regs;
> +	struct cxl_dport *dport;
> +	int severity;
> +
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return;
> +
> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
> +		return;
> +
> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> +		return;
> +
> +	pci_print_aer(pdev, severity, &aer_regs);
> +
> +	if (severity == AER_CORRECTABLE)
> +		cxl_handle_rdport_cor_ras(cxlds, dport);
> +	else
> +		cxl_handle_rdport_ras(cxlds, dport);
> +}
> +
> +static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
> +}
> +
> +static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
> +}
> +
> +void cxl_cor_error_detected(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct device *dev = &cxlds->cxlmd->dev;
> +
> +	scoped_guard(device, dev) {
> +		if (!dev->driver) {
> +			dev_warn(&pdev->dev,
> +				 "%s: memdev disabled, abort error handling\n",
> +				 dev_name(dev));
> +			return;
> +		}
> +
> +		if (cxlds->rcd)
> +			cxl_handle_rdport_errors(cxlds);
> +
> +		cxl_handle_endpoint_cor_ras(cxlds);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> +
> +pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> +				    pci_channel_state_t state)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *dev = &cxlmd->dev;
> +	bool ue;
> +
> +	scoped_guard(device, dev) {
> +		if (!dev->driver) {
> +			dev_warn(&pdev->dev,
> +				 "%s: memdev disabled, abort error handling\n",
> +				 dev_name(dev));
> +			return PCI_ERS_RESULT_DISCONNECT;
> +		}
> +
> +		if (cxlds->rcd)
> +			cxl_handle_rdport_errors(cxlds);
> +		/*
> +		 * A frozen channel indicates an impending reset which is fatal to
> +		 * CXL.mem operation, and will likely crash the system. On the off
> +		 * chance the situation is recoverable dump the status of the RAS
> +		 * capability registers and bounce the active state of the memdev.
> +		 */
> +		ue = cxl_handle_endpoint_ras(cxlds);
> +	}
> +
> +
> +	switch (state) {
> +	case pci_channel_io_normal:
> +		if (ue) {
> +			device_release_driver(dev);
> +			return PCI_ERS_RESULT_NEED_RESET;
> +		}
> +		return PCI_ERS_RESULT_CAN_RECOVER;
> +	case pci_channel_io_frozen:
> +		dev_warn(&pdev->dev,
> +			 "%s: frozen state error detected, disable CXL.mem\n",
> +			 dev_name(dev));
> +		device_release_driver(dev);
> +		return PCI_ERS_RESULT_NEED_RESET;
> +	case pci_channel_io_perm_failure:
> +		dev_warn(&pdev->dev,
> +			 "failure state error detected, request disconnect\n");
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f68a9414da26..ddf0ee46b116 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -760,14 +760,6 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  					 struct device *dport_dev, int port_id,
>  					 resource_size_t rcrb);
>  
> -#ifdef CONFIG_PCIEAER_CXL
> -void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> -#else
> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
> -						struct device *host) { }
> -#endif
> -
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..3959fa7e2ead 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -132,7 +132,23 @@ struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  			struct cxl_endpoint_dvsec_info *info);
>  void read_cdat_data(struct cxl_port *port);
> +
> +#ifdef CONFIG_CXL_RAS
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> +#else
> +static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
> +
> +static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> +						  pci_channel_state_t state)
> +{
> +	return PCI_ERS_RESULT_NONE;
> +}
> +
> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
> +						struct device *host) { }
> +#endif
> +
>  #endif /* __CXL_PCI_H__ */
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 31a2d73c963f..4cc8099bbcd2 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -68,6 +68,7 @@ cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
> +cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras.o
>  cxl_core-y += config_check.o
>  cxl_core-y += cxl_core_test.o
>  cxl_core-y += cxl_core_exports.o
> 
> base-commit: 6e130ce1dfd47a1ef953d0be127934760aecb769

